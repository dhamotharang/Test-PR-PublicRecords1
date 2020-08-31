EXPORT Regulatory := MODULE

	//
	//  businessGrouping
	//
	EXPORT Drop_Header_Grouping_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
		record
			string15 group_id;
			string15 bdid;
			string2 new_line; 
	end;

	EXPORT Layout_BH_Super_Group := record
		unsigned6 group_id;
		unsigned6 bdid;
	end;

	//add supplemental data
	EXPORT applyBusinessGroupingInj(base_ds) := FUNCTIONMACRO
		import Business_Header, Suppress;

		local Base_File_Append_In := suppress.applyregulatory.getFile('file_businessgrouping_inj.txt', Business_Header.Regulatory.Drop_Header_Grouping_Layout);

		recordof(base_ds) reformat_header(Business_Header.Regulatory.Drop_Header_Grouping_Layout L) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
			 transform
				self.group_id := (unsigned6)l.group_id;
				self.bdid := (unsigned6)l.bdid;
				self := L;
				self := [];
		end;
 
		local Base_File_Append := project(Base_File_Append_In, reformat_header(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
		
		return base_ds + Base_File_Append;
		
	ENDMACRO;

	
	//
	//  businessRelatives
	//
	
	EXPORT Drop_Header_Relatives_Layout := 
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
	
	export Layout_Business_Relative := record
		unsigned6 bdid1;
		unsigned6 bdid2;
		boolean corp_charter_number := false;
		boolean business_registration := false;
		boolean bankruptcy_filing := false;
		boolean duns_number := false;
		boolean duns_tree := false;  // might point to a group
		boolean edgar_cik := false;
		boolean name := false;  // might point to a group
		boolean name_address := false;
		boolean name_phone := false;
		boolean gong_group := false;
		boolean ucc_filing := false;
		boolean fbn_filing := false;
		boolean fein := false;
		boolean phone := false;
		boolean addr := false;
		boolean mail_addr := false;
		boolean dca_company_number := false;  // Directory of Corporate Affilications Company Number (Root and Sub)
		boolean dca_hierarchy := false;
		boolean abi_number := false;     // InfoUSA - American Business ID Company Number
		boolean abi_hierarchy := false;
		boolean lien_properties := false;
		boolean liens_v2 := false;
		//boolean shared_contacts := false;
		boolean rel_group := false;
	end;
	
	EXPORT applyBusinessRelativesInj(base_ds) := FUNCTIONMACRO
		import Business_Header, Suppress;

		local Base_File_Append_In := suppress.applyregulatory.getFile('file_businessrelatives_inj.txt', Business_Header.Regulatory.Drop_Header_Relatives_Layout);

		recordof(base_ds) reformat_header(Business_Header.Regulatory.Drop_Header_Relatives_Layout L) :=
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
				self := L;
				self := [];
		end;

		local Relatives_Base_File_Append1 := project(Base_File_Append_In, reformat_header(left));

		recordof(base_ds) add_reverse(recordof(base_ds) L) := transform
			self.bdid1 := (unsigned6)L.bdid2;
			self.bdid2 := (unsigned6)L.bdid1;  
			self := L;
			self := [];
		end;

		local Base_File_Append_Relatives := project(relatives_Base_File_Append1, add_reverse(left)) + Relatives_Base_File_Append1; 
		
		return base_ds + Base_File_Append_Relatives;
		
	ENDMACRO;

	//
	// Business Header Best
	// 

	EXPORT Drop_Header_BH_Best_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
		Record
			string15 	bdid;	         
			string10 	dt_last_seen;
			string120 company_name;
			string10 	prim_range;
			string2   predir;
			string28 	prim_name;
			string4  	addr_suffix;
			string2   postdir;
			string5  	unit_desig;
			string8  	sec_range;
			string25 	city;
			string2   state;
			string8 	zip;
			string5 	zip4;
			string15 	phone;
			string10 	fein;       
			string3 	best_flags;
			string2   source;	 
			string2   DPPA_State;
			string2 	eor;
	END;

	EXPORT applyBusinessBestInj(base_ds) := FUNCTIONMACRO
		import Business_Header, Suppress;

		local Base_File_Append_In := suppress.applyregulatory.getFile('file_business_best_inj.txt', Business_Header.Regulatory.Drop_Header_BH_Best_Layout);

		recordof(base_ds) reformat_header(Business_Header.Regulatory.Drop_Header_BH_Best_Layout L) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
			 transform
				self.bdid := (unsigned6) L.bdid;
				self.dt_last_seen := (unsigned4) L.dt_last_seen;
				self.zip := (unsigned3) L.zip;
				self.zip4 := (unsigned2) L.zip4;
				self.phone := (unsigned6) L.phone;
				self.fein := (unsigned4) L.fein;
				self.best_flags := (unsigned3) L.best_flags;
				self := L;
				self := [];	
		end;
 
		local Base_File_Append := project(Base_File_Append_In, reformat_header(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
		
		return base_ds + Base_File_Append;
		
	ENDMACRO;


	//
	// Business Contact
	//
		EXPORT Drop_Header_Business_Contact_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
		Record
			string15 bdid := '0';  
			string15 did := '0';  
			string3 contact_score := '0';
			string34 vendor_id := ''; 
			string10 dt_first_seen;
			string10 dt_last_seen;
			string2 source;
			string1 record_type;
			string1 from_hdr := 'N';
			string1 glb := '0';
			string1 dppa := '0';
			string35 company_title;
			string35 company_department := '';
			string5 title;
			string20 fname;
			string20 mname;
			string20 lname;
			string5 name_suffix;
			string1 name_score;
			string10 prim_range;
			string2 predir;
			string28 prim_name;
			string4 addr_suffix;
			string2 postdir;
			string5 unit_desig;
			string8 sec_range;
			string25 city;
			string2 state;
			string8 zip;
			string5 zip4;
			string3 county;
			string4 msa;
			string10 geo_lat;
			string11 geo_long;
			string15 phone;
			string60 email_address;
			string10 ssn := '0';
			string34 company_source_group := '';
			string120 company_name;
			string10 company_prim_range;
			string2 company_predir;
			string28 company_prim_name := '';
			string4 company_addr_suffix := '';
			string2 company_postdir := '';
			string5 company_unit_desig := '';
			string8 company_sec_range := '';
			string25 company_city := '';
			string2 company_state := '';
			string8 company_zip := '';
			string5 company_zip4 := '';
			string15 company_phone := '';
			string10 company_fein := '0';
			string2 eor := '\r\n';
	end;


	EXPORT applyBusinessContactInj(base_ds) := FUNCTIONMACRO
		import Business_Header, Suppress, ut;

		local Base_File_Append_In := suppress.applyregulatory.getFile('file_business_contact_inj.txt', Business_Header.Regulatory.Drop_Header_Business_Contact_Layout);

		// Project Business Contacts File into Accurint format
		recordof(base_ds)  FormatOutput(Business_Header.Regulatory.Drop_Header_Business_Contact_Layout L) := TRANSFORM
			SELF.bdid := IF((unsigned6)L.bdid <> 0, (STRING12)INTFORMAT((unsigned6)L.bdid, 12, 1), '');
			SELF.did := IF((unsigned6)L.did <> 0, (STRING12)INTFORMAT((unsigned6)L.did, 12, 1), '');
			SELF.ssn := IF((unsigned4)L.ssn <> 0, (STRING9)INTFORMAT((unsigned4)L.ssn, 9, 1), '');
			SELF.dt_first_seen := IF((unsigned4)L.dt_first_seen <> 0, (STRING8)L.dt_first_seen, '');
			SELF.dt_last_seen := IF((unsigned4)L.dt_last_seen <> 0, (STRING8)L.dt_last_seen, '');
			SELF.company_zip := IF((unsigned3)L.company_zip <> 0, (STRING5)INTFORMAT((unsigned3)L.company_zip, 5, 1), '');
			SELF.company_zip4 := IF((unsigned2)L.company_zip4 <> 0, (STRING4)INTFORMAT((unsigned2)L.company_zip4, 4, 1), '');
			SELF.zip := IF((unsigned3)L.zip <> 0, (STRING5)INTFORMAT((unsigned3)L.zip, 5, 1), '');
			SELF.zip4 := IF((unsigned2)L.zip4 <> 0, (STRING4)INTFORMAT((unsigned2)L.zip4, 4, 1), '');
			SELF.phone := IF((unsigned6)L.phone <> 0, (STRING10)INTFORMAT((unsigned6)L.phone, 10, 1), '');
			SELF.company_title := IF(L.source='F' AND L.company_title='OWNER', 'CONTACT', 
									IF(L.company_title != '', L.company_title, L.company_department));
			self.name_suffix := if ( ut.is_unk(l.name_suffix),'',l.name_suffix);
			self.DPPA_State := if(L.dppa = '1', L.vendor_id[1..2], '');
			SELF := L;
			SELF := [];
		END;
		
		local Base_File_Append_Out := project(Base_File_Append_In, FormatOutput(left));

		return base_ds + Base_File_Append_Out;
		
	ENDMACRO;

	EXPORT applyBusinessContactInj_AtEnd(base_ds) := FUNCTIONMACRO
		import Business_Header, Suppress;

		local Base_File_Append_In := suppress.applyregulatory.getFile('file_business_contact_inj.txt', Business_Header.Regulatory.Drop_Header_Business_Contact_Layout);
		local max_file_pos := max(base_ds,__filepos) : global;
		
		recordof(base_ds) reformat_header(Business_Header.Regulatory.Drop_Header_Business_Contact_Layout L, INTEGER C) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
			 transform
				self.did := (unsigned6) L.did;
				self.bdid := (unsigned6) L.bdid;
				self.dt_first_seen := (unsigned4) L.dt_first_seen;
				self.dt_last_seen := (unsigned4) L.dt_last_seen;
				self.contact_score := (unsigned1) L.contact_score;
				self.glb := (boolean) if(l.glb = '1', true, false);
				self.dppa := (boolean) if(l.dppa = '1', true,  false);
				self.zip := (unsigned3) L.zip;
				self.zip4 := (unsigned2) L.zip4;
				self.phone := (unsigned6) L.phone;
				self.ssn := (unsigned4) L.ssn;
				self.company_zip := (unsigned3) L.company_zip;
				self.company_zip4 := (unsigned2) L.company_zip4;
				self.company_phone := (unsigned6) L.company_phone;
				self.company_fein := (unsigned4) L.company_fein;				
				self.__filepos := max_file_pos + C;				
				self := L;
				self := [];	
		end;
 
		local Base_File_Append := project(Base_File_Append_In, reformat_header(left, counter)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

		return base_ds + Base_File_Append;
		
	ENDMACRO;

	EXPORT applyDidAddressBusiness_sup(base_ds) := FUNCTIONMACRO
		import Business_Header, Suppress;

		local DidAddressBusinessHash (recordof(base_ds) L) :=  hashmd5(
															l.bdid,(string)l.state,(string)l.zip,(string)l.city,
															(string)l.prim_name,(string)l.prim_range,(string)l.predir,
															(string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
						
		local ds1 := Suppress.applyRegulatory.simple_sup(base_ds, 'didaddressbusiness_sup.txt', DidAddressBusinessHash);
		return (ds1);

	ENDMACRO;

 	EXPORT applyDidAddressBusiness_sup2(base_ds) := FUNCTIONMACRO
		import Business_Header, Suppress;
		local DidAddressBusinessHash2 (recordof(base_ds) L) :=  hashmd5(
																intformat((unsigned6)l.bdid,12,1),(string)l.state,(string)l.zip,(string)l.city,
																(string)l.prim_name,(string)l.prim_range,(string)l.predir,
																(string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
							
		local ds1 := Suppress.applyRegulatory.simple_sup(base_ds, 'didaddressbusiness_sup.txt', DidAddressBusinessHash2);
		return (ds1);

	ENDMACRO;

	//
	// Business Header
	//
	EXPORT Drop_Header_Business_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
	Record
		string15 rcid;
		string15 bdid; 
		string2 source; 
		string34 source_group; 
		string3 pflag; 
		string15 group1_id; 
		string34 vendor_id; 
		string10 dt_first_seen; 
		string10 dt_last_seen; 
		string10 dt_vendor_first_reported;
		string10 dt_vendor_last_reported;
		string120 company_name;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string5 unit_desig;
		string8 sec_range;
		string25 city;
		string2 state;
		string8 zip;
		string5 zip4;
		string3 county;
		string4 msa;
		string10 geo_lat;
		string11 geo_long;
		string15 phone;
		string5 phone_score; 
		string10 fein; 
		string1 current; 
		string1 dppa; 
		string81 match_company_name;
		string20 match_branch_unit;
		string25 match_geo_city := '';
		string2 eor := '';
 end;

	EXPORT applyBusinessHeaderInj(base_ds) := FUNCTIONMACRO
		import Business_Header, Suppress, ut;

		local Base_File_Append_In := suppress.applyregulatory.getFile('file_business_header_inj.txt', Business_Header.Regulatory.Drop_Header_Business_Header_Layout);

		recordof(base_ds) FormatOutput(Business_Header.Regulatory.Drop_Header_Business_Header_Layout L, integer c) := TRANSFORM
			self.rcid := (unsigned6) L.rcid;
			self.bdid := (unsigned6) L.bdid;
			self.group1_id := (unsigned6) L.group1_id;
			self.dt_first_seen := (unsigned4) L.dt_first_seen;
			self.dt_last_seen := (unsigned4) L.dt_last_seen;
			self.dt_vendor_first_reported := (unsigned4) L.dt_vendor_first_reported;
			self.dt_vendor_last_reported := (unsigned4) L.dt_vendor_last_reported;	
			self.zip := (unsigned3) L.zip;
			self.zip4 := (unsigned2) L.zip4;
			self.phone := (unsigned6) L.phone;
			self.phone_score := (unsigned2) L.phone_score;
			self.fein := (unsigned4) L.fein;
			self.current := (boolean) L.current;
			self.dppa := (boolean) L.dppa;
			self := L;
			SELF := [];
		end;

		
		local Base_File_Append_Out := project(Base_File_Append_In, FormatOutput(left, counter));

		return base_ds + Base_File_Append_Out;
		
	ENDMACRO;

	EXPORT applyBusinessHeaderInj_AtEnd(base_ds) := FUNCTIONMACRO
		import Business_Header, Suppress, ut;

		local Base_File_Append_In := suppress.applyregulatory.getFile('file_business_header_inj.txt', Business_Header.Regulatory.Drop_Header_Business_Header_Layout);

		max_file_pos := max(Business_Header.files(,Business_Header._Dataset().IsDataland).base.business_headers.keybuild,__filepos) : global;

		recordof(base_ds) FormatOutput(Business_Header.Regulatory.Drop_Header_Business_Header_Layout L, integer c) := TRANSFORM
			self.rcid := (unsigned6) L.rcid;
			self.bdid := (unsigned6) L.bdid;
			self.group1_id := (unsigned6) L.group1_id;
			self.dt_first_seen := (unsigned4) L.dt_first_seen;
			self.dt_last_seen := (unsigned4) L.dt_last_seen;
			self.dt_vendor_first_reported := (unsigned4) L.dt_vendor_first_reported;
			self.dt_vendor_last_reported := (unsigned4) L.dt_vendor_last_reported;	
			self.zip := (unsigned3) L.zip;
			self.zip4 := (unsigned2) L.zip4;
			self.phone := (unsigned6) L.phone;
			self.phone_score := (unsigned2) L.phone_score;
			self.fein := (unsigned4) L.fein;
			self.current := (boolean) L.current;
			self.dppa := (boolean) L.dppa;
			self.__filepos := max_file_pos + c;
			self := L;
			SELF := [];
		end;

		
		local Base_File_Append_Out := project(Base_File_Append_In, FormatOutput(left, counter));

		return base_ds + Base_File_Append_Out;
		
	ENDMACRO;

END;