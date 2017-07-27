import business_header, ut,mdr;

export fIRS_Non_Profit_As_Business_Contact(dataset(govdata.Layouts_IRS_NonProfit.Base_AID) pBasefile) :=
function

	f := pBasefile;

	Business_Header.Layout_Business_Contact_Full_New into(f L) := transform
		// Gen Data
		SELF.bdid := L.bdid;       
		SELF.did := 0;
		SELF.vl_id := L.employer_id_number + l.group_exemption_number;
		SELF.vendor_id := L.employer_id_number + l.group_exemption_number;
		SELF.dt_first_seen := if((integer) l.ruling_date > 190000,
					((integer) l.ruling_date) * 100, 
					if((integer) l.tax_period > 190000,
						((integer) l.tax_period) * 100,
						(integer) l.process_date));
		SELF.dt_last_seen := (integer) l.process_date;
		SELF.source := MDR.sourceTools.src_IRS_Non_Profit;
		SELF.record_type := 'C';
		
		// Business Data
		SELF.company_source_group := '';
		SELF.company_name := L.primary_name_of_organization;
		SELF.company_prim_range := L.prim_range;
		SELF.company_predir := L.predir;
		SELF.company_prim_name := L.prim_name;
		SELF.company_addr_suffix := L.addr_suffix;
		SELF.company_postdir := L.postdir;
		SELF.company_unit_desig := L.unit_desig;
		SELF.company_sec_range := L.sec_range;
		SELF.company_city := L.v_city_name;
		SELF.company_state := L.st;
		SELF.company_zip := (INTEGER)L.zip;
		SELF.company_zip4 := (INTEGER)L.zip4;
		SELF.company_phone := 0;	
		SELF.company_fein := (INTEGER)L.employer_id_number;
		
		// Person data
		SELF.company_title := '';   // Title of Contact at Company if available
		SELF.city := L.v_city_name;
		SELF.state := L.st;
		SELF.zip := (INTEGER)L.zip;
		SELF.zip4 := (INTEGER)L.zip4;
		SELF.county := L.county[3..5];
		SELF.phone := 0;
		SELF.email_address := '';
		SELF.ssn := 0;
		SELF.rawaid := l.Append_RawAID;
		Self.company_rawaid := l.Append_RawAID;
		SELF := l;
	end;

	p := project(f, into(left));
	return p(lname != '');

end;