hc1 := Business_Header.Header_Contacts;

count(hc1);

layout_contact_score_stat1 := record
hc1.contact_score;
cnt := count(group);
end;

hc1_stat := table(hc1, layout_contact_score_stat1, contact_score, few);

output(hc1_stat, all);

hc2 := TM_Test.Header_Contacts;

count(hc2);

layout_contact_score_stat2 := record
hc2.contact_score;
cnt := count(group);
end;

hc2_stat := table(hc2, layout_contact_score_stat2, contact_score, few);

output(hc2_stat,all);
