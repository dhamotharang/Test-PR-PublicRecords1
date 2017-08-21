IMPORT ut, Business_Header, uccd;

export fUCC_Party_As_Business_Contact(dataset(recordof(uccd.UCC_Parties_Wdates)) pUCC)
 :=
  function

	//*********************************************************************************
	// Translate Contacts from UCC Debtor and Secured Master to Business Contact Format
	//*********************************************************************************

	UCC_Parties_Clean := pUCC(lname <> '');

	Business_Header.Layout_Business_Contact_Full Translate_UCC_to_BCF(UCC_Parties_Clean L) := TRANSFORM
	SELF.company_title := '';   // Title of Contact at Company if available
	SELF.name_score := Business_Header.CleanName(L.fname,L.mname,L.lname,L.name_suffix)[142];
	SELF.addr_suffix := L.addr_suffix;
	SELF.city := L.p_city_name;
	SELF.zip := (UNSIGNED3)L.zip;
	SELF.zip4 := (UNSIGNED2)L.zip4;
	SELF.phone := 0;
	SELF.source := 'U';
	SELF.record_type := l.record_type;
	SELF.company_name := L.name;
	SELF.vendor_id := (QSTRING34)((STRING34)
		(L.file_state + if(L.orig_filing_num <> '', L.orig_filing_num, L.ucc_key[4..35])));
	SELF.company_prim_range := L.prim_range;
	SELF.company_predir := L.predir;
	SELF.company_prim_name := L.prim_name;
	SELF.company_addr_suffix := L.addr_suffix;
	SELF.company_postdir := L.postdir;
	SELF.company_unit_desig := L.unit_desig;
	SELF.company_sec_range := L.sec_range;
	SELF.company_city := L.p_city_name;
	SELF.company_state := L.st;
	SELF.company_zip := (UNSIGNED3)L.zip;
	SELF.company_zip4 := (UNSIGNED2)L.zip4;
	SELF.company_phone := 0;
	SELF.dt_first_seen := (unsigned)l.dt_first_seen;
	SELF.dt_last_seen := (unsigned)l.dt_last_seen;
	SELF.ssn := (UNSIGNED4)L.ssn;
	SELF.email_address := '';
	self.bdid := 0;
	self.did := 0;
	self.state := l.st;
	self.county := l.fips_county;
	SELF := L;
	END;

	UCC_Contacts := PROJECT(UCC_Parties_Clean, Translate_UCC_to_BCF(LEFT));

	UCC_Contacts_Filtered	:=	UCC_Contacts(company_name<>'', 
											 lname<>'',fname<>'',
											 (prim_range <> '' or prim_name <> ''),
											 (INTEGER)name_score < 3, 
											 Business_Header.CheckPersonName(fname, mname, lname, name_suffix)
											);

	return UCC_Contacts_Filtered;

  end
 ;