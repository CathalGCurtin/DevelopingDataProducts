# Read data from .csv file. We're only interested in first 2 cols but read everything
cycledata <- read.csv("./tfl-daily-cycle-hires.csv", colClasses="character")
# Make sure Day column is converted to a date
cycledata$Day <- as.Date(cycledata$Day, "%d/%m/%Y")
# Change name of 2nd column to make it a bit tidier
names(cycledata)[2] <- 'dailybikehires'
# Now make sure it's numeric
cycledata$dailybikehires <- as.numeric(cycledata$dailybikehires)

shinyServer(
    function(input, output) {
        
        output$dateranges = reactive({
            paste("The date ranges selected are ", 
                  paste(as.character(input$daterange[1]), 
                  " to ", 
                  as.character(input$daterange[2]))
            )
        })

        output$meanbikehire = reactive({
            hiredates <- subset(cycledata, Day >= input$daterange[1])
            hiredates <- subset(hiredates, Day <= input$daterange[2])
            paste("The (rounded to full number) mean bike hire for your date range is : ", 
                  round(mean(hiredates$dailybikehires),0)
            )
        })
        
        output$dailyHires <- renderPlot({
            # Keeping it simple for code readability - plot by date and hires
            plot(cycledata$Day, cycledata$dailybikehires, xlab="Date Range", type='b', col='blue', 
                 ylab="Total Hires", main="London Bike Hires for dataset")
        })
        
    }
)
