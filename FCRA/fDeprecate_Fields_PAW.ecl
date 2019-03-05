IMPORT ut, FCRA, PAW;

EXPORT fDeprecate_Fields_PAW(DATASET(FCRA.Layout_Override_PAW)  pPAWBase) := FUNCTION
        
     // DF- - Blank out fields in FCRA file thor_data400::key::override::fcra::paw::qa::ffid
     fields_to_clear  := 'company_department,company_fein,dead_flag,dppa_state,title';
                      
     ut.MAC_CLEAR_FIELDS(pPAWBase, dBase_FilterFCRA, fields_to_clear);
     dBase := DEDUP(dBase_FilterFCRA);
     
		RETURN(dBase); 

END;	