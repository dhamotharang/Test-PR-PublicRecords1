import address;
file1 := Fictitious_Business_Names.File_Out_AllFlat(cct_lastname !=''or cct_firstname !='' or cct_suffix !='');

Layout_Clean_Name := record
  string73 combine_cct_name;
  string73 clean_cct_name;
	Fictitious_Business_Names.Layout_In_InfoUSA_Flat;
end;

Layout_Clean_Name trans_cleanname(file1 l) := Transform
self.combine_cct_name := trim(l.cct_firstname,left,right) + ' ' + trim(l.cct_lastname,left,right) + ' ' + trim(l.cct_suffix,left,right);
self.clean_cct_name:= address.CleanPersonfml73(self.combine_cct_name); 
self := l;
end;

file_clean_names := Project(file1,trans_cleanname(left));

output(file_clean_names(clean_cct_name[71..73]<'085'))