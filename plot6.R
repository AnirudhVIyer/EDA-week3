
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# Gather the subset of the NEI data which corresponds to vehicles
condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
VSCC <- SCC[condition, SCC]
VNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Subset the vehicles NEI data by each city's fip and add city name.
VBNEI <- VNEI[fips == "24510",]
VBNEI[, city := c("Baltimore City")]

VLANEI <- VNEI[fips == "06037",]
VLANEI[, city := c("Los Angeles")]

# Combine data.tables into one data.table
mixNEI <- rbind(VBNEI,VLANEI)

png("plot6.png")

ggplot(mixNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA"))

dev.off()
