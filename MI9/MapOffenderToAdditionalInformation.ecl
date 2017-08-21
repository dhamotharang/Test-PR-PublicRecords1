




import crim_common;
import crim_cp_ln;

Layout_additional_information_Offender_key := Layout_additional_information_cp;

Layout_additional_information_Offender_key   tr_PrimOffenderToAddInfo(Distribute_File_Primary_Offender_ECL_Cade_id L) := TRANSFORM,
                                                                                                                 SKIP(l.image_link = '')
  
	SELF.ECL_CADE_ID := L.ECL_CADE_ID;
  SELF.OFFENDER_KEY := L.Seisint_Primary_Key; 
 	//SELF.ADIN_ID := '';
  SELF.NARRATIVE_INFORMATION :=  'C:\\SOFF\\'  + StringLib.StringToLowerCase(regexreplace('([A-Z]+)([_].*)',l.image_link ,'$1')) + '.photos\\' +  l.image_link;  
 	SELF.CADE_CADE_ID :=  '';
	SELF.CREATED_BY  := 'HPCCLOAD';
 	SELF.CREATION_DT := StringLib.GetDateYYYYMMDD();
 	SELF.LAST_UPDATED_BY := '';
 	SELF.LAST_UPDATE_DT := '';
 	SELF.RECORD_SUPPLIER_CD := L.RECORD_SUPPLIER_CD_C;
 	SELF.BATCH_NUMBER := '';
  SELF.OLD_RECORD_SUPPLIER_CD  := L.OLD_RECORD_SUPPLIER_CD_C;
	SELF := [];
END;	
	
ds_AddInfo := PROJECT(Distribute_File_Primary_Offender_ECL_Cade_id,tr_PrimOffenderToAddInfo(LEFT));
  

export MapOffenderToAdditionalInformation := SORT(ds_AddInfo,ecl_cade_id)
                             : persist ('~thor_data400::persist::out::crim::cross_soff::MapOffenderToAdditionalInformation');   
                                            















