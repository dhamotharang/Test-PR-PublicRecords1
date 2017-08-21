layout_bbb_demographic_out := record
string12 bdid;
string6  bbb_id;
string60 company_name;
string100 address;
string12 country;
string14 phone;
string12 revenues := '';
string7  number_employees := '';
end;

bbb_dmg := dataset('~thor_data400::TMTEST::BBB_Demographics_Append', layout_bbb_demographic_out, flat);

layout_dmg_stat := record
total_bbb := count(group);
number_employees_not_available := count(group, (integer)bbb_dmg.number_employees = 0);
number_employees_1_to_50 := count(group, (integer)bbb_dmg.number_employees >= 1 and (integer)bbb_dmg.number_employees <= 50);
number_employees_51_to_100 := count(group, (integer)bbb_dmg.number_employees >= 51 and (integer)bbb_dmg.number_employees <= 100);
number_employees_101_to_300 := count(group, (integer)bbb_dmg.number_employees >= 101 and (integer)bbb_dmg.number_employees <= 300);
number_employees_301_plus := count(group, (integer)bbb_dmg.number_employees >= 301);
revenues_not_available := count(group, (integer)bbb_dmg.revenues = 0);
revenues_1_to_499999 := count(group, (integer)bbb_dmg.revenues >= 1 and (integer)bbb_dmg.revenues <= 499999);
revenues_500000_to_999999 := count(group, (integer)bbb_dmg.revenues >= 500000 and (integer)bbb_dmg.revenues <= 999999);
revenues_1000000_to_2499999 := count(group, (integer)bbb_dmg.revenues >= 1000000 and (integer)bbb_dmg.revenues <= 2499999);
revenues_2500000_to_4999999 := count(group, (integer)bbb_dmg.revenues >= 2500000 and (integer)bbb_dmg.revenues <= 4999999);
revenues_5000000_to_9999999 := count(group, (integer)bbb_dmg.revenues >= 5000000 and (integer)bbb_dmg.revenues <= 9999999);
revenues_10000000_to_19999999 := count(group, (integer)bbb_dmg.revenues >= 10000000 and (integer)bbb_dmg.revenues <= 19999999);
revenues_20000000_to_49999999 := count(group, (integer)bbb_dmg.revenues >= 20000000 and (integer)bbb_dmg.revenues <= 49999999);
revenues_50000000_to_99999999 := count(group, (integer)bbb_dmg.revenues >= 50000000 and (integer)bbb_dmg.revenues <= 99999999);
revenues_100000000_to_499999999 := count(group, (integer)bbb_dmg.revenues >= 100000000 and (integer)bbb_dmg.revenues <= 499999999);
revenues_500000000_to_999999999 := count(group, (integer)bbb_dmg.revenues >= 500000000 and (integer)bbb_dmg.revenues <= 999999999);
revenues_1000000000_plus := count(group, (integer)bbb_dmg.revenues >= 1000000000);
end;

bbb_dmg_stat := table(bbb_dmg, layout_dmg_stat);

output(bbb_dmg_stat);

