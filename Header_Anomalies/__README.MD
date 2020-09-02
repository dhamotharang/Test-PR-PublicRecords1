### I. File list
------------
_BWR_Create_Reports.ecl   File that helps run partial and full reports
_Create_Reports.ecl       Module that enables the user to run partial and full reports
Files.ecl                 File where all of the input files are called
Header_Counts.ecl         Report that calculates counts across file and lexids
Header_Percentages.ecl    Report that calculates the population of fields across file
Header_Watchdog_Match.ecl File where the comparison of Header and Watchdog happens 
Layouts.ecl               File where core layouts are stored, if not all layouts
Mailing_List.ecl          File that stores groups and individual emails for Send_Email.ecl
Send_Email.ecl            Where email notifications are configured according to user's preference 


### II. Design 

------------ 

## A. Program design

1. Style
Code was written in a modular style in order to simplify its readability and usage.
Throughout the project the syntax is explained or described by corresponding comments. 

## B. Inputs

1. We needed to find out if there are any anomalies in our Header file, specifically we wanted to know how many anomalies existed per source. In order to achieve this there had to be a standard to compare our file against, which naturally meant that Watchdog was the most sensible choice for this task.

The project uses two files, the raw Header file and Watchdog which are both executed independently from any workflow item.  You can find the code in Files.ecl. 

## C. Match Comparison and Flagging

1. Skewing
Skewing was carefully done in this project to reduce cluster time and reduce the chances of errors when executing reports. Particularly, the Header file gets distributed using a hash algorithm and then deduped by all the fields. On the other hand, the Watchdog is only distributed by lexid. 

2. Header_Watchdog_Match.ecl 
In order to successfully calculate reports on Header there has to be a method that defines the factors which will be calculated. 
In this file we take Watchdog and Header and compare all of its columns per lexid, when the columns are compared the program flags each lexid depending on the outcome.
When the column and row match on both files we flag it with "T" for true, if the results don't match it gets flagged with "F" for false, and lastly, when there is a blank value on Header it gets flagged with "B" for blank.

## D. Reports

1. Header_Counts.ecl 
The goal of this report is to find most common names across Header, most common social security numbers, most common date of births, most common addresses and the normal distribution of all combinations of months and days across the Header file. 

2. Header_Percentages.ecl
In this file, in combination with the outputs obtained from Header_Watchdog_Match.ecl, we are able to calculate the percentages of True values in Header against False values and Blanks. Thus, we are able to understand which sources are providing the most complete and accurate data. 

## E. Executing Reports

1. _Create_Reports.ecl 
This module is designed to allow the user to easily execute partial reports on Header and full reports. The user can simply call the attributes in a BWR file and get the results. If the user wishes to reduce cluster time they can go to File.ecl and reduce the amount of records in the input file. However, I recommend to run both full files to guarantee accuracy in your results.

2. Send_Email.ecl 
When the user executes a full file report, the program will automatically generate an email and send it to the respective groups or individuals in the mailing lists. The content of the email varies depending on the outcome of the report, the size of the files, and whether the cluster was successful or failed. Look in Mailing_List.ecl to update email groups and recipients. Note: this feature is only available for full file reports at this time.

3. Mailing_List.ecl 
In this file we organize groups and individuals to which the Send_Email.ecl file will send reports.

## F. Formating 

1. Formating_Tools.ecl
In this module I stored all of the functions that  help the user achieve any special output, such as commas in numbers or date convertions not provided by the STD library.