/* *****FUNCTION DEFINITION**********
This function macro outputs the desired variable/dataset contents and names it by the name of that variable/dataset
without EVER running into overwrite/extend issues! 
In the process it appends a random number to the end of the output name thus making each name unique.
************** */
EXPORT out(outParam,namePrefix=''):=FUNCTIONMACRO
	RETURN OUTPUT(outParam,NAMED(#TEXT(namePrefix)+'_'+#TEXT(outParam)+'_'+(unsigned2)RANDOM())); 
ENDMACRO;
/*
Examples:

str:='someText';
bool:=TRUE;
ds:=dataset([{'Mark','Smith'}],{STRING20 fn,STRING20 ln});

ut.out(str);
ut.out(bool);
ut.out(ds,attributeName); //passing in the second optional parameter will append that name to the start of the output name

The main advantage of this function is that if your named 'outputs' are in an attribute that gets called more than once, you will 
NOT get -> "Error: Duplicate output...EXTEND/OVERWRITE required" but rather each output will be returned sequentially with a different number appended.
*/