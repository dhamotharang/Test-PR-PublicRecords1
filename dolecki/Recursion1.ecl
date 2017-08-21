import buzzsaw;

export Recursion1(attrname, i) := MACRO
	LOADXML('<xml/>');

	#CONSTANT('i',i)
	#DECLARE (SetString)
	#DECLARE (Ndx)
	
	#SET (SetString, '[') //initialize SetString to [
	#SET (Ndx, 1) //initialize Ndx to 1
	
	#LOOP
		#IF (%Ndx% > i) //if we've iterated 9 times
			#BREAK // break out of the loop
		#ELSE //otherwise
			#APPEND (SetString, %'Ndx'% + ',')

		//append Ndx and comma to SetString
		#SET (Ndx, %Ndx% + 1)
	
	//and increment the value of Ndx
	#END
	#END
	#APPEND (SetString, %'Ndx'% + ']') //add 10th element and closing ]
	
	attrname := %'SetString'%; //generate the ECL code

ENDMACRO;