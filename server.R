# set the working directory
setwd("~/Data_Analysis_with_R/Coursera/devDataProds/courseProject")

# load packages
library(shiny);library(UsingR);library(rpart);library(caret)
library(e1071);library(rpart.plot)
library(shinyapps); library(ggplot2)

# get the data
data(iris)

# Define the server logic required to generate and plot the chart
shinyServer(
    function(input, output) {
        output$dTree <- renderPlot({
             # Plot 
            qplot(Sepal.Length, Petal.Length, data = iris, color = Species, 
                  size = Petal.Width, alpha = I(0.7), xlab = "Sepal Length", ylab = "Petal Length",
                  main = "Sepal Length vs. Petal Length of Iris Flowers")
            # By setting the alpha of each point to 0.7, we reduce the effects of overplotting.
        })
        
        # Show the first "n" observations
        output$prediction <- renderPrint({
            # user inputs
            sepLen <- input$sepLen
            sepWid <- input$sepWid
            petLen <- input$petLen
            petWid <- input$petWid
            pctTrain <- input$pctTrain
            # partition data into training and testing set
            set.seed(1234)
            inTrain <- createDataPartition(y = iris$Species, p = pctTrain/100, list = FALSE)
            trainData <- iris[inTrain,]; testData <- iris[-inTrain,]
            # model
            model <- train(Species ~ ., method = "rpart", data = trainData)
            #Prediction
            #sepLen*2
            #dat = cbind(sepLen,sepWid)
            dat <- cbind(Sepal.Length = sepLen,Sepal.Width = sepWid, Petal.Length = petLen, Petal.Width = petWid)
            #colnames(userInput) <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
            #levels(iris$Species)
            predict(model, newdata = dat)
        })
        
        # Show the first "n" observations
        output$confMat <- renderPrint({
            # user inputs
            sepLen <- input$sepLen
            sepWid <- input$sepWid
            petLen <- input$petLen
            petWid <- input$petWid
            pctTrain <- input$pctTrain
            # partition data into training and testing set
            set.seed(1234)
            inTrain <- createDataPartition(y = iris$Species, p = pctTrain/100, list = FALSE)
            trainData <- iris[inTrain,]; testData <- iris[-inTrain,]
            # model
            model <- train(Species ~ ., method = "rpart", data = trainData)
            #Prediction
            #sepLen*2
            #dat = cbind(sepLen,sepWid)
           
            confusionMatrix(model, newdata = testData)
        })
})

# run app
# shinyApp(ui = ui2, server = server2)
# runApp()