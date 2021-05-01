
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

finalEmmision <- NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]
png(filename='plot2.png')
barplot(finalEmmision[, Emissions]
        , names = finalEmmision[, year]
        , xlab = "Year", ylab = "Emissions"
        , main = "Plot of Emission vs Year in Baltimore")
dev.off()
