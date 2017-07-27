import doxie, business_header,ut;

unsigned2 pt := 10 : stored ('PenaltThreshold');

business_header.doxie_MAC_Field_Declare ();

boolean IsDeepDive := ~noDeepDive;
boolean is_CompSearchL := company_name_value <> '' or Business_Header.stored_bdid_value > 0;

ids := OSHAIR_services.Get_ids (false, , IsDeepDive, is_CompSearchL); //this is layout [layouts.id + isDeepDive]

rec_ids := project (ids, layouts.id);

//NOTE: no ssn_mask_value; OSHAIR doesn't have SSNs
ds_recs := OSHAIR_services.raw.SEARCH_VIEW.by_id (rec_ids);

// Filter by input date range if it was supplied
string8 ActivityStartDate  := ''     : STORED('ActivityStartDate');
string8 ActivityEndDate    := ''     : STORED('ActivityEndDate');

// input dates should be in YYYYMMDD format
is_valid_dateinput := (ActivityStartDate = '' or ut.ValidDate(ActivityStartDate)) 
		                  and (ActivityEndDate = '' or ut.ValidDate(ActivityEndDate));
		
IF(~is_valid_dateinput, FAIL('An error occurred while running OSHAIR_Services.OSHAIRSearchService: invalid input dates.') );

ds_filt := ds_recs(ut.isInRange((string8)ut.NormDate((unsigned)Last_Activity_Date),ActivityStartDate,ActivityEndDate));

recs_filt := if(ActivityStartDate != '' or ActivityEndDate != '',ds_filt,ds_recs);
 
rdd := join (recs_filt, ids, 
             (unsigned) left.activity_number = right.activity_number,
             transform ({ids.isDeepDive, ds_recs}, self.isDeepDive := right.isDeepDive, self := left),
             left outer);

rdd_filtered := rdd (penalt <= pt);    // Simplification of the original code that was filtering and sorting at the same time.
rdd_dedup := dedup(rdd_filtered, all); // Duplicates were detected.  An ALL is necessary since Last_Activity_Date is not been provided anymore. (Ticket 188440)
rsrt := sort (rdd_dedup, if (isDeepDive, 1, 0), penalt, -Last_Activity_Date);
doxie.MAC_Marshall_Results (rsrt, rmar);

export search_records := rmar;


