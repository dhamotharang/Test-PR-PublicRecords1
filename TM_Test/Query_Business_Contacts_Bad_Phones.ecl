f := Business_Header.File_Business_Contacts;

layout_phone_source := record
f.source;
f.phone;
f.company_phone;
end;

fphone := table(f(from_hdr = 'N', phone <> 0 or company_phone <> 0), layout_phone_source);

layout_phone_stat := record
fphone.source;
cnt_phones := count(group, fphone.phone <> 0);
cnt_company_phones  := count(group, fphone.company_phone <> 0);
cnt_bad_phones := count(group, fphone.phone > 10000000000);
cnt_bad_company_phones := count(group, fphone.company_phone > 10000000000);
end;

fphone_stat := table(fphone, layout_phone_stat, source);

output(fphone_stat, all);

output(sum(fphone_stat, cnt_bad_phones), named('Total_Count_Bad_Phones'));
output(sum(fphone_stat, cnt_bad_company_phones), named('Total_Count_Bad_Company_Phones'));