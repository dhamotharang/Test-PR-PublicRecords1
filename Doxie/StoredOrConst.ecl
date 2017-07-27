export StoredOrConst(vartype, varname, nullvalue, inputname, isConst = false, constVal) := 
MACRO


#if(isConst)
#CONSTANT(inputName,constVal);
#end

vartype varname := nullvalue : STORED(inputname);

ENDMACRO;