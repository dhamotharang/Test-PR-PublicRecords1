// BWR_Spray_CrossReference 

IMPORT ut, PRTE2_X_Ins_PropertyScramble, PRTE2_Common;
#OPTION('multiplePersistInstances',FALSE);
#workunit('name', 'Alpha CT Property XRef Spray & Build');

fileVersion := ut.GetDate+'a';

CSVName := 'Property_XRef_Enhanced_20150213.csv';

BuildFile := PRTE2_X_Ins_PropertyScramble.FnSpray_And_Build_XRef(CSVName,fileVersion);

SEQUENTIAL (BuildFile);
