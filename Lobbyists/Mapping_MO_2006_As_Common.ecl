import lib_stringlib;

My_Extra_Phone_Layout := record
  Layout_Lobbyists_MO_2006;
	string Lobbyist_Single_Phone_1;
	string Lobbyist_Single_Phone_2;
end;

MyTwoPhonePattern := '^(.*) OR (.*)$';

My_Extra_Phone_Layout MyExtraPhone1Transform(Layout_Lobbyists_MO_2006 InputRecord, integer PassNumber) 
												:= transform
	self.Lobbyist_Single_Phone_1 				:= if(regexfind(MyTwoPhonePattern,InputRecord.Lobbyist_Phone_1),
												regexfind(MyTwoPhonePattern,InputRecord.Lobbyist_Phone_1,PassNumber),
												InputRecord.Lobbyist_Phone_1);
	self.Lobbyist_Single_Phone_2 				:= '';
	self 										:= InputRecord;
end;

MyExtraPhone1DS 								:= normalize(File_Lobbyists_MO_2006,
												if(regexfind(MyTwoPhonePattern,
												left.Lobbyist_Phone_1),
												2,
												1),
												MyExtraPhone1Transform(left,counter));

My_Extra_Phone_Layout MyExtraPhone2Transform(My_Extra_Phone_Layout InputRecord, integer PassNumber) 
												:= transform
	self.Lobbyist_Single_Phone_2 				:= if(regexfind(MyTwoPhonePattern,InputRecord.Lobbyist_Phone_2),
												regexfind(MyTwoPhonePattern,InputRecord.Lobbyist_Phone_2,PassNumber),
												InputRecord.Lobbyist_Phone_2);
	self 										:= InputRecord;
end;

MyExtraPhone2DS 								:= normalize(MyExtraPhone1DS,
												if(regexfind(MyTwoPhonePattern,
												left.Lobbyist_Phone_2),
												2,
												1),
												MyExtraPhone2Transform(left,counter));
														 
Layout_Lobbyists_Common MyTransform(My_Extra_Phone_Layout InputRecord, integer PassNumber) 
												:= transform
	self.Key 									:= 'MO' + hash64(InputRecord.Lobbyist_State_ID,InputRecord.Principal_Name);
	self.Process_Date 							:= '20060323';
	self.Source_State 							:= 'MO';
	self.Lobbyist_State_ID 						:= InputRecord.Lobbyist_State_ID;
	self.Lobbyist_Name_Last 					:= InputRecord.Lobbyist_Name_Last;
	self.Lobbyist_Name_First 					:= InputRecord.Lobbyist_Name_First;
	Address1IsAddress 							:= stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1_Or_Firm[1..8]) = 'P.O. BOX' or
												stringlib.StringToUpperCase(InputRecord.Lobbyist_Address_Street_1_Or_Firm[1..6]) = 'PO BOX' or
												(InputRecord.Lobbyist_Address_Street_1_Or_Firm[1] >= '0' and
												InputRecord.Lobbyist_Address_Street_1_Or_Firm[1] <= '9');
	
	self.Lobbyist_Address_Street_Line 			:= trim(if(Address1IsAddress,
	                                            trim(InputRecord.Lobbyist_Address_Street_1_Or_Firm,left,right) + ' ',
												'') +
												trim(InputRecord.Lobbyist_Address_Street_2,left,right));
	
	self.Lobbyist_Address_City 					:= InputRecord.Lobbyist_Address_City;
	self.Lobbyist_Address_State 				:= InputRecord.Lobbyist_Address_State;
	self.Lobbyist_Address_ZIP 					:= InputRecord.Lobbyist_Address_ZIP;
	self.Association_Name_Full 					:= InputRecord.Principal_Name;
	
	DateFinder 									:= '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';

	self.Lobbyist_Phone 						:= lib_stringlib.StringLib.StringFilter(choose(PassNumber,InputRecord.Lobbyist_Single_Phone_1,InputRecord.Lobbyist_Single_Phone_2),'0123456789');
	self.Firm_Name_Full 						:= if(Address1IsAddress,'',InputRecord.Lobbyist_Address_Street_1_Or_Firm);
	self.Firm_Address_Street_Line 				:= if(Address1IsAddress,'',InputRecord.Lobbyist_Address_Street_2);
	self.Firm_Address_City 						:= if(Address1IsAddress,'',InputRecord.Lobbyist_Address_City);
	self.Firm_Address_State 					:= if(Address1IsAddress,'',InputRecord.Lobbyist_Address_State);
	self.Firm_Address_ZIP 						:= if(Address1IsAddress,'',InputRecord.Lobbyist_Address_ZIP);
	self.Firm_Phone 							:= if(Address1IsAddress,
												'',
												lib_stringlib.StringLib.StringFilter(choose(PassNumber,InputRecord.Lobbyist_Single_Phone_1,InputRecord.Lobbyist_Single_Phone_2),'0123456789'));
												
	self.Lobby_Legislative_Year_Start 			:= '2006';
												
	self.Lobby_Legislative_Year_End 			:= '2006';
												
	self 										:= [];
end;

export Mapping_MO_2006_As_Common := normalize(MyExtraPhone2DS,
                                                   if(lib_stringlib.StringLib.StringFilter(left.Lobbyist_Single_Phone_2,'0123456789') <> '',
																										2,
																										1),
																									 MyTransform(left,counter));