// Crosstab of Corporate Records by State of Origin
Corp_State_Origin_Crosstab_Rec := RECORD
Corporate.File_Corp4_Base.state_origin;
record_count := COUNT(GROUP);
END;

Corp_State_Origin_Crosstab := TABLE(Corporate.File_Corp4_Base, Corp_State_Origin_Crosstab_Rec, state_origin, FEW);
OUTPUT(Corp_State_Origin_Crosstab);

// Crosstab of Corporate Records by Clean State
Corp_State_Crosstab_Rec := RECORD
Corporate.File_Corp4_Base.state;
record_count := COUNT(GROUP);
END;

Corp_State_Crosstab := TABLE(Corporate.File_Corp4_Base, Corp_State_Crosstab_Rec, state, FEW);
OUTPUT(Corp_State_Crosstab);

// Crosstab of Corporate Contacts by State of Origin
Corp_Contacts_State_Origin_Crosstab_Rec := RECORD
Corporate.File_Corp_Contacts.state_origin;
record_count := COUNT(GROUP);
END;

Corp_Contacts_State_Origin_Crosstab := TABLE(Corporate.File_Corp_Contacts, Corp_Contacts_State_Origin_Crosstab_Rec, state_origin, FEW);
OUTPUT(Corp_Contacts_State_Origin_Crosstab);

// Crosstab of Corporate Contacts by Clean State
Corp_Contacts_State_Crosstab_Rec := RECORD
Corporate.File_Corp_Contacts.state;
record_count := COUNT(GROUP);
END;

Corp_Contacts_State_Crosstab := TABLE(Corporate.File_Corp_Contacts, Corp_Contacts_State_Crosstab_Rec, state, FEW);
OUTPUT(Corp_Contacts_State_Crosstab);