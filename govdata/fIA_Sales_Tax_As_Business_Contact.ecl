import Business_Header, ut,mdr,address;

export fIA_Sales_Tax_As_Business_Contact(dataset(Layout_IA_SalesTax_Base) pInputfile) :=
function

	f := pInputfile;

	Business_Header.Layout_Business_Contact_Full_New Translate_IST_To_BCF(Layout_IA_SalesTax_Base l) := transform
	self.source := MDR.sourceTools.src_IA_Sales_Tax;          // Source file type
	self.vl_id := 'IA' + l.permit_nbr;
	self.vendor_id := 'IA' + l.permit_nbr;
	self.dt_first_seen := (unsigned4)l.issue_date;
	self.dt_last_seen := (unsigned4)IA_Sales_Tax_File_Date;
	self.name_score := l.ownerName.name_score,
	self.title := l.ownerName.title;
	self.fname := l.ownerName.fname;
	self.mname := l.ownerName.mname;
	self.lname := l.ownerName.lname;
	self.name_suffix := l.ownerName.name_suffix;
	self.prim_range := l.locationAddress.prim_range;
	self.predir := l.locationAddress.predir;
	self.prim_name := l.locationAddress.prim_name;
	self.addr_suffix := l.locationAddress.addr_suffix;
	self.postdir := l.locationAddress.postdir;
	self.unit_desig := l.locationAddress.unit_desig;
	self.sec_range := l.locationAddress.sec_range;
	self.city := l.locationAddress.v_city_name;
	self.state := l.locationAddress.st;
	self.zip := (unsigned3)l.locationAddress.zip;
	self.zip4 := (unsigned2)l.locationAddress.zip4;
	self.county := l.locationAddress.fips_county;
	self.msa := l.locationAddress.msa;
	self.geo_lat := l.locationAddress.geo_lat;
	self.geo_long := l.locationAddress.geo_long;
	self.phone := 0;
	self.email_address := '';
	self.company_title := 'OWNER';
	self.company_source_group := 'IA' + l.permit_nbr; // Source group
	self.company_name := l.company_name_1;
	self.company_prim_range := l.locationAddress.prim_range;
	self.company_predir := l.locationAddress.predir;
	self.company_prim_name := l.locationAddress.prim_name;
	self.company_addr_suffix := l.locationAddress.addr_suffix;
	self.company_postdir := l.locationAddress.postdir;
	self.company_unit_desig := l.locationAddress.unit_desig;
	self.company_sec_range := l.locationAddress.sec_range;
	self.company_city := l.locationAddress.v_city_name;
	self.company_state := l.locationAddress.st;
	self.company_zip := (unsigned3)l.locationAddress.zip;
	self.company_zip4 := (unsigned2)l.locationAddress.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	//self := l; currently has no effect
	end;

	RETURN PROJECT( f(TRIM(ownerName.fname + ownerName.mname + ownerName.lname) <> '' AND company_name_1 = company_name_2),
                  Translate_IST_To_BCF(LEFT) );
                  
END;