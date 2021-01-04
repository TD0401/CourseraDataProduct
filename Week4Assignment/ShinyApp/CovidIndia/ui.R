#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(shinycssloaders)

# Define UI for application that draws a histogram for covid cases count and shows tabular data for count
shinyUI(fluidPage(

    # Application title
    titlePanel("Covid 19 India Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("state",h3("Choose State"), 
                        choices = list(
                            "Andaman and Nicobar Islands" ="AN",
                            "Andhra Pradesh" ="AP",
                            "Arunachal Pradesh" ="AR",
                            "Assam" ="AS",
                            "Bihar" ="BR",
                            "Chandigarh" ="CH",
                            "Chattisgarh" ="CT",
                            "Delhi" ="DL",
                            "Dadar and Nagar Haveli" ="DN",
                            "Goa" ="GA",
                            "Gujarat" ="GJ",
                            "Himachal Pradesh" ="HP",
                            "Haryana" ="HR",
                            "Jharkhand" ="JH",
                            "Jammu and Kashmir" ="JK",
                            "Karnataka" ="KA",
                            "Kerala" ="KL",
                            "Ladakh" ="LA",
                            "Maharashtra" ="MH",
                            "Meghalaya" ="ML",
                            "Manipur" ="MN",
                            "Madhya Pradesh" ="MP",
                            "Mizoram" ="MZ",
                            "Nagaland" ="NL",
                            "Orissa" ="OR",
                            "Punjab" ="PB",
                            "Puducherry" ="PY",
                            "Rajasthan" ="RJ",
                            "Sikkim" ="SK",
                            "Telangana" ="TG",
                            "Tamil Nadu" ="TN",
                            "Tripura" ="TR",
                            "Uttar Pradesh" ="UP",
                            "Uttarakhand" ="UT",
                            "West Bengal" ="WB"
                            )
                            , selected="MH"),
            
            sliderInput("months",
                        "No. of months from today:",
                        min = 1,
                        max = 10,
                        value = 2)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h4("This website shows the Covid-19 cases in India state wise. The Tabular data shows day wise count. The Graphical Data shows the plot of count of cases over days."),
            h4("The side panel allows to select the number of months of data you want to see from today and there is an option to select state."),
            tabsetPanel(type = "tabs",
                                         tabPanel("Tabular Data",br(),withSpinner(dataTableOutput("tabular"))),
                                         tabPanel("Graphical Data",br(),withSpinner(plotlyOutput("covidPlot")))
                        )
            
        )
    )
))
