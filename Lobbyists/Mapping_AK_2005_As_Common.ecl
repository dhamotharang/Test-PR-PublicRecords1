import lib_stringlib;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_AK_2005 input) := transform

	self.Key := 'AK' + hash64(input.Lobbyist,input.Address);
	self.Process_Date := '20050923';
	self.Source_State := 'AK';
	lobbyistiscompany := func_is_company (input.Lobbyist);
	self.Lobbyist_Name_Full	:= if(lobbyistiscompany, '', input.Lobbyist);
	self.Firm_Name_Full := if (lobbyistiscompany, input.Lobbyist, '');
	self.Lobbyist_Address_Whole	:= if(lobbyistiscompany, '', input.Address);
	self.Firm_Address_Whole := if(lobbyistiscompany, input.Address, '');
	self.Lobbyist_Phone	:= if(lobbyistiscompany, '', lib_stringlib.stringlib.stringfilter(input.Phone, '0123456789'));
	self.Firm_Phone := if(lobbyistiscompany, lib_stringlib.stringlib.stringfilter(input.Phone, '0123456789'), '');
	self.Association_Name_Full := input.Client_Employer;
	self.Lobbyist_Type := input.Lobbyist_Type;
	self.Lobby_Subject := input.Subject;
	self.Lobby_Legislative_Year_Start := '2005';
	self.Lobby_Legislative_Year_End := '2005';
	self := [];
end;

export Mapping_AK_2005_As_Common := project(File_Lobbyists_AK_2005,MyTransform(left));