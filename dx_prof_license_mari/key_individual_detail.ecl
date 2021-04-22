IMPORT $;

EXPORT key_individual_detail := INDEX({$.layouts.i_individual_detail.INDIVIDUAL_NMLS_ID}, 
  $.layouts.i_individual_detail, $.names().i_individual_detail);
