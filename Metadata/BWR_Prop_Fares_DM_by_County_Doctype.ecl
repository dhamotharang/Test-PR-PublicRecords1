//W20071207-133412 20080118-133506 20080904-121128 Prop Fares DM by County
t2 := table(Property.File_Fares_Deeds,{mortgage_deed_type,fips});
d2 := distribute(t2,hash(mortgage_deed_type));
output(table(d2,{fips,count(group)},fips),all);

//W20071206-174414 20080904-121128 Prop Fares DM by Doctype
output(table(d2,{mortgage_deed_type,count(group)},mortgage_deed_type),all);