IMPORT Data_Services, STD, FLAccidents_Ecrash;

EXPORT  fn_delete_document():= FUNCTION

	document := DATASET(Data_Services.foreign_prod+'thor_data400::in::ecrash::document_raw'
								 ,FLAccidents_Ecrash.Layout_Infiles.Document
								 ,CSV(HEADING(1),TERMINATOR('\n'), SEPARATOR(','),QUOTE('"')),OPT)(Document_ID != 'Document_ID');
				 
	//Distribute DS
  d_document := document(incident_id NOT IN ['19044647', '19044651']); 

	
	doc_out := OUTPUT(d_document,,'~thor_data400::in::ecrash::data_removal_document_'+WORKUNIT,OVERWRITE,__COMPRESSED__,
		                CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"')));
				 
	document_out := SEQUENTIAL(
														doc_out,
														FileServices.StartSuperFileTransaction(),
														FileServices.ClearSuperFile('~thor_data400::in::ecrash::document_raw', FALSE),
														FileServices.AddSuperFile('~thor_data400::in::ecrash::document_raw','~thor_data400::in::ecrash::data_removal_document_'+workunit),
														FileServices.FinishSuperFileTransaction()
													 );
													 

	
	delete_document_data := SEQUENTIAL(
	                             COUNT(document),
															 COUNT(d_document),
															 document_out
															);
	 
	RETURN delete_document_data;
END;
