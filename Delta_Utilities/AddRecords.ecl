export AddRecords(FullData,NewData,MatchFields,DistSet,isLookup=false):=functionmacro

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
	#APPEND(CommandString,',transform(right),right only');
    #if(count(distset)=0)
    #append(CommandString,');\n');
    #else
    #append(CommandString,',local)\n');
    #end
    //#append(CommandString,'');
    #append(CommandString,'PrevBase := MAX(distcurr,Record_Sid);\n');

    #append(CommandString,'RecordLayout tCreateAdds(RecordLayout L, RecordLayout R):=TRANSFORM\n');
    #append(CommandString,'SELF.Record_Sid:=IF (l.Record_Sid=0, PrevBase+1, l.Record_Sid+thorlib.nodes());\n');
    #append(CommandString,'self.delta_ind:=1;\n');
    #append(CommandString,'self:=R;\n');
    #append(CommandString,'end;');

    #append(CommandString,'FinalAdds:=iterate(dAddRecords,tCreateAdds(left,right));\n');

    %CommandString%;

    return FinalAdds
END;

endmacro;