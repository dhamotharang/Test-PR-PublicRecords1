import Sheila_Greco,MDR;

export SheilaGreco_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := Sheila_Greco.Files('').Base.Companies.QA;
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(rawfields.maincompanyid != '' and rawfields.companyname != '');
		
		extract := normalize(filtered,if(left.clean_address.v_city_name != left.clean_address.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Sheila_Greco,
				self.source_docid := left.rawfields.maincompanyid,
				self.source_party := '',
				self.date_first_seen := (unsigned4)left.dt_first_seen,
				self.date_last_seen := (unsigned4)left.dt_last_seen,
				self.company_name := left.rawfields.companyname,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := left.raw_aid,
				self.prim_range := left.clean_address.prim_range,
				self.predir := left.clean_address.predir,
				self.prim_name := left.clean_address.prim_name,
				self.addr_suffix := left.clean_address.addr_suffix,
				self.postdir := left.clean_address.postdir,
				self.unit_desig := left.clean_address.unit_desig,
				self.sec_range := left.clean_address.sec_range,
				self.city_name := choose(counter,
					left.clean_address.p_city_name,
					left.clean_address.v_city_name),
				self.state := left.clean_address.st,
				self.zip := left.clean_address.zip,
				self.zip4 := left.clean_address.zip4,
				self.county_fips := left.clean_address.fips_county,
				self.msa := left.clean_address.msa,
				self.phone := left.clean_phones.phone,
				self.fein := '',
				self.url := left.rawfields.weburl,
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return extract;
	
	end;
	
	export dataset(Layout_URLs.Unlinked) As_URL_Master := function
	
		filtered := base(rawfields.maincompanyid != '' and rawfields.weburl != '');
		
		extract := project(filtered,
			transform(Layout_URLs.Unlinked,
				self.source := MDR.sourceTools.src_Sheila_Greco,
				self.source_docid := left.rawfields.maincompanyid,
				self.source_party := '',
				self.url := left.rawfields.weburl));
		
		return extract;
	
	end;
	
	export dataset(Layout_Finance.Unlinked) As_Finance_Master := function
	
		filtered := base(rawfields.maincompanyid != '' and rawfields.sales != '');
		
		extract := project(filtered,
			transform(Layout_Finance.Unlinked,
				self.source := MDR.sourceTools.src_Sheila_Greco,
				self.source_docid := left.rawfields.maincompanyid,
				self.source_party := '',
				self.ticker := left.rawfields.ticker,
				self.annualsalesrevisiondate := intformat(left.clean_dates.lastupdate,8,1),
				self.sales := (integer)left.rawfields.sales, // units ???, 1000s, 100,000Ks or millions ???
				self := []));
		
		return extract;
	
	end;
	
	export dataset(Layout_Industry.Unlinked) As_Industry_Master := function
	   
		filtered := base(rawfields.maincompanyid != '' and
			(rawfields.primaryindustry != '' or rawfields.siccode != ''));
		
		pattern p_digit := pattern('[0-9]');
		pattern p_nondigit := pattern('[^0-9]');
		pattern p_sic := p_digit p_digit;
		pattern p_sicfull := (p_sic after (first or p_nondigit)) before (p_nondigit or last);
		
		temprec := record
			filtered.rawfields.maincompanyid;
			string siccode := matchtext(p_sic);
		end;
		
		parsed := parse(filtered(rawfields.siccode != ''),rawfields.primaryindustry,p_sicfull,temprec,scan all);
		
		extract_1 := project(filtered(rawfields.primaryindustry != ''),
		  transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.src_Sheila_Greco,
				self.source_docid := left.rawfields.maincompanyid,
				self.source_party := '',
				self.SicCode := '';
				self.industry_description := stringlib.StringToUpperCase(left.rawfields.primaryindustry);
				self.NAICS := '';
      ));
		
		extract_2 := project(parsed,
			transform(Layout_Industry.Unlinked,
				self.source := MDR.sourceTools.src_Sheila_Greco,
				self.source_docid := left.maincompanyid,
				self.source_party := '',
				self.siccode := left.siccode,
				self.industry_description := '';
				self.NAICS := '';
			));
			
		return extract_1 + extract_2;
		
	end;

	export dataset(Layout_Abstract.Unlinked) As_Abstract_Master := function

	  filtered := base(rawfields.maincompanyid != '' and	rawfields.description != '');

		extract := project(filtered,
		  transform(Layout_Abstract.unlinked,
			  self.source := MDR.sourceTools.src_Sheila_Greco,
				self.source_docid := left.rawfields.maincompanyid,
			  self.source_party := '',
	      // The rawfields.desccription field contains a textual description of the company.
				// So it was decided to put that type of info in the business_description 
				// field on the layout_abstract instead of on the layout_industry.
        self.business_description := left.rawfields.description;
			));

		return extract;

	end;
		
end;
