IMPORT data_services;

rec := Suppress.Layout_OptOut;
lfn := data_services.Data_location.Prefix()+'thor::key::new_suppression::qa::opt_out';
lfn_fcra 	:= data_services.Data_location.Prefix()+'thor::key::new_suppression::fcra::qa::opt_out';

EXPORT Key_OptOutSrc(integer d_env = data_services.data_env.iNonFCRA) := 
  INDEX({rec.lexid}, rec, IF(data_services.data_env.isFCRA(d_env), lfn_fcra, lfn));
