IMPORT ingenix_natlprof;

EXPORT As_Ingenix (STRING filedate, boolean pUseProd = false) := MODULE

		SHARED InSanc  := Enclarity_Facility_Sanctions.Files(,pUseProd).facility_sanctions_base.qa(record_type='C');
		SHARED InSanCd := Enclarity_Facility_Sanctions.Sanction_Code_Lookup.dsSancLookup;
		SHARED InSanBrd:= Enclarity_Facility_Sanctions.Sanction_Code_Lookup.dsBoardLookup;
		
		//////////////////////////////////////////////////////////
		// Sanctions_All
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 surrogate_key
									,string38 group_key
									,string20 prac1_key
									,Ingenix_NatlProf.Sanctioned_providers_Bdid};

		OutLayout tr1(InSanc l) 		:= transform
			self.surrogate_key									:= 	l.surrogate_key;
			self.group_key											:=	l.group_key;
			self.prac1_key											:=	l.prac1_key;
			self.bdid														:=	l.bdid;
			self.bdid_score											:=	l.bdid_score;
			self.process_date										:=	(string)l.date_vendor_last_reported;
			self.date_first_seen								:=	(string)l.date_first_seen;
			self.date_last_seen									:=	(string)l.date_last_seen;
			self.date_first_reported						:=	(string)l.date_vendor_first_reported;
			self.date_last_reported							:=	(string)l.date_vendor_last_reported;
			self.did														:=	'';
			self.filetyp												:=	l.filecode; // temp hold for board info later - from lookup table <-------OVERLOADED FIELD
			self.SANC_ID												:=	(string)l.lnfid;
			self.sanc_lnme											:=	'';
			self.sanc_fnme											:=	'';
			self.sanc_mid_i_nm									:=	'';
			self.sanc_busnme										:=	l.clean_company_name;
			self.sanc_dob												:=	'';
			self.SANC_STREET										:= 	trim(stringlib.stringcleanspaces(
																								trim(l.clean_prac1_prim_range)
																								+' '+trim(l.clean_prac1_predir)
																								+' '+trim(l.clean_prac1_prim_name)
																								+' '+trim(l.clean_prac1_addr_suffix)
																								+' '+trim(l.clean_prac1_postdir)
																								+' '+trim(l.clean_prac1_unit_desig)
																								+' '+trim(l.clean_prac1_sec_range)));
			self.SANC_CITY  											:=	l.clean_prac1_v_city_name;
			self.SANC_STATE												:=	l.clean_prac1_st;
			self.SANC_ZIP 												:=	l.clean_prac1_zip;
			self.SANC_CNTRY												:=	'';
			self.sanc_tin													:=	l.tin1;
			self.sanc_upin												:=	'';
			self.SANC_PROVTYPE										:=	l.facility_type	;
			self.SANC_SANCDTE_form								:=	'';
			self.SANC_SANCDTE	 										:=	l.clean_sanc1_date;
			self.SANC_SANCST											:=	l.sanc1_state	;
			self.SANC_LICNBR											:=	if(length(stringlib.stringfilterout(trim(l.lic1_num,all),'0'))<>0,l.lic1_num,'')	;
			self.sanc_brdtype											:=	''; // will get from lookup table later
			self.SANC_SRC_DESC										:=	''; // will get from lookup table later
			self.SANC_TYPE 												:=	trim(stringlib.stringcleanspaces(Stringlib.StringToUpperCase(l.sanc1_complaint)));
			self.SANC_REAS 												:= 	trim(stringlib.stringcleanspaces(Stringlib.StringToUpperCase(l.sanc1_description_ef)));
			self.SANC_TERMS												:=	trim(stringlib.stringcleanspaces(Stringlib.StringToUpperCase(l.sanc1_terms_ef)));
			self.SANC_COND 												:=	trim(stringlib.stringcleanspaces(Stringlib.StringToUpperCase(l.sanc1_condition_ef)));
			self.SANC_FINES												:=	trim(stringlib.stringcleanspaces(Stringlib.StringToUpperCase(l.sanc1_fine_ef)));
			self.SANC_FAB 												:= 'FALSE';
			self.SANC_UPDTE_form									:=	'';
			self.SANC_UPDTE												:=	'';
			self.SANC_REINDTE_form								:= 	'';
			//If it is a reinstatement, then the sanction data is really a reinstate date
			cleanCode 														:=	trim(l.sanc1_complaint,left,right);
			lastCharacter 												:=	cleanCode[length(cleanCode)];
			isReinstatement 											:=	if(lastCharacter='R',true,false);
			self.SANC_REINDTE	 										:=	if((unsigned)l.clean_sanc1_rein_date>0,l.clean_sanc1_rein_date,l.LN_derived_rein_date);
			self.SANC_UNAMB_IND 									:=	''; // will get from lookup table later
			self.prov_clean_title									:=	'';
			self.prov_clean_fname									:=	'';
			self.prov_clean_mname									:=	'';
			self.prov_clean_lname									:=	'';
			self.prov_clean_name_suffix						:=	'';
			self.prov_clean_cleaning_score				:=	'';
			self.provco_address_clean_prim_range	:=	l.clean_prac1_prim_range;
			self.provco_address_clean_predir			:=	l.clean_prac1_predir;
			self.provco_address_clean_prim_name		:=	l.clean_prac1_prim_name;
			self.provco_address_clean_addr_suffix	:=	l.clean_prac1_addr_suffix;
			self.provco_address_clean_postdir			:=	l.clean_prac1_postdir;
			self.provco_address_clean_unit_desig	:=	l.clean_prac1_unit_desig;
			self.provco_address_clean_sec_range		:=	l.clean_prac1_sec_range;
			self.provco_address_clean_p_city_name	:=	l.clean_prac1_p_city_name;
			self.provco_address_clean_v_city_name	:=	l.clean_prac1_v_city_name;
			self.provco_address_clean_st					:=	l.clean_prac1_st;
			self.provco_address_clean_zip					:=	l.clean_prac1_zip;
			self.provco_address_clean_zip4				:=	l.clean_prac1_zip4;
			self.provco_address_clean_cart				:=	l.clean_prac1_cart;
			self.provco_address_clean_cr_sort_sz	:=	l.clean_prac1_cr_sort_sz;
			self.provco_address_clean_lot					:=	l.clean_prac1_lot;
			self.provco_address_clean_lot_order		:=	l.clean_prac1_lot_order;
			self.provco_address_clean_dpbc				:=	l.clean_prac1_dbpc;
			self.provco_address_clean_chk_digit		:=	l.clean_prac1_chk_digit;
			self.provco_address_clean_record_type	:=	l.clean_prac1_rec_type;
			self.provco_address_clean_ace_fips_st	:=	l.clean_prac1_fips_st;
			self.provco_address_clean_fipscounty	:=	l.clean_prac1_fips_county;
			self.provco_address_clean_geo_lat			:=	l.clean_prac1_geo_lat;
			self.provco_address_clean_geo_long		:=	l.clean_prac1_geo_long;
			self.provco_address_clean_msa					:=	l.clean_prac1_msa;
			self.provco_address_clean_geo_match		:=	l.clean_prac1_geo_match;
			self.provco_address_clean_err_stat		:=	l.clean_prac1_err_stat;
			self.source_rec_id										:=	l.source_rid;
			self.DerivedReinstateDate							:=	if(l.LN_derived_rein_flag,l.LN_derived_rein_date,'');
			self.DotID														:=	l.DotID;
			self.DotScore													:=	l.DotScore;
			self.DotWeight												:=	l.DotWeight;
			self.EmpID														:=	l.EmpID;
			self.EmpScore													:=	l.EmpScore;
			self.EmpWeight												:=	l.EmpWeight;
			self.POWID														:= 	l.POWID;
			self.POWScore													:=	l.POWScore;
			self.POWWeight												:=	l.POWWeight;
			self.ProxID														:=	l.ProxID;
			self.ProxScore												:=	l.ProxScore;
			self.ProxWeight												:=	l.ProxWeight;
			self.SELEID														:=	l.SELEID;
			self.SELEScore												:=	l.SELEScore;
			self.SELEWeight												:=	l.SELEWeight;	
			self.OrgID														:=	l.OrgID;
			self.OrgScore													:=	l.OrgScore;
			self.OrgWeight												:=	l.OrgWeight;
			self.UltID														:=	l.UltID;
			self.UltScore													:=	l.UltScore;
			self.UltWeight												:=	l.UltWeight;	
			self																	:=	l;
			self																	:=	[];
		end;

		prep1:=project(InSanc,tr1(left));
		
		prep2:=join(prep1,InSanCd
							,left.SANC_TYPE = right.code 
							,transform({prep1}
									,self.SANC_UNAMB_IND	:= if(right.severity = '1','TRUE','FALSE')
									,self:=left
									)
							,left outer
							,lookup);
							
		prep3:=join(prep2,InSanBrd
							,left.filetyp=right.filecode //note:overloaded filetyp for temp use above
							,transform({prep1}
									,self.SANC_SRC_DESC := trim(Stringlib.StringToUpperCase(right.BoardName))
									,self.SANC_BRDTYPE 	:= trim(Stringlib.StringToUpperCase(right.BoardType))
									,self.filetyp				:= ''
									,self:=left
									)
							,left outer
							,lookup);

		EXPORT Sanctions_All := dedup(prep3,record,all) :persist('~thor400_data::persist::Facility_Sanctions_All');

		//////////////////////////////////////////////////////////
		// Sanctioned_facilities_Bdid
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.Sanctioned_providers_Bdid};

		prep1 := project(Sanctions_All,outlayout);

		EXPORT Sanctioned_facilities_Bdid := prep1;

		//////////////////////////////////////////////////////////
		// ProviderSanctions_all
		//////////////////////////////////////////////////////////

		OutLayout  := {string38 group_key
									,string10 sanc_type
									,Ingenix_NatlProf.update_ProviderSanctions};

		OutLayout tr1(Sanctions_all l) := transform
			self.processdate								:=	l.process_date;
			self.dt_vendor_first_reported		:=	l.date_first_reported;
			self.dt_vendor_last_reported		:=	l.date_last_reported;
			self.providerid									:=	l.sanc_id;
			self.SanctionDate								:=	l.sanc_sancdte	;
			self.SanctioningState						:=	l.sanc_sancst	;
			self.SanctionedLicenseNumber		:=	l.sanc_licnbr	;
			self.SanctionReason							:=	l.SANC_reas ;
			self.SanctioningBoardType				:=	l.SANC_BRDTYPE ;
			self.LastUpdate									:=	l.SANC_UPDTE_form	;
			self														:=	l;
			self														:=	[];
		end;

		prep1:=project(Sanctions_all,tr1(left));
		
		prep2:=join(prep1,InSanCd
							,left.sanc_type = right.code 
							,transform({prep1}
									,self.LossOfLicenseIndicator	:= if(right.severity = '1','Y','N')
									,self:=left
									)
							,left outer
							,lookup);

		EXPORT ProviderSanctions_all := prep2 : persist('~thor400_data::persist::FacilitySanctions_all');

		//////////////////////////////////////////////////////////
		// update_ProviderSanctions
		//////////////////////////////////////////////////////////

		outlayout  := {Ingenix_NatlProf.update_ProviderSanctions};

		prep1 := project(ProviderSanctions_all,outlayout);

		EXPORT update_ProviderSanctions := prep1;

END;