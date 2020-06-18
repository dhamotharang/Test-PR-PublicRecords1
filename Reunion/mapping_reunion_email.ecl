EXPORT mapping_reunion_email(unsigned1 mode, STRING sVersion) := MODULE

//-----------------------------------------------------------------------------
// Builds the email file
//-----------------------------------------------------------------------------
EXPORT all := Reunion.fn_add_email(reunion.files(mode).dMain);

END;