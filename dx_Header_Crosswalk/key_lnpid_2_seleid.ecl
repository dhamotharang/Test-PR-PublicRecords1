IMPORT dx_Header_Crosswalk;

EXPORT key_lnpid_2_seleid := INDEX(
  {dx_Header_Crosswalk.Layouts.lnpid_2_seleid.lnpid},
  dx_Header_Crosswalk.Layouts.lnpid_2_seleid,
  dx_Header_Crosswalk.Names.str_lnpid_2_seleid
);