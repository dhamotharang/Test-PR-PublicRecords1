
EXPORT Fetch_BC_State_LFName (STRING2 state_key, STRING20 firstname_key, STRING20 lastname_key,
                              boolean f_loose=false, boolean l_loose=false) := 
	Business_Header.Fetch_BC_Full(Business_Header.Fetch_BC_Key_State_LFName(state_key, firstname_key, lastname_key,
																																					f_loose,l_loose));