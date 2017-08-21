/*2016-03-30T17:48:16Z (Srilatha Katukuri)
Bug# 200197 - Included to not to count for blank Orig Lastnames
*/
/*2016-03-23T18:26:01Z (Srilatha Katukuri)
Bug#200197 - modifying last name
*/
/*2015-11-16T20:55:36Z (Srilatha Katukuri)
#193680 - CR323
*/
/*2015-07-22T17:53:59Z (Srilatha Katukuri)
#173799
*/
/*2015-07-20T22:08:28Z (Srilatha Katukuri)
#173799
*/
import doxie, ut, Data_Services, std; 

	New_Slim_Layout := RECORD
		STRING20 lname ;
		FLAccidents_Ecrash.Layouts.key_slim_layout ;
		
	END;
	
	New_Slim_Layout	ModifyLayout( FLAccidents_Ecrash.File_KeybuildV2.out L)	:= TRANSFORM
		SELF.lname	:=	L.lname;
		SELF	:= L;
	END;
	
	FLAccidents_Ecrash.Layout_keybuild_SSv2 copyNames(FLAccidents_Ecrash.Layout_keybuild_SSv2 le) := TRANSFORM
		SELF.fname := le.Orig_fname;
		SELF.lname := le.orig_lname;
		self.mname := le.orig_mname;
		self := Le;
	END;
	 
dsKeyBuild := 	 FLAccidents_Ecrash.File_KeybuildV2.out(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and lname <> '' and trim(report_type_id,all) in ['A','DE']);

mSSv2:= PROJECT(dsKeyBuild(trim(lname, left, right) <> trim(orig_lname, left, right) and  (STD.STr.CountWords(lname,' ') > 1 or STD.STr.CountWords(orig_lname,' ') > 1 ) and orig_lname <> '' ),copyNames(LEFT));

dsSlimFile := project (mSSv2 + dsKeyBuild , ModifyLayout(LEFT));
ds_LastName	:= dedup(sort(distribute(dsSlimFile, hash64(accident_nbr)), accident_nbr,report_code,jurisdiction_state,jurisdiction,accident_date, report_type_id, local),lname,accident_nbr,report_code,jurisdiction_state,jurisdiction,accident_date, report_type_id, local); 


EXPORT Key_EcrashV2_LastName := 	INDEX(ds_LastName
																							,{lname,jurisdiction_state,jurisdiction}
																							,{ds_LastName}
																						,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::eCrashV2_LastName_State_' + doxie.Version_SuperKey);
																					
																						
																										