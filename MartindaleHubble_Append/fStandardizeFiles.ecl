import ut, address;
export fStandardizeFiles(

	dataset(Layouts.Vendor) pVendorDataset

) :=
function

	//First Parse out the DOB
	ut.macAppendStandardizedDate(pVendorDataset, born_text, dDobAppend);

	layouts.standardized tStandardizeRecord(dDobAppend l) := 
	transform
		
		lfmname 					:= trim(l.last_name,left,right) + ', ' + trim(l.first_name,left,right);
		standardized_name := Address.CleanPersonLFM73_fields(lfmname);

		address1 := if(regexfind('[[:alpha:]]', trim(l.po_box)), trim(l.street) + ' ' + trim(l.po_box), trim(l.street));
		address2 := trim(l.city) + ', ' 
							+ trim(l.state) + ' ' 
							+ trim(l.zip);
		standardized_address := Address.CleanAddressParsed(address1, address2);

		self.title					:= standardized_name.title					;
		self.fname					:= standardized_name.fname					;
		self.mname					:= standardized_name.mname					;
		self.lname					:= standardized_name.lname					;
		self.name_suffix		:= standardized_name.name_suffix		;
		self.name_score			:= standardized_name.name_score			;
		self.dob						:= if(l.yyyy = '' or l.yyyy = '0000'
																,l.year_born + l.mm + l.dd
																,l.yyyy + l.mm + l.dd
														);
		self.prim_range		:= standardized_address.prim_range	;
		self.predir				:= standardized_address.predir			;
		self.prim_name		:= standardized_address.prim_name		;
		self.addr_suffix	:= standardized_address.addr_suffix	;
		self.postdir			:= standardized_address.postdir			;
		self.unit_desig		:= standardized_address.unit_desig	;
		self.sec_range		:= standardized_address.sec_range		;
		self.p_city_name	:= standardized_address.p_city_name	;
		self.v_city_name	:= standardized_address.v_city_name	;
		self.st						:= standardized_address.st					;
		self.zip					:= standardized_address.zip					;
		self.zip4					:= standardized_address.zip4				;
		self.cart					:= standardized_address.cart				;
		self.cr_sort_sz		:= standardized_address.cr_sort_sz	;
		self.lot					:= standardized_address.lot					;
		self.lot_order		:= standardized_address.lot_order		;
		self.dbpc					:= standardized_address.dbpc				;
		self.chk_digit		:= standardized_address.chk_digit		;
		self.rec_type			:= standardized_address.rec_type		;
		self.fips_state		:= standardized_address.fips_state	;
		self.fips_county	:= standardized_address.fips_county	;
		self.geo_lat			:= standardized_address.geo_lat			;
		self.geo_long			:= standardized_address.geo_long		;
		self.msa					:= standardized_address.msa					;
		self.geo_blk			:= standardized_address.geo_blk			;
		self.geo_match		:= standardized_address.geo_match		;
		self.err_stat			:= standardized_address.err_stat		;
		self.did := 0;
		self.did_score := 0;
		self.RawFields 												:= l;
																															
	end;

	standardized_file := project(dDobAppend, tStandardizeRecord(left));
	
	return standardized_file;

end;