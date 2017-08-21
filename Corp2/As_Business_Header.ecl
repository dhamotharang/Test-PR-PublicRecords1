import Business_Header, ut,mdr, prte2_Corp;

export As_Business_Header :=
module

	#OPTION('multiplePersistInstances',FALSE);
	
	export fAs_Business_Header(
	
		dataset(Layout_Corporate_Direct_Corp_Base) pInput, Boolean isPRCT=False
	
	) :=
	function

		//*************************************************************************
		// Translate Corporate Direct to Common Business Header Format
		//*************************************************************************

		corp_base_unp := pInput(corp_legal_name not in ['X','SAME','NATIONAL REGISTERED AGENTS, INC.','NATIONAL REGISTERED AGENTS']);

		Layout_Corp_Local :=
		record
			unsigned6 record_id := 0;
			Layout_Corporate_Direct_Corp_Base;
		end;

		// Add unique record id to Corporate file
		Layout_Corp_Local AddRecordID(Layout_Corporate_Direct_Corp_Base L, unsigned4 cnt) :=
		transform
			self.record_id	:= cnt;
			self						:= L;
		end;

		Corp_Seq := project(corp_base_unp, AddRecordID(left,counter));

		Business_Header.Layout_Business_Header_New  Translate_Corporate_to_BHF(Layout_Corp_Local l, integer c) :=
		transform
		  SELF.bdid  			              := If(IsPRCT,(integer)l.BDID,0);
		  self.vl_id                    := l.corp_key;
			self.group1_id								:= L.record_id;
			self.vendor_id								:= l.corp_key;
			self.phone										:= (unsigned6)l.corp_phone10;
			self.phone_score							:= if(l.corp_phone10 <> '', 1, 0);
			self.source										:= MDR.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin);
			self.source_group							:= l.corp_key;
			self.company_name							:= Stringlib.StringToUpperCase(l.corp_legal_name);
			self.prim_range								:= choose(c, 						l.corp_addr1_prim_range	, 						l.corp_addr2_prim_range		);
			self.predir										:= choose(c, 						l.corp_addr1_predir			,							l.corp_addr2_predir				);
			self.prim_name								:= choose(c, 						l.corp_addr1_prim_name	, 						l.corp_addr2_prim_name		);
			self.addr_suffix							:= choose(c, 						l.corp_addr1_addr_suffix,							l.corp_addr2_addr_suffix	);
			self.postdir									:= choose(c, 						l.corp_addr1_postdir		, 						l.corp_addr2_postdir			);
			self.unit_desig								:= choose(c, 						l.corp_addr1_unit_desig	, 						l.corp_addr2_unit_desig		);
			self.sec_range								:= choose(c, 						l.corp_addr1_sec_range	, 						l.corp_addr2_sec_range		);
			self.city											:= choose(c, 						l.corp_addr1_v_city_name, 						l.corp_addr2_v_city_name	);
			self.state										:= choose(c, 						l.corp_addr1_state			,							l.corp_addr2_state				);
			self.zip											:= choose(c, (UNSIGNED3)l.corp_addr1_zip5				, (UNSIGNED3)	l.corp_addr2_zip5					);
			self.zip4											:= choose(c, (UNSIGNED2)l.corp_addr1_zip4				, (UNSIGNED2)	l.corp_addr2_zip4					);
			self.county										:= choose(c, 						l.corp_addr1_county			, 						l.corp_addr2_county				);
			self.msa											:= choose(c, 						l.corp_addr1_msa				, 						l.corp_addr2_msa					);
			self.geo_lat									:= choose(c, 						l.corp_addr1_geo_lat		, 						l.corp_addr2_geo_lat			);
			self.geo_long									:= choose(c, 						l.corp_addr1_geo_long		, 						l.corp_addr2_geo_long			);
			self.dt_first_seen						:= l.dt_first_seen;
			self.dt_last_seen							:= l.dt_last_seen;
			self.dt_vendor_first_reported := l.dt_vendor_first_reported ;
			self.dt_vendor_last_reported	:= l.dt_vendor_last_reported	;
			self.fein											:= if(Business_Header.ValidFEIN((unsigned4) stringLib.stringFilter(l.corp_fed_tax_id, '0123456789')), (unsigned4)stringLib.stringFilter(l.corp_fed_tax_id, '0123456789'), 0);
			self.current									:= if(L.record_type = 'C', true, false);		    
		end;

		from_corporate_norm := normalize(Corp_Seq, 2, Translate_Corporate_to_BHF(left, counter));

		from_corporate_norm_dist := distribute(from_corporate_norm, hash(group1_id, ut.CleanCompany(company_name)));
		from_corporate_norm_sort := sort(from_corporate_norm_dist, group1_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

		Business_Header.Layout_Business_Header_New RollupCorporateNorm(Business_Header.Layout_Business_Header_New l, Business_Header.Layout_Business_Header_New r) := transform
		self := l;
		end;

		from_corporate_norm_rollup := rollup(
			from_corporate_norm_sort
			,		left.group1_id = right.group1_id
			and ut.CleanCompany(left.company_name) = ut.CleanCompany(right.company_name)
			and (
				(			left.zip 				= right.zip
					and left.prim_name 	= right.prim_name
					and left.prim_range = right.prim_range
					and left.city				= right.city
					and left.state			= right.state
				)
				or
				(			right.zip					= 0
					and right.prim_name		= ''
					and right.prim_range	= ''
					and right.city				= ''
					and right.state				= ''
				)
			)
			,RollupCorporateNorm(left, right)
			,local);

		// Calculate stat to determine count by group_id
		Layout_Group_List := record
		from_corporate_norm_rollup.group1_id;
		end;

		corp_group_list := table(from_corporate_norm_rollup, Layout_Group_List);

		Layout_Group_Stat := record
		corp_group_list.group1_id;
		cnt := count(group);
		end;

		corp_group_stat := table(corp_group_list, Layout_Group_Stat, group1_id);

		// Clean single group ids and format
		Business_Header.Layout_Business_Header_New FormatToBHF(Business_Header.Layout_Business_Header_New L, Layout_Group_Stat R) := TRANSForM
		self.group1_id := R.group1_id;
		SELF := L;
		END;

		corp_group_clean := join(from_corporate_norm_rollup,
								 corp_group_stat(cnt > 1),
								 left.group1_id = right.group1_id,
								 FormatToBHF(left, right),
								 left outer,
								 lookup);

		// Rollup
		Business_Header.Layout_Business_Header_New RollupCorp(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := TRANSForM
		self.dt_first_seen := 
					ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
					ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
		self.dt_last_seen := max(L.dt_last_seen,R.dt_last_seen);
		self.dt_vendor_last_reported := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		self.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		self.vl_id := if(L.vl_id = '', R.vl_id, L.vl_id);
		self.company_name := if(L.company_name = '', R.company_name, L.company_name);
		self.group1_id := if(L.group1_id = 0, R.group1_id, L.group1_id);
		self.vendor_id := if((L.group1_id = 0 and R.group1_id <> 0) or
							 L.vendor_id = '', R.vendor_id, L.vendor_id);
		self.source_group := if((L.group1_id = 0 and R.group1_id <> 0) or
							 L.source_group = '', R.source_group, L.source_group);
		self.phone := if(L.phone = 0, R.phone, L.phone);
		self.phone_score := if(L.phone = 0, R.phone_score, L.phone_score);
		self.fein := if(L.fein = 0, R.fein, L.fein);
		self.prim_range := if(l.prim_range = '' and l.zip4 = 0, r.prim_range, l.prim_range);
		self.predir := if(l.predir = '' and l.zip4 = 0, r.predir, l.predir);
		self.prim_name := if(l.prim_name = '' and l.zip4 = 0, r.prim_name, l.prim_name);
		self.addr_suffix := if(l.addr_suffix = '' and l.zip4 = 0, r.addr_suffix, l.addr_suffix);
		self.postdir := if(l.postdir = '' and l.zip4 = 0, r.postdir, l.postdir);
		self.unit_desig := if(l.unit_desig = ''and l.zip4 = 0, r.unit_desig, l.unit_desig);
		self.sec_range := if(l.sec_range = '' and l .zip4 = 0, r.sec_range, l.sec_range);
		self.city := if(l.city = '' and l.zip4 = 0, r.city, l.city);
		self.state := if(l.state = '' and l.zip4 = 0, r.state, l.state);
		self.zip := if(l.zip = 0 and l.zip4 = 0, r.zip, l.zip);
		self.zip4 := if(l.zip4 = 0, r.zip4, l.zip4);
		self.county := if(l.county = '' and l.zip4 = 0, r.county, l.county);
		self.msa := if(l.msa = '' and l.zip4 = 0, r.msa, l.msa);
		self.geo_lat := if(l.geo_lat = '' and l.zip4 = 0, r.geo_lat, l.geo_lat);
		self.geo_long := if(l.geo_long = '' and l.zip4 = 0, r.geo_long, l.geo_long);
		SELF := L;
		END;

		corp_clean_dist := distribute(corp_group_clean,
							hash(zip, trim(prim_name), trim(prim_range), trim(source_group), trim(company_name)));
		corp_clean_sort := sort(corp_clean_dist, zip, prim_range, prim_name, source_group, company_name,
							if(sec_range <> '', 0, 1), sec_range,
							if(phone <> 0, 0, 1), phone,
							if(fein <> 0, 0, 1), fein,
							dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
		corp_clean_rollup := rollup(corp_clean_sort,
							left.zip = right.zip and
								left.prim_name = right.prim_name and
								left.prim_range = right.prim_range and
								left.source_group = right.source_group and
								left.company_name = right.company_name and
								(right.sec_range = '' or left.sec_range = right.sec_range) and
								(right.phone = 0 or left.phone = right.phone) and
								(right.fein = 0 or left.fein = right.fein),
							RollupCorp(left, right),
							local);

		return corp_clean_rollup;

	end;


export corp := fAs_Business_Header(Files().base.corp.BusinessHeader,false)  
	: persist('~thor_data400::persist::Corp2::As_Business_Header');
export prctcorp:= fAs_Business_Header(Prte2_Corp.files.DS_corp_Direct, True);
	
end;