EXPORT ChangesByField(in_base,in_father,PackageName,InputKeyNickName,recref,rec_id,ignorefields='',VersionBase,VersionFather,willPublish=true,iskey=true) := functionmacro
import std;
#IF(iskey=false)
	#if(ignorefields='')
	LoadNew:=dataset(in_base,#expand(recref),thor);
	LoadOld:=dataset(in_father,#expand(recref),thor);
	DistNew:=distribute(LoadNew,hash(#expand(rec_id)));
	DistOld:=distribute(LoadOld,hash(#expand(rec_id)));
	#else
	LoadNew:=dataset(in_base,#expand(recref),thor);
	LoadOld:=dataset(in_father,#expand(recref),thor);
	RemoveNew:=project(LoadNew,transform(recordof(LoadNew)-[#expand(ignorefields)],Self:=Left;));
	RemoveOld:=project(LoadOld,transform(recordof(LoadOld)-[#expand(ignorefields)],Self:=Left;));
	DistNew:=distribute(RemoveNew,hash(#expand(rec_id)));
	DistOld:=distribute(RemoveOld,hash(#expand(rec_id)));
	#end;
#ELSE	
	#if(ignorefields='')
	LoadKeyNew:=index(#expand(recref),in_base);
	LoadKeyOld:=index(#expand(recref),in_father);
	PullKeyNew:=pull(LoadKeyNew);
	PullKeyOld:=pull(LoadKeyOld);
	DistNew:=distribute(PullKeyNew,hash(#expand(rec_id)));
	DistOld:=distribute(PullKeyOld,hash(#expand(rec_id)));
	#else
	LoadKeyNew:=index(#expand(recref),in_base);
	LoadKeyOld:=index(#expand(recref),in_father);
	PullKeyNew:=pull(LoadKeyNew);
	PullKeyOld:=pull(LoadKeyOld);
	RemoveNew:=project(PullKeyNew,transform(recordof(PullKeyNew)-[#expand(ignorefields)],Self:=Left;));
	RemoveOld:=project(PullKeyOld,transform(recordof(PullKeyOld)-[#expand(ignorefields)],Self:=Left;));
	DistNew:=distribute(RemoveNew,hash(#expand(rec_id)));
	DistOld:=distribute(RemoveOld,hash(#expand(rec_id)));
	#end;
#END;
	outrec:=record
	string PersistentRecID;
	string Diff;
	end;
	
	outrec tDifferences(DistNew L, DistOld R):=transform
		Self.PersistentRecID:=(String)L.#expand(rec_id);
		Self.Diff:=ROWDIFF(L,R);
	end;
	
	dDifferences:=join(DistNew,DistOld,Left.#expand(rec_id)=Right.#expand(rec_id),tDifferences(left,Right),local);
	
	DiffTable:=table(dDifferences,{Diff,cnt:=count(group)},Diff,merge);
	
	Package:=PackageName;
	Nickname:=InputKeyNickName;
	Base:=VersionBase;
	Father:=VersionFather;
	
	#DECLARE(DatasetString);
	#SET(DatasetString,'Results:=dataset([\n');
	#APPEND(DatasetString,'{Package,Nickname,Base,Father,\'NoChange\',(string)(sum(DiffTable(Diff=\'\'),cnt)),\'N\'}\n');
	#EXPORTXML(FieldList,recordof(DistNew));
	#FOR(FieldList)
		#FOR(field)
			#APPEND(DatasetString,',{Package,Nickname,Base,Father,\''+%'@name'%+'\',(string)(sum(DiffTable(STD.STR.FIND(Diff,\''+%'@name'%+'\',1)<>0),cnt)),\'N\'}\n');
		#end
	#end
	#APPEND(DatasetString,'],DOPSGrowthCheck.layouts.FieldChangeLayout);');
	%DatasetString%;
	#if(willPublish=false)
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