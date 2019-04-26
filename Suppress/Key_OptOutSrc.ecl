IMPORT data_services;

rec := Suppress.Layout_OptOut;
EXPORT Key_OptOutSrc(integer d_env = data_services.data_env.iNonFCRA) :=  
	INDEX({rec.lexid}, rec, data_services.Data_location.Prefix()+'thor::key::new_suppression::qa::opt_out', OPT);
