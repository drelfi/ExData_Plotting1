read.household.power.consumption <- function( filename = "household_power_consumption.txt") {
  require(dplyr)
  dat <- read.table(filename, header=TRUE, sep=";", na.strings = "?")
 
  dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")  
  dat <- filter( dat, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02') )   

  dat$Time <- strptime( paste(as.character(dat$Date), dat$Time, sep=" "), format="%Y-%m-%d %H:%M:%S")
  
  dat
}

plot2 <- function() {
  with( dat,
    plot(
      Time,
      Global_active_power,
      main="", 
      ylab="Global Active Power (kilowatts)",
      xlab="",
      type="l"
    )
  )
}

dat <- read.household.power.consumption()
png(filename="plot2.png", width=480, height=480)
plot2()
dev.off()

