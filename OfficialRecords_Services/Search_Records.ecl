IMPORT AutoStandardI, dx_official_records, iesp, NID, ut, suppress, STD;

EXPORT Search_Records := MODULE
  EXPORT params := INTERFACE
    (OfficialRecords_Services.Search_IDs.params,
     AutoStandardI.LIBIN.PenaltyI_Indv.base)
    EXPORT INTEGER2 FilingStartDateYear := 0;
    EXPORT INTEGER2 FilingStartDateMonth := 0;
    EXPORT INTEGER2 FilingStartDateDay := 0;
    EXPORT INTEGER2 FilingEndDateYear := 0;
    EXPORT INTEGER2 FilingEndDateMonth := 0;
    EXPORT INTEGER2 FilingEndDateDay := 0;
  END;
  
  EXPORT DATASET(iesp.officialrecord.t_OfficialRecRecord) val(params in_mod) := FUNCTION
  
    // Get the official_record_key (orid) numbers associated with what information was
    // entered in the input search fields.
    orids := OfficialRecords_Services.Search_IDs.val(in_mod);
    
    // Join orids returned from Search_IDs to key party orid on official_record_key to get
    // detailed info for the orid.
    recs_joined := JOIN(orids, dx_official_records.Key_Party_ORID,
                     KEYED(LEFT.official_record_key=RIGHT.official_record_key),
                      TRANSFORM(OfficialRecords_Services.Layouts.raw_rec,
                       SELF:=LEFT,
                       SELF:=RIGHT,
                       SELF := []),
                     LIMIT(OfficialRecords_Services.Constants.MAX_RECS_ON_JOIN, SKIP));

    // Set local attributes to be used in filter checking below
    search_st := TRIM(STD.STR.ToUpperCase(in_mod.state),LEFT,RIGHT);
    // Reminder; input county was stored in city for searching autokeys
    search_county := TRIM(STD.STR.ToUpperCase(in_mod.city),LEFT,RIGHT);
                     
     // Create 8 digit date string from individual pieces (yyyy, mm, dd).
    INTEGER4 search_date_start := (in_mod.FilingStartDateYear*10000) +
                                  (in_mod.FilingStartDateMonth*100) +
                                  in_mod.FilingStartDateDay;
    INTEGER4 temp_date_end := (in_mod.FilingEndDateYear*10000) +
                                  (in_mod.FilingEndDateMonth*100) +
                                  in_mod.FilingEndDateDay;
                                  
    // if end date not entered, set it to the highest possible value for filtering below.
    INTEGER4 search_date_end := IF(temp_date_end=0,99999999,temp_date_end);
        
    // Filter to only include records that meet what was entered on the search criteria.

    // Only include recs for the requested state (if there was one).
    recs_filt1 := recs_joined (search_st='' OR
                                (search_st <> '' AND search_st = state_origin));

    // Only include recs for the requested county and state (if there was one).
    // If county entered on search form, then state must also be entered for filtering
    // to take place. That is how the moxie search worked.
    recs_filt2 := recs_filt1 (search_county='' OR
                              (search_county<>'' AND search_st='') OR
                              (
                               search_county <> '' AND search_county = county_name AND
                               search_st <> '' AND search_st = state_origin
                              )
                             );

    // Used to replace spaces in date strings with zeroes so cast to integer works Ok for
    // all date variations.
    fixed_date(STRING8 dtin) := STD.Str.FindReplace(dtin, ' ', '0');

    // *********************************************************************************
    // Filter to only include records that meet what was entered on the search criteria.
    // *********************************************************************************

    // Only include recs within the requested date range (if there was one),
    // fixing the doc_filed_dt in case it just contains a yyyy or a yyyymm.
    recs_filt3 := recs_filt2 (search_date_start <= (INTEGER4) fixed_date(doc_filed_dt) AND
                              (INTEGER4) fixed_date(doc_filed_dt) <= search_date_end
                             );
      
    // input values
    in_strict := in_mod.StrictMatch;
    in_nicknames_on := in_mod.allownicknames;
    in_phonetics_on := in_mod.phoneticmatch;
    
    STRING20 search_firstname := TRIM(STD.STR.ToUpperCase(in_mod.FirstName),LEFT,RIGHT);
    STRING20 search_middlename := TRIM(STD.STR.ToUpperCase(in_mod.MiddleName),LEFT,RIGHT);
    BOOLEAN search_mi_only := IF(search_middlename[2]=' ', TRUE, FALSE);
    STRING20 search_lastname := TRIM(STD.STR.ToUpperCase(in_mod.LastName),LEFT,RIGHT);
    STRING120 search_compname := STD.STR.ToUpperCase(in_mod.CompanyName);

    // When StrictMatch requested, filter on last name
    // allowing for when PhoneticMatch was requested.
    recs_filt4 := recs_filt3 (NOT(in_strict) OR search_compname<>'' OR
                              (search_lastname <> '' AND
                               (search_lastname = TRIM(lname1,LEFT,RIGHT) OR
                                (in_phonetics_on AND
                                  metaphonelib.DMetaPhone1(search_lastname)[1..6] =
                                  metaphonelib.DMetaPhone1(lname1)[1..6]
                                )
                               )
                              )
                             );

    // When StrictMatch requested, filter on first name,
    // allowing for when AllowNickNames was requested.
    recs_filt5 := recs_filt4 (NOT(in_strict) OR search_compname<>'' OR
                              (search_firstname <> '' AND
                               (search_firstname = TRIM(fname1,LEFT,RIGHT) OR
                                (in_nicknames_on AND
                                  NID.mod_PFirstTools.PFLeqPFR(search_firstname,TRIM(fname1,LEFT,RIGHT))
                                )
                               )
                              )
                             );
    
    // When StrictMatch requested, filter on:
    // entire middle name if more than 1 character entered in search by field or
    // only first initial of middle name if only 1 character entered in search by field.
    recs_filt6 := recs_filt5 (NOT(in_strict) OR search_compname<>'' OR
                              search_middlename=' ' OR
                              (search_middlename <> '' AND
                               (NOT(search_mi_only) AND
                                  search_middlename = TRIM(mname1,LEFT,RIGHT)
                               )
                               OR
                               (search_mi_only AND search_middlename[1] = mname1[1])
                              )
                             );
    

    // Remove all records for an orid except one.
     recs_filt_deduped := DEDUP(SORT(recs_filt6,official_record_key),
                               official_record_key);
 
     // Join orids to key document orid on official_record_key to get
    // detailed document level info for the orid.
    recs_joined2 := JOIN(recs_filt_deduped, dx_official_records.Key_Document_ORID,
                      KEYED(LEFT.official_record_key=RIGHT.official_record_key),
                      TRANSFORM(dx_Official_Records.layouts.document,
                        SELF:=RIGHT; SELF := []),
                     LIMIT(OfficialRecords_Services.Constants.MAX_RECS_ON_JOIN, SKIP));
    
    // Format recs for searchservice XML output
    recs_fmtd := OfficialRecords_Services.Functions.fnSearchVal(recs_joined2);
    
    // Sort into final order for returning
    recs_sort := SORT(recs_fmtd,-FilingDate.Year,
                                -FilingDate.Month,
                                -FilingDate.Day,
                                State,
                                County,
                                OfficialRecordId,
                                RECORD);

    // Dedup
    recs_dedup := DEDUP(recs_sort, RECORD);
    
    // Limit the returned output records to the current max value of 2000 records.
    recs_proj := CHOOSEN(recs_dedup, iesp.Constants.OFFRECS_MAX_COUNT_SEARCH_RESPONSE_RECORDS);

    // Compliance
    Suppress.MAC_Suppress(recs_proj,recs_pulled,in_mod.applicationtype,,,Suppress.Constants.DocTypes.OfficialRecord,OfficialRecordId);


    //Uncomment lines below as needed to assist in debugging
    //output(in_mod.penalty_threshold,named('sr_inmod_pen_th'));
    //output(orids,named('sr_orids'));
    //output(recs_joined, named('sr_recs_joined'));
    //output(in_mod.state,named('sr_inmod_state'));
    //output(in_mod.city,named('sr_inmod_city'));
    //output(search_st,named('sr_search_st'));
    //output(search_county,named('sr_search_county'));
    //output(search_date_start,named('sr_searchdatestart'));
    //output(temp_date_end,named('sr_tempdateend'));
    //output(search_date_end,named('sr_searchdateend'));
    //output(in_strict,named('sr_in_strict'));
    //output(in_nicknames_on,named('sr_in_nicknames_on'));
    //output(in_phonetics_on,named('sr_in_phonetics_on'));
    //output(search_firstname,named('sr_search_firstname'));
    //output(search_middlename,named('sr_search_middlename'));
    //output(search_lastname,named('sr_search_lastname'));
    //output(recs_filt1, named('sr_recs_filt1'));
    //output(recs_filt2, named('sr_recs_filt2'));
    //output(recs_filt3, named('sr_recs_filt3'));
    //output(recs_filt4, named('sr_recs_filt4'));
    //output(recs_filt5, named('sr_recs_filt5'));
    //output(recs_filt6, named('sr_recs_filt6'));
    //output(recs_filt_deduped, named('sr_recs_filt_deduped'));
    //output(recs_joined2, named('sr_recs_joined2'));
    //output(recs_fmtd, named('sr_recs_fmt'));
    //output(recs_sort, named('sr_recs_sort'));
    //output(recs_proj, named('sr_recs_proj'));
    
    RETURN recs_pulled;

  END;
    
END;
