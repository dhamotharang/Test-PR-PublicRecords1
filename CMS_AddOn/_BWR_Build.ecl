pversion := '20150403';

#option('multiplePersistInstances', FALSE);
#workunit('name', 'Yogurt:CMS - AddOn ' + pversion);
CMS_AddOn.Build_All(pversion).All;
