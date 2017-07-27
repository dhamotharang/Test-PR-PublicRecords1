IMPORT Business_Header, ut;
#workunit ('name', 'Build Business_Contacts_Output');

/////////////////////////////////////////////////////////
// Create the Business Contacts Output File
/////////////////////////////////////////////////////////
bc_local := Business_Header.BC_Out;
Business_Header.Layout_Business_Contact_Out fixcontdates(bc_local L) := transform
  self.dt_first_seen := IF((integer)L.dt_first_seen > (integer)stringlib.GetDateYYYYMMDD(), stringlib.GetDateYYYYMMDD(), L.dt_first_seen);
  self.dt_last_seen := IF((integer)L.dt_last_seen > (integer)stringlib.GetDateYYYYMMDD(), stringlib.GetDateYYYYMMDD(), L.dt_last_seen);
  self := L;
end;
bc_local_fix := project(bc_local, fixcontdates(left));
bc_local_out := OUTPUT(bc_local_fix,,'OUT::Business_Contacts', OVERWRITE);

/////////////////////////////////////////////////////////
// Create the Employment/People at Work Output File
/////////////////////////////////////////////////////////
emp_local := Business_Header.Emp_Out;
Business_Header.Layout_Employment_Out fixempdates(emp_local L) := transform
  self.dt_first_seen := IF((integer)L.dt_first_seen > (integer)stringlib.GetDateYYYYMMDD(), stringlib.GetDateYYYYMMDD(), L.dt_first_seen);
  self.dt_last_seen := IF((integer)L.dt_last_seen > (integer)stringlib.GetDateYYYYMMDD(), stringlib.GetDateYYYYMMDD(), L.dt_last_seen);
  self := L;
end;
emp_local_fix := project(emp_local, fixempdates(left));
emp_local_out := OUTPUT(emp_local_fix,,'OUT::Employment', OVERWRITE);

/////////////////////////////////////////////////////////
// run the output files and counts
/////////////////////////////////////////////////////////
sequential(bc_local_out,emp_local_out);

count(business_header.File_Business_Contacts_Out((integer) did > 0));
count(business_header.File_Employment_Out((integer) did > 0));
count(business_header.File_Business_Contacts_Out((integer)dt_first_seen > (integer)stringlib.GetDateYYYYMMDD()));
count(business_header.File_Business_Contacts_Out((integer)dt_last_seen > (integer)stringlib.GetDateYYYYMMDD()));
count(business_header.File_Employment_Out((integer)dt_first_seen > (integer)stringlib.GetDateYYYYMMDD()));
count(business_header.File_Employment_Out((integer)dt_last_seen > (integer)stringlib.GetDateYYYYMMDD()));
