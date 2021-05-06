IMPORT dx_Header_Crosswalk;

EXPORT key_lnpid_2_lexid := INDEX(
  {dx_Header_Crosswalk.Layouts.lnpid_2_lexid.lnpid},
  dx_Header_Crosswalk.Layouts.lnpid_2_lexid,
  dx_Header_Crosswalk.Names.str_lnpid_2_lexid
);