EXPORT Layout_Directorate_Defense_Trade_Controls_Debarred_Parties := module

export layout_Debarred_Parties := record
  string name_info;
  string DOB;
  string registration_info;
  string Date;
end;

export layout_names_and_AKAS := record
  string sequence;
  string name;
	string name_type;
	string DOB;
  string registration_info;
  string Date;
end;

end;
