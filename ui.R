library(shiny)

# Define UI for application that renders a map chart
shinyUI(pageWithSidebar(
        headerPanel("Visualization of Violent Crime Rates"),
        sidebarPanel(
                p("How to use the application:"),
                p("Select the violent crime type from the dropdown box to display the crime rate for each state as indicated by the color code."),
                p("The map uses a color legend that reflects the severity of violent crime rate for each state, where blue indicates low crime rate and red indicates high crime rate."),
                p("If you hover your mouse pointer over a state, the number of arrests will be displayed."),
                selectInput("Crime", "Select the crime:",
                            choices = c("Assault", "Rape", "Murder")),
                p("Created by: Paul Lim Min Chim"),
                p("Date: 20 July 2015")),
        mainPanel(h4(textOutput("header")),
                  p("The color legend below the chart shows the minimum & maximum values."),
                  htmlOutput("gvis"),
                  p(uiOutput("avg")),
                  p(uiOutput("sd"))
                  )
        )
        
)
