# TwinTwist_Hackathon
Honeywell Hackathon 2017

############################################################# Overview ####################################################################

* Connect people with similar interests around the globe!!!
* Share Events /Activities of Your interest
* Share local activities and “interests” with each other

Tools & Languages

Tools
1. Visual Studio 2013 
2. RStudio
3. Oracle DB with SQL developer
4. MS SQL Server Management Studio 2014

Languages
1. ASP DOTNET, C#
2. R
3. Css, javascript, jquery
4. SQL

Proposed architecture/ Flow 

Proposal 1:

* User enters interests
* R code fetches real-time tweets from twitter
* Uses data analytics to group people into similar interests
* Use data analytics to give user suggestions about the trending events and topics
* Displays in the web page

Proposal 2:

* User enters interests
* Uses Database stored procedures to group and display the people with similar interests
* Display it in the website


Designs Proposed

* Connecting to Twitter and retrieving real time tweets from R and use it to predict trending and most tweeted events.
* Functionalities supported by Oracle Queries.
* Functionalities supported by asp.Net MVC web app with SQL server database.

Algorithms and Logics

* MVC application where user can create and share events
* Events grouped and displayed according to the user’s choice of interest
* User can Like and share events, notifications etc.
* Use R to extract real-time tweets, analyze it and group people with similar interests
* Use R for topic modelling, to analyze tweets and identify most tweeted topics and notify the user if he is interested about it
* Connect R to SQL database to store outputs
* Connect Web interface to R 
* Connect SQL to web interface to store and retrieve data

SQL Server Database as Backend

Three main tables:
1. Events: to store the events and it’s details
2. UserInterests: to store user and his interests
3. UserFollow: to store the user and the other users he is following

* MS SQL Connected to MVC using ADO DOT NET Entity data model to store and retrieve the data
* MS SQL connected to R code using RODBC connectivity to store the results of the real-time data analytics process and display it in the front end

Challenges Faced

* Storing real time tweets from R
* Connecting Oracle database with Visual Studio
* Sharing notification as live feed

Status

* Able to connect to  Tweet API  through R and retrieve tweets locally
* Able to run all the functionality of the application using a backend of Oracle database
* Able to run basic functionality of the application with a backend of SQL server and front end of asp.Net MVC web interface.

Future Scope

* The application can be connected to real time tweets and perform real time analytics of tweets
* The application can be connected to oracle database to implement the stored procedures

                                    ###########################THE END#####################################








