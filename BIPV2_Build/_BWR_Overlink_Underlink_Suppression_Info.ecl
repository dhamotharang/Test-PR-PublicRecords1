/*
  Overlinks:
    BIPV2_BlockLink._BWR_LGID3_BlockLink                          -- will do a blocklink on lgid3s.   This splits up the lgid3 into two, preventing it from coming back together.  Only use if cluster is two distinct entities.
    BIPV2_BlockLink._BWR_Proxid_BlockLink                         -- will do a blocklink on Proxids.  This splits up the Proxid into two, preventing it from coming back together.  Only use if cluster is two distinct entities.
    BIPV2_Build._BWR_Reset_Overlinked_Clusters                    -- use to reset clusters that are overlinked and consists of more than two entities.  if the cluster needs to be broken up into more than two, use this instead of blocklink.
                                                                     this has a transform that also allows you to blank out any offending fields that are causing the overlinking such as bad feins from D&B Fein.
    BIPV2_Field_Suppression._BWR_Add_Candidates                   -- Add candidates to custom Suppression/Explosion file.  Will work for all clusters/fields.
    BIPV2_Field_Suppression._BWR_Remove_Candidates                -- Remove Candidates from custome suppression/explosion file.
    BIPV2_Field_Suppression._BWR_Initialize_Suppression_Counter   -- initialize suppression counter for suppression file to zero.  This make the next suppression call using this file explode the clusters too.
    BIPV2_Field_Suppression._BWR_Increment_Suppression_Counter    -- increment the suppression counter in the suppression file + 1.  This will make the next suppression call not explode the clusters.
    BIPV2_Field_Suppression._BWR_Decrement_Suppression_Counter    -- decrement the suppression counter in the suppression file - 1.  This will basically return the suppression back to before the last call of it.  
                                                                      Good for rollbacks where you need to rerun the code that calls the suppression.
    BIPV2_Field_Suppression.mac_Suppress                          -- Suppression macro call.  Will need to modify this to add fields/context/id fields if we add new fields to the suppression file.
                                                                     Future improvement is to generate the code from the suppression file to call this macro.
  Underlinks:
    BIPV2.BWR_ManualUnderlinks                  -- force lgid3s or proxids together.  uses UnderLinks attribute file, so this will only work if both lgid3s/proxids are in the lgid3/proxid Match Candidates.
    BIPV2_ForceLink._BWR_Add_Candidates         -- Add Forcelink Candidates.  Outside of SALT.
    BIPV2_ForceLink._BWR_Remove_Candidates      -- Remove ForceLink Candidates(Just removes them from the forcelink file, does not explode clusters)
    BIPV2_ForceLink._BWR_Test_ForceLink         -- Test Forcelink(This will show you a deduped version of clusters to be forcelinked to get an idea if it looks right before going into the build).

  Suppression:
    BIPV2.BWR_ManualSuppression                 -- suppress records from output keys in the kfetch(example here: BIPV2_Suppression.BWR_Test).
    BIPV2_Suppression.BWR_ManualSuppression     -- adds seleid, proxid pairs to the suppression key, updates BIPV2SuppressionKeys in DOPS.  this can suppress proxids in queries.

    BIPV2_Field_Suppression._BWR_Add_Candidates                   -- Add candidates to custom Suppression/Explosion file.  Will work for all clusters/fields.
    BIPV2_Field_Suppression._BWR_Remove_Candidates                -- Remove Candidates from custome suppression/explosion file.
    BIPV2_Field_Suppression._BWR_Initialize_Suppression_Counter   -- initialize suppression counter for suppression file to zero.  This make the next suppression call using this file explode the clusters too.
    BIPV2_Field_Suppression._BWR_Increment_Suppression_Counter    -- increment the suppression counter in the suppression file + 1.  This will make the next suppression call not explode the clusters.
    BIPV2_Field_Suppression._BWR_Decrement_Suppression_Counter    -- decrement the suppression counter in the suppression file - 1.  This will basically return the suppression back to before the last call of it.  
                                                                      Good for rollbacks where you need to rerun the code that calls the suppression.
    BIPV2_Field_Suppression.mac_Suppress                          -- Suppression macro call.  Will need to modify this to add fields/context/id fields if we add new fields to the suppression file.
                                                                     Future improvement is to generate the code from the suppression file to call this macro.
    
  Thor Research Tools:
    BIPV2_Tools.mac_How_Did_This_Link           -- use to examine in detail a proxid/lgid3/seleid.  if a seleid consists of multiple lgid3s, then that seleid was set by hierarchy.
                                                  u can usually see if two company names are linked directly by fein/duns/corpkey/sbfe_id.  if not, it could be through transitive closure of one of those fields.
                                                  or you might be able to see if one of those fields' values is bad, such as an fein of '999999999' or something like that.
    BIPV2_ProxID._fun_CompareService            -- the proxid compare service uses this function.  u can specify the version of the proxid keys used and also the environment, so it is a little more flexible than the service.
    BIPV2_LGID3._fn_CompareService              -- the lgid3 compare service uses this function.  u can specify the version of the lgid3 keys used, so it is a little more flexible than the service

  Doxie Research Tools:
    bipv2_tools.how_did_this_link_service       -- http://prod_esp.br.seisint.com:8002/WsEcl/forms/ecl/query/hthor_eclcc/bipv2_tools.how_did_this_link_service 
    lgid3 compare service                       -- http://prod_esp.br.seisint.com:8002/WsEcl/forms/ecl/query/hthor_eclcc/bipv2_lgid3.lgid3compareservice___
    proxid compare service                      -- http://prod_esp.br.seisint.com:8002/WsEcl/forms/ecl/query/hthor_eclcc/bipv2_proxid.proxidcompareservice
    hrchy shows proxid hierarchy                -- http://prod_esp.br.seisint.com:8002/WsEcl/forms/ecl/query/hthor_eclcc/bipv2_hrchy.showservice   396292 is an interesting one.


  Missing:
    We need a research tool for hierarchy so we can understand why lgid3s clustered into seleids.  right now, this is basically a blank box.
    the proxid hrchy service is ok, but it would be nice to see that for lgid3s, and what source was used in the hierarchy, and what data such as duns/ent numbers, etc.
    looks like we can get the source, but it would be nice the have the actual values for duns_number used, etc.

*/