export Layout_WorldCheck_in := record, maxlength(100000)
    string  UID;
    string  Last_Name;
    string  First_Name;
    string  Aliases;                // Multiple values, ";" delimited
    string  Alternate_Spelling;     // Multiple values, ";" delimited
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
    string  Locations;              // Multiple values, ";" delimited
    string  Countries;
    string  Companies;              // Multiple values, ";" delimited
    string  E_I_Ind;
    string  Linked_Tos;             // Multiple values, ";" delimited
    string  Further_Information;
    string  Keywords;               // Multiple values, "~" delimited
    string  External_Sources;       // Multiple values, " " (space) delimited
    string  Entered;
    string  Updated;
    string  Editor;
    string  Age_As_Of_Date;
end;

