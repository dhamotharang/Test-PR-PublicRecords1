IMPORT ut, Business_Header,mdr;

export fUCCV2_As_Business_contact(dataset(recordof(UCCV2.File_UCC_Party_Base_AID)) pUCC, boolean IsPRCT = false)
 :=
  function 

	//*********************************************************************************
	// Translate Contacts from UCC Debtor and Secured Master to Business Contact Format
	//*********************************************************************************

	Business_Header.Layout_Business_Contact_Full_New Translate_UCC_to_BCF(Layout_UCC_Common.Layout_Party_With_AID L) :=
	TRANSFORM
	  SELF.vl_id                := '';
		SELF.company_title				:= '';   // Title of Contact at Company if available
		SELF.name_score						:= Business_Header.CleanName(L.fname,L.mname,L.lname,L.name_suffix)[142];
		SELF.addr_suffix					:= L.suffix;
		SELF.city									:= L.v_city_name;
		SELF.zip									:= (UNSIGNED3)L.zip5;
		SELF.zip4									:= (UNSIGNED2)L.zip4;
		SELF.phone								:= 0;
		SELF.source								:= MDR.sourceTools.src_UCCV2;
		SELF.record_type					:= 'Y';
		SELF.company_name					:= L.company_name;
		SELF.vendor_id						:= l.tmsid;
		SELF.company_source_group	:= l.tmsid;
		SELF.company_prim_range 	:= L.prim_range;
		SELF.company_predir				:= L.predir;
		SELF.company_prim_name 		:= L.prim_name;
		SELF.company_addr_suffix	:= L.suffix;
		SELF.company_postdir			:= L.postdir;
		SELF.company_unit_desig		:= L.unit_desig;
		SELF.company_sec_range		:= L.sec_range;
		SELF.company_city					:= L.v_city_name;
		SELF.company_state				:= L.st;
		SELF.company_zip					:= (UNSIGNED3)L.zip5;
		SELF.company_zip4					:= (UNSIGNED2)L.zip4;
		SELF.company_phone				:= 0;
		SELF.dt_first_seen				:= (unsigned)l.dt_first_seen*100;
		SELF.dt_last_seen					:= (unsigned)l.dt_last_seen*100;
		SELF.ssn									:= (UNSIGNED4)L.ssn;
		SELF.email_address				:= '';
		self.bdid									:= IF(IsPRCT,L.bdid,0);
		self.did									:= IF(IsPRCT,L.did,0);
		self.state								:= l.st;
		self.county								:= l.county;
		self.RawAID								:= l.RAWAID;
		self.Company_RawAID				:= l.RAWAID;
		SELF											:= L;
	END;

	UCC_Contacts := PROJECT(UCCV2.File_UCC_Party_Base_AID(lname <> ''), Translate_UCC_to_BCF(LEFT));

	UCC_Contacts_Filtered	:=	UCC_Contacts(company_name<>'', 
											 lname<>'',fname<>'',
											 (prim_range <> '' or prim_name <> ''),
											 (INTEGER)name_score < 3, 
											 Business_Header.CheckPersonName(fname, mname, lname, name_suffix)
											);

	return UCC_Contacts_Filtered;

  end;
