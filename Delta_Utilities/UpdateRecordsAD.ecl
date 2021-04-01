export UpdateRecordsAD(FullData,NewData,recref,MatchFields,UpdateFields,process_date,DistSet='',isDist=false,isLookup=false):=functionmacro
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
    
	RecordLayoutNoSid:=RECORD
		RecordLayout-[Record_Sid];
	END;

	RecordLayoutTemp:=RECORD
		UNSIGNED8 record_sid;
		boolean updated;
		RecordLayoutNoSid OldRec;
		RecordLayoutNoSid NewRec;
	END;
	effectivedate:=process_date;
    #append(CommandString,'RecordLayoutTemp tCreateUpdates(RecordLayout L, RecordLayout R):=TRANSFORM\n');
    #append(CommandString,'self.record_sid:=L.record_sid;\n');
	#append(CommandString,%'UpdateString'%);
	#append(CommandString,'self.NewRec.dt_effective_first:=(UNSIGNED4)effectivedate;\n');
	#append(CommandString,'self.OldRec.dt_effective_last:=(UNSIGNED4)effectivedate;\n');
	#append(CommandString,'self.NewRec.delta_ind:=1;\n');
	#append(CommandString,'self.OldRec.delta_ind:=3;\n');
	#append(CommandString,'self.OldRec:=L;\n');
	#append(CommandString,'self.NewRec:=R;\n');
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
	#append(CommandString,'dUpdateRecordsAdds:=project(dUpdateRecordsTemp,\n');
    #append(CommandString,'transform(RecordLayout,self.record_sid:=left.record+sid; self:=Left.NewRec;));\n');
	#append(CommandString,'dUpdateRecordsDeletes:=project(dUpdateRecordsTemp,\n');
    #append(CommandString,'transform(RecordLayout,self.record_sid:=left.record+sid; self:=Left.OldRec;));\n');
	
	%CommandString%;

    return dUpdateRecordsAdds+dUpdateRecordsDeletes;
	//return %'CommandString'%;

endmacro;