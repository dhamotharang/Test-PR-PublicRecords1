EXPORT rds(ds, modifier = '\'\'') := 
functionMACRO
// MACRO

#uniquename(str)
string %str% := if((string)modifier = '', '', (string)modifier);

// return output(ds,named(#text(ds)));
return dataset('~thor_data400::lksd.'+%str%+'.'+#text(ds), {ds}, thor);

ENDMACRO;