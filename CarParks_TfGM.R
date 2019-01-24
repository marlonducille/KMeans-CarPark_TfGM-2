
df <- read.csv('CarParks_TfGM.csv')
data <- df[c('Id', 'Capacity')]

#'''''''''''''''''''''''''''''''''''
#'Determine the optimal value for k
#'''''''''''''''''''''''''''''''''''
set.seed(20)
n <- 10
wss <- numeric(n) #preolocate with zeros

for(k in 1:n) {
  k_means <- kmeans(data, centers = k)
  wss[k] <- sum(k_means$withinss)
  print(k_means)
}

plot(1:10, wss, type='b', xlab = "No of clusters", ylab = "WSS")
# After viewing the graph from the Elbow method, the best value for k is 4

#''''''''''''''''''''''
#'Determine the k-means
#''''''''''''''''''''''
library(cluster)
km <- kmeans(data, centers = 4)
km$centers
km$cluster

clusplot(data, km$cluster, lines=0, shade = TRUE, color = TRUE, span = TRUE, 
         plotchar = TRUE, xlab = "Capacity", ylab = "Car Park ID", 
         main = "Car Park Capacity" )

group_name <- c('small', 'medium', 'large', 'extra-large')

car_park_category <- cbind(df[3], km$cluster)
car_park_category$group_name <- group_name[km$cluster]




