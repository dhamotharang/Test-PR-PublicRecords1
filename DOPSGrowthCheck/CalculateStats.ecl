
export CalculateStats(PackageName='',recref,InputKeyNickName, in_base='',indexfields,PersistentRecIDField='',EmailField='',PhoneField='',SSNField='',FEINField='', VersionBase, VersionFather,willPublish=true, iskey=true) := functionmacro 
import DOPSGrowthCheck,STD,ut;
#IF(iskey=false)
	BaseFile:=dataset(in_base,#expand(recref),thor);
	#ELSE	
	LoadKeyNew:=index(#expand(recref),in_base);
	BaseFile:=pull(LoadKeyNew);
#END;

NumRecs:=count(BaseFile);

ut.hasField(BaseFile,did,hasDID);
ut.hasField(BaseFile,ProxID,hasProxID);
ut.hasField(BaseFile,SeleID,hasSeleID);
#DECLARE(CommaString);
#DECLARE(FieldCount);
#SET(CommaString,'');
#SET(FieldCount,0);
ut.hasField(BaseFile,Date_Last_Seen,hasDate_Last_Seen);
ut.hasField(BaseFile,Date_Vendor_Last_Seen,hasDate_Vendor_Last_Seen);
ut.hasField(BaseFile,Process_Date,hasProcess_Date);
ut.hasField(BaseFile,Filedate,hasFiledate);

DistFile:=distribute(BaseFile,hash(#expand(PersistentRecIDField)));

#IF(hasDID)
UniqueDID:=(string)count(table(DistFile,{did},did,merge));
#ELSE
UniqueDID:='n/a';
#END
#IF(hasProxID)
UniqueProxID:=(string)count(table(DistFile,{ProxID},ProxID,merge));
#ELSE
UniqueProxID:='n/a';
#END
#IF(hasSeleID)
UniqueSeleID:=(string)count(table(DistFile,{SeleID},SeleID,merge));
#ELSE
UniqueSeleID:='n/a';
#END
//Calculate Custom Field Stats
#IF(PersistentRecIDField!='')
UniquePersistentRecID:=(string)count(table(DistFile,{#expand(PersistentRecIDField)},#expand(PersistentRecIDField),merge));
#ELSE
UniquePersistentRecID:='n/a';
#END
#IF(EmailField!='')
UniqueEmail:=(string)count(table(DistFile,{#expand(EmailField)},#expand(EmailField),merge));
#ELSE
UniqueEmail:='n/a';
#END
#IF(PhoneField!='')
UniquePhone:=(string)count(table(DistFile,{#expand(PhoneField)},#expand(PhoneField),merge));
#ELSE
UniquePhone:='n/a';
#END
#IF(SSNField!='')
UniqueSSN:=(string)count(table(DistFile,{#expand(SSNField)},#expand(SSNField),merge));
#ELSE
UniqueSSN:='n/a';
#END
#IF(FEINField!='')
UniqueFein:=(string)count(table(DistFile,{#expand(FEINField)},#expand(FEINField),merge));
#ELSE
UniqueFein:='n/a';
#END
#IF(indexfields!='')
//Calculate Index Stats
UniqueIndex:=(string)count(table(DistFile,{#expand(indexfields)},#expand(indexfields),merge));
#ELSE
UniqueIndex:='n/a';
#END

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
RemoveDates:=project(BaseFile,transform(recordof(BaseFile)-[%CommaString%],Self:=Left;));
#ELSE 
RemoveDates:=BaseFile;
#END 
UniquePayload:=(string)count(dedup(sort(distribute(RemoveDates,hash(#expand(indexfields))),record,local),record,local));

NewEntry:=dataset([
{PackageName,in_base,InputKeyNickName,VersionBase,'n/a','NumRecs',NumRecs,'B','N'},
{PackageName,in_base,InputKeyNickName,VersionBase,'n/a','UniqueDID',UniqueDID,'B','N'},
{PackageName,in_base,InputKeyNickName,VersionBase,'n/a','UniqueProxID',UniqueProxID,'B','N'},
{PackageName,in_base,InputKeyNickName,VersionBase,'n/a','UniqueSeleID',UniqueSeleID,'B','N'},
{PackageName,in_base,InputKeyNickName,VersionBase,'n/a','UniquePersistentRecID',UniquePersistentRecID,'B','N'},
{PackageName,in_base,InputKeyNickName,VersionBase,'n/a','UniqueEmail',UniqueEmail,'B','N'},
{PackageName,in_base,InputKeyNickName,VersionBase,'n/a','UniquePhone',UniquePhone,'B','N'},
{PackageName,in_base,InputKeyNickName,VersionBase,'n/a','UniqueSSN',UniqueSSN,'B','N'},
{PackageName,in_base,InputKeyNickName,VersionBase,'n/a','UniqueFEIN',UniqueFEIN,'B','N'},
{PackageName,in_base,InputKeyNickName,VersionBase,'n/a','UniqueIndex',UniqueIndex,'B','N'},
{PackageName,in_base,InputKeyNickName,VersionBase,'n/a','UniquePayload',UniquePayload,'B','N'}
],DOPSGrowthCheck.layouts.Stats_Layout);
OldRecords:=dataset('~thor_data400::DeltaStats::IndividualFileStats::full',DOPSGrowthCheck.layouts.Stats_Layout,thor,__compressed__,opt);

IdentifyProdRecord:=OldRecords(KeyNickName=InputKeyNickName and CurrVersion=VersionFather and RecType='B');



DOPSGrowthCheck.layouts.Stats_Layout tCalculateDelTaStats(DOPSGrowthCheck.layouts.Stats_Layout L ,DOPSGrowthCheck.layouts.Stats_Layout R):= transform
                    Self.results:=(string)((((real)L.results-(real)R.results)/(real)R.results)*100);
                    Self.CurrVersion:=L.CurrVersion;
                    Self.PrevVersion:=R.CurrVersion;
                    Self.RecType:='D';
                    Self.Passed:='n/a';
                    Self:=L;
                end;
NewDeltaStat:=join(NewEntry,IdentifyProdRecord,Left.KeyNickName=Right.KeyNickName and Left.Stat_Name=Right.Stat_Name,tCalculateDelTaStats(left,right));
//output(NewDeltaStat,named('NewDeltaStat'));

NewFile:=if(exists(IdentifyProdRecord),NewDeltaStat+NewEntry,NewEntry);

Publish:=output(NewFile,,'~thor_data400::DeltaStats::IndividualFileStats::using::'+workunit+InputKeyNickName,thor,compressed,overwrite);

AddFile:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::IndividualFileStats::using','~thor_data400::DeltaStats::IndividualFileStats::using::'+workunit+InputKeyNickName),
                      STD.File.FinishSuperFileTransaction()
                     );

#IF(willPublish=false)
return output(NewFile);
#ELSE
return sequential(
		Publish,
    AddFile);
#END
endmacro;