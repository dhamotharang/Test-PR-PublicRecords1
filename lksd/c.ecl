EXPORT c(ds) := 
// functionMACRO
MACRO


// return output(ds,named(#text(ds)));
output(count(ds),named('count_' + #text(ds)));

ENDMACRO;