EXPORT getKnownIssuesJoinCondition(joinFieldsSet, excludeFieldsSet) := functionmacro
 #uniquename(i); 
 #set(i, 1);
 #uniquename(joinCondition); 
  
 #loop
	 #if(%i% > count(joinFieldsSet))
	   #break
	 #elseif(%i% = 1 and (joinFieldsSet[%i%] not in excludeFieldsSet))
			#if(joinFieldsSet[%i%] = 'self')
					   #set(joinCondition, 'left=right');
			#else
						#set(joinCondition, 'left.' + joinFieldsSet[%i%] + ' = right.' + joinFieldsSet[%i%]);
			#end//inner if
			 #set(i, %i% + 1);
	 #elseif(joinFieldsSet[%i%] not in excludeFieldsSet)
		   #append(joinCondition, ' and left.' + joinFieldsSet[%i%] + ' = right.' + joinFieldsSet[%i%]);
		   #set(i, %i% + 1);
	 #else
			#set(i, %i% + 1);
	 #end //parent if end
 #end //loop end
 
 return %'joinCondition'%;

 
endmacro;