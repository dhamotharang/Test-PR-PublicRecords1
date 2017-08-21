// NEW_Proc_Build_Autokeys 
// Moved over from PRTE2 module to create specialized PRTE2_Foreclosure module.

IMPORT AutoKeyB2, ut, roxiekeybuild, PRTE_CSV, PRTE2_Common;

EXPORT NEW_Proc_Build_Autokeys(string filedate) := MODULE

			//************************************
			SHARED Join_Files_Module := Join_files(filedate);
			EXPORT file_out1 := Join_Files_Module.File_Foreclosure_Autokey_CT;
			SHARED OUT1 := OUTPUT (choosen(file_out1,100),NAMED('fileout1'));

			SHARED File_Foreclosure_Autokey_bdid :=
								project(file_out1,
									transform(recordof(file_out1) - [bid,bid_score],
										self.bdid := left.bdid,
										self.bdid_score := left.bdid_score,
										self := left));

			SHARED OUT2 := OUTPUT(File_Foreclosure_Autokey_bdid,,'~prte::ct::foreclosure::bdid',OVERWRITE);		
				
			file_out2 := Join_Files_Module.File_Foreclosures_Joined_CT;
			SHARED file_out3 := file_out2(document_type !='');

			SHARED OUT3 := OUTPUT (file_out3,,'~prte::ct::foreclosure::fileout3',OVERWRITE);
			File_Foreclosure_FID :=
								project(file_out3,
										Transform(PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__fid,
										SELF.fid := left.foreclosure_id,
										SELF.state := left.st,
										SELF.name1_ssn := IF(left.name1_ssn='',left.SSN,left.name1_ssn);
										SELF.name1_did :=  IF(left.name1_did='',(STRING)left.did,left.name1_did);
										SELF.name1_bdid :=  IF(left.name1_bdid='',(STRING)left.bdid,left.name1_bdid);
										SELF.name1_did_score :=  IF(left.name1_did_score='',(STRING)left.did_score,left.name1_did_score);
										SELF.name1_bdid_score :=  IF(left.name1_bdid_score='',(STRING)left.bdid_score,left.name1_bdid_score);
										self := left,
										self := [] ));
//************************************************************************************************
			EXPORT foreclosure_ak_dataset2 := DEDUP(File_Foreclosure_FID(fid != ''),RECORD, ALL);
//********** NOTE: 7/2/2014 - foreclosure_ak_dataset2 ABOVE IS USED in PRTE2_Foreclosure.Proc_build_foreclosure_keys 

			SHARED OUT4 := OUTPUT(foreclosure_ak_dataset2,,'~prte::ct::foreclosure::ak_dataset2',OVERWRITE);
				
			//*  APPEND FILES HERE *//			
			EXPORT foreclosure_ak_dataset := File_Foreclosure_Autokey_bdid;

			SHARED ak_dataset  := foreclosure_ak_dataset;
			EXPORT ak_keyname	:= files.ak_keyname;
			EXPORT ak_logical	:= files.ak_logical(filedate);
			EXPORT ak_skipSet	:= ['P','Q','F'];
			EXPORT ak_typeStr	:= 'AK';


			// To build the updated keys,  USE THE SHORT VERSION THAT MATCHES PRODUCTION, ak_dataset:
			layout_autokey := RECORD
					ak_dataset;
			END;

			AutoKeyB2.MAC_Build (ak_dataset,name_first,name_middle,name_last,
								 ssn,
								 zero,
								 blank,
								 site_prim_name,
								 site_prim_range,
								 site_st,
								 site_p_city_name,
								 site_zip,
								 site_sec_range,
								 zero,
								 zero,zero,zero,
								 zero,zero,zero,
								 zero,zero,zero,
								 zero,
								 did,
								 name_Company, // compname which is string thus "blank"
								 zero,
								 zero,
								 site_prim_name,
								 site_prim_range,
								 site_st,
								 site_p_city_name,
								 site_zip,
								 site_sec_range,
								 bdid, // bdid_out
								 ak_keyname,
								 ak_logical,
								 bld_auto_keys,false,
								 ak_skipSet,true,ak_typeStr,
								 true,,,zero);

								 
			AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, move_auto_keys,, ak_skipSet);


			EXPORT retval := SEQUENTIAL(OUT1,OUT2,OUT3,OUT4,bld_auto_keys, move_auto_keys);
//************************************************************************************************
//********** NOTE: 7/2/2014 - retval is referenced in the PRTE2_Foreclosure.BWR_Build_Foreclosure 
//************************************************************************************************
			

END;