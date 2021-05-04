IMPORT ingenix_natlprof,Healthcare_Provider_Services,NPPES,ut;

// EXPORT As_Ingenix (STRING filedate, boolean pUseProd = false) := MODULE
EXPORT As_Ingenix (STRING filedate, boolean pUseProd = true) := MODULE

		SHARED InSanc  := Enclarity.Files(,pUseProd).sanction_base.qa;//(record_type='C');
		SHARED InSanTp := Enclarity.Files(,pUseProd).sanc_prov_type_base.qa(record_type='C');
		SHARED InSanCd := Enclarity.Files(,pUseProd).sanc_codes_base.qa(record_type='C');
		SHARED InIndi  := Enclarity.Files(,pUseProd).individual_base.qa(record_type='C');
		SHARED InAsso  := Enclarity.Files(,pUseProd).associate_base.qa(record_type='C');
		SHARED InFac   := Enclarity.Files(,pUseProd).facility_base.qa(record_type='C');
		SHARED InLic   := Enclarity.Files(,pUseProd).license_base.qa(record_type='C');
		SHARED InNpi   := Enclarity.Files(,pUseProd).npi_base.qa(record_type='C');
		SHARED InDea   := Enclarity.Files(,pUseProd).dea_base.qa(record_type='C');
		SHARED InDeaCd := Enclarity.Files(,pUseProd).dea_bacodes_base;
		SHARED InAddr  := Enclarity.Files(,pUseProd).address_base.qa(record_type='C');
		SHARED InTxo   := Enclarity.Files(,pUseProd).taxonomy_base.qa(record_type='C');
		SHARED InTxoCd := Enclarity.Files(,pUseProd).tax_codes_base.qa(record_type='C');
		SHARED InMSch  := Enclarity.Files(,pUseProd).medschool_base.qa(record_type='C');
		SHARED InSpec  := Enclarity.Files(,pUseProd).specialty_base.qa(record_type='C');
		SHARED InProBd := Enclarity.Files(,pUseProd).prov_birthdate_base.qa(record_type='C');
		SHARED InProSn := Enclarity.Files(,pUseProd).prov_ssn_base.qa(record_type='C');
		SHARED NPPES_  := NPPES.File_NPPES_Base(length(trim(regexreplace('[^0-9]',npi,'')))=10,(unsigned)npi>0);
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

		SHARED fn_scale_gk(string38 gk) := function
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
									,unsigned6 lnpid
									,Ingenix_NatlProf.layout_sanctions_bdid
									};

		OutLayout tr1(InSanc l) 		:= transform
			self.lnpid															:=	l.lnpid;
			self.date_first_seen					:=	(string)l.dt_first_seen;
			self.date_last_seen						:=	(string)l.dt_last_seen;
			self.date_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.date_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.process_date								:=	(string)l.dt_vendor_last_reported;

			self.SANC_ID													:=	(string)l.pid;

			decodes																		:=	decodeSancInfo(l.sanc1_code);

			//If it is a reinstatement, then the sanction data is really a reinstate date
			cleanCode 															:=	trim(l.sanc1_code,left,right);
			lastCharacter 											:=	cleanCode[length(cleanCode)];
			isReinstatement 									:= 	if(lastCharacter='R',true,false);
			self.SANC_SANCDTE 							:= 	l.clean_sanc1_date;
			self.SANC_SANCDTE_form 		:= 	l.clean_sanc1_date;
			self.SANC_REINDTE 							:= 	if((unsigned)l.clean_sanc1_rein_date>0,l.clean_sanc1_rein_date,l.LN_derived_rein_date);

			self.SANC_SANCST									:=	l.sanc1_state	;
			self.SANC_LICNBR									:=	if(length(stringlib.stringfilterout(trim(l.sanc1_lic_num,all),'0'))<>0,l.sanc1_lic_num,'')	;

			self.SANC_COND 										:= 	decodes.Cat;
			self.SANC_REAS 										:= 	decodes.desc;
			self.SANC_TYPE 										:= 	decodes.LegacyType;
			self.SANC_FAB 											:= 	if(decodes.Cat='FRAUD/ABUSE','TRUE','FALSE');
			self.SANC_UNAMB_IND 					:= 	decodes.LossOfLicense;

			self.SANC_PROVTYPE							:=	l.sanc1_prof_type	;

			self.sanc_brdtype								:=	l.sanc1_code	; //temp hold field
			self																					:=	l;
			self																					:=	[];
		end;

		prep1:=project(InSanc,tr1(left));

		prep2:=join(prep1,InSanTp
							,left.SANC_PROVTYPE=right.prov_type_code
							,transform({prep1,InSanTp.prov_type_code,InSanTp.prov_type_desc}
									,self:=left
									,self:=right
									)
							,left outer
							,lookup);

		prep3:=join(prep2,InSanCd
							,left.sanc_brdtype=right.sanc_code  // note: overloaded sanc_brdtype for temp use above
							,transform({prep2,InSanCd.sanc_code,InSanCd.sanc_desc}
									,self:=left
									,self:=right
									)
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

		sort_prep4			:= sort(distribute(prep4, hash(group_key)), group_key, local);
		sort_InProSn	:= sort(distribute(InProSn(clean_ssn<>''), hash(group_key)), group_key, local);
		
		prep5:=join(sort_prep4,sort_InProSn
							,left.group_key=right.group_key
							,transform(OutLayout
									,self.sanc_tin:=if(left.group_key=right.group_key,right.clean_ssn,'')
									,self:=left
									)
							,left outer
							,lookup);
							
		
		temp_InIndi_rec:= record
			InIndi.lnpid;
			InIndi.dt_first_seen;
			InIndi.dt_last_seen;
			InIndi.dt_vendor_first_reported;
			InIndi.dt_vendor_last_reported;
			InIndi.pid;
			InIndi.group_key;
			InIndi.addr_key;
			InIndi.prim_range;
			InIndi.predir;
			InIndi.prim_name;
			InIndi.addr_suffix;
			InIndi.postdir;
			InIndi.unit_desig;
			InIndi.sec_range;
			InIndi.v_city_name;
			InIndi.p_city_name;
			InIndi.st;
			InIndi.zip;
			InIndi.zip4;
			InIndi.cart;
			InIndi.cr_sort_sz;
			InIndi.lot;
			InIndi.lot_order;
			InIndi.dbpc;
			InIndi.chk_digit;
			InIndi.rec_type;
			InIndi.fips_st;
			InIndi.fips_county;
			InIndi.geo_lat;
			InIndi.geo_long;
			InIndi.msa;
			InIndi.geo_match;
			InIndi.err_stat;
			InIndi.source_rid;
			InIndi.did;
			InIndi.last_name;
			InIndi.first_name;
			InIndi.middle_name;
			InIndi.clean_dob;
			InIndi.clean_ssn;
			InIndi.upin;
			InIndi.title;
			InIndi.fname;
			InIndi.mname;
			InIndi.lname;
			InIndi.name_suffix;
			InIndi.DotID;
			InIndi.DotScore;
			InIndi.DotWeight;
			InIndi.EmpID;
			InIndi.EmpScore;
			InIndi.EmpWeight;
			InIndi.POWID;
			InIndi.POWScore;
			InIndi.POWWeight;
			InIndi.ProxID;
			InIndi.ProxScore;
			InIndi.ProxWeight;
			InIndi.SELEID;
			InIndi.SELEScore;
			InIndi.SELEWeight;	
			InIndi.OrgID;
			InIndi.OrgScore;
			InIndi.OrgWeight;
			InIndi.UltID;
			InIndi.UltScore;
			InIndi.UltWeight;	
		end;
		
		slim_InIndi	:= project(InIndi, temp_InIndi_rec);
		sort_prep5		:= sort(distribute(prep5, hash(group_key)), group_key, local);
		dedup_InIndi	:=	dedup(sort(distribute(slim_InIndi, hash(group_key, addr_key)), group_key, addr_key, -dt_vendor_last_reported, local), group_key, addr_key, local):independent;
		sort_InIndi	:=	sort(distribute(dedup_InIndi, hash(group_key)), group_key, -dt_vendor_last_reported, local):independent;

		OutLayout tr2(sort_prep5 l, sort_InIndi r) := transform
			self.lnpid															:=	if(l.group_key = r.group_key, r.lnpid, l.lnpid);
			self.date_first_seen					:=	if(l.group_key = r.group_key, (string)r.dt_first_seen, l.date_first_seen);
			self.date_last_seen						:=	if(l.group_key = r.group_key, (string)r.dt_last_seen, l.date_last_seen);
			self.date_first_reported	:=	if(l.group_key = r.group_key, (string)r.dt_vendor_first_reported, l.date_first_reported);
			self.date_last_reported		:=	if(l.group_key = r.group_key, (string)r.dt_vendor_last_reported, l.date_last_reported);
			self.process_date								:=	if(l.group_key = r.group_key, (string)r.dt_vendor_last_reported, l.process_date);
			self.SANC_ID													:=	if(l.group_key = r.group_key, (string)r.pid, l.sanc_id);

			self.SANC_STREET									:=	if(l.group_key = r.group_key
																															,trim(stringlib.stringcleanspaces(
																																			trim(r.prim_range)
																																			+' '+trim(r.predir)
																																			+' '+trim(r.prim_name)
																																			+' '+trim(r.addr_suffix)
																																			+' '+trim(r.postdir)
																																			+' '+trim(r.unit_desig)
																																			+' '+trim(r.sec_range)
																															))
																															,l.sanc_street);

			self.SANC_CITY  									:=	if(l.group_key = r.group_key, r.v_city_name, l.sanc_city)	;
			self.SANC_STATE										:=	if(l.group_key = r.group_key, r.st, l.sanc_state)	;
			self.SANC_ZIP 											:=	if(l.group_key = r.group_key, r.zip, l.sanc_zip)	;

			self.did																	:=	intformat(if(l.group_key = r.group_key, (unsigned)r.did, (unsigned)l.did), 12, 1);
			self.sanc_lnme											:=	if(l.group_key = r.group_key, r.last_name, l.sanc_lnme);
			self.sanc_fnme											:=	if(l.group_key = r.group_key, r.first_name, l.sanc_fnme);
			self.sanc_mid_i_nm							:=	if(l.group_key = r.group_key, r.middle_name, l.sanc_mid_i_nm);
			self.sanc_dob												:=	if(l.group_key = r.group_key, r.clean_dob, l.sanc_dob);
			self.sanc_tin												:=	if(l.group_key = r.group_key, r.clean_ssn, l.sanc_tin);
			self.sanc_upin											:=	if(l.group_key = r.group_key, r.upin, l.sanc_upin);
			self.prov_clean_title				:=	if(l.group_key = r.group_key, r.title, l.prov_clean_title);
			self.prov_clean_fname				:=	if(l.group_key = r.group_key,	r.fname,	l.prov_clean_fname);
			self.prov_clean_mname				:=	if(l.group_key = r.group_key,	r.mname, l.prov_clean_mname);
			self.prov_clean_lname				:=	if(l.group_key = r.group_key, r.lname, l.prov_clean_lname);
			self.prov_clean_name_suffix											:=	if(l.group_key = r.group_key, r.name_suffix, l.prov_clean_name_suffix);
			self.provco_address_clean_prim_range		:=	if(l.group_key = r.group_key, r.prim_range, l.provco_address_clean_prim_range);
			self.provco_address_clean_predir						:=	if(l.group_key = r.group_key, r.predir, l.provco_address_clean_predir);
			self.provco_address_clean_prim_name			:=	if(l.group_key = r.group_key, r.prim_name, l.provco_address_clean_prim_name);
			self.provco_address_clean_addr_suffix	:=	if(l.group_key = r.group_key, r.addr_suffix, l.provco_address_clean_addr_suffix);
			self.provco_address_clean_postdir					:=	if(l.group_key = r.group_key, r.postdir, l.provco_address_clean_postdir);
			self.provco_address_clean_unit_desig		:=	if(l.group_key = r.group_key, r.unit_desig, l.provco_address_clean_unit_desig);
			self.provco_address_clean_sec_range			:=	if(l.group_key = r.group_key, r.sec_range, l.provco_address_clean_sec_range);
			self.provco_address_clean_p_city_name	:=	if(l.group_key = r.group_key, r.p_city_name, l.provco_address_clean_p_city_name);
			self.provco_address_clean_v_city_name	:=	if(l.group_key = r.group_key,	r.v_city_name, l.provco_address_clean_v_city_name);
			self.provco_address_clean_st										:=	if(l.group_key = r.group_key,	r.st,	l.provco_address_clean_st);
			self.provco_address_clean_zip									:=	if(l.group_key = r.group_key, r.zip, l.provco_address_clean_zip);
			self.provco_address_clean_zip4								:=	if(l.group_key = r.group_key, r.zip4, l.provco_address_clean_zip4);
			self.provco_address_clean_cart								:=	if(l.group_key = r.group_key, r.cart, l.provco_address_clean_cart);
			self.provco_address_clean_cr_sort_sz		:=	if(l.group_key = r.group_key, r.cr_sort_sz, l.provco_address_clean_cr_sort_sz);
			self.provco_address_clean_lot									:=	if(l.group_key = r.group_key, r.lot, l.provco_address_clean_lot);
			self.provco_address_clean_lot_order			:=	if(l.group_key = r.group_key, r.lot_order, l.provco_address_clean_lot_order);
			self.provco_address_clean_dpbc								:=	if(l.group_key = r.group_key, r.dbpc, l.provco_address_clean_dpbc);
			self.provco_address_clean_chk_digit			:=	if(l.group_key = r.group_key, r.chk_digit, l.provco_address_clean_chk_digit);
			self.provco_address_clean_record_type	:=	if(l.group_key = r.group_key, r.rec_type, l.provco_address_clean_record_type);
			self.provco_address_clean_ace_fips_st	:=	if(l.group_key = r.group_key, r.fips_st, l.provco_address_clean_ace_fips_st);
			self.provco_address_clean_fipscounty		:=	if(l.group_key = r.group_key, r.fips_county, l.provco_address_clean_fipscounty);
			self.provco_address_clean_geo_lat					:=	if(l.group_key = r.group_key, r.geo_lat, l.provco_address_clean_geo_lat);
			self.provco_address_clean_geo_long				:=	if(l.group_key = r.group_key, r.geo_long, l.provco_address_clean_geo_long);
			self.provco_address_clean_msa									:=	if(l.group_key = r.group_key, r.msa, l.provco_address_clean_msa);
			self.provco_address_clean_geo_match			:=	if(l.group_key = r.group_key, r.geo_match, l.provco_address_clean_geo_match);
			self.provco_address_clean_err_stat				:=	if(l.group_key = r.group_key, r.err_stat, l.provco_address_clean_err_stat);
			self.source_rec_id																				:=	if(l.group_key = r.group_key, r.source_rid, l.source_rec_id);

			self.DotID					:= r.DotID;
			self.DotScore		:= r.DotScore;
			self.DotWeight	:= r.DotWeight;
			self.EmpID					:= r.EmpID;
			self.EmpScore		:= r.EmpScore;
			self.EmpWeight	:= r.EmpWeight;
			self.POWID					:= r.POWID;
			self.POWScore		:= r.POWScore;
			self.POWWeight	:= r.POWWeight;
			self.ProxID				:= r.ProxID;
			self.ProxScore	:= r.ProxScore;
			self.ProxWeight:= r.ProxWeight;
			self.SELEID				:= r.SELEID;
			self.SELEScore	:= r.SELEScore;
			self.SELEWeight:= r.SELEWeight;	
			self.OrgID					:= r.OrgID;
			self.OrgScore		:= r.OrgScore;
			self.OrgWeight	:= r.OrgWeight;
			self.UltID					:= r.UltID;
			self.UltScore		:= r.UltScore;
			self.UltWeight	:= r.UltWeight;	

			self											:= l;
			self											:= [];
		end;
	
		// dedup here may be responsible for random record selection (noticed specifically with regard to addresses) when a group_key has more than one address
		// prep6:=join(distribute(prep5,hash(group_key)), dedup(sort(distribute(InIndi,hash(group_key)),group_key,-dt_vendor_last_reported,local),group_key,local)
		prep6:=join(sort_prep5, sort_InIndi
							,left.group_key=right.group_key
							,tr2(left,right)
							,left outer
							,local
							);

		temp_InAsso_rec:= record
			InAsso.lnpid;
			InAsso.dt_first_seen;
			InAsso.dt_last_seen;
			InAsso.dt_vendor_first_reported;
			InAsso.dt_vendor_last_reported;
			InAsso.pid;
			InAsso.group_key;
			InAsso.addr_key;
			InAsso.prim_range;
			InAsso.predir;
			InAsso.prim_name;
			InAsso.addr_suffix;
			InAsso.postdir;
			InAsso.unit_desig;
			InAsso.sec_range;
			InAsso.v_city_name;
			InAsso.st;
			InAsso.zip;
			InAsso.bdid;
			InAsso.bdid_score;
			InAsso.did;
			InAsso.Prepped_name;
			InAsso.bill_tin;
			InAsso.title;
			InAsso.fname;
			InAsso.mname;
			InAsso.lname;
			InAsso.name_suffix;
			InAsso.p_city_name;
			InAsso.zip4;
			InAsso.cart;
			InAsso.cr_sort_sz;
			InAsso.lot;
			InAsso.lot_order;
			InAsso.dbpc;
			InAsso.chk_digit;
			InAsso.rec_type;
			InAsso.fips_st;
			InAsso.fips_county;
			InAsso.geo_lat;
			InAsso.geo_long;
			InAsso.msa;
			InAsso.geo_match;
			InAsso.err_stat;
			InAsso.source_rid;
			InAsso.DotID;
			InAsso.DotScore;
			InAsso.DotWeight;
			InAsso.EmpID;
			InAsso.EmpScore;
			InAsso.EmpWeight;
			InAsso.POWID;
			InAsso.POWScore;
			InAsso.POWWeight;
			InAsso.ProxID;
			InAsso.ProxScore;
			InAsso.ProxWeight;
			InAsso.SELEID;
			InAsso.SELEScore;
			InAsso.SELEWeight;	
			InAsso.OrgID;
			InAsso.OrgScore;
			InAsso.OrgWeight;
			InAsso.UltID;
			InAsso.UltScore;
			InAsso.UltWeight;	
		end;
		
		slim_InAsso	:= project(InAsso, temp_InAsso_rec);
		
		sort_prep6		:= sort(distribute(prep6, hash(group_key)), group_key, local);
		dedup_InAsso	:= dedup(sort(distribute(slim_InAsso, hash(group_key, addr_key)), group_key, addr_key, -dt_vendor_last_reported, local), group_key, addr_key, local):independent;
		sort_InAsso	:= sort(distribute(dedup_InAsso, hash(group_key)), group_key, -dt_vendor_last_reported, local):independent;
		
		OutLayout tr3(sort_prep6 l, sort_InAsso r) := transform
			self.lnpid															:=	if(l.group_key = r.group_key, r.lnpid, l.lnpid);
			self.date_first_seen					:=	if(l.group_key = r.group_key, (string)r.dt_first_seen, l.date_first_seen);
			self.date_last_seen						:=	if(l.group_key = r.group_key, (string)r.dt_last_seen, l.date_last_seen);
			self.date_first_reported	:=	if(l.group_key = r.group_key, (string)r.dt_vendor_first_reported, l.date_first_reported);
			self.date_last_reported		:=	if(l.group_key = r.group_key, (string)r.dt_vendor_last_reported, l.date_last_reported);
			self.process_date								:=	if(l.group_key = r.group_key, (string)r.dt_vendor_last_reported, l.process_date);
			self.SANC_ID													:=	if(l.group_key = r.group_key, (string)r.pid, l.sanc_id);

			self.SANC_STREET									:=	if(l.group_key = r.group_key
																																,trim(stringlib.stringcleanspaces(
																																				trim(r.prim_range)
																																				+' '+trim(r.predir)
																																				+' '+trim(r.prim_name)
																																				+' '+trim(r.addr_suffix)
																																				+' '+trim(r.postdir)
																																				+' '+trim(r.unit_desig)
																																				+' '+trim(r.sec_range)
																																))
																																,l.sanc_street);

			self.SANC_CITY  									:=	if(l.group_key = r.group_key, r.v_city_name, l.sanc_city);
			self.SANC_STATE										:=	if(l.group_key = r.group_key, r.st, l.sanc_state)	;
			self.SANC_ZIP 											:=	if(l.group_key = r.group_key, r.zip, l.sanc_zip)	;

			self.bdid																:=	if(l.group_key = r.group_key, r.bdid, l.bdid);
			self.bdid_score										:=	if(l.group_key = r.group_key, r.bdid_score, l.bdid_score);
			self.did																	:=	intformat(if(l.group_key = r.group_key, (unsigned)r.did, (unsigned)l.did),12,1);
			self.SANC_BUSNME									:=	if(l.group_key = r.group_key, r.Prepped_name, l.sanc_busnme);
			self.SANC_TIN												:=	if(l.group_key = r.group_key, r.bill_tin, l.sanc_tin);
			self.prov_clean_title				:=	if(l.group_key = r.group_key,	r.title,	l.prov_clean_title);
			self.prov_clean_fname				:=	if(l.group_key = r.group_key, r.fname, l.prov_clean_fname);
			self.prov_clean_mname				:=	if(l.group_key = r.group_key, r.mname, l.prov_clean_mname);
			self.prov_clean_lname				:=	if(l.group_key = r.group_key, r.lname, l.prov_clean_lname);
			self.prov_clean_name_suffix										:=	if(l.group_key = r.group_key, r.name_suffix, l.prov_clean_name_suffix);
			self.provco_address_clean_prim_range	:=	if(l.group_key = r.group_key, r.prim_range, l.provco_address_clean_prim_range);
			self.provco_address_clean_predir					:=	if(l.group_key = r.group_key, r.predir, l.provco_address_clean_predir);
			self.provco_address_clean_prim_name		:=	if(l.group_key = r.group_key, r.prim_name, l.provco_address_clean_prim_name);
			self.provco_address_clean_addr_suffix:=	if(l.group_key = r.group_key, r.addr_suffix, l.provco_address_clean_addr_suffix);
			self.provco_address_clean_postdir				:=	if(l.group_key = r.group_key, r.postdir, l.provco_address_clean_postdir);
			self.provco_address_clean_unit_desig	:=	if(l.group_key = r.group_key, r.unit_desig, l.provco_address_clean_unit_desig);
			self.provco_address_clean_sec_range		:=	if(l.group_key = r.group_key, r.sec_range, l.provco_address_clean_sec_range);
			self.provco_address_clean_p_city_name:=	if(l.group_key = r.group_key, r.p_city_name, l.provco_address_clean_p_city_name);
			self.provco_address_clean_v_city_name:=	if(l.group_key = r.group_key, r.v_city_name, l.provco_address_clean_v_city_name);
			self.provco_address_clean_st									:=	if(l.group_key = r.group_key, r.st, l.provco_address_clean_st);
			self.provco_address_clean_zip								:=	if(l.group_key = r.group_key, r.zip, l.provco_address_clean_zip);
			self.provco_address_clean_zip4							:=	if(l.group_key = r.group_key, r.zip4, l.provco_address_clean_zip4);
			self.provco_address_clean_cart							:=	if(l.group_key = r.group_key, r.cart, l.provco_address_clean_cart);
			self.provco_address_clean_cr_sort_sz	:=	if(l.group_key = r.group_key, r.cr_sort_sz, l.provco_address_clean_cr_sort_sz);
			self.provco_address_clean_lot								:=	if(l.group_key = r.group_key, r.lot, l.provco_address_clean_lot);
			self.provco_address_clean_lot_order		:=	if(l.group_key = r.group_key, r.lot_order, l.provco_address_clean_lot_order);
			self.provco_address_clean_dpbc							:=	if(l.group_key = r.group_key, r.dbpc, l.provco_address_clean_dpbc);
			self.provco_address_clean_chk_digit		:=	if(l.group_key = r.group_key, r.chk_digit, l.provco_address_clean_chk_digit);
			self.provco_address_clean_record_type:=	if(l.group_key = r.group_key, r.rec_type, l.provco_address_clean_record_type);
			self.provco_address_clean_ace_fips_st:=	if(l.group_key = r.group_key, r.fips_st, l.provco_address_clean_ace_fips_st);
			self.provco_address_clean_fipscounty	:=	if(l.group_key = r.group_key, r.fips_county, l.provco_address_clean_fipscounty);
			self.provco_address_clean_geo_lat				:=	if(l.group_key = r.group_key, r.geo_lat, l.provco_address_clean_geo_lat);
			self.provco_address_clean_geo_long			:=	if(l.group_key = r.group_key, r.geo_long, l.provco_address_clean_geo_long);
			self.provco_address_clean_msa								:=	if(l.group_key = r.group_key, r.msa, l.provco_address_clean_msa);
			self.provco_address_clean_geo_match		:=	if(l.group_key = r.group_key, r.geo_match, l.provco_address_clean_geo_match);
			self.provco_address_clean_err_stat			:=	if(l.group_key = r.group_key, r.err_stat, l.provco_address_clean_err_stat);
			self.source_rec_id																			:=	if(l.group_key = r.group_key, r.source_rid, l.source_rec_id);

			self.DotID					:= 	if(l.group_key = r.group_key, r.DotID, l.DotID);
			self.DotScore		:= 	if(l.group_key = r.group_key, r.DotScore, l.DotScore);
			self.DotWeight	:= 	if(l.group_key = r.group_key, r.DotWeight, l.DotWeight);
			self.EmpID					:= 	if(l.group_key = r.group_key, r.EmpID, l.EmpID);
			self.EmpScore		:= 	if(l.group_key = r.group_key, r.EmpScore, l.EmpScore);
			self.EmpWeight	:= 	if(l.group_key = r.group_key, r.EmpWeight, l.EmpWeight);
			self.POWID					:= 	if(l.group_key = r.group_key, r.POWID, l.POWID);
			self.POWScore		:= 	if(l.group_key = r.group_key, r.POWScore, l.POWScore);
			self.POWWeight	:= 	if(l.group_key = r.group_key, r.POWWeight, l.POWWeight);
			self.ProxID				:= 	if(l.group_key = r.group_key, r.ProxID, l.ProxID);
			self.ProxScore	:= 	if(l.group_key = r.group_key, r.ProxScore, l.ProxScore);
			self.ProxWeight:= 	if(l.group_key = r.group_key, r.ProxWeight, l.ProxWeight);
			self.SELEID				:= 	if(l.group_key = r.group_key, r.SELEID, l.SELEID);
			self.SELEScore	:= 	if(l.group_key = r.group_key, r.SELEScore, l.SELEScore);
			self.SELEWeight:= 	if(l.group_key = r.group_key, r.SELEWeight, l.SELEWeight);	
			self.OrgID					:= 	if(l.group_key = r.group_key, r.OrgID, l.OrgID);
			self.OrgScore		:= 	if(l.group_key = r.group_key, r.OrgScore, l.OrgScore);
			self.OrgWeight	:= 	if(l.group_key = r.group_key, r.OrgWeight, l.OrgWeight);
			self.UltID					:= 	if(l.group_key = r.group_key, r.UltID, l.UltID);
			self.UltScore		:= 	if(l.group_key = r.group_key, r.UltScore, l.UltScore);
			self.UltWeight	:= 	if(l.group_key = r.group_key, r.UltWeight, l.UltWeight);	

			self											:=	l;
			self											:=	[];
		end;

		// dedup here may be responsible for random record selection (noticed specifically with regard to addresses) when a group_key has more than one address
		// prep7:=join(distribute(prep6,hash(group_key)), dedup(sort(distribute(InAsso,hash(group_key)),group_key,-dt_vendor_last_reported,local),group_key,local)
		prep7:=join(sort_prep6, sort_InAsso
							,left.group_key=right.group_key
							// and left.addr_key=right.addr_key
							,tr3(left,right)
							,left outer
							,local
							);

		sort_prep7	:= dedup(sort(distribute(prep7, hash(group_key)), group_key, local), record, local);
		sort_InFac	:= sort(distribute(InFac(sanc1_code <> ''), hash(group_key)), group_key, -dt_vendor_last_reported, local);
		
		OutLayout tr4(sort_InFac l) := transform
			self.lnpid															:=	l.lnpid;
			self.date_first_seen					:=	(string)l.dt_first_seen;
			self.date_last_seen						:=	(string)l.dt_last_seen;
			self.date_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.date_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.process_date								:=	(string)l.dt_vendor_last_reported;

			// not sure two '(string)' are needed here
			// self.SANC_ID							:=(string)(string)l.pid;
			self.SANC_ID													:=	(string)l.pid;
			self.SANC_BUSNME									:=	l.clean_company_name;

			decodes																		:=	decodeSancInfo(l.sanc1_code);

			//If it is a reinstatement, then the sanction data is really a reinstate date
			cleanCode 															:= trim(l.sanc1_code,left,right);
			lastCharacter 											:= cleanCode[length(cleanCode)];
			isReinstatement 									:= if(lastCharacter='R',true,false);
			self.SANC_SANCDTE 							:= if(isReinstatement,'',(string)l.clean_sanc1_date);
			self.SANC_SANCDTE_form 		:= if(isReinstatement,'',(string)l.clean_sanc1_date);
			self.SANC_REINDTE 							:= if(isReinstatement,(string)l.clean_sanc1_date,'');

			self.SANC_SANCST									:=	l.lic_state	;
			self.SANC_LICNBR									:=	if(length(stringlib.stringfilterout(trim(l.lic_num_in,all),'0'))<>0,l.lic_num_in,'')	;

			self.SANC_COND 										:= decodes.Cat;
			self.SANC_REAS 										:= decodes.desc;
			self.SANC_TYPE 										:= decodes.LegacyType;
			self.SANC_FAB 											:= if(decodes.Cat='FRAUD/ABUSE','TRUE','FALSE');
			self.SANC_UNAMB_IND 					:= decodes.LossOfLicense;

			self.SANC_PROVTYPE							:=	l.type1	;

			self.sanc_brdtype								:=	l.sanc1_code	; //temp hold field

			self.provco_address_clean_prim_range		:=	l.prim_range;
			self.provco_address_clean_predir						:=	l.predir;
			self.provco_address_clean_prim_name			:=	l.prim_name;
			self.provco_address_clean_addr_suffix	:=	l.addr_suffix;
			self.provco_address_clean_postdir					:=	l.postdir;
			self.provco_address_clean_unit_desig		:=	l.unit_desig;
			self.provco_address_clean_sec_range			:=	l.sec_range;
			self.provco_address_clean_p_city_name	:=	l.p_city_name;
			self.provco_address_clean_v_city_name	:=	l.v_city_name;
			self.provco_address_clean_st										:=	l.st;
			self.provco_address_clean_zip									:=	l.zip;
			self.provco_address_clean_zip4								:=	l.zip4;
			self.provco_address_clean_cart								:=	l.cart;
			self.provco_address_clean_cr_sort_sz		:=	l.cr_sort_sz;
			self.provco_address_clean_lot									:=	l.lot;
			self.provco_address_clean_lot_order			:=	l.lot_order;
			self.provco_address_clean_dpbc								:=	l.dbpc;
			self.provco_address_clean_chk_digit			:=	l.chk_digit;
			self.provco_address_clean_record_type	:=	l.rec_type;
			self.provco_address_clean_ace_fips_st	:=	l.fips_st;
			self.provco_address_clean_fipscounty		:=	l.fips_county;
			self.provco_address_clean_geo_lat					:=	l.geo_lat;
			self.provco_address_clean_geo_long				:=	l.geo_long;
			self.provco_address_clean_msa									:=	l.msa;
			self.provco_address_clean_geo_match			:=	l.geo_match;
			self.provco_address_clean_err_stat				:=	l.err_stat;

			self																	:=	l;
			self																	:=	[];
		end;

		prep8:=project(sort_InFac,tr4(left));
		
		prep9:=join(prep8,InSanTp
							,left.SANC_PROVTYPE=right.prov_type_code
							,transform({prep8,InSanTp.prov_type_code,InSanTp.prov_type_desc}
									,self:=left
									,self:=right
									)
							,left outer
							,lookup);

		sort_prep9	:= sort(distribute(prep9, hash(sanc_brdtype, group_key)), sanc_brdtype, group_key, local);
		
		prep10:=join(sort_prep9,InSanCd
							,left.sanc_brdtype=right.sanc_code  // note: overloaded sanc_brdtype for temp use above
							,transform({prep9,InSanCd.sanc_code,InSanCd.sanc_desc}
									,self:=left
									,self:=right
									)
							,left outer
							,lookup);
							
		sort_prep10:=sort(prep10, prov_type_desc);

		prep11:=project(sort_prep10
							,transform(OutLayout
									,self.SANC_PROVTYPE:=left.prov_type_desc
									// could put together from provider type, state and type of sanction
									,self.SANC_SRC_DESC := decodeBoardInfo(left.sanc_sancst,left.prov_type_desc).RegulatingBoard
									,self.SANC_BRDTYPE := ''
									,self:=left
									));
								
		sort_prep11	:= dedup(sort(distribute(prep11, hash(group_key, SANC_LICNBR)), group_key, SANC_LICNBR, local), record, local);
		sort_prep7a	:= dedup(sort(distribute(sort_prep7, hash(group_key, addr_key)), group_key, addr_key, local), record, local);

		EXPORT Sanctions_All := sort_prep7a + sort_prep11 :persist('~thor400_data::persist::Sanctions_All2');

		//////////////////////////////////////////////////////////
		// update_BWR_Sanctions_Did_File
		//////////////////////////////////////////////////////////
		outlayout  := {ingenix_natlprof.layout_sanctions_DID_RecID};

		prep1 := project(Sanctions_All,outlayout);

		EXPORT update_BWR_Sanctions_Did_File := prep1;

		//////////////////////////////////////////////////////////
		// Sanctioned_providers_Bdid
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.layout_sanctions_bdid,
										unsigned6 lnpid};

		prep1 := project(Sanctions_All,outlayout);

		EXPORT Sanctioned_providers_Bdid := prep1;

		//////////////////////////////////////////////////////////
		// ProviderSanctions_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key
									,Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_Allsrc};

		OutLayout tr1(Sanctions_all l) := transform
			self.processdate														:=	l.process_date;
			self.dt_vendor_first_reported	:=	l.date_first_reported;
			self.dt_vendor_last_reported		:=	l.date_last_reported;
			self.providerid															:=	l.sanc_id;
			self.SanctionDate													:=	l.sanc_sancdte	;
			self.SanctioningState									:=	l.sanc_sancst	;
			self.SanctionedLicenseNumber		:=	l.sanc_licnbr	;
			self.SanctionReason											:=	l.SANC_reas ;
			self.SanctioningBoardType					:=	l.SANC_BRDTYPE ;
			self.LastUpdate															:=	l.SANC_UPDTE_form	;

			self													:=	l;
			self													:=	[];
		end;

		prep1:=project(Sanctions_all,tr1(left));

		sort_prep1	:= sort(distribute(prep1, hash(group_key)), group_key, local);
		sort_InLic	:= sort(distribute(InLic, hash(group_key, lic_num_in)), group_key, lic_num_in, -dt_vendor_last_reported, local);
		
		prep2:=join(sort_prep1,dedup(sort_InLic,group_key,lic_num_in, local)
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

		outlayout  := {Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_Allsrc};

		prep1 := project(ProviderSanctions_all,outlayout);

		EXPORT update_ProviderSanctions := prep1;

		//////////////////////////////////////////////////////////
		// Provider_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key
									,string20 addr_key
									,ingenix_natlprof.Layout_provider_base_rid
									,string10 p2
									,string10 p3
									,string10 f1
									,string10 f2
									,string10 f3
									};

		OutLayout tr1(InIndi l) := transform
			self.did																:=	intformat(l.did,12,1);
			self.did_score										:=	(string)l.did_score;
			self.dt_first_seen						:=	(string)l.dt_first_seen;
			self.dt_last_seen							:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate								:=	(string)l.dt_vendor_last_reported;
			self.providerid									:=	(string)l.pid;

			self.lastname											:=	l.last_name;
			self.firstname										:=	l.first_name;
			self.middlename									:=	l.middle_name;
			self.suffix													:=	l.suffix_name;
			self.gender													:=	l.gender;

			self.prov_clean_title			:=	l.title;
			self.prov_clean_fname			:=	l.fname;
			self.prov_clean_mname			:=	l.mname;
			self.prov_clean_lname			:=	l.lname;
			self.prov_clean_name_suffix	:=	l.name_suffix;

			self.addressid										:=	l.Addr_key;

			self.Address												:=	trim(stringlib.stringcleanspaces(
																																trim(l.prim_range)
																																+' '+trim(l.predir)
																																+' '+trim(l.prim_name)
																																+' '+trim(l.addr_suffix)
																																+' '+trim(l.postdir)));
			self.Address2											:=	trim(stringlib.stringcleanspaces(trim(l.unit_desig)
																															+' '+trim(l.sec_range)));

			self.city															:=	l.v_city_name;
			self.state														:=	l.st;
			self.county													:=	l.fips_county;
			self.extzip													:=	l.zip4;
			self.latitude											:=	l.geo_lat;
			self.longitute										:=	l.geo_long;
			self.birthdate										:=	l.clean_dob;
			self.taxid														:=	l.clean_ssn;

			self.prov_clean_prim_range	:=	l.prim_range;
			self.prov_clean_predir					:=	l.predir;
			self.prov_clean_prim_name		:=	l.prim_name;
			self.prov_clean_addr_suffix:=	l.addr_suffix;
			self.prov_clean_postdir				:=	l.postdir;
			self.prov_clean_unit_desig	:=	l.unit_desig;
			self.prov_clean_sec_range		:=	l.sec_range;
			self.prov_clean_p_city_name:=	l.p_city_name;
			self.prov_clean_v_city_name:=	l.v_city_name;
			self.prov_clean_st									:=	l.st;
			self.prov_clean_zip								:=	l.zip;
			self.prov_clean_zip4							:=	l.zip4;
			self.prov_clean_cart							:=	l.cart;
			self.prov_clean_cr_sort_sz	:=	l.cr_sort_sz;
			self.prov_clean_lot								:=	l.lot;
			self.prov_clean_lot_order		:=	l.lot_order;
			self.prov_clean_dpbc							:=	l.dbpc;
			self.prov_clean_chk_digit		:=	l.chk_digit;
			self.prov_clean_record_type:=	l.rec_type;
			self.prov_clean_ace_fips_st:=	l.fips_st;
			self.prov_clean_fipscounty	:=	l.fips_county;
			self.prov_clean_geo_lat				:=	l.geo_lat;
			self.prov_clean_geo_long			:=	l.geo_long;
			self.prov_clean_msa								:=	l.msa;
			self.prov_clean_geo_match		:=	l.geo_match;
			self.prov_clean_err_stat			:=	l.err_stat;

			self.deceaseddate										:=	l.date_of_death;
			self.deceasedindicator					:=	if(self.deceaseddate<>'','Y','N');

			self												:=	l;
			self												:=	[];
		end;

		prep1:=project(InIndi,tr1(left));

		sort_prep1		:= sort(distribute(prep1, hash(group_key, addr_key)), group_key, addr_key, local);
		sort_InAddr	:= sort(distribute(InAddr, hash(group_key, addr_key)), group_key, addr_key, local);
		
		prep2a:=join(sort_prep1,sort_InAddr
							,left.group_key=right.group_key
							and left.addr_key=right.addr_key
							,transform(OutLayout
									,self.PhoneNumber:=if(left.group_key=right.group_key,right.clean_phone,'')
									,self.p2:=if(left.group_key=right.group_key,right.phone2,'')
									,self.p3:=if(left.group_key=right.group_key,right.phone3,'')
									,self.f1:=if(left.group_key=right.group_key,right.clean_fax,'')
									,self.f2:=if(left.group_key=right.group_key,right.fax2,'')
									,self.f3:=if(left.group_key=right.group_key,right.fax3,'')
									,self:=left),left outer);
									
		prep2	:= dedup(sort(distribute(prep2a, hash(group_key, addr_key, PhoneNumber, p2, p3, f1, f2, f3)), group_key, addr_key,
								PhoneNumber, p2, p3, f1, f2, f3, local), record, local);

		EXPORT Provider_all := prep2 : persist('~thor400_data::persist::Provider_all');

		//////////////////////////////////////////////////////////
		// Provider_did
		//////////////////////////////////////////////////////////

		outlayout  := {ingenix_natlprof.Layout_provider_base_rid};

		prep1 := project(Provider_all,outlayout);

		EXPORT Provider_did := prep1;

		//////////////////////////////////////////////////////////
		// License_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key
									,Ingenix_Natlprof.Layout_in_ProviderLicense.raw_srctype
									,string8  dt_first_seen
									,string8  dt_last_seen
									,string8  dt_vendor_first_reported
									,string8  dt_vendor_last_reported
									};

		OutLayout tr1(InLic l) := transform
			self.dt_first_seen				:=	(string)l.dt_first_seen;
			self.dt_last_seen					:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate						:=	(string)l.dt_vendor_last_reported;
			self.providerid							:=	(string)l.pid	;
			self.licensenumber				:=	l.lic_num_in	;
			self.licensestate					:=	l.lic_state	;
			self.effective_date			:=	l.lic_begin_date	;
			self.termination_date	:=	l.lic_end_date	;
			self									:=	l;
			self									:=	[];
		end;

		prep1:=project(InLic,tr1(left))(licensestate<>'',licensenumber<>'',length(stringlib.stringfilterout(trim(licensenumber,all),'0'))<>0);

		OutLayout tr2(InFac l) := transform
			self.dt_first_seen				:=	(string)l.dt_first_seen;
			self.dt_last_seen					:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate						:=	(string)l.dt_vendor_last_reported;
			self.providerid							:=	(string)l.pid;
			self.licensenumber				:=	l.lic_num_in;
			self.licensestate					:=	l.lic_state;
			self.effective_date			:=	l.lic_begin_date;
			self.termination_date	:=	l.lic_end_date;
			self									:=	l;
			self									:=	[];
		end;

		prep2:=project(InFac,tr2(left))(licensestate<>'',licensenumber<>'',length(stringlib.stringfilterout(trim(licensenumber,all),'0'))<>0);

		EXPORT License_all := dedup(prep1 + prep2,record,all) : persist('~thor400_data::persist::License_all');

		//////////////////////////////////////////////////////////
		// update_providerlicense
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_Natlprof.Layout_in_ProviderLicense.raw_srctype
									,string8  dt_first_seen
									,string8  dt_last_seen
									,string8  dt_vendor_first_reported
									,string8  dt_vendor_last_reported
									};

		prep1 := project(License_all,outlayout);

		EXPORT update_providerlicense := prep1;

		//////////////////////////////////////////////////////////
		// NPI_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key
									,string1 npi_type
									,Ingenix_Natlprof.Layout_in_ProviderNPI.raw_srctype
									,string	TaxonomyCode
									,string	PrimaryIndicator
									,string8	dt_first_seen
									,string8	dt_last_seen
									,string8	dt_vendor_first_reported
									,string8	dt_vendor_last_reported
									};

		OutLayout tr1(InNpi l) := transform
			self.dt_first_seen				:=	(string)l.dt_first_seen;
			self.dt_last_seen					:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate						:=	(string)l.dt_vendor_last_reported;
			self.providerid							:=	(string)l.pid;
			self.npi														:=	l.npi_num;
			self.npi_type									:=	l.npi_type;
			self.taxonomycode					:=	l.taxonomy;
			self.PrimaryIndicator	:=	l.taxonomy_primary_ind;
			self.enumerationdate		:=	l.npi_enum_date;
			self									:=	l;
			self									:=	[];
		end;

		prep1:=project(InNpi,tr1(left))(npi<>'');

		OutLayout tr2(InAsso l) := transform
			self.dt_first_seen					:=	(string)l.dt_first_seen;
			self.dt_last_seen						:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate							:=	(string)l.dt_vendor_last_reported;
			self.providerid								:=	(string)l.pid;
			self.npi															:=	l.bill_npi;
			self.npi_type										:=	'2';
			self									:=	l;
			self									:=	[];
		end;

		prep2:=project(InAsso,tr2(left))(npi<>'');

		EXPORT NPI_all := dedup(prep1 + prep2,record,all) : persist('~thor400_data::persist::NPI_all');

		//////////////////////////////////////////////////////////
		// update_NPI
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_Natlprof.Layout_in_ProviderNPI.raw_srctype
									,string	TaxonomyCode
									,string	PrimaryIndicator
									,string8	dt_first_seen
									,string8	dt_last_seen
									,string8	dt_vendor_first_reported
									,string8	dt_vendor_last_reported
									};

		prep1 := project(NPI_all(npi_type='1'),outlayout);

		EXPORT update_NPI := prep1;

		//////////////////////////////////////////////////////////
		// DEA_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key
									,Ingenix_Natlprof.Layout_in_ProviderDEA.raw_srctype
									,string8  dt_first_seen
									,string8  dt_last_seen
									,string8  dt_vendor_first_reported
									,string8  dt_vendor_last_reported
									};

		OutLayout tr1(InDea l) := transform
			self.dt_first_seen				:=	(string)l.dt_first_seen;
			self.dt_last_seen					:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate						:=	(string)l.dt_vendor_last_reported;
			self.providerid							:=	(string)l.pid;
			self.deanumber								:=	l.dea_num;
			self.addressid								:=	l.Addr_key;

			self									:=	l;
			self									:=	[];
		end;

		prep1:=project(InDea,tr1(left))(deanumber<>'');

		OutLayout tr2(InFac l) := transform
			self.dt_first_seen				:=	(string)l.dt_first_seen;
			self.dt_last_seen					:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate						:=	(string)l.dt_vendor_last_reported;
			self.providerid							:=	(string)l.pid;
			self.deanumber								:=	l.dea_num;
			self.addressid								:=	l.Addr_key;

			self									:=	l;
			self									:=	[];
		end;

		prep2:=project(InFac,tr2(left))(deanumber<>'');

		EXPORT DEA_all := dedup(prep1 + prep2,record,all) : persist('~thor400_data::persist::DEA_all');

		//////////////////////////////////////////////////////////
		// update_DEA
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_Natlprof.Layout_in_ProviderDEA.raw_srctype
									,string8  dt_first_seen
									,string8  dt_last_seen
									,string8  dt_vendor_first_reported
									,string8  dt_vendor_last_reported
									};

		prep1 := project(DEA_all,outlayout);

		EXPORT update_DEA := prep1;

		//////////////////////////////////////////////////////////
		// UPIN_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,Ingenix_Natlprof.Layout_in_ProviderUPIN.raw_srctype
									,string8  dt_first_seen
									,string8  dt_last_seen
									,string8  dt_vendor_first_reported
									,string8  dt_vendor_last_reported
									};

		OutLayout tr1(InIndi l) := transform
			self.dt_first_seen					:=	(string)l.dt_first_seen;
			self.dt_last_seen						:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate							:=	(string)l.dt_vendor_last_reported;
			self.providerid								:=	(string)l.pid;
			self.upin														:=	l.upin;

			self									:=	l;
			self									:=	[];
		end;

		prep1:=project(InIndi,tr1(left))(upin<>'');

		EXPORT UPIN_all := prep1 : persist('~thor400_data::persist::UPIN_all');

		//////////////////////////////////////////////////////////
		// update_UPIN
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_Natlprof.Layout_in_ProviderUPIN.raw_srctype
									,string8  dt_first_seen
									,string8  dt_last_seen
									,string8  dt_vendor_first_reported
									,string8  dt_vendor_last_reported
									};

		prep1 := project(UPIN_all,outlayout);

		EXPORT update_UPIN := prep1;

		//////////////////////////////////////////////////////////
		// Group_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,ingenix_natlprof.Layout_Group_Base_BIP};

		OutLayout tr1(InAsso l) := transform
			self.dt_first_seen					:=	(string)l.dt_first_seen;
			self.dt_last_seen						:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate							:=	(string)l.dt_vendor_last_reported;
			self.providerid								:=	(string)l.pid;
			self.grouppracticeid			:=	fn_scale_gk(l.sloc_group_key);
			self.GroupName									:=	l.Prepped_name;
			self.PhoneNumber							:=	l.clean_phone;
			self.addressid									:=	l.Addr_key;
			self.address											:=	trim(StringLib.StringCleanSpaces(
																															l.prim_range
																															+' '+l.predir
																															+' '+l.prim_name
																															+' '+l.addr_suffix
																															+' '+l.postdir
																															+' '+l.unit_desig
																															+' '+l.sec_range));
			self.city														:=	l.v_city_name;
			self.state													:=	l.st;
			self.extzip												:=	l.zip4;
			self.Latitude										:=	l.geo_lat;
			self.Longitude									:=	l.geo_long;
			self.taxid													:=	l.bill_tin;
			self.bdid														:=	intformat(l.bdid,12,1);
			self.bdid_score								:=	intformat(l.bdid_score,3,1);

			self									:=	l;
			self									:=	[];
		end;

		prep1:=project(InAsso,tr1(left));

		EXPORT Group_all := prep1 : persist('~thor400_data::persist::Group_all');

		//////////////////////////////////////////////////////////
		// Group_BDID
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.Layout_Group_Base_BIP};

		prep1 := project(Group_all,outlayout);

		EXPORT Group_BDID := prep1;

		//////////////////////////////////////////////////////////
		// Speciality_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key
									,string  FILETYP
									,string  PROCESSDATE
									,string	ProviderID
									,string	SpecialityID
									,string	SpecialtyCompanyCount
									,string	SpecialtyTierTypeID
									,string	SpecialityName
									,string	SpecialityGroupID
									,string	SpecialityGroupName
									,string8  dt_first_seen
									,string8  dt_last_seen
									,string8  dt_vendor_first_reported
									,string8  dt_vendor_last_reported
									};

		OutLayout tr1(InSpec l) := transform
			self.dt_first_seen							:=	(string)l.dt_first_seen;
			self.dt_last_seen								:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate									:=	(string)l.dt_vendor_last_reported;
			self.providerid										:=	(string)l.pid	;
			self.specialityid								:=	l.spec_code	;
			self.specialityname						:=	l.spec_desc	;
			self.specialitygroupid			:=	l.spec_code	;
			self.specialitygroupname	:=	l.spec_desc	;

			self											:=	l;
			self											:=	[];
		end;

		prep1:=project(InSpec,tr1(left))(specialityid<>'');

		prep2:=join(InFac(specialization<>''),dedup(InSpec,spec_desc,all)
							,left.specialization=right.spec_desc
							,transform(OutLayout
									,self.dt_first_seen	:=	(string)left.dt_first_seen;
									,self.dt_last_seen		:=	(string)left.dt_last_seen;
									,self.dt_vendor_first_reported	:=	(string)left.dt_vendor_first_reported;
									,self.dt_vendor_last_reported		:=	(string)left.dt_vendor_last_reported;
									,self.processdate			:=	(string)left.dt_vendor_last_reported;
									,self.providerid				:=	(string)left.pid;
									,self.specialityid		:=right.spec_code
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

		outlayout  := {string  FILETYP
									,string  PROCESSDATE
									,string	ProviderID
									,string	SpecialityID
									,string	SpecialtyCompanyCount
									,string	SpecialtyTierTypeID
									,string	SpecialityName
									,string	SpecialityGroupID
									,string	SpecialityGroupName
									,string8  dt_first_seen
									,string8  dt_last_seen
									,string8  dt_vendor_first_reported
									,string8  dt_vendor_last_reported
									};

		prep1 := project(Speciality_all,outlayout);

		EXPORT File_in_Provider_Speciality_Joined := prep1;

		//////////////////////////////////////////////////////////
		// Hospital_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,ingenix_natlprof.Layout_Hospital_Base_BIP};

		OutLayout tr1(InFac l) := transform
			self.dt_first_seen							:=	(string)l.dt_first_seen;
			self.dt_last_seen								:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate									:=	(string)l.dt_vendor_last_reported;
			self.providerid										:=	(string)l.pid;
			self.PhoneNumber									:=	l.clean_phone;
			self.MedicareProviderID		:=	l.Medicare_fac_num;
			self.HospitalName								:=	l.prac_company_name;
			self.ServiceCodeDescription	:=	l.classification;
			self.addressid											:=	l.Addr_key;
			self.address													:=	trim(StringLib.StringCleanSpaces(
																																l.prim_range
																																+' '+l.predir
																																+' '+l.prim_name
																																+' '+l.addr_suffix
																																+' '+l.postdir
																																+' '+l.unit_desig
																																+' '+l.sec_range));
			self.city																:=	l.v_city_name;
			self.state															:=	l.st;
			self.extzip														:=	l.zip4;
			self.Latitude												:=	l.geo_lat;
			self.Longitude											:=	l.geo_long;
			self.bdid																:=	intformat(l.bdid,12,1);
			self.bdid_score										:=	intformat(l.bdid_score,3,1);

			self												:=	l;
			self												:=	[];
		end;

		prep1:=project(InFac(type1='HOSPITALS'),tr1(left));

		EXPORT Hospital_all := prep1 : persist('~thor400_data::persist::Hospital_all');

		//////////////////////////////////////////////////////////
		// Hospital_BDID
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.Layout_Hospital_Base_BIP};

		prep1 := project(Hospital_all,outlayout);

		EXPORT Hospital_BDID := dedup(prep1,all);

		//////////////////////////////////////////////////////////
		// Medschool_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key,ingenix_natlprof.Layout_Medschool_Base_BIP};

		OutLayout tr1(InMSch l) := transform
			self.dt_first_seen					:=	(string)l.dt_first_seen;
			self.dt_last_seen						:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate							:=	(string)l.dt_vendor_last_reported;
			self.providerid								:=	(string)l.pid;
			self.MedSchoolName					:=	l.MedSchool;
			self.GraduationYear				:=	l.MedSchool_year;

			self										:=	l;
			self										:=	[];
		end;

		prep1:=project(InMSch,tr1(left));
		
		sort_prep1		:= sort(distribute(prep1, hash(group_key)), group_key, local);
		sort_InIndi	:= sort(distribute(InIndi(bdid > 0), hash(group_key)), group_key, -dt_vendor_last_reported, local);

		prep2:=join(dedup(sort_prep1,all),sort_InIndi
							,left.group_key=right.group_key
							,transform({prep1}
								,self.bdid							:= if(left.group_key=right.group_key,intformat(right.bdid,12,1),left.bdid);
								,self.bdid_score	:= if(left.group_key=right.group_key,intformat(right.bdid_score,3,1),left.bdid_score);
								,self.DotID						:= if(left.group_key=right.group_key,right.DotID,left.DotID);
								,self.DotScore			:= if(left.group_key=right.group_key,right.DotScore,left.DotScore);
								,self.DotWeight		:= if(left.group_key=right.group_key,right.DotWeight,left.DotWeight);
								,self.EmpID						:= if(left.group_key=right.group_key,right.EmpID,left.EmpID);
								,self.EmpScore			:= if(left.group_key=right.group_key,right.EmpScore,left.EmpScore);
								,self.EmpWeight		:= if(left.group_key=right.group_key,right.EmpWeight,left.EmpWeight);
								,self.POWID						:= if(left.group_key=right.group_key,right.POWID,left.POWID);
								,self.POWScore			:= if(left.group_key=right.group_key,right.POWScore,left.POWScore);
								,self.POWWeight		:= if(left.group_key=right.group_key,right.POWWeight,left.POWWeight);
								,self.ProxID					:= if(left.group_key=right.group_key,right.ProxID,left.ProxID);
								,self.ProxScore		:= if(left.group_key=right.group_key,right.ProxScore,left.ProxScore);
								,self.ProxWeight	:= if(left.group_key=right.group_key,right.ProxWeight,left.ProxWeight);
								,self.SELEID					:= if(left.group_key=right.group_key,right.SELEID,left.SELEID);
								,self.SELEScore		:= if(left.group_key=right.group_key,right.SELEScore,left.SELEScore);
								,self.SELEWeight	:= if(left.group_key=right.group_key,right.SELEWeight,left.SELEWeight);	
								,self.OrgID						:= if(left.group_key=right.group_key,right.OrgID,left.OrgID);
								,self.OrgScore			:= if(left.group_key=right.group_key,right.OrgScore,left.OrgScore);
								,self.OrgWeight		:= if(left.group_key=right.group_key,right.OrgWeight,left.OrgWeight);
								,self.UltID						:= if(left.group_key=right.group_key,right.UltID,left.UltID);
								,self.UltScore			:= if(left.group_key=right.group_key,right.UltScore,left.UltScore);
								,self.UltWeight		:= if(left.group_key=right.group_key,right.UltWeight,left.UltWeight);	
								,self:=left),left outer, local);
								
		sort_prep2		:= sort(distribute(prep2, hash(group_key)), group_key, local);
		sort_InAsso	:= sort(distribute(InAsso(bdid > 0), hash(group_key)), group_key, -dt_vendor_last_reported, local);

		prep3:=join(dedup(sort_prep2,all),sort_InAsso
							,left.group_key=right.group_key
							,transform({prep1}
								,self.bdid							:= if(left.group_key=right.group_key,intformat(right.bdid,12,1),left.bdid);
								,self.bdid_score	:= if(left.group_key=right.group_key,intformat(right.bdid_score,3,1),left.bdid_score);
								,self.DotID						:= if(left.group_key=right.group_key,right.DotID,left.DotID);
								,self.DotScore			:= if(left.group_key=right.group_key,right.DotScore,left.DotScore);
								,self.DotWeight		:= if(left.group_key=right.group_key,right.DotWeight,left.DotWeight);
								,self.EmpID						:= if(left.group_key=right.group_key,right.EmpID,left.EmpID);
								,self.EmpScore			:= if(left.group_key=right.group_key,right.EmpScore,left.EmpScore);
								,self.EmpWeight		:= if(left.group_key=right.group_key,right.EmpWeight,left.EmpWeight);
								,self.POWID						:= if(left.group_key=right.group_key,right.POWID,left.POWID);
								,self.POWScore			:= if(left.group_key=right.group_key,right.POWScore,left.POWScore);
								,self.POWWeight		:= if(left.group_key=right.group_key,right.POWWeight,left.POWWeight);
								,self.ProxID					:= if(left.group_key=right.group_key,right.ProxID,left.ProxID);
								,self.ProxScore		:= if(left.group_key=right.group_key,right.ProxScore,left.ProxScore);
								,self.ProxWeight	:= if(left.group_key=right.group_key,right.ProxWeight,left.ProxWeight);
								,self.SELEID					:= if(left.group_key=right.group_key,right.SELEID,left.SELEID);
								,self.SELEScore		:= if(left.group_key=right.group_key,right.SELEScore,left.SELEScore);
								,self.SELEWeight	:= if(left.group_key=right.group_key,right.SELEWeight,left.SELEWeight);	
								,self.OrgID						:= if(left.group_key=right.group_key,right.OrgID,left.OrgID);
								,self.OrgScore			:= if(left.group_key=right.group_key,right.OrgScore,left.OrgScore);
								,self.OrgWeight		:= if(left.group_key=right.group_key,right.OrgWeight,left.OrgWeight);
								,self.UltID						:= if(left.group_key=right.group_key,right.UltID,left.UltID);
								,self.UltScore			:= if(left.group_key=right.group_key,right.UltScore,left.UltScore);
								,self.UltWeight		:= if(left.group_key=right.group_key,right.UltWeight,left.UltWeight);	
								,self:=left),left outer, local);

		sort_prep3		:= sort(distribute(prep3, hash(group_key)), group_key, local);
		sort_InFac		:= sort(distribute(InFac(bdid > 0), hash(group_key)), group_key, -dt_vendor_last_reported, local);
		
		prep4:=join(dedup(sort_prep3,all),sort_InFac
							,left.group_key=right.group_key
							,transform({prep1}
								,self.bdid							:= if(left.group_key=right.group_key,intformat(right.bdid,12,1),left.bdid);
								,self.bdid_score	:= if(left.group_key=right.group_key,intformat(right.bdid_score,3,1),left.bdid_score);
								,self.DotID						:= if(left.group_key=right.group_key,right.DotID,left.DotID);
								,self.DotScore			:= if(left.group_key=right.group_key,right.DotScore,left.DotScore);
								,self.DotWeight		:= if(left.group_key=right.group_key,right.DotWeight,left.DotWeight);
								,self.EmpID						:= if(left.group_key=right.group_key,right.EmpID,left.EmpID);
								,self.EmpScore			:= if(left.group_key=right.group_key,right.EmpScore,left.EmpScore);
								,self.EmpWeight		:= if(left.group_key=right.group_key,right.EmpWeight,left.EmpWeight);
								,self.POWID						:= if(left.group_key=right.group_key,right.POWID,left.POWID);
								,self.POWScore			:= if(left.group_key=right.group_key,right.POWScore,left.POWScore);
								,self.POWWeight		:= if(left.group_key=right.group_key,right.POWWeight,left.POWWeight);
								,self.ProxID					:= if(left.group_key=right.group_key,right.ProxID,left.ProxID);
								,self.ProxScore		:= if(left.group_key=right.group_key,right.ProxScore,left.ProxScore);
								,self.ProxWeight	:= if(left.group_key=right.group_key,right.ProxWeight,left.ProxWeight);
								,self.SELEID					:= if(left.group_key=right.group_key,right.SELEID,left.SELEID);
								,self.SELEScore		:= if(left.group_key=right.group_key,right.SELEScore,left.SELEScore);
								,self.SELEWeight	:= if(left.group_key=right.group_key,right.SELEWeight,left.SELEWeight);	
								,self.OrgID						:= if(left.group_key=right.group_key,right.OrgID,left.OrgID);
								,self.OrgScore			:= if(left.group_key=right.group_key,right.OrgScore,left.OrgScore);
								,self.OrgWeight		:= if(left.group_key=right.group_key,right.OrgWeight,left.OrgWeight);
								,self.UltID						:= if(left.group_key=right.group_key,right.UltID,left.UltID);
								,self.UltScore			:= if(left.group_key=right.group_key,right.UltScore,left.UltScore);
								,self.UltWeight		:= if(left.group_key=right.group_key,right.UltWeight,left.UltWeight);	
								,self:=left),left outer, local);

		EXPORT Medschool_all := dedup(prep4,all) : persist('~thor400_data::persist::Medschool_all');

		//////////////////////////////////////////////////////////
		// Medschool_BDID
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.Layout_Medschool_Base_BIP};

		prep1 := project(Medschool_all,outlayout);

		EXPORT Medschool_BDID := prep1;

		//////////////////////////////////////////////////////////
		// Degree_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key
									,Ingenix_Natlprof.Layout_in_ProviderDegree.raw_srctype
									,string8  dt_first_seen
									,string8  dt_last_seen
									,string8  dt_vendor_first_reported
									,string8  dt_vendor_last_reported
									};

		OutLayout tr1(InIndi l) := transform
			self.dt_first_seen						:=	(string)l.dt_first_seen;
			self.dt_last_seen							:=	(string)l.dt_last_seen;
			self.dt_vendor_first_reported	:=	(string)l.dt_vendor_first_reported;
			self.dt_vendor_last_reported		:=	(string)l.dt_vendor_last_reported;
			self.processdate								:=	(string)l.dt_vendor_last_reported;
			self.providerid									:=	(string)l.pid;
			self.Degree													:=	l.suffix_other;
			self													:=	l;
			self													:=	[];
		end;
		
		temp_degree	:= project(InIndi,tr1(left))(Degree<>'');
		sort_InIndi	:= sort(distribute(temp_degree, hash(providerid, degree, processdate, filetyp, degreecompanycount, degreetiertypeid)), 
										providerid, degree, processdate, filetyp, degreecompanycount, degreetiertypeid, local);
												
		Outlayout t_rollup (sort_inIndi L, sort_InIndi R) := transform
			SELF.dt_first_seen            := (STRING)ut.EarliestDate ((INTEGER)L.dt_first_seen, (INTEGER)R.dt_first_seen);
			SELF.dt_last_seen             := (STRING)max((INTEGER)L.dt_last_seen, 	(INTEGER)R.dt_last_seen);
			SELF.dt_vendor_first_reported := (STRING)ut.EarliestDate((INTEGER)L.dt_vendor_first_reported, (INTEGER)R.dt_vendor_first_reported);
			SELF.dt_vendor_last_reported  := (STRING)max((INTEGER)L.dt_vendor_last_reported,  (INTEGER)R.dt_vendor_last_reported);
			SELF						 							:= L;
		END;

		new_degree := rollup(
							sort_InIndi,
									LEFT.providerid											= RIGHT.providerid
							AND LEFT.degree													= RIGHT.degree
							AND LEFT.processdate								= RIGHT.processdate
							AND LEFT.filetyp												= RIGHT.filetyp
							AND LEFT.degreecompanycount	= RIGHT.degreecompanycount
							AND LEFT.degreetiertypeid			= RIGHT.degreetiertypeid
            ,t_rollup(LEFT, RIGHT),LOCAL);

		// prep1:=project(InIndi,tr1(left))(Degree<>''): persist('~thor400_data::persist::Degree_all');
		prep1:=new_degree: persist('~thor400_data::persist::Degree_all');

		EXPORT Degree_all := dedup(prep1,record,all);

		//////////////////////////////////////////////////////////
		// update_degree
		//////////////////////////////////////////////////////////

		OutLayout  := {Ingenix_Natlprof.Layout_in_ProviderDegree.raw_srctype
									,string8  dt_first_seen
									,string8  dt_last_seen
									,string8  dt_vendor_first_reported
									,string8  dt_vendor_last_reported
									};

		prep1 := project(Degree_all,OutLayout);

		EXPORT update_degree := prep1;

		//////////////////////////////////////////////////////////
		// Residency_BDID
		//////////////////////////////////////////////////////////

		OutLayout  := {ingenix_natlprof.Layout_Residency_Base_BIP};

		prep1 := dataset([],OutLayout);

		EXPORT Residency_BDID := prep1;

		//////////////////////////////////////////////////////////
		// update_language
		//////////////////////////////////////////////////////////

		OutLayout  := {Ingenix_Natlprof.Layout_in_ProviderLanguage.raw_srctype
									,string8  dt_first_seen
									,string8  dt_last_seen
									,string8  dt_vendor_first_reported
									,string8  dt_vendor_last_reported
									};

		prep1 := dataset([],OutLayout);

		EXPORT update_language := prep1;

END;