shinyUI(pageWithSidebar(
    headerPanel("London Datastore Bike Hire"),
    sidebarPanel(
        helpText("Note: Choose a date range between 2010-07-30 and 2015-02-28",
                 "to see mean bike hires in date range. ",
                 "The associated plot shows all hires for entire date range.",
                 " "),
        dateRangeInput('daterange','Select bike hire dates',
                       start = "2010-07-30",
                       end   = "2015-02-28",
                       min   = "2010-07-30",
                       max   = "2015-02-28",
                       format = "yyyy/mm/dd"),
        textOutput("dateranges")
    ),
    mainPanel(
        plotOutput('dailyHires'),
        textOutput("meanbikehire")
    )
))
