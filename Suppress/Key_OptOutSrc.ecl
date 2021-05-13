IMPORT $, data_services;

rec := Suppress.Layout_OptOut;
dops_dataset := 'SuppressOptOutKeys';
string prefix := data_services.Data_location.Prefix();

// @version@ is replaced by dops version (or default QA) in file_version.get_file()   
fname(boolean isFCRA) := IF (isFCRA,
    prefix + 'thor::key::new_suppression::fcra::@version@::opt_out',
    prefix + 'thor::key::new_suppression::@version@::opt_out');

//This code is not working in ThorDev 
//key_name(boolean isFCRA) := $.file_version(isFCRA).get_file(dops_dataset, fname(isFCRA));
key_name(boolean isFCRA) :=  '~foreign::10.173.44.105::thor::key::new_suppression::qa::opt_out';

EXPORT Key_OptOutSrc(boolean isFCRA = false) := INDEX({rec.lexid}, rec, key_name(isFCRA), OPT);
/* This is not yet implemented in ThorProd, commenting to use code above
EXPORT Key_OptOutSrc(integer d_env = data_services.data_env.iNonFCRA) := 
  INDEX({rec.lexid}, rec,  key_name(data_services.data_env.isFCRA(d_env)));
*/