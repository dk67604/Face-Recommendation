Inspiration
Try searching "Movies for age 25 Female/Male" on search engine or "Clothes for Women of age 30" on E-commerce websites . The search results will contradicts with your query like you will see results of baby dress instead of women of age 25. This was the seed for our idea. We did research on our first day of Bitcamp for recommendations based on gender and age. We later came across a recent case study conducted in January 2018 - Face Based Advertisement Recommendation with Deep Learning: A Case Study. According to the paper a Face Based Advertisement Recommendation System (FBARS) could raise the accuracy 4 times.

How we built it
We wanted to built a recommendation system that operates on the minimal input (Age and Gender) and recommend users with movies, songs, thing to do nearby, traveling, restaurants, financial advisement. We began our data set search, it was a challenge as most of the data sets does not have the age and gender data associated. The internet connectivity was a major issue to download the datasets and analyze it. We then got a Movielens dataset that has age and gender as one of its field. We thought to make it less user entry application, so we ask user to take a selfie via our application. We then use Microsoft Cognitive Face API REST services to detect age and gender from the image. We created a Deep Learning Neural Network based on Collaborative Filtering in python. We used the Adamax Optimizer. It is a variant of Adam based on the infinity norm.Loss function is Mean squared error. We set epoch to 300.An epoch is a measure of the number of times all of the training vectors are used once to update the weights. The loss values we achieved after running 300 epoch model converged at below loss, loss: 1.6953 - age_out_loss: 0.8459 - gender_out_loss: 0.8494 - val_loss: 1.9955 - val_age_out_loss: 0.9974 - val_gender_out_loss: 0.9981 The age and gender is pass as parameter to the Neural Network Model. The model recommends the top 10 movies to the user based on age- gender and top ratings.

Challenges we ran into
One of the major challenge we had come across was with the data collection. There are very few open source data sets available that has age and gender. We found a Movielens dataset but age field had data in high range. Due to this the distribution of the data was not uniform that affected the performance of the Deep Learning Model. We then tweaked our age data by generating age using row shuffle + random number generator based on age range.

Accomplishments that we're proud of
We implemented a proof of concept which captures your photo and detects age-gender. Based on the age-gender, recommends movies to the user.

What we learned
The facial features such as age, gender, can help us classify consumers intuitively and rapidly so that it can raise the accuracy in recommendation in a short time. Face Based Recommendation System could raise the accuracy 4 times.

What's next for Face 2 Recommendation
More squeezed Neural Network that can be deployed on iPhone or Android devices. A more robust model can be developed to recommend Clothing, Life-style, Music, Restaurants, Travel Destinations, etc.

Built With
deep-learning
microsoft-cognitive-face-api
keras
collaborative-filtering
wide-and-deep-learning
ios
swift
pandas
python
