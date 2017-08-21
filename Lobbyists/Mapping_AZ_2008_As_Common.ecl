import lib_stringlib,ut;

Layout_Lobbyists_Common MyTransform(Layout_Lobbyists_AZ_2008 input) := transform

	self.Key := 'AZ' + hash64(input.Lob_ID, input.PPB_ID);
	self.Process_Date := '20080317';
	self.Source_State := 'AZ';
	self.Lobbyist_State_Id := input.Lob_ID;
	self.Lobbyist_Name_Last	:= if(input.Lob_First = '', '', input.Lob_Last);
	self.Lobbyist_Name_First	:= if(input.Lob_First = '', '', input.Lob_First); 
	self.Lobbyist_Address_Street_Line	:= if(input.Lob_First = '', '', 
											  trim(input.Lob_Addr1,left,right) + ' ' +
											  trim(input.Lob_Addr2,left,right));
	self.Lobbyist_Address_City	:= if(input.Lob_First = '', '', input.Lob_City);
	self.Lobbyist_Address_State	:= if(input.Lob_First = '', '', input.Lob_State);
	self.Lobbyist_Address_Zip	:= if(input.Lob_First = '', '', lib_stringlib.stringlib.stringfilter(input.Lob_Zip,'0123456789'));
	self.Lobbyist_Phone	:= if(input.Lob_First = '', '', lib_stringlib.stringlib.stringfilter(input.Lob_Phone,'0123456789'));
	self.Lobbyist_Fax := lib_stringlib.stringlib.stringfilter(input.Lob_Fax,'0123456789');
	self.Lobbyist_Email := input.Lob_Email;
	self.Firm_Name_Full := if(input.Lob_First = '', input.Lob_Last, '');
	self.Firm_Address_Street_Line := if(input.Lob_First = '',  
									    trim(input.Lob_Addr1,left,right) + ' ' +
									    trim(input.Lob_Addr2,left,right),'');
	self.Firm_Address_City := if(input.Lob_First = '', input.Lob_City,'');
	self.Firm_Address_State := if(input.Lob_First = '', input.Lob_State,''); 
	self.Firm_Address_Zip := if(input.Lob_First = '', lib_stringlib.stringlib.stringfilter(input.Lob_Zip,'0123456789'),'');
	self.Firm_Phone := if(input.Lob_First = '', lib_stringlib.stringlib.stringfilter(input.Lob_Phone,'0123456789'),'');
	self.Association_State_ID := input.PPB_ID;
	self.Association_Name_Full := input.PPB_Name;
	self.Association_Contact_Name_Full := input.PPB_Contact;
	self.Association_Address_Street_Line := trim(input.PPB_Addr1,left,right) + ' ' +
										    trim(input.PPB_Addr2,left,right);
	self.Association_Address_City := input.PPB_City;
	self.Association_Address_State := input.PPB_State;
	self.Association_Address_Zip := lib_stringlib.stringlib.stringfilter(input.PPB_Zip,'0123456789');
	self.Association_Phone := lib_stringlib.stringlib.stringfilter(input.PPB_Phone,'0123456789');
	self.Lobby_Legislative_Year_Start := '2007';
	self.Lobby_Legislative_Year_End := '2007';
	self := [];
end;

export Mapping_AZ_2008_As_Common := project(File_Lobbyists_AZ_2008,MyTransform(left));