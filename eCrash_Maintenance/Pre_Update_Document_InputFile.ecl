/*
One time BWR to expand Document file layout with new fields.
*/
IMPORT Data_Services, FLAccidents_Ecrash;
EXPORT Pre_Update_Document_InputFile := FUNCTION

ds_photo := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::document_raw'
								    ,Layout_Document
								    ,CSV(HEADING(1),TERMINATOR('\n'), SEPARATOR(','),QUOTE('"')),OPT)(Document_ID != 'Document_ID');
																	
 FLAccidents_Ecrash.Layout_Infiles.Document ExpandDocumentLayout(ds_photo L) := TRANSFORM
																																												SELF := L;
																																									      SELF := [];
																																								       END;
																									 
 upd_document_layout := PROJECT(ds_photo, ExpandDocumentLayout(LEFT));
		
 ds_document_upd := OUTPUT(upd_document_layout,,'~thor_data400::in::ecrash::document_layout_change_'+workunit,overwrite,__compressed__,
				                   csv(terminator('\n'), separator(','),quote('"')));

 do_all :=  SEQUENTIAL(
												ds_document_upd,
												FileServices.StartSuperFileTransaction(),
												FileServices.ClearSuperFile('~thor_data400::in::ecrash::document_raw', FALSE),
												FileServices.AddSuperFile('~thor_data400::in::ecrash::document_raw','~thor_data400::in::ecrash::document_layout_change_'+workunit),
												FileServices.FinishSuperFileTransaction()
										  );
					 
 RETURN do_all;
END;

