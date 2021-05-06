import ut;

ut.MAC_SK_Move('~thor_data400::key::baddids','Q',a)
ut.MAC_SK_Move('~thor_data400::key::annotated_names','Q',b)
ut.MAC_SK_Move('~thor_data400::key::patriot_file_full','Q',c)
ut.MAC_SK_Move('~thor_data400::maltemp::key::patriot','Q',d)
ut.MAC_SK_Move_v2('~thor_data400::key::patriot_did_file','Q',e)
ut.MAC_SK_Move_v2('~thor_data400::key::patriot_bdid_file','Q',f)
ut.MAC_SK_Move_v2('~thor_data400::key::patriot_key','Q',g)
ut.MAC_SK_Move_v2('~thor_data400::key::patriot::Baddies_with_name','Q',h)
ut.MAC_SK_Move_v2('~thor_Data400::key::patriot_phoneticnames','Q',i,2);

export Proc_Accept_SK_To_QA := parallel(a,b,c,/*d,*/e,f,g,h,i);
