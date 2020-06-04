EXPORT proc_build_cnpname_slim (string filedate) := FUNCTION
 
filename:='~prte::key::bizlinkfull::' + filedate + '::proxid::refs::l_cnpname';

my_index := index({ 
 unsigned4 gss_hash;
  unsigned1 fallback_value;
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  string28 prim_name;
  string25 city;
  string2 st;
  string8 company_sic_code1;
  string30 cnp_number;
  string10 cnp_btype;
  string20 cnp_lowv;
  string10 prim_range;
  string8 sec_range;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  string1 sele_flag;
  string1 org_flag;
  string1 ult_flag;
  string5 zip;
  unsigned6 powid;
  unsigned2 gss_word_weight;
  string240 cnp_name;
  unsigned8 gss_bloom;
  unsigned1 prim_name_len;
  unsigned1 city_len;
  unsigned1 prim_range_len;
  unsigned1 sec_range_len;
  unsigned4 efr_bmap;
  integer2 prim_name_weight100;
  integer2 prim_name_e1_weight100;
  integer2 city_weight100;
  integer2 city_p_weight100;
  integer2 city_e2_weight100;
  integer2 city_e2p_weight100;
  integer2 st_weight100;
  integer2 company_sic_code1_weight100;
  integer2 cnp_number_weight100;
  integer2 cnp_btype_weight100;
  integer2 cnp_lowv_weight100;
  integer2 prim_range_weight100;
  integer2 prim_range_e1_weight100;
  integer2 sec_range_weight100;
  integer2 sec_range_e1_weight100;
  integer2 parent_proxid_weight100;
  integer2 sele_proxid_weight100;
  integer2 org_proxid_weight100;
  integer2 ultimate_proxid_weight100;
  integer2 sele_flag_weight100;
  integer2 org_flag_weight100;
  integer2 ult_flag_weight100;
  integer2 zip_weight100
 
  }, layouts.cnpname, filename);
	
x := dedup(project(my_index,layouts.cnpname_slim), record, all);
	
outKey := INDEX(x,
{ gss_hash;
  gss_bloom;
  fallback_value;
  ultid;
  orgid;
  seleid;
  proxid;
  gss_word_weight },{x},
'~prte::key::bizlinkfull::' + filedate + '::proxid::refs::l_cnpname_slim');

slim_out := BUILDindex(outkey);

return slim_out;
end;

	

	
	
	
	
	
	