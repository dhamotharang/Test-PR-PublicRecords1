export getJoinCondition(joinFieldsArray) := functionmacro
 #uniquename(i); 
 #set(i, 1);
 #uniquename(joinCondition); 
  
 #loop
	 #if(%i% > count(joinFieldsArray))
	   #break
	 #elseif(%i% = 1)
			#if(joinFieldsArray[%i%] = 'self')
					   #set(joinCondition, 'left=right');
			#else
						#set(joinCondition, 'left.' + joinFieldsArray[%i%] + ' = right.' + joinFieldsArray[%i%]);
			#end//inner if
			 #set(i, %i% + 1);
	 #else
		   #append(joinCondition, ' and left.' + joinFieldsArray[%i%] + ' = right.' + joinFieldsArray[%i%]);
		   #set(i, %i% + 1);
	 #end //parent if end
 #end //loop end
 
 return %'joinCondition'%;

 
endmacro;