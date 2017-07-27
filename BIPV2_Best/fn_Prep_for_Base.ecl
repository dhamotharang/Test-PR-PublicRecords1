import BIPV2_Best_Proxid, BIPV2_Best_Seleid,Census_Data, BIPv2_HRCHY, BIPV2, ut;
layfips         := recordof(Census_Data.File_Fips2County);

EXPORT fn_Prep_for_Base( 
   dataset(BIPV2_Best_Proxid.Layout_Base                                ) pInBase           = BIPV2_Best_Proxid.In_Base
  ,dataset(BIPV2_Best_Seleid.Layout_Base                                ) sInBase           = BIPV2_Best_Seleid.In_Base
  ,dataset(recordof(BIPV2_Best_Proxid.best(pInBase).BestBy_proxid_child)) pBestChildProxid  = BIPV2_Best_Proxid.best(pInBase).BestBy_proxid_child
  ,dataset(recordof(BIPV2_Best_Seleid.best(sInBase).BestBy_seleid_child)) pBestChildSeleid  = BIPV2_Best_Seleid.best(sInBase).BestBy_seleid_child
  ,dataset(BIPv2_HRCHY.Layouts.HrchyBase                                ) pHrchyBase        = project(BIPV2.CommonBase.DS_CLEAN,BIPv2_HRCHY.Layouts.HrchyBase)
  ,dataset(layfips                                                      ) pFips2County      = Census_Data.file_Fips2County
) := 
function

  Best_proxid := BIPV2_Best.fn_Append_After_Best(proxid, pBestChildProxid, pHrchyBase, pFips2County);

  Best_seleid := BIPV2_Best.fn_Append_After_Best(seleid, pBestChildSeleid, pHrchyBase, pFips2County);

  Best_seleid_set_proxid := project(Best_seleid, transform(BIPV2_Best.Layouts.Base,
                                                           self.proxid := 0,
                                                           self := left));
  Final_best_Base := Best_proxid + Best_seleid_set_proxid;
  return Final_best_Base;
	
  
end;