 
export Layout_DL_Wildcard := record
	qstring24    					dl_number;	
	unsigned6    					dl_seq;          
	BIG_ENDIAN unsigned1 	orig_state;
	BIG_ENDIAN unsigned1 	years_since_1900;
	string1      					gender;
end;