Covid 19 India App 
========================================================
author: Trina Dey
date: 04 Jan 2021
autosize: true

Introduction
========================================================

All over the world we are tracking Covid-19 cases. In India, Govt. has opened up their apis to be used by different tech companies. So we have taken the data from <a href="https://api.covid19india.org/">Covid-19 India Org Apis</a>. The data that has been fetched is a time series data present in json format which can be found <a href="https://api.covid19india.org/v4/min/timeseries.min.json">here</a> 

Application Technical Overview
========================================================

- The application is written in Shiny which is a web application framework for R
- The source code consists of two files: server.R and ui.R
- server.R includes the the server logic of a Shiny web application
- ui.R includes the the user-interface definition, which uses the sidebarLayout template
- The application is hosted on Rstudio's shiny server in the cloud (Shinyapps.io)

Application Feature Overview
========================================================

There are primarily two parts to the application -   
1. to show the data in tabular format  
2.  to plot the data in a bar graph  

Following are the steps performed -   
1. Download the json data and parse to create data frame  
2. Data frame has stateCode, stateName, date and count per row  
3. Based on the selected number of months and state, data is shown in tabular and plot format  
4. The plot is interactive and you can zoom or select a part of plot to further see the data

Interactive Plots
========================================================
Interactive plots can be zoomed in or zoomed out, clipped to enhance specific parts. Here is the data and one such plot

```
  state_code  state_name       date count
1         MH Maharashtra 2020-12-30  3537
2         MH Maharashtra 2020-12-31  3509
3         MH Maharashtra 2021-01-01  3524
4         MH Maharashtra 2021-01-02  3218
5         MH Maharashtra 2021-01-03  3282
6         MH Maharashtra 2021-01-04     0
```

Interactive Plots - Part 2
========================================================


```r
suppressPackageStartupMessages(library(plotly))

p <- plot_ly(data, x = data$date, y= data$count, type="bar", mode="markers")
htmlwidgets::saveWidget(as.widget(p), file = "demo.html")
```
<iframe src="demo.html" style="position:absolute;height:100%;width:100%"></iframe>

Documentation
========================================================

- The code for the app can be find at Github here.
- The UI for the app is hosted at shinyapps.io and can be found here.
