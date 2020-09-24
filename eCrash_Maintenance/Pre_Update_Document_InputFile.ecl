/*
One time BWR to populate report_source field in Document file to 'CC'
*/
IMPORT Data_Services, FLAccidents_Ecrash;
EXPORT Pre_Update_Document_InputFile := FUNCTION

ds_photo := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::document_raw'
								    ,FLAccidents_Ecrash.Layout_Infiles.Document
								    ,CSV(HEADING(1),TERMINATOR('\n'), SEPARATOR(','),QUOTE('"')),OPT)(Document_ID != 'Document_ID');
																	
 FLAccidents_Ecrash.Layout_Infiles.Document AddReportSource(ds_photo L) := TRANSFORM
		SELF.report_source := 'CC';
		SELF := L; 
 END;
																									
 add_Report_Source := PROJECT(ds_photo, AddReportSource(LEFT));	 
 
		
 ds_document_upd := OUTPUT(add_Report_Source,,'~thor_data400::in::ecrash::document_raw_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
				                   CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"')));

 do_all :=  SEQUENTIAL(
												ds_document_upd,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile('~thor_data400::in::ecrash::document_raw', FALSE),
												FileServices.AddSuperFile('~thor_data400::in::ecrash::document_raw','~thor_data400::in::ecrash::document_raw_'+WORKUNIT),
												FileServices.FinishSuperFileTransaction()
										  );
					 
 RETURN do_all;
END;

