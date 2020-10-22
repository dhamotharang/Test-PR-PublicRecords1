import ut,roxiekeybuild,promotesupers;

roxiekeybuild.Mac_SK_Move('~thor_data400::key::baddids','Q',a)
roxiekeybuild.Mac_SK_Move('~thor_data400::key::annotated_names','Q',b)
roxiekeybuild.Mac_SK_Move('~thor_data400::key::patriot_file_full','Q',c)
roxiekeybuild.Mac_SK_Move('~thor_data400::maltemp::key::patriot','Q',d)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::patriot_did_file','Q',e)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::patriot_bdid_file','Q',f)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::patriot_key','Q',g)
promotesupers.Mac_SK_Move_v2('~thor_data400::key::patriot::Baddies_with_name','Q',h)
promotesupers.Mac_SK_Move_v2('~thor_Data400::key::patriot_phoneticnames','Q',i,2);

// DF-28226 Move delta_rid key to QA
promotesupers.Mac_SK_Move_v2('~thor_data400::key::patriot_file::delta_rid','Q',j,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::baddids::delta_rid','Q',k,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::annotated_names::delta_rid','Q',l,2);

export Proc_Accept_SK_To_QA := parallel(a,b,c,/*d,*/e,f,g,h,i,j,k,l);
