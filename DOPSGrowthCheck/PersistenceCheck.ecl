EXPORT PersistenceCheck(in_base,in_father,PackageName,NickName,KeyRef,rec_id,PersistentFields,VersionBase,VersionFather) := functionmacro
import std;

	#Declare(CommandString);
	#Declare(numField);
	#Set(CommandString,'');
	#Set(numField,1);
	#APPEND(CommandString,'DistNew:=distribute(in_base,hash(#expand(rec_id)));\n');
	#APPEND(CommandString,'DistOld:=distribute(in_father,hash(#expand(rec_id)));\n');
	#Append(CommandString,'Slim_Rec:=record\n');
	#loop 
		#IF(%numField%> Count(inFields))
			#BREAK 
		#ELSE 
			#APPEND(CommandString,',{\''+PackageName+'\',\''+KeyNickName+'\',\''+VersionBase+'\',\''+VersionFather+'\',\''+trim(inFields[%numField%])+'\',\'Delta_Added\','+'((string)((((real)count(Differences('+trim(inFields[%numField%])+'_added=true)))/((real)(Total)))*100)),((string)count(Differences('+trim(inFields[%numField%])+'_added=true))),\'N\'}\n');
			#APPEND(CommandString,'string '+trim(PersistentFields[%numField%])';\n');
		#end 
		#SET(numField, %numField% + 1);
	#end 
	#APPEND(CommandString,'string '+trim(PersistentFields[%numField%])';\n');
	#APPEND(CommandString,'end;\n');
	#APPEND(CommandString,'dSlimNew:=project(DistNew,transform(Slim_Rec,self:=left;));\n');
	#APPEND(CommandString,'dSlimOld:=project(DistOld,transform(Slim_Rec,self:=left;));\n');
	
	
end;