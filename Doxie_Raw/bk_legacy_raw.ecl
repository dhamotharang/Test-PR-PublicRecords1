import bankrupt,bankruptcyv2_services,doxie,doxie_cbrs;

//Use BKV2 data to fill the legacy layout for BKV1 source docs
export bk_legacy_raw(
    dataset(Doxie.layout_references) dids = doxie_raw.ds_EmptyDIDs,
    dataset(Doxie.Layout_ref_bdid) bdids = doxie_raw.ds_EmptyBDIDs,
		dataset(bankruptcyv2_services.layout_tmsid_ext) tmsids = dataset([],bankruptcyv2_services.layout_tmsid_ext),
    unsigned3 dateVal = 0,
    string6 ssn_mask_value = 'NONE',
		string1 in_party_type = ''
) := FUNCTION

//***** GATHER TMSIDS BY INPUTS
d := bankruptcyv2_services.bankruptcy_raw().report_view(
	in_dids := dids,
	in_bdids := project(bdids,doxie_cbrs.layout_references),
	in_tmsids := tmsids,
	in_ssn_mask := ssn_mask_value,
	in_party_type := in_party_type);

bankrupt.layout_bk_search_name debtorName_xt(bankruptcyv2_services.layouts.layout_name l) := TRANSFORM
	SELF.debtor_title := '';
	SELF.debtor_fname := l.fname;
	SELF.debtor_mname := l.mname;
	SELF.debtor_lname := l.lname;
	SELF.debtor_name_suffix := l.name_suffix;
	SELF.debtor_company := l.cname;
END;

bankrupt.layout_bk_search_addr debtorAddr_xt(bankruptcyv2_services.layouts.layout_address l) := TRANSFORM
	SELF := l;
	self.suffix := l.addr_suffix;
	self.z5:=l.zip;
	SELF := [];
END;

doxie.layout_bk_child_ext debtor_xt(bankruptcyv2_services.layouts.layout_party l) := TRANSFORM
	SELF.debtor_type := l.debtor_type_1;
	SELF.debtor_ssn := l.ssn;
	SELF.debtor_DID := l.did;
	SELF.bdid := l.bdid;
	SELF.names := project(l.names, debtorName_xt(LEFT));
	SELF.addresses := project(l.addresses, debtorAddr_xt(LEFT));
	SELF := [];
END;

string SetName (BankruptcyV2_Services.layouts.layout_name name) := StringLib.StringCleanSpaces (
  name.fname + ' ' + name.mname + ' ' + name.lname + ' ' + name.name_suffix);

string SetAddressLine1 (BankruptcyV2_Services.layouts.layout_address addr) := StringLib.StringCleanSpaces (
  addr.prim_range + ' ' + addr.predir + ' ' + addr.prim_name + ' ' + 
  addr.addr_suffix + ' ' + addr.postdir + ' ' + addr.unit_desig + ' ' + addr.sec_range);

doxie.Layout_BK_output_ext legacy_xt(d l) := TRANSFORM
	// first take attorney and trustee datasets and populate flat fields in the legacy layout
	atty1 := l.attorneys[1];
	SELF.attorney_name := SetName (atty1.names[1]);
	SELF.attorney_phone := atty1.phones[1].phone;
	SELF.attorney_company := atty1.names[1].cname;

	SELF.attorney_address1 := SetAddressLine1 (atty1.addresses[1]);
	SELF.attorney_address2 := '';  // no equivalent in the V2
	SELF.attorney_city := atty1.addresses[1].v_city_name;
	SELF.attorney_st := atty1.addresses[1].st;
	SELF.attorney_zip := atty1.addresses[1].zip;
	SELF.attorney_zip4 := atty1.addresses[1].zip4;
	SELF.attorney_prim_range := atty1.addresses[1].prim_range;
	SELF.attorney_predir := atty1.addresses[1].predir;
	SELF.attorney_prim_name := atty1.addresses[1].prim_name;
	SELF.attorney_addr_suffix := atty1.addresses[1].addr_suffix;
	SELF.attorney_postdir := atty1.addresses[1].postdir;
	SELF.attorney_unit_desig := atty1.addresses[1].unit_desig;
	SELF.attorney_sec_range := atty1.addresses[1].sec_range;
	
	atty2 := l.attorneys[2];
	SELF.attorney2_name := SetName (atty2.names[1]);
	SELF.attorney2_phone := atty2.phones[1].phone;
	SELF.attorney2_company := atty2.names[1].cname;
	SELF.attorney2_address1 := SetAddressLine1 (atty2.addresses[1]);
	SELF.attorney2_address2 := '';  // no equivalent in the V2
	SELF.attorney2_city := atty2.addresses[1].v_city_name;
	SELF.attorney2_st := atty2.addresses[1].st;
	SELF.attorney2_zip := atty2.addresses[1].zip;
	SELF.attorney2_zip4 := atty2.addresses[1].zip4;
	SELF.attorney2_prim_range := atty2.addresses[1].prim_range;
	SELF.attorney2_predir := atty2.addresses[1].predir;
	SELF.attorney2_prim_name := atty2.addresses[1].prim_name;
	SELF.attorney2_addr_suffix := atty2.addresses[1].addr_suffix;
	SELF.attorney2_postdir := atty2.addresses[1].postdir;
	SELF.attorney2_unit_desig := atty2.addresses[1].unit_desig;	
	SELF.attorney2_sec_range := atty2.addresses[1].sec_range;
		
	trst1 := l.trustees[1];
	SELF.trustee_name := SetName (trst1.names[1]);
	SELF.trustee_phone := trst1.phones[1].phone;
	SELF.trustee_company := trst1.names[1].cname;
	SELF.trustee_address1 := SetAddressLine1 (trst1.addresses[1]);
	SELF.trustee_address2 := '';  // no equivalent in the V2
	SELF.trustee_city := trst1.addresses[1].v_city_name;
	SELF.trustee_st := trst1.addresses[1].st;
	SELF.trustee_zip := trst1.addresses[1].zip;
	SELF.trustee_zip4 := trst1.addresses[1].zip4;
	SELF.trustee_prim_range := trst1.addresses[1].prim_range;
	SELF.trustee_predir := trst1.addresses[1].predir;
	SELF.trustee_prim_name := trst1.addresses[1].prim_name;
	SELF.trustee_addr_suffix := trst1.addresses[1].addr_suffix;
	SELF.trustee_postdir := trst1.addresses[1].postdir;
	SELF.trustee_unit_desig := trst1.addresses[1].unit_desig;
	SELF.trustee_sec_range := trst1.addresses[1].sec_range;
		
	SELF.debtor_records := project(l.debtors, debtor_xt(LEFT));
	
	SELF := l;
	SELF := [];
END;

legacy_res := project(d, legacy_xt(LEFT));

return legacy_res(dateVal = 0 OR (unsigned3)(date_filed[1..6]) <= dateVal);

END;