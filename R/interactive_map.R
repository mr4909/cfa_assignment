
options(tigris_use_cache = TRUE)
sf_use_s2(FALSE)  # Avoids geometry issues in st_intersection

# Load application data
df <- read_csv("D:/code_for_america/exercise_data.csv")
zips <- unique(df$zip) |> as.character()

# Get ACS population and poverty data with geometry
acs_vars <- c(total_pop = "B01001_001", below_poverty = "B17001_002") # check these!
acs_data <- get_acs(
  geography = "zcta",
  variables = acs_vars,
  year = 2021,
  survey = "acs5",
  geometry = TRUE
) |>
  select(GEOID, variable, estimate, geometry) |>
  st_transform(4326)

# Reshape to wide format and calculate poverty rate
acs_wide <- acs_data |>
  st_drop_geometry() |>
  pivot_wider(names_from = variable, values_from = estimate) |>
  rename(total_pop = total_pop, below_poverty = below_poverty) |>
  mutate(poverty_rate = if_else(total_pop > 0, below_poverty / total_pop, NA_real_))

# Merge back with geometry
acs_geom <- acs_data |> distinct(GEOID, geometry)
acs_merged <- left_join(acs_geom, acs_wide, by = "GEOID")

# Filter to ZIP codes in your dataset
acs_filtered <- acs_merged |> filter(GEOID %in% zips) |> 
  mutate(GEOID = as.character(GEOID))

# Join application count
app_count <- df |> count(zip) |> rename(GEOID = zip, count = n)|> 
  mutate(GEOID = as.character(GEOID))
acs_final <- left_join(acs_filtered, app_count, by = "GEOID")

# Define color palettes
pop_pal <- colorBin("YlGnBu", acs_final$total_pop, bins = 5, pretty = TRUE)
poverty_pal <- colorBin("YlOrRd", acs_final$below_poverty, bins = 5, pretty = TRUE)
rate_pal <- colorBin("PuBuGn", acs_final$poverty_rate, bins = 5, pretty = TRUE)
app_pal <- colorBin("Blues", acs_final$count, bins = 5, pretty = TRUE)

# Create interactive map
leaflet_ca <- leaflet(acs_final) |>
  addProviderTiles("CartoDB.Positron") |>
  
  addPolygons(
    fillColor = ~app_pal(count),
    fillOpacity = 0.7,
    color = "white",
    weight = 1,
    group = "Applications",
    label = ~paste0("ZIP: ", GEOID, "<br>Applications: ", count)
  ) |>
  
  addPolygons(
    fillColor = ~pop_pal(total_pop),
    fillOpacity = 0.7,
    color = "white",
    weight = 1,
    group = "Total Population",
    label = ~paste0("ZIP: ", GEOID, "<br>Population: ", total_pop)
  ) |>
  
  addPolygons(
    fillColor = ~poverty_pal(below_poverty),
    fillOpacity = 0.7,
    color = "white",
    weight = 1,
    group = "Below Poverty",
    label = ~paste0("ZIP: ", GEOID, "<br>Below Poverty: ", below_poverty)
  ) |>
  
  addPolygons(
    fillColor = ~rate_pal(poverty_rate),
    fillOpacity = 0.7,
    color = "white",
    weight = 1,
    group = "Poverty Rate (%)",
    label = ~paste0("ZIP: ", GEOID, "<br>Poverty Rate: ", percent(poverty_rate, accuracy = 0.1))
  ) |>
  
  addLayersControl(
    overlayGroups = c("Applications", "Total Population", "Below Poverty", "Poverty Rate (%)"),
    options = layersControlOptions(collapsed = FALSE)
  ) |>
  setView(lng = -117.15, lat = 32.72, zoom = 10) |>   # San Diego region center
  addLayersControl(
    baseGroups = c("Applications", "Total Population",
                   "Below Poverty", "Poverty Rate (%)"),
    options = layersControlOptions(collapsed = FALSE)
  ) 

# Add CSS to set the background color to white
leaflet_ca <- leaflet_ca |> htmlwidgets::onRender("
  function(el, x) {
    document.querySelector('.leaflet-container').style.background = 'white';
  }")

leaflet_ca

# IDEAS

# Application rates by zip code (using population by zip code)
