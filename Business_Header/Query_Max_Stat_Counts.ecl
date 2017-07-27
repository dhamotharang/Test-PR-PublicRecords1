// Calculate maximum values for number of base records and relatives
f := Business_Header.File_Business_Header_Stats;
fb := Business_Header.File_Business_Header_Best;

layout_max := record
unsigned2 max_base_record_count := max(group, f.base_record_count);
unsigned2 max_corp_charter_number_relative_count := max(group, f.corp_charter_number_relative_count);
unsigned2 max_business_registration_relative_count := max(group, f.business_registration_relative_count);
unsigned2 max_bankruptcy_filing_relative_count := max(group, f.bankruptcy_filing_relative_count);
unsigned2 max_duns_number_relative_count := max(group, f.duns_number_relative_count);
unsigned2 max_duns_tree_relative_count := max(group, f.duns_tree_relative_count);
unsigned2 max_edgar_cik_relative_count := max(group, f.edgar_cik_relative_count);
unsigned2 max_name_relative_count := max(group, f.name_relative_count);
unsigned2 max_name_address_relative_count := max(group, f.name_address_relative_count);
unsigned2 max_name_phone_relative_count := max(group, f.name_phone_relative_count);
unsigned2 max_gong_group_relative_count := max(group, f.gong_group_relative_count);
unsigned3 max_ucc_filing_relative_count := max(group, f.ucc_filing_relative_count);
unsigned2 max_fbn_filing_relative_count := max(group, f.fbn_filing_relative_count);
unsigned2 max_fein_relative_count := max(group, f.fein_relative_count);
unsigned2 max_phone_relative_count := max(group, f.phone_relative_count);
unsigned3 max_addr_relative_count := max(group, f.addr_relative_count);
unsigned2 max_mail_addr_relative_count := max(group, f.mail_addr_relative_count);
end;

fstat := table(f, layout_max);

output(fstat);

// Select the stat records with maximum values for each count

max_base_record_count := max(f, base_record_count);
max_corp_charter_number_relative_count := max(f, corp_charter_number_relative_count);
max_business_registration_relative_count := max(f, business_registration_relative_count);
max_bankruptcy_filing_relative_count := max(f, bankruptcy_filing_relative_count);
max_duns_number_relative_count := max(f, duns_number_relative_count);
max_duns_tree_relative_count := max(f, duns_tree_relative_count);
max_edgar_cik_relative_count := max(f, edgar_cik_relative_count);
max_name_relative_count := max(f, name_relative_count);
max_name_address_relative_count := max(f, name_address_relative_count);
max_name_phone_relative_count := max(f, name_phone_relative_count);
max_gong_group_relative_count := max(f, gong_group_relative_count);
max_ucc_filing_relative_count := max(f, ucc_filing_relative_count);
max_fbn_filing_relative_count := max(f, fbn_filing_relative_count);
max_fein_relative_count := max(f, fein_relative_count);
max_phone_relative_count := max(f, phone_relative_count);
max_addr_relative_count := max(f, addr_relative_count);
max_mail_addr_relative_count := max(f, mail_addr_relative_count);


maxlist := choosen(f(base_record_count = max_base_record_count),1) +
           choosen(f(corp_charter_number_relative_count = max_corp_charter_number_relative_count),1) +
           choosen(f(business_registration_relative_count = max_business_registration_relative_count),1) +
           choosen(f(bankruptcy_filing_relative_count = max_bankruptcy_filing_relative_count),1) +
           choosen(f(duns_number_relative_count = max_duns_number_relative_count),1) +
           choosen(f(duns_tree_relative_count = max_duns_tree_relative_count),1) +
           choosen(f(edgar_cik_relative_count = max_edgar_cik_relative_count),1) +
           choosen(f(name_relative_count = max_name_relative_count),1) +
           choosen(f(name_address_relative_count = max_name_address_relative_count),1) +
           choosen(f(name_phone_relative_count = max_name_phone_relative_count),1) +
           choosen(f(gong_group_relative_count = max_gong_group_relative_count),1) +
           choosen(f(ucc_filing_relative_count = max_ucc_filing_relative_count),1) +
           choosen(f(fbn_filing_relative_count = max_fbn_filing_relative_count),1) +
           choosen(f(fein_relative_count = max_fein_relative_count),1) +
           choosen(f(phone_relative_count = max_phone_relative_count),1) +
           choosen(f(mail_addr_relative_count = max_mail_addr_relative_count),1) +
           choosen(f(addr_relative_count = max_addr_relative_count),1);

maxlist_dedup := dedup(maxlist, bdid, all);

layout_max_combined := record
fb;
unsigned2 base_record_count;
unsigned2 corp_charter_number_relative_count;
unsigned2 business_registration_relative_count;
unsigned2 bankruptcy_filing_relative_count;
unsigned2 duns_number_relative_count;
unsigned2 duns_tree_relative_count;
unsigned2 edgar_cik_relative_count;
unsigned2 name_relative_count;
unsigned2 name_address_relative_count;
unsigned2 name_phone_relative_count;
unsigned2 gong_group_relative_count;
unsigned3 ucc_filing_relative_count;
unsigned2 fbn_filing_relative_count;
unsigned2 fein_relative_count;
unsigned2 phone_relative_count;
unsigned3 addr_relative_count;
unsigned2 mail_addr_relative_count;
end;

layout_max_combined CombineMax(fb l, maxlist_dedup r) := transform
self := l;
self := r;
end;

maxlist_combined := join(fb,
                         maxlist_dedup,
                         left.bdid = right.bdid,
                         CombineMax(left, right),
                         lookup);

output(maxlist_combined);