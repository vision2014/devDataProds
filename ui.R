# set the working directory
setwd("~/Data_Analysis_with_R/Coursera/devDataProds/courseProject")

# load packages
library(shiny);library(UsingR);library(rpart);library(caret)
library(e1071);library(rpart.plot)
library(shinyapps); library(ggplot2)

# get the data
data(iris)

# Build the application
# Define UI for application
shinyUI(pageWithSidebar(
    # Application title
    headerPanel(h4("I wonder, What species of the iris flower has the following measurements?")),
    # Sidebar with with sliders
    sidebarPanel(
        h6("Lets get started. Use the sliders to select the flower parts measurements"),
        # Input values
        # Sepal.Length
        sliderInput('sepLen', h5('Sepal length (cm)'),value = mean(iris$Sepal.Length), min = min(iris$Sepal.Length), max = max(iris$Sepal.Length), step = 0.1),
        # Sepal.Width
        sliderInput('sepWid', h5('Sepal Width (cm)'),value = mean(iris$Sepal.Width), min = min(iris$Sepal.Width), max = max(iris$Sepal.Width), step = 0.1),
        # Petal.Length
        sliderInput('petLen', h5('Petal length (cm)'),value = mean(iris$Petal.Length), min = min(iris$Petal.Length), max = max(iris$Petal.Length), step = 0.1),
        # Petal.Width
        sliderInput('petWid', h5('Petal Width (cm)'),value = mean(iris$Petal.Width), min = min(iris$Petal.Width), max = max(iris$Petal.Width), step = 0.1),
        # Training data
        h6("Now select the percent of training data you'd like to use"),
        sliderInput('pctTrain',h6('Percentage of training data'),value = 70, min = 50, max = 90, step = 10),
        h6("Good, now click the Predict button below to make your prediction. Look above the chart for your prediction results"),
        submitButton("Predic"),
        h5(a("Documentation",href="https://github.com/vision2014/devDataProds/blob/64e5c024c95084eb17569ec62879ca4c08adfae0/app_documentation.txt",target="_blank"))
    ),
    # show the plot
    mainPanel(
        h5("Predicted species"),
        verbatimTextOutput("prediction"),
        h5("Scatter plot"),
        plotOutput('dTree'),
        h5("Confusion Matrix"),
        h6("I wonder, how did my prediction model perform?"),
        verbatimTextOutput("confMat")
    )
))

