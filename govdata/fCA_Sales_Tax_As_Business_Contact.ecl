import Business_Header, ut,mdr,address;

export fCA_Sales_Tax_As_Business_Contact(dataset(Layout_CA_Sales_Tax) pBasefile) :=
function

	f := File_CA_Sales_Tax_BDID;

	Business_Header.Layout_Business_Contact_Full Translate_CST_To_BCF(Layout_CA_Sales_Tax l) := transform
	self.source := MDR.sourceTools.src_CA_Sales_Tax;          // Source file type
	self.vendor_id := 'CA' + l.ACCOUNT_NUMBER;
	self.dt_first_seen := (unsigned4)l.start_date;
	self.dt_last_seen := (unsigned4)CA_Sales_Tax_File_Date;
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142],
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.email_address := '';
	self.company_title := 'OWNER';
	self.company_source_group := 'CA' + l.ACCOUNT_NUMBER; // Source group
	self.company_name := Stringlib.StringToUpperCase(l.firm_name);
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self := l;
	end;

	return project(f(owner_name <> '', firm_name <> '',
			   Address.Business.GetNameType(name_first + ' ' + name_middle + ' ' + name_last + ' ' + name_suffix) in ['P','D']
				 and datalib.CompanyClean(owner_name)[41..120] = '',
			   (integer)(Business_Header.CleanName(name_first, name_middle, name_last, name_suffix)[142]) < 3),
				   Translate_CST_To_BCF(left));

end;
