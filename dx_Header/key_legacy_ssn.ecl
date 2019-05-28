IMPORT data_services;
IMPORT $;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_legacy_ssn_fcra,
                                     $.names().i_legacy_ssn); 

EXPORT key_legacy_ssn (integer data_category = 0) := 
         INDEX ($.layouts.i_legacy_ssn, fname(data_category), OPT);
