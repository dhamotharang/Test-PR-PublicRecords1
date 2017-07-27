export ApprissKeys := macro
output(choosen(Appriss.Key_AgencyOri_StateCd,10));
output(choosen(Appriss.Key_ap_SSN,10));
output(choosen(Appriss.Key_Booking,10));
output(choosen(Appriss.key_charges,10));
output(choosen(Appriss.Key_demographic,10));
output(choosen(Appriss.Key_did,10));
output(choosen(Appriss.Key_DL,10));
output(choosen(Appriss.Key_FBI,10));
output(choosen(Appriss.Key_Gang,10));
output(choosen(Appriss.Key_state_id,10));
output(choosen(Appriss.Key_Appriss_Autokey_Payload,10));
output(choosen(autokey.key_address('~thor_200::key::appriss::autokey::qa::'),10));
output(choosen(autokey.key_citystname('~thor_200::key::appriss::autokey::qa::'),10));
output(choosen(autokey.key_name('~thor_200::key::appriss::autokey::qa::'),10));
output(choosen(autokey.key_zip('~thor_200::key::appriss::autokey::qa::'),10));
output(choosen(autokey.key_stname('~thor_200::key::appriss::autokey::qa::'),10));
output(choosen(autokey.Key_SSN2('~thor_200::key::appriss::autokey::qa::'),10));
output(choosen(autokey.key_phone2('~thor_200::key::appriss::autokey::qa::'),10));

endmacro;