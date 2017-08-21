import YellowPages, address;

TargusIn	:=	YellowPages.Files.Input.Using(business_name <> '');


YellowPages.Layout_YellowPages_InputTemp CleanAddr(YellowPages.Layout_YellowPages input) := transform	
	address1					:= stringlib.StringToUppercase(trim(	trim(input.house,left,right) + ' ' +
											trim(input.predir,left,right) + ' ' + 
											trim(input.Street,left,right) + ' ' +
											trim(input.StreetType,left,right) + ' ' +
											trim(input.Postdir,left,right) + ' ' +
											trim(input.AptType,left,right) + ' ' +
											trim(input.AptNbr,left,right) + ' ' +
											trim(input.BoxNbr,left,right),
											left,right));
										

	string182 clean_address		:= Address.CleanAddress182(	address1,
															stringlib.StringToUppercase(trim(	trim(input.orig_city,left,right) + ', ' +
																	trim(input.orig_state,left,right) + ' ' +
																	trim(input.orig_zip,left,right),
																	left,right
																))
														  );	
																				
	self.prim_range				:= clean_address[1..10];
	self.predir					:= clean_address[11..12];
	self.prim_name				:= clean_address[13..40];
	self.suffix					:= clean_address[41..44];
	self.postdir				:= clean_address[45..46];
	self.unit_desig				:= clean_address[47..56];
	self.sec_range				:= clean_address[57..64];
	self.p_city_name			:= clean_address[65..89];
	self.v_city_name			:= clean_address[90..114];
	self.st						:= clean_address[115..116];
	self.zip					:= clean_address[117..121];
	self.zip4					:= clean_address[122..125];
	self.cart					:= clean_address[126..129];
	self.cr_sort_sz				:= clean_address[130];
	self.lot					:= clean_address[131..134];
	self.lot_order				:= clean_address[135];
	self.dpbc					:= clean_address[136..137];
	self.chk_digit				:= clean_address[138];
	self.rec_type				:= clean_address[139..140];
	self.ace_fips_st			:= clean_address[141..142];
	self.county					:= clean_address[143..145];
	self.geo_lat				:= clean_address[146..155];
	self.geo_long				:= clean_address[156..166];
	self.msa					:= clean_address[167..170];
	self.geo_blk				:= clean_address[171..177];
	self.geo_match				:= clean_address[178];
	self.err_stat				:= clean_address[179..182];
	self.orig_street			:= address1;
	self.addr_suffix_flag		:= 'N';
	self.bus_name_flag			:= 'Y';
	self.business_name			:= stringlib.StringToUppercase(input.business_name);
	self.orig_city				:= stringlib.StringToUppercase(input.orig_city);
	self.BusShortName			:= stringlib.StringToUppercase(input.BusShortName);
	self.BusDeptName			:= stringlib.StringToUppercase(input.BusDeptName);
	self						:= input;
	self						:= [];
end;
		
TargusInAddrCleaned	:=	project(TargusIn, CleanAddr(left));			
			
npanxx_layout	:=	record
	string3		npa;
	string3		nxx;
	string25	city;
	string2		state;
	string5		zip;
	string1		aceFlag;
	string25	altCity1;
	string5		altZip1;
	string25	altCity2;
	string5		altZip2;
	string1		lf;
end;

npaState_layout	:=	record
	string3		npa;
	string2		state;
	string1		lf;
end;

npanxx_lookup	:=	dataset('~thor_data400::in::targus::yellowpages::npanxx', npanxx_layout, flat);

npaState_lookup	:=	dataset('~thor_data400::in::targus::yellowpages::npa_state', npaState_layout,flat);

YellowPages.Layout_YellowPages_InputTemp join4NPANXX(YellowPages.Layout_YellowPages_InputTemp l, npanxx_layout r)	:=	transform
	self.nn_fix_city		:=	r.city;
	self.nn_fix_state		:=	r.state;	
	self.nn_fix_zip			:=	r.zip;
	self.nn_fix_ace_flag	:=	r.aceFlag;
	self.nn_fix_alt_city1	:=	r.altCity1;
	self.nn_fix_alt_zip1	:=	r.altZip1;
	self.nn_fix_alt_city2	:=	r.altCity2;
	self.nn_fix_alt_zip2	:=	r.altZip2;
	self.n_fix_state		:=	'';
	self					:=	l;
end;	

Add_NPANXX	 	:=		join(	TargusInAddrCleaned,
								npanxx_lookup,
								left.orig_phone10[1..3] = right.npa and
								left.orig_phone10[4..6] = right.nxx,
								join4NPANXX(left,right),
								lookup,
								left outer
							);	
							
YellowPages.Layout_YellowPages_InputTemp join4NPAState(YellowPages.Layout_YellowPages_InputTemp l, npaState_layout r)	:=	transform
	self.n_fix_state		:=	r.state;
	self					:=	l;
end;	

export CleanedInput	:=	join(	Add_NPANXX,
								npaState_lookup,
								left.orig_phone10[1..3] = right.npa,
								join4NPAState(left,right),
								lookup,
								left outer
							) :persist ('~thor_data400::persist::yellowpages::CleanedInput');	