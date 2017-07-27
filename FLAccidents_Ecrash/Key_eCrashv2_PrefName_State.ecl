/*2015-07-23T22:34:48Z (Srilatha Katukuri)
#173799 removed the pref_fname from payload
*/
/*2015-07-23T16:43:40Z (Srilatha Katukuri)
#173799 - reordering the key fields

*/
/*2015-07-07T18:00:52Z (Srilatha Katukuri)
#173799
*/
IMPORT NID, Data_Services, Doxie, NID;

	New_Slim_Layout := RECORD
		STRING20 fname ;
		FLAccidents_Ecrash.Layouts.key_slim_layout ;
	END;
 
	New_Slim_Layout	ModifySlimLayout( FLAccidents_Ecrash.File_KeybuildV2.out L)	:= TRANSFORM
		//SELF.pref_fname	:= NID.PreferredFirstVersionedStr(L.fname, NID.version);  
		SELF.fname	:=	L.fname;
		//SELF.IdField	:=  L.Idfield;
		SELF	:= L;
	END;
 
	dsSlimFile := project ( FLAccidents_Ecrash.File_KeybuildV2.out(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and fname <> '') , ModifySlimLayout(LEFT)); 
	dsDedupFile := dedup(sort(distribute(dsSlimFile, hash64(accident_nbr)), fname,accident_nbr,report_code,jurisdiction_state,jurisdiction,accident_date, report_type_id, local ), fname,accident_nbr,report_code,jurisdiction_state,jurisdiction,accident_date, report_type_id, local);
	EXPORT	Key_eCrashv2_PrefName_State:=	INDEX(dsDedupFile
																							,{fname,jurisdiction_state,jurisdiction}
																							,{dsDedupFile}
																							,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::eCrashV2_PrefName_State_' + doxie.Version_SuperKey);
																							
																																
																															
