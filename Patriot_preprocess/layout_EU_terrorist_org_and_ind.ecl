
EXPORT layout_EU_terrorist_org_and_ind := module


// individuals
export layout_individual := record
  string Subject_to_Common_Pos_2001_931_CFSP;
  string Datax;
  string Full_Name;
  string First_Name;
  string Last_Name;
  string Date_of_Birth;
  string Alt_DoB_1;
  string Alt_DoB_2;
  string Individual_ID;
  string AKA;
  string Passport;
  string ID_Card;
  string ETA_Membership;
  string Other_Membership;
  string Citizenship;
  string Born_In;
end;

export layout_individual_slim := record
  string Subject_to_Common_Pos_2001_931_CFSP;
  string First_Name;
  string Last_Name;
  string Date_of_Birth;
  string Alt_DoB_1;
  string Alt_DoB_2;
  string Individual_ID;
  string AKA;
  string Passport;
  string ID_Card;
  string ETA_Membership;
  string Other_Membership;
  string Citizenship;
  string Born_In;
end;

export layout_names_and_AKAS := record
  string Subject_to_Common_Pos_2001_931_CFSP;
  string name;
	string name_type;
  string Date_of_Birth;
  string Alt_DoB_1;
  string Alt_DoB_2;
  string Individual_ID;
  string Passport;
  string ID_Card;
  string ETA_Membership;
  string Other_Membership;
  string Citizenship;
  string Born_In;
end;

// groups
export layout_groups := record
  string RECORDNO;
	string UNPARSED_DATA;
	string SFLAG;
	string GROUPNAME;
	string UNPARSED_NAMES; 
end;

export layout_concat_all_names := record
string recordno;
string concat_all_names;
end;

end;