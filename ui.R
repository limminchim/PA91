library(shiny)

# Define UI for application that renders a map chart
shinyUI(pageWithSidebar(
        headerPanel("Visualization of Violent Crime Rates by US States (1973)"),
        sidebarPanel(
                p("How to use the application: Select the crime from the dropdown box to update the map display."),
                selectInput("Crime", "Select the crime:",
                            choices = c("Assault", "Rape", "Murder")),
                p("Created by: Paul Lim Min Chim"),
                p("Date: 18 July 2015")),
        mainPanel(h4(textOutput("header")),
                  p("Hover over state to view the number of arrests per 100,000 people in that state."),
                  p("The color-scale bar below the chart shows the minimum & maximum values."),
                  htmlOutput("gvis"),
                  p(uiOutput("avg")),
                  p(uiOutput("sd"))
                  )
        )
        
)
