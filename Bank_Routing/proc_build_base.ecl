IMPORT Bank_Routing,ut,address,PromoteSupers,AID,lib_StringLib;

EXPORT proc_build_base(DATASET(RECORDOF(Bank_Routing.Layouts.Base_WithRT)) inFile) := FUNCTION

 lAIDPrep := RECORD
  string50 Append_PrepAddr1;
  string50 Append_PrepAddr2;
  Bank_Routing.Layouts.Base;
 END;
 
 //Cleanup and format the incoming records
 lAIDPrep tMapInput(Bank_Routing.Layouts.Base_WithRT pInput) := TRANSFORM
  SELF.RawAID := 0;
  SELF.current_record := IF(pInput.__Tpe = Bank_Routing.Ingest().RecordType.Old,'N','Y');
  SELF.Process_Date := thorlib.wuid()[2..9];
  SELF.Dt_First_Seen := IF(pInput.__Tpe = Bank_Routing.Ingest().RecordType.Old,pInput.Dt_First_Seen,(UNSIGNED4)SELF.Process_Date);
  SELF.Dt_Last_Seen := IF(pInput.__Tpe = Bank_Routing.Ingest().RecordType.Old,pInput.Dt_Last_Seen,(UNSIGNED4)SELF.Process_Date);
  SELF.Dt_Vendor_First_Reported := IF(pInput.__Tpe = Bank_Routing.Ingest().RecordType.Old,pInput.Dt_Vendor_First_Reported,(UNSIGNED4)SELF.Process_Date);
  SELF.Dt_Vendor_Last_Reported := IF(pInput.__Tpe = Bank_Routing.Ingest().RecordType.Old,pInput.Dt_Vendor_Last_Reported,(UNSIGNED4)SELF.Process_Date);
  SELF.s_date_updated := Bank_Routing.fn_formatDate(pInput.date_updated);
  SELF.s_year_2000_date_last_updated := Bank_Routing.fn_formatDate(pInput.year_2000_date_last_updated);
  SELF.institution_name_full := StringLib.StringToUppercase(pInput.institution_name_full);
  SELF := pInput;
  SELF := [];
 END;

 rsMappedInputFile := PROJECT(inFile,tMapInput(LEFT));

 lAIDPrep tProjectAIDPrep(lAIDPrep pInput, INTEGER cnt) := TRANSFORM
  SELF.Append_PrepAddr1 := CHOOSE(cnt,pInput.street_address,pInput.mail_address);
  SELF.Append_PrepAddr2 := CHOOSE(cnt,TRIM(pInput.city_town)+' '+TRIM(pInput.state)+' '+TRIM(pInput.zip_code),
   TRIM(pInput.mail_city_town)+' '+TRIM(pInput.mail_state)+' '+TRIM(pInput.mail_zip_code));
  SELF.address_type := CHOOSE(cnt,'B','M');
  SELF := pInput;
 END;
 
 rsAIDPrep := NORMALIZE(rsMappedInputFile,2,tProjectAIDPrep(LEFT,COUNTER));

 unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

 AID.MacAppendFromRaw_2Line(rsAIDPrep,Append_PrepAddr1,Append_PrepAddr2,RawAID,rsCleanAID,lAIDFlags);

 Bank_Routing.Layouts.Base tProjectClean(rsCleanAID pInput) := TRANSFORM
  SELF.prim_range := pInput.aidwork_acecache.prim_range;
  SELF.predir := pInput.aidwork_acecache.predir;
  SELF.prim_name := pInput.aidwork_acecache.prim_name;
  SELF.addr_suffix := pInput.aidwork_acecache.addr_suffix;
  SELF.postdir := pInput.aidwork_acecache.postdir;
  SELF.unit_desig := pInput.aidwork_acecache.unit_desig;
  SELF.sec_range := pInput.aidwork_acecache.sec_range;
  SELF.p_city_name := pInput.aidwork_acecache.p_city_name;
  SELF.v_city_name := pInput.aidwork_acecache.v_city_name;
  SELF.st := pInput.aidwork_acecache.st;
  SELF.zip := pInput.aidwork_acecache.zip5;
  SELF.zip4 := pInput.aidwork_acecache.zip4;
  SELF.cart := pInput.aidwork_acecache.cart;
  SELF.cr_sort_sz := pInput.aidwork_acecache.cr_sort_sz;
  SELF.lot := pInput.aidwork_acecache.lot;
  SELF.lot_order := pInput.aidwork_acecache.lot_order;
  SELF.dpbc := pInput.aidwork_acecache.dbpc;
  SELF.chk_digit := pInput.aidwork_acecache.chk_digit;
  SELF.rec_type := pInput.aidwork_acecache.rec_type;
  SELF.county := pInput.aidwork_acecache.county;
  SELF.ace_fips_st := SELF.county[1..2];
  SELF.fips_county := SELF.county[3..5];
  SELF.geo_lat := pInput.aidwork_acecache.geo_lat;
  SELF.geo_long := pInput.aidwork_acecache.geo_long;
  SELF.msa := pInput.aidwork_acecache.msa;
  SELF.geo_blk := pInput.aidwork_acecache.geo_blk;
  SELF.geo_match := pInput.aidwork_acecache.geo_match;
  SELF.err_stat := pInput.aidwork_acecache.err_stat;
  SELF.rawaid := pInput.aidwork_rawaid;
  SELF := pInput;
 END;
	
 rsCleanAIDParsed := PROJECT(rsCleanAID, tProjectClean(LEFT));
			
 PromoteSupers.Mac_SF_BuildProcess(rsCleanAIDParsed,bank_routing.thor_cluster + 'base::bank_routing',build_base,,,true);

 RETURN build_base;

END;