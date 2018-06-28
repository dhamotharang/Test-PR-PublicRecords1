EXPORT ChangesByFieldMultiMatch(in_base,in_father,PackageName,InputKeyNickName,recref,matchfields,ignorefields='',VersionBase,VersionFather,willPublish=true,iskey=true) := functionmacro
import std;
	#declare(CommaString);
	#Declare(numField);
	#Set(CommaString,'');
	#Set(numField,1);
	#loop
		#IF(%numField%> Count(matchfields))
			#BREAK 
		#ELSE
			#append(CommaString,matchfields[%numField%]);
			#if(%numField%!=Count(matchfields))
				#append(CommaString,',');
			#end
		#end
		#SET(numField, %numField% + 1);
	#end
#IF(iskey=false)
	#if(ignorefields='')
	LoadNew:=dataset(in_base,#expand(recref),thor);
	LoadOld:=dataset(in_father,#expand(recref),thor);
	DistNew:=distribute(LoadNew,hash(%CommaString%));
	DistOld:=distribute(LoadOld,hash(%CommaString%));
	#else
	LoadNew:=dataset(in_base,#expand(recref),thor);
	LoadOld:=dataset(in_father,#expand(recref),thor);
	RemoveNew:=project(LoadNew,transform(recordof(LoadNew)-[#expand(ignorefields)],Self:=Left;));
	RemoveOld:=project(LoadOld,transform(recordof(LoadOld)-[#expand(ignorefields)],Self:=Left;));
	DistNew:=distribute(RemoveNew,hash(%CommaString%));
	DistOld:=distribute(RemoveOld,hash(%CommaString%));
	#end;
#ELSE	
	#if(ignorefields='')
	LoadKeyNew:=index(#expand(recref),in_base);
	LoadKeyOld:=index(#expand(recref),in_father);
	PullKeyNew:=pull(LoadKeyNew);
	PullKeyOld:=pull(LoadKeyOld);
	DistNew:=distribute(PullKeyNew,hash(%CommaString%));
	DistOld:=distribute(PullKeyOld,hash(%CommaString%));
	#else
	LoadKeyNew:=index(#expand(recref),in_base);
	LoadKeyOld:=index(#expand(recref),in_father);
	PullKeyNew:=pull(LoadKeyNew);
	PullKeyOld:=pull(LoadKeyOld);
	RemoveNew:=project(PullKeyNew,transform(recordof(PullKeyNew)-[#expand(ignorefields)],Self:=Left;));
	RemoveOld:=project(PullKeyOld,transform(recordof(PullKeyOld)-[#expand(ignorefields)],Self:=Left;));
	DistNew:=distribute(RemoveNew,hash(%CommaString%));
	DistOld:=distribute(RemoveOld,hash(%CommaString%));
	#end;
#END;
	Package:=PackageName;
	Nickname:=InputKeyNickName;
	Base:=VersionBase;
	Father:=VersionFather;
	#DECLARE(DatasetString);
	#Set(DatasetString,'');
	#APPEND(DatasetString,'outrec:=record\n');
	#EXPORTXML(FieldList,recordof(DistNew));
	#FOR(FieldList)
		#FOR(field)
			#IF(%'@name'% in matchfields)
				#APPEND(DatasetString,'\t'+%'@type'%+'\t'+%'@name'%+';\n');
			#end
		#end
	#end
	#APPEND(DatasetString,'\tstring\tdiff;\n');
	#APPEND(DatasetString,'end;\n');
	#append(DatasetString,'outrec tDifferences(DistNew L, DistOld R):=transform\n');
		#APPEND(DatasetString,'Self.Diff:=ROWDIFF(L,R);\n');
		#APPEND(DatasetString,'Self:=L;\n');
	#APPEND(DatasetString,'end;\n');
	
	#append(DatasetString,'dDifferences:=join(DistNew,DistOld,\n');
	#Set(numField,1);
	#loop
		#IF(%numField%> Count(matchfields))
			#BREAK 
		#ELSE
			#APPEND(DatasetString,'\t\tLeft.'+matchfields[%numField%]+'= Right.'+matchfields[%numField%]);
			#if(%numField%!=Count(matchfields))
				#append(DatasetString,' and \n');
			#else
				#append(DatasetString,'\n');
			#end
		#end
		#SET(numField, %numField% + 1);
	#end
	
	#APPEND(DatasetString,',tDifferences(LEFT,RIGHT),local);\n');
	#APPEND(DatasetString,'DiffTable:=table(dDifferences,{Diff,cnt:=count(group)},Diff,merge);\n');
	
	
	#APPEND(DatasetString,'Results:=dataset([\n');
	#APPEND(DatasetString,'{Package,Nickname,Base,Father,\'NoChange\',(string)(sum(DiffTable(Diff=\'\'),cnt)),\'N\'}\n');
	#FOR(FieldList)
		#FOR(field)
			#IF(%'@name'% not in matchfields)
				#APPEND(DatasetString,',{Package,Nickname,Base,Father,\''+%'@name'%+'\',(string)(sum(DiffTable(STD.STR.FIND(Diff,\''+%'@name'%+'\',1)<>0),cnt)),\'N\'}\n');
			#end
		#end
	#end
	#APPEND(DatasetString,'],DOPSGrowthCheck.layouts.FieldChangeLayout);');
	%DatasetString%;
	#if(willPublish=false)
	// return output(%'commastring'%);
	return if(STD.File.FileExists(in_base)=true and STD.File.FileExists(in_father)=true,output(Results),output('One or Both of the files '+in_base+' and '+in_father+'do not exist'));
	#else
	
	PublishFile:=output(Results,,'~thor_data400::DeltaStats::ChangesByField::using::'+workunit+InputKeyNickName,thor,compressed,overwrite);

	AddFile:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::ChangesByField::using','~thor_data400::DeltaStats::ChangesByField::using::'+workunit+InputKeyNickName),
                      STD.File.FinishSuperFileTransaction()
                     );
										 
	return if(STD.File.FileExists(in_base)=true and STD.File.FileExists(in_father)=true,sequential(PublishFile,AddFile),output('One or Both of the files '+in_base+' and '+in_father+'do not exist'));
	#end

endmacro;