export MAC_SetConvert (inSet, converter, outset, storename) :=
MACRO

#uniquename(ds)
#uniquename(inField)

%ds% := dataset(inSet, {TYPEOF(inSet[1]) %inField%});
outset := set(%ds%, converter(%inField%)) : STORED(storename);

ENDMACRO;