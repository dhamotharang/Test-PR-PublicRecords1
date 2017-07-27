import business_header, ut,mdr;

export fIRS_Non_Profit_As_Business_Header(dataset(govdata.Layouts_IRS_NonProfit.Base_AID) pBasefile) :=
function

	f := pBasefile;

	Business_Header.Layout_Business_Header_New into(f L) := transform
		// Gen Data
		SELF.rcid := 0;        
		SELF.bdid := L.bdid;
		SELF.vl_id := L.employer_id_number + l.group_exemption_number;
		SELF.vendor_id := L.employer_id_number + l.group_exemption_number;
		SELF.dt_first_seen := if((integer) l.ruling_date > 190000,
					((integer) l.ruling_date) * 100, 
					if((integer) l.tax_period > 190000,
						((integer) l.tax_period) * 100,
						(integer) l.process_date));
		SELF.dt_vendor_first_reported := SELF.dt_first_seen;
		SELF.dt_last_seen := (integer) l.process_date;
		SELF.dt_vendor_last_reported := (integer) l.process_date;
		SELF.source := MDR.sourceTools.src_IRS_Non_Profit;
		SELF.source_group := ''; 
		SELF.pflag := '';   
		SELF.group1_id := 0;  

		// Business Data
		SELF.company_name := L.primary_name_of_organization;
		SELF.prim_range := L.prim_range;
		SELF.predir := L.predir;
		SELF.prim_name := L.prim_name;
		SELF.addr_suffix := L.addr_suffix;
		SELF.postdir := L.postdir;
		SELF.unit_desig := L.unit_desig;
		SELF.sec_range := L.sec_range;
		SELF.city := L.v_city_name;
		SELF.state := L.st;
		SELF.zip := (INTEGER)L.zip;
		SELF.zip4 := (INTEGER)L.zip4;
		SELF.county := L.county[3..5];
		SELF.msa := L.msa;
		SELF.geo_lat := L.geo_lat;
		SELF.geo_long := L.geo_long;
		SELF.phone := 0;	
		SELF.phone_score := 0;
		SELF.fein := (INTEGER)L.employer_id_number;
		SELF.current := TRUE;
		SELF.rawaid := l.Append_RawAID
	end;

	p := project(f, into(left));

	return p(company_name != '');

end;