IMPORT $, data_services;

rec := Suppress.Layout_OptOut;
dops_dataset := 'SuppressOptOutKeys';
string prefix := data_services.Data_location.Prefix();

// @version@ is replaced by dops version (or default QA) in file_version.get_file()   
fname(boolean isFCRA) := IF (isFCRA,
    prefix + 'thor::key::new_suppression::fcra::@version@::opt_out',
    prefix + 'thor::key::new_suppression::@version@::opt_out');

key_name(boolean isFCRA) := $.file_version(isFCRA).get_file(dops_dataset, fname(isFCRA));

EXPORT Key_OptOutSrc(integer d_env = data_services.data_env.iNonFCRA) := 
  INDEX({rec.lexid}, rec,  key_name(data_services.data_env.isFCRA(d_env)));
