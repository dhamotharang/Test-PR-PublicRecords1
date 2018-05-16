// EXPORT DeltaCommand := 'todo';

/*USAGE GUIDE//////////////////////////////////////////////////////////////////



REQUIRED:
------------------------------------------
in_base				:		Current version of the file. 
in_father			:		Previous version of the file.
rec_id				:		Record identifier field.

OPTIONAL:
------------------------------------------
src_field			:		Source field. If blank, the result will only have one row, which is 'TOTAL'.	
inFields			:		Set of fields to compare. If blank, the result will only have 5 columns (unless dtFields are specified): src, cnt, cntNew, cntDeleted, cntUnchanged, cntUpdated.
src_rid_field	:		Source rid field. For use across SALT Ingest and similar processes where one source rid may spawn multiple rec_id rows when a field is changed. If blank, the result will only compare using the rec_id field.
dtFields			:		Set of date fields to compare. If blank, the result will not include the date comparison columns.
inPersist			:		Infix to be applied to persists. If blank, no persists will be generated. Use persists if you are expecting to run this macro with at least one of the same files, with the same fields, multiple times against other file versions.
debug					:		For development. Setting this flag to TRUE outputs the ECL generated as a string instead.

/////////////////////////////////////////////////////////////////////////////*/

import SALT311;
EXPORT DeltaCommand(in_base,in_father,PackageName,KeyNickName,KeyRef,rec_id,VersionBase,VersionFather,inFields) := functionmacro
	#Declare(DatasetString);
	#Declare(numField);
	#Set(DatasetString,'');
	#Set(numField,1);

	LoadKeyNew:=index(#expand(KeyRef),in_base);
	LoadKeyOld:=index(#expand(KeyRef),in_father);

	PullKeyNew:=pull(LoadKeyNew);
	PullKeyOld:=pull(LoadKeyOld);

	Differences := SALT311.mod_Delta.mac_DifferencesByRIDField(PullKeyOld, PullKeyNew, inFields, #expand(rec_id));

	Total:=count(PullKeyOld);

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


return sequential(
		Publish,
    AddFile);
	// return %'DatasetString'%;

ENDMACRO;