import address;

export All_Entiera_Layouts := module

export Entiera_Autokey_layout :=record
Layouts.Base_For_Indexes;
unsigned1 zero := 0;
string1   blank:='';
end;

export Entiera_household_id_fixed := record
Layouts.Base_For_Indexes;
string13 household_id;
string13 individual_id;
end;

export Entiera_individual_id_fixed := record
Layouts.Base_For_Indexes;
string13 individual_id;
end;

export Entiera_email_address_fixed := record
Layouts.Base_For_Indexes and not [process_date,did_score,orig_e360_id,orig_teramedia_id];
string60 Email_addr1;
string60 Email_addr2;
end;

export Entiera_final_layout	:= Layouts.Base_For_Indexes;	// For external references (queries)

end;