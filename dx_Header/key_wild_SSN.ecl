IMPORT data_services, autokey;
IMPORT $;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_wild_ssn_fcra,
                                     $.names().i_wild_ssn);

EXPORT key_wild_ssn (integer data_category = 0) := 
         INDEX (autokey.Layout_Wild_SSN, fname(data_category)); //TODO: OPT?
  
