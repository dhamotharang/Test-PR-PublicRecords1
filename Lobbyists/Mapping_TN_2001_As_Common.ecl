import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_TN_2001 input) := transform

	self.Key := 'TN' + '2001' + hash64(input.Contl_Name,input.Contf_Name,input.Emp_Name);
	self.Process_Date := '20050520';
	self.Source_State := 'TN';
	self.Lobbyist_Name_Last	:= input.Contl_Name;
	self.Lobbyist_Name_First	:= input.Contf_Name;
	self.Firm_Name_Full	:= input.Firm_Name;
	self.Firm_Address_Street_Line	:= input.Address;
	self.Firm_Address_City	:= input.City;
	self.Firm_Address_State	:= input.State;
	self.Firm_Address_Zip	:= lib_stringlib.stringlib.stringfilter(input.Zip,'0123456789');
	self.Firm_Phone	:= lib_stringlib.stringlib.stringfilter(input.Phone,'0123456789');
	self.Association_Name_Full	:= input.Emp_Name;
	self.Association_Address_Street_Line	:= input.Emp_Add_1;
	self.Association_Address_CSZ_Line	:= input.Emp_Add_2;
	self.Association_Phone	:= lib_stringlib.stringlib.stringfilter(input.Emp_Phone,'0123456789');
	self.Lobby_Legislative_Year_Start := '2001';
	self.Lobby_Legislative_Year_End := '2001';
	self := [];
end;

export Mapping_TN_2001_As_Common := project(File_Lobbyists_TN_2001,MyTransform(left));