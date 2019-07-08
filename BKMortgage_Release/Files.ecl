IMPORT $, Data_Services, ut;

EXPORT Files(BOOLEAN	pUseProd	=	TRUE) := MODULE

	SHARED fileprefix	:= IF(pUseProd, data_services.foreign_prod, '~'); 

	EXPORT Release_Update_in    	:= DATASET(fileprefix + 'thor_data400::in::BKMortgage::Update_Release',
																					BKMortgage_Release.Layouts.Raw_out,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
	EXPORT Release_Orphan_Update  := DATASET(fileprefix + 'thor_data400::in::BKMortgage::Update_Release_orphan',
																					BKMortgage_Release.Layouts.Raw_out,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));

	EXPORT Release_Delete       	:= DATASET(fileprefix + 'thor_data400::in::BKMortgage::delete_Release',
																					BKMortgage_Release.Layouts.Delete_Rec,THOR);
																					
	EXPORT Release_Refresh_Ref  	:= DATASET(fileprefix + 'thor_data400::in::BKMortgage::refresh_Release',
																					BKMortgage_Release.Layouts.Raw_out,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
	EXPORT Release_Orphan_Ref   	:= DATASET(fileprefix + 'thor_data400::in::BKMortgage::refresh_Release_orphan',
																					BKMortgage_Release.Layouts.Raw_out,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
																					
	EXPORT Release_Refresh  			:= Release_Refresh_Ref + Release_Orphan_Ref;
	EXPORT Release_Update  				:= Release_Update_in + Release_Orphan_Update;
	
	EXPORT fReleaseRefresh       := DATASET('~thor_data400::base::BKMortgage::Release_refresh',
																			BKMortgage_Release.Layouts.base,THOR,OPT);
	EXPORT fReleaseUpdate        := DATASET('~thor_data400::base::BKMortgage::Release_update',
																			BKMortgage_Release.Layouts.base,THOR,OPT);
																			
END;
