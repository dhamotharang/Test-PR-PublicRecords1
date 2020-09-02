IMPORT $, BKForeclosure, Data_Services, ut;

EXPORT Files(BOOLEAN	pUseProd	=	FALSE) := MODULE
 SHARED fileprefix	:= IF(pUseProd, data_services.foreign_prod, '~');

 //SHARED lAssignRaw:= {BKMortgage.Layouts.Assign_Raw_out, string100 raw_file_name { virtual(logicalfilename)}};
 
 
//BK Assignment Files 
 EXPORT Assignment_Update_in     := DATASET(fileprefix + 'thor_data400::in::BKMortgage::Update_Assignment',
																					BKMortgage.Layouts.Assign_Raw_out_ext,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 EXPORT Assignment_Orphan_Update := DATASET(fileprefix + 'thor_data400::in::BKMortgage::Update_Assignment_orphan',
																					BKMortgage.Layouts.Assign_Raw_out_ext,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));

 // EXPORT Assignment_Delete       := DATASET(fileprefix + 'thor_data400::in::BKMortgage::delete_Assignment',
																					// BKMortgage_Assignment.Layouts.Delete_Rec,THOR);
 
 EXPORT Assignment_Refresh_Ref  := DATASET(fileprefix + 'thor_data400::in::BKMortgage::refresh_Assignment',
																					BKMortgage.Layouts.Assign_Raw_out_ext,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 EXPORT Assignment_Orphan_Ref   := DATASET(fileprefix + 'thor_data400::in::BKMortgage::refresh_Assignment_orphan',
																					BKMortgage.Layouts.Assign_Raw_out_ext,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 
 EXPORT Assignment_Update	  := Assignment_Update_in + Assignment_Orphan_Update;
 EXPORT Assignment_Refresh  := Assignment_Refresh_Ref + Assignment_Orphan_Ref;
 
 EXPORT Assignment_Infile		:= DEDUP(SORT(Assignment_Refresh + Assignment_Update, -ln_filedate, FIPSCode, PID),RECORD, EXCEPT ln_filedate, bk_infile_type);
																
 EXPORT fAssign         := DATASET('~thor_data400::base::BKMortgage::Assignment',
																		BKMortgage.Layouts.AssignBase,THOR,OPT);
																			
//BK Release Files
	//SHARED lReleaseRaw:= {BKMortgage.Layouts.Release_Raw_out, string100 raw_file_name { virtual(logicalfilename)}};

	EXPORT Release_Update_in    	:= DATASET(fileprefix + 'thor_data400::in::BKMortgage::Update_Release',
																					BKMortgage.Layouts.Release_Raw_out_ext,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
	EXPORT Release_Orphan_Update  := DATASET(fileprefix + 'thor_data400::in::BKMortgage::Update_Release_orphan',
																					BKMortgage.Layouts.Release_Raw_out_ext,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));

	// EXPORT Release_Delete       	:= DATASET(fileprefix + 'thor_data400::in::BKMortgage::delete_Release',
																					// BKMortgage_Release.Layouts.Delete_Rec,THOR);
																					
	EXPORT Release_Refresh_Ref  	:= DATASET(fileprefix + 'thor_data400::in::BKMortgage::refresh_Release',
																					BKMortgage.Layouts.Release_Raw_out_ext,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
	EXPORT Release_Orphan_Ref   	:= DATASET(fileprefix + 'thor_data400::in::BKMortgage::refresh_Release_orphan',
																					BKMortgage.Layouts.Release_Raw_out_ext,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
																					
	EXPORT Release_Update  				:= Release_Update_in + Release_Orphan_Update;
	EXPORT Release_Refresh  			:= Release_Refresh_Ref + Release_Orphan_Ref;
	
	EXPORT Release_Infile					:= DEDUP(SORT(Release_Refresh + Release_Update, -ln_filedate, FIPSCode, PID),RECORD, EXCEPT ln_filedate, bk_infile_type);
	
	EXPORT fRelease				        := DATASET('~thor_data400::base::BKMortgage::Release',
																			BKMortgage.Layouts.ReleaseBase,THOR,OPT);

//File manually created from spreadsheet provided by Black Knight
 EXPORT codes_table 		 := DATASET(fileprefix + 'thor_data400::in::BKForeclosure::codes',
																BKForeclosure.layout_BK.CodeTable,CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR(['\n','\r','\r\n'])));
																
END;