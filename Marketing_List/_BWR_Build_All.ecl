// Marketing_List.Build_All('20191002');
// Marketing_List.proc_build_all('20191002');

/*
#workunit('name', Marketing_List._Config().name + ' 20191120 build');

#workunit('priority','high');
Marketing_List.Build_All('20191120'
,Marketing_List . Source_Files() . bip_best
,Marketing_List . Source_Files() . bip_base
,Marketing_List . Source_Files() . dca
,Marketing_List . Source_Files() . eq_biz
,Marketing_List . Source_Files() . oshair
,Marketing_List . Source_Files() . cortera
,Marketing_List . Source_Files() . infutor
,Marketing_List . Source_Files() . accutrend
,Marketing_List . Source_Files() . crosswalk
,Marketing_List . _Config() . ds_sources_of_number_of_employees
,Marketing_List . _Config() . ds_sources_of_sales_revenue
,Marketing_List . _Config() . Marketing_Bitmap
,Marketing_List . _Config() . set_marketing_approved_sources
,false
,[]
);

*/

/*
I am seeing there are duplicate person_hierarchy (so Chris and Jerry both have a 1 and then Kim, Troy and Alex all have 2) I am guessing this is not supposed to happen

*/
// Marketing_List.Build_All('20200501a_BH821'  ,pDebug := true,pSampleProxids := [35959]); // runs whole build, filtering each intermediate dataset for the pSampleProxids so you can see how it progresses through the build.  good for debugging logic
 
set_debug_proxids := [35959];

ds_biz     := Marketing_List.Create_Business_Information_File (            pDebug := true  ,pSampleProxids := set_debug_proxids  ,pQuickTest := true);
ds_contact := Marketing_List.Create_Business_Contact_File     (,,,ds_biz  ,pDebug := true  ,pSampleProxids := set_debug_proxids  ,pQuickTest := true);

output(choosen(ds_biz      ,100) ,named('ds_biz'    ));
output(choosen(ds_contact  ,100) ,named('ds_contact'));


// Marketing_List.Build_All('20200501a_BH821'); // runs whole build, filtering each intermediate dataset for the pSampleProxids so you can see how it progresses through the build.  good for debugging logic
