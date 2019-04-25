//Gets Transform logic for applying normalization
//Parameters:
//OutputFields: Fields that appear in the output file after the normalize function
//CorrespondingInputFields: Fields from the parent file that are normalized 
//																					into the output fields
EXPORT getTransformLogic(outputFields, correspondingInputFields) := functionmacro

 #uniquename(transformLogic)
 #set(transformLogic, 'transform ')
 #uniquename(i)
 #set(i,1)
  #loop
    #if(%i% > count(outputFields))
      #break
    #else
			#append(transformLogic, 'self.' + outputFields[%i%] + ':=' + correspondingInputFields[%i%] + ';' )
      #set(i,%i%+1)
    #end//end if
  #end//end loop
	
	#append(transformLogic, 'self:= l; end;')
	
	return %'transformLogic'%;
endmacro;