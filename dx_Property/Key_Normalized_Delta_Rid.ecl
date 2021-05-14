IMPORT $;

inFile := $.Layouts.i_Delta_Rid;

// this is the main basefile/rid key used for DID/BDID and autokeys

EXPORT Key_Normalized_Delta_Rid := INDEX(
  {inFile.record_sid},
  {inFile}, 
  $.names().i_normalized_delta_rid
  );
