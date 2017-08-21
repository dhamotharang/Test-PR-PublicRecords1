IMPORT Data_Services, ut;
EXPORT File_BK_Foreclosure := MODULE

 Export Reo_Update       := DATASET('~thor_data400::in::BKForeclosure::update_reo::using',
                                BKForeclosure.layout_BK.reo,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 EXPORT Nod_Update       := DATASET('~thor_data400::in::BKForeclosure::update_nod::using',
                                BKForeclosure.layout_BK.nod,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));

 EXPORT Nod_Delete       := DATASET('~thor_data400::in::BKForeclosure::delete_nod::using',
                                BKForeclosure.layout_BK.Delete_Nod,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r\n','\n\r'])));

 EXPORT Reo_Delete       := DATASET('~thor_data400::in::BKForeclosure::delete_reo::using',
                                BKForeclosure.layout_BK.Delete_Reo,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r\n','\n\r'])));
 							
 Export Reo_Refresh_Ref  := DATASET('~thor_data400::in::BKForeclosure::refresh_reo_refresh::using',
                                BKForeclosure.layout_BK.reo,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 EXPORT Reo_Orphan_Ref   := DATASET('~thor_data400::in::BKForeclosure::refresh_reo_orphan::using',
                                BKForeclosure.layout_BK.reo,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 Export Nod_Refresh_Ref  := DATASET('~thor_data400::in::BKForeclosure::refresh_nod_refresh::using',
                                BKForeclosure.layout_BK.nod,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 EXPORT Nod_Orphan_Ref   := DATASET('~thor_data400::in::BKForeclosure::refresh_nod_orphan::using',
                                BKForeclosure.layout_BK.nod,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
 
 EXPORT NOD_Refresh  := Nod_Refresh_Ref + Nod_Orphan_Ref;
 EXPORT REO_Refresh  := Reo_Refresh_Ref + Reo_Orphan_Ref;							
 EXPORT Reo_File_used    := DATASET('~thor_data400::in::BKForeclosure::reo_infile::used',
                                BKForeclosure.layout_BK.reo,THOR);
 EXPORT Nod_File_used    := DATASET('~thor_data400::in::BKForeclosure::nod_infile::used',
                                BKForeclosure.layout_BK.nod,THOR);

 EXPORT Reo_File         := DATASET('~thor_data400::in::BKForeclosure::reo_infile::using',
                                BKForeclosure.layout_BK.reo,THOR);
 EXPORT Nod_File         := DATASET('~thor_data400::in::BKForeclosure::nod_infile::using',
                                BKForeclosure.layout_BK.nod,THOR);
																
 EXPORT fNod             := DATASET('~thor_data400::base::BKForeclosure_Nod',
                                BKForeclosure.layout_BK.base_nod,THOR);
 EXPORT fReo             := DATASET('~thor_data400::base::BKForeclosure_Reo',
                                BKForeclosure.layout_BK.base_reo,THOR);						
END;
