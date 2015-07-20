library("shiny")
library("maps")
library("googleVis")

# Violent Crime Rates by US State
data(USArrests)
USArrests$State <- rownames(USArrests)
USArrests <- USArrests[c(5, 1, 2, 3, 4)]

# Define server logic required to render the map chart
shinyServer(
        function(input, output) {
                
                # prepare page header
                variable <- reactive({switch(input$Crime,
                                             "Assault" = "assault",
                                             "Rape" = "rape",
                                             "Murder" = "murder")})
                
                output$header <- renderText({paste("Visualization of ", variable(), " arrests in US (1973).")})
                
                dataList <- reactive({switch(input$Crime,
                                             "Assault" = 1,
                                             "Rape" = 2,
                                             "Murder" = 3)})
                
                output$gvis <- renderGvis({
                        # assign data frame variables 
                        d <- dataList()
                        if(d==1) {stateData <- data.frame(USArrests$State, USArrests$Assault)}
                        if(d==2) {stateData <- data.frame(USArrests$State, USArrests$Rape)}
                        if(d==3) {stateData <- data.frame(USArrests$State, USArrests$Murder)}
                        names(stateData)[2] <- "Num.of.Arrests"
                        
                        # generate the map
                        data(stateMapEnv)
                        stateData$state.abb <- state.abb[match(USArrests$State, state.name)]
                        if(d==1) {
                                gvisGeoChart(stateData, "USArrests.State", "Num.of.Arrests", options=list(
                                        region="US", displayMode="regions", resolution="provinces", forceIFrame='TRUE', 
                                        backgroundColor="#81d4fa", datalessRegionColor="#f8bbd0", defaultColor = "#f5f5f5",
                                        colorAxis="{values:[50,100,200,300,350], colors:[\'blue', \'green\', \'yellow', \'orange',\'red']}" ))
                        }
                        else if(d==2) {
                                gvisGeoChart(stateData, "USArrests.State", "Num.of.Arrests", options=list(
                                        region="US", displayMode="regions", resolution="provinces", forceIFrame='TRUE',
                                        backgroundColor="#81d4fa", datalessRegionColor="#f8bbd0", defaultColor = "#f5f5f5",
                                        colorAxis="{values:[5,10,20,30,46], colors:[\'blue', \'green\', \'yellow', \'orange',\'red']}" ))
                        }
                        else if(d==3) {
                                gvisGeoChart(stateData, "USArrests.State", "Num.of.Arrests", options=list(
                                        region="US", displayMode="regions", resolution="provinces", forceIFrame='TRUE',
                                        backgroundColor="#81d4fa", datalessRegionColor="#f8bbd0", defaultColor = "#f5f5f5",
                                        colorAxis="{values:[3,5,10,15,18], colors:[\'blue', \'green\', \'yellow', \'orange',\'red']}" ))
                        }
                })
                
                output$avg <- renderText({
                        # assign data frame variables regardless of selection
                        d <- dataList()
                        if(d==1) {stateData <- data.frame(USArrests$State, USArrests$Assault)}
                        if(d==2) {stateData <- data.frame(USArrests$State, USArrests$Rape)}
                        if(d==3) {stateData <- data.frame(USArrests$State, USArrests$Murder)}
                        
                        # calculate the mean value
                        names(stateData)[2] <- "Num.of.Arrests"
                        meanNumOfArrests <- round(mean(stateData$Num.of.Arrests), 3)
                        paste("<strong>Average:</strong> ", meanNumOfArrests)
                })
                
                output$sd <- renderText({
                        # assign data frame variables regardless of selection
                        d <- dataList()
                        if(d==1) {stateData <- data.frame(USArrests$State, USArrests$Assault)}
                        if(d==2) {stateData <- data.frame(USArrests$State, USArrests$Rape)}
                        if(d==3) {stateData <- data.frame(USArrests$State, USArrests$Murder)}
                        # calculate the std deviation
                        names(stateData)[2] <- "Num.of.Arrests"
                        sdNumOfArrests <- round(sd(stateData$Num.of.Arrests), 3)
                        paste("<strong>Std Dev:</strong> ", sdNumOfArrests)
                        
                })
                
                
        }
)
