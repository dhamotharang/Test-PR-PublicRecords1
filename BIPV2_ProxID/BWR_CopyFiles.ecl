import BIPV2,tools;
version         := BIPV2.keysuffix + '_35';
keynames        := BIPV2_ProxID.keynames(version).dall_filenames;
istesting       := false;
SkipSuperStuff  := false;
filedescription := workunit + '\n Copied BIPV2_ProxID iteration 35 files to BIPV2_ProxID.  First time we are using DBA in prod. BIPV2_ProxID workunit: W20130605-103201';
Filterregex     := 'key';
destgroup       := tools.fun_Groupname('20');
//copy prod to prod
tools.fun_CopyRename(keynames,true ,['BIPV2_ProxID','BIPV2_ProxID'] ,[version,BIPV2.keysuffix] ,filedescription,Filterregex ,pdestinationgroup := destgroup ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting );   //package file keys         
//copy to dataland from prod , run on dataland    
//tools.fun_CopyRename(keynames(BIPV2.keysuffix).dall_filenames,true ,['thor_data400',tools.fun_Groupname('20')] ,[] ,filedescription,Filterregex ,pdestinationgroup := destgroup ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting )   //package file keys         
