https://jira.rsi.lexisnexis.com/browse/CDENH-4001
Updated Requirement  received on July 24/2019

Opt Out Export File

The complete list of opted out California residents is exported daily.   The extracted data is in CSV format, a single row for the heading, a vertical bar as a field separator, a single row for a footer with a record count,  and containing the following fields:

ENTRY_TYPE
OPTOUT – standard Opt Out Request
DELETE – standard Delete Request
Other types may be defined in the future
LEXID of consumer opting out
PROF_DATA - Include Healthcare professional data (Y/N)
STATE_ACT – state abbreviation of the act under which this consumer has opted out
“CA” for CCPA
DATE_OF_REQUEST of the request (YYYYMMDD)
An example file:

ENTRY_TYPE|LEXID|PROF_DATA|STATE_ACT|DATE_OF_REQUEST

OPTOUT|123456|Y|CA|20200101

OPTOUT|987654321|N|CA|20200110

ROWCOUNT|2|||
------------------------------------------------------------------------------------------
https://jira.rsi.lexisnexis.com/browse/CCPA-685 - Create build process for SuppressOptOutKeys, 
FCRA_SuppressOptOutKeys, and Boolean SuppressOptOutKeys.