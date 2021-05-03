
EXPORT mapping_reunion_college(unsigned1 mode, STRING sVersion) := MODULE

//-----------------------------------------------------------------------------
// Builds the college file
//-----------------------------------------------------------------------------
EXPORT all := Reunion.fn_add_college(reunion.files(mode).dMain);

END;