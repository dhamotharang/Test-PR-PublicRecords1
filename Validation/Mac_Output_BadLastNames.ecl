export Mac_Output_BadLastNames(in_ds, in_field) :=
MACRO
import Validation;

#uniquename(r)
#uniquename(cnt)
#uniquename(t)
%r% := RECORD
	in_ds.in_field;
	%cnt% := COUNT(GROUP);
END;
%t% := TABLE(in_ds,%r%,in_field,few);

#uniquename(tra)
%r% %tra%(%t% le, Validation.File_LastNames ri) := TRANSFORM
	SELF := le;
END;

#uniquename(j)
%j% := JOIN(%t%,Validation.File_LastNames,LEFT.lname=RIGHT.name,%tra%(LEFT,RIGHT),LEFT ONLY,HASH);

output(CHOOSEN(SORT(%j%,-%cnt%), 1000));


ENDMACRO;