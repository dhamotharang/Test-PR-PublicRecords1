EXPORT Layout_State_Dept_Foreign_Terrorist_Orgs := module

EXPORT layout_foreign_terrorists := record
  string Organization;
  string AKA;
end;

export layout_names_and_AKAS := record
  string sequence;
  string name;
	string name_type;
end;

end;
