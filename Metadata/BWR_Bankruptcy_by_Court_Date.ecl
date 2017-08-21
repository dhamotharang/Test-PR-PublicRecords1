//W20070926-174258 W20071015-142505 W20080515-164702 Bankruptcy by Court Date

dDev := BankruptcyV2.file_bankruptcy_main;

output(table(dDev,{court_location,count(group)},court_location),all);
output(table(dDev,{court_name,min(group,date_filed)},court_name),all);
output(table(dDev,{court_name,max(group,date_filed)},court_name),all);
output(choosen(table(dDev,{court_code,court_name,court_location,max(group,date_filed),count(group)},court_code,court_name,court_location),all));