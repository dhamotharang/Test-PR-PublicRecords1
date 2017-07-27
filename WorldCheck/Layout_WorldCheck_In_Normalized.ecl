export Layout_WorldCheck_In_Normalized := record, maxlength(30900)
    string  UID;
	unsigned8 key;
	string255 name_orig;
	string1   Name_Type;
    string  Last_Name;
    string  First_Name;
    string  Category;
    string  Title;
    string  Sub_Category;
    string  Position;
    string  Age;
    string  Date_Of_Birth;
    string  Places_Of_Birth;        // Multiple values, ";" delimited
    string  Date_Of_Death;
    string  Passports;              // Possible restricted information?
    string  Social_Security_Number; // Possible restricted information? Currently blank
    string  Location;              // Multiple values, ";" delimited
    string  Countries;
    string  Companies;              // Multiple values, ";" delimited
    string  E_I_Ind;
    string  Linked_Tos;             // Multiple values, ";" delimited
    string5000  Further_Information;
    string  Keywords;               // Multiple values, "~" delimited
    string5000  External_Sources;       // Multiple values, " " (space) delimited
    string  Entered;
    string  Updated;
    string  Editor;
    string  Age_As_Of_Date;
end;