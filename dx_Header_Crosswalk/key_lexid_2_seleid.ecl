IMPORT dx_Header_Crosswalk;

EXPORT key_lexid_2_seleid := INDEX(
  {dx_Header_Crosswalk.Layouts.lexid_2_seleid.lexid},
  dx_Header_Crosswalk.Layouts.lexid_2_seleid,
  dx_Header_Crosswalk.Names.str_lexid_2_seleid
);