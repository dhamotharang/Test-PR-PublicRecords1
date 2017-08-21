import Business_Header, ut,mdr;

export fProf_License_As_Business_Contact(

	dataset(prof_license.layout_prolic_out_with_AID) pProfLic = Prof_License.File_prof_license_base_AID,boolean isPRCT=false

) :=
  function

	f := pProfLic(business_flag = 'Y', company_name <> '', lname <> '', prolic_key[1..1]<>'C');

	Business_Header.Layout_Business_Contact_Full_New Translate_Proflic_To_BCF(prof_license.layout_prolic_out_with_AID l) := transform
	self.source := MDR.sourceTools.src_Professional_License;          // Source file type
	self.vl_id := if(l.source_st<> '', l.source_st, l.st) + if(l.license_number <> '', l.license_number, l.orig_license_number);
	self.vendor_id := if(l.source_st<> '', l.source_st, l.st) + if(l.license_number <> '', l.license_number, l.orig_license_number);
	self.dt_first_seen := (unsigned4)map(l.date_first_seen <> '' => l.date_first_seen,
							  l.issue_date <> '' => l.issue_date,
							  l.last_renewal_date <> '' => l.last_renewal_date,
							  version);
	self.dt_last_seen := (unsigned4)map(l.date_last_seen <> '' => l.date_last_seen,
							  l.last_renewal_date <> '' => l.last_renewal_date,
							  l.issue_date <> '' => l.issue_date,
							  version);
	self.name_score := Business_Header.CleanName(l.fname, l.mname, l.lname, l.name_suffix)[142],
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.rawaid	:=	l.rawaid;
	self.phone := (unsigned6)l.phone;
	self.email_address := '';
	self.company_title := l.profession_or_board;
	self.company_source_group := '';
	self.company_name := Stringlib.StringToUpperCase(l.company_name);
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self.addr_suffix := l.suffix;
	self.Company_RawAID	:=	l.RAWAID;
	SELF.bdid           := If(IsPRCT,(integer)l.BDID,0);
	//self.bdid := 0;
	SELF.did           := If(IsPRCT,(integer)l.DID,0);
	//self.did := 0;
	self := l;
	end;

	Proflic_Contacts := project(f, Translate_Proflic_To_BCF(left));

	Proflic_Contacts_Filtered	:=	Proflic_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));
	
	return Proflic_Contacts_Filtered;
	
  end
 ;
