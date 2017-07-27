Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_NJ_1995_2005 input) := transform

	self.Key := 'NJ' + hash64(input.Name,input.Company);
	self.Process_Date := '20050608';
	self.Source_State := 'NJ';
	self.Lobbyist_Name_Full	:= input.Name;
	self.Lobbyist_Address_Street_Line	:= trim(input.Addr1,left,right) + ' ' +
																			 trim(input.Addr2,left,right);
	self.Lobbyist_Address_CSZ_Line	:= input.Cit_St_Zip;
	self.Association_Name_Full	:= input.Company;
	self := [];
end;

export Mapping_NJ_1995_2005_As_Common := project(File_Lobbyists_NJ_1995_2005,MyTransform(left));