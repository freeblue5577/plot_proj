#read 5 rows of data 
tab5rows <- read.table("./Downloads/household_power_consumption.txt",head=TRUE,sep=":",nrows=5)
# Get data type for each variable, so that R can read this data set faster
classes<-sapply(tab5rows,class)
# Read data into R 
tabAll <- read.table("./Downloads/household_power_consumption.txt", header = TRUE, colClasses = classes,sep=";",na.String="?")
# transform data type of "Date" from factor to Date variable 
tabAll2<-transform(tabAll,Date=as.POSIXlt(as.character(Date),format="%d/%m/%Y"))
# subset data for Dates in 2007-02-01 and 2007-02-02 only
tabAll2.sub <-subset(tabAll2,Date %in% c("2007-02-01","2007-02-02"))


# Create a png file for the first plot with 
png("plot1.png",width=480,height=480)
# Plot histgram of Clobal_Active_Power
hist(tabAll2.sub$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power(kilowatts)")
# Close the Graph Device 
dev.off()