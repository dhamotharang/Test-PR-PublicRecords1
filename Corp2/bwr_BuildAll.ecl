pversion	:= '20170707';   // modify to current date

#workunit('protect',true);
#workunit('name', 'Yogurt:Corp2 Complete Process ' + pversion);
#workunit('priority','high');
#workunit('priority',12);
#option ('activitiesPerCpp', 50);

corp2.Proc_Build_All(pversion).all;								
