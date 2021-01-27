export DeleteRecords(FullData,NewData,recref,MatchFields,DistSet='',process_date,isDist=false,isLookup=false):=functionmacro
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

    #APPEND(CommandString,'dDeleteRecords:=join(dFullData,dNewData,');
	#append(CommandString,%'MatchString'%);
	#APPEND(CommandString,',transform(left)');
	#if(isLookup=false and isdist=false)
	#APPEND(CommandString,',left only);\n');
	
	#elseif(islookup)
	#append(CommandString,',left only,lookup);\n');
	
	#else
    #append(CommandString,',left only,local);\n');
    #end
    //#append(CommandString,'');
	
    effectivedate:=process_date;
	#append(CommandString,'RecordLayout tCreateDeletes(RecordLayout L):=TRANSFORM\n');
    #append(CommandString,'self.dt_effective_last:=(UNSIGNED4)effectivedate;\n');
    #append(CommandString,'self.dt_effective_first:=(UNSIGNED4)effectivedate;\n');
	#append(CommandString,'self.delta_ind:=3;\n');
    #append(CommandString,'self:=L;\n');
    #append(CommandString,'end;\n');

    #append(CommandString,'FinalDeletes:=project(dDeleteRecords,tCreateDeletes(left));\n');

    %CommandString%;

    return FinalDeletes;
	//return %'CommandString'%;

endmacro;