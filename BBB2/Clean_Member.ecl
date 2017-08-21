import ut, Business_Header, Business_Header_SS, did_add,address,lib_stringlib, BIPV2;

export Clean_Member(

	 string																pversion
	,dataset(Layouts_Files.Input.Member)	pInputFile
	,string																pPersistName = PersistNames.CleanMember

) := 
function

BBB_Member_In 		:= pInputFile;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Parse out Address 1 and 2 fields
//////////////////////////////////////////////////////////////////////////////////////////////
layout_BBB_Member_parse_address := 
record
	BBB_Member_In;
	string address1;
	string address2;
end;

// Count comma characters in string
unsigned1 CommaCount(string s) := length(trim(stringlib.stringfilter(s, ',')));

// Add unique sequence number to input
layout_BBB_Member_parse_address ParseAddress(BBB_Member_In l) := 
transform
	self.address1	:= if(l.address <> '', ut.CleanSpacesAndUpper(l.address[1..(stringlib.stringfind(l.address, ',', (CommaCount(l.address) - 2)) -1)]), '');
	self.address2	:= if(l.address <> '', ut.CleanSpacesAndUpper(l.address[(stringlib.stringfind(l.address, ',', (CommaCount(l.address) - 2)) +2)..]), '');
	self 		:= l;
end;

BBB_Parse_Address := project(BBB_Member_In, ParseAddress(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Standardize the phone
//////////////////////////////////////////////////////////////////////////////////////////////
layout_BBB_clean := 
record
	layout_BBB_Member_parse_address;
	string182 clean_address;
	string10  phone10;
end;

layout_BBB_clean CleanInput(layout_BBB_Member_parse_address l) := 
transform
	//*** Using old address cleaned values to determine the foreign addresses before creating the address prep fields for AID call.
	self.clean_address	:= Address.cleanAddress182(l.address1, l.address2);
	self.phone10		:= if(l.phone <> '', Address.CleanPhone(trim(l.phone,all)), '');
	self				:= l;
end;

BBB_clean := project(BBB_Parse_Address, CleanInput(left));

//*** Strip a comma character after the state and between the zip code and also strip of the hypen and zip4 if any.
//*** Function Converts the given string in "city, state, zip-zip4" into "city, state zip" ex:- Springboro, OH, 45066-1230 to Springboro, OH 45066
string Fn_formatCityStZip(string s) := function
	str1   := if(CommaCount(s) = 2, s[1..stringlib.StringFind(s,',',2)-1] + ' '+ stringlib.stringcleanspaces(s[stringlib.StringFind(s,',',2)+1..])[1..5], s);
	return stringlib.stringcleanspaces(str1);
end;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert Input File to Base Format
//////////////////////////////////////////////////////////////////////////////////////////////
Layouts_Files.Base.Member_BIP Input2Base(layout_bbb_clean l) := 
transform
	self.process_date_first_seen	:= (unsigned4)version;
	self.process_date_last_seen 	:= self.process_date_first_seen;
	self.record_type							:= 'C';
	self.report_date 							:= intformat((unsigned2) l.listing_year, 4, 1) +
																	 intformat((unsigned1) l.listing_month, 2, 1) +
																	 intformat((unsigned1) l.listing_day, 2, 1);
	//since the source contains the date as in yyyy-mm-dd just remove the dash from source
	//self.member_since_date 		:= map(Stringlib.StringToUpperCase(l.member_attr_name1) = 'MEMBER SINCE' => l.member_attr1[7..10] + l.member_attr1[1..2] + l.member_attr1[4..5],
						//	Stringlib.StringToUpperCase(l.member_attr_name2) = 'MEMBER SINCE' => l.member_attr2[7..10] + l.member_attr2[1..2] + l.member_attr2[4..5],
							//	'');
	self.member_since_date 				:= map( lib_stringlib.stringlib.stringfind(l.member_attr1,'/',1) = 2 and lib_stringlib.stringlib.stringfind(l.member_attr1,'/',2) = 5 => l.member_attr1[6..9] + '0'+l.member_attr1[1] + l.member_attr1[3..4],
																				lib_stringlib.stringlib.stringfind(l.member_attr1,'/',1) = 2 and lib_stringlib.stringlib.stringfind(l.member_attr1,'/',2) = 4 => l.member_attr1[5..8] + '0'+l.member_attr1[1] + '0' +l.member_attr1[3],
																				lib_stringlib.stringlib.stringfind(l.member_attr1,'/',1) = 3 and lib_stringlib.stringlib.stringfind(l.member_attr1,'/',2) = 5 => l.member_attr1[6..9] + l.member_attr1[1..2] + '0' +l.member_attr1[4],
																				l.member_attr1[7..10] + l.member_attr1[1..2] + l.member_attr1[4..5]);
																	
	self.member_category 					:= map( Stringlib.StringToUpperCase(l.member_attr_name2) = 'CATEGORY' => lib_stringlib.StringLib.StringFilterOut(l.member_attr2,'-'),
																				Stringlib.StringToUpperCase(l.member_attr_name1) = 'CATEGORY' => lib_stringlib.StringLib.StringFilterOut(l.member_attr1,'-'),
																				'');
	self.date_first_seen 					:= if((integer)business_header.validatedate(self.member_since_date) = 0, 
																			(unsigned4)business_header.validatedate(self.report_date),
																			(unsigned4)business_header.validatedate(self.member_since_date));
	self.date_last_seen 					:= if((integer)business_header.validatedate(self.report_date) = 0, self.date_first_seen,
																			(unsigned4)business_header.validatedate(self.report_date));
	self.dt_vendor_first_reported := (unsigned4)pversion;
	self.dt_vendor_last_reported 	:= (unsigned4)pversion;
	self.company_name							:= ut.CleanSpacesAndUpper(l.company_name);
	//*** Old address cleaned state value is used to determine the foreign addresses before creating the address prep fields for AID call. 
	self.prep_addr_line1 					:= if(trim(l.clean_address[115..116]) <> '', l.address1,'');
	self.prep_addr_line_last 			:= if(trim(l.clean_address[115..116]) <> '', Fn_formatCityStZip(l.address2), '');
	self 													:= l;
	self 													:= [];
end;

dreturn := project(BBB_clean, Input2Base(left)) : persist(pPersistName);

return dreturn;

end;