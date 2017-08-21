import ut, Business_Header,mdr;

export fYellowPages_as_Business_Contact(dataset(Layout_YellowPages_Base_V2_Bip) pYellowPages)
 :=
  function
  
	YellowPages_Init := pYellowPages(MDR.sourceTools.sourceisYellow_Pages(source));

	Business_Header.Layout_Business_Contact_Full_New Translate_YellowPages_to_BCF(Layout_YellowPages_Base_V2_Bip L, INTEGER C) := TRANSFORM
	SELF.company_title := L.executive_title;
	SELF.title := CHOOSE(C, L.exec_title, L.title);
	SELF.fname := CHOOSE(C, L.exec_fname, L.fname);
	SELF.mname := CHOOSE(C, L.exec_mname, L.mname);
	SELF.lname := CHOOSE(C, L.exec_lname, L.lname);
	SELF.name_suffix := CHOOSE(C, L.exec_name_suffix, L.name_suffix);
	SELF.name_score := CHOOSE(C, Business_Header.CleanName(L.exec_fname,L.exec_mname,L.exec_lname,L.exec_name_suffix)[142],
								 Business_Header.CleanName(L.fname,L.mname,L.lname,L.name_suffix)[142]);
	SELF.addr_suffix := L.suffix;
	SELF.city := L.p_city_name;
	SELF.state := L.st;
	SELF.zip := (UNSIGNED3)L.zip;
	SELF.zip4 := (UNSIGNED2)L.zip4;
	SELF.company_name := L.business_name;
	SELF.vl_id := (STRING34)L.primary_key;
	SELF.vendor_id := (QSTRING34)((STRING34)L.primary_key);
	SELF.phone := (UNSIGNED6)((UNSIGNED8)L.phone10);
	SELF.company_prim_range := L.prim_range;
	SELF.company_predir := L.predir;
	SELF.company_prim_name := L.prim_name;
	SELF.company_addr_suffix := L.suffix;
	SELF.company_postdir := L.postdir;
	SELF.company_unit_desig := L.unit_desig;
	SELF.company_sec_range := L.sec_range;
	SELF.company_city := L.p_city_name;
	SELF.company_state := L.st;
	SELF.company_zip := (UNSIGNED3)L.zip;
	SELF.company_zip4 := (UNSIGNED2)L.zip4;
	SELF.company_phone := (UNSIGNED6)((UNSIGNED8)L.phone10);
	SELF.source := MDR.sourceTools.src_Yellow_Pages;
	SELF.record_type := 'C';     // 'C' = Current, 'H' = Historical
	SELF.dt_first_seen := (UNSIGNED4)(L.pub_date);
	SELF.dt_last_seen := (UNSIGNED4)(L.pub_date);
	SELF := L;
	END;

	dYellowPages_Contacts_Norm := NORMALIZE(YellowPages_Init, 2, Translate_YellowPages_to_BCF(LEFT, COUNTER));
	
	dYellowPages_As_Business_Contact	:= dYellowPages_Contacts_Norm((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix));

	return dYellowPages_As_Business_Contact;
  end
 ;