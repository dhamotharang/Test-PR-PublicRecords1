﻿

import SALT311;
EXPORT DeltaCommand(in_base,in_father,PackageName,KeyNickName,recref,rec_id,VersionBase,VersionFather,inFields,willPublish=true,iskey=true) := functionmacro
	#Declare(DatasetString);
	#Declare(numField);
	#Set(DatasetString,'');
	#Set(numField,1);

#IF(iskey=false)
	BaseNew:=dataset(in_base,#expand(recref),thor);
	BaseOld:=dataset(in_father,#expand(recref),thor);
#ELSE	
	LoadKeyNew:=index(#expand(recref),in_base);
	LoadKeyOld:=index(#expand(recref),in_father);
	BaseNew:=pull(LoadKeyNew);
	BaseOld:=pull(LoadKeyOld);
#END;
	

	Differences := SALT311.mod_Delta.mac_DifferencesByRIDField(BaseOld, BaseNew, inFields, #expand(rec_id));

	Total:=count(BaseOld);

	#Append(DatasetString,'Result:=dataset([\n');
	#APPEND(DatasetString,'{\''+PackageName+'\',\''+KeyNickName+'\',\''+VersionBase+'\',\''+VersionFather+'\',\'Total\',\'Delta_Added\',((string)((((real)count(Differences(added=true)))/((real)(Total)))*100)),((string)count(Differences(added=true))),\'N\'}\n');
	#APPEND(DatasetString,',{\''+PackageName+'\',\''+KeyNickName+'\',\''+VersionBase+'\',\''+VersionFather+'\',\'Total\',\'Delta_Deleted\',((string)((((real)count(Differences(Deleted=true)))/((real)(Total)))*100)),((string)count(Differences(Deleted=true))),\'N\'}\n');
	#APPEND(DatasetString,',{\''+PackageName+'\',\''+KeyNickName+'\',\''+VersionBase+'\',\''+VersionFather+'\',\'Total\',\'Delta_Changed\',((string)((((real)count(Differences(Changed=true)))/((real)(Total)))*100)),((string)count(Differences(Changed=true))),\'N\'}\n');
	#loop 
		#IF(%numField%> Count(inFields))
			#BREAK 
		#ELSE 
			#APPEND(DatasetString,',{\''+PackageName+'\',\''+KeyNickName+'\',\''+VersionBase+'\',\''+VersionFather+'\',\''+trim(inFields[%numField%])+'\',\'Delta_Added\','+'((string)((((real)count(Differences('+trim(inFields[%numField%])+'_added=true)))/((real)(Total)))*100)),((string)count(Differences('+trim(inFields[%numField%])+'_added=true))),\'N\'}\n');
			#APPEND(DatasetString,',{\''+PackageName+'\',\''+KeyNickName+'\',\''+VersionBase+'\',\''+VersionFather+'\',\''+trim(inFields[%numField%])+'\',\'Delta_Removed\','+'((string)((((real)count(Differences('+trim(inFields[%numField%])+'_removed=true)))/((real)(Total)))*100)),((string)count(Differences('+trim(inFields[%numField%])+'_removed=true))),\'N\'}\n');
			#APPEND(DatasetString,',{\''+PackageName+'\',\''+KeyNickName+'\',\''+VersionBase+'\',\''+VersionFather+'\',\''+trim(inFields[%numField%])+'\',\'Delta_Modified\','+'((string)((((real)count(Differences('+trim(inFields[%numField%])+'_modified=true)))/((real)(Total)))*100)),((string)count(Differences('+trim(inFields[%numField%])+'_modified=true))),\'N\'}\n');
		#end 
		#SET(numField, %numField% + 1);
	#end 
	#APPEND(DatasetString,'],DOPSGrowthCheck.layouts.Full_Delta_Stat_Layout);');
	
	%DatasetString%;

	Publish:=output(Result,,'~thor_data400::DeltaStats::FullDeltaStats::using::'+workunit+KeyNickName,thor,compressed,overwrite);

	AddFile:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::FullDeltaStats::using','~thor_data400::DeltaStats::FullDeltaStats::using::'+workunit+KeyNickName),
                      STD.File.FinishSuperFileTransaction()
                     );

#IF(willPublish=false)
return if(STD.File.FileExists(in_base)=true and STD.File.FileExists(in_father)=true,output(Result),output('One or Both of the files '+in_base+' and '+in_father+'do not exist'));
#ELSE
return if(STD.File.FileExists(in_base)=true and STD.File.FileExists(in_father)=true,sequential(
		Publish,
    AddFile),output('One or Both of the files '+in_base+' and '+in_father+'do not exist'));
		
#END		
		
	// return %'DatasetString'%;

ENDMACRO;