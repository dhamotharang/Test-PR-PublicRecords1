/*
Mark / Todd,

Vern, Jason and I met yesterday to discuss implementation from a data development standpoint
and made changes to the proposed files / layout that we want to build.  Initially this was the
result of discussions over handling the various contacts and address types in the file; however,
the primary goal ended up being to create files that were more generic; enabling us to add other 
sources as we are able.  As Vern gets into the development, he will undoubtedly discover other 
changes we want/need to make.  We also decided to go ahead and pre-calculate some of the other 
information as well regardless of usage for our own analysis.  These calculations will not be 
priority for the project completion. Vern will be starting to work on this immediately.  Please 
let us know if you have and concerns or other suggestions for the changes.

Business Summary File
date_filing_first seen – Initial Filing Date
date_filing_last_seen - Latest Filing Date or Latest Filing Event
bdid
unique_id
source - (= BH Source Code)
current_status - (D = Delinquent, G = Good Standing) **
current_status_date 
date_most_recent_status_change(date prior status?)
count_delinquent_status
last_event_date
last_derogatory_events **
count_derogatory_events
count_bankruptcy
count_liens_judgments
count_ucc_filings

Contact Summary File
bdid
unique_id
contact_type (R = Registered Agent, O = Officer) **
last_contact_type_change_date
count_contact_type_changes
count_bankruptcies_associated_contact_type
count_liens_judgments_associated_contact_type
count_ucc_filings_associated_contact_type

Address Summary File
unique_id
bdid
address_id
address_type (M = Mailing, R= Registered Agent, O = Officer) **
last_address_type_change
count_addresss_type_changes

At run time we would/could still do the following:

Address
            Bankruptcies at
            L&J at
            UCC at
            Foreclosure at (need recency – last 90 days?)
            ADVO Indicators – see attached for additional indicators that seem interesting to leverage

Company and Contacts
            Bankruptcies
            L&J
            UCC


/////////////////////////////////////////////////////////////////////////////////////
I didn’t want to forget some of our discussion so just throwing ideas out there on segmentation of business and contacts.  

Create metadata file on BDID with the following: 
Business vs. Residential Address 
Total Number of Sources Reporting BDID at Address 
Last Date Source Reported BDID at Address 
Property Type (Multi-Unit, High Rise, etc.) 
Count of all Other Business Reported at Address 
Count of all Business with Delinquent Status Reported at Address 
Count of all Business with Derogatory Events Reported at Address 
Count of Other EDA Listings at Address 
Count of Total Link IDs Associated with BDID 
Count of Total Link ID’s Associated with Other Delinquent BDIDs 
Count of Total Link ID’s Associated with Other Derogatory BDID’s 
Has Active Parent Company 
Number of other Companies in DCA tree 
 

By starting to determine a way to segment the BDID’s and identify potential “shell” corporations and the contacts associated with them we could then begin to create a file of “potential fraudulent relationships (associated fraudulent businesses (bdid – bdid), associated fraudulent individuals (linked – linked).  Again, I think we might need an additional identifier for the business contacts which would ultimately help us to segment further the valid individuals from the synthetic identities created solely from “shell corporation”.

//////////////////
Me thinking again about yesterday’s email and creating more work againJ  It would be interesting though once we have the business information to create the contact file (based on those files) and include some consumer risk indicators.  Something like (just a start – ideas?):

adl
adl_segment
adl_crim_record_flag (non-traffic)
count_adl_ssn
count_adl_dob_variations
count_adl_name_variations
count_adl_bankruptcies
count_adl_liens_judgments
count_adl_ucc_flings
count_bdid_total_associations
count_bdid_total_associations_StatusG (good standing)
count_bdid_total_associations_StatusD (delinquent)
count_bdid_total_associations_EventsD (derogatory)
count_bdid_address_HRI (number of bdids with at least one address HRI)
count_bdid_bankruptcy
count_bdid_liens_judgments
count_bdid_ucc_filings

*/