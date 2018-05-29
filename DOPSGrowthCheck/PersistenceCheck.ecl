EXPORT PersistenceCheck(in_base,in_father,PackageName,NickName,KeyRef,rec_id,PersistentFields,DistSet,VersionBase,VersionFather) := functionmacro
import std;

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
	DistNew:=distribute(in_base,hash(%'CommaString'%));
	DistOld:=distribute(in_father,hash(%'CommaString'%));
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
	#APPEND(CommandString,'ResultTable:=Table(dCheckPersistence,{Diff,cnt:=count(group)},Diff,merge);\n');
	#APPEND(CommandString,'result:=OUTPUT(ResultTable);\n');
// %CommandString%;
// return result;
return %'CommandString'%;
	
endmacro;