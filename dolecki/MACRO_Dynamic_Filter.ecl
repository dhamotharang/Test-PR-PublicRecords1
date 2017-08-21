export MACRO_Dynamic_Filter(attrname,ds,filter) := MACRO

	attrname := ds(#EXPAND(filter));

ENDMACRO;