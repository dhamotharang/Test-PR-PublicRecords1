AppendLNFID HIPIE Plugin

This plugin appends dataset that contains facility information (company name, Address, NPI etc ..)
with lexis nexis facility id (LNFID). 

INCOMING DATA NOTES

* The plugin expects facilityname, address and one health care specific isn number for best hit rate. 

Input Parameters
Prefix: The prefix for all the appended columns. 
        e.g. Facility will result in the column FacilityLNFID being appended 
            (along with the additional linking result columns).
Weight: Match weight threshold. This is the lowest weight at which LNFIDs are considered a match.
        If the weight is less than the threshold a LNFID will not be assigned to that row.
        This allows products to configure and tune precision & recall.
Distance: Minimum distance between the two highest candidates.
          If the distance is too small between them it will not assign the LNFID to that row.
          Allows for excluding ambiguous results. 
          Returns multiple candidates match inquiry data.
          Returns single candidate if results are not ambiguous.

Best practice is that Address clean has run for all the addresses as a previous step to get 
best results from the linking process. Although NPI\Taxonomy\CLIA etc. are optional, you will get 
better results the more data inputs you give the linking process.

Resource Requirements
This plugin is dependant on all the internal indexes and code used for linking.
It cannot be used outside of our core environments and data.

