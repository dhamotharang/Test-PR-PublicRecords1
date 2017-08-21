pversion := '20160204';

#workunit('name', 'Infogroup Build ' + pversion);
#OPTION('multiplePersistInstances', FALSE);
Infogroup.Build_All(pversion).All;
