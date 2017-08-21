import driversv2,crim_common;

dl_all := driversv2.File_Dl;
dl:= distribute(dl_all(did<>0 and zip5 in ['33069', '33072', '33093']),hash((integer) did));

cr_all := distribute(crim_common.File_Crim_Offender2_Plus((integer) did<>0),hash((integer) did));

layout_dl_plus_cr := record
driversv2.file_dl;
string1 cr_flag;
end;

layout_dl_plus_cr trans_add_cr(dl l,cr_all r) := transform
self := l;
self.cr_flag := if(r.lname<>'','Y','N');
end;

dl_plus_cr := join(dl,cr_all,(integer) left.did= (integer) right.did, trans_add_cr(left,right),left outer,local);

output(dl_plus_cr,,'~thor_data400::bvh::bso_20070816_dl',overwrite);

