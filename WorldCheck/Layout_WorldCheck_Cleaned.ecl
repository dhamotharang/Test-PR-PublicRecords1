import Standard;

export Layout_WorldCheck_Cleaned := Module

	// Child record layouts
	export layout_POB := record
	   string50 Place_Of_Birth := '';
	end;

	export layout_Passports := record
	   string50 Passport := '';
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

    // Main record layout
	export Layout_WorldCheck_Main :=  record,maxlength(30900)
		unsigned8                     Key;
		integer4                      UID;
		string255                     Name_Orig;
		string1                       Name_Type;
		string255                     Last_Name;
		string255                     First_Name;
		string255                     Category;
		string255                     WC_Title;
		string32                      Sub_Category;
		string255                     Position;
		String3                       Age;
		string8                       Date_Of_Birth;
		dataset(layout_POB)           POB_detail;
		string8                       Date_Of_Death;
		dataset(layout_Passports)     Passport_detail;
		string25                      Social_Security_Number;
	    string30                      Address_1 := '';
	    string30                      Address_2 := '';
	    string30                      Address_3 := '';
	    string30                      Address_Country := '';
		dataset(layout_Countries)     Country_detail;
		dataset(layout_Companies)     Company_detail;
		string1                       E_I_Ind;
		dataset(layout_Linked_To_IDs) Linked_To_detail;
		string5000                    Further_Information;
		dataset(layout_Keywords)      Keyword_detail;
		string8                       Entered;
		string8                       Updated;
		string30                      Editor;
		string8                       Age_As_Of_Date;
		Standard.Name;
		string100                     cname;
		Standard.L_Address.detailed;
		//unsigned8 					  append_Rawaid;
	end;

end;
