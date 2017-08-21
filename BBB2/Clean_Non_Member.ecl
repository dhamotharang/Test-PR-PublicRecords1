import ut, Business_Header, Business_Header_SS, did_add,address,lib_stringlib;

export Clean_Non_Member(

	 string																	pversion
	,dataset(Layouts_Files.Input.NonMember)	pInputFile
	,string																	pPersistName = PersistNames.CleanNonMember

) := 
function

BBB_Non_Member_In 		:= pInputFile;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert input file to base file format first
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
// -- Parse out Address 1 and 2 fields
//////////////////////////////////////////////////////////////////////////////////////////////
layout_BBB_Non_Member_parse_address := 
record
	BBB_Non_Member_In;
	string address1;
	string address2;
end;

// Count comma characters in string
unsigned1 CommaCount(string s) := length(trim(stringlib.stringfilter(s, ',')));

// Add unique sequence number to input
layout_BBB_Non_Member_parse_address ParseAddress(BBB_Non_Member_In l) := 
transform
	self.address1	:= if(l.address <> '', ut.CleanSpacesAndUpper(l.address[1..(stringlib.stringfind(l.address, ',', (CommaCount(l.address) - 2)) -1)]), '');
	self.address2	:= if(l.address <> '', ut.CleanSpacesAndUpper(l.address[(stringlib.stringfind(l.address, ',', (CommaCount(l.address) - 2)) +2)..]), '');
	self			:= l;
end;

BBB_Parse_Address := project(BBB_Non_Member_In, ParseAddress(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Standardize the phone
//////////////////////////////////////////////////////////////////////////////////////////////
layout_BBB_clean := 
record
	layout_BBB_Non_Member_parse_address;
	string182 clean_address;
	string10  phone10;
end;

layout_BBB_clean CleanInput(layout_BBB_Non_Member_parse_address l) := 
transform
	//*** Using old address cleaned values to determine the foreign addresses before creating the address prep fields for AID call.
	self.clean_address	:= address.cleanAddress182(l.address1, l.address2);
	self.phone10		:= if(l.phone <> '', Address.CleanPhone(trim(l.phone,all)), '');
	self := l;
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
Layouts_Files.Base.NonMember_BIP Input2Base(layout_bbb_clean l) := 
transform
	self.process_date_first_seen	:= (unsigned4)version;
	self.process_date_last_seen 	:= self.process_date_first_seen;
	self.record_type							:= 'C';
	self.report_date 							:= intformat((unsigned2) l.listing_year, 4, 1) +
																	 intformat((unsigned1) l.listing_month, 2, 1) +
																	 intformat((unsigned1) l.listing_day, 2, 1);
	self.date_first_seen 					:= (unsigned4)business_header.validatedate(self.report_date);
	self.date_last_seen 					:= self.date_first_seen;
	self.dt_vendor_first_reported := (unsigned4)pversion;
	self.dt_vendor_last_reported 	:= self.dt_vendor_first_reported;
	self.non_member_category      := lib_stringlib.StringLib.StringFilterOut(l.non_member_category,'-');
	self.company_name							:= ut.CleanSpacesAndUpper(l.company_name);
	//*** Old address cleaned state value is used to determine the foreign addresses before creating the address prep fields for AID call. 
	self.prep_addr_line1 					:= if(trim(l.clean_address[115..116]) <> '', l.address1,'');
	self.prep_addr_line_last 			:= if(trim(l.clean_address[115..116]) <> '', Fn_formatCityStZip(l.address2),'');
	self 													:= l;
	self 													:= [];
end;

dreturn := project(BBB_clean, Input2Base(left)) : persist(pPersistName);

return dreturn;

end;
