/*
	default the event date to filing date if no event
	might want to look at events to make sure counting them correctly
	fix count businesses at address
	the address passed in by Dell should be joined to all addresses per bdid, corp_key(RA address included)
	this should pick up more hits


	before real run do this:
		in dell_append_ids, replace the persist being passed in to the attribute above it
		


	date first/last seen not always right--first is later than last, etc
	norwood systems not showing up, lost records
	not doing ncs match correctly

	do date filtering on misc files(advo, foreclosure, gong, pp, uspis)
  General Filtering – Dell’s Last Transaction Date should be the cut off for information we return.  
	We should not report any information that was not available prior to that date.

·        Matching – 

o        Try to assign BDID and use BDID to get corporate filing if no corporate filing exists for the BDID, then
o        Try to match directly to corporate filings on exact Name, City and State (only consider a match if there is one hit)
o        Set Filing Match = Y only if there is a Match on Corporate Filing
o        Set Filing Type Match = SOS if Corporate Filing Match, Other if BDID Match or None if there is no match
o        Match Criteria = Link ID or NCS

·         Filing Summary – should be based on the initial corporate filing returned (not all BDID’s associated with the filing):
o        Current Status = G if Good Standing Event, D if Delinquent Event or U if unknown
o        Date Last Seen – Latest Filing Date <= Dell Transaction Date
<MAL> I’m not sure if this is clear.  Basically, this field should either be the latest filing date, or if the filing date is > dell transaction, then the dell transaction date.  This also presumes that you’ve appropriate filtered per above.
o        Time Between Filings - # of months (rounded) between Dell Transaction Date and Latest Filing Date
o        Date of Last Event – if available, date of last filing 
o        Time Between Events - # of months (rounded) between latest filing and previous filing (or event if later)
o        Current Derogatory Event – set to Y if current filing contains or is a derogatory event (this should not include Status already captured 
o        Current Address Change – set to Y if current filing contains any address change (include all address types other than previous and registered agent = company)
o        Current Contact Change – set to Y if current filing contains any contact change (include all contact types even registered agent if not company)
o        Dissolution Exists – set to Y if filing event or status ever was = Dissolution Type
o        Reinstatement Exists – set to Y if filing event or status ever was = Reinstatement Type
o        Time Between – # of months (rounded) between Reinstatement Event and Dissolution Event dates

·         Counts – Filing Summary (should be based on initial corporate filing returned only)
o        Count Delinquent Status – count # of filings over life of corporation that contained delinquent status 
o        Count Derogatory Events – count # of filing events over life of corporation that were derogatory
o        Count Address Changes – count # of address changes over life of corporation
o        Count Contact Changes – count # of contact changes over life of corporation

·         Counts – Associations 
o        Businesses at Address (Total, with Delinquent Status & with Derogatory Events) – should be based on input address only
o        Business Associated with Contacts - (Break into 2 Segments:  Registered Agents (only if not company) & Other Contacts) – counts for each set (Total, Delinquent Status & Derogatory Events).  NOTE CHANGE – THIS WILL ADD 3 ADDITIONAL FIELDS, BUT I THINK WORTH BREAKING OUT.  ANY CONCERNS OR QUESTIONS?

o        Other Derogatory Counts – 
§         Bankruptcies, L&J & UCC for Business (Based on all BDIDS associated with Corporate filings)
§         Bankruptcies, L&J & UCC for Contacts (Based on all Link ID’s associated with Corporate filings)

·         Phone & Address Flag – Questions / Additions
o        Add Record Type Code 
o        Recent Foreclosure – what are we considering recent?
o        Phones – are we preferring a directory assistance match & only returning phones plus if 1 match and no eda?

*/













/*
	address type and contact type
	//make sure stats are up to date as far as fields(I've added fields)
	//append miscellaneous stuff to business summary(advo, etc)
	//incorporate full status and event status tables
	//make sure all time fields are in months, not days.  maybe keep them in months in the summary files, then transform them to months in the dell output file
	//add city state match when record does not bdid, or 
	//for other business at same address, will limit them to the last 20 years 
	//Need to populate the EDA/Phonesplus fields.
	//a problem with the rollup of the changes fields(count address changes).  they all have the same number
	//then, when it rolls up, it totals them multiple times.
	
	multiple vendor_ids in business summary file
/////////////////////////////////////////////////////
I am probably not going to have much time in the next couple of days to dig in
, but at first glance something is wrong.  Look at Garr Land and Resource (at first glance):

fixed. There is a last derog event, but the count of derog events is 0 (there are 4). 
fixed. There have been contact changes, but this is not flagged 
There are UCC’s. 
There are 7 companies at the current filing address, of which 6 are delinquent; 
all of those for the most part have delinquent events? 

I am forwarding the full examples that I ran.  I expect counts to be different based upon the logic used;
 but should at least have some results.  Also, why are we returning 3 records for the same charter number
 (aren’t we rolling these up in the appended counts / info?).

Jason / Vern – could you take the lead on manually reviewing both the examples I have provided and the 
DFS sample.  Also, my examples will not be in the sample we are working on now – they were sent randomly 
at different times.  

 

*/