IMPORT SALT38,STD;
EXPORT Delta(DATASET(Layout_OKC_Probate_Profile)old_s, DATASET(Layout_OKC_Probate_Profile) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['name_score','filedate','dod','dob','masterid','debtorfirstname','debtorlastname','debtoraddress1','debtoraddress2','debtoraddresscity','debtoraddressstate','debtoraddresszipcode','dateofdeath','dateofbirth','isprobatelocated','casenumber','filingdate','lastdatetofileclaim','issubjecttocreditorsclaim','publicationstartdate','isestateopen','executorfirstname','executorlastname','executoraddress1','executoraddress2','executoraddresscity','executoraddressstate','executoraddresszipcode','executorphone','attorneyfirstname','attorneylastname','firm','attorneyaddress1','attorneyaddress2','attorneyaddresscity','attorneyaddressstate','attorneyaddresszipcode','attorneyphone','attorneyemail','documenttypes','corr_dateofdeath','pdid','pfrd_address_ind','nid','cln_title','cln_fname','cln_mname','cln_lname','cln_suffix','cln_title2','cln_fname2','cln_mname2','cln_lname2','cln_suffix2','persistent_record_id','cname','cleanaid','addresstype','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_OKC_Probate_Profile, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_OKC_Probate_Profile, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OKC_Probate, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));


    RETURN hygieneDiffOverall_Standard;
  END;
END;
