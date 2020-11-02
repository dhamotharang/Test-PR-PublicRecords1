﻿EXPORT mac_ForceLink(

   pDataset                   = 'bipv2.commonbase.ds_base'
  ,pProxid_Underlink_file     = 'BIPV2_ForceLink.files.Proxid_Underlink'  //{proxid ,integer underlinkid}.  also can be 'BIPV2_Proxid.ManualUnderLinks.dataIn_file'
  ,pLgid3_Underlink_file      = 'BIPV2_ForceLink.files.Lgid3_Underlink'   //{lgid3  ,integer underlinkid}.  also can be 'BIPV2_LGID3.ManualUnderLinks.dataIn_file'
  ,pProxidExtraResearchFields = '\'cnp_name,prim_range,prim_name,v_city_name,st\''    //optional fields to use to unique on so you can see a better representation of patched clusters.
  ,pLgid3ExtraResearchFields  = '\'cnp_name,prim_range,prim_name,v_city_name,st\''    //optional fields to use to unique on so you can see a better representation of patched clusters.
  ,pOutputDebug               = 'true'
) :=
functionmacro

  ds_patch_underlinked_proxids := BIPV2_ForceLink.mac_ForceLink_Proxid(pDataset                     ,pProxid_Underlink_file ,pProxidExtraResearchFields ,pOutputDebug);
  ds_patch_underlinked_lgid3s  := BIPV2_ForceLink.mac_ForceLink_Lgid3(ds_patch_underlinked_proxids  ,pLgid3_Underlink_file  ,pLgid3ExtraResearchFields  ,pOutputDebug);  

  return ds_patch_underlinked_lgid3s;

endmacro;