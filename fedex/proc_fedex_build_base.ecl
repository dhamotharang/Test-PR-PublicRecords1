import address, fedex, ut;

ds_fedex_in := fedex.File_FedEx_In;

layout_fedex_clean := record
	fedex.layout_fedex_in;
	string73	clean_name;
	string182	clean_address;
end;

layout_fedex_clean clean_name_address(ds_fedex_in l) := transform
	tmp_address_line1				:=	if(l.address_line2 = '', trim(l.address_line1), regexreplace('^[,]', trim(l.address_line1) + ',' + trim(l.address_line2), ''));
	tmp_address_line2 			:=	regexreplace('^[,]|[,]$', trim(l.city) + ',' + trim(l.state) + ' ' + trim(l.zip) + ',' + trim(l.country), '');
	self.clean_name					:=	AddrCleanLib.CleanPersonFML73(l.full_name);
	self.clean_address			:=	if(trim(l.country,left,right) = 'CA',
																Address.CleanCanadaAddress109(tmp_address_line1, tmp_address_line2),
																Address.CleanAddress182(tmp_address_line1, tmp_address_line2)
																);
	self := l;
end;

ds_fedex_clean := project(ds_fedex_in, clean_name_address(left));

fedex.layout_fedex_base reformat(ds_fedex_clean l) := transform
	tmp_name_flag				:=	if (trim(l.first_name + l.last_name) = '' and l.full_name <> '', 'Y','');

	self.last_name			:=	if(tmp_name_flag = 'Y', trim(l.clean_name[46..65]), l.last_name);
	self.first_name			:=	if(tmp_name_flag = 'Y', trim(l.clean_name[6..25]), l.first_name);
	self.middle_initial	:=	if(tmp_name_flag = 'Y', trim(l.clean_name[26..45]), l.middle_initial);
	
	self.prim_range			:=	l.clean_address[1..10];
	self.predir					:=	l.clean_address[11..12];
	self.prim_name			:=	l.clean_address[13..40];
	self.addr_suffix		:=	l.clean_address[41..44];
	self.postdir				:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[45..46]);
	self.unit_desig			:=	case(trim(l.country,left,right), 'CA' => l.clean_address[45..54], l.clean_address[47..56]);
	self.sec_range			:=	case(trim(l.country,left,right), 'CA' => l.clean_address[55..62], l.clean_address[57..64]);
	self.p_city_name		:=	case(trim(l.country,left,right), 'CA' => l.clean_address[63..92], l.clean_address[65..89]);
	self.v_city_name		:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[90..114]);
	self.st							:=	case(trim(l.country,left,right), 'CA' => l.clean_address[93..94], l.clean_address[115..116]);
	self.zip5						:=	case(trim(l.country,left,right), 'CA' => l.clean_address[95..100], l.clean_address[117..121]);
	self.zip6						:=	case(trim(l.country,left,right), 'CA' => l.clean_address[95..100], l.clean_address[117..121]);
	self.zip4						:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[122..125]);
	self.cart						:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[126..129]);
	self.cr_sort_sz			:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[130]);
	self.lot						:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[131..134]);
	self.lot_order			:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[135]);
	self.dbpc						:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[136..137]);
	self.chk_digit			:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[138]);
	self.rec_type				:=	case(trim(l.country,left,right), 'CA' => l.clean_address[101..102], l.clean_address[139..140]);
	self.county					:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[141..145]);
	self.geo_lat				:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[146..155]);
	self.geo_long				:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[156..166]);
	self.msa						:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[167..170]);
	self.geo_blk				:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[171..177]);
	self.geo_match			:=	case(trim(l.country,left,right), 'CA' => '', l.clean_address[178]);
	self.err_stat				:=	case(trim(l.country,left,right), 'CA' => l.clean_address[104..109], l.clean_address[179..182]);
	self								:=	l;
end;

ds_fedex_reformat := project(ds_fedex_clean, reformat(left));

ds_comp_cont_names_populated	:= ds_fedex_reformat(trim(first_name + last_name) <> '' and company_name <> '');
ds_others											:= ds_fedex_reformat(~(trim(first_name + last_name) <> '' and company_name <> ''));

fedex.layout_fedex_base normalize_names(ds_comp_cont_names_populated l, integer c) := transform
	self.last_name					:=	choose(c, l.last_name, l.company_name);
	self.first_name					:=	choose(c, l.first_name, '');
	self.middle_initial			:=	choose(c, l.middle_initial, '');
	self.business_indicator	:=	choose(c, '', 'Y');
	self										:=	l;
end;

ds_normalize_names := normalize(ds_comp_cont_names_populated, 2, normalize_names(left, counter));

fedex.layout_fedex_base reformat_cname(ds_others l) := transform
	self.last_name 					:= if(l.company_name != '', l.company_name, l.last_name);
	self.business_indicator	:= if(l.company_name != '', 'Y', '');
	self := l;
end;

switch_company_name := project(ds_others, reformat_cname(left));

ut.MAC_SF_BuildProcess(ds_normalize_names+switch_company_name, '~thor_data400::base::fedex::nohits', build_base,,,true);

export proc_fedex_build_base := build_base;