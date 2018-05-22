import DOPSGrowthCheck,STD,ut;
export CalculateStats(PackageName='', KeyRef, KeyFile='',indexfields, VersionCert='', VersionProd='') := functionmacro 
STD.FILE.CreateSuperFile('~thor_data400::DeltaStats::'+PackageName+'::IndividualFileStats',,true);
STD.FILE.CreateSuperFile('~thor_data400::DeltaStats::'+PackageName+'::BasicDeltaStats',,true);
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
UniqueIndex:=(string)count(dedup(sort(distribute(PullKey,hash(#expand(indexfields))),#expand(indexfields),local),#expand(indexfields),local));

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

NewEntry:=dataset([{PackageName,KeyFile,VersionCert,NumRecs,UniqueDID,UniqueProxID,UniqueSeleID,UniqueIndex,UniquePayload}],DOPSGrowthCheck.layouts.Unique_Stats_Layout);
OldRecords:=dataset('~thor_data400::DeltaStats::'+PackageName+'::IndividualFileStats',DOPSGrowthCheck.layouts.Unique_Stats_Layout,thor,__compressed__,opt);

IdentifyProdRecord:=OldRecords(KeyName=KeyFile and Version=VersionProd);

//#IF(exists(IdentifyProdRecord))

OldDeltaRecords:=dataset('~thor_data400::DeltaStats::'+PackageName+'::BasicDeltaStats',DOPSGrowthCheck.layouts.Basic_Delta_Stats,thor,__compressed__,opt);

DOPSGrowthCheck.layouts.Basic_Delta_Stats tCalculateDelTaStats(DOPSGrowthCheck.layouts.Unique_Stats_Layout L ,DOPSGrowthCheck.layouts.Unique_Stats_Layout R):= transform
                    Self.delta_num_recs:=(string)((((real)L.Num_Recs-(real)R.Num_Recs)/(real)R.Num_Recs)*100);
                    Self.delta_unique_did:=if(L.unique_did='n/a','n/a',(string)((((real)L.unique_did-(real)R.unique_did)/(real)R.unique_did)*100));
                    Self.delta_unique_proxid:=if(L.unique_proxid='n/a','n/a',(string)((((real)L.unique_proxid-(real)R.unique_proxid)/(real)R.unique_proxid)*100));
                    Self.delta_unique_seleid:=if(L.unique_seleid='n/a','n/a',(string)((((real)L.unique_seleid-(real)R.unique_seleid)/(real)R.unique_seleid)*100));
                    Self.delta_unique_index:=if(L.unique_index='n/a','n/a',(string)((((real)L.unique_index-(real)R.unique_index)/(real)R.unique_index)*100));
                    Self.delta_unique_payload:=if(L.unique_payload='n/a','n/a',(string)((((real)L.unique_payload-(real)R.unique_payload)/(real)R.unique_payload)*100));
                    Self.CertVersion:=L.Version;
                    Self.ProdVersion:=R.Version;
                    Self:=L;
                end;
NewDeltaStat:=join(NewEntry,IdentifyProdRecord,Left.KeyName=Right.KeyName,tCalculateDelTaStats(left,right));
//output(NewDeltaStat,named('NewDeltaStat'));

Publish:=sequential(
            output(NewEntry+OldRecords,,'~thor_data400::DeltaStats::'+PackageName+'::IndividualFileStats'+workunit,thor,compressed),
            output(OldDeltaRecords+NewDeltaStat,,'~thor_data400::DeltaStats::'+PackageName+'::BasicDeltaStats'+workunit,thor,compressed)
            );
ClearFile:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.ClearSuperFile('~thor_data400::DeltaStats::'+PackageName+'::IndividualFileStats',true),
                      STD.FILE.ClearSuperFile('~thor_data400::DeltaStats::'+PackageName+'::BasicDeltaStats',true),
                      STD.File.FinishSuperFileTransaction()
                     );
AddFile:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::'+PackageName+'::IndividualFileStats','~thor_data400::DeltaStats::'+PackageName+'::IndividualFileStats'+workunit),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::'+PackageName+'::BasicDeltaStats','~thor_data400::DeltaStats::'+PackageName+'::BasicDeltaStats'+workunit),
                      STD.File.FinishSuperFileTransaction()
                     );

Publish2:=output(NewEntry+OldRecords,,'~thor_data400::DeltaStats::'+PackageName+'::IndividualFileStats'+workunit,thor,compressed);
ClearFile2:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.ClearSuperFile('~thor_data400::DeltaStats::'+PackageName+'::IndividualFileStats',true),
                      STD.File.FinishSuperFileTransaction()
                     );
AddFile2:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::'+PackageName+'::IndividualFileStats','~thor_data400::DeltaStats::'+PackageName+'::IndividualFileStats'+workunit),
                      STD.File.FinishSuperFileTransaction()
                     );


return if(exists(IdentifyProdRecord),
    sequential(
    Publish,
    ClearFile,
    AddFile),
    sequential(
    Publish2,
    ClearFile2,
    AddFile2)
);

endmacro;