#read 5 rows of data 
tab5rows <- read.table("./Downloads/household_power_consumption.txt",head=TRUE,sep=":",nrows=5)
# Get data type for each variable, so that R can read this data set faster
classes<-sapply(tab5rows,class)
# Read data into R 
tabAll <- read.table("./Downloads/household_power_consumption.txt", header = TRUE, colClasses = classes,sep=";",na.strings="?")
# Transform data type of "Date" from factor to Date variable 
tabAll2<-transform(tabAll,Date=as.POSIXlt(as.character(Date),format="%d/%m/%Y"))
# Subset data for Dates in 2007-02-01 and 2007-02-02 only
tabAll2.sub <-subset(tabAll2,Date %in% c("2007-02-01","2007-02-02"))
# Create a Vector with the combination of Date and Time in the original dataset
datetime<-as.POSIXct(paste(tabAll2.sub$Date,tabAll2.sub$Time),format="%Y-%m-%d %H:%M:%S")


png("plot4.png",width=480,height=480)
old.par<-par(mfrow=c(2,2))
par(mar=c(4,4,2,2))
plot(tabAll2.sub$Global_active_power~datetime,type="n",xlab="",ylab="Global Active Power(kilowatts")
lines(tabAll2.sub$Global_active_power~datetime,lwd=2)
plot(tabAll2.sub$Voltage~datetime,type="n",xlab="datetime",ylab="Voltage")
lines(tabAll2.sub$Voltage~datetime,lwd=2)
plot(datetime,tabAll2.sub$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(datetime,tabAll2.sub$Sub_metering_2,col="red")
lines(datetime,tabAll2.sub$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lwd=2,cex=0.5)
plot(datetime,tabAll2.sub$Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()