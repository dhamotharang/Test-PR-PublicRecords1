/*2015-07-22T17:53:59Z (Srilatha Katukuri)
#173799
*/
/*2015-07-20T22:08:28Z (Srilatha Katukuri)
#173799
*/
import doxie, ut, Data_Services ; 

	New_Slim_Layout := RECORD
		STRING20 lname ;
		FLAccidents_Ecrash.Layouts.key_slim_layout ;
		
	END;
	
	New_Slim_Layout	ModifyLayout( FLAccidents_Ecrash.File_KeybuildV2.out L)	:= TRANSFORM
		SELF.lname	:=	L.lname;
		SELF	:= L;
	END;
	 
	 
dsSlimFile := project ( FLAccidents_Ecrash.File_KeybuildV2.out(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and lname <> '') , ModifyLayout(LEFT));

ds_LastName	:= dedup(sort(distribute(dsSlimFile, hash64(accident_nbr)), accident_nbr,report_code,jurisdiction_state,jurisdiction,accident_date, report_type_id, local),lname,accident_nbr,report_code,jurisdiction_state,jurisdiction,accident_date, report_type_id, local); 


EXPORT Key_EcrashV2_LastName := 	INDEX(ds_LastName
																							,{lname,jurisdiction_state,jurisdiction}
																							,{ds_LastName}
																						,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::eCrashV2_LastName_State_' + doxie.Version_SuperKey);
																						
																										