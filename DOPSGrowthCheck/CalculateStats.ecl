import DOPSGrowthCheck,STD,ut;
export CalculateStats(PackageName='',KeyRef,KeyNickName, KeyFile='',indexfields,PersistentRecIDField='',EmailField='',PhoneField='',SSNField='',FEINField='', VersionCert='', VersionProd='') := functionmacro 
LoadKey:=index(#expand(KeyRef),KeyFile);

PullKey:=pull(LoadKey);

NumRecs:=count(PullKey);

ut.hasField(PullKey,did,hasDID);
ut.hasField(PullKey,ProxID,hasProxID);
ut.hasField(PullKey,SeleID,hasSeleID);
#DECLARE(CommaString);
#DECLARE(FieldCount);
#SET(CommaString,'');
#SET(FieldCount,0);
ut.hasField(PullKey,Date_Last_Seen,hasDate_Last_Seen);
ut.hasField(PullKey,Date_Vendor_Last_Seen,hasDate_Vendor_Last_Seen);
ut.hasField(PullKey,Process_Date,hasProcess_Date);
ut.hasField(PullKey,Filedate,hasFiledate);

#IF(hasDID)
UniqueDID:=(string)count(dedup(sort(distribute(PullKey,hash(did)),did,local),did,local));
#ELSE
UniqueDID:='n/a';
#END
#IF(hasProxID)
UniqueProxID:=(string)count(dedup(sort(distribute(PullKey,hash(ProxID)),ProxID,local),ProxID,local));
#ELSE
UniqueProxID:='n/a';
#END
#IF(hasSeleID)
UniqueSeleID:=(string)count(dedup(sort(distribute(PullKey,hash(SeleID)),SeleID,local),SeleID,local));
#ELSE
UniqueSeleID:='n/a';
#END
//Calculate Custom Field Stats
#IF(PersistentRecIDField!='')
UniquePersistentRecID:=(string)count(dedup(sort(distribute(PullKey,hash(#expand(PersistentRecIDField))),#expand(PersistentRecIDField),local),#expand(PersistentRecIDField),local));
#ELSE
UniquePersistentRecID:='n/a';
#END
#IF(EmailField!='')
UniqueEmail:=(string)count(dedup(sort(distribute(PullKey,hash(#expand(EmailField))),#expand(EmailField),local),#expand(EmailField),local));
#ELSE
UniqueEmail:='n/a';
#END
#IF(PhoneField!='')
UniquePhone:=(string)count(dedup(sort(distribute(PullKey,hash(#expand(PhoneField))),#expand(PhoneField),local),#expand(PhoneField),local));
#ELSE
UniquePhone:='n/a';
#END
#IF(SSNField!='')
UniqueSSN:=(string)count(dedup(sort(distribute(PullKey,hash(#expand(SSNField))),#expand(SSNField),local),#expand(SSNField),local));
#ELSE
UniqueSSN:='n/a';
#END
#IF(FEINField!='')
UniqueFein:=(string)count(dedup(sort(distribute(PullKey,hash(#expand(FEINField))),#expand(FEINField),local),#expand(FEINField),local));
#ELSE
UniqueFein:='n/a';
#END

//Calculate Index Stats
UniqueIndex:=(string)count(dedup(sort(distribute(PullKey,hash(#expand(indexfields))),#expand(indexfields),local),#expand(indexfields),local));

//Remove Date Fields
#IF(hasDate_Last_Seen)
    #IF(%FieldCount%>0)
		#APPEND(CommaString,',');
    #End 
    #SET(fieldCount, %fieldCount% + 1);
    #APPEND(CommaString,'Date_Last_Seen');
#END 
#IF(hasDate_Vendor_Last_Seen)
    #IF(%FieldCount%>0)
		#APPEND(CommaString,',');
    #End 
    #SET(fieldCount, %fieldCount% + 1);
    #APPEND(CommaString,'Date_Vendor_Last_Seen');
#END #IF(hasProcess_Date)
    #IF(%FieldCount%>0)
		#APPEND(CommaString,',');
    #End 
    #SET(fieldCount, %fieldCount% + 1);
    #APPEND(CommaString,'Process_Date');
#END #IF(hasFiledate)
    #IF(%FieldCount%>0)
		#APPEND(CommaString,',');
    #End 
    #SET(fieldCount, %fieldCount% + 1);
    #APPEND(CommaString,'Filedate');
#END 
#IF(%FieldCount%>0)
RemoveDates:=project(PullKey,transform(recordof(PullKey)-[%CommaString%],Self:=Left;));
#ELSE 
RemoveDates:=PullKey;
#END 
UniquePayload:=(string)count(dedup(sort(distribute(PullKey,hash(#expand(indexfields))),record,local),record,local));

NewEntry:=dataset([{PackageName,KeyFile,KeyNickName,VersionCert,'n/a',NumRecs,UniqueDID,UniqueProxID,UniqueSeleID,UniquePersistentRecID,UniqueEmail,UniquePhone,UniqueSSN,UniqueFEIN,UniqueIndex,UniquePayload,'B','N'}],DOPSGrowthCheck.layouts.Stats_Layout);
OldRecords:=dataset('~thor_data400::DeltaStats::IndividualFileStats::full',DOPSGrowthCheck.layouts.Stats_Layout,thor,__compressed__,opt);

IdentifyProdRecord:=OldRecords(KeyName=KeyFile and CurrVersion=VersionProd and RecType='B');

UpdatePassed:=project(OldRecords,transform(recordof(OldRecords),Self.Passed:=if(Left.CurrVersion=VersionProd and Left.Passed='N','Y',Left.Passed);Self:=Left;));

DOPSGrowthCheck.layouts.Stats_Layout tCalculateDelTaStats(DOPSGrowthCheck.layouts.Stats_Layout L ,DOPSGrowthCheck.layouts.Stats_Layout R):= transform
                    Self.num_recs:=(string)((((real)L.Num_Recs-(real)R.Num_Recs)/(real)R.Num_Recs)*100);
                    Self.unique_did:=if(L.unique_did='n/a','n/a',(string)((((real)L.unique_did-(real)R.unique_did)/(real)R.unique_did)*100));
                    Self.unique_proxid:=if(L.unique_proxid='n/a','n/a',(string)((((real)L.unique_proxid-(real)R.unique_proxid)/(real)R.unique_proxid)*100));
                    Self.unique_seleid:=if(L.unique_seleid='n/a','n/a',(string)((((real)L.unique_seleid-(real)R.unique_seleid)/(real)R.unique_seleid)*100));
                    Self.Unique_PersistentRecID:=if(L.Unique_PersistentRecID='n/a','n/a',(string)((((real)L.Unique_PersistentRecID-(real)R.Unique_PersistentRecID)/(real)R.Unique_PersistentRecID)*100));
                    Self.Unique_Email:=if(L.Unique_Email='n/a','n/a',(string)((((real)L.Unique_Email-(real)R.Unique_Email)/(real)R.Unique_Email)*100));
                    Self.Unique_Phone:=if(L.Unique_Phone='n/a','n/a',(string)((((real)L.Unique_Phone-(real)R.Unique_Phone)/(real)R.Unique_Phone)*100));
                    Self.Unique_SSN:=if(L.Unique_SSN='n/a','n/a',(string)((((real)L.Unique_SSN-(real)R.Unique_SSN)/(real)R.Unique_SSN)*100));
                    Self.Unique_Fein:=if(L.Unique_Fein='n/a','n/a',(string)((((real)L.Unique_Fein-(real)R.Unique_Fein)/(real)R.Unique_Fein)*100));
                    Self.unique_index:=if(L.unique_index='n/a','n/a',(string)((((real)L.unique_index-(real)R.unique_index)/(real)R.unique_index)*100));
                    Self.unique_payload:=if(L.unique_payload='n/a','n/a',(string)((((real)L.unique_payload-(real)R.unique_payload)/(real)R.unique_payload)*100));
                    Self.CurrVersion:=L.CurrVersion;
                    Self.PrevVersion:=R.CurrVersion;
                    Self.RecType:='D';
                    Self.Passed:='n/a';
                    Self:=L;
                end;
NewDeltaStat:=join(NewEntry,IdentifyProdRecord,Left.KeyName=Right.KeyName,tCalculateDelTaStats(left,right));
//output(NewDeltaStat,named('NewDeltaStat'));

NewFile:=if(exists(IdentifyProdRecord),NewDeltaStat+NewEntry+UpdatePassed,NewEntry+UpdatePassed);

Publish:=output(NewFile,,'~thor_data400::DeltaStats::IndividualFileStats::using::'+workunit+KeyNickName,thor,compressed,overwrite);

AddFile:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::IndividualFileStats::using','~thor_data400::DeltaStats::IndividualFileStats::using::'+workunit+KeyNickName),
                      STD.File.FinishSuperFileTransaction()
                     );


return sequential(
		Publish,
    AddFile);

endmacro;