import bankruptcyv2, address, ut, data_services, std;

kfMain	 := dataset(data_services.foreign_prod + 'thor_data400::base::override::fcra::qa::bankrupt_main',FCRA.Layout_Override_bk_filing,flat);

layout_main_ffid_v3 := record
	bankruptcyv2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing;
	string20 flag_file_id;
end;

layout_main_ffid_v3 toV3Main(FCRA.Layout_Override_bk_filing input) := transform
	string73 tempname 		:= 	Address.CleanPersonFML73(input.trustee_name);
	pname 					:= 	Address.CleanNameFields(tempName);
	string182 clean_address	:= 	Address.CleanAddress182(trim(input.trustee_address1,left,right),
														trim(	trim(input.trustee_city,left,right) + ', ' +
																trim(input.trustee_st,left,right) + ' ' +
																trim(input.trustee_zip),left,right));	
	self.tmsid				:=	'BK' + input.court_code + input.case_number;
	self.process_date		:=	(STRING8)Std.Date.Today();
	self.trusteeName 		:= 	input.trustee_name;
	self.trusteePhone 		:= 	input.trustee_phone;
	self.trusteeAddress 	:= 	input.trustee_address1;
	self.trusteeCity 		:= 	input.trustee_city;
	self.trusteeState 		:= 	input.trustee_st;
	self.trusteeZip 		:=	input.trustee_zip;
	self.trusteeZip4 		:= 	input.trustee_zip4;
	self.fname				:=	pname.fname;
	self.mname				:=	pname.mname;
	self.lname				:=	pname.lname;
	self.name_suffix		:=	pname.name_suffix;
	self.prim_range			:=	clean_address[1..10];
	self.predir				:=	clean_address[11..12];
	self.prim_name			:=	clean_address[13..40];
	self.addr_suffix		:=	clean_address[41..44];
	self.postdir			:=	clean_address[45..46];
	self.unit_desig			:=	clean_address[47..56];
	self.sec_range			:=	clean_address[57..64];
	self.p_city_name		:=	clean_address[65..89];
	self.v_city_name		:=	clean_address[90..114];
	self.st					:=	clean_address[115..116];
	self.zip				:=	clean_address[117..121];
	self.zip4				:=	clean_address[122..125];
	self.cart				:=	clean_address[126..129];
	self.cr_sort_sz			:=	clean_address[130];
	self.lot				:=	clean_address[131..134];
	self.lot_order			:=	clean_address[135];
	self.dbpc				:=	clean_address[136..137];
	self.chk_digit			:=	clean_address[138];
	self.rec_type			:=	clean_address[139..140];
	self.county				:=	clean_address[143..145];
	self.geo_lat			:=	clean_address[146..155];
	self.geo_long			:=	clean_address[156..166];
	self.msa				:=	clean_address[167..170];
	self.geo_blk			:=	clean_address[171..177];
	self.geo_match			:=	clean_address[178];
	self.err_stat			:=	clean_address[179..182];
	self 					:= 	input;
	self 					:= 	[];
end;

kv3 := project(kfMain, toV3Main(left));

export key_override_bkv3_main_ffid := index (kv3, 
                                             {flag_file_id}, 
                                             {kv3}, 
                                             data_services.data_location.prefix() + 'thor_data400::key::override::fcra::bankrupt_filing::qa::ffid_v3');