import doxie,ut,Address,did_add,mdr, dx_header, Suppress;

//NOTE: address_type gets set here, but then updated later by Fedex_Services.fn_CheckAddrType

export mod_Formatting := 
MODULE

// return layout
shared outrec := Fedex_Services.Layouts.out;

// to filter results
shared fil(dataset(outrec) l) := 
function
    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
    temp_outrec:= RECORD
		outrec;
		UNSIGNED4 global_sid;
		UNSIGNED8 record_sid;
	END;

	notpobox 		:= ~ut.isPOBox(l.prim_name);
	deliverable := l.zip4 <> '';
	
	good := notpobox and deliverable;
	
    fixed_DRM := mod_access.DataRestrictionMask;
    
    header_recs_all :=  join(	//if the gong record is not deliverable, but the person has a header record at a very similar address that is deliverable, use that address instead
			l(l.internal_src = fedex_services.Contants.internal_src_gong and l.did > 0 and not deliverable and notpobox),
			dx_header.Key_Header(),
			keyed(left.did = right.s_did) and 
			right.zip4 <> '' and	//this ensures that the address we are patching in is deliverable
			left.prim_range = right.prim_range and  //this line was added last and prevents a slightly wrong address when i search 6624294274
			DID_Add.Address_Match_Score(left.prim_range,left.prim_name,left.sec_range,left.zip5,right.prim_range,right.prim_name,right.sec_range,right.zip) <= 80 and
			~doxie.compliance.isHeaderSourceRestricted(right.src, mod_access.DataRestrictionMask),
			transform(
				temp_outrec,
				self.prim_range 			:= right.prim_Range;
				self.predir 					:= right.predir;
				self.prim_name 				:= right.prim_name;
				self.addr_suffix 			:= right.suffix;
				self.postdir 					:= right.postdir;
				self.unit_desig 			:= right.unit_desig;
				self.sec_range 				:= right.sec_range;
				self.v_city_name 			:= right.city_name;
				self.st 							:= right.st;
				self.zip5 						:= right.zip;
				self.PostalCode 			:= right.zip;	//see check in comments for 10/1/08
				self.zip4 						:= right.zip4;
				self.internal_src			:= fedex_services.Contants.internal_src_gong_patched;
				self.country				:= if (Fedex_Services.Inputs.isCanadaSearch,Fedex_Services.Contants.str_CA,Fedex_Services.Contants.str_US);
				self.global_sid				:= right.global_sid;
				self.record_sid				:= right.record_sid;
				self := left
			),
			keep(1),
			limit(500, skip)
		);

        header_recs := Suppress.MAC_SuppressSource(header_recs_all, mod_access);
        recs_out := PROJECT(header_recs,outrec);
    return l(good) + recs_out;
		

end;

// to filter canadian results
shared fil_can(dataset(outrec) l) := 
function

	notpobox 		:= ~ut.isPOBox(l.prim_name);
	deliverable := l.err_stat[1] <> 'E';
	
	good := notpobox and deliverable;

	return 
		l(good);

end;	

// to filter fedex results
shared fil_fed(dataset(outrec) l) := 
function

	notpobox 		:= ~ut.isPOBox(l.prim_name);
	isCanadian  := length(trim(l.postalcode))=6;// THIS SHOULD CHECK COUNTRY FIELD ONCE THAT IS ADDED
	deliverable := l.zip4 <> '' OR (isCanadian and l.err_stat[1] <> 'E');
	
	good := notpobox and deliverable;

	return 
		l(good) +
		project(
			l(not deliverable),
			transform(
				outrec,
				self.isDeliverableAddress := false,
				self := left
			)
		);

end;
	
	
//to reclean
shared outrec addrclean(outrec l, unsigned1 region) := 
	transform
		addr1 := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,l.addr_suffix, l.postdir, l.unit_desig, l.sec_range);
		addr2 := Address.Addr2FromComponents(l.v_city_name, l.st, l.zip5);
		addrcleanparts := Address.GetCleanAddress(addr1, addr2, region).results;
		self.prim_range 			:= addrcleanparts.prim_Range;
		self.predir 					:= addrcleanparts.predir;
		self.prim_name 				:= addrcleanparts.prim_name;
		self.addr_suffix 			:= addrcleanparts.suffix;
		self.postdir 					:= addrcleanparts.postdir;
		self.unit_desig 			:= addrcleanparts.unit_desig;
		self.sec_range 				:= addrcleanparts.sec_range;
		self.v_city_name 			:= addrcleanparts.v_city;
		self.st 							:= addrcleanparts.state;
		self.zip5 						:= addrcleanparts.zip;
		self.PostalCode				:= addrcleanparts.zip; //see check-in comments for 10/1/08
		self.zip4 						:= addrcleanparts.zip4;
		self.country				:= if (Fedex_Services.Inputs.isCanadaSearch,Fedex_Services.Contants.str_CA,Fedex_Services.Contants.str_US);
		
		self := l;
	end;
			
shared reclean(dataset(outrec) l, unsigned1 region = address.Components.Country.US) := 
	project(l, addrclean(left, region));

	
//to check lname match
shared boolean is_exact_lname_match(string25 thelname)	:= 
	Fedex_Services.Inputs.valid_lname and 
	thelname = Fedex_Services.Inputs.lname;
shared boolean is_leading_lname_match(string25 thelname) := 
	Fedex_Services.Inputs.valid_lname and 
	thelname[1..LENGTH(TRIM(Fedex_Services.Inputs.lname))] = Fedex_Services.Inputs.lname;


//***** Fedex No-Hit Data
inrec := recordof(fedex_services.mod_Searches.FedexNoHit);
export FedexNoHitFormat(
		dataset(inrec) l) :=
function

	p := 
	project(
		l,
		transform(
			outrec,
			self.internal_src := fedex_services.Contants.internal_src_fedexNoHit,
			self.isFedexRecord := true,
			self.address_type := 
				if(
					left.company_name <> '', 
					Fedex_Services.Contants.str_Business, 
					Fedex_Services.Contants.str_Residential	
				), 
			self.dt_last_seen := 
				if(
					length(trim((string)left.dt_last_seen)) = 6, 
					(unsigned4)(left.dt_last_seen + '00'),
					(unsigned4)left.dt_last_seen
					);
			self.exact_lname_match := is_exact_lname_match(left.lname),
			self.leading_lname_match := is_leading_lname_match(left.lname),
			self.phone := left.phone,
			self.company_name := stringlib.stringtouppercase(left.company_name),
			self.PostalCode := left.zip6;
			self.zip5 := left.zip6;
			self.v_city_name := if(left.v_city_name = '', left.p_city_name, left.v_city_name); //could probably just use p_city_name for 'CA' records, but this will work
			self.country := 
				if (
					(Fedex_Services.Inputs.isCanadaSearch and left.country = Fedex_Services.Contants.str_US)
					OR
					(~Fedex_Services.Inputs.isCanadaSearch and left.country = Fedex_Services.Contants.str_CA),
					SKIP,
					left.country
				);
			self := left
		)
	)
	;
	
	// we dont want to reclean(p) the fedex data because it was just cleaned on thor and they really want it returned as-is

	return fil_fed(p);
end;


//***** Canada
inrec := recordof(fedex_Services.mod_Searches.Canada);
export CanadaFormat(
		dataset(inrec) l) := 
function
	p := 
	project(
		l,
		transform(
			outrec,
			self.internal_src := fedex_services.Contants.internal_src_canada,
			self.address_type := 
				if(
					left.listing_type = 'B',
					Fedex_Services.Contants.str_Business,
					Fedex_Services.Contants.str_Residential
				);
					
			
			self.dt_last_seen := (unsigned4)left.pub_date,  //also have date_last_reported, but this looks like a file date
			self.addr_suffix := left.addr_suffix,
			self.zip5 := left.zip,
			self.zip4 := '',
			self.st := left.state,
			self.v_city_name := left.p_city_name,
			self.exact_lname_match := is_exact_lname_match(stringlib.StringToUpperCase(left.lastname)),
			self.leading_lname_match := is_leading_lname_match(stringlib.StringToUpperCase(left.lastname)),
			self.phone := left.phonenumber,
			self.fname := stringlib.StringToUpperCase(left.firstname),
			self.mname := stringlib.StringToUpperCase(left.middlename),
			self.lname := stringlib.StringToUpperCase(left.lastname),
			self.company_name := stringlib.StringToUpperCase(left.company_name),
			self.err_stat := left.errstat,
			self.country := if (Fedex_Services.Inputs.isCanadaSearch,Fedex_Services.Contants.str_CA,Fedex_Services.Contants.str_US);
      self.did := 0,			
      self := left,
			self.bdid := 0,
			self.postdir := ''
		)
	);
	rc := reclean(p, address.Components.Country.CA);

	return fil_can(rc);
end;
		

//***** GONG
inrec := recordof(fedex_Services.mod_Searches.GongSearch);
export GongFormat(
		dataset(inrec) l) := 
function
	p := 
	project(
		l,
		transform(
			outrec,
			self.internal_src := fedex_services.Contants.internal_src_gong,
			self.address_type := 
				if(
					left.listing_type_bus <> '', 
					Fedex_Services.Contants.str_Business, 
					Fedex_Services.Contants.str_Residential	//listing_type_res also available if needed
				), 
			self.dt_last_seen := (unsigned4)left.dt_last_seen,
			self.addr_suffix := left.suffix,
			self.zip5 := left.z5,
			self.PostalCode := left.z5,  //see check-in comments for 10/1/08
			self.zip4 := left.z4,
			self.v_city_name := left.v_city_name,
			self.exact_lname_match := is_exact_lname_match(left.name_last),
			self.leading_lname_match := is_leading_lname_match(left.name_last),
			self.phone := left.phone10,
			self.fname := left.name_first,
			self.mname := left.name_middle,
			self.lname := left.name_last,
			self.err_stat := '',
			self.company_name := 
				if(
					left.listing_type_bus <> '', 
					left.listed_name,
					''
				),
			self.country := if (Fedex_Services.Inputs.isCanadaSearch,Fedex_Services.Contants.str_CA,Fedex_Services.Contants.str_US);
			self := left
		)
	);
	
	rc := reclean(p);

	return fil(rc);
end;
		
		
//***** PHONES+
inrec := recordof(fedex_Services.mod_Searches.PhonesPlusSearch);
export PhonesPlusFormat(
		dataset(inrec) l) := 
function
	p := 
	project(
		l,
		transform(
			outrec,
			self.internal_src := fedex_services.Contants.internal_src_phonesplus,
			self.address_type := 
				if(
					left.listing_type_bus <> '', 
					Fedex_Services.Contants.str_Business, 
					Fedex_Services.Contants.str_Residential	//listing_type_res also available
				), 
			self.dt_last_seen := (unsigned4)left.dt_last_seen,
			self.addr_suffix := left.suffix,
			self.zip5 := left.zip,
			self.PostalCode := left.zip,	//see check-in comments
			self.v_city_name := left.city_name,
			self.exact_lname_match := is_exact_lname_match(left.lname),
			self.leading_lname_match := is_leading_lname_match(left.lname),
			self.phone := left.phone,
			self.fname := left.fname,
			self.mname := left.mname,
			self.lname := left.lname,
			self.company_name := 
				if(
					left.listing_type_bus <> '', 
					left.listed_name,
					''
				),
			self.err_stat := '',
			self.country := if (Fedex_Services.Inputs.isCanadaSearch,Fedex_Services.Contants.str_CA,Fedex_Services.Contants.str_US);
			self := left
		)
	);
	
	rc := reclean(p);
	return fil(rc);
end;


//***** BUSINESS
inrec := recordof(fedex_Services.mod_Searches.BusinessSearch);
export BusinessFormat(
		dataset(inrec) l) := 
function
	p := 
	project(
		l,
		transform(
			outrec,
			self.internal_src := fedex_services.Contants.internal_src_business,
			self.address_type := Fedex_Services.Contants.str_Business,
			self.dt_last_seen := (unsigned4)left.dt_last_seen,
			self.zip5 := left.zip,
			self.PostalCode := left.zip,	//see check-in comments for 10/1/08
			self.zip4 := left.zip4,
			self.v_city_name := left.city,
			self.st := left.state,
			self.exact_lname_match := false,
			self.leading_lname_match := false,
			self.phone := (string10)left.phone,
			self.fname := '',
			self.mname := '',
			self.lname := '',
			self.company_name := left.company_name,
			self.country := if (Fedex_Services.Inputs.isCanadaSearch,Fedex_Services.Contants.str_CA,Fedex_Services.Contants.str_US);
			self.did := 0;
			self.err_stat := '',
			self := left
		)
	);
	
	rc := reclean(p);
	return fil(rc);
end;


//***** HEADER
inrec := recordof(fedex_Services.mod_Searches.HeaderSearch);
export HeaderFormat(
		dataset(inrec) l) := 
function

	outrec tra(inrec l, boolean useListedPhone = false) := 
	transform
		self.internal_src := fedex_services.Contants.internal_src_header,
		self.address_type := Fedex_Services.Contants.str_Residential, 
		self.dt_last_seen := (unsigned4)(l.dt_last_seen + '00'),
		self.addr_suffix := l.suffix,
		self.zip5 := l.zip,
		self.PostalCode := l.zip,	//see check-in comments for 10/1/08
		self.zip4 := l.zip4,
		self.v_city_name := l.city_name,
		self.exact_lname_match := is_exact_lname_match(l.lname),
		self.leading_lname_match := is_leading_lname_match(l.lname),
		self.fname := l.fname,
		self.mname := l.mname,
		self.lname := l.lname,
		self.company_name := '',
		self.phone := if(useListedPhone, l.listed_phone, l.phone),
		self.country := if (Fedex_Services.Inputs.isCanadaSearch,Fedex_Services.Contants.str_CA,Fedex_Services.Contants.str_US);
		self.err_stat := '',
		self := l
	end;

	onlyHaveListedPhone := l.phone = '' and l.listed_phone <> '';
	TwoPhones := l.phone <> '' and l.listed_phone <> '' and l.phone <> l.listed_phone;

	p := 
	project(
		l(not onlyHaveListedPhone),																					//unless listed_phone is all we have,																						
		tra(left, useListedPhone := false)  																//create a record with the phone field
	) +
	project(
		l(onlyHaveListedPhone or TwoPhones),																//if listed_phone is all we have OR we have distint phones
		tra(left, useListedPhone := true)  																	//then add a row that has the listed phone
	)	;
	
	rc := reclean(p);

	return fil(rc);
end;


END;