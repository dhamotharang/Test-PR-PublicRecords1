import STRATA, BIPV2_Build,BIPV2,wk_ut,STD,ut;
EXPORT CreateStrataForAllKeys(
	string                       pversion        = bipv2.KeySuffix
	,boolean                      pIsTesting      = false
  ,boolean                      pOverwrite      = false
  ) := 
  function

//1 find the wu of the sprint full build:
//Try this next time
thecurrentdate  := (STRING8)Std.Date.Today();      
highwuid        := 'W' + thecurrentdate + '-999999';
wu_str :=sort(wk_ut.get_Running_Workunits('W' + pversion + '-000001',highwuid,'running')(job = 'BIPV2 Full Build ' + pversion),-wuid)[1].wuid;//'W20150217-055342'
//wu_str;  //this is the wu wanted

//While full build has not been done, this may get wrong WU:
/* wus:=BIPV2_Build.files().workunit_history_.qa(version = pversion);//'20160617'
   sname:='BIPV2 Full Build ' + pversion; //'20160617'
   ds_wu:=wus(name=sname);
   wu_str:=max(ds_wu,wuid);
*/


//2 get the fullkeys and weeklykeys logical files (keyFileNames:=BIPV2_Build.keynames('qa').BIPV2FullKeys;???)
ds2:=wk_ut.get_FilesRead(wu_str); 
ds3:=ds2(cluster<>'' and issuper=false);//get the fullkeys and weeklykeys logical files
	
//3 find the size and rowcount	
ds1:=STD.File.LogicalFileList();
ds4:=ds1(superfile=false); //rowcount>0 and 
J:=join(ds3,ds4, left.name=right.name, 
								 transform({string name, unsigned size, unsigned rowcount,boolean superfile},self:=right));

//4 convert the logical to super
J1:=project(J, transform({string name, unsigned size, unsigned rowcount},
							 self.name:=MIN(STD.File.LogicalFileSuperowners('~'+left.name),name);
							 self:=left));
//5 project to get the format suitable for strata
P_size:=project(J1,transform({string name, string field, unsigned countval},
                   self.name:=left.name;
									 self.field:='filesize';
									 self.countval:=left.size));
P_count:=project(J1,transform({string name, string field, unsigned countval},
                   self.name:=left.name;
									 self.field:='rowcount';
									 self.countval:=left.rowcount));		
P_Add:=P_size + P_count;
P_final:=sort(P_Add, name, field) : independent; 
	
	//return output(P_final);
	return Strata.macf_CreateXMLStats(P_final ,'BIPV2','FullBuild'	,pversion	,BIPV2_Build.mod_email.emailList	,'FullAndWeekly'  ,'Keys'    ,pIsTesting,pOverwrite); //group on name,field

end;	
      