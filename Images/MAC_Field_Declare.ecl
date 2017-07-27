export MAC_Field_Declare :=
MACRO

	string2 state_val	:= '' : stored('state');
	string2 rtype_val := '' : stored('rtype');
	state_value := stringlib.stringtouppercase(state_val);
	rtype_value := stringlib.stringtouppercase(rtype_val);
	string60 id_value 	:= '' : stored('id');
	string8 date_b_value := '' : stored('b_date');
	string8 date_e_value := '' : stored('e_date');
	string14 did_value	:= '' : stored('did');
	set of unsigned6 did_values := [] : stored('dids');
	did_data := dataset([],images.Layout_DidSearch) : stored('didData',few);
	integer4 seq_b_value := -1 : stored('b_seq');
	integer4 seq_e_value := -1 : stored('e_seq');
	integer4 seq_value	:= -1 : stored('seq');
	boolean is_a_neighbor := false : stored('isANeighbor');
	set of string256 neighbor_service := [] : stored('NeighborService');
	neighbor_data := dataset([],doxie.Layout_Neighbors) : stored('NeighborData',few);

	// For logging
	string30 fname_val := '' : stored('FirstName');
	string30 lname_val := '' : stored('LastName');
	string30 mname_val := '' : stored('MiddleName');
	string9 ssn_value := '' : stored('ssn');
	fname_value := stringlib.stringtouppercase(fname_val);
	lname_value := stringlib.stringtouppercase(lname_val);
	mname_value := stringlib.stringtouppercase(mname_val);
	
ENDMACRO;