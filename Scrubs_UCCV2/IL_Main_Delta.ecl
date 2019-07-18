IMPORT SALT311,STD;
EXPORT IL_Main_Delta(DATASET(IL_Main_Layout_UCCV2)old_s, DATASET(IL_Main_Layout_UCCV2) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['tmsid','rmsid','process_date','static_value','date_vendor_removed','date_vendor_changed','filing_jurisdiction','orig_filing_number','orig_filing_type','orig_filing_date','orig_filing_time','filing_number','filing_number_indc','filing_type','filing_date','filing_time','filing_status','status_type','page','expiration_date','contract_type','vendor_entry_date','vendor_upd_date','statements_filed','continuious_expiration','microfilm_number','amount','irs_serial_number','effective_date','signer_name','title','filing_agency','address','city','state','county','zip','duns_number','cmnt_effective_date','description','collateral_desc','prim_machine','sec_machine','manufacturer_code','manufacturer_name','model','model_year','model_desc','collateral_count','manufactured_year','new_used','serial_number','property_desc','borough','block','lot','collateral_address','air_rights_indc','subterranean_rights_indc','easment_indc','volume','persistent_record_id'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := IL_Main_hygiene(old_s).Summary('Old') + IL_Main_hygiene(new_s).Summary('New') + IL_Main_hygiene(PROJECT(Differences(deleted), TRANSFORM(IL_Main_Layout_UCCV2, SELF := LEFT.old_rec))).Summary('Deletions') + IL_Main_hygiene(PROJECT(Differences(added), TRANSFORM(IL_Main_Layout_UCCV2, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_UCCV2, IL_Main_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
