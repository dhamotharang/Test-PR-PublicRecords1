IMPORT Data_Services, ut;
EXPORT File_BK_Foreclosure := MODULE

 Export Reo_Update       := DATASET('~thor_data400::in::BKForeclosure::update_reo',
                                BKForeclosure.layout_BK.reo_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 EXPORT Nod_Update       := DATASET('~thor_data400::in::BKForeclosure::update_nod',
                                BKForeclosure.layout_BK.nod_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));

 EXPORT Nod_Delete       := DATASET('~thor_data400::in::BKForeclosure::delete_nod',
                                BKForeclosure.layout_BK.Delete_Nod, THOR);

 EXPORT Reo_Delete       := DATASET('~thor_data400::in::BKForeclosure::delete_reo',
                                BKForeclosure.layout_BK.Delete_Reo,THOR);
 							
 Export Reo_Refresh_Ref  := DATASET('~thor_data400::in::BKForeclosure::refresh_reo',
                                BKForeclosure.layout_BK.reo_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 EXPORT Reo_Orphan_Ref   := DATASET('~thor_data400::in::BKForeclosure::refresh_reo_orphan',
                                BKForeclosure.layout_BK.reo_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 Export Nod_Refresh_Ref  := DATASET('~thor_data400::in::BKForeclosure::refresh_nod',
                                BKForeclosure.layout_BK.nod_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 EXPORT Nod_Orphan_Ref   := DATASET('~thor_data400::in::BKForeclosure::refresh_nod_orphan',
                                BKForeclosure.layout_BK.nod_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 
 EXPORT NOD_Refresh  := Nod_Refresh_Ref + Nod_Orphan_Ref;
 EXPORT REO_Refresh  := Reo_Refresh_Ref + Reo_Orphan_Ref;							
 // EXPORT Reo_File_used    := DATASET('~thor_data400::in::BKForeclosure::reo_infile::used',
                                // BKForeclosure.layout_BK.reo,THOR);
 // EXPORT Nod_File_used    := DATASET('~thor_data400::in::BKForeclosure::nod_infile::used',
                                // BKForeclosure.layout_BK.nod,THOR);

 EXPORT Reo_File         := DATASET('~thor_data400::in::BKForeclosure::reo_infile',
                                BKForeclosure.layout_BK.reo_in,THOR);
 EXPORT Nod_File         := DATASET('~thor_data400::in::BKForeclosure::nod_infile',
                                BKForeclosure.layout_BK.nod_in,THOR);
																
 EXPORT fNod             := DATASET('~thor_data400::base::BKForeclosure::Nod',
                                BKForeclosure.layout_BK.base_nod,THOR,OPT);
 EXPORT fReo             := DATASET('~thor_data400::base::BKForeclosure::Reo',
                                BKForeclosure.layout_BK.base_reo,THOR,OPT);	

//File manually created from spreadsheet provided by Black Knight
 EXPORT codes_table 		 := DATASET('~thor_data400::in::BKForeclosure::codes',
																BKForeclosure.layout_BK.CodeTable,CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR(['\n','\r','\r\n'])));
	
END;
