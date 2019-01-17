AppendLexID HIPIE Plugin

Given a dataset that contains Personally Identifiable Information (Name, Address, DOB etc..)
this plugin will append the LexID along with metrics that quantify the match.
 
This plugin will typically be used as a pre-cursor step for plugins that will append 
additional content, like a best append, vehicle, property, crim history appends.
It will also be used in situations where disambiguation on identity is required.
e.g. patient prescriptions where the goal is to tie all the prescriptions for patients together
     across name variations and location\address variations.
     
Best practice is that Address clean has run for all the addresses as a previous step to get 
best results from the linking process. Although SSN\Gender\DOB etc. are optional, you will get 
better results the more data inputs you give the linking process.
 
Resource Requirements
This plugin is dependant on all the internal indexes and code used for linking.
It cannot be used outside of our core environments and data.

Input Parameters
Prefix: The prefix for all the appended columns. 
        e.g. BusinessContact will result in the column BusinessContactLexid being appended 
            (along with the additional linking result columns).
Weight: Match weight threshold. This is the lowest weight at which LexIDs are considered a match.
        If the weight is less than the threshold a LexID will not be assigned to that row.
        This allows products to configure and tune precision & recall.
Distance: Minimum distance between the two highest candidates.
          If the distance is too small between them it will not assign the Lexid to that row.
          Allows for excluding ambiguous results. 
          Returns multiple candidates match inquiry data.
          Returns single candidate if results are not ambiguous.

FirstName: is required.
LastName: is required.

The rest of the parameters are optional. The more input data points you provide the better the 
linking process will be able to function.

These are the super indexes required from production (via RAMPS Cert\QA).

Supername                                                                        Size           Rows
thor_data400::key::insuranceheader_xlink::qa::did::refs::zip_pr   589,734,977,536  6,521,214,646
thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn4      87,997,947,904  1,452,398,889
thor_data400::key::insuranceheader_xlink::qa::did::refs::ssn      545,140,826,112  9,192,076,565
thor_data400::key::insuranceheader_xlink::qa::did::refs::ph       572,031,123,456  9,123,086,044
thor_data400::key::insuranceheader_xlink::qa::did::refs::name     825,323,945,984  9,987,218,077
thor_data400::key::insuranceheader_xlink::qa::did::refs::lfz      830,241,742,848  9,873,771,968
thor_data400::key::insuranceheader_xlink::qa::did::refs::dob      614,614,056,960  9,171,980,766
thor_data400::key::insuranceheader_xlink::qa::did::refs::dln       73,457,508,352    692,766,464
thor_data400::key::insuranceheader_xlink::qa::did::refs::address  845,441,187,840  8,698,804,534
                                                         Total: 4,983,983,316,992
