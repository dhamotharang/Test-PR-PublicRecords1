export MAC_EnumerateRecords(rset_in, rset_out) := MACRO
#UNIQUENAME(new_rset_type)
#UNIQUENAME(xform_name)

%new_rset_type% := RECORD
	UNSIGNED4 recNo;
	rset_in;
END;

%new_rset_type% %xform_name%(rset_in L, INTEGER c) := TRANSFORM
	SELF := L;
	SELF.recNo := c;
END;

rset_out := PROJECT(rset_in, %xform_name%(LEFT, COUNTER));
ENDMACRO;
