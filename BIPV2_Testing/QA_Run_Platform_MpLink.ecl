fn := '~thor_data400::bipv2::internal_linking::platform_mplink_test';

ds := dataset(fn, bipv2.CommonBase_mod.Layout_S40, thor);

ds_dataset    := distribute(table(ds,{rcid,lgid3,seleid})) : independent;							
countgroup    := count(ds_dataset);
  
pDid_Unique   := count(table(table(ds_dataset(lgid3 != 0),{unsigned6 lgid3 := lgid3}),
                             {lgid3},lgid3  ,merge));

output(countgroup);
output(pdid_unique);
