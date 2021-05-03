EXPORT mac_ForceLink_Proxid(

   pDataset             = 'bipv2.commonbase.ds_base'                            
  ,pUnderlink_file      = 'BIPV2_ForceLink.files.Proxid_Underlink'              // -- {proxid, integer underlinkid ,string date_added ,string userid  ,string comment}.  
  ,pExtraResearchFields = '\'cnp_name,prim_range,prim_name,v_city_name,st\''    // -- optional fields to use to unique on so you can see a better representation of clusters.
  ,pOutputDebug         = 'true'                                                // -- do debug outputs
  ,pID                  = 'proxid'                                              // --                                                                          

) := 
functionmacro

  import BIPV2,LinkingTools;

  forcelink_proxid := LinkingTools.mac_ForceLink(pDataset ,pID  ,pUnderlink_file  ,pExtraResearchFields ,pOutputDebug);
  
  return forcelink_proxid;
  
endmacro;