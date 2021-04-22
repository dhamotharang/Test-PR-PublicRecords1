IMPORT $;

EXPORT key_ssn_taxid := INDEX(
  {$.layouts.i_ssn_taxid.ssn_taxid,$.layouts.i_ssn_taxid.tax_type}, 
  $.layouts.i_ssn_taxid, 
  $.names().i_ssn_taxid);
