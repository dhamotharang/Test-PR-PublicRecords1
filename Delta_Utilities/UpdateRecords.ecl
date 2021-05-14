export UpdateRecords(FullData,NewData,recref,MatchFields,UpdateFields,process_date,DistSet='',isDist=false,isLookup=false):=functionmacro
#Declare(CommandString);
	#declare(CommaString);
	#declare(MatchString);
	#declare(UpdateString);
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
	#Set(numField,1);
	#set(UpdateString,'self.updated:=map(');

	#loop
		#IF(%numField%> Count(UpdateFields))
			#BREAK 
		#ELSE
			#append(UpdateString,'L.'+UpdateFields[%numField%]+' <> R.'+UpdateFields[%numField%]+'=>TRUE,\n');
		#end
		#SET(numField, %numField% + 1);
	#end
	#append(UpdateString,'FALSE);\n')
    #if(isdist=false or isLookup)
        dFullData:=fulldata;
        dNewData:=newData;
    #Else
        dFullData:=distribute(fulldata,hash(%CommaString%));
        dNewData:=distribute(newData,hash(%CommaString%));
    #end;
	RecordLayout:=#expand(recref);;
    RecordLayoutTemp:=RECORD
		RecordLayout;
		boolean updated;
	END;
	effectivedate:=process_date;
    #append(CommandString,'RecordLayoutTemp tCreateUpdates(RecordLayout L, RecordLayout R):=TRANSFORM\n');
    #append(CommandString,'self.record_sid:=L.record_sid;\n');
	#append(CommandString,%'UpdateString'%);
	#append(CommandString,'self.dt_effective_first:=(UNSIGNED4)effectivedate;\n');
	#append(CommandString,'self.delta_ind:=2;\n');
    #append(CommandString,'self:=R;\n');
    #append(CommandString,'end;\n');

    #APPEND(CommandString,'dUpdateRecordsTemp:=join(dFullData,dNewData,');
	#append(CommandString,%'MatchString'%);
	#APPEND(CommandString,',tCreateUpdates(left,right)');
	#if(isLookup=false and isdist=false)
	#append(CommandString,');\n');
	
	#elseif(islookup)
    #append(CommandString,',lookup);\n');
    #else
    #append(CommandString,',local);\n');
    #end
    //#append(CommandString,'');
	#append(CommandString,'dUpdateRecords:=project(dUpdateRecordsTemp(updated),transform(RecordLayout,self:=Left;));\n')
    %CommandString%;

    return dUpdateRecords;
	//return %'CommandString'%;

endmacro;