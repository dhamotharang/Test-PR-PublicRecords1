ds_lntu_norm := dataset('~thor_dell400_2::base::File_LN_TU_Normalized_All_patched',ln_tu.Layout_Normalized,flat);

ln_tu.Layout_In_Header_UID_SRC t_slim(ds_lntu_norm le) := transform
 self := le;
end;

p_slim := project(ds_lntu_norm,t_slim(left));
count(p_slim);

p_slim_dist := distribute(p_slim,hash(uid));
p_slim_dupd := dedup(p_slim_dist,record,local);
count(p_slim_dupd);

output(p_slim_dupd,,'~thor_data400::base::ln_tu_as_source'+thorlib.wuid(),__compressed__);

//fileservices.createsuperfile('~thor_data400::base::ln_tu_as_source');