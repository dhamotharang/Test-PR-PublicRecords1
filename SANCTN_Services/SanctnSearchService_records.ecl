IMPORT business_header,doxie,Sanctn_services,STD,ut;

EXPORT SanctnSearchService_records (doxie.IDataAccess mod_access) := 
  FUNCTION

  unsigned2 pt := 10 : stored('PenaltThreshold');

  business_header.doxie_MAC_Field_Declare ();

  boolean is_CompSearchL := company_name_value <> '';

  // workHard = true, noFail = false, IncludeDeepDives = false, is_CompSearchL = false
  ids := Sanctn_services.Get_ids (true, , false, is_CompSearchL); //this is layout [layouts.id]

  ds_recs := Sanctn_services.raw.SEARCH_VIEW.by_id (ids, mod_access);

  // additional filtering, in case we have incident date in input
  string8 inc_date_val       := '' : STORED ('IncidentDate');
 	string8 IncidentStartDate  := '' : STORED('IncidentStartDate');
	string8 IncidentEndDate    := '' : STORED('IncidentEndDate');

  is_valid_dateinput := (IncidentStartDate = '' or STD.DATE.IsValidDate((UNSIGNED4)IncidentStartDate)) 
		                       and (IncidentEndDate = '' or STD.DATE.IsValidDate((UNSIGNED4)IncidentEndDate));
		
	IF(~is_valid_dateinput, FAIL('An error occurred while running SANCTN_Services.SanctnSearchService: invalid input dates.') );
	
  ds_dtfilt := ds_recs ((inc_date_val = '') OR (incident_date_clean = inc_date_val));

  ds_dtrangefilt := ds_recs(ut.isInRange(incident_date_clean,IncidentStartDate,IncidentEndDate));
	
  ds_filt := map(inc_date_val != '' => ds_dtfilt,
	               IncidentStartDate != '' or IncidentEndDate != '' => ds_dtrangefilt,
								 ds_recs);

  rsrt := SORT (ds_filt (penalt <= pt), penalt, -incident_date_clean);

  doxie.MAC_Marshall_Results (rsrt, rmar);

  RETURN rmar;
  END;
