IMPORT dx_Header_Crosswalk;

EXPORT key_lexid_2_lnpid := INDEX(
  {dx_Header_Crosswalk.Layouts.lexid_2_lnpid.lexid},
  dx_Header_Crosswalk.Layouts.lexid_2_lnpid,
  dx_Header_Crosswalk.Names.str_lexid_2_lnpid
);