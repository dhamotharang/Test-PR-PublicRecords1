IMPORT data_services;

//CCPA-120 - CCPA Opt Out key
rec 					:= Suppress.Layout_OptOut;
lfn 					:= data_services.Data_location.Prefix()+'thor::key::new_suppression::qa::opt_out';
lfn_fcra 	:= data_services.Data_location.Prefix()+'thor::key::new_suppression::fcra::qa::opt_out';

EXPORT Key_OptOutSrc(boolean isFCRA = false) := INDEX({rec.lexid}, rec, IF(isFCRA,lfn_fcra,lfn), OPT);	
