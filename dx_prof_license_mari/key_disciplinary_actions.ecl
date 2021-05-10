IMPORT $;

drecs := DATASET([], $.layouts.i_disciplinary_actions);

EXPORT key_disciplinary_actions := INDEX(drecs, 
  {INDIVIDUAL_NMLS_ID}, {drecs}, 
  $.names().i_disciplinary_actions);
