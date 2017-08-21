import ut, did_add, header_slimsort, didville,watchdog,doxie,header, address;

impulse_marketing:=files_idv.impulse_marketing;
layouts_idv.base tr_impulse_marketing( impulse_marketing l) :=transform
	self.src				:=	'1';
	self.orig_key			:=	l.record_id;
	self.orig_SSN			:=	l.ssn;
	self.orig_DOB			:=	l.dob;
	self.orig_phone			:=	l.phone;
	self.orig_Title			:=	'';
	self.orig_First_Name	:=	l.firstname;
	self.orig_Mid_Name		:=	'';
	self.orig_Last_Name		:=	l.lastname;
	self.orig_sffx			:=	'';
	self.orig_address		:=	l.address;
	self.orig_City			:=	l.city;
	self.orig_state			:=	l.state;
	self.orig_Zip			:=	l.zip;

	name					:=	trim(l.lastname)+' '+trim(l.firstname);

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonlfm73(stringlib.stringcleanspaces(name)),'');

	addr					:=	trim(l.address);

	string182 caddr			:=	if(trim(addr)<>'',Address.CleanAddress182(addr,trim(l.city)+' '+
																					trim(l.state)+' '+
																					trim(l.zip)),'');

	self.prim_range		:= caddr[	1	..	10	];
	self.predir			:= caddr[	11	..	12	];
	self.prim_name		:= caddr[	13	..	40	];
	self.addr_suffix	:= caddr[	41	..	44	];
	self.postdir		:= caddr[	45	..	46	];
	self.unit_desig		:= caddr[	47	..	56	];
	self.sec_range		:= caddr[	57	..	64	];
	self.p_city_name	:= caddr[	65	..	89	];
	self.v_city_name	:= caddr[	90	..	114	];
	self.st				:= caddr[	115	..	116	];
	self.zip			:= caddr[	117	..	121	];
	self.zip4			:= caddr[	122	..	125	];
	self.cart			:= caddr[	126	..	129	];
	self.cr_sort_sz		:= caddr[	130	..	130	];
	self.lot			:= caddr[	131	..	134	];
	self.lot_order		:= caddr[	135	..	135	];
	self.dbpc			:= caddr[	136	..	137	];
	self.chk_digit		:= caddr[	138	..	138	];
	self.rec_type		:= caddr[	139	..	140	];
	self.fips_county	:= caddr[	141	..	142	];
	self.county			:= caddr[	143	..	145	];
	self.geo_lat		:= caddr[	146	..	155	];
	self.geo_long		:= caddr[	156	..	166	];
	self.msa			:= caddr[	167	..	170	];
	self.geo_blk		:= caddr[	171	..	177	];
	self.geo_match		:= caddr[	178	..	178	];
	self.err_stat		:= caddr[	179	..	182	];

	self.title     		:= cname[ 1.. 5];
	self.fname   		:= cname[ 6..25];
	self.mname			:= cname[26..45];
	self.lname 			:= cname[46..65];
	self.name_suffix	:= cname[66..70];
	self.name_score 	:= cname[71..73];

	clean_dob:=if(l.dob='2099-12-31','',stringlib.stringfindreplace(trim(l.dob),'-',''));
	self.clean_dob:=if(stringlib.stringfindreplace(trim(clean_dob),'0','')='','',clean_dob);

	clean_phone	:= stringlib.stringfindreplace(l.phone,' ','0');
	self.clean_hphone:=if(stringlib.stringfindreplace(clean_phone,'0','')='','',clean_phone);

	clean_ssn:= stringlib.stringfindreplace(l.ssn,'9','0');
	self.clean_ssn:=if(stringlib.stringfindreplace(trim(clean_ssn),'0','')='','',clean_ssn);

end;
impulse_marketing_base	:=	project(impulse_marketing,tr_impulse_marketing(left),local)
								:persist('~thor_data400::persist::impulse_marketing')
								;

infoDirect:=files_idv.infoDirect;
layouts_idv.base tr_infoDirect( infoDirect l) :=transform
	self.src				:=	'2';
	self.orig_key			:=	l.seqno;
	self.orig_SSN			:=	l.ssn;
	self.orig_DOB			:=	l.dateOfBirth;
	self.orig_phone			:=	l.homephone;
	self.orig_Title			:=	'';
	self.orig_First_Name	:=	l.firstname;
	self.orig_Mid_Name		:=	'';
	self.orig_Last_Name		:=	l.lastname;
	self.orig_sffx			:=	'';
	self.orig_address		:=	l.streetaddress;
	self.orig_City			:=	l.city;
	self.orig_state			:=	l.state;
	self.orig_Zip			:=	l.zip;

	name					:=	trim(l.lastname)+' '+trim(l.firstname);

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonlfm73(stringlib.stringcleanspaces(name)),'');

	addr					:=	trim(l.streetaddress);

	string182 caddr			:=	if(trim(addr)<>'',Address.CleanAddress182(addr,trim(l.city)+' '+
																					trim(l.state)+' '+
																					trim(l.zip)),'');

	self.prim_range		:= caddr[	1	..	10	];
	self.predir			:= caddr[	11	..	12	];
	self.prim_name		:= caddr[	13	..	40	];
	self.addr_suffix	:= caddr[	41	..	44	];
	self.postdir		:= caddr[	45	..	46	];
	self.unit_desig		:= caddr[	47	..	56	];
	self.sec_range		:= caddr[	57	..	64	];
	self.p_city_name	:= caddr[	65	..	89	];
	self.v_city_name	:= caddr[	90	..	114	];
	self.st				:= caddr[	115	..	116	];
	self.zip			:= caddr[	117	..	121	];
	self.zip4			:= caddr[	122	..	125	];
	self.cart			:= caddr[	126	..	129	];
	self.cr_sort_sz		:= caddr[	130	..	130	];
	self.lot			:= caddr[	131	..	134	];
	self.lot_order		:= caddr[	135	..	135	];
	self.dbpc			:= caddr[	136	..	137	];
	self.chk_digit		:= caddr[	138	..	138	];
	self.rec_type		:= caddr[	139	..	140	];
	self.fips_county	:= caddr[	141	..	142	];
	self.county			:= caddr[	143	..	145	];
	self.geo_lat		:= caddr[	146	..	155	];
	self.geo_long		:= caddr[	156	..	166	];
	self.msa			:= caddr[	167	..	170	];
	self.geo_blk		:= caddr[	171	..	177	];
	self.geo_match		:= caddr[	178	..	178	];
	self.err_stat		:= caddr[	179	..	182	];

	self.title     		:= cname[ 1.. 5];
	self.fname   		:= cname[ 6..25];
	self.mname			:= cname[26..45];
	self.lname 			:= cname[46..65];
	self.name_suffix	:= cname[66..70];
	self.name_score 	:= cname[71..73];

	clean_dob:=if(l.dateOfBirth='2099-12-31','',stringlib.stringfindreplace(trim(l.dateOfBirth),'-',''));
	self.clean_dob:=if(stringlib.stringfindreplace(trim(clean_dob),'0','')='','',clean_dob);

	clean_phone	:= stringlib.stringfindreplace(l.homephone,' ','0');
	self.clean_hphone:=if(stringlib.stringfindreplace(clean_phone,'0','')='','',clean_phone);

	clean_ssn:= stringlib.stringfindreplace(l.ssn,'9','0');
	self.clean_ssn:=if(stringlib.stringfindreplace(trim(clean_ssn),'0','')='','',clean_ssn);

end;
infoDirect_base	:=	project(infoDirect,tr_infoDirect(left),local)
								:persist('~thor_data400::persist::infoDirect')
								;

teletrack:=files_idv.teletrack;
layouts_idv.base tr_teletrack( teletrack l) :=transform
	self.src				:=	'3';
	self.orig_key			:=	l.Account_number;
	self.orig_SSN			:=	l.Social_Security_Number;
	self.orig_DOB			:=	'';
	self.orig_phone			:=	'';
	self.orig_Title			:=	'';
	self.orig_First_Name	:=	l.Name;
	self.orig_Mid_Name		:=	'';
	self.orig_Last_Name		:=	'';
	self.orig_sffx			:=	'';
	self.orig_address		:=	'';
	self.orig_City			:=	'';
	self.orig_state			:=	'';
	self.orig_Zip			:=	'';

	name					:=	trim(l.Name);

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonFML73(stringlib.stringcleanspaces(name)),'');

	self.title     		:= cname[ 1.. 5];
	self.fname   		:= cname[ 6..25];
	self.mname			:= cname[26..45];
	self.lname 			:= cname[46..65];
	self.name_suffix	:= cname[66..70];
	self.name_score 	:= cname[71..73];

	clean_ssn:= stringlib.stringfindreplace(l.Social_Security_Number,'9','0');
	self.clean_ssn:=if(stringlib.stringfindreplace(trim(clean_ssn),'0','')='','',clean_ssn);

	self	:= [];
end;
teletrack_base	:=	project(teletrack,tr_teletrack(left),local)
								:persist('~thor_data400::persist::teletrack')
								;

Segment_52_SocialGuard_Data:=files_idv.Segment_52_SocialGuard_Data;
layouts_idv.base tr_Segment_52_SocialGuard_Data( Segment_52_SocialGuard_Data l) :=transform
	self.src				:=	'4';
	self.orig_key			:=	l.Customer_Reference_Number;
	self.orig_SSN			:=	l.Social_Security_Number;
	self.orig_DOB			:=	'';
	self.orig_phone			:=	'';
	self.orig_Title			:=	'';
	self.orig_First_Name	:=	l.Customer_Name;
	self.orig_Mid_Name		:=	'';
	self.orig_Last_Name		:=	'';
	self.orig_sffx			:=	'';
	self.orig_address		:=	'';
	self.orig_City			:=	'';
	self.orig_state			:=	'';
	self.orig_Zip			:=	'';

	name					:=	trim(l.Customer_Name);

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonFML73(stringlib.stringcleanspaces(name)),'');

	self.title     		:= cname[ 1.. 5];
	self.fname   		:= cname[ 6..25];
	self.mname			:= cname[26..45];
	self.lname 			:= cname[46..65];
	self.name_suffix	:= cname[66..70];
	self.name_score 	:= cname[71..73];

	clean_ssn:= stringlib.stringfindreplace(l.Social_Security_Number,'9','0');
	self.clean_ssn:=if(stringlib.stringfindreplace(trim(clean_ssn),'0','')='','',clean_ssn);

	self	:= [];
end;
Segment_52_SocialGuard_Data_base	:=	project(Segment_52_SocialGuard_Data,tr_Segment_52_SocialGuard_Data(left),local)
								:persist('~thor_data400::persist::Segment_52_SocialGuard_Data')
								;

Segment_53_Charge_Offs:=files_idv.Segment_53_Charge_Offs;
layouts_idv.base tr_Segment_53_Charge_Offs( Segment_53_Charge_Offs l) :=transform
	self.src				:=	'5';
	self.orig_key			:=	l.Customer_Reference_Number;
	self.orig_SSN			:=	l.Social_Security_Number;
	self.orig_DOB			:=	'';
	self.orig_phone			:=	'';
	self.orig_Title			:=	'';
	self.orig_First_Name	:=	l.Customer_Name;
	self.orig_Mid_Name		:=	'';
	self.orig_Last_Name		:=	'';
	self.orig_sffx			:=	'';
	self.orig_address		:=	l.Last_Known_Address;
	self.orig_City			:=	l.Last_Known_City;
	self.orig_state			:=	l.Last_Known_State;
	self.orig_Zip			:=	l.Last_Known_Zip;

	name					:=	trim(l.Customer_Name);

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonFML73(stringlib.stringcleanspaces(name)),'');

	addr					:=	trim(l.Last_Known_Address);

	string182 caddr			:=	if(trim(addr)<>'',Address.CleanAddress182(addr,trim(l.Last_Known_City)+' '+
																					trim(l.Last_Known_State)+' '+
																					trim(l.Last_Known_Zip)),'');

	self.prim_range		:= caddr[	1	..	10	];
	self.predir			:= caddr[	11	..	12	];
	self.prim_name		:= caddr[	13	..	40	];
	self.addr_suffix	:= caddr[	41	..	44	];
	self.postdir		:= caddr[	45	..	46	];
	self.unit_desig		:= caddr[	47	..	56	];
	self.sec_range		:= caddr[	57	..	64	];
	self.p_city_name	:= caddr[	65	..	89	];
	self.v_city_name	:= caddr[	90	..	114	];
	self.st				:= caddr[	115	..	116	];
	self.zip			:= caddr[	117	..	121	];
	self.zip4			:= caddr[	122	..	125	];
	self.cart			:= caddr[	126	..	129	];
	self.cr_sort_sz		:= caddr[	130	..	130	];
	self.lot			:= caddr[	131	..	134	];
	self.lot_order		:= caddr[	135	..	135	];
	self.dbpc			:= caddr[	136	..	137	];
	self.chk_digit		:= caddr[	138	..	138	];
	self.rec_type		:= caddr[	139	..	140	];
	self.fips_county	:= caddr[	141	..	142	];
	self.county			:= caddr[	143	..	145	];
	self.geo_lat		:= caddr[	146	..	155	];
	self.geo_long		:= caddr[	156	..	166	];
	self.msa			:= caddr[	167	..	170	];
	self.geo_blk		:= caddr[	171	..	177	];
	self.geo_match		:= caddr[	178	..	178	];
	self.err_stat		:= caddr[	179	..	182	];

	self.title     		:= cname[ 1.. 5];
	self.fname   		:= cname[ 6..25];
	self.mname			:= cname[26..45];
	self.lname 			:= cname[46..65];
	self.name_suffix	:= cname[66..70];
	self.name_score 	:= cname[71..73];

	clean_ssn:= stringlib.stringfindreplace(l.Social_Security_Number,'9','0');
	self.clean_ssn:=if(stringlib.stringfindreplace(trim(clean_ssn),'0','')='','',clean_ssn);

end;
Segment_53_Charge_Offs_base	:=	project(Segment_53_Charge_Offs,tr_Segment_53_Charge_Offs(left),local)
								:persist('~thor_data400::persist::Segment_53_Charge_Offs')
								;

Segment_54_Previous_Inquiries:=files_idv.Segment_54_Previous_Inquiries;
layouts_idv.base tr_Segment_54_Previous_Inquiries( Segment_54_Previous_Inquiries l) :=transform
	self.src				:=	'6';
	self.orig_key			:=	l.Customer_Reference_Number;
	self.orig_SSN			:=	l.Social_Security_Number;
	self.orig_DOB			:=	'';
	self.orig_phone			:=	'';
	self.orig_Title			:=	'';
	self.orig_First_Name	:=	l.Customer_Name;
	self.orig_Mid_Name		:=	'';
	self.orig_Last_Name		:=	'';
	self.orig_sffx			:=	'';
	self.orig_address		:=	'';
	self.orig_City			:=	'';
	self.orig_state			:=	'';
	self.orig_Zip			:=	'';

	name					:=	trim(l.Customer_Name);

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonFML73(stringlib.stringcleanspaces(name)),'');

	self.title     		:= cname[ 1.. 5];
	self.fname   		:= cname[ 6..25];
	self.mname			:= cname[26..45];
	self.lname 			:= cname[46..65];
	self.name_suffix	:= cname[66..70];
	self.name_score 	:= cname[71..73];

	clean_ssn:= stringlib.stringfindreplace(l.Social_Security_Number,'9','0');
	self.clean_ssn:=if(stringlib.stringfindreplace(trim(clean_ssn),'0','')='','',clean_ssn);

	self	:= [];
end;
Segment_54_Previous_Inquiries_base	:=	project(Segment_54_Previous_Inquiries,tr_Segment_54_Previous_Inquiries(left),local)
								:persist('~thor_data400::persist::Segment_54_Previous_Inquiries')
								;

Segment_56_SkipGuard_Alerts:=files_idv.Segment_56_SkipGuard_Alerts;
layouts_idv.base tr_Segment_56_SkipGuard_Alerts( Segment_56_SkipGuard_Alerts l) :=transform
	self.src				:=	'7';
	self.orig_key			:=	l.Customer_Reference_Number;
	self.orig_SSN			:=	l.Social_Security_Number;
	self.orig_DOB			:=	'';
	self.orig_phone			:=	'';
	self.orig_Title			:=	'';
	self.orig_First_Name	:=	l.Customer_Name;
	self.orig_Mid_Name		:=	'';
	self.orig_Last_Name		:=	'';
	self.orig_sffx			:=	'';
	self.orig_address		:=	'';
	self.orig_City			:=	'';
	self.orig_state			:=	'';
	self.orig_Zip			:=	'';

	name					:=	trim(l.Customer_Name);

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonFML73(stringlib.stringcleanspaces(name)),'');

	self.title     		:= cname[ 1.. 5];
	self.fname   		:= cname[ 6..25];
	self.mname			:= cname[26..45];
	self.lname 			:= cname[46..65];
	self.name_suffix	:= cname[66..70];
	self.name_score 	:= cname[71..73];

	clean_ssn:= stringlib.stringfindreplace(l.Social_Security_Number,'9','0');
	self.clean_ssn:=if(stringlib.stringfindreplace(trim(clean_ssn),'0','')='','',clean_ssn);

	self	:= [];
end;
Segment_56_SkipGuard_Alerts_base	:=	project(Segment_56_SkipGuard_Alerts,tr_Segment_56_SkipGuard_Alerts(left),local)
								:persist('~thor_data400::persist::Segment_56_SkipGuard_Alerts')
								;

Segment_61_Tenant_Evictions_and_Court_Dispositions:=files_idv.Segment_61_Tenant_Evictions_and_Court_Dispositions;
layouts_idv.base tr_Segment_61_Tenant_Evictions_and_Court_Dispositions( Segment_61_Tenant_Evictions_and_Court_Dispositions l) :=transform
	self.src				:=	'8';
	self.orig_key			:=	l.Customer_Reference_Number;
	self.orig_SSN			:=	l.Social_Security_Number;
	self.orig_DOB			:=	'';
	self.orig_phone			:=	'';
	self.orig_Title			:=	'';
	self.orig_First_Name	:=	l.Tenant_Name;
	self.orig_Mid_Name		:=	'';
	self.orig_Last_Name		:=	'';
	self.orig_sffx			:=	'';
	self.orig_address		:=	l.Address;
	self.orig_City			:=	l.City;
	self.orig_state			:=	l.State;
	self.orig_Zip			:=	l.Zip_Code;

	name					:=	trim(l.Tenant_Name);

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonFML73(stringlib.stringcleanspaces(name)),'');

	addr					:=	trim(l.Address);

	string182 caddr			:=	if(trim(addr)<>'',Address.CleanAddress182(addr,trim(l.City)+' '+
																					trim(l.State)+' '+
																					trim(l.Zip_Code)),'');

	self.prim_range		:= caddr[	1	..	10	];
	self.predir			:= caddr[	11	..	12	];
	self.prim_name		:= caddr[	13	..	40	];
	self.addr_suffix	:= caddr[	41	..	44	];
	self.postdir		:= caddr[	45	..	46	];
	self.unit_desig		:= caddr[	47	..	56	];
	self.sec_range		:= caddr[	57	..	64	];
	self.p_city_name	:= caddr[	65	..	89	];
	self.v_city_name	:= caddr[	90	..	114	];
	self.st				:= caddr[	115	..	116	];
	self.zip			:= caddr[	117	..	121	];
	self.zip4			:= caddr[	122	..	125	];
	self.cart			:= caddr[	126	..	129	];
	self.cr_sort_sz		:= caddr[	130	..	130	];
	self.lot			:= caddr[	131	..	134	];
	self.lot_order		:= caddr[	135	..	135	];
	self.dbpc			:= caddr[	136	..	137	];
	self.chk_digit		:= caddr[	138	..	138	];
	self.rec_type		:= caddr[	139	..	140	];
	self.fips_county	:= caddr[	141	..	142	];
	self.county			:= caddr[	143	..	145	];
	self.geo_lat		:= caddr[	146	..	155	];
	self.geo_long		:= caddr[	156	..	166	];
	self.msa			:= caddr[	167	..	170	];
	self.geo_blk		:= caddr[	171	..	177	];
	self.geo_match		:= caddr[	178	..	178	];
	self.err_stat		:= caddr[	179	..	182	];

	self.title     		:= cname[ 1.. 5];
	self.fname   		:= cname[ 6..25];
	self.mname			:= cname[26..45];
	self.lname 			:= cname[46..65];
	self.name_suffix	:= cname[66..70];
	self.name_score 	:= cname[71..73];

	clean_ssn:= stringlib.stringfindreplace(l.Social_Security_Number,'9','0');
	self.clean_ssn:=if(stringlib.stringfindreplace(trim(clean_ssn),'0','')='','',clean_ssn);

end;
Segment_61_Tenant_Evictions_and_Court_Dispositions_base	:=	project(Segment_61_Tenant_Evictions_and_Court_Dispositions,tr_Segment_61_Tenant_Evictions_and_Court_Dispositions(left),local)
								:persist('~thor_data400::persist::Segment_61_Tenant_Evictions_and_Court_Dispositions')
								;

Segment_62_Paid_Charge_Offs:=files_idv.Segment_62_Paid_Charge_Offs;
layouts_idv.base tr_Segment_62_Paid_Charge_Offs( Segment_62_Paid_Charge_Offs l) :=transform
	self.src				:=	'9';
	self.orig_key			:=	l.Customer_Reference_Number;
	self.orig_SSN			:=	l.Social_Security_Number;
	self.orig_DOB			:=	'';
	self.orig_phone			:=	'';
	self.orig_Title			:=	'';
	self.orig_First_Name	:=	l.Customer_Name;
	self.orig_Mid_Name		:=	'';
	self.orig_Last_Name		:=	'';
	self.orig_sffx			:=	'';
	self.orig_address		:=	l.Last_Known_Address;
	self.orig_City			:=	l.Last_Known_City;
	self.orig_state			:=	l.Last_Known_State;
	self.orig_Zip			:=	l.Last_Known_Zip;

	name					:=	trim(l.Customer_Name);

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonFML73(stringlib.stringcleanspaces(name)),'');

	addr					:=	trim(l.Last_Known_Address);

	string182 caddr			:=	if(trim(addr)<>'',Address.CleanAddress182(addr,trim(l.Last_Known_City)+' '+
																					trim(l.Last_Known_State)+' '+
																					trim(l.Last_Known_Zip)),'');

	self.prim_range		:= caddr[	1	..	10	];
	self.predir			:= caddr[	11	..	12	];
	self.prim_name		:= caddr[	13	..	40	];
	self.addr_suffix	:= caddr[	41	..	44	];
	self.postdir		:= caddr[	45	..	46	];
	self.unit_desig		:= caddr[	47	..	56	];
	self.sec_range		:= caddr[	57	..	64	];
	self.p_city_name	:= caddr[	65	..	89	];
	self.v_city_name	:= caddr[	90	..	114	];
	self.st				:= caddr[	115	..	116	];
	self.zip			:= caddr[	117	..	121	];
	self.zip4			:= caddr[	122	..	125	];
	self.cart			:= caddr[	126	..	129	];
	self.cr_sort_sz		:= caddr[	130	..	130	];
	self.lot			:= caddr[	131	..	134	];
	self.lot_order		:= caddr[	135	..	135	];
	self.dbpc			:= caddr[	136	..	137	];
	self.chk_digit		:= caddr[	138	..	138	];
	self.rec_type		:= caddr[	139	..	140	];
	self.fips_county	:= caddr[	141	..	142	];
	self.county			:= caddr[	143	..	145	];
	self.geo_lat		:= caddr[	146	..	155	];
	self.geo_long		:= caddr[	156	..	166	];
	self.msa			:= caddr[	167	..	170	];
	self.geo_blk		:= caddr[	171	..	177	];
	self.geo_match		:= caddr[	178	..	178	];
	self.err_stat		:= caddr[	179	..	182	];

	self.title     		:= cname[ 1.. 5];
	self.fname   		:= cname[ 6..25];
	self.mname			:= cname[26..45];
	self.lname 			:= cname[46..65];
	self.name_suffix	:= cname[66..70];
	self.name_score 	:= cname[71..73];

	clean_ssn:= stringlib.stringfindreplace(l.Social_Security_Number,'9','0');
	self.clean_ssn:=if(stringlib.stringfindreplace(trim(clean_ssn),'0','')='','',clean_ssn);

end;
Segment_62_Paid_Charge_Offs_base	:=	project(Segment_62_Paid_Charge_Offs,tr_Segment_62_Paid_Charge_Offs(left),local)
								:persist('~thor_data400::persist::Segment_62_Paid_Charge_Offs')
								;

Segment_68_Bankruptcies:=files_idv.Segment_68_Bankruptcies;
layouts_idv.base tr_Segment_68_Bankruptcies( Segment_68_Bankruptcies l) :=transform
	self.src				:=	'10';
	self.orig_key			:=	l.Customer_Reference_Number;
	self.orig_SSN			:=	l.Social_Security_Number;
	self.orig_DOB			:=	'';
	self.orig_phone			:=	'';
	self.orig_Title			:=	'';
	self.orig_First_Name	:=	l.Customer_Name;
	self.orig_Mid_Name		:=	'';
	self.orig_Last_Name		:=	'';
	self.orig_sffx			:=	'';
	self.orig_address		:=	l.Address_City_State_Zip;
	self.orig_City			:=	'';
	self.orig_state			:=	'';
	self.orig_Zip			:=	'';

	name					:=	trim(l.Customer_Name);

	string73 cname			:=	if(trim(name)<>'',address.cleanpersonFML73(stringlib.stringcleanspaces(name)),'');

	str						:='^(.*,) (.*, [^ ]*, [^ ]*$)';
	addr					:=regexfind(str,l.Address_City_State_Zip,1);
	csz						:=regexfind(str,l.Address_City_State_Zip,2);

	string182 caddr			:=	if(trim(addr)<>'',Address.CleanAddress182(addr,trim(csz)),'');

	self.prim_range		:= caddr[	1	..	10	];
	self.predir			:= caddr[	11	..	12	];
	self.prim_name		:= caddr[	13	..	40	];
	self.addr_suffix	:= caddr[	41	..	44	];
	self.postdir		:= caddr[	45	..	46	];
	self.unit_desig		:= caddr[	47	..	56	];
	self.sec_range		:= caddr[	57	..	64	];
	self.p_city_name	:= caddr[	65	..	89	];
	self.v_city_name	:= caddr[	90	..	114	];
	self.st				:= caddr[	115	..	116	];
	self.zip			:= caddr[	117	..	121	];
	self.zip4			:= caddr[	122	..	125	];
	self.cart			:= caddr[	126	..	129	];
	self.cr_sort_sz		:= caddr[	130	..	130	];
	self.lot			:= caddr[	131	..	134	];
	self.lot_order		:= caddr[	135	..	135	];
	self.dbpc			:= caddr[	136	..	137	];
	self.chk_digit		:= caddr[	138	..	138	];
	self.rec_type		:= caddr[	139	..	140	];
	self.fips_county	:= caddr[	141	..	142	];
	self.county			:= caddr[	143	..	145	];
	self.geo_lat		:= caddr[	146	..	155	];
	self.geo_long		:= caddr[	156	..	166	];
	self.msa			:= caddr[	167	..	170	];
	self.geo_blk		:= caddr[	171	..	177	];
	self.geo_match		:= caddr[	178	..	178	];
	self.err_stat		:= caddr[	179	..	182	];

	self.title     		:= cname[ 1.. 5];
	self.fname   		:= cname[ 6..25];
	self.mname			:= cname[26..45];
	self.lname 			:= cname[46..65];
	self.name_suffix	:= cname[66..70];
	self.name_score 	:= cname[71..73];

	clean_ssn:= stringlib.stringfindreplace(l.Social_Security_Number,'9','0');
	self.clean_ssn:=if(stringlib.stringfindreplace(trim(clean_ssn),'0','')='','',clean_ssn);

end;
Segment_68_Bankruptcies_base	:=	project(Segment_68_Bankruptcies,tr_Segment_68_Bankruptcies(left),local)
								:persist('~thor_data400::persist::Segment_68_Bankruptcies')
								;

// eFund:=files_idv.eFund;	// 11
// layouts_idv.base tr_eFund( eFund l) :=transform
// end;
// eFund_base	:=	project(eFund,tr_eFund(left),local)
								// :persist('~thor_data400::persist::eFund')
								// ;
// rent_bureau:=files_idv.rent_bureau;	//12
// layouts_idv.base tr_rent_bureau( rent_bureau l) :=transform
// end;
// rent_bureau_base	:=	project(rent_bureau,tr_rent_bureau(left),local)
								// :persist('~thor_data400::persist::rent_bureau')
								// ;
// alliant:=files_idv.alliant;	//13
// layouts_idv.base tr_alliant( alliant l) :=transform
// end;
// alliant_base	:=	project(alliant,tr_alliant(left),local)
								// :persist('~thor_data400::persist::alliant')
								// ;

teletrack_base tr(teletrack_base l, teletrack_base r) := transform
	self.orig_address	:=	r.orig_address;
	self.orig_City		:=	r.orig_city;
	self.orig_state		:=	r.orig_state;
	self.orig_Zip		:=	r.orig_zip;

	self.prim_range		:=	r.prim_range;
	self.predir			:=	r.predir;
	self.prim_name		:=	r.prim_name;
	self.addr_suffix	:=	r.addr_suffix;
	self.postdir		:=	r.postdir;
	self.unit_desig		:=	r.unit_desig;
	self.sec_range		:=	r.sec_range;
	self.p_city_name	:=	r.p_city_name;
	self.v_city_name	:=	r.v_city_name;
	self.st				:=	r.st;
	self.zip			:=	r.zip;
	self.zip4			:=	r.zip4;
	self.cart			:=	r.cart;
	self.cr_sort_sz		:=	r.cr_sort_sz;
	self.lot			:=	r.lot;
	self.lot_order		:=	r.lot_order;
	self.dbpc			:=	r.dbpc;
	self.chk_digit		:=	r.chk_digit;
	self.rec_type		:=	r.rec_type;
	self.fips_county	:=	r.fips_county;
	self.county			:=	r.county;
	self.geo_lat		:=	r.geo_lat;
	self.geo_long		:=	r.geo_long;
	self.msa			:=	r.msa;
	self.geo_blk		:=	r.geo_blk;
	self.geo_match		:=	r.geo_match;
	self.err_stat		:=	r.err_stat;
	self				:=	l;
end;

t53:=join(distribute(teletrack_base,hash(trim(orig_key))),distribute(Segment_53_Charge_Offs_base,hash(trim(orig_key)))
			,trim(left.orig_key)=trim(right.orig_key)
			,tr(left,right)
			,left outer
			,local);
t61:=join(distribute(t53,hash(trim(orig_key))),distribute(Segment_61_Tenant_Evictions_and_Court_Dispositions_base,hash(trim(orig_key)))
			,trim(left.orig_key)=trim(right.orig_key)
			,tr(left,right)
			,left outer
			,local);
t62:=join(distribute(t61,hash(trim(orig_key))),distribute(Segment_62_Paid_Charge_Offs_base,hash(trim(orig_key)))
			,trim(left.orig_key)=trim(right.orig_key)
			,tr(left,right)
			,left outer
			,local);
t68:=join(distribute(t62,hash(trim(orig_key))),distribute(Segment_68_Bankruptcies_base,hash(trim(orig_key)))
			,trim(left.orig_key)=trim(right.orig_key)
			,tr(left,right)
			,left outer
			,local);

base :=		impulse_marketing_base
		+	infoDirect_base
		+	t68
		+	Segment_52_SocialGuard_Data_base
		+	Segment_53_Charge_Offs_base
		+	Segment_54_Previous_Inquiries_base
		+	Segment_56_SkipGuard_Alerts_base
		+	Segment_61_Tenant_Evictions_and_Court_Dispositions_base
		+	Segment_62_Paid_Charge_Offs_base
		+	Segment_68_Bankruptcies_base;

base_ddp	:= dedup(sort(distribute(base,hash(orig_key)),orig_key,src,local),orig_key,local);
// base_ddp	:= base;

matchset := ['A','D','S','Q'];

did_add.MAC_Match_Flex
	(base_ddp
	,matchset
	,clean_ssn
	,clean_dob
	,fname
	,mname
	,lname
	,name_suffix
	,prim_range
	,prim_name
	,sec_range
	,zip
	,st
	,clean_Phone
	,DID
	,recordof(base)
	,true
	,DID_Score
	,75
	,base_out);

base_dist	:= distribute(base_out,hash(did)): persist('~thor_data400::persist::idv_basev2');

h:=distribute(header.File_Headers,hash(did));
// h:=dataset('~thor_data400::base::header_father',header.Layout_Header,flat);
segmented_h := distribute(Header.fn_ADLSegmentation(h).core_check,hash(did));
seg_ind := JOIN(base_dist(did>0),segmented_h
					,	left.did=right.did
					and	right.ind<>''
					,transform({base_dist,segmented_h.ind}
								,self.ind:=right.ind
								,self:=left)
					,left outer
					,keep(1)
					,LOCAL);

base_ind:=		seg_ind
			+	project(base_dist(did=0),transform({seg_ind},self.ind:='',self:=left),local)
					 :persist('~thor400_84::persist::idv_base_indv2');

// export idv_base := base_ind;
export idv_base := dataset(ut.foreign_dataland+'~thor400_84::persist::idv_base_ind',recordof(base_indv2),flat);
// export idv_base := dataset(ut.foreign_prod+'~thor400_84::persist::idv_base_ind',recordof(base_indv2),flat);
