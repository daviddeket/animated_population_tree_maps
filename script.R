
library(ggplot2)
library(treemapify)
library(dplyr)
library(animation)
library(png)

# Set the working directory to the location of the CSV file
my_path <- file.path("C:","Users", "name","Desktop","R Paper")
setwd(my_path)

# Read the CSV file into a data frame
data <- read.csv("fertility_rates.csv", header = TRUE)

# Print the first few rows of the data frame to verify that the data was read in correctly
head(data)

for (my_year in 1950:2021) {
  # Filter for year x
  df_filtered <- filter(data, year == my_year)
  
  # Generate static tree map
  myplot <- ggplot(df_filtered, aes(area = avg, fill = avg, label = country, subgroup = region)) + geom_treemap(layout = "fixed") + 
    geom_treemap_subgroup_border(layout = "fixed") +
    geom_treemap_subgroup_text(place = "centre", alpha = 0.5, colour =
                                 "black", fontface = "italic", min.size = 0, layout = "fixed") +
    geom_treemap_text(fontface = "italic", colour = "white", place = "centre", layout = "fixed")
  
  # Save as image in folder
  ggsave(paste0("plots/", my_year-1949,".png"), plot = myplot)
}


# Set the working directory to the location of the CSV file
my_path <- file.path("C:","Users", "name","Desktop","R Paper","plots")
setwd(my_path)

# Load the PNG files as a list
png_files <- list.files(pattern = "*.png")

# Animate the PNG files and save the resulting GIF
saveGIF({
  for (file in png_files) {
    plot.new()
    img <- readPNG(file)
    rasterImage(img, 0, 0, 1, 1)
  }
}, movie.name = "myanimation.gif", ani.width = 800, ani.height = 600, ani.type = "cairo")
