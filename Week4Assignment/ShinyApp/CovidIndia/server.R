#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(jsonlite)
library(plotly)
library(lubridate)
library(dplyr)




getCovidData <- function(){
    
    state_map <- data.frame(
        code=c("AN","AP","AR","AS","BR","CH","CT","DL","DN","GA","GJ","HP","HR","JH","JK","KA","KL","LA","MH","ML","MN","MP","MZ","NL","OR","PB","PY","RJ","SK","TG","TN","TR","UP","UT","WB","TT","UN"),
        name =c("Andaman and Nicobar Islands","Andhra Pradesh" ,"Arunachal Pradesh" ,"Assam" ,"Bihar" ,"Chandigarh" ,"Chattisgarh" ,"Delhi" ,"Dadar and Nagar Haveli" ,"Goa" ,"Gujarat" ,"Himachal Pradesh", 
                "Haryana" ,"Jharkhand" ,"Jammu and Kashmir" ,"Karnataka" ,"Kerala" ,"Ladakh" ,"Maharashtra" ,"Meghalaya" ,"Manipur" ,"Madhya Pradesh" ,"Mizoram" ,"Nagaland" ,"Orissa" ,"Punjab" ,
                "Puducherry" ,"Rajasthan" ,"Sikkim" ,"Telangana" ,"Tamil Nadu" ,"Tripura" ,"Uttar Pradesh" ,"Uttarakhand" ,"West Bengal","TT","UN" )
    )
    
    covidjson <- fromJSON(txt="https://api.covid19india.org/v4/min/timeseries.min.json",simplifyVector = FALSE)
    coviddata <- data.frame(state_code=NULL, state_name=NULL,date =NULL, count=NULL)
    for(i in 1:length(covidjson)){
        statecode <- names(covidjson[i])
        statename <- state_map[state_map$code==statecode,]$name
        for(j in 1:length(covidjson[[i]]$dates)){
            date <-  as.Date(names(covidjson[[i]]$dates[j]))
            count <- 0 
           if (! is.null(covidjson[[i]]$dates[[j]]$delta) && !is.null(covidjson[[i]]$dates[[j]]$delta$confirmed)){
               count <- covidjson[[i]]$dates[[j]]$delta$confirmed
           }
            if(count <0 ){
                count <- 0
            }
            temp <- data.frame(state_code = statecode,state_name =statename, date = date, count = count )
            coviddata <- rbind(coviddata, temp)
        }
    }
    return (coviddata)
    

}

covid_data <- getCovidData()

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
    output$tabular <- renderDataTable({
        data <- covid_data %>% filter(state_code == input$state) %>% filter(( as.Date(today())-date) <=  input$months*30)
        data
    })
    
    output$covidPlot <- renderPlotly({
        data <- covid_data %>% filter(state_code == input$state) %>% filter(( as.Date(today())-date) <=  input$months*30)
        plot_ly(data, x = data$date, y= data$count, type="bar", mode="markers")
    })

})
