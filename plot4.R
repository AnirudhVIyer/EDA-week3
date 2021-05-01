library("ggplot2")

SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))


# coal Combustion
combustionR <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
coalR <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE) 
combustionSCC <- SCC[combustionR & coalR, SCC]
combustionNEI <- NEI[NEI[,SCC] %in% combustionSCC]

png("plot4.png")

ggplot(combustionNEI,aes(x = factor(year),y = Emissions/10^5)) +
  geom_bar(stat="identity", fill ="#FF9999", width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions due to Coal Combustion Source in US"))

dev.off()
