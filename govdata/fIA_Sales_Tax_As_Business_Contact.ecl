import Business_Header, ut,mdr,address;

export fIA_Sales_Tax_As_Business_Contact(dataset(Layout_IA_Sales_Tax_In) pInputfile) :=
function

	f := pInputfile;

	Business_Header.Layout_Business_Contact_Full_New Translate_IST_To_BCF(Layout_IA_Sales_Tax_In l) := transform
	self.source := MDR.sourceTools.src_IA_Sales_Tax;          // Source file type
	self.vl_id := 'IA' + l.permit_nbr;
	self.vendor_id := 'IA' + l.permit_nbr;
	self.dt_first_seen := (unsigned4)l.issue_date;
	self.dt_last_seen := (unsigned4)IA_Sales_Tax_File_Date;
	self.name_score := Datalib.NameClean(l.owner_name)[142],
	self.title := if(Address.Business.GetNameType(l.owner_name_first + ' ' + l.owner_name_middle + ' ' + l.owner_name_last + ' ' + l.owner_name_suffix) in ['P','D'] and datalib.CompanyClean(l.owner_name)[41..120] = '' and
					 (integer)(Business_Header.CleanName(l.owner_name_first, l.owner_name_middle, l.owner_name_last, l.owner_name_suffix)[142]) < 3,
					 l.owner_name_prefix, '');
	self.fname := if(Address.Business.GetNameType(l.owner_name_first + ' ' + l.owner_name_middle + ' ' + l.owner_name_last + ' ' + l.owner_name_suffix) in ['P','D'] and datalib.CompanyClean(l.owner_name)[41..120] = '' and
					 (integer)(Business_Header.CleanName(l.owner_name_first, l.owner_name_middle, l.owner_name_last, l.owner_name_suffix)[142]) < 3,
					 l.owner_name_first, datalib.NameClean(l.owner_name)[1..40]);
	self.mname := if(Address.Business.GetNameType(l.owner_name_first + ' ' + l.owner_name_middle + ' ' + l.owner_name_last + ' ' + l.owner_name_suffix) in ['P','D'] and datalib.CompanyClean(l.owner_name)[41..120] = '' and
					 (integer)(Business_Header.CleanName(l.owner_name_first, l.owner_name_middle, l.owner_name_last, l.owner_name_suffix)[142]) < 3,
					 l.owner_name_middle, datalib.NameClean(l.owner_name)[41..80]);
	self.lname := if(Address.Business.GetNameType(l.owner_name_first + ' ' + l.owner_name_middle + ' ' + l.owner_name_last + ' ' + l.owner_name_suffix) in ['P','D'] and datalib.CompanyClean(l.owner_name)[41..120] = '' and
					 (integer)(Business_Header.CleanName(l.owner_name_first, l.owner_name_middle, l.owner_name_last, l.owner_name_suffix)[142]) < 3,
					 l.owner_name_last, datalib.NameClean(l.owner_name)[81..120]);
	self.name_suffix := if(Address.Business.GetNameType(l.owner_name_first + ' ' + l.owner_name_middle + ' ' + l.owner_name_last + ' ' + l.owner_name_suffix) in ['P','D'] and datalib.CompanyClean(l.owner_name)[41..120] = '' and
					 (integer)(Business_Header.CleanName(l.owner_name_first, l.owner_name_middle, l.owner_name_last, l.owner_name_suffix)[142]) < 3,
					 l.owner_name_suffix, datalib.NameClean(l.owner_name)[131..140]);
	self.prim_range := l.location_prim_range;
	self.predir := l.location_predir;
	self.prim_name := l.location_prim_name;
	self.addr_suffix := l.location_addr_suffix;
	self.postdir := l.location_postdir;
	self.unit_desig := l.location_unit_desig;
	self.sec_range := l.location_sec_range;
	self.city := l.location_v_city_name;
	self.state := l.location_st;
	self.zip := (unsigned3)l.location_zip;
	self.zip4 := (unsigned2)l.location_zip4;
	self.county := l.location_fipscounty;
	self.msa := l.location_msa;
	self.geo_lat := l.location_geo_lat;
	self.geo_long := l.location_geo_long;
	self.phone := 0;
	self.email_address := '';
	self.company_title := 'OWNER';
	self.company_source_group := 'IA' + l.permit_nbr; // Source group
	self.company_name := if(l.trade_name <> '', Stringlib.StringToUpperCase(l.trade_name),
												Stringlib.StringToUpperCase(l.owner_name));
	self.company_prim_range := l.location_prim_range;
	self.company_predir := l.location_predir;
	self.company_prim_name := l.location_prim_name;
	self.company_addr_suffix := l.location_addr_suffix;
	self.company_postdir := l.location_postdir;
	self.company_unit_desig := l.location_unit_desig;
	self.company_sec_range := l.location_sec_range;
	self.company_city := l.location_v_city_name;
	self.company_state := l.location_st;
	self.company_zip := (unsigned3)l.location_zip;
	self.company_zip4 := (unsigned2)l.location_zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	//self := l; currently has no effect
	end;

	return project(f(owner_name <> '',
			   (Address.Business.GetNameType(owner_name_first + ' ' + owner_name_middle + ' ' + owner_name_last + ' ' + owner_name_suffix) in ['P','D'] and datalib.CompanyClean(owner_name)[41..120] = '' and
			   (integer)(Business_Header.CleanName(owner_name_first, owner_name_middle, owner_name_last, owner_name_suffix)[142]) < 3) or
			   (integer)(Datalib.NameClean(owner_name)[142]) < 3),
				   Translate_IST_To_BCF(left));
end;