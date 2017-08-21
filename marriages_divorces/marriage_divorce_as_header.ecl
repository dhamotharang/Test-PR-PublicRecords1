import marriages_divorces,lib_keylib,lib_fileservices,ut,Business_Header,Header;

marriage_divorce_base := marriages_divorces.marriage_divorce_as_source;

Header.Layout_New_Records Translate_Marriage_Divorce_to_Header1(marriage_divorce_base l) := transform
 self.did                      := 0;
 self.rid                      := 0;
 self.pflag1                   := '';
 self.pflag2                   := '';
 self.pflag3                   := '';
 //self.src                      := '';
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_last_reported  := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_nonglb_last_seen      := 0;
 self.rec_type                 := '';
 self.vendor_id                := ''; //Assign later
 self.phone                    := '';
 self.dob                      := (integer4)l.dob;
 self.cbsa                     := '';
 self.tnt                      := '';
 self.valid_SSN                := '';
 self.jflag1                   := '';
 self.jflag2                   := '';
 self.jflag3                   := '';
 self                          := l;
end;

marriage_divorce_project := project(marriage_divorce_base,Translate_Marriage_Divorce_to_Header(left));

export marriage_divorce_as_header := marriage_divorce_project(lname != '' and prim_name != '' and zip != '');