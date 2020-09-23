export UpdateRecords(FullData,NewData,recref,MatchFields,DistSet='',process_date,isDist=false,isLookup=false):=functionmacro
#Declare(CommandString);
	#declare(CommaString);
	#declare(MatchString);
	#Declare(numField);
	#Set(CommandString,'');
	#Set(CommaString,'');
	#set(MatchString,'');
	#Set(numField,1);
	#if(isdist)
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
	#end;
	#loop
		#IF(%numField%> Count(MatchFields))
			#BREAK 
		#ELSE
			#append(MatchString,'Left.'+MatchFields[%numField%]+' = Right.'+MatchFields[%numField%]);
			#if(%numField%!=Count(MatchFields))
				#append(MatchString,' AND ');
			#end
		#end
		#SET(numField, %numField% + 1);
	#end
    #if(isdist=false or isLookup)
        dFullData:=fulldata;
        dNewData:=newData;
    #Else
        dFullData:=distribute(fulldata,hash(%CommaString%));
        dNewData:=distribute(newData,hash(%CommaString%));
    #end;

    RecordLayout:=#expand(recref);

    #append(CommandString,'RecordLayout tCreateUpdates(RecordLayout L, RecordLayout R):=TRANSFORM\n');
    #append(CommandString,'self.record_sid:=L.record_sid\n');
    #append(CommandString,'self:=R;\n');
    #append(CommandString,'end;\n');

    #APPEND(CommandString,'dUpdateRecords:=join(dFullData,dNewData,');
	#append(CommandString,%'MatchString'%);
	#APPEND(CommandString,',tCreateUpdates(left,right)');
	#if(isLookup=false and isdist=false)
	#append(CommandString,');\n');
	#end
	#if(islookup)
    #append(CommandString,'lookup);\n');
    #else
    #append(CommandString,',local);\n');
    #end
    //#append(CommandString,'');
	#if(islookup)
	#APPEND(CommandString,'dUpdateRecordsFinal:=join(dDeleteRecords,dNewData,');
	#append(CommandString,%'MatchString'%);
	#APPEND(CommandString,',transform(left),left only);\n');
	#else
	#APPEND(CommandString,'dDeleteRecordsFinal:=dDeleteRecords;\n');
	#end
	

    #append(CommandString,'FinalDeletes:=project(dDeleteRecordsFinal,tCreateDeletes(left));\n');

    %CommandString%;

    return FinalDeletes;
	//return %'CommandString'%;

endmacro;