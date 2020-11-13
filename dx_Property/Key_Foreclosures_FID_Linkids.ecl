IMPORT $;

// ---------------------------------------------------------------
// For delta rollup logic use: $.key_foreclosure_delta_rid
// ---------------------------------------------------------------

inFile := $.Layouts.i_FID_Linkids;

EXPORT Key_Foreclosures_FID_Linkids := INDEX(
  {inFile.fid},
  {inFile}, 
  $.names().i_foreclosure_fid_linkid
  );

