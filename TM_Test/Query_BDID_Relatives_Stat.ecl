f := Business_Header.File_Business_Relatives(not rel_group, bdid2 < bdid1);
fg := Business_Header.File_Business_Relatives_Group;

layout_relatives_slim := record
unsigned6 bdid;
string2 relation_type;
end;

layout_relatives_slim MapRelationType(f L, string2 rtype) := transform
self.bdid := L.bdid1;
self.relation_type := rtype;
end;

relatives_corp_charter_number := project(f(corp_charter_number), MapRelationType(left, 'C'));
relatives_bankruptcy_filing := project(f(bankruptcy_filing), MapRelationType(left, 'B'));
relatives_business_registration := project(f(business_registration), MapRelationType(left, 'BR'));
relatives_duns_number := project(f(duns_number), MapRelationType(left, 'D'));
relatives_duns_tree := project(f(duns_tree), MapRelationType(left, 'DT'));
relatives_edgar_cik := project(f(edgar_cik), MapRelationType(left, 'E'));
relatives_name := project(f(name), MapRelationType(left, 'NM'));
relatives_name_address := project(f(name_address), MapRelationType(left, 'NA'));
relatives_name_phone := project(f(name_phone), MapRelationType(left, 'NP'));
relatives_phone := project(f(phone), MapRelationType(left, 'PH'));
relatives_addr := project(f(addr), MapRelationType(left, 'AD'));
relatives_mail_addr := project(f(mail_addr), MapRelationType(left, 'MA'));
relatives_gong_group := project(f(gong_group), MapRelationType(left, 'G'));
relatives_ucc_filing := project(f(ucc_filing), MapRelationType(left, 'U'));
relatives_fbn_filing := project(f(fbn_filing), MapRelationType(left, 'F'));
relatives_fein := project(f(fein), MapRelationType(left, 'FE'));
relatives_dca_company_number := project(f(dca_company_number), MapRelationType(left, 'DC'));
relatives_dca_hierarchy := project(f(dca_hierarchy), MapRelationType(left, 'DH'));
relatives_abi_number := project(f(abi_number), MapRelationType(left, 'AB'));
relatives_abi_hierarchy := project(f(abi_hierarchy), MapRelationType(left, 'AH'));


relatives_slim := relatives_corp_charter_number +
                  relatives_bankruptcy_filing +
                  relatives_business_registration +
                  relatives_duns_number +
                  relatives_duns_tree +				  
                  relatives_edgar_cik +
                  relatives_name +
                  relatives_name_address +
                  relatives_name_phone +
                  relatives_phone +
                  relatives_addr +
                  relatives_mail_addr +
                  relatives_gong_group +
                  relatives_ucc_filing +
                  relatives_fbn_filing +
                  relatives_fein +
			   relatives_dca_company_number +
			   relatives_dca_hierarchy +
			   relatives_abi_number +
			   relatives_abi_hierarchy;

layout_relatives_stat := record
relatives_slim.bdid;
relatives_slim.relation_type;
relation_count := count(group);
end;

relatives_stat := table(relatives_slim, layout_relatives_stat, bdid, relation_type);
/*
// Create Group Relative Stat
layout_relative_grp := record
fg.group_id;
cnt := count(group);
end;

fg_stat := table(fg, layout_relative_grp, group_id);

layout_relatives_stat AddGroupCount(fg l, layout_relative_grp r) := transform
self.bdid := l.bdid;
self.relation_type := l.group_type;
self.relation_count := r.cnt - 1;
end;

group_stat := join(fg,
                   fg_stat,
                   left.group_id = right.group_id,
                   AddGroupCount(left, right),
                   lookup);
*/
combined_stat := relatives_stat /* + group_stat */;

total_bdids := count(Business_Header.File_Business_Header_Best);
total_bdids_with_relatives := count(dedup(combined_stat, bdid, all));

output(total_bdids, named('Total_Number_of_BDIDs'));
output(total_bdids_with_relatives, named('Total_Number_of_BDIDs_with_Relatives'));

// Distribution of BDIDs by type of relation
layout_relatives_type_stat := record
combined_stat.relation_type;
cnt_bdids := count(group);
cnt_no_bdids := total_bdids - count(group);
cnt_total_relations := sum(group, combined_stat.relation_count);
avg_per_bdid_with_relation := sum(group, combined_stat.relation_count)/count(group);
avg_per_bdid_all := sum(group, combined_stat.relation_count)/total_bdids;
end;

relatives_type_stat := table(combined_stat, layout_relatives_type_stat, relation_type, few);

output(relatives_type_stat, all);

// Frequency Distribution by Count of Relation Type
layout_relatives_frequency_stat := record
combined_stat.relation_type;
combined_stat.relation_count;
cnt_freq := count(group);
end;

relatives_frequency_stat := table(combined_stat, layout_relatives_frequency_stat, relation_type, relation_count);

// Add entry for bdids with zero count
relatives_frequency_stat_zero := project(relatives_type_stat,
                                         transform(layout_relatives_frequency_stat,
								           self.relation_type := left.relation_type,
										 self.relation_count := 0,
										 self.cnt_freq := total_bdids - left.cnt_bdids));

output(sort(relatives_frequency_stat + relatives_frequency_stat_zero, relation_type, relation_count), all);



