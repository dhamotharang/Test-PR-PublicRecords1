EXPORT Constants := MODULE
	
	EXPORT Non_CRU_DataSource := ['FLAcc','eCrash','EN','FS']; 
	
	EXPORT Restricted_States := ['RI'];
END;

// export str_flacc                 := 'FLAcc';
// export str_ecrash                := 'eCrash';  => this has both eCrash and CRU. If report_code = EA and work_type_id = 2 or 3 then its CRU data else it is eCrash data. 
// export str_natlacc               := 'NatlAcc';   => CRU 
// export str_natlaccinq            := 'NatlAcc-Inq'; => CRU inq 
// export str_both_sources          := 'NatlAcc + NatlAcc-Inq'; = CRU 
// export str_en                    := 'EN';
// export str_fs                    := 'FS';

