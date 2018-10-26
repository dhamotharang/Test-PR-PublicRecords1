AppendLNPID HIPIE Plugin

This plugin appends dataset that contains personally identifiable information (Name, Address, DOB, NPI etc ..)
with lexis nexis provider id (LNPID). 

INCOMING DATA NOTES

* The plugin expects firstname, lastname, address and one health care specific isn number for best hit rate. 

The more input data points you provider the better the linking process will be able to function.

Input Parameters
Prefix: The prefix for all the appended columns. 
        e.g. Provider will result in the column ProviderLNPID being appended 
            (along with the additional linking result columns).
Weight: Match weight threshold. This is the lowest weight at which LNPIDs are considered a match.
        If the weight is less than the threshold a LNPID will not be assigned to that row.
        This allows products to configure and tune precision & recall.
Distance: Minimum distance between the two highest candidates.
          If the distance is too small between them it will not assign the LNPID to that row.
          Allows for excluding ambiguous results. 
          Returns multiple candidates match inquiry data.
          Returns single candidate if results are not ambiguous.

Best practice is that Address clean has run for all the addresses as a previous step to get 
best results from the linking process. Although SSN\Gender\DOB etc. are optional, you will get 
better results the more data inputs you give the linking process.

Resource Requirements
This plugin is dependant on all the internal indexes and code used for linking.
It cannot be used outside of our core environments and data.

