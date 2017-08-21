score_threshold := 6;  // combined_score for contact must be greater than this number for people at work

bc := Business_Header.File_Business_Contacts_Stats(NOT Business_Header.CheckUCC(source, company_name, fname, mname, lname, name_suffix));
paw := bc(combined_score > score_threshold);

output(count(paw(combined_score > score_threshold)), named('Total_PAW'));
output(min(paw(dt_first_seen > 19500000), dt_first_seen), named('PAW_earliest_date'));

layout_date := record
date_year := bc.dt_first_seen DIV 10000;
end;

paw_date := table(paw(dt_first_seen > 0), layout_date);

layout_stat := record
paw_date.date_year;
cnt := count(group);
end;

paw_date_stat := table(paw_date(date_year > 0), layout_stat, date_year, few);

output(topn(paw_date_stat(date_year > 0), 1000, date_year), all);

