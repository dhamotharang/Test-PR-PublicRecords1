EXPORT ChangesByField(in_base,in_father,PackageName,NickName,KeyRef,rec_id,ignorefields='',VersionBase,VersionFather) := functionmacro
import std;
	#if(ignorefields='')
	DistNew:=distribute(in_base,hash(#expand(rec_id)));
	DistOld:=distribute(in_father,hash(#expand(rec_id)));
	#else
	RemoveNew:=project(in_base,transform(recordof(in_base)-[#expand(ignorefields)],Self:=Left;));
	RemoveOld:=project(in_father,transform(recordof(in_father)-[#expand(ignorefields)],Self:=Left;));
	DistNew:=distribute(RemoveNew,hash(#expand(rec_id)));
	DistOld:=distribute(RemoveOld,hash(#expand(rec_id)));
	#end;
	
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
	
	#DECLARE(DatasetString);
	#SET(DatasetString,'Results:=dataset([\n');
	#APPEND(DatasetString,'{\''+PackageName+'\',\''+NickName+'\',\''+VersionBase+'\',\''+VersionFather+'\',\'NoChange\',(string)(sum(DiffTable(Diff=\'\'),cnt))}\n');
	#EXPORTXML(FieldList,recordof(DistNew));
	#FOR(FieldList)
		#FOR(field)
			#APPEND(DatasetString,',{\''+PackageName+'\',\''+NickName+'\',\''+VersionBase+'\',\''+VersionFather+'\',\''+%'@name'%+'\',(string)(sum(DiffTable(STD.STR.FIND(Diff,\''+%'@name'%+'\',1)<>0),cnt))}\n');
		#end
	#end
	#APPEND(DatasetString,'],DOPSGrowthCheck.layouts.FieldChangeLayout);');
	%DatasetString%;
	return Results;

endmacro;