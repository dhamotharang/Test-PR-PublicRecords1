export DeleteRecords(FullData,NewData,MatchFields,DistSet,process_date):=functionmacro

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

    #if(count(distset)<>0)
        dFullData:=fulldata;
        dNewData:=newData;
    #Else
        dFullData:=distribute(fulldata,hash(%CommaString%));
        dNewData:=distribute(newData,hash(%CommaString%));
    #end;

    RecordLayout:=recordof(FullData);

    #APPEND(CommandString,'dAddRecords:=join(dFullData,dNewData,');
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
	#APPEND(CommandString,',transform(left),left only');
    #if(count(distset)=0)
    #append(CommandString,');\n');
    #else
    #append(CommandString,',local)\n');
    #end

    #append(CommandString,'RecordLayout tCreateDeletes(RecordLayout L):=TRANSFORM\n');
    #append(CommandString,'self.dt_effective_last:=process_date;\n');
    #append(CommandString,'self.dt_effective_first:=process_date;\n');
    #append(CommandString,'self:=L;\n');
    #append(CommandString,'end;\n');

    #append(CommandString,'FinalDeletes:=project(FindDeletes,tCreateDeletes(left));\n');

    %CommandString%;

    return FinalDeletes;

endmacro;