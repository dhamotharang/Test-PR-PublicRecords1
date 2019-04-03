import location_services, address, ut, risk_indicators, property, doxie, doxie_raw, doxie_ln,
       AutoStandardI, DeathV2_Services, LN_PropertyV2_Services, LN_PropertyV2, location_services, STD;

todays_date := (string) STD.Date.Today();

export AddrHistory_Function(dataset(location_services.Layout_AddrHistory_In) inrecs, 
													  unsigned1 glbperms, 
														unsigned1 dppaperms, 
														boolean ln_branded_val, 
														boolean prob_override_val, 
														string32 appType) := 
function

mod_access := module(doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))
  EXPORT boolean ln_branded := ln_branded_val;
  EXPORT boolean probation_override := prob_override_val;
  EXPORT string32 application_type := appType;
  EXPORT unsigned1 glb := glbperms;
  EXPORT unsigned1 dppa := dppaperms;
end;

deathparams := DeathV2_Services.IParam.GetRestrictions(mod_access);
glb_ok_death := deathparams.isValidGlb();  

MAX_RECS_PER_ADDRESS := 1000; // Big enough to get records back from doxie.did_from_address

//--------------[ first, sequence the recs ]------------------
seqrec := record
	inrecs;
	unsigned4	seq;
end;

seqrec into_seq(inrecs L, integer C) := transform
	self.seq := C;
	self := L;
end;

dfseq := project(inrecs,into_seq(LEFT,COUNTER));


//-------------[ then, normalize them ]------------------

location_services.layout_addrHistory_Norm into_Norm(dfseq L, integer C) := transform
	self.seq 			:= L.seq;
	self.source		:= choose(C, 'B1','B2','S1','S2');
	self.did			:= choose (C, L.buyer_did, L.buyer2_did, L.seller_did, L.seller2_did);
	self 			:= [];
end;

df := normalize(dfseq, 4, into_norm(LEFT,COUNTER));

// ------------------ get best info
withdid 	:= df(did != 0);

glb_ok := mod_access.isValidGLB();
dids := dedup(sort(project(withdid, doxie.layout_references), did), did);
doxie.mac_best_records(dids, 
											 did, 
											 best_recs, 
											 1, 
											 glb_ok,
											 , 
											 doxie.DataRestriction.fixed_DRM,
											 include_DOD:=true);	

withdid get_best_info (withdid L, best_recs R) := transform
	self.fname := R.fname;
	self.mname := R.mname;
	self.lname := R.lname;
	self.name_suffix := if (ut.is_unk(R.name_suffix),'',R.name_suffix);
  // NB: one of the former transforms used "R.name_suffix ='UNK'" 
  // condition, which I believe is (or must be) exactly same
	self.DOD	 := R.DOD;
	self.dob 	 := (string)R.dob;
	self.deceased := if (self.DOD != '', 'Y','N');
	self.ageatdeath := if (R.dob != 0 and R.dod != '', ut.DaysApart((string)R.dob, R.dod) div 365, 0);
	self.age 	 := if (R.dob != 0, ut.Age(R.dob), 0);
	//self.phone := R.phone;
	self  	 := L;
end;

withbestinfo := join(withdid, best_recs,
										 left.did = right.did,
										 get_best_info(left, right),
										 left outer);

//--------------[ Get HRI, Gong, and Deathfile Info ]---------------
maxHRIPer_Value := 50;

layout_addr_search_plus := record, maxlength(100004)
	location_services.Layout_Addr_Search;
	unsigned4	seq;
end;

layout_addr_search_plus into_srch(dfseq L) := transform
	clean_addr := Address.cleanAddress182(L.addr1, address.Addr2FromComponents(L.city, L.state, L.zip));
	self.prim_range := clean_addr[1..10];
	self.predir     := clean_addr[11..12];
	self.prim_name	 := clean_addr[13..40];
	self.suffix 	 := clean_addr[41..44];
	self.postdir 	 := clean_addr[45..46];
	self.unit_desig := clean_addr[47..56];
	self.sec_range  := clean_addr[57..64];
	self.p_city_name := clean_addr[65..89];
	self.st 		 := clean_addr[115..116];
	self.zip		 := clean_addr[117..121];
	self.zip4		 := clean_addr[122..125];
	self.hri_address :=[];
	self.phones_children := [];
	self.seq := L.seq;
end;

srchrec := project(dfseq, into_srch(LEFT));

location_services.get_hriAddr(srchrec, withsearch);

location_services.get_gong_by_address(withsearch, phones_children, withgonginfo);


location_services.Layout_AddrHistory_Norm integrate_search(withbestinfo L, withgonginfo R) := transform
	self.search_addr := project(R, transform(location_services.Layout_Addr_Search, self := LEFT));
	self := L;
end;

withdidinfo := join(withbestinfo, withgonginfo,
						left.seq = right.seq,
					  integrate_search(LEFT, right));

withdidinfo get_death_info(withdidinfo L, doxie.key_death_masterV2_ssa_DID R) := transform
	self.deathVerificationCode := R.VorP_Code;
	self.deathcounty := R.county_name;
	self.deathstate := R.state;
	self.deceased := if (r.l_did != 0 ,'Y', L.deceased);
	self := L;
end;

withDeathCodes := join(withdidinfo, doxie.key_death_masterV2_ssa_DID,
          left.did != 0 and 
          keyed(left.did = right.l_did)
          and not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok_death, deathparams),
          get_death_info(LEFT,RIGHT),
          left outer,
          keep(ut.limits.DEATH_PER_DID), limit (0));

//-------------------[ get AKAs ]--------------------
refs := project (withdeathcodes, TRANSFORM (doxie.layout_references, SELF := Left));

hk := doxie_raw.Header_Raw(refs, mod_access);

hk get_header_recs(withdeathcodes L, hk R) := transform
	self.name_suffix := if (R.name_suffix ='UNK','',R.name_suffix);
	self.prim_name   := if (R.src in ['DE', 'DS'],'',R.prim_name);
	self := R;
end;

hrecs := join (withdeathcodes, hk,
               left.did = right.did,
               get_header_recs(LEFT,RIGHT));

hrecs_srt := dedup(sort(hrecs,did,lname,fname,mname),did,lname,fname,mname);

withdeathcodes denorm_names(withdeathcodes L, hrecs_srt R) := transform
// decision was made to drop name_suffix from akas....not in dedup or populated in output
	self.akas := L.akas + dataset([{r.fname,R.mname,R.lname,''}], location_services.Layout_Name);
	self := L;
end;

withAkas := denormalize (withdeathcodes, hrecs_srt,
                         left.did = right.did and
                         (left.fname != right.fname or left.mname != right.mname or left.lname != right.lname ),
                         denorm_names(LEFT,RIGHT));
				    

//---------------------[ get all property records ]-----------------
// FOR NOW only using Fares property (ln_fares_id[1] = 'R')
// IN THE FUTURE, when the contract with Fares ends, we can remove this filter.
prop_ids := doxie_ln.property_ids (
              refs, dataset([],doxie.layout_ref_bdid),
              0, mod_access.dppa, mod_access.glb, mod_access.ln_branded, mod_access.probation_override,,,,,,,,mod_access.application_type); 
							
props_deeds := if(Doxie.Datarestriction.Fares,
                  dataset([],doxie_ln.layout_deed_records),
                  doxie_ln.deed_records (prop_ids, 0, mod_access.ln_branded)(current = true, ln_fares_id[1] ='R'));

props_assess := if(Doxie.DataRestriction.Fares,
                   dataset([],doxie_ln.layout_assessor_records),
                   doxie_ln.asses_records(prop_ids, 0, mod_access.ln_branded)(current = true, ln_fares_id[1] ='R'));

slimrec := record
	string12 ln_fares_id;
	unsigned6	did;
	string1	source;
	string3	transaction_type;
	string10	prim_range;
	string2	predir;
	string28	prim_name;
	string4	suffix;
	string2	postdir;
	string10	unit_desig;
	string8	sec_range;
	string25	p_city_name;
	string2	st;
	string5	zip;
	string4	zip4;
	string8	record_date;
	string11	sales_price;
	string80	seller1;
	string80	seller2;
	string80	buyer1;
	string80	buyer2;
	string1	foreclosure_flag;
	string1	rec_type;
	boolean self_sell := false; //to keep track of property, which was sold to the same person
	string1	current_record;
end;


slimrec into_slim_deed(props_deeds L) := transform
	self.did := L.did;
	self.source := L.source_code;
	self.record_date := L.recording_date;
	self.transaction_type := map(L.ln_fares_id[1] = 'R' => if ((integer)L.fares_transaction_type != 2, '000', '002'),
						    L.first_td_loan_type_code in ['E','R'] => '002',
						    '000');
	addr := Address.cleanaddress182(L.property_full_street_address + ' ' + L.property_address_unit_number, L.property_address_citystatezip);
	self.prim_Range := addr[1..10];
	self.predir	 := addr[11..12];
	self.prim_name  := addr[13..40];
	self.suffix	:= addr[41..44];
	self.postdir	 := addr[45..46];
	self.unit_desig	:= addr[47..56];
	self.sec_range  := addr[57..64];
	self.p_city_name	:= addr[65..89];
	self.st		 := addr[115..116];
	self.zip 	 	 := addr[117..121];
	self.zip4		 := addr[122..125];
	self.sales_price := ut.rmv_ld_zeros(L.sales_price);
	self.seller1 := L.seller1;
	self.seller2 := L.seller2;
	self.buyer1 := L.buyer1;
	self.buyer2 := L.buyer2;
	self.foreclosure_flag := '';
	self.rec_type := 'D';
	self.ln_fares_id :=l.ln_fares_id;
	self.current_record := L.current_record;
end;

slimdeed := project(props_deeds, into_slim_deed(LEFT));

slimrec into_slim_assessor(props_assess L) := transform
	self.did := l.did;
	self.source := L.source_code;
	addr := Address.cleanaddress182(L.property_full_street_address + ' ' + L.property_unit_number, L.property_city_state_zip);
	self.prim_Range := addr[1..10];
	self.predir	 := addr[11..12];
	self.prim_name  := addr[13..40];
	self.suffix	:= addr[41..44];
	self.postdir	 := addr[45..46];
	self.unit_desig	:= addr[47..56];
	self.sec_range  := addr[57..64];
	self.p_city_name	:= addr[65..89];
	self.st		 := addr[115..116];
	self.zip 	 	 := addr[117..121];
	self.zip4		 := addr[122..125];
	self.record_date := L.recording_date;
	self.sales_price := ut.rmv_ld_zeros(L.sales_price);
	self.transaction_type := '000';
	self.seller1 := '';
	self.seller2 := '';
	self.buyer1 := '';
	self.buyer2 := '';
	self.foreclosure_flag := '';
	self.rec_type := 'A';
	self.ln_fares_id :=l.ln_fares_id;
	self.current_record := L.current_record;
end;

slimassess := project(props_assess, into_slim_assessor(LEFT));

slimprops := (slimdeed + slimassess)(prim_name != '');

// set self-sell flag for properties which were "sold to self", to avoid loosing this info in rolup
slimrec setSelfSellFlag (slimrec L, slimrec R) := TRANSFORM
  SELF.self_sell := IF (R.did != 0 AND (integer)L.record_date != 0, true, false);
  SELF := L;
END;

//now find the same property which is "owned", but later was selled to self.
self_flagged := JOIN (slimprops, DEDUP (SORT (slimprops, prim_range, prim_name, zip, record_date, source), prim_range, prim_name, zip, record_date, source),
                      left.record_date = right.record_date and left.source != right.source AND
                      left.did = right.did and
                      left.prim_range = right.prim_range and left.prim_name = right.prim_name and
                      left.sec_range = right.sec_range and left.zip = right.zip and left.ln_fares_id[1]=right.ln_fares_id[1],
                      setSelfSellFlag (Left, Right),
                      LEFT OUTER);
//OUTPUT (self_flagged, NAMED ('self_flagged'));

srt := SORT (self_flagged,
             did, prim_range, prim_name, sec_range, zip, source, transaction_type, self_sell,ln_fares_id,
             if (record_date = '', '99999999', record_date), if (rec_type = 'D', 0, 1),
             -(integer)sales_price, if (seller1 = '', 1, 0), if (seller2 = '', 1, 0), record);

slimprop_grp := GROUP (srt,
                       did, prim_Range, prim_name, sec_range, zip, source, transaction_type, self_sell,ln_fares_id[1]);
											 

slimprop_grp roll_slimprops(slimprop_grp L, slimprop_grp R) := transform
  boolean lg := (integer)L.sales_price > (integer)R.sales_price;
	self.sales_price := map (L.rec_type = 'D' and R.rec_type = 'A' => if ((integer)L.sales_price != 0, L.sales_price, R.sales_price),
                           L.rec_type = 'A' and R.rec_type = 'D' => if ((Integer)R.sales_price != 0, R.sales_price, L.sales_price),
                           if (lg, L.sales_price, R.sales_price));
	self.rec_type := map (L.rec_type = R.rec_type => L.rec_type,
                        L.rec_type = 'D' and (integer)L.sales_price != 0 => L.rec_type,
                        R.rec_type = 'D' and (integer)R.sales_price != 0 => R.rec_type, 'A');
	self.record_date := if ( (integer) R.record_date = 0 OR 
	                         (integer) L.record_date < (integer) R.record_date AND
                           (integer) L.record_date != 0, L.record_date, R.record_date);
						
	self.seller1 := If (L.seller1 = '', R.seller1, L.seller1);
	self.seller2 := if (L.seller2 = '', R.seller2, L.seller2);
	self.buyer1  := if (L.buyer1 = '', R.buyer1, L.buyer1);
	self.buyer2  := if (L.buyer2 = '', R.buyer2, L.buyer2);
	
	self.current_record  := if (L.current_record='', R.current_record, L.current_record);
	
	self := L;
end;

slimprop_srt_ddp := UNGROUP (ROLLUP (slimprop_grp, true, roll_slimprops(LEFT,RIGHT)));


//------------------[ count sales/purchases ]-------------

deedcountrec := record
	slimprop_srt_ddp.did;
	string8	early_date := min(group,if (slimprop_srt_ddp.record_date = '' , '99999999', slimprop_srt_ddp.record_date));
	unsigned4	cnt := count(group);
end;

deedcountsbuy := table(slimprop_srt_ddp(source = 'O'), deedcountrec, did);
deedcountssell :=table(slimprop_srt_ddp(source = 'S'), deedcountrec,did);

withAKAs get_prop_info(withAKAs L, deedcountsbuy R) := transform
	self.prop_owned := R.cnt;
	self.prop_hist_early_Date := R.early_date;
	self := L;
end;

withpropinfobuy := join(withAkas,
                        deedcountsbuy,
                        left.did = right.did,
                        get_prop_info(LEFT,RIGHT), 
				    left outer);

withpropinfobuy get_prop_info_2(withpropinfobuy L, deedcountssell R) := transform
	self.prop_sold := R.cnt;
	self.prop_hist_early_date := if (L.prop_hist_early_date < R.early_date and L.prop_hist_early_Date != '', L.prop_hist_early_date, R.early_date);
	self := L;
end;

withpropinfo := join(withpropinfobuy,
				 deedcountssell,
                     left.did = right.did,
				 get_prop_info_2(LEFT,RIGHT),
				 left outer);



//-----------------------[ Foreclosure Flags ]------------

fclsrec := record
	unsigned6	did;
	string70 fid;
end;


fclsrec check_foreclosures(slimprop_srt_ddp L, property.Key_Foreclosure_DID R) := transform
	self := L;
	self := R;
end;

fids := join(slimprop_srt_ddp(ln_fares_id[1]='R'), property.Key_Foreclosure_DID,
			keyed(left.did = right.did),
			check_foreclosures(LEFT,RIGHT),
      limit(ut.limits.Foreclosure_PER_DID, skip));


fclsrec2 := record
	unsigned6	did;
	string10	situs1_prim_range;
	string28	situs1_prim_name;
	string8	situs1_sec_range;
	string5	situs1_zip;
	string10	situs2_prim_range;
	string28	situs2_prim_name;
	string8	situs2_sec_range;
	string5	situs2_zip;
end;


fclsrec2 get_foreclosures(fids L, property.Key_Foreclosures_FID R) := transform
	self := L;
	self := R;
end;

frecs := join(fids,
              property.Key_Foreclosures_FID,
              keyed(left.fid = right.fid),
              get_foreclosures(LEFT,RIGHT),
              limit(ut.limits.Foreclosure_MAX, skip));

fclsrec3 := record
	unsigned6	did;
	string10	prim_range;
	string28	prim_name;
	string8	sec_range;
	string5	zip;
end;

fclsrec3 norm_frecs(frecs L, integer C) := transform
	self.did := L.did;
	self.prim_Range := if (C = 1, L.situs1_prim_range, L.situs2_prim_range);
	self.prim_name  := if (C = 1, L.situs1_prim_name, L.situs2_prim_name);
	self.sec_range  := if (C = 1, L.situs1_sec_range, L.situs2_sec_range);
	self.zip 		 := if (C = 1, L.situs1_zip, L.situs2_zip);
end;

frecs2 := dedup(normalize(frecs, 2, norm_frecs(LEFT,COUNTER)), whole record, all);

slimprop_srt_ddp add_foreclosures(slimprop_srt_ddp L, frecs2 R) := transform
	self.foreclosure_flag := if (R.prim_name = L.prim_name, 'Y', 'N');
	self := L;
end;

slimprop_rdy := join(slimprop_srt_ddp,
				   frecs2,
						left.did = right.did and
						left.prim_range = right.prim_range and
						left.prim_name = right.prim_name and
						left.sec_range = right.sec_range and
						left.zip = right.zip and left.ln_fares_id[1]='R',
				   add_foreclosures(LEFT, RIGHT),
				   left outer);
				   

//---------------------[ address history ]---------------------

slimhrec := record
	hrecs.did;
	hrecs.prim_range;
	hrecs.predir;
	hrecs.prim_name;
	hrecs.suffix;
	hrecs.postdir;
	hrecs.unit_desig;
	hrecs.sec_range;
	hrecs.city_name;
	hrecs.st;
	hrecs.zip;
	hrecs.zip4;
	hrecs.dt_first_seen;
	hrecs.dt_last_seen;
end;

hrecslim := table(hrecs,slimhrec);

hrecslim roll_dates(hrecslim L, hrecslim R) := transform
	self.dt_first_seen := if (L.dt_first_seen < R.dt_first_Seen and L.dt_first_seen != 0, L.dt_first_seen, R.dt_first_Seen);
	self.dt_last_seen  := if (L.dt_last_seen > R.dt_last_Seen, L.dt_last_Seen, R.dt_last_seen);
	self := L;
end;

hrs_ddp := rollup(sort(hrecslim, did, prim_range, prim_name, sec_range, zip, -dt_last_seen, dt_first_seen),
					left.did = right.did and
					left.prim_range = right.prim_range and
					left.prim_name = right.prim_name and
					left.sec_range = right.sec_range and
					left.zip = right.zip,
				roll_dates(LEFT,RIGHT));
				

hrs_ownrec := record, maxlength(100000)
	hrs_ddp;
	boolean	owned_by_subject;
	boolean	current_addr;
	dataset(Risk_Indicators.Layout_Desc) Hri_address;
	dataset(location_services.Layout_Phone) phone_children;
end;

hrs_ownrec into_ownedrec(hrs_ddp L, slimprop_rdy R) := transform
	self.owned_by_subject := if (R.did != 0, true, false);
	self.current_addr := false;
	self.hri_address := [];
	self.phone_children := [];
	self := L;
end;

hrs_withownership := join(hrs_ddp,
					 slimprop_rdy,
						left.did = right.did and
						left.prim_range = right.prim_Range and
						left.prim_name = right.prim_name and
						left.sec_range = right.sec_range and
						left.zip = right.zip,
					 into_ownedrec(LEFT,RIGHT),
					 left outer, keep(1));

hrs_dids := dedup(sort(project(hrs_withownership, doxie.layout_references), did), did);
doxie.mac_best_records(hrs_dids, 
											 did, 
											 best_hrs_recs, 
											 1, 
											 glb_ok, 
											 , 
											 doxie.DataRestriction.fixed_DRM);	

hrs_withownership check_current(hrs_withownership L, best_hrs_recs R) := transform
	self.current_addr := if (L.prim_range = r.prim_range and L.prim_name = r.prim_name and
						l.sec_range = r.sec_range and l.zip = r.zip, true, false);
	self := l;
end;

hrscurrent := join(hrs_withownership, best_hrs_recs,
									 left.did = right.did,
									 check_current(left, right),
									 left outer);

doxie.mac_AddHRIAddress(hrscurrent,hrs_highrisk);

location_services.get_gong_by_address(hrs_highrisk, phone_children, hrs_wgong);

withpropinfo add_history(withpropinfo L, hrs_wgong R) := transform
	self.address_history := L.address_history + if (~R.current_addr, dataset([{R.prim_Range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range, R.city_name, R.st, R.zip, R.zip4, (string)R.dt_first_seen, (string)R.dt_last_seen, R.owned_by_subject, choosen(R.hri_address,location_services.consts.max_hri_addr), choosen(R.phone_children,location_services.consts.max_hri_phone)}], location_services.Layout_address_hist));
	self.current_address := L.current_address + if (R.current_addr, dataset([{R.prim_Range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range, R.city_name, R.st, R.zip, R.zip4, (string)R.dt_first_seen, (string)R.dt_last_seen, R.owned_by_subject, choosen(R.hri_address,location_services.consts.max_hri_addr), choosen(R.phone_children,location_services.consts.max_hri_phone)}], location_services.Layout_address_hist));
	self := L;
end;

withhist := denormalize(withpropinfo,
				    sort(hrs_wgong, did, -dt_last_seen, -dt_first_seen),
						left.did = right.did,
				    add_history(LEFT,RIGHT));


// -------------------- [ Current Properties Section ] -------------

currOwn := LN_PropertyV2_Services.Ownership.get_dids(refs,true,mod_access.application_type);

// massage results into legacy format with help of unparsed deed & assessment keys
k_deed1 := LN_PropertyV2.key_deed_fid();
k_deed2 := LN_PropertyV2.key_addl_fares_deed_fid;
slimrec own2slim_d1(currOwn L, k_deed1 R) := transform
	self.transaction_type := map(
		// R.ln_fares_id[1] = 'R' => condition handled in next join
		R.first_td_loan_type_code in ['E','R']	=> '002',
		'000');
	self.source						:= R.vendor_source_flag;
	self.record_date			:= R.recording_date;
	self.sales_price			:= ut.rmv_ld_zeros(R.sales_price);
	self.buyer1						:= R.name1;
	self.buyer2						:= R.name2;
	self.foreclosure_flag	:= '';
	self.rec_type					:= 'D';
	self := L;
	self := R;
end;
slimrec own2slim_d2(slimrec L, k_deed2 R) := transform
	self.transaction_type := map(
		L.ln_fares_id[1]='R' => if ((integer)R.fares_transaction_type != 2, '000', '002'),
		L.transaction_type);
	self := L;
end;
currentProp_d1 := join(
	currOwn(hist[1].ln_fares_id[2]='D'), k_deed1,
	left.hist[1].ln_fares_id = right.ln_fares_id,
	own2slim_d1(left,right),
	limit(0), keep(1));
currentProp_d2 := join(
	currentProp_d1, k_deed2,
	left.ln_fares_id = right.ln_fares_id,
	own2slim_d2(left,right),
	left outer, limit(0), keep(1));

k_assess := LN_PropertyV2.key_assessor_fid();
slimrec own2slim_a(currOwn L, k_assess R) := transform
	self.source						:= R.vendor_source_flag;
	self.record_date			:= R.recording_date;
	self.sales_price			:= ut.rmv_ld_zeros(R.sales_price);
	self.transaction_type	:= '000';
	self.seller1					:= '';
	self.seller2					:= '';
	self.buyer1						:= '';
	self.buyer2						:= '';
	self.foreclosure_flag	:= '';
	self.rec_type					:= 'A';
	self := L;
	Self := R;
end;
currentProp_a := join(
	currOwn(hist[1].ln_fares_id[2]='A'), k_assess,
	left.hist[1].ln_fares_id = right.ln_fares_id,
	own2slim_a(left,right),
	limit(0), keep(1));
	
currentProp := currentProp_d2 + currentProp_a;

doxie.Layout_AddressSearch into_search(currentprop L, integer C) := transform
	self.seq := C;
	self.state := L.st;
	self := L;
end;

clas := project(currentprop,into_search(LEFT,COUNTER));

currentdids := doxie.did_from_address(clas, true);

doxie.mac_best_records(currentdids,
											 did,
											 outfile,
											 dppa_ok,
											 glb_ok, 
											 ,
											 doxie.DataRestriction.fixed_DRM,
											 include_DOD:=true);
													 
currentbests0 := project(outfile, transform(watchdog.Layout_Best,
																			self.name_suffix := if (left.name_suffix ='UNK','',left.name_suffix);
																			self := left));
																			
currentbests := dedup(sort(currentbests0(ut.daysapart((string)addr_dt_last_seen, todays_date) <= 365), did), did);

layout_prop_with_did := record, maxlength(50006)
	location_services.Layout_Prop_Owned;
	unsigned6	did;
end;


layout_prop_with_did into_withdid(currentprop L) := transform
	self.zip := L.zip;
	self.purchase_date := if ((integer)L.transaction_type = 2, '', L.record_date);
	self.refinance_date := if ((integer)L.transaction_type = 2, L.record_date, '');
	self := L;
	self.current_residents := [];
	self.phones_children := [];
	self.HRI_address := [];
	self.owner_is_resident := false;
	yo :=if ((integer)L.record_date = 0, -1, ut.DaysApart(L.record_date, todays_date));
	self.years_owned := map (yo = -1 => 'U',
						yo < 365 => '<1',
						(string)(yo div 365));
	self.purchaser1 := L.buyer1;
	self.purchaser2 := L.buyer2;
end;

cpwd := project(currentprop, into_withdid(LEFT));

layout_prop_with_did into_propowned(layout_prop_with_did L, currentbests R) := transform
	self.current_residents := L.current_residents + dataset([{R.did, R.fname, R.mname, R.lname, '', R.dod != ''}], location_services.layout_name_did);
	self.owner_is_resident := L.owner_is_resident or L.did = R.did;
	self := L;
end;

ownedprops := denormalize(cpwd, 
					 currentbests,
						left.prim_range = right.prim_range and
						left.prim_name = right.prim_name and
						left.sec_range = right.sec_range and
						left.zip = right.zip,
					 into_propowned(LEFT,RIGHT));

doxie.mac_AddHRIAddress(ownedprops,owned_wHRI);

location_services.get_gong_by_address(owned_wHRI, phones_children, owned_wGong);

withhist add_current(withhist L, owned_wGong R) := transform
	self.current_property := L.current_property + dataset([{R.prim_Range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range, R.p_city_name, R.st, R.zip, R.zip4, R.sales_price, R.purchase_date, R.refinance_date, R.years_owned, R.seller1, R.seller2, R.purchaser1, R.purchaser2, R.current_residents, R.owner_is_resident, R.foreclosure_flag, R.phones_children, R.hri_address}],location_services.Layout_Prop_Owned);
	self := L;
end;

withcurrent := denormalize (withhist, owned_wGong,
                            left.did = right.did,
                            add_Current(LEFT,RIGHT));

//---------------------[ Previous Property Section ]-----------
lprev_did := record, maxlength(500000)
  location_services.Layout_Prev_Property;
  unsigned6	did;
  boolean	Skip_res := false;
end;

// enumerate transactions by order of transaction dates; this is done for handling "weird"
// cases when same property is "sold" to the same person few times ("self-sell");
seq_transactions := RECORD
  unsigned4 seq;
  slimprop_rdy
END;

seq_transactions assignSequence (slimprop_rdy L, integer C) := TRANSFORM
  SELF.seq := C;
  SELF := L;
END;

all_props_srt := SORT (slimprop_rdy, did, prim_range, prim_name, sec_range, zip, record_date, -source);
all_transactions := PROJECT (all_props_srt, assignSequence (Left, COUNTER));

Prevsales :=  all_transactions (source = 'S');
PrevOwns := all_transactions (source = 'O');

lprev_did into_prev (Prevsales L, PrevOwns R) := transform
	self.purchase_date := if ((integer)R.transaction_type = 2, '', R.record_date);
	self.refinance_date := if ((integer)R.transaction_type = 2, R.record_date, '');
	self.purchase_price := R.sales_price;
	self.seller1 := R.seller1;
	self.seller2 := R.seller2;
	self.sales_price := L.sales_price;
	self.sale_date := L.record_date;
	self.purchaser1 := L.buyer1;
	self.purchaser2 := L.buyer2;
	self.Net_Profit_From_Sale := if ((integer)self.sales_price = 0 or (integer)self.purchase_price = 0, '', (string)((integer)self.sales_price - (integer)self.purchase_price));
	self.Pcnt_Gain_or_Loss := if ((integer)self.net_profit_from_sale = 0, '', (string)(round(((integer)self.net_profit_from_sale/(integer)self.purchase_price)*100)));
	yo :=if ((integer)R.record_date = 0 or (integer)L.record_date = 0, -1, ut.DaysApart(L.record_date, R.record_Date));
	self.years_owned := map (yo = -1 => 'U',
						yo < 365 => '<1',
						(string)(yo div 365));
	self.foreclosure_flag := if (L.foreclosure_flag = 'Y' or R.foreclosure_flag = 'Y','Y','N');
	self.did := L.did;
	self.zip := L.zip;
	self := L;
	self.current_residents := [];
	self.hri_address := [];
	self.phones_children := [];
end;
prev_props := join (prevSales, prevOwns,
                    left.did = right.did and
                    left.prim_Range = right.prim_range and left.prim_name = right.prim_name and
                    left.sec_range = right.sec_range and left.zip = right.zip AND
                    Left.seq = Right.seq+1 AND left.ln_fares_id[1]=right.ln_fares_id[1],
                    into_prev(LEFT,RIGHT),
                    left outer);
	
doxie.Layout_AddressSearch into_search_prev(prev_props L, integer C) := transform
	self.seq := C;
	self.state := L.st;
	self.zip := L.zip;
	self := L;
end;

plas := project(prev_props,into_search_prev(LEFT,COUNTER));

prevdids := doxie.did_from_address (plas,true,MAX_RECS_PER_ADDRESS);

//prevdids may contain more than one address, but we are ignoring address here and 
//sorting/deduping only by DID because a dataset only of dids (doxie.layout_reference) 
//is passed todoxie_raw.Header_Raw.
pds := project(dedup(sort(prevdids, did), did), transform(Doxie.layout_references, self := left));

prev_hdrs := doxie_raw.Header_Raw(pds, mod_access);

prev_hdrs_ddp := dedup(sort(prev_hdrs, did, lname, fname, prim_range, Prim_name, sec_range, zip), did, lname, fname, prim_range, prim_name, sec_range, zip);

//prev_props can have multiple records for a property address with different purchase dates.  
//Dedup here so we don't end up with duplicate residents.
prev_props_dedup := dedup(sort(prev_props, prim_range, prim_name, sec_range, st, zip), prim_range, prim_name, sec_range, st, zip);

//weed out the records from header that do not have the addresses we are interested.
prev_hdrs_prev_props := join(prev_hdrs_ddp, prev_props_dedup,
														 left.prim_range = right.prim_range and
														 left.prim_name = right.prim_name and
														 left.sec_range = right.sec_range and
														 left.zip = right.zip, limit(MAX_RECS_PER_ADDRESS, skip));

with_dod := record, maxlength(500000)
	prev_hdrs_ddp;
	boolean	deceased;
end;

//Don't need to use DIDs that were not found in header when calling doxie.mac_best_records.
dids_for_best := project(prev_hdrs_prev_props, transform(doxie.layout_references, self.did := left.did));

doxie.mac_best_records(dids_for_best,
											 did,
											 outfile2,
											 dppa_ok,
											 glb_ok, 
											 ,
											 doxie.DataRestriction.fixed_DRM,
											 include_DOD:=true);
									 
prev_hdr_wDOD := join(prev_hdrs_prev_props, outfile2,
												left.did = right.did,
														transform(with_dod,
																self.deceased := right.dod != '';
																self := left), left outer);

prev_props add_residents(prev_props L, prev_hdr_wdod R, integer C) := transform
	self.skip_res := if (L.prim_range = '' and L.sec_range = '' and C > 10, true, false);
	self.current_residents := if (C < 10, L.current_residents + dataset([{R.did, R.fname, R.mname, R.lname, '', R.deceased}], location_services.layout_name_did),
						    if (self.skip_res, dataset([], location_services.layout_name_did), L.current_residents));	
	self := l;
end;

prev_props_wresidents := denormalize(prev_props,
					    prev_hdr_wDOD,
							~left.skip_res and
							left.prim_Range = right.prim_range and
							left.prim_name = right.prim_name and
							left.sec_range = right.sec_range and
							left.zip = right.zip and
							// An attempt to populate residents only for a current property by filtering on date?
							(integer)(left.purchase_date[1..6]) <= (integer) right.dt_last_seen and (integer)left.purchase_date != 0 and
							(integer)(left.sale_date[1..6]) >= (integer) right.dt_first_seen,
					    add_residents(LEFT,RIGHT, counter));
							
doxie.mac_AddHRIAddress(prev_props_wresidents,prev_props_wHRI);

location_services.get_gong_by_address(prev_props_wHRI, phones_children, prev_wGong);

location_services.Layout_AddrHistory_Norm add_prev_props(withcurrent L, prev_wGong R) := transform
	self.previous_property := L.previous_property + dataset([{R.prim_Range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range, R.p_city_name, R.st, R.zip, R.zip4, R.years_owned, R.purchase_Date, R.purchase_price, R.refinance_Date, R.seller1, R.seller2, R.sale_date, R.sales_price, R.purchaser1, R.purchaser2,R.current_residents, R.Net_Profit_From_Sale, R.pcnt_Gain_or_Loss, R.foreclosure_flag, R.phones_children, R.hri_address}], location_services.layout_prev_property);
	self := L;
end;

withprev := denormalize( withcurrent,
					prev_wGong,
						left.did = right.did,
					add_prev_props(LEFT,RIGHT));

//---------------------[ Inter-Subject Relationships ] -------------

relationrec := record
	unsigned4	seq;
	string2	source;
	string2	rel_source1;
	string2	rel_source2;
	string2	rel_source3;
	string2	rel_source4;
	string2	rel_source5;
	string2	rel_source6;
	string2	rel_source7;
end;

foorec := record
	boolean foo;
end;

foorec compare_hist_to_cprop(location_services.layout_address_hist L, location_services.layout_prop_owned R) := transform
	self.foo := true;
end;

foorec compare_hist_to_pprop(location_services.layout_address_hist L, location_services.layout_prev_property R) := transform
	self.foo := true;
end;

foorec compare_hist_to_hist(location_services.layout_address_hist L, location_services.layout_address_hist R) := transform
	self.foo := true;
end;

foorec compare_cur_to_cur(location_services.layout_prop_owned L, location_services.layout_prop_owned R) := transform
	self.foo := true;
end;

foorec compare_prev_to_cur(location_services.layout_prev_property L, location_services.layout_prop_owned R) := transform
	self.foo := true;
end;

foorec compare_prev_to_prev(location_services.layout_prev_property L, location_services.layout_prev_property R) := transform
	self.foo := true;
end;


relationrec check_rel(withprev L, withprev R) := transform
	self.rel_source1 := if (count(join(L.address_history, R.current_property,
									 left.prim_Range = right.prim_range and 
									 left.prim_name = right.prim_name and
									 left.sec_range = right.sec_range and
									 left.zip = right.zip,
								compare_hist_to_cprop(LEFT,RIGHT)))>0, R.source,'');
	self.rel_source2 := if (count(join(L.address_history, R.previous_property,
									 left.prim_Range = right.prim_range and 
									 left.prim_name = right.prim_name and
									 left.sec_range = right.sec_range and
									 left.zip = right.zip,
								compare_hist_to_pprop(LEFT,RIGHT)))>0, R.source,'');
	self.rel_source3 := if (count(join(L.address_history, R.address_history,
									 left.prim_Range = right.prim_range and
									 left.prim_name = right.prim_name and
									 left.sec_range = right.sec_range and
									 left.zip = right.zip,
								compare_hist_to_hist(LEFT,RIGHT)))>0, R.source, '');
								
	self.rel_source4 := if (count(join(L.current_property, R.current_property,
									 left.prim_Range = right.prim_range and 
									 left.prim_name = right.prim_name and
									 left.sec_range = right.sec_range and
									 left.zip = right.zip,
								compare_cur_to_cur(LEFT,RIGHT)))>0, R.source,'');
	self.rel_source5 := if (count(join(L.previous_property, R.current_property,
									 left.prim_Range = right.prim_range and 
									 left.prim_name = right.prim_name and
									 left.sec_range = right.sec_range and
									 left.zip = right.zip,
								compare_prev_to_cur(LEFT,RIGHT)))>0, R.source,'');
	self.rel_source6 := if (count(join(R.previous_property, L.current_property,
									 left.prim_Range = right.prim_range and 
									 left.prim_name = right.prim_name and
									 left.sec_range = right.sec_range and
									 left.zip = right.zip,
								compare_prev_to_cur(LEFT,RIGHT)))>0,R.source,'');
	self.rel_source7 := if (count(join(L.previous_property, R.previous_property,
									 left.prim_Range = right.prim_range and 
									 left.prim_name = right.prim_name and
									 left.sec_range = right.sec_range and
									 left.zip = right.zip,
								compare_prev_to_prev(LEFT,RIGHT)))>0, R.source,'');

	self := l;
end;

with_checked_rels1 := join(withprev, withprev,
						left.seq = right.seq and
						left.source != right.source,
					  check_rel(LEFT,RIGHT));
					  
					  
location_services.layout_addrHistory_Norm add_relations(location_services.layout_addrHistory_Norm L, with_checked_rels1 R) := transform
	self.related_subjects := dedup(L.related_subjects + dataset([{R.rel_source1,'Owns Property in Address History'},{R.rel_source2,'Formerly Owned Property in Address History'},{R.rel_source3,'Share Address in Address Histories'},{R.rel_source4,'Both Owned Same Property'},{R.rel_source5,'Both Owned Same Property'},{R.rel_source6,'Both Owned Same Property'},{R.rel_source7,'Both Owned Same Property'}], location_services.layout_rel),whole record, all)(source != '');
	self := L;
end;

with_rel_relations := denormalize (withprev, with_checked_rels1,
							left.seq = right.seq and
							left.source = right.source,
						add_relations(LEFT,RIGHT));
						
						
newrec := RECORD(location_services.layout_addrHistory_Norm)
boolean do_royal;
end;

newrec doroyal(with_rel_relations l):=transform
self :=l;
self.do_royal :=count(l.current_property(sales_price <>''))<>0 or count(l.current_property(purchase_date <>''))<>0 or count(l.current_property(refinance_date <>''))<>0 or
count(l.current_property(years_owned <>''))<>0 or count(l.current_property(seller1 <>''))<>0 or count(l.current_property(seller2 <>''))<>0 or count(l.current_property(purchaser1 <>''))<>0 or count(l.current_property(purchaser2 <>''))<>0 or count(l.previous_property(years_owned <>''))<>0 or
count(l.previous_property(purchase_date <>''))<>0 or count(l.previous_property(refinance_date <>''))<>0 or count(l.previous_property(seller1 <>''))<>0 or count(l.previous_property(seller2 <>''))<>0 or
count(l.previous_property(sale_date <>''))<>0 or count(l.previous_property(sales_price <>''))<>0 or count(l.previous_property(purchaser1 <>''))<>0 or count(l.previous_property(purchaser2 <>''))<>0 or
count(l.previous_property((integer)net_profit_from_sale <> 0))<>0 or count(l.previous_property((integer)pcnt_gain_or_loss <>0))<>0 or l.prop_hist_early_Date<>'';

end;

with_rel_relations_out :=project(with_rel_relations,doroyal(left));						

// output(props_deeds,named('props_deeds'));
// output(props_assess,named('props_assess'));
// output(slimprops,named('slimprops'));
// output(self_flagged,named('self_flagged'));
// output(srt,named('srt'));
// output(slimprop_srt_ddp,named('slimprop_srt_ddp'));
// output(slimprop_rdy,named('slimprop_rdy'));
// output(currentprop,named('currentprop'));
// output(cpwd,named('cpwd'));
// output(currentbests,named('currentbests'));
// output(ownedprops,named('ownedprops'));
// output(owned_wHRI,named('owned_wHRI'));
// output(owned_wGong,named('owned_wGong'));

return with_rel_relations_out;
end;
