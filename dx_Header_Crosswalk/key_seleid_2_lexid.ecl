IMPORT dx_Header_Crosswalk;

EXPORT key_seleid_2_lexid := INDEX(
  {dx_Header_Crosswalk.Layouts.seleid_2_lexid.seleid},
  dx_Header_Crosswalk.Layouts.seleid_2_lexid,
  dx_Header_Crosswalk.Names.str_seleid_2_lexid
);