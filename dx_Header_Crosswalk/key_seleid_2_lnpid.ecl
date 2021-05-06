IMPORT dx_Header_Crosswalk;

EXPORT key_seleid_2_lnpid := INDEX(
  {dx_Header_Crosswalk.Layouts.seleid_2_lnpid.seleid},
  dx_Header_Crosswalk.Layouts.seleid_2_lnpid,
  dx_Header_Crosswalk.Names.str_seleid_2_lnpid
);