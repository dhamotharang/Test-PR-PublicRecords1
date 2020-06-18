/*
One time BWR to expand Person file layout with new PRtcc fields.
*/
IMPORT Data_Services, FLAccidents_Ecrash;
EXPORT Pre_Update_Person_InputFile := FUNCTION

ds_person := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::persn_raw'
										,Layout_Person
										,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Person_ID');
													 

 FLAccidents_Ecrash.Layout_Infiles.persn_NEW ExpandPersonLayout(ds_person L) := TRANSFORM
																																									SELF := L;
																																									SELF := [];
																																								 END;
																									 
 upd_person_layout := PROJECT(ds_person, ExpandPersonLayout(LEFT));
		
 ds_person_upd := OUTPUT(upd_person_layout,,'~thor_data400::in::ecrash::person_layout_change_'+workunit,overwrite,__compressed__,
				                 csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

 do_all :=  SEQUENTIAL(
												ds_person_upd,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile('~thor_data400::in::ecrash::persn_raw', FALSE),
												FileServices.AddSuperFile('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::person_layout_change_'+workunit),
												FileServices.FinishSuperFileTransaction()
										  );
					 
 RETURN do_all;
END;

