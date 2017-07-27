IMPORT Business_Header, ut;
#workunit ('name', 'Remove DPPA records from Business Header Output Files');

bc_init := Business_Header.File_Business_Contacts_Out;
bc_init_no_dppa := Business_Header.File_Business_Contacts_Out(DPPA_State = '');
emp_init := Business_Header.File_Employment_Out;
emp_init_no_dppa := business_Header.File_Employment_Out(DPPA_State = '');
bh_init := business_header.File_Business_Header_Out;
bh_init_nodppa := business_header.File_Business_Header_Out(DPPA_State = '');
bh_init_dppa := business_header.File_Business_Header_Out(DPPA_State != '');
bhb_init := business_header.File_Business_Header_Best_Out(DPPA_State = '');
bhb_init_nodppa := business_header.File_Business_Header_Best_Out;

bhs_init := business_header.File_Business_Header_Stats_Out;
br_init := business_header.File_Business_Relatives_Out;
brg_init := business_header.File_Business_Relatives_Group_Out;


bh_slim := record
bh_init_dppa.bdid;
end;

bh_dppa_bdids 	:= table(bh_init_dppa,bh_slim);
bh_slim_dist 	:= distribute(bh_dppa_bdids, 	hash(bdid));
bh_slim_sort 	:= sort(bh_slim_dist,  	bdid, local);
bh_slim_dedup 	:= dedup(bh_slim_sort, 	bdid, local);
output('Number of bdids with DPPA_State populated from bus header file : ' + count(bh_slim_dedup));
output(enth(bh_slim_dedup,1000), all) : success(output('List of bdids with DPPA_State populated'));

bh_slim getbdids(bh_init_nodppa L, bh_slim_dedup r) := transform
self := l;
end;

bh_slim_dist_nodppa 	:= distribute(bh_init_nodppa, 	hash(bdid));
bh_slim_sort_nodppa 	:= sort(bh_slim_dist_nodppa,  	bdid, local);

bh_filtered_bdids := join(bh_slim_sort_nodppa, bh_slim_dedup, left.bdid = right.bdid, getbdids(left,right), right only, local);
output('Number of DPPA only BDIDS filtered out from Bus headers: ' + count(bh_filtered_bdids));
output(enth(bh_filtered_bdids,1000), all) : success(output('List of DPPA only bdids'));


// filter out these bdids from the rest of the output files
bc_slim_dist_nodppa 	:= distribute(bc_init_no_dppa(bdid != ''), 	hash(bdid));
bc_slim_sort_nodppa 	:= sort(bc_slim_dist_nodppa,  	bdid, local);

bc_slim_sort_nodppa filterbc(bc_slim_sort_nodppa L, bh_filtered_bdids r) := transform
self := l;
end;
bc_final_filter := join(bc_slim_sort_nodppa, bh_slim_dedup, left.bdid = right.bdid, filterbc(left,right), left only, local) + bc_init_no_dppa(bdid = '');
/////////////////////////////////////////////////////////////////////////////////////////
emp_slim_dist_nodppa 	:= distribute(emp_init_no_dppa(bdid != ''), 	hash(bdid));
emp_slim_sort_nodppa 	:= sort(emp_slim_dist_nodppa,  	bdid, local);

emp_slim_sort_nodppa filteremp(emp_slim_sort_nodppa L, bh_filtered_bdids r) := transform
self := l;
end;
emp_final_filter := join(emp_slim_sort_nodppa, bh_slim_dedup, left.bdid = right.bdid, filteremp(left,right), left only, local) + emp_init_no_dppa(bdid = '');
/////////////////////////////////////////////////////////////////////////////////////////
bhb_slim_dist_nodppa 	:= distribute(bhb_init_nodppa, 	hash(bdid));
bhb_slim_sort_nodppa 	:= sort(bhb_slim_dist_nodppa,  	bdid, local);

bhb_slim_sort_nodppa filterbhb(bhb_slim_sort_nodppa L, bh_filtered_bdids r) := transform
self := l;
end;
bhb_final_filter := join(bhb_slim_sort_nodppa, bh_slim_dedup, left.bdid = right.bdid, filterbhb(left,right), left only, local);

/////////////////////////////////////////////////////////////////////////////////////////
bhs_slim_dist_nodppa 	:= distribute(bhs_init, 	hash(bdid));
bhs_slim_sort_nodppa 	:= sort(bhs_slim_dist_nodppa,  	bdid, local);

bhs_slim_sort_nodppa filterbhs(bhs_slim_sort_nodppa L, bh_filtered_bdids r) := transform
self := l;
end;
bhs_final_filter := join(bhs_slim_sort_nodppa, bh_slim_dedup, left.bdid = right.bdid, filterbhs(left,right), left only, local);

/////////////////////////////////////////////////////////////////////////////////////////
br_slim_dist_nodppa 	:= distribute(br_init, 	hash(bdid1));
br_slim_sort_nodppa 	:= sort(br_slim_dist_nodppa,  	bdid1, local);

br_slim_sort_nodppa filterbr(br_slim_sort_nodppa L, bh_filtered_bdids r) := transform
self := l;
end;
br_final_filter1 := join(br_slim_sort_nodppa, bh_slim_dedup, left.bdid1 = right.bdid, filterbr(left,right), left only, local);

br_slim_dist_nodppa2 	:= distribute(br_final_filter1, 	hash(bdid2));
br_slim_sort_nodppa2 	:= sort(br_slim_dist_nodppa2,  	bdid2, local);

br_slim_sort_nodppa2 filterbr2(br_slim_sort_nodppa2 L, bh_filtered_bdids r) := transform
self := l;
end;
br_final_filter2 := join(br_slim_sort_nodppa2, bh_slim_dedup, left.bdid2 = right.bdid, filterbr2(left,right), left only, local);

/////////////////////////////////////////////////////////////////////////////////////////
brg_slim_dist_nodppa 	:= distribute(brg_init, 	hash(bdid));
brg_slim_sort_nodppa 	:= sort(brg_slim_dist_nodppa,  	bdid, local);

brg_slim_sort_nodppa filterbrg(brg_slim_sort_nodppa L, bh_filtered_bdids r) := transform
self := l;
end;
brg_final_filter := join(brg_slim_sort_nodppa, bh_slim_dedup, left.bdid = right.bdid, filterbrg(left,right), left only, local);

/////////////////////////////////////////////////////////////////////////////////////////

output('Total BH records: ' + count(bh_init));
output('Total BH records w/o DPPA: ' + count(bh_init_nodppa));
output('Total BC records: ' + count(bc_init));
output('Total BC records w/o DPPA: ' + count(bc_init_no_dppa));
output('Total BC records w/o DPPA 2nd filter: ' + count(bc_final_filter));
output('Total Employment records: ' + count(emp_init));
output('Total Employment records w/o DPPA: ' + count(emp_init_no_dppa));
output('Total Employment records w/o DPPA 2nd filter: ' + count(emp_final_filter));
output('Total BH Best records: ' + count(bhb_init));
output('Total BH Best records w/o DPPA: ' + count(bhb_init_nodppa));
output('Total BH Best records w/o DPPA 2nd filter: ' + count(bhb_final_filter));
output('Total BH Stat records: ' + count(bhs_init));
output('Total BH Stat records w/o DPPA: ' + count(bhs_final_filter));
output('Total BH Relatives records: ' + count(br_init));
output('Total BH Relatives records w/o DPPA bdid1: ' + count(br_final_filter1));
output('Total BH Relatives records w/o DPPA bdid2: ' + count(br_final_filter2));
output('Total BH Relatives Group records: ' + count(brg_init));
output('Total BH Relatives Group records w/o DPPA: ' + count(brg_final_filter));


Business_Header.Layout_Business_Contact_Out fixcontdates(bc_final_filter L) := transform
  self.dt_first_seen := IF((integer)L.dt_first_seen > (integer)stringlib.GetDateYYYYMMDD(), stringlib.GetDateYYYYMMDD(), L.dt_first_seen);
  self.dt_last_seen := IF((integer)L.dt_last_seen > (integer)stringlib.GetDateYYYYMMDD(), stringlib.GetDateYYYYMMDD(), L.dt_last_seen);
  self := L;
end;
bc_local_fix := project(bc_final_filter, fixcontdates(left));

Business_Header.Layout_Employment_Out fixempdates(emp_final_filter L) := transform
  self.dt_first_seen := IF((integer)L.dt_first_seen > (integer)stringlib.GetDateYYYYMMDD(), stringlib.GetDateYYYYMMDD(), L.dt_first_seen);
  self.dt_last_seen := IF((integer)L.dt_last_seen > (integer)stringlib.GetDateYYYYMMDD(), stringlib.GetDateYYYYMMDD(), L.dt_last_seen);
  self := L;
end;
emp_local_fix := project(emp_final_filter, fixempdates(left));

output(bh_init_nodppa,,'out::business_header_nodppa',overwrite);
output(bc_local_fix,,'out::business_contacts_nodppa',overwrite);
output(emp_local_fix,,'out::employment',overwrite);
output(bhb_final_filter,,'out::business_header_best',overwrite);
output(bhs_final_filter,,'out::business_header_stat_nodppa',overwrite);
output(br_final_filter2,,'out::business_relatives_nodppa',overwrite);
output(brg_final_filter,,'out::business_relatives_group_nodppa',overwrite);





