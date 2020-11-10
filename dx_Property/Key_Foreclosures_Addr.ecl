IMPORT $;

// ---------------------------------------------------------------
// For delta rollup logic use: $.key_foreclosure_delta_rid
// ---------------------------------------------------------------

inFile := $.Layouts.i_address;
              
EXPORT key_foreclosures_addr := INDEX(
  {inFile.situs1_zip,
  inFile.situs1_prim_range,
  inFile.situs1_prim_name,
  inFile.situs1_addr_suffix,
  inFile.situs1_predir},
  {inFile},
  $.names().i_foreclosure_addr
  );
