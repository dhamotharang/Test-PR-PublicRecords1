export Layout_WorldCheck_Base := module 

	// Child records
	export layout_POB := record
	   string50 Place_Of_Birth := '';
	end;
	export layout_Passports := record
	   string50 Passport := '';
	end;
	export layout_Locations := record
	   string50 Location := '';
	end;
	export layout_Countries := record
	   string50 Country := '';
	end;
	export layout_Companies := record
	   string50 Company := '';
	end;
	export layout_Linked_To_IDs := record
	   string50 Linked_To := '';
	end;
	export layout_Keywords := record
	   string30  Keyword           := '';
	   string150 Source_Name       := '';
	   string30  Authority_Country := '';
	end;
	export layout_Ext_Sources := record
	   string5000 External_Source := '';
	end;

	// Main file
	export Layout_WorldCheck_Fullfile := record
		string10                      UID;
		string255                     Orig_Last_Name;
		string255                     Orig_First_Name;
		string510                     Orig_Name; // May contain primary, alias, or alternate spelling
		string1                       Name_Type;  // 0 - Primary, 2 - AKA, 3 - Alternate Spelling
		string255                     Category;
		string255                     Title;
		string32                      Sub_Category;
		string255                     Position;
		string3                       Age;
		string10                      Orig_Date_Of_Birth;
		string10                      Orig_Date_Of_Death;
		string255                     Social_Security_Number;
		string1                       E_I_Ind;
		string2000                    Further_Information;
		string10                      Orig_Date_Entered;
		string10                      Orig_Date_Updated;
		string100                     Editor;
		string10                      Orig_Age_As_Of_Date;
		string73                      PName_Clean;
		string255                     CName_Clean;
		string8                       Date_Of_Birth;
		string8                       Date_of_Death;
		string8                       Date_Entered;
		string8                       Date_Updated;
		string8                       Age_As_Of_Date;
		dataset(layout_POB)           POB_detail;
		dataset(layout_Passports)     Passport_detail;
		dataset(layout_Locations)     Location_detail;
		dataset(layout_Countries)     Country_detail;
		dataset(layout_Companies)     Company_detail;
		dataset(layout_Linked_To_IDs) Linked_To_detail;
		dataset(layout_Keywords)      Keyword_detail;
		dataset(layout_Ext_Sources)   Ext_Src_detail;
	end;

end;  // End of the whole module