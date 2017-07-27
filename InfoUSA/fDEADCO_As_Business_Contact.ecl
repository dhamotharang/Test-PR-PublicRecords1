import business_header, infousa, ut;

export fDEADCO_As_Business_Contact(dataset(infousa.Layout_DEADCO_Clean_In) pDEADCO)
 :=
  function

	DEADCO_IN := pDEADCO;


	business_header.Layout_Business_Contact_Full tDEADCOtoHEADER(infousa.Layout_DEADCO_Clean_In L) := transform

	self.title                := L.title;
	self.fname                := L.fname;
	self.mname                := L.mname;
	self.lname                := L.lname;
	self.name_suffix          := L.name_suffix;
	self.company_title        := ''; 
	self.vendor_id            := L.ABI_number + L.production_date;
	self.source               := 'ID';//waiting for replay from the vendor
	self.name_score           := Business_Header.CleanName(l.fname,l.mname,l.lname, l.name_suffix)[142];
	self.prim_range		      := L.prim_range ;
	self.predir			      := L.predir;
	self.prim_name	          := L.prim_name;
	self.addr_suffix	      := L.addr_suffix;
	self.postdir		      := L.postdir;
	self.unit_desig		      := L.unit_desig;
	self.sec_range		      := L.sec_range;
	self.city			      := L.p_city_name;
	self.state			      := L.st;
	self.zip 			      := (unsigned3)L.zip5;
	self.zip4			      := (unsigned2)L.zip4;
	self.county			      := L.ace_fips_county;
	self.msa			      := L.msa;
	self.geo_lat		      := L.geo_lat;
	self.geo_long		      := L.geo_long;
	SELF.company_name         := stringlib.stringtouppercase(L.company_name);
	self.company_source_group := L.ABI_number;
	SELF.company_prim_range   := L.prim_range;
	SELF.company_predir       := L.predir;
	SELF.company_prim_name    := L.prim_name;
	SELF.company_addr_suffix  := L.addr_suffix;
	SELF.company_postdir      := L.postdir;
	SELF.company_unit_desig   := L.unit_desig;
	SELF.company_sec_range    := L.sec_range;
	SELF.company_city         := L.p_city_name;
	SELF.company_state        := L.st;
	SELF.company_zip          := (UNSIGNED3)L.zip5;
	SELF.company_zip4         := (UNSIGNED2)L.zip4;
	self.company_phone        := (UNSIGNED6)((UNSIGNED8)L.Phone);
	self.company_fein         := 0;
	self.phone                := (unsigned6)((unsigned8)L.Phone);
	self.email_address        := '';
	self.dt_first_seen        := if((unsigned)L.dt_first_seen < 300000, (unsigned)L.dt_first_seen * 100, (unsigned)L.dt_first_seen);
	self.dt_last_seen         := if((unsigned)L.dt_last_seen < 300000, (unsigned)L.dt_last_seen * 100, (unsigned)L.dt_last_seen);
	self.record_type          := 'C';
	//self := L;
	end;

	deadco_header := project(DEADCO_IN,tDEADCOtoHEADER(LEFT));

	// Removed extra contacts with blank addresses
	deadco_dist := distribute(deadco_header(lname <> ''), hash(trim(vendor_id), trim(company_name)));

	deadco_sort := sort(deadco_dist, vendor_id, company_name,
						 fname, mname, lname, name_suffix, company_title, phone, if(zip <> 0, 0, 1), zip, prim_name, prim_range, 
						 local);

	deadco_dedup := dedup(deadco_sort,
								 left.vendor_id = right.vendor_id and
								 left.company_name = right.company_name and
								 left.fname= right.fname and
								 left.mname = right.mname and
								 left.lname = right.lname and
								 left.name_suffix = right.name_suffix and
								 left.company_title = right.company_title and
								 ((left.zip = right.zip and
								 left.prim_name = right.prim_name and
								 left.prim_range = right.prim_range) or
								 (left.zip <> 0 and right.zip = 0)),
								 local);

	deadco_dedup_filtered	:=	deadco_dedup((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));
	
	return deadco_dedup_filtered;
	
  end
 ;
