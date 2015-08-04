#Boilerplate reading of file and subsetting for all plots of the project, ASSUMES DATA IS IN WORKING DIRECTORY

consume <- read.table("household_power_consumption.txt",sep=";",header=TRUE,skip=66636,nrows=2880) 
  #reads in data to consume from only dates of 2/1/2007 through 2/2/2007
cols <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_Intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
colnames(consume) <- cols   #rename header to match intial file
consume$Date_and_Time <- as.POSIXlt(paste(consume$Date, consume$Time), format = "%d/%m/%Y %H:%M:%S")
  #adds new column to data frame listing date and time as POSIXct class

#Plotting and file generation commands:
png(filename="plot2.png") #defaults 480x480 pixel image
plot(consume$Date_and_Time, consume$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.off()

