import Bair;

export MAC_Join(res, leftDS, rightDS, linkflags) := macro
#uniquename(j)
	%j% := JOIN(leftDS,rightDS,#EXPAND(linkflags));
#uniquename(res)
	res	:= %j% + rightDS;
endmacro;