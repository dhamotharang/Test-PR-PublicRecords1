IMPORT $;

keyed_fields := RECORD
  $.layouts.i_dob_fname.pf2;
  $.layouts.i_dob_fname.dob;
  $.layouts.i_dob_fname.pfname;
  $.layouts.i_dob_fname.st; 
  $.layouts.i_dob_fname.zip;
END;

EXPORT key_DOB_pfname (integer data_category = 0) :=  
         INDEX (keyed_fields, {$.layouts.i_dob_fname.did}, $.names().i_dob_pfname, OPT);

