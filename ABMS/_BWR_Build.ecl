#option ('activitiesPerCpp', 50); // Supposedly shortens the compile time
pversion := '20130319';

#workunit('name', 'ABMS Build ' + pversion);
ABMS.Build_All(pversion).All;
