EXPORT PersistenceCheck(in_base,in_father,PackageName,InputKeyNickName,recref,rec_id,PersistentFields,DistSet,VersionBase,VersionFather,willPublish=true,iskey=true) := functionmacro
import std;
	Package:=PackageName;
	Nickname:=InputKeyNickName;
	Base:=VersionBase;
	Father:=VersionFather;
	#Declare(CommandString);
	#declare(CommaString);
	#Declare(numField);
	#Set(CommandString,'');
	#Set(CommaString,'');
	#Set(numField,1);
	#loop
		#IF(%numField%> Count(DistSet))
			#BREAK 
		#ELSE
			#append(CommaString,DistSet[%numField%]);
			#if(%numField%!=Count(DistSet))
				#append(CommaString,',');
			#end
		#end
		#SET(numField, %numField% + 1);
	#end
	#Set(numField,1);
#IF(iskey=false)
	LoadNew:=dataset(in_base,#expand(recref),thor);
	LoadOld:=dataset(in_father,#expand(recref),thor);
	DistNew:=distribute(LoadNew,hash(%CommaString%));
	DistOld:=distribute(LoadOld,hash(%CommaString%));
#ELSE	
	LoadKeyNew:=index(#expand(recref),in_base);
	LoadKeyOld:=index(#expand(recref),in_father);
	PullKeyNew:=pull(LoadKeyNew);
	PullKeyOld:=pull(LoadKeyOld);
	DistNew:=distribute(PullKeyNew,hash(%CommaString%));
	DistOld:=distribute(PullKeyOld,hash(%CommaString%));
#END;
#Append(CommandString,'Slim_Rec:=record\n');
	#loop 
		#IF(%numField%> Count(PersistentFields))
			#BREAK 
		#ELSE 
			#APPEND(CommandString,'DistNew.'+trim(PersistentFields[%numField%])+';\n');
		#end 
		#SET(numField, %numField% + 1);
	#end 
	#APPEND(CommandString,'DistNew.'+rec_id+';\n');
	#APPEND(CommandString,'end;\n');
	#Append(CommandString,'DiffRec:=record\n');
	#Set(numField,1);
	#loop 
		#IF(%numField%> Count(PersistentFields))
			#BREAK 
		#ELSE 
			#APPEND(CommandString,'DistNew.'+trim(PersistentFields[%numField%])+';\n');
		#end 
		#SET(numField, %numField% + 1);
	#end 
	#APPEND(CommandString,'string Diff;\n');
	#APPEND(CommandString,'end;\n');
	#APPEND(CommandString,'dSlimNew:=project(DistNew,transform(Slim_Rec,self:=left;));\n');
	#APPEND(CommandString,'dSlimOld:=project(DistOld,transform(Slim_Rec,self:=left;));\n');
	#APPEND(CommandString,'DiffRec tCheckPersistence(dSlimNew L, dSlimOld R):=transform\n');
	#APPEND(COmmandString,'Self.DIFF:=ROWDIFF(L,R);\n');
	#APPEND(CommandString,'Self:=L;\n');
	#APPEND(CommandString,'end;\n');
	#APPEND(CommandString,'dCheckPersistence:=join(dSlimNew,dSlimOld,');
	#Set(numField,1);
	#loop
		#IF(%numField%> Count(PersistentFields))
			#BREAK 
		#ELSE
			#append(CommandString,'Left.'+PersistentFields[%numField%]+' = Right.'+PersistentFields[%numField%]);
			#if(%numField%!=Count(PersistentFields))
				#append(CommandString,' AND ');
			#end
		#end
		#SET(numField, %numField% + 1);
	#end
	#APPEND(CommandString,',tCheckPersistence(Left,Right),local);\n');
	#APPEND(CommandString,'ResultTable:=Table(dCheckPersistence,{Diff,NumRecsChanged:=count(group)},Diff,merge);\n');
	#APPEND(CommandString,'AddMetaData:=project(ResultTable,transform(DopsGrowthCheck.layouts.PersistLayout,Self.PackageName:=Package;Self.KeyNickName:=Nickname;self.CurrVersion:=Base;self.PrevVersion:=Father;Self.Passed:=\'N\';Self.NumRecsChanged:=(string)Left.NumRecsChanged;Self:=left;));\n');
	
	#APPEND(CommandString,'results:=OUTPUT(AddMetaData);\n');
%CommandString%;
#if(willPublish=false)
	return if(STD.File.FileExists(in_base)=true and STD.File.FileExists(in_father)=true,Results,output('One or Both of the files '+in_base+' and '+in_father+'do not exist'));
	#else
	
	PublishFile:=output(AddMetaData,,'~thor_data400::DeltaStats::PersistenceCheck::using::'+workunit+InputKeyNickName,thor,compressed,overwrite);

	AddFile:=sequential(STD.FILE.StartSuperFileTransaction(),
                      STD.FILE.AddSuperFile('~thor_data400::DeltaStats::PersistenceCheck::using','~thor_data400::DeltaStats::PersistenceCheck::using::'+workunit+InputKeyNickName),
                      STD.File.FinishSuperFileTransaction()
                     );
										 
	return if(STD.File.FileExists(in_base)=true and STD.File.FileExists(in_father)=true,sequential(PublishFile,AddFile),output('One or Both of the files '+in_base+' and '+in_father+'do not exist'));
	#end
	
endmacro;