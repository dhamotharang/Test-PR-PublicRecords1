ds_case        := sort(CRIM.File_OR_Raw_Case         ,court_type,court_location,case_number);
ds_Case_Courts := dedup(CRIM.File_OR_Lookup_Codes(Table_Type                         = 'TB11'
                                              AND length(trim(table_key,left,right)) = 3)
                       ,Table_Key);

// Add the case court name using the code lookup table
layout_case_with_court_name := record
   Crim.Layout_OR_Case AND NOT [Record_Type];
   string40 case_court_name;
end;

// Create a layout that includes the name of the court that is derived from the code table lookup
layout_case_with_court_name jCourtName (ds_case L, ds_Case_Courts R) := transform
   self                 := L;
   self.case_court_name := R.Full_Description[1..40];
end;

ds_case_court := join(ds_case, ds_Case_Courts
                     ,LEFT.Court_Location = Right.Table_Key
					 ,jCourtName(left,right)
					 ,left outer
					 ,lookup);
					 
ds_crim_cases     := distribute(ds_case_court ,hash32(court_type,court_location,case_number));

export Name_OR_Case_Courts := ds_crim_cases : PERSIST('~thor_dell400::persist::CrimCourt_OR_Cases_With_Court_Name');