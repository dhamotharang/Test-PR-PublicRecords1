/*
One time BWR to expand Citation file layout with new PRtcc fields.
*/
IMPORT Data_Services;
EXPORT Pre_Update_Citation_PRtcc_DataElements := FUNCTION

 Lay := RECORD
  string citation_id;
  string creation_date;
  string incident_id;
  string person_id;
  string citation_issued;
  string citation_number1;
  string citation_number2;
  string section_number1;
  string court_date;
  string court_time;
  string citation_detail1;
  string local_code;
  string violation_code1;
  string violation_code2;
  string multiple_charges_indicator;
  string dui_indicator;
  string court_time_am;
  string court_time_pm;
  string violator_name;
  string type_hazardous;
  string type_other;
  string citation_status;
 END;

 ds_citation := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::citatn_raw'
											 ,Lay
											 ,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)))(Incident_ID != 'Citation_ID');
													 

 FLAccidents_Ecrash.Layout_Infiles.citation ExpandCitationLayout(ds_citation L) := TRANSFORM
																																									  SELF.Violation_Code3 := '';
																																									  SELF.Violation_Code4 := '';
																																									  SELF := L;
																																								   END;
																									 
 upd_citation_layout := PROJECT(ds_citation, ExpandCitationLayout(LEFT));
		
 OUTPUT(upd_citation_layout,,'~thor_data400::in::ecrash::citation_layout_change_prtcc_'+workunit,overwrite,__compressed__,
				csv(terminator('\n'), separator(','),quote('"'),maxlength(60000)));

 do_all :=  SEQUENTIAL(
												FileServices.StartSuperFileTransaction(),
												FileServices.AddSuperFile('~thor_data400::in::ecrash::citatn_raw','~thor_data400::in::ecrash::citation_layout_change_prtcc_'+workunit),
												FileServices.FinishSuperFileTransaction()
										  );
					 
 RETURN do_all;
END;

