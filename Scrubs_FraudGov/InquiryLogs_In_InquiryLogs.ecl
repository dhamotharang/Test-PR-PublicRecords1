import FraudGovPlatform,Inquiry_AccLogs;
Export InquiryLogs_In_InquiryLogs := Function 

	InquiryLogs_Layout_InquiryLogs f0(Inquiry_AccLogs.Layout.Common_ThorAdditions L) := transform
		self.transaction_id := l.search_info.transaction_id;
		self.datetime 	:= l.search_info.datetime;
		self.full_name	:= l.person_q.full_name;
		self.title		:= l.person_q.title;
		self.fname		:= l.person_q.fname;
		self.mname		:= l.person_q.mname;
		self.lname		:= l.person_q.lname;
		self.name_suffix	:= l.person_q.name_suffix;
		self.ssn			:= l.person_q.ssn;
		self.appended_ssn	:= l.person_q.appended_ssn;
		self.address		:= l.person_q.address;
		self.city			:= l.person_q.city;
		self.state		:= l.person_q.state;
		self.zip			:= l.person_q.zip;
		self.fips_county	:= l.person_q.fips_county;
		self.personal_phone	:= l.person_q.personal_phone;
		self.dob			:= l.person_q.dob;
		self.email_address	:= l.person_q.email_address;
		self.dl_st		:= l.person_q.dl_st;
		self.dl				:= l.person_q.dl;
		self.ipaddr		:= l.person_q.ipaddr;
		self.geo_lat		:= l.person_q.geo_lat;
		self.geo_long	:= l.person_q.geo_long;
		self.Source		:= l.Source;
	end;	
		
   result := project( FraudGovPlatform.Files().Sprayed.InquiryLogs, f0(left) );
   
	return (result);
end;