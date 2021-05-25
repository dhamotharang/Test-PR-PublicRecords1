IMPORT $, data_services;

fname (integer data_category) := 
  IF (data_category = data_services.data_env.iFCRA,
    $.names().i_did_fcra,
    $.names().i_did); 

EXPORT key_did(integer data_category = 0) := INDEX({$.layouts.i_did.s_did}, 
  $.layouts.i_did, fname(data_category));

