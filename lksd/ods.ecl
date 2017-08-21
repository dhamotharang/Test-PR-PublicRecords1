EXPORT ods(ds, modifier = '\'\'',over_write='false') := 
// functionMACRO
MACRO

#uniquename(str)
string %str% := if((string)modifier = '', '', (string)modifier);

// return output(ds,named(#text(ds)));
output(ds,,'~thor_data400::lksd.'+%str%+'.'+#text(ds)
#if(over_write)
	,overwrite
#end
);

ENDMACRO;