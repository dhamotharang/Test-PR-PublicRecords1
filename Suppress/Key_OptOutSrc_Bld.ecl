IMPORT data_services;
EXPORT Key_OptOutSrc_Bld(boolean isFCRA = false) := FUNCTION
	//CCPA-120 - CCPA Opt Out key
	//This key is built from base file
	ds 				:= IF(isFCRA, Suppress.File_OptOut_Base_FCRA, Suppress.File_OptOut_Base);
	// DF-26857 Suppress current record only
	ds_prep			:= PROJECT(ds(domain_id=$.Constants.Exemptions().Domain_Id_PR and entry_type='OPTOUT' and history_flag='' and act_id<>'' and LEXID<>0), Suppress.Layout_OptOut);
	lfn 			:= IF(isFCRA,data_services.Data_location.Prefix()+'thor::key::new_suppression::fcra::qa::opt_out',
	                       data_services.Data_location.Prefix()+'thor::key::new_suppression::qa::opt_out');
	key := INDEX(ds_prep, {lexid}, {ds_prep}, lfn);
	RETURN key;
	
END;