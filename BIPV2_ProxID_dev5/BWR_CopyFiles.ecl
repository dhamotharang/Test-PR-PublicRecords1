import BIPV2,tools;

version         := BIPV2.keysuffix + '_35';
keynames        := BIPV2_ProxID_dev5.keynames(version).dall_filenames;
istesting       := false;
SkipSuperStuff  := false;
filedescription := workunit + '\n Copied BIPV2_ProxID_dev5_dev iteration 35 files to BIPV2_ProxID_dev5.  First time we are using DBA in prod. BIPV2_ProxID_dev5_dev workunit: W20130605-103201';
Filterregex     := 'key';
destgroup       := tools.fun_Groupname('20');


//copy prod to prod
tools.fun_CopyRename(keynames,true ,['BIPV2_ProxID_dev5','BIPV2_ProxID_dev5_dev'] ,[version,BIPV2.keysuffix] ,filedescription,Filterregex ,pdestinationgroup := destgroup ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting );   //package file keys         

//copy to dataland from prod , run on dataland    
//tools.fun_CopyRename(keynames(BIPV2.keysuffix).dall_filenames,true ,['thor_data400',tools.fun_Groupname('20')] ,[] ,filedescription,Filterregex ,pdestinationgroup := destgroup ,pSkipSuperStuff := SkipSuperStuff,pIsTesting := istesting )   //package file keys         
