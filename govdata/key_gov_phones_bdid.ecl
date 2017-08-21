import	BIPV2;

df := project(govdata.File_Gov_Phones_Base(bdid != 0),transform(Layout_Gov_Phones_Base - BIPV2.IDlayouts.l_xlink_IDs,self:=left;));

export key_gov_phones_bdid := index(df,{bdid},{df},govdata.keynames().EmployeeDirsbdid.qa);
