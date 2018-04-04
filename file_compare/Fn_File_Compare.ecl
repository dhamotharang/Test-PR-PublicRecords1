import std;

EXPORT Fn_File_Compare(OldFile,NewFile,ImportantFields='',IgnoreFields='', DistributeFields = '',useImportant=false,useIgnore=false,useDistribute=false, publish=false,datasetName='',fileType='',Version='') := functionmacro
			
	
	ConcatinatedFile:=OldFile+NewFile;
		#IF(useImportant)
			#DECLARE(CommaString);
			#DECLARE(ConditionString);
			#DECLARE(FieldCount);
			#SET(CommaString,'');
			#SET(ConditionString,'');
			#SET(FieldCount,0);
			#EXPORTXML(FieldList,ImportantFields);
			#FOR(FieldList)
				#FOR(field)
					#IF(%FieldCount%>0)
						#APPEND(CommaString,',');
						#APPEND(ConditionString,' AND ');
					#END
					#SET(fieldCount, %fieldCount% + 1);
					#APPEND(CommaString,%'@name'%);
					#APPEND(ConditionString,'Left.' + %'@name'% + ' = Right.' + %'@name'%);	
				#END
			#END
		#END
		
		#IF(useIgnore)
			#DECLARE(FieldCount2);
			#DECLARE(IgnoreComma);
			#SET(IgnoreComma,'');
			#SET(FieldCount2,0);
			#EXPORTXML(IgnoreList,IgnoreFields);
			#FOR(IgnoreList)
				#FOR(field)
					#IF(%FieldCount2%>0)
						#APPEND(IgnoreComma,',');
					#END
					#SET(FieldCount2, %FieldCount2% + 1);
					#APPEND(IgnoreComma,%'@name'%);
				#END
			#END
		#END
		
		#IF(useDistribute)
			#DECLARE(FieldCount3);
			#DECLARE(DistributeComma);
			#SET(DistributeComma,'');
			#SET(FieldCount3,0);
			#EXPORTXML(DistributeList,DistributeFields);
			#FOR(DistributeList)
				#FOR(field)
					#IF(%FieldCount3%>0)
						#APPEND(DistributeComma,',');
					#END
					#SET(FieldCount3, %FieldCount3% + 1);
					#APPEND(DistributeComma,%'@name'%);
				#END
			#END
		#END
		
		#IF(useIgnore)
			RedcuedRecord:=record
				recordof(OldFile)-[%IgnoreComma%];
			end;
			#ELSE
			RedcuedRecord:=record
				recordof(OldFile);
			end;
			#END
		RowDiffLayout:=record
				String250 DiffExpanded;
				String250 DiffBits;
			end;
			
			RowDiffLayout tRowDiff(RedcuedRecord L, RedcuedRecord R):=transform
				SELF.DiffExpanded	:=	ROWDIFF(L,R);
				SELF.DiffBits	:=	ROWDIFF(L, R, COUNT);		
			end;	
	#IF(useImportant)
		#IF(useIgnore)
			
			
			ReducedOldFile:=project(OldFile,transform(RedcuedRecord,Self:=Left;));
			ReducedNewFile:=project(NewFile,transform(RedcuedRecord,Self:=Left;));
			
			#IF(useDistribute)
			SortedDistConCat:=Sort(Distribute(ConcatinatedFile,hash(%DistributeComma%)),record,except %IgnoreComma%,local);
			SortedDistConCatImp:=Sort(Distribute(ConcatinatedFile,hash(%DistributeComma%)),%CommaString%,local);
			SortDistOldFile:=Sort(Distribute(OldFile,hash(%DistributeComma%)),record,except %IgnoreComma%,local);
			SortDistNewFile:=Sort(Distribute(NewFile,hash(%DistributeComma%)),record,except %IgnoreComma%,local);
			FullRecDedup:=dedup(SortedDistConCat,record,except %IgnoreComma%,local);
			RollupDedup:=dedup(SortedDistConCatImp,%CommaString%,local);
			RollOldFileDedup:=dedup(SortDistOldFile,%CommaString%,local);
			RollNewFileDedup:=dedup(SortDistNewFile,%CommaString%,local);
			
			CalcRowDiff:=join(distribute(ReducedOldFile,hash(%DistributeComma%)),distribute(ReducedNewFile,hash(%DistributeComma%)),%ConditionString%,tRowDiff(Left,Right),LOCAL);
			LeftOnly:=join(distribute(ReducedOldFile,hash(%DistributeComma%)),distribute(ReducedNewFile,hash(%DistributeComma%)),%ConditionString%,left only,local);
			RightOnly:=join(distribute(ReducedOldFile,hash(%DistributeComma%)),distribute(ReducedNewFile,hash(%DistributeComma%)),%ConditionString%,right only,local);
			
			AggregateDiff:=sort(table(distribute(CalcRowDiff,hash(DiffExpanded)),{DiffExpanded,cnt:=count(group)},DiffExpanded,merge),-cnt);
			#ELSE
			SortedDistConCat:=Sort(ConcatinatedFile,record,except %IgnoreComma%);
			SortedDistConCatImp:=Sort(ConcatinatedFile,%CommaString%);
			SortDistOldFile:=Sort(OldFile,record,except %IgnoreComma%);
			SortDistNewFile:=Sort(NewFile,record,except %IgnoreComma%);
			FullRecDedup:=dedup(SortedDistConCat,record,except %IgnoreComma%);
			RollupDedup:=dedup(SortedDistConCat,%CommaString%);
			RollOldFileDedup:=dedup(SortDistOldFile,%CommaString%);
			RollNewFileDedup:=dedup(SortDistNewFile,%CommaString%);
			
			CalcRowDiff:=join(ReducedOldFile,ReducedNewFile,%ConditionString%,tRowDiff(Left,Right));
			LeftOnly:=join(ReducedOldFile,ReducedNewFile,%ConditionString%,left only);
			RightOnly:=join(ReducedOldFile,ReducedNewFile,%ConditionString%,right only);
			
			AggregateDiff:=sort(table(distribute(CalcRowDiff,hash(DiffExpanded)),{DiffExpanded,cnt:=count(group)},DiffExpanded,merge),-cnt);
			#END
		#else
			
			ReducedOldFile:=project(OldFile,transform(RedcuedRecord,Self:=Left;));
			ReducedNewFile:=project(NewFile,transform(RedcuedRecord,Self:=Left;));
			
			#IF(useDistribute)
			SortedDistConCat:=Sort(Distribute(ConcatinatedFile,hash(%DistributeComma%)),record,local);
			SortedDistConCatImp:=Sort(Distribute(ConcatinatedFile,hash(%DistributeComma%)),%CommaString%,local);
			SortDistOldFile:=Sort(Distribute(OldFile,hash(%DistributeComma%)),record,local);
			SortDistNewFile:=Sort(Distribute(NewFile,hash(%DistributeComma%)),record,local);
			FullRecDedup:=dedup(SortedDistConCat,record,local);
			RollupDedup:=dedup(SortedDistConCatImp,%CommaString%,local);
			RollOldFileDedup:=dedup(SortDistOldFile,%CommaString%,local);
			RollNewFileDedup:=dedup(SortDistNewFile,%CommaString%,local);
			
			CalcRowDiff:=join(distribute(ReducedOldFile,hash(%DistributeComma%)),distribute(ReducedNewFile,hash(%DistributeComma%)),%ConditionString%,tRowDiff(Left,Right),LOCAL);
			LeftOnly:=join(distribute(ReducedOldFile,hash(%DistributeComma%)),distribute(ReducedNewFile,hash(%DistributeComma%)),%ConditionString%,left only,local);
			RightOnly:=join(distribute(ReducedOldFile,hash(%DistributeComma%)),distribute(ReducedNewFile,hash(%DistributeComma%)),%ConditionString%,right only,local);
			
			AggregateDiff:=sort(table(distribute(CalcRowDiff,hash(DiffExpanded)),{DiffExpanded,cnt:=count(group)},DiffExpanded,merge),-cnt);
			#ELSE
			SortedDistConCat:=Sort(ConcatinatedFile,record);
			SortedDistConCat:=Sort(ConcatinatedFile,%CommaString%);
			SortDistOldFile:=Sort(OldFile,record);
			SortDistNewFile:=Sort(NewFile,record);
			FullRecDedup:=dedup(SortedDistConCat,record);
			RollupDedup:=dedup(SortedDistConCat,%CommaString%);
			RollOldFileDedup:=dedup(SortDistOldFile,%CommaString%);
			RollNewFileDedup:=dedup(SortDistNewFile,%CommaString%);
			
			CalcRowDiff:=join(ReducedOldFile,ReducedNewFile,%ConditionString%,tRowDiff(Left,Right));
			LeftOnly:=join(ReducedOldFile,ReducedNewFile,%ConditionString%,left only);
			RightOnly:=join(ReducedOldFile,ReducedNewFile,%ConditionString%,right only);
			
			AggregateDiff:=sort(table(distribute(CalcRowDiff,hash(DiffExpanded)),{DiffExpanded,cnt:=count(group)},DiffExpanded,merge),-cnt);
			#END
		#end
	#else
		#IF(useIgnore)
			#IF(useDistribute)
			SortedDistConCat:=Sort(Distribute(ConcatinatedFile,hash(%DistributeComma%)),record,except %IgnoreComma%,local);
			FullRecDedup:=dedup(SortedDistConCat,record,except %IgnoreComma%,local);
			#ELSE
			SortedDistConCat:=Sort(ConcatinatedFile,record,except %IgnoreComma%);
			FullRecDedup:=dedup(SortedDistConCat,record,except %IgnoreComma%);
			#END
		#else
			#IF(useDistribute)
			SortedDistConCat:=Sort(Distribute(ConcatinatedFile,hash(%DistributeComma%)),record,local);
			FullRecDedup:=dedup(SortedDistConCat,record,local);
			#ELSE
			SortedDistConCat:=Sort(ConcatinatedFile,record);
			FullRecDedup:=dedup(SortedDistConCat,record);
			#END
		#end
	#end
	
	#IF(UseImportant)
			NumUniqueOldFile	:=count(RollOldFileDedup);
			NumUniqueNewFile	:=count(RollNewFileDedup);
			NumReducedOldFile	:=count(ReducedOldFile);
			NumDedupCombined	:=count(RollupDedup);
			PercentChangeImportant:=(real)((((real)NumDedupCombined-(real)NumUniqueOldFile)/((real)NumUniqueOldFile))*100);
			NumLeftOnly				:=count(LeftOnly);
			NumRightOnly			:=count(RightOnly);
			ImpSuperFile:='~thor_data400::file_compare::ImportantFieldResults';
			ImpIndividLog:='~thor_data400::file_compare::'+datasetName+'::ImportantFieldResults';
			ImpOldEntries:=dataset(ImpIndividLog,file_compare.Layouts.ImportantFieldsResultsLayout,thor,opt);
			ImpNewEntry		:=dataset([{datasetName,
																fileType,
																Version,
																%'CommaString'%,
																workunit,
																NumUniqueOldFile,
																NumUniqueNewFile,
																NumDedupCombined,
																NumLeftOnly,
																NumRightOnly,
																(real)((((real)NumDedupCombined-(real)NumUniqueOldFile)/((real)NumUniqueOldFile))*100),
																(real)((((real)NumLeftOnly)/((real)NumReducedOldFile))*100),
																(real)((((real)NumRightOnly)/((real)NumReducedOldFile))*100)}],file_compare.Layouts.ImportantFieldsResultsLayout);
			
			PublishImportant:=sequential(
												output(ImpOldEntries+ImpNewEntry,,ImpIndividLog+fileType+'_'+workunit,thor,overwrite),
												output(ImpNewEntry,named('ImpRecStats'+filetype)),
												nothor(global(sequential(if(std.file.FileExists(ImpIndividLog),
																sequential(STD.File.StartSuperFileTransaction(),
																STD.File.ClearSuperFile(ImpIndividLog,true),
																STD.File.FinishSuperFileTransaction())),
												STD.File.StartSuperFileTransaction(),
												STD.File.AddSuperFile(ImpIndividLog,ImpIndividLog+fileType+'_'+workunit),
												STD.File.FinishSuperFileTransaction()))));
			#END
			NumOldFile:=count(OldFile);
			NumNewFile:=count(NewFile);
			NumDedupFullRec:=count(FullRecDedup);
			PercentChangeFull:=(real)((((real)NumDedupFullRec-(real)NumOldFile)/((real)NumOldFile))*100);
			FullSuperFile:='~thor_data400::file_compare::FullRecordResults';
			FullIndividLog:='~thor_data400::file_compare::'+datasetName+'::FullRecordResults';
			FullOldEntries:=dataset(FullIndividLog,file_compare.Layouts.FullFileResultsLayout,thor,opt);
			FullNewEntry		:=dataset([{datasetName,fileType,Version,workunit,NumOldFile,NumNewFile,NumDedupFullRec,(real)((((real)NumDedupFullRec-(real)NumOldFile)/((real)NumOldFile))*100)}],file_compare.Layouts.FullFileResultsLayout);
			PublishFull:=sequential(
												output(FullOldEntries+FullNewEntry,,FullIndividLog+fileType+'_'+workunit,thor,overwrite),
												output(FullNewEntry,named('FullRecStats'+filetype)),
												nothor(global(sequential(if(std.file.FileExists(FullIndividLog),
																sequential(STD.File.StartSuperFileTransaction(),
																STD.File.ClearSuperFile(FullIndividLog,true),
																STD.File.FinishSuperFileTransaction())),
												STD.File.StartSuperFileTransaction(),
												STD.File.AddSuperFile(FullIndividLog,FullIndividLog+fileType+'_'+workunit),
												STD.File.FinishSuperFileTransaction()))));									
	
	
	return ordered(
					output(NumDedupFullRec,named('NumDedupFullRec'+filetype))
					,output(NumOldFile,named('NumOldFile'+filetype))
					,output(NumNewFile,named('NumNewFile'+filetype))
					,output(PercentChangeFull,named('PercentChangeFull'+filetype))
					#if(publish)
					,PublishFull
					#end
					#if(useImportant)
					,output(NumDedupCombined,named('NumDedupCombined'+filetype))
					,output(NumUniqueOldFile,named('NumUniqueOldFile'+filetype))
					,output(NumUniqueNewFile,named('NumUniqueNewFile'+filetype))
					,output(PercentChangeImportant,named('PercentChangeImportant'+filetype))
					,output(AggregateDiff,named('AggregateDiff'+filetype))
					#if(publish)
					,PublishImportant
					#end
					#end
					);
endmacro;