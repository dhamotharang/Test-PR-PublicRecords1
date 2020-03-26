Import PRTE2_Email_Data, dx_Email;

EXPORT Layouts := MODULE

Export Email_linkids_layout:=RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid;
  unsigned8 email_rec_key;
 END;

EXPORT Base_Ext := record
PRTE2_Email_Data.layouts.base;
string9 	clean_ssn;
unsigned4 clean_dob;
end;


EXPORT i_DID := record
dx_Email.Layouts.i_DID;
end;


EXPORT i_Email_Address := RECORD
dx_Email.Layouts.i_Email_Address;
END;

EXPORT i_Payload	:= RECORD
	dx_email.layouts.i_Payload
END;

END;