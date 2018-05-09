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
EXPORT DeltaCommand(in_base,in_father,PackageName,KeyNickName,KeyRef,rec_id,inFields) := functionmacro
	#Declare(DatasetString);
	#Declare(nField);
	#Set(DatasetString,'');
	#Set(nField,1);

	LoadKeyNew:=index(#expand(KeyRef),in_base);
	LoadKeyOld:=index(#expand(KeyRef),in_father);

	PullKeyNew:=pull(LoadKeyNew);
	PullKeyOld:=pull(LoadKeyOld);

	#Append(DatasetString,'Result:=dataset([\n';
	#loop 
		#IF(%nField%> Count(inFields))
			#BREAK 
		#ELSE 
			#APPEND(DatasetString,'{\''+PackageName+'\',\''+KeyName+'\',\''+CurrVersion+'\',\''+PrevVersion+'\',\''+trim(inFields[%nField%])+'\',\''+
		{PackageName,KeyNickName,CurrVersion,PrevVersion,}
	],DOPSGrowthCheck.layouts.Full_Delta_Stat_Layout);
	
	Differences := SALT311.mod_Delta.mac_DifferencesByRIDField(PullKeyOld, PullKeyNew, inFields, #expand(rec_id));



	return output(Differences);

ENDMACRO;