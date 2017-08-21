pversion := '20151009';

#workunit('name', 'ALC Build ' + pversion);
#OPTION('multiplePersistInstances', FALSE);
ALC.Build_All(pversion).All;
