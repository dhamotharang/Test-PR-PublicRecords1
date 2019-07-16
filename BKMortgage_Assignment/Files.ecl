IMPORT $, BKForeclosure, Data_Services, ut;
EXPORT Files(BOOLEAN	pUseProd	=	TRUE) := MODULE

 SHARED fileprefix	:= IF(pUseProd, data_services.foreign_prod, '~'); 

 EXPORT Assignment_Update_in     := DATASET(fileprefix + 'thor_data400::in::BKMortgage::Update_Assignment',
																					BKMortgage_Assignment.Layouts.Raw_out,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 EXPORT Assignment_Orphan_Update := DATASET(fileprefix + 'thor_data400::in::BKMortgage::Update_Assignment_orphan',
																					BKMortgage_Assignment.Layouts.Raw_out,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));

 EXPORT Assignment_Delete       := DATASET(fileprefix + 'thor_data400::in::BKMortgage::delete_Assignment',
																					BKMortgage_Assignment.Layouts.Delete_Rec,THOR);
 							
 EXPORT Assignment_Refresh_Ref  := DATASET(fileprefix + 'thor_data400::in::BKMortgage::refresh_Assignment',
																					BKMortgage_Assignment.Layouts.Raw_out,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 EXPORT Assignment_Orphan_Ref   := DATASET(fileprefix + 'thor_data400::in::BKMortgage::refresh_Assignment_orphan',
																					BKMortgage_Assignment.Layouts.Raw_out,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 
 EXPORT Assignment_Refresh  := Assignment_Refresh_Ref + Assignment_Orphan_Ref;
 EXPORT Assignment_Update	  := Assignment_Update_in + Assignment_Orphan_Update;
																
 EXPORT fAssignUpdate         := DATASET('~thor_data400::base::BKMortgage::Assignment_update',
																			BKMortgage_Assignment.Layouts.base,THOR,OPT);
																			
 EXPORT fAssignRefresh        := DATASET('~thor_data400::base::BKMortgage::Assignment_refresh',
																			BKMortgage_Assignment.Layouts.base,THOR,OPT);

//File manually created from spreadsheet provided by Black Knight
 EXPORT codes_table 		 := DATASET(fileprefix + 'thor_data400::in::BKForeclosure::codes',
																BKForeclosure.layout_BK.CodeTable,CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR(['\n','\r','\r\n'])));
	
END;
