IMPORT ut, FCRA, thrive;

EXPORT fDeprecate_Fields_Thrive(DATASET(FCRA.Layout_Override_thrive)  pThriveBase) := FUNCTION
        
     // DF- - Blank out fields in FCRA file thor_data400::key::override::fcra::thrive::qa::ffid
     fields_to_clear  := 'phone_work,phone_home,phone_cell,monthsemployed,own_home,is_military,drvlic_state,monthsatbank,ip,yrsthere,' +
                         'besttime,credit,loanamt,loantype,ratetype,mortrate,ltv,propertytype,datecollected,title,fips_st,fips_county,' +
                         'clean_phone_work,clean_phone_home,clean_phone_cell';
                      
     ut.MAC_CLEAR_FIELDS(pThriveBase, dBase_FilterFCRA, fields_to_clear);
     dBase := DEDUP(dBase_FilterFCRA);
     
		RETURN(dBase); 

END;	