f := Business_Header.File_Business_Relatives(not rel_group, bdid2 < bdid1);

layout_slim := record
f.corp_charter_number;
f.business_registration;
f.bankruptcy_filing;
f.duns_number;
f.duns_tree;
f.edgar_cik;
f.name;
f.name_address;
f.name_phone;
f.gong_group;
f.ucc_filing;
f.fbn_filing;
f.fein;
f.phone;
f.addr;
f.mail_addr;
f.dca_company_number;
f.dca_hierarchy;
f.abi_number;
f.abi_hierarchy;
end;

fslim := table(f, layout_slim);

layout_stat := record
cnt_corp_charter_number := count(group, fslim.corp_charter_number);
cnt_business_registration := count(group, fslim.business_registration);
cnt_bankruptcy_filing := count(group, fslim.bankruptcy_filing);
cnt_duns_number := count(group, fslim.duns_number);
cnt_duns_tree := count(group, fslim.duns_tree);
cnt_edgar_cik := count(group, fslim.edgar_cik);
cnt_name := count(group, fslim.name);
cnt_name_address := count(group, fslim.name_address);
cnt_name_phone := count(group, fslim.name_phone);
cnt_gong_group := count(group, fslim.gong_group);
cnt_ucc_filing := count(group, fslim.ucc_filing);
cnt_fbn_filing := count(group, fslim.fbn_filing);
cnt_fein := count(group, fslim.fein);
cnt_phone := count(group, fslim.phone);
cnt_addr := count(group, fslim.addr);
cnt_mail_addr := count(group, fslim.mail_addr);
cnt_dca_company_number := count(group, fslim.dca_company_number);
cnt_dca_hierarchy := count(group, fslim.dca_hierarchy);
cnt_abi_number := count(group, fslim.abi_number);
cnt_abi_hierarchy := count(group, fslim.abi_hierarchy);
end;

fstat := table(fslim, layout_stat, few);

output(fstat);
