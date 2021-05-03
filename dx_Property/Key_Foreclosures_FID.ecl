IMPORT $;

// ---------------------------------------------------------------
// For delta rollup logic use: $.key_foreclosure_delta_rid
// ---------------------------------------------------------------

inFile := $.Layouts.i_FID;

EXPORT Key_Foreclosures_FID := INDEX(
  {inFile.fid},
  {inFile}, 
  $.names().i_foreclosure_fid
  );

