Import Data_Services, business_header_ss,ut,header_services, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
f_br_1 := PRTE2_Business_Header.Files().Base.Business_Relatives.built;
#ELSE
f_br_1 := Files().Base.Business_Relatives.built;
#END;

Drop_Header_Layout := 
	Record
		string15 bdid1;
		string15 bdid2;
		string1 corp_charter_number;
		string1 business_registration;
		string1 bankruptcy_filing;
		string1 duns_number;
		string1 duns_tree;
		string1 edgar_cik;
		string1 name;
		string1 name_address;
		string1 name_phone;
		string1 gong_group;
		string1 ucc_filing;
		string1 fbn_filing;
		string1 fein;
		string1 phone;
		string1 addr;
		string1 mail_addr;
		string1 dca_company_number;
		string1 dca_hierarchy;
		string1 abi_number;
		string1 abi_hierarchy;
		string1 lien_properties;
		string1 liens_v2;
		string1 rel_group;
		string2 EOR;
	end; 

header_services.Supplemental_Data.mac_verify('file_businessrelatives_inj.txt', Drop_Header_Layout, attr);

Base_File_Append_In := attr();

business_header.Layout_Business_Relative reformat_header(Base_File_Append_In L) :=
 transform
	self.bdid1 := (unsigned6)L.bdid1;
	self.bdid2 := (unsigned6) L.bdid2;
	self.corp_charter_number := (boolean)((unsigned)L.corp_charter_number);
	self.business_registration := (boolean)((unsigned)L.business_registration);
	self.bankruptcy_filing := (boolean)((unsigned)L.bankruptcy_filing);
	self.duns_number := (boolean)((unsigned)L.duns_number);
	self.duns_tree := (boolean)((unsigned)L.duns_tree);
	self.edgar_cik := (boolean)((unsigned)L.edgar_cik);
	self.name := (boolean)((unsigned)L.name);
	self.name_address := (boolean)((unsigned)L.name_address);
	self.name_phone := (boolean)((unsigned)L.name_phone);
	self.gong_group := (boolean)((unsigned)L.gong_group);
	self.ucc_filing := (boolean)((unsigned)L.ucc_filing);
	self.fbn_filing := (boolean)((unsigned)L.fbn_filing);
	self.fein := (boolean)((unsigned)L.fein);
	self.phone := (boolean)((unsigned)L.phone);
	self.addr := (boolean)((unsigned)L.addr);
	self.mail_addr := (boolean)((unsigned)L.mail_addr);
	self.dca_company_number := (boolean)((unsigned)L.dca_company_number);
	self.dca_hierarchy := (boolean)((unsigned)L.dca_hierarchy);
	self.abi_number := (boolean)((unsigned)L.abi_number);
	self.abi_hierarchy := (boolean)((unsigned)L.abi_hierarchy);
	self.lien_properties := (boolean)((unsigned)L.lien_properties);
	self.liens_v2 := (boolean)((unsigned)L.liens_v2);
	self.rel_group := (boolean)((unsigned)L.rel_group);
 end;

Relatives_Base_File_Append1 := project(Base_File_Append_In, reformat_header(left));

	business_header.Layout_Business_Relative add_reverse(business_header.Layout_Business_Relative L) := transform
	self.bdid1 := (unsigned6)L.bdid2;
	self.bdid2 := (unsigned6)L.bdid1;  
	self := L;
end;

Base_File_Append2 := project(relatives_Base_File_Append1, add_reverse(left)) + Relatives_Base_File_Append1; 

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
f_br := f_br_1;
#ELSE
f_br := f_br_1 + Base_File_Append2;
#END;

EXPORT Key_Business_Relatives := INDEX(f_br,
	{f_br.bdid1}, {f_br}, 
	'~thor_data400::key::business_header.BusinessRelatives_' + business_header_ss.key_version);