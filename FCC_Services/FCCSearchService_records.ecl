IMPORT doxie, business_header;

  unsigned2 pt := 10 : stored('PenaltThreshold');

  business_header.doxie_MAC_Field_Declare ();

  boolean is_CompSearchL := company_name_value <> '';

  // workHard = true, noFail = false, IncludeDeepDives = false, is_CompSearchL = false
  ids := FCC_services.Get_ids (false, , false, is_CompSearchL); //this is layout [layouts.id]

  ds_recs := FCC_services.raw.SEARCH_VIEW.by_id (ids, application_type_value);


  rsrt := SORT (ds_recs (penalt <= pt), penalt, licensees_name, licensees_attention_line);

  doxie.MAC_Marshall_Results (rsrt, rmar);

EXPORT FCCSearchService_records := rmar;
