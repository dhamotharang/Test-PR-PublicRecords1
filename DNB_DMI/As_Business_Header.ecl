#OPTION('multiplePersistInstances',FALSE);
import mdr,business_header,ut;

laybus := business_header.Layout_Business_Header_New;

export as_business_header(

	 boolean 													pUsingInBizHdr		= true
	,boolean 													pUseOtherEnviron	= _Constants().IsDataland
	,dataset(layouts.Base.CompaniesForBIP2)	pDataset		= if(pUsingInBizHdr
																													,files(,pUseOtherEnviron).base.companies.BusinessHeader
																													,files(,pUseOtherEnviron).base.companies.qa
																												)
	,string1													pTodo							= 'R'	//'R' = recalculate persist,'P' = pull from persist(don't recalculate),'N' = Don't persist code
	,string														pPersistname			= persistnames(									).AsBusinessHeader
	,dataset(laybus								) 	pPersist 					= persists		(pUseOtherEnviron	).AsBusinessHeader
	
) :=
function

	dnb_base := pDataset;

	Layout_BHF_Local := RECORD
	Business_Header.Layout_Business_Header_New;
	UNSIGNED6 orig_id;
	UNSIGNED6 split_id := 0;
	UNSIGNED1 ntyp := 0;
	END;

	Layout_BHF_Local Translate_DNB_To_BHF(layouts.Base.CompaniesForBIP2 L, INTEGER CTR, unsigned1 ntyp) := transform
		SELF.vl_id   									:= L.rawfields.duns_number;
		SELF.orig_id 									:= L.rid;
		SELF.ntyp 										:= ntyp;
		SELF.vendor_id 								:= IF(L.active_duns_number = 'Y', L.rawfields.duns_number, 'D' + L.rawfields.duns_number + '-' + stringlib.stringtouppercase(L.rawfields.business_name));
		SELF.phone 										:= (UNSIGNED6)((UNSIGNED8)L.rawfields.telephone_number);
		SELF.phone_score 							:= IF((UNSIGNED8)L.rawfields.telephone_number = 0, 0, 1);
		SELF.source 									:= MDR.sourceTools.src_Dunn_Bradstreet;
		SELF.source_group 						:= IF(L.active_duns_number = 'Y', L.rawfields.duns_number, 'D' + L.rawfields.duns_number + '-' + stringlib.stringtouppercase(L.rawfields.business_name));
		SELF.company_name 						:= CHOOSE(ntyp, stringlib.stringtouppercase(L.rawfields.business_name), stringlib.stringtouppercase(L.rawfields.trade_style));
		SELF.prim_range 							:= CHOOSE(CTR ,L.clean_mail_address.prim_range			,L.clean_address.prim_range);
		SELF.predir 									:= CHOOSE(CTR ,L.clean_mail_address.predir					,L.clean_address.predir);
		SELF.prim_name 								:= CHOOSE(CTR ,L.clean_mail_address.prim_name				,L.clean_address.prim_name);
		SELF.addr_suffix 							:= CHOOSE(CTR ,L.clean_mail_address.addr_suffix			,L.clean_address.addr_suffix);
		SELF.postdir 									:= CHOOSE(CTR ,L.clean_mail_address.postdir					,L.clean_address.postdir);
		SELF.unit_desig 							:= CHOOSE(CTR ,L.clean_mail_address.unit_desig			,L.clean_address.unit_desig);
		SELF.sec_range 								:= CHOOSE(CTR ,L.clean_mail_address.sec_range				,L.clean_address.sec_range);
		SELF.city 										:= CHOOSE(CTR ,L.clean_mail_address.v_city_name			,L.clean_address.v_city_name);
		SELF.state 										:= CHOOSE(CTR ,L.clean_mail_address.st							,L.clean_address.st);
		SELF.zip 											:= CHOOSE(CTR ,(UNSIGNED3)L.clean_mail_address.zip	,(UNSIGNED3)L.clean_address.zip);
		SELF.zip4 										:= CHOOSE(CTR ,(UNSIGNED2)L.clean_mail_address.zip4	,(UNSIGNED2)L.clean_address.zip4);
		SELF.county 									:= CHOOSE(CTR ,L.clean_mail_address.fips_county			,L.clean_address.fips_county);
		SELF.msa 											:= CHOOSE(CTR ,L.clean_mail_address.msa							,L.clean_address.msa);
		SELF.geo_lat 									:= CHOOSE(CTR ,L.clean_mail_address.geo_lat					,L.clean_address.geo_lat);
		SELF.geo_long 								:= CHOOSE(CTR ,L.clean_mail_address.geo_long				,L.clean_address.geo_long);
		SELF.dt_first_seen 						:= L.date_first_seen;
		SELF.dt_last_seen 						:= L.date_last_seen;
		SELF.dt_vendor_first_reported := if(l.date_vendor_first_reported 	= 0, L.date_first_seen	, l.date_vendor_first_reported);
		SELF.dt_vendor_last_reported 	:= if(l.date_vendor_last_reported 	= 0, L.date_last_seen		,	l.date_vendor_last_reported	);
		SELF.fein 										:= 0;
		SELF.current 									:= if(utilities.RT2CurrentHistoricalFlag(l.record_type) = 'C',true, false);
		self.rawaid                   := l.rawaid;
	END;

	from_dnb_norm1 := NORMALIZE(dnb_base(rawfields.business_name <> '',
																		 rawfields.trade_style = '' or (rawfields.trade_style <> '' and rawfields.parent_duns_number = '' and rawfields.ultimate_duns_number = '')), 2, Translate_DNB_To_BHF(LEFT, COUNTER, 1));
	from_dnb_norm2 := NORMALIZE(dnb_base(rawfields.trade_style <> ''), 2, Translate_DNB_To_BHF(LEFT, COUNTER, 2));

	from_dnb_norm := from_dnb_norm1 + from_dnb_norm2;

	from_dnb_norm_dist := DISTRIBUTE(from_dnb_norm, HASH(orig_id, ut.CleanCompany(company_name)));
	from_dnb_norm_sort := SORT(from_dnb_norm_dist, orig_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

	Layout_BHF_Local RollupDNBNorm(Layout_BHF_Local L, Layout_BHF_Local R) := TRANSFORM
	SELF := L;
	END;

	from_dnb_norm_rollup := ROLLUP(from_dnb_norm_sort,
																LEFT.orig_id = RIGHT.orig_id AND
									ut.CleanCompany(LEFT.company_name) = ut.CleanCompany(RIGHT.company_name) AND
									((LEFT.zip = RIGHT.zip AND
									 LEFT.prim_name = RIGHT.prim_name AND
									 LEFT.prim_range = RIGHT.prim_range AND
									 LEFT.city = RIGHT.city AND
									 LEFT.state = RIGHT.state)
									OR
									 (RIGHT.zip = 0 AND
										RIGHT.prim_name = '' AND
									RIGHT.prim_range = '' AND
									RIGHT.city = '' AND
									RIGHT.state = '' AND
									RIGHT.city = '')
									),
									RollupDNBNorm(LEFT, RIGHT),
									LOCAL);

	ut.MAC_Sequence_Records(from_dnb_norm_rollup, split_id, from_dnb_seq)

	// Group by original id
	from_dnb_dist := DISTRIBUTE(from_dnb_seq, hash(orig_id));
	from_dnb_sort := SORT(from_dnb_dist, orig_id, ntyp, LOCAL);
	from_dnb_grpd := GROUP(from_dnb_sort, orig_id, ntyp, LOCAL);
	from_dnb_grpd_sort := SORT(from_dnb_grpd, split_id);

	Layout_BHF_Local SetGroupId(Layout_BHF_Local L, Layout_BHF_Local R) := TRANSFORM
	SELF.group1_id := IF(L.group1_id <> 0, L.group1_id, R.split_id);
	SELF := R;
	END;

	// Set group id
	from_dnb_iter := GROUP(ITERATE(from_dnb_grpd_sort, SetGroupId(LEFT, RIGHT)));

	// Calculate stat to determine count by group_id
	Layout_Group_List := RECORD
	from_dnb_iter.group1_id;
	END;

	dnb_group_list := TABLE(from_dnb_iter, Layout_Group_List);

	Layout_Group_Stat := RECORD
	dnb_group_list.group1_id;
	cnt := COUNT(GROUP);
	END;

	dnb_group_stat := TABLE(dnb_group_list, Layout_Group_Stat, group1_id);

	// Clean single group ids and format
	Business_Header.Layout_Business_Header_New FormatToBHF(Layout_BHF_Local L, Layout_Group_Stat R) := TRANSFORM
	SELF.group1_id := R.group1_id;
	SELF := L;
	END;

	dnb_group_clean := JOIN(from_dnb_iter,
													 dnb_group_stat(cnt > 1),
													 LEFT.group1_id = RIGHT.group1_id,
													 FormatToBHF(LEFT, RIGHT),
													 LEFT OUTER);

	// Rollup
	Business_Header.Layout_Business_Header_New RollupDNB(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := TRANSFORM
	SELF.dt_first_seen := 
							ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
					ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	SELF.dt_last_seen := MAX(L.dt_last_seen,R.dt_last_seen);
	SELF.dt_vendor_last_reported := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	SELF.vl_id := IF(L.vl_id = '', R.vl_id, L.vl_id);
	SELF.company_name := IF(L.company_name = '', R.company_name, L.company_name);
	SELF.group1_id := IF(L.group1_id = 0, R.group1_id, L.group1_id);
	SELF.vendor_id := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
											 L.vendor_id = '', R.vendor_id, L.vendor_id);
	SELF.source_group := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
											 L.source_group = '', R.source_group, L.source_group);
	SELF.phone := IF(L.phone = 0, R.phone, L.phone);
	SELF.phone_score := IF(L.phone = 0, R.phone_score, L.phone_score);
	SELF.fein := IF(L.fein = 0, R.fein, L.fein);
	SELF.prim_range := IF(l.prim_range = '' AND l.zip4 = 0, r.prim_range, l.prim_range);
	SELF.predir := IF(l.predir = '' AND l.zip4 = 0, r.predir, l.predir);
	SELF.prim_name := IF(l.prim_name = '' AND l.zip4 = 0, r.prim_name, l.prim_name);
	SELF.addr_suffix := IF(l.addr_suffix = '' AND l.zip4 = 0, r.addr_suffix, l.addr_suffix);
	SELF.postdir := IF(l.postdir = '' AND l.zip4 = 0, r.postdir, l.postdir);
	SELF.unit_desig := IF(l.unit_desig = ''AND l.zip4 = 0, r.unit_desig, l.unit_desig);
	SELF.sec_range := IF(l.sec_range = '' AND l .zip4 = 0, r.sec_range, l.sec_range);
	SELF.city := IF(l.city = '' AND l.zip4 = 0, r.city, l.city);
	SELF.state := IF(l.state = '' AND l.zip4 = 0, r.state, l.state);
	SELF.zip := IF(l.zip = 0 AND l.zip4 = 0, r.zip, l.zip);
	SELF.zip4 := IF(l.zip4 = 0, r.zip4, l.zip4);
	SELF.county := IF(l.county = '' AND l.zip4 = 0, r.county, l.county);
	SELF.msa := IF(l.msa = '' AND l.zip4 = 0, r.msa, l.msa);
	SELF.geo_lat := IF(l.geo_lat = '' AND l.zip4 = 0, r.geo_lat, l.geo_lat);
	SELF.geo_long := IF(l.geo_long = '' AND l.zip4 = 0, r.geo_long, l.geo_long);
	SELF := L;
	END;

	dnb_clean_dist := DISTRIBUTE(dnb_group_clean,
											HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
	dnb_clean_sort := SORT(dnb_clean_dist, zip, prim_range, prim_name, source_group, company_name,
											IF(sec_range <> '', 0, 1), sec_range,
											IF(phone <> 0, 0, 1), phone,
											IF(fein <> 0, 0, 1), fein,
											dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
	dasbh := ROLLUP(dnb_clean_sort,
								left.zip = right.zip and
									left.prim_name = right.prim_name and
									left.prim_range = right.prim_range and
									left.company_name = right.company_name and
												left.source_group = right.source_group and
									(right.sec_range = '' OR left.sec_range = right.sec_range) and
												(right.phone = 0 OR left.phone = right.phone) and
									(right.fein = 0 OR left.fein = right.fein),
											RollupDNB(LEFT, RIGHT),
											LOCAL);


	dasbh_persisted := dasbh : persist(pPersistname);
	dasbh_persist		:= pPersist;
	
	decision := map(
		 pTodo = 'R' => dasbh_persisted
		,pTodo = 'P' => dasbh_persist
		,pTodo = 'N' => dasbh
		,								dasbh_persisted
	);

	return decision;

end;
