IMPORT $;

EXPORT key_regulatory_actions := INDEX(
  {$.layouts.i_regulatory_actions.NMLS_ID,$.layouts.i_regulatory_actions.AFFIL_TYPE_CD}, 
  $.layouts.i_regulatory_actions, 
  $.names().i_regulatory_actions);
