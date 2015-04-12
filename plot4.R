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
          ylab="Global Active Power",
          xlab="",
          type="l"
        )
  )
}

plot3 <- function() {
  with( dat,
    plot(
      Time,
      Sub_metering_1,
      main="", 
      ylab="Energy sub metering",
      xlab="",
      type="l"
    )
  )
  lines(dat$Time, dat$Sub_metering_2, col="red")
  lines(dat$Time, dat$Sub_metering_3, col="blue")
  legend(
    "topright", 
    c(
      "Sub_metering_1", 
      "Sub_metering_2", 
      "Sub_metering_3"
      ), 
    col=c("black", "red", "blue"), 
    lty=c(1,1,1),
    bty="n"
    )
}

plot4.1 <- function() {
  with( dat,
        plot(
          Time, 
          Voltage,
          xlab="datetime",
          type="l")
        )
}

plot4.2 <- function() {
  with( dat,
        plot(
          Time, 
          Global_reactive_power,
          xlab="datetime",
          type="l")
  )
}

plot4 <- function() {
  par(mfcol = c(2,2))
  plot2()
  plot3()
  plot4.1()
  plot4.2()
}

dat <- read.household.power.consumption()
png(filename="plot4.png", width=480, height=480)
plot4()
dev.off()

