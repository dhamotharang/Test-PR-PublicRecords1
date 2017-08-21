//W20071221-093424 20080118-133506 20080904-121128 Prop Fares FC by County Date
t3 := table(Property.File_Foreclosure,{document_type,state,county,recording_date,full_site_address_unparsed_1,full_site_address_unparsed_2});
dt3 := '20080904';
output(table(t3(recording_date<=dt3),
  {state,county,count(group),
   min(group,recording_date),max(group,recording_date)},
  state,county),all);

//W20071207-101501 20080904-121128 Prop Fares FC by Doctype
output(table(t3,{document_type,count(group)},document_type),all);

//W20071221-093921 20080904-121128 Missing property search
output(t3(state='12' and county='103'),all);

//W20071221-101716 20080904-121128 Missing property detail
output(Property.File_Foreclosure(state='12' and county='103' and 
  full_site_address_unparsed_2='2870 37TH AVE'),all);