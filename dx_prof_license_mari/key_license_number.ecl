IMPORT $;

EXPORT key_license_number := INDEX(
  {$.layouts.i_license_number.cln_license_nbr, $.layouts.i_license_number.license_state}, 
  $.layouts.i_license_number, $.names().i_license_number);
