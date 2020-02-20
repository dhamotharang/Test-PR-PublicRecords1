IMPORT ingenix_natlprof;

EXPORT As_Ingenix (STRING filedate, boolean pUseProd = false) := MODULE

		SHARED InSanc  := Enclarity.Files(,pUseProd).sanction_base.qa;
		SHARED InSanTp := Enclarity.Files(,pUseProd).sanc_prov_type_base.qa;
		SHARED InSanCd := Enclarity.Files(,pUseProd).sanc_codes_base.qa;
		SHARED InIndi  := Enclarity.Files(,pUseProd).individual_base.qa;
		SHARED InAsso  := Enclarity.Files(,pUseProd).associate_base.qa;
		SHARED InFac   := Enclarity.Files(,pUseProd).facility_base.qa;
		SHARED InLic   := Enclarity.Files(,pUseProd).license_base.qa;
		SHARED InNpi   := Enclarity.Files(,pUseProd).npi_base.qa;
		SHARED InDea   := Enclarity.Files(,pUseProd).dea_base.qa;
		SHARED InDeaCd := Enclarity.Files(,pUseProd).dea_bacodes_base.qa;
		SHARED InAddr  := Enclarity.Files(,pUseProd).address_base.qa;
		SHARED InTxo   := Enclarity.Files(,pUseProd).taxonomy_base.qa;
		SHARED InTxoCd := Enclarity.Files(,pUseProd).tax_codes_base.qa;
		SHARED InMSch  := Enclarity.Files(,pUseProd).medschool_base.qa;
		SHARED InSpec  := Enclarity.Files(,pUseProd).specialty_base.qa;
		SHARED InProBd := Enclarity.Files(,pUseProd).prov_birthdate_base.qa;
		SHARED InProSn := Enclarity.Files(,pUseProd).prov_ssn_base.qa;

		SHARED dsSancLookup_ := LookupTables.dsSancLookup;
		SHARED decodeSancInfo(string code) := Function
			checkCode := stringlib.StringToUpperCase(code);
			return dsSancLookup_(Code=checkCode)[1];
		End;

		SHARED dsBoardInfo_ := LookupTables.dsBoardInfo;
		SHARED decodeBoardInfo(string st,string typ) := Function
			checkSt := stringlib.StringToUpperCase(st);
			checkTp := stringlib.StringToUpperCase(typ);
			return dsBoardInfo_(State=checkSt,ProviderType=checkTp)[1];
		End;

		SHARED
			fn_scale_gk(string38 gk) := function
				unsigned6 max_pid := 281474976710655;  //max unsigne6
				new_gk
					:=
						(string)
							((unsigned8)( hash64(hashmd5(gk)) ) % max_pid)
						;
				return new_gk;
			end;

		//////////////////////////////////////////////////////////
		// Sanctions_All
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key
									,string20 addr_key
									,Ingenix_NatlProf.Sanctioned_providers_Bdid};

		OutLayout tr1(InSanc l) := transform
			self.date_first_seen	:=	(string)l.dt_first_seen;
			self.date_last_seen	:=	(string)l.dt_last_seen;
			self.date_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.date_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.process_date	:=	(string)l.dt_vendor_last_reported;

			self.SANC_ID:=(string)(string)l.pid;

			decodes:=decodeSancInfo(l.sanc1_code);

			//If it is a reinstatement, then the sanction data is really a reinstate date
			cleanCode := trim(l.sanc1_code,left,right);
			lastCharacter := cleanCode[length(cleanCode)];
			isReinstatement := if(lastCharacter='R',true,false);
			self.SANC_SANCDTE := if(isReinstatement,'',l.sanc1_date);
			self.SANC_REINDTE := if(isReinstatement,l.sanc1_date,'');

			self.SANC_SANCST	:=	l.sanc1_state	;
			self.SANC_LICNBR	:=	if(length(stringlib.stringfilterout(trim(l.sanc1_lic_num,all),'0'))<>0,l.sanc1_lic_num,'')	;

			self.SANC_COND := decodes.Cat;
			self.SANC_REAS := decodes.desc;
			self.SANC_TYPE := decodes.LegacyType;
			self.SANC_FAB := if(decodes.Cat='FRAUD/ABUSE','TRUE','FALSE');
			self.SANC_UNAMB_IND := decodes.LossOfLicense;

			self.SANC_PROVTYPE	:=	l.sanc1_prof_type	;

			self.sanc_brdtype	:=	l.sanc1_code	; //temp hold field
			self:=l;
			self:=[];
		end;

		prep1:=project(InSanc,tr1(left));

		prep2:=join(prep1,InSanTp
							,left.SANC_PROVTYPE=right.prov_type_code
							,left outer
							,lookup);

		prep3:=join(prep2,InSanCd
							,left.sanc_brdtype=right.sanc_code  // note: overloaded sanc_brdtype for temp use above
							,left outer
							,lookup);

		prep4:=project(prep3
							,transform(OutLayout
									,self.SANC_PROVTYPE:=left.prov_type_desc
									// could put together from provider type, state and type of sanction
									,self.SANC_SRC_DESC := decodeBoardInfo(left.sanc_sancst,left.prov_type_desc).RegulatingBoard
									,self.SANC_BRDTYPE := ''
									,self:=left
									));

		prep5:=join(prep4,InProSn(clean_ssn<>'')
							,left.group_key=right.group_key
							,transform(OutLayout
									,self.sanc_tin:=if(left.group_key=right.group_key,right.clean_ssn,'')
									,self:=left
									)
							,left outer
							,lookup);

		OutLayout tr2(prep5 l, InIndi r) := transform
			self.date_first_seen	:=	if(l.group_key=r.group_key,(string)r.dt_first_seen,l.date_first_seen);
			self.date_last_seen	:=	if(l.group_key=r.group_key,(string)r.dt_last_seen,l.date_last_seen);
			self.date_first_reported	:=	if(l.group_key=r.group_key,(string)r.dt_vendor_first_reported,l.date_first_reported);
			self.date_last_reported	:=	if(l.group_key=r.group_key,(string)r.dt_vendor_last_reported,l.date_last_reported);
			self.process_date	:=	if(l.group_key=r.group_key,(string)r.dt_vendor_last_reported,l.process_date);
			self.SANC_ID:=if(l.group_key=r.group_key,(string)r.pid,l.sanc_id);

			self.SANC_STREET:=if(l.group_key=r.group_key
														,trim(stringlib.stringcleanspaces(
																					trim(r.prim_range)
																			+' '+trim(r.predir)
																			+' '+trim(r.prim_name)
																			+' '+trim(r.addr_suffix)
																			+' '+trim(r.postdir)
																			+' '+trim(r.unit_desig)
																			+' '+trim(r.sec_range)
																			))
														,l.sanc_street
														);

			self.SANC_CITY  :=	if(l.group_key=r.group_key,r.v_city_name,l.sanc_city)	;
			self.SANC_STATE	:=	if(l.group_key=r.group_key,r.st,l.sanc_state)	;
			self.SANC_ZIP 	:=	if(l.group_key=r.group_key,r.zip,l.sanc_zip)	;

			self.did:=intformat(if(l.group_key=r.group_key,(unsigned)r.did,(unsigned)l.did),12,1);
			self.sanc_lnme:=if(l.group_key=r.group_key,r.last_name,l.sanc_lnme);
			self.sanc_fnme:=if(l.group_key=r.group_key,r.first_name,l.sanc_fnme);
			self.sanc_mid_i_nm:=if(l.group_key=r.group_key,r.middle_name,l.sanc_mid_i_nm);
			self.sanc_dob:=if(l.group_key=r.group_key,r.clean_dob,l.sanc_dob);
			self.sanc_tin:=if(l.group_key=r.group_key,r.clean_ssn,l.sanc_tin);
			self.sanc_upin:=if(l.group_key=r.group_key,r.upin,l.sanc_upin);
			self.prov_clean_title:=if(l.group_key=r.group_key,r.title,l.prov_clean_title);
			self.prov_clean_fname:=if(l.group_key=r.group_key,r.fname,l.prov_clean_fname);
			self.prov_clean_mname:=if(l.group_key=r.group_key,r.mname,l.prov_clean_mname);
			self.prov_clean_lname:=if(l.group_key=r.group_key,r.lname,l.prov_clean_lname);
			self.prov_clean_name_suffix:=if(l.group_key=r.group_key,r.name_suffix,l.prov_clean_name_suffix);
			self.provco_address_clean_prim_range:=if(l.group_key=r.group_key,r.prim_range,l.provco_address_clean_prim_range);
			self.provco_address_clean_predir:=if(l.group_key=r.group_key,r.predir,l.provco_address_clean_predir);
			self.provco_address_clean_prim_name:=if(l.group_key=r.group_key,r.prim_name,l.provco_address_clean_prim_name);
			self.provco_address_clean_addr_suffix:=if(l.group_key=r.group_key,r.addr_suffix,l.provco_address_clean_addr_suffix);
			self.provco_address_clean_postdir:=if(l.group_key=r.group_key,r.postdir,l.provco_address_clean_postdir);
			self.provco_address_clean_unit_desig:=if(l.group_key=r.group_key,r.unit_desig,l.provco_address_clean_unit_desig);
			self.provco_address_clean_sec_range:=if(l.group_key=r.group_key,r.sec_range,l.provco_address_clean_sec_range);
			self.provco_address_clean_p_city_name:=if(l.group_key=r.group_key,r.p_city_name,l.provco_address_clean_p_city_name);
			self.provco_address_clean_v_city_name:=if(l.group_key=r.group_key,r.v_city_name,l.provco_address_clean_v_city_name);
			self.provco_address_clean_st:=if(l.group_key=r.group_key,r.st,l.provco_address_clean_st);
			self.provco_address_clean_zip:=if(l.group_key=r.group_key,r.zip,l.provco_address_clean_zip);
			self.provco_address_clean_zip4:=if(l.group_key=r.group_key,r.zip4,l.provco_address_clean_zip4);
			self.provco_address_clean_cart:=if(l.group_key=r.group_key,r.cart,l.provco_address_clean_cart);
			self.provco_address_clean_cr_sort_sz:=if(l.group_key=r.group_key,r.cr_sort_sz,l.provco_address_clean_cr_sort_sz);
			self.provco_address_clean_lot:=if(l.group_key=r.group_key,r.lot,l.provco_address_clean_lot);
			self.provco_address_clean_lot_order:=if(l.group_key=r.group_key,r.lot_order,l.provco_address_clean_lot_order);
			self.provco_address_clean_dpbc:=if(l.group_key=r.group_key,r.dbpc,l.provco_address_clean_dpbc);
			self.provco_address_clean_chk_digit:=if(l.group_key=r.group_key,r.chk_digit,l.provco_address_clean_chk_digit);
			self.provco_address_clean_record_type:=if(l.group_key=r.group_key,r.rec_type,l.provco_address_clean_record_type);
			self.provco_address_clean_ace_fips_st:=if(l.group_key=r.group_key,r.fips_st,l.provco_address_clean_ace_fips_st);
			self.provco_address_clean_fipscounty:=if(l.group_key=r.group_key,r.fips_county,l.provco_address_clean_fipscounty);
			self.provco_address_clean_geo_lat:=if(l.group_key=r.group_key,r.geo_lat,l.provco_address_clean_geo_lat);
			self.provco_address_clean_geo_long:=if(l.group_key=r.group_key,r.geo_long,l.provco_address_clean_geo_long);
			self.provco_address_clean_msa:=if(l.group_key=r.group_key,r.msa,l.provco_address_clean_msa);
			self.provco_address_clean_geo_match:=if(l.group_key=r.group_key,r.geo_match,l.provco_address_clean_geo_match);
			self.provco_address_clean_err_stat:=if(l.group_key=r.group_key,r.err_stat,l.provco_address_clean_err_stat);
			self.source_rec_id:=if(l.group_key=r.group_key,r.source_rid,l.source_rec_id);

			self:=l;
			self:=[];
		end;

		prep6:=join(prep5, dedup(sort(InIndi,group_key,-dt_vendor_last_reported),group_key)
							,left.group_key=right.group_key
							,tr2(left,right)
							,left outer
							);

		OutLayout tr3(prep6 l, InAsso r) := transform
			self.date_first_seen	:=	if(l.group_key=r.group_key,(string)r.dt_first_seen,l.date_first_seen);
			self.date_last_seen	:=	if(l.group_key=r.group_key,(string)r.dt_last_seen,l.date_last_seen);
			self.date_first_reported	:=	if(l.group_key=r.group_key,(string)r.dt_vendor_first_reported,l.date_first_reported);
			self.date_last_reported	:=	if(l.group_key=r.group_key,(string)r.dt_vendor_last_reported,l.date_last_reported);
			self.process_date	:=	if(l.group_key=r.group_key,(string)r.dt_vendor_last_reported,l.process_date);
			self.SANC_ID:=if(l.group_key=r.group_key,(string)r.pid,l.sanc_id);

			self.SANC_STREET:=if(l.group_key=r.group_key
														,trim(stringlib.stringcleanspaces(
																					trim(r.prim_range)
																			+' '+trim(r.predir)
																			+' '+trim(r.prim_name)
																			+' '+trim(r.addr_suffix)
																			+' '+trim(r.postdir)
																			+' '+trim(r.unit_desig)
																			+' '+trim(r.sec_range)
																			))
														,l.sanc_street
														);

			self.SANC_CITY  :=	if(l.group_key=r.group_key,r.v_city_name,l.sanc_city)	;
			self.SANC_STATE	:=	if(l.group_key=r.group_key,r.st,l.sanc_state)	;
			self.SANC_ZIP 	:=	if(l.group_key=r.group_key,r.zip,l.sanc_zip)	;

			self.bdid:=if(l.group_key=r.group_key,r.bdid,l.bdid);
			self.bdid_score:=if(l.group_key=r.group_key,r.bdid_score,l.bdid_score);
			self.did:=intformat(if(l.group_key=r.group_key,(unsigned)r.did,(unsigned)l.did),12,1);
			self.SANC_BUSNME:=if(l.group_key=r.group_key,r.Prepped_name,l.sanc_busnme);
			self.SANC_TIN:=if(l.group_key=r.group_key,r.bill_tin,l.sanc_tin);
			self.prov_clean_title:=if(l.group_key=r.group_key,r.title,l.prov_clean_title);
			self.prov_clean_fname:=if(l.group_key=r.group_key,r.fname,l.prov_clean_fname);
			self.prov_clean_mname:=if(l.group_key=r.group_key,r.mname,l.prov_clean_mname);
			self.prov_clean_lname:=if(l.group_key=r.group_key,r.lname,l.prov_clean_lname);
			self.prov_clean_name_suffix:=if(l.group_key=r.group_key,r.name_suffix,l.prov_clean_name_suffix);
			self.provco_address_clean_prim_range:=if(l.group_key=r.group_key,r.prim_range,l.provco_address_clean_prim_range);
			self.provco_address_clean_predir:=if(l.group_key=r.group_key,r.predir,l.provco_address_clean_predir);
			self.provco_address_clean_prim_name:=if(l.group_key=r.group_key,r.prim_name,l.provco_address_clean_prim_name);
			self.provco_address_clean_addr_suffix:=if(l.group_key=r.group_key,r.addr_suffix,l.provco_address_clean_addr_suffix);
			self.provco_address_clean_postdir:=if(l.group_key=r.group_key,r.postdir,l.provco_address_clean_postdir);
			self.provco_address_clean_unit_desig:=if(l.group_key=r.group_key,r.unit_desig,l.provco_address_clean_unit_desig);
			self.provco_address_clean_sec_range:=if(l.group_key=r.group_key,r.sec_range,l.provco_address_clean_sec_range);
			self.provco_address_clean_p_city_name:=if(l.group_key=r.group_key,r.p_city_name,l.provco_address_clean_p_city_name);
			self.provco_address_clean_v_city_name:=if(l.group_key=r.group_key,r.v_city_name,l.provco_address_clean_v_city_name);
			self.provco_address_clean_st:=if(l.group_key=r.group_key,r.st,l.provco_address_clean_st);
			self.provco_address_clean_zip:=if(l.group_key=r.group_key,r.zip,l.provco_address_clean_zip);
			self.provco_address_clean_zip4:=if(l.group_key=r.group_key,r.zip4,l.provco_address_clean_zip4);
			self.provco_address_clean_cart:=if(l.group_key=r.group_key,r.cart,l.provco_address_clean_cart);
			self.provco_address_clean_cr_sort_sz:=if(l.group_key=r.group_key,r.cr_sort_sz,l.provco_address_clean_cr_sort_sz);
			self.provco_address_clean_lot:=if(l.group_key=r.group_key,r.lot,l.provco_address_clean_lot);
			self.provco_address_clean_lot_order:=if(l.group_key=r.group_key,r.lot_order,l.provco_address_clean_lot_order);
			self.provco_address_clean_dpbc:=if(l.group_key=r.group_key,r.dbpc,l.provco_address_clean_dpbc);
			self.provco_address_clean_chk_digit:=if(l.group_key=r.group_key,r.chk_digit,l.provco_address_clean_chk_digit);
			self.provco_address_clean_record_type:=if(l.group_key=r.group_key,r.rec_type,l.provco_address_clean_record_type);
			self.provco_address_clean_ace_fips_st:=if(l.group_key=r.group_key,r.fips_st,l.provco_address_clean_ace_fips_st);
			self.provco_address_clean_fipscounty:=if(l.group_key=r.group_key,r.fips_county,l.provco_address_clean_fipscounty);
			self.provco_address_clean_geo_lat:=if(l.group_key=r.group_key,r.geo_lat,l.provco_address_clean_geo_lat);
			self.provco_address_clean_geo_long:=if(l.group_key=r.group_key,r.geo_long,l.provco_address_clean_geo_long);
			self.provco_address_clean_msa:=if(l.group_key=r.group_key,r.msa,l.provco_address_clean_msa);
			self.provco_address_clean_geo_match:=if(l.group_key=r.group_key,r.geo_match,l.provco_address_clean_geo_match);
			self.provco_address_clean_err_stat:=if(l.group_key=r.group_key,r.err_stat,l.provco_address_clean_err_stat);
			self.source_rec_id:=if(l.group_key=r.group_key,r.source_rid,l.source_rec_id);

			self:=l;
			self:=[];
		end;

		prep7:=join(prep6, dedup(sort(InAsso,group_key,-dt_vendor_last_reported),group_key)
							,left.group_key=right.group_key
							,tr3(left,right)
							,left outer
							);

		OutLayout tr4(InFac l) := transform
			self.date_first_seen	:=	(string)l.dt_first_seen;
			self.date_last_seen	:=	(string)l.dt_last_seen;
			self.date_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.date_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.process_date	:=	(string)l.dt_vendor_last_reported;

			self.SANC_ID:=(string)(string)l.pid;
			self.SANC_BUSNME:=l.clean_company_name;

			decodes:=decodeSancInfo(l.sanc1_code);

			//If it is a reinstatement, then the sanction data is really a reinstate date
			cleanCode := trim(l.sanc1_code,left,right);
			lastCharacter := cleanCode[length(cleanCode)];
			isReinstatement := if(lastCharacter='R',true,false);
			self.SANC_SANCDTE := if(isReinstatement,'',l.sanc1_date);
			self.SANC_REINDTE := if(isReinstatement,l.sanc1_date,'');

			self.SANC_SANCST	:=	l.lic_state	;
			self.SANC_LICNBR	:=	if(length(stringlib.stringfilterout(trim(l.lic_num_in,all),'0'))<>0,l.lic_num_in,'')	;

			self.SANC_COND := decodes.Cat;
			self.SANC_REAS := decodes.desc;
			self.SANC_TYPE := decodes.LegacyType;
			self.SANC_FAB := if(decodes.Cat='FRAUD/ABUSE','TRUE','FALSE');
			self.SANC_UNAMB_IND := decodes.LossOfLicense;

			self.SANC_PROVTYPE	:=	l.type1	;

			self.sanc_brdtype	:=	l.sanc1_code	; //temp hold field

			self.provco_address_clean_prim_range:=l.prim_range;
			self.provco_address_clean_predir:=l.predir;
			self.provco_address_clean_prim_name:=l.prim_name;
			self.provco_address_clean_addr_suffix:=l.addr_suffix;
			self.provco_address_clean_postdir:=l.postdir;
			self.provco_address_clean_unit_desig:=l.unit_desig;
			self.provco_address_clean_sec_range:=l.sec_range;
			self.provco_address_clean_p_city_name:=l.p_city_name;
			self.provco_address_clean_v_city_name:=l.v_city_name;
			self.provco_address_clean_st:=l.st;
			self.provco_address_clean_zip:=l.zip;
			self.provco_address_clean_zip4:=l.zip4;
			self.provco_address_clean_cart:=l.cart;
			self.provco_address_clean_cr_sort_sz:=l.cr_sort_sz;
			self.provco_address_clean_lot:=l.lot;
			self.provco_address_clean_lot_order:=l.lot_order;
			self.provco_address_clean_dpbc:=l.dbpc;
			self.provco_address_clean_chk_digit:=l.chk_digit;
			self.provco_address_clean_record_type:=l.rec_type;
			self.provco_address_clean_ace_fips_st:=l.fips_st;
			self.provco_address_clean_fipscounty:=l.fips_county;
			self.provco_address_clean_geo_lat:=l.geo_lat;
			self.provco_address_clean_geo_long:=l.geo_long;
			self.provco_address_clean_msa:=l.msa;
			self.provco_address_clean_geo_match:=l.geo_match;
			self.provco_address_clean_err_stat:=l.err_stat;

			self:=l;
			self:=[];
		end;

		prep8:=project(InFac(sanc1_code<>''),tr4(left));

		prep9:=join(prep8,InSanTp
							,left.SANC_PROVTYPE=right.prov_type_code
							,left outer
							,lookup);

		prep10:=join(prep9,InSanCd
							,left.sanc_brdtype=right.sanc_code  // note: overloaded sanc_brdtype for temp use above
							,left outer
							,lookup);

		prep11:=project(prep10
							,transform(OutLayout
									,self.SANC_PROVTYPE:=left.prov_type_desc
									// could put together from provider type, state and type of sanction
									,self.SANC_SRC_DESC := decodeBoardInfo(left.sanc_sancst,left.prov_type_desc).RegulatingBoard
									,self.SANC_BRDTYPE := ''
									,self:=left
									));

		EXPORT Sanctions_All := dedup(prep7 + prep11,record,all) :persist('~thor400_data::persist::Sanctions_All');

		//////////////////////////////////////////////////////////
		// update_BWR_Sanctions_Did_File
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.update_BWR_Sanctions_Did_File};

		prep1 := project(Sanctions_All,outlayout);

		EXPORT update_BWR_Sanctions_Did_File := prep1;

		//////////////////////////////////////////////////////////
		// Sanctioned_providers_Bdid
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.Sanctioned_providers_Bdid};

		prep1 := project(Sanctions_All,outlayout);

		EXPORT Sanctioned_providers_Bdid := prep1;

		//////////////////////////////////////////////////////////
		// ProviderSanctions_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key
									,Ingenix_NatlProf.update_ProviderSanctions};

		OutLayout tr1(Sanctions_all l) := transform
			self.processdate:=l.process_date;
			self.dt_vendor_first_reported:=l.date_first_reported;
			self.dt_vendor_last_reported:=l.date_last_reported;
			self.providerid:=l.sanc_id;
			self.SanctionDate	:=	l.sanc_sancdte	;
			self.SanctioningState	:=	l.sanc_sancst	;
			self.SanctionedLicenseNumber	:=	l.sanc_licnbr	;
			self.SanctionReason:=l.SANC_reas ;
			self.SanctioningBoardType:=l.SANC_BRDTYPE ;
			self.LastUpdate	:=	l.SANC_UPDTE_form	;

			self:=l;
			self:=[];
		end;

		prep1:=project(Sanctions_all,tr1(left));

		prep2:=join(prep1,dedup(sort(InLic,group_key,lic_num_in,-dt_vendor_last_reported),group_key,lic_num_in)
							,left.group_key=right.group_key
							and left.SanctionedLicenseNumber=right.lic_num_in
							,transform(OutLayout
									,self.LossOfLicenseIndicator:=if(left.group_key=right.group_key and right.lic_status<>'A','Y','N')
									,self:=left
									)
							,left outer
							);

		EXPORT ProviderSanctions_all := prep2 : persist('~thor400_data::persist::ProviderSanctions_all');

		//////////////////////////////////////////////////////////
		// update_ProviderSanctions
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.update_ProviderSanctions};

		prep1 := project(ProviderSanctions_all,outlayout);

		EXPORT update_ProviderSanctions := prep1;

		//////////////////////////////////////////////////////////
		// Provider_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key
									,string20 addr_key
									,ingenix_natlprof.Provider_did
									,string10 p2
									,string10 p3
									,string10 f1
									,string10 f2
									,string10 f3
									};

		OutLayout tr1(InIndi l) := transform
			self.did	:=	intformat(l.did,12,1)	;
			self.did_score	:=	(string)l.did_score;
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;

			self.lastname	:=	l.last_name	;
			self.firstname	:=	l.first_name	;
			self.middlename	:=	l.middle_name	;
			self.suffix	:=	l.suffix_name	;
			self.gender	:=	l.gender	;

			self.prov_clean_title	:=	l.title	;
			self.prov_clean_fname	:=	l.fname	;
			self.prov_clean_mname	:=	l.mname	;
			self.prov_clean_lname	:=	l.lname	;
			self.prov_clean_name_suffix	:=	l.name_suffix	;

			self.addressid	:=	l.Addr_key	;

			self.Address:=trim(stringlib.stringcleanspaces(
																		trim(l.prim_range)
																+' '+trim(l.predir)
																+' '+trim(l.prim_name)
																+' '+trim(l.addr_suffix)
																+' '+trim(l.postdir)
																))
																;
			self.Address2:=	trim(stringlib.stringcleanspaces(trim(l.unit_desig)
																+' '+trim(l.sec_range)
																))
																;

			self.city	:=	l.v_city_name	;
			self.state	:=	l.st	;
			self.county	:=	l.fips_county	;
			self.extzip	:=	l.zip4	;
			self.latitude	:=	l.geo_lat	;
			self.longitute	:=	l.geo_long	;
			self.birthdate	:=	l.clean_dob	;
			self.taxid	:=	l.clean_ssn	;

			self.prov_clean_prim_range	:=	l.prim_range	;
			self.prov_clean_predir	:=	l.predir	;
			self.prov_clean_prim_name	:=	l.prim_name	;
			self.prov_clean_addr_suffix	:=	l.addr_suffix	;
			self.prov_clean_postdir	:=	l.postdir	;
			self.prov_clean_unit_desig	:=	l.unit_desig	;
			self.prov_clean_sec_range	:=	l.sec_range	;
			self.prov_clean_p_city_name	:=	l.p_city_name	;
			self.prov_clean_v_city_name	:=	l.v_city_name	;
			self.prov_clean_st	:=	l.st	;
			self.prov_clean_zip	:=	l.zip	;
			self.prov_clean_zip4	:=	l.zip4	;
			self.prov_clean_cart	:=	l.cart	;
			self.prov_clean_cr_sort_sz	:=	l.cr_sort_sz	;
			self.prov_clean_lot	:=	l.lot	;
			self.prov_clean_lot_order	:=	l.lot_order	;
			self.prov_clean_dpbc	:=	l.dbpc	;
			self.prov_clean_chk_digit	:=	l.chk_digit	;
			self.prov_clean_record_type	:=	l.rec_type	;
			self.prov_clean_ace_fips_st	:=	l.fips_st	;
			self.prov_clean_fipscounty	:=	l.fips_county	;
			self.prov_clean_geo_lat	:=	l.geo_lat	;
			self.prov_clean_geo_long	:=	l.geo_long	;
			self.prov_clean_msa	:=	l.msa	;
			self.prov_clean_geo_match	:=	l.geo_match	;
			self.prov_clean_err_stat	:=	l.err_stat	;

			self.deceaseddate	:=	l.date_of_death	;
			self.deceasedindicator	:=	if(self.deceaseddate<>'','Y','N')	;

			self:=l;
			self:=[];
		end;

		prep1:=project(InIndi,tr1(left));

		prep2:=join(prep1,InAddr
							,left.group_key=right.group_key
							and left.addr_key=right.addr_key
							,transform(OutLayout
									,self.PhoneNumber:=if(left.group_key=right.group_key,right.clean_phone,'')
									,self.p2:=if(left.group_key=right.group_key,right.phone2,'')
									,self.p3:=if(left.group_key=right.group_key,right.phone3,'')
									,self.f1:=if(left.group_key=right.group_key,right.clean_fax,'')
									,self.f2:=if(left.group_key=right.group_key,right.fax2,'')
									,self.f3:=if(left.group_key=right.group_key,right.fax3,'')
									,self:=left
									)
							,left outer
							);

		// OutLayout tr2(InFac l) := transform
			// self.did	:=	intformat(l.did,12,1)	;
			// self.did_score	:=	(string)l.did_score;
			// self.dt_first_seen	:=	(string)l.dt_first_seen;
			// self.dt_last_seen	:=	(string)l.dt_last_seen;
			// self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			// self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			// self.processdate	:=	(string)l.dt_vendor_last_reported;
			// self.providerid	:=	(string)l.pid	;

			// self.addressid	:=	l.Addr_key	;

			// self.Address:=trim(stringlib.stringcleanspaces(
																		// trim(l.prim_range)
																// +' '+trim(l.predir)
																// +' '+trim(l.prim_name)
																// +' '+trim(l.addr_suffix)
																// +' '+trim(l.postdir)
																// ))
																// ;
			// self.Address2:=	trim(stringlib.stringcleanspaces(trim(l.unit_desig)
																// +' '+trim(l.sec_range)
																// ))
																// ;

			// self.city	:=	l.v_city_name	;
			// self.state	:=	l.st	;
			// self.county	:=	l.fips_county	;
			// self.extzip	:=	l.zip4	;
			// self.latitude	:=	l.geo_lat	;
			// self.longitute	:=	l.geo_long	;
			// self.birthdate	:=	l.clean_dob	;
			// self.taxid	:=	l.clean_ssn	;

			// self.prov_clean_prim_range	:=	l.prim_range	;
			// self.prov_clean_predir	:=	l.predir	;
			// self.prov_clean_prim_name	:=	l.prim_name	;
			// self.prov_clean_addr_suffix	:=	l.addr_suffix	;
			// self.prov_clean_postdir	:=	l.postdir	;
			// self.prov_clean_unit_desig	:=	l.unit_desig	;
			// self.prov_clean_sec_range	:=	l.sec_range	;
			// self.prov_clean_p_city_name	:=	l.p_city_name	;
			// self.prov_clean_v_city_name	:=	l.v_city_name	;
			// self.prov_clean_st	:=	l.st	;
			// self.prov_clean_zip	:=	l.zip	;
			// self.prov_clean_zip4	:=	l.zip4	;
			// self.prov_clean_cart	:=	l.cart	;
			// self.prov_clean_cr_sort_sz	:=	l.cr_sort_sz	;
			// self.prov_clean_lot	:=	l.lot	;
			// self.prov_clean_lot_order	:=	l.lot_order	;
			// self.prov_clean_dpbc	:=	l.dbpc	;
			// self.prov_clean_chk_digit	:=	l.chk_digit	;
			// self.prov_clean_record_type	:=	l.rec_type	;
			// self.prov_clean_ace_fips_st	:=	l.fips_st	;
			// self.prov_clean_fipscounty	:=	l.fips_county	;
			// self.prov_clean_geo_lat	:=	l.geo_lat	;
			// self.prov_clean_geo_long	:=	l.geo_long	;
			// self.prov_clean_msa	:=	l.msa	;
			// self.prov_clean_geo_match	:=	l.geo_match	;
			// self.prov_clean_err_stat	:=	l.err_stat	;

			// self:=l;
			// self:=[];
		// end;

		// prep3:=project(InFac,tr2(left));

		EXPORT Provider_all := prep2 : persist('~thor400_data::persist::Provider_all');

		//////////////////////////////////////////////////////////
		// Provider_did
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.Provider_did};

		prep1 := project(Provider_all,outlayout);

		EXPORT Provider_did := prep1;

		//////////////////////////////////////////////////////////
		// License_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,Ingenix_NatlProf.update_providerlicense};

		OutLayout tr1(InLic l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			self.licensenumber	:=	l.lic_num_in	;
			self.licensestate	:=	l.lic_state	;
			self.effective_date	:=	l.lic_begin_date	;
			self.termination_date	:=	l.lic_end_date	;
			self:=l;
			self:=[];
		end;

		prep1:=project(InLic,tr1(left))(licensestate<>'',licensenumber<>'',length(stringlib.stringfilterout(trim(licensenumber,all),'0'))<>0);

		OutLayout tr2(InFac l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			self.licensenumber	:=	l.lic_num_in	;
			self.licensestate	:=	l.lic_state	;
			self.effective_date	:=	l.lic_begin_date	;
			self.termination_date	:=	l.lic_end_date	;
			self:=l;
			self:=[];
		end;

		prep2:=project(InFac,tr2(left))(licensestate<>'',licensenumber<>'',length(stringlib.stringfilterout(trim(licensenumber,all),'0'))<>0);

		EXPORT License_all := dedup(prep1 + prep2,record,all) : persist('~thor400_data::persist::License_all');

		//////////////////////////////////////////////////////////
		// update_providerlicense
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.update_providerlicense};

		prep1 := project(License_all,outlayout);

		EXPORT update_providerlicense := prep1;

		//////////////////////////////////////////////////////////
		// NPI_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,Ingenix_NatlProf.update_NPI};

		OutLayout tr1(InNpi l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			self.npi	:=	l.npi_num	;
			self.taxonomycode	:=	l.taxonomy	;
			self.PrimaryIndicator	:=	l.taxonomy_primary_ind	;
			self.enumerationdate	:=	l.npi_enum_date	;
			// self.NPITierTypeID	:=	Are you looking for Type1/Type 2 indicator?
			self:=l;
			self:=[];
		end;

		prep1:=project(InNpi,tr1(left))(npi<>'');

		OutLayout tr2(InAsso l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			self.npi	:=	l.bill_npi;
			self:=l;
			self:=[];
		end;

		prep2:=project(InAsso,tr2(left))(npi<>'');

		EXPORT NPI_all := dedup(prep1 + prep2,record,all) : persist('~thor400_data::persist::NPI_all');

		//////////////////////////////////////////////////////////
		// update_NPI
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.update_NPI};

		prep1 := project(NPI_all,outlayout);

		EXPORT update_NPI := prep1;

		//////////////////////////////////////////////////////////
		// DEA_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,Ingenix_NatlProf.update_DEA};

		OutLayout tr1(InDea l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			self.deanumber	:=	l.dea_num	;
			self.addressid	:=	l.Addr_key	;

			self:=l;
			self:=[];
		end;

		prep1:=project(InDea,tr1(left))(deanumber<>'');

		OutLayout tr2(InFac l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			self.deanumber	:=	l.dea_num	;
			self.addressid	:=	l.Addr_key	;

			self:=l;
			self:=[];
		end;

		prep2:=project(InFac,tr2(left))(deanumber<>'');

		EXPORT DEA_all := dedup(prep1 + prep2,record,all) : persist('~thor400_data::persist::DEA_all');

		//////////////////////////////////////////////////////////
		// update_DEA
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.update_DEA};

		prep1 := project(DEA_all,outlayout);

		EXPORT update_DEA := prep1;

		//////////////////////////////////////////////////////////
		// UPIN_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,Ingenix_NatlProf.update_UPIN};

		OutLayout tr1(InIndi l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			self.upin	:=	l.upin	;

			self:=l;
			self:=[];
		end;

		prep1:=project(InIndi,tr1(left))(upin<>'');

		EXPORT UPIN_all := prep1 : persist('~thor400_data::persist::UPIN_all');

		//////////////////////////////////////////////////////////
		// update_UPIN
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.update_UPIN};

		prep1 := project(UPIN_all,outlayout);

		EXPORT update_UPIN := prep1;

		//////////////////////////////////////////////////////////
		// Group_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,ingenix_natlprof.Group_BDID};

		OutLayout tr1(InAsso l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			// self.grouppracticeid	:=	fn_scale_gk(l.billing_group_key);
			self.grouppracticeid	:=	fn_scale_gk(l.sloc_group_key);
			self.GroupName	:=	l.Prepped_name	;
			self.PhoneNumber	:=	l.clean_phone	;
			self.addressid	:=	l.Addr_key	;
			self.address	:=	trim(StringLib.StringCleanSpaces(
															l.prim_range
														+' '+l.predir
														+' '+l.prim_name
														+' '+l.addr_suffix
														+' '+l.postdir
														+' '+l.unit_desig
														+' '+l.sec_range
														));
			self.city	:=	l.v_city_name	;
			self.state	:=	l.st	;
			self.extzip	:=	l.zip4	;
			self.Latitude	:=	l.geo_lat	;
			self.Longitude	:=	l.geo_long	;
			self.taxid	:=	l.bill_tin	;
			self.bdid	:=	intformat(l.bdid,12,1)	;
			self.bdid_score	:=	intformat(l.bdid_score,3,1)	;

			self:=l;
			self:=[];
		end;

		prep1:=project(InAsso,tr1(left));

		EXPORT Group_all := prep1 : persist('~thor400_data::persist::Group_all');

		//////////////////////////////////////////////////////////
		// Group_BDID
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.Group_BDID};

		prep1 := project(Group_all,outlayout);

		EXPORT Group_BDID := prep1;

		//////////////////////////////////////////////////////////
		// Speciality_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,ingenix_natlprof.File_in_Provider_Speciality_Joined};

		OutLayout tr1(InSpec l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			self.specialityid	:=	l.spec_code	;
			self.specialityname	:=	l.spec_desc	;
			self.specialitygroupid	:=	l.spec_code	;
			self.specialitygroupname	:=	l.spec_desc	;

			self:=l;
			self:=[];
		end;

		prep1:=project(InSpec,tr1(left))(specialityid<>'');

		prep2:=join(InFac(specialization<>''),dedup(InSpec,spec_desc,all)
							,left.specialization=right.spec_desc
							,transform(OutLayout
									,self.dt_first_seen	:=	(string)left.dt_first_seen;
									,self.dt_last_seen	:=	(string)left.dt_last_seen;
									,self.dt_vendor_first_reported	:=	(string)left.dt_vendor_first_reported;
									,self.dt_vendor_last_reported	:=	(string)left.dt_vendor_last_reported;
									,self.processdate	:=	(string)left.dt_vendor_last_reported;
									,self.providerid	:=	(string)left.pid	;
									,self.specialityid:=right.spec_code
									,self.specialityname:=if(left.specialization=right.spec_desc,right.spec_desc,left.specialization)
									,self:=left
									,self:=[]
									)
							,left outer
							,lookup);

		EXPORT Speciality_all := dedup(prep1 + prep2,record,all) : persist('~thor400_data::persist::Speciality_all');

		//////////////////////////////////////////////////////////
		// File_in_Provider_Speciality_Joined
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.File_in_Provider_Speciality_Joined};

		prep1 := project(Speciality_all,outlayout);

		EXPORT File_in_Provider_Speciality_Joined := prep1;

		//////////////////////////////////////////////////////////
		// Hospital_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,ingenix_natlprof.Hospital_BDID};

		OutLayout tr1(InFac l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			self.PhoneNumber	:=	l.clean_phone	;
			self.MedicareProviderID	:=	l.Medicare_fac_num	;
			self.HospitalName	:=	l.prac_company_name	;
			self.ServiceCodeDescription	:=	l.classification	;
			self.addressid	:=	l.Addr_key	;
			self.address	:=	trim(StringLib.StringCleanSpaces(
															l.prim_range
														+' '+l.predir
														+' '+l.prim_name
														+' '+l.addr_suffix
														+' '+l.postdir
														+' '+l.unit_desig
														+' '+l.sec_range
														));
			self.city	:=	l.v_city_name	;
			self.state	:=	l.st	;
			self.extzip	:=	l.zip4	;
			self.Latitude	:=	l.geo_lat	;
			self.Longitude	:=	l.geo_long	;
			self.bdid	:=	intformat(l.bdid,12,1)	;
			self.bdid_score	:=	intformat(l.bdid_score,3,1)	;

			self:=l;
			self:=[];
		end;

		prep1:=project(InFac,tr1(left));

		EXPORT Hospital_all := prep1 : persist('~thor400_data::persist::Hospital_all');

		//////////////////////////////////////////////////////////
		// Hospital_BDID
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.Hospital_BDID};

		prep1 := project(Hospital_all,outlayout);

		EXPORT Hospital_BDID := prep1;

		//////////////////////////////////////////////////////////
		// Medschool_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,ingenix_natlprof.Medschool_BDID};

		OutLayout tr1(InMSch l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			self.MedSchoolName	:=	l.MedSchool	;
			self.GraduationYear	:=	l.MedSchool_year	;

			self:=l;
			self:=[];
		end;

		prep1:=project(InMSch,tr1(left));

		EXPORT Medschool_all := prep1 : persist('~thor400_data::persist::Medschool_all');

		//////////////////////////////////////////////////////////
		// Medschool_BDID
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.Medschool_BDID};

		prep1 := project(Medschool_all,outlayout);

		EXPORT Medschool_BDID := prep1;

		//////////////////////////////////////////////////////////
		// update_degree
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,Ingenix_NatlProf.update_degree};

		OutLayout tr1(InIndi l) := transform
			self.dt_first_seen	:=	(string)l.dt_first_seen;
			self.dt_last_seen	:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported	:=	(string)l.dt_vendor_last_reported;
			self.processdate	:=	(string)l.dt_vendor_last_reported;
			self.providerid	:=	(string)l.pid	;
			self.Degree	:=	l.suffix_other	;

			self:=l;
			self:=[];
		end;

		prep1:=project(InIndi,tr1(left))(Degree<>'');

		EXPORT update_degree := dedup(prep1,record,all);

		//////////////////////////////////////////////////////////
		// Residency_BDID
		//////////////////////////////////////////////////////////

		OutLayout  := {ingenix_natlprof.Residency_BDID};

		prep1 := dataset([],OutLayout);

		EXPORT Residency_BDID := prep1;

		//////////////////////////////////////////////////////////
		// update_language
		//////////////////////////////////////////////////////////

		OutLayout  := {Ingenix_NatlProf.update_language};

		prep1 := dataset([],OutLayout);

		EXPORT update_language := prep1;

END;