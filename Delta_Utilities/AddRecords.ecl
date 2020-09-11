export AddRecords(FullData,NewData,recref,MatchFields,DistSet='',isDist=false,isLookup=false):=functionmacro

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

    #APPEND(CommandString,'dAddRecords:=join(dFullData,dNewData,');
	#append(CommandString,%'MatchString'%);
	#APPEND(CommandString,',transform(right)');
	#if(isLookup=false)
	#APPEND(CommandString,',right only');
	#end
	#if(isdist=false or islookup)
    #append(CommandString,');\n');
    #else
    #append(CommandString,',local);\n');
    #end
    //#append(CommandString,'');
	#if(islookup)
	#APPEND(CommandString,'dAddRecordsFinal:=join(dAddRecords,dNewData,');
	#append(CommandString,%'MatchString'%);
	#APPEND(CommandString,',transform(right),right only);\n');
	#else
	#APPEND(CommandString,'dAddRecordsFinal:=dAddRecords;\n');
	#end
	
    #append(CommandString,'PrevBase := MAX(dFullData,Record_Sid);\n');

    #append(CommandString,'RecordLayout tCreateAdds(RecordLayout L, RecordLayout R):=TRANSFORM\n');
    #append(CommandString,'SELF.Record_Sid:=IF (l.Record_Sid=0, PrevBase+1, l.Record_Sid+thorlib.nodes());\n');
    #append(CommandString,'self.delta_ind:=1;\n');
    #append(CommandString,'self:=R;\n');
    #append(CommandString,'end;\n');

    #append(CommandString,'FinalAdds:=iterate(dAddRecordsFinal,tCreateAdds(left,right));\n');

    //%CommandString%;

    //return FinalAdds;
	return %'CommandString'%;


endmacro;