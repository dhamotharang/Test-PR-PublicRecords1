
import vehlic,driversv2;

my_vf2i := dataset('~thor_data400::bvh::bso_20070816_vf2',VehLic.Layout_Vehicles,flat);
my_vf2 := my_vf2i(history in ['E',' ']);
layout_did := record
string12 did;
end;
layout_did normalize_did(my_vf2 l,integer c) := transform
self.did := choose(c,l.own_1_did,l.own_2_did,l.reg_1_did,l.reg_2_did);
end;
my_vf2_dids:= distribute(normalize(my_vf2,4,normalize_did(left,counter)),hash((integer) did));


layout_dl_plus_cr := record
driversv2.file_dl;
string1 cr_flag;
end;
my_dl_plus_cr := distribute(dataset('~thor_data400::bvh::bso_20070816_dl',layout_dl_plus_cr,flat),hash((integer) did));

//output(my_vf2_dids((integer) did<>0));
//output(my_dl_plus_cr((integer) did<>0));

layout_dl_plus_vf2 := record
layout_dl_plus_cr;
string1 vf_flag;
end;

layout_dl_plus_vf2 trans_add_vf2(my_dl_plus_cr l,my_vf2_dids r) := transform
self := l;
self.vf_flag := if((integer) r.did<>0 ,'Y','N');
end;

dl_plus_vf2_j := join(my_dl_plus_cr((integer) did<>0),my_vf2_dids((integer) did<>0),(integer) left.did= (integer) right.did, trans_add_vf2(left,right),left outer,local);
dl_plus_vf2 := dedup(sort(dl_plus_vf2_j,did,lic_issue_date,local),did);

bwmv := dl_plus_vf2((race='w' or race='B') and sex_flag='M' and  vf_flag='Y');
wmcv := dl_plus_vf2(race='W' and sex_flag='M' and cr_flag='Y' and vf_flag='Y');
bmcv := dl_plus_vf2(race='B' and sex_flag='M' and cr_flag='Y' and vf_flag='Y');
bfv  := dl_plus_vf2(race='B' and sex_flag='F' and vf_flag='Y');

/*
output(bwmv,,'~thor_data400::bvh::bso_20070816_bw_m_v',csv,overwrite);
output(wmcv,,'~thor_data400::bvh::bso_20070816_w_m_cv',csv,overwrite);
output(bmcv,,'~thor_data400::bvh::bso_20070816_b_m_cv',csv,overwrite);
output(bfv,, '~thor_data400::bvh::bso_20070816_b_f_v',csv,overwrite);
*/

output(choosen(bwmv,1000));
output(choosen(wmcv,1000));
output(choosen(bmcv,1000));
output(choosen(bfv,1000));