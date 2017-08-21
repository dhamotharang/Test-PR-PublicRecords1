#workunit('name', 'BBB Max Field Sizes Input Stats');

////////////////////////////////////////////////////////////////////
// -- Input Xml Files used in last build
////////////////////////////////////////////////////////////////////
lMemberInput	:= bbb2.Files().Input.Member.Used;
lNonMemberInput	:= bbb2.Files().Input.NonMember.Used;

////////////////////////////////////////////////////////////////////
// -- Tables to get Max Field Lengths of XML files
////////////////////////////////////////////////////////////////////
layout_member_max := 
record
	unsigned4 maxsize_bbb_id				:= max(group, length(trim(lMemberInput.bbb_id)));
	unsigned4 maxsize_company_name			:= max(group, length(trim(lMemberInput.company_name)));
	unsigned4 maxsize_address				:= max(group, length(trim(lMemberInput.address)));
	unsigned4 maxsize_country				:= max(group, length(trim(lMemberInput.country)));
	unsigned4 maxsize_phone					:= max(group, length(trim(lMemberInput.phone)));
	unsigned4 maxsize_phone_type			:= max(group, length(trim(lMemberInput.phone_type)));
	unsigned4 maxsize_listing_date			:= max(group, length(trim(lMemberInput.listing_month) + trim(lMemberInput.listing_day) + trim(lMemberInput.listing_year)));
	unsigned4 maxsize_http_link				:= max(group, length(trim(lMemberInput.http_link)));
	unsigned4 maxsize_member_title			:= max(group, length(trim(lMemberInput.member_title)));
	unsigned4 maxsize_member_attr1			:= max(group, length(trim(lMemberInput.member_attr1)));
	unsigned4 maxsize_member_attr2			:= max(group, length(trim(lMemberInput.member_attr2)));
end;

layout_nonmember_max := 
record
	unsigned4 maxsize_bbb_id				:= max(group, length(trim(lNonMemberInput.bbb_id)));
	unsigned4 maxsize_company_name			:= max(group, length(trim(lNonMemberInput.company_name)));
	unsigned4 maxsize_address				:= max(group, length(trim(lNonMemberInput.address)));
	unsigned4 maxsize_country				:= max(group, length(trim(lNonMemberInput.country)));
	unsigned4 maxsize_listing_date			:= max(group, length(trim(lNonMemberInput.listing_month) + trim(lNonMemberInput.listing_day) + trim(lNonMemberInput.listing_year)));
	unsigned4 maxsize_phone					:= max(group, length(trim(lNonMemberInput.phone)));
	unsigned4 maxsize_phone_type			:= max(group, length(trim(lNonMemberInput.phone_type)));
	unsigned4 maxsize_http_link				:= max(group, length(trim(lNonMemberInput.http_link)));
	unsigned4 maxsize_nonmember_title		:= max(group, length(trim(lNonMemberInput.non_member_title)));
	unsigned4 maxsize_nonmember_category	:= max(group, length(trim(lNonMemberInput.non_member_category)));
end;

member_max		:= table(lMemberInput,		layout_member_max,		few);
nonmember_max	:= table(lNonMemberInput,	layout_nonmember_max,	few);

////////////////////////////////////////////////////////////////////
// -- Sets used to label fields and get sizes of fields
////////////////////////////////////////////////////////////////////
lMemberFieldNames		:= [ 'bbb_id'
							,'company_name'
							,'address'
							,'country'
							,'phone'
							,'phone_type'
							,'report_date'
							,'http_link'
							,'member_title'
							,'member_since_date'
							,'member_category'
						];
lNonMemberFieldNames	:= [ 'bbb_id'
							,'company_name'
							,'address'
							,'country'
							,'phone'
							,'phone_type'
							,'report_date'
							,'http_link'
							,'non_member_title'
							,'non_member_category'
						];

lMemberMaxBaseFieldSizes := [	 sizeof(BBB2.Layouts_Files.Base.Member.bbb_id)
								,sizeof(BBB2.Layouts_Files.Base.Member.company_name)
								,sizeof(BBB2.Layouts_Files.Base.Member.address)
								,sizeof(BBB2.Layouts_Files.Base.Member.country)
								,sizeof(BBB2.Layouts_Files.Base.Member.phone)
								,sizeof(BBB2.Layouts_Files.Base.Member.phone_type)
								,sizeof(BBB2.Layouts_Files.Base.Member.report_date)
								,sizeof(BBB2.Layouts_Files.Base.Member.http_link)
								,sizeof(BBB2.Layouts_Files.Base.Member.member_title)
								,sizeof(BBB2.Layouts_Files.Base.Member.member_since_date)
								,sizeof(BBB2.Layouts_Files.Base.Member.member_category)
						];


lNonMemberMaxBaseFieldSizes := [ sizeof(BBB2.Layouts_Files.Base.NonMember.bbb_id)
								,sizeof(BBB2.Layouts_Files.Base.NonMember.company_name)
								,sizeof(BBB2.Layouts_Files.Base.NonMember.address)
								,sizeof(BBB2.Layouts_Files.Base.NonMember.country)
								,sizeof(BBB2.Layouts_Files.Base.NonMember.phone)
								,sizeof(BBB2.Layouts_Files.Base.NonMember.phone_type)
								,sizeof(BBB2.Layouts_Files.Base.NonMember.report_date)
								,sizeof(BBB2.Layouts_Files.Base.NonMember.http_link)
								,sizeof(BBB2.Layouts_Files.Base.NonMember.non_member_title)
								,sizeof(BBB2.Layouts_Files.Base.NonMember.non_member_category)
						];

////////////////////////////////////////////////////////////////////
// -- Normalize tables to get detail of size comparisons for output
////////////////////////////////////////////////////////////////////
layout_sizes_check := 
record
	string30	fieldname;
	unsigned4	xml_max_size;
	unsigned4	base_size;
	boolean		Is_xml_greater_than_base;
end;

layout_sizes_check tnormalize_member_sizes(member_max l, unsigned4 cnt) :=
transform
	self.fieldname					:= lMemberFieldNames[cnt];
	self.xml_max_size				:= choose(cnt,   l.maxsize_bbb_id		
													,l.maxsize_company_name	
													,l.maxsize_address		
													,l.maxsize_country		
													,l.maxsize_phone			
													,l.maxsize_phone_type	
													,l.maxsize_listing_date	
													,l.maxsize_http_link		
													,l.maxsize_member_title	
													,l.maxsize_member_attr1	- 2
													,l.maxsize_member_attr2
											);
	self.base_size					:= lMemberMaxBaseFieldSizes[cnt];
	self.Is_xml_greater_than_base	:= if(self.xml_max_size > self.base_size, true, false);
end;

layout_sizes_check tnormalize_nonmember_sizes(nonmember_max l, unsigned4 cnt) :=
transform
	self.fieldname					:= lNonMemberFieldNames[cnt];
	self.xml_max_size				:= choose(cnt,   l.maxsize_bbb_id		
													,l.maxsize_company_name	
													,l.maxsize_address		
													,l.maxsize_country		
													,l.maxsize_phone			
													,l.maxsize_phone_type	
													,l.maxsize_listing_date	
													,l.maxsize_http_link		
													,l.maxsize_nonmember_title	
													,l.maxsize_nonmember_category
									);
	self.base_size					:= lNonMemberMaxBaseFieldSizes[cnt];
	self.Is_xml_greater_than_base	:= if(self.xml_max_size > self.base_size, true, false);
end;

member_norm := normalize(member_max, 11, tnormalize_member_sizes(left, counter));
nonmember_norm := normalize(nonmember_max, 10, tnormalize_nonmember_sizes(left, counter));

output(member_norm, named('MemberFieldLengthComparisons'));
output(nonmember_norm, named('NonMemberFieldLengthComparisons'));


// Once a new build is in place on dataland, this code should work (20060301)
//apply(member_norm, nothor(if(Is_xml_greater_than_base = true, output('Member field: ' + fieldname + ' XML field is longer(' + xml_max_size + 
//						') than the base size(' + base_size + ')'), output('hello')))); 

//apply(nonmember_norm, nothor(if(Is_xml_greater_than_base = true, output('NonMember field: ' + fieldname + ' XML field is longer(' + xml_max_size + 
//						') than the base size(' + base_size + ')'), output('hello')))); 
