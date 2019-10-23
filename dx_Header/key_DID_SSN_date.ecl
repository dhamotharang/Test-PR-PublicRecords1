IMPORT data_services;
IMPORT $;

rec := $.layouts.i_did_ssn_date;

fname (integer data_category) := IF (data_category = data_services.data_env.iFCRA,
                                     $.names().i_did_ssn_date_fcra,
                                     $.names().i_did_ssn_date); 

EXPORT key_DID_SSN_date (integer data_category = 0) :=  
         INDEX ({rec.did, rec.ssn}, {rec.best_date}, fname (data_category));

