// Marketing_List.Build_All(pDebug := true,pSampleProxids := [72439041]); // runs whole build, filtering each intermediate dataset for the pSampleProxids so you can see how it progresses through the build.  good for debugging logic
  
set_debug_proxids := [72439041];

ds_biz     := Marketing_List.Create_Business_Information_File (           pDebug := true  ,pSampleProxids := set_debug_proxids);
ds_contact := Marketing_List.Create_Business_Contact_File     (,,ds_biz  ,pDebug := true  ,pSampleProxids := set_debug_proxids);

output(choosen(ds_biz      ,100) ,named('ds_biz'    ));
output(choosen(ds_contact  ,100) ,named('ds_contact'));