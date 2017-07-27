f := Business_Header.File_Business_Relatives(not rel_group);

layout_relatives_slim := record
string2 relation_type;
end;

layout_relatives_slim MapRelationType(f L, string2 rtype) := transform
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
                  relatives_fein;

layout_relatives_stat := record
relatives_slim.relation_type;
relation_count := count(group);
end;

relatives_stat := table(relatives_slim, layout_relatives_stat, relation_type, few);

output(relatives_stat);