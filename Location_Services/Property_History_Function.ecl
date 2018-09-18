// Function to build a property history record set. 

import codes, address, Advo, ln_propertyv2, doxie, ut, risk_indicators, doxie_cbrs, LN_PropertyV2_Services, Suppress,
       STD;

todays_date := (string) STD.Date.Today();

export Property_History_Function(DATASET(Layout_PropHistory_In) inData,
						   UNSIGNED1 dppa,UNSIGNED1 glba, String32 applicationType,
						   BOOLEAN lnBranded=false, BOOLEAN doAVM=false) := 
FUNCTION

  mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
	  EXPORT unsigned1 glb := glba;
	  EXPORT unsigned1 dppa := ^.dppa;
		EXPORT boolean ln_branded := lnBranded;
		EXPORT string32 application_type := applicationType;
	END;
	
  key_search := LN_PropertyV2.key_search_fid();	
  key_addr   := LN_PropertyV2.key_addr_fid();
  key_assess := LN_PropertyV2.key_assessor_fid();
  key_deed   := LN_PropertyV2.key_deed_fid();
	
	// Reformat requests into results
	Layout_PropHistory_Out rfmt(Layout_PropHistory_In l) := TRANSFORM
		SELF.reqData := PROJECT(l, TRANSFORM(Layout_PropHistory_In, SELF:=LEFT));
		SELF := [];
	END;
	
	emptyResults := PROJECT(indata, rfmt(LEFT));

	WorkLayout := RECORD
		INTEGER	seq;
		STRING12	fares_id;
	END;
	
	WorkAssessment := RECORD
		WorkLayout;
		ln_propertyv2.layout_property_common_model_base currentAssessment;
	END;

	WorkLayout getFaresID1(Layout_PropHistory_In l, key_addr R) := TRANSFORM		
		SELF.seq := l.seq;
		SELF.fares_id :=R.ln_fares_id;
	END;

	byAddr := JOIN(indata(prim_name<>''), 
				key_addr,
					LEFT.prim_name<>'' AND 
					keyed(LEFT.prim_name=RIGHT.prim_name) AND
					keyed(LEFT.prim_range=RIGHT.prim_range) AND
					keyed(LEFT.in_zipCode=RIGHT.zip) AND
					keyed(LEFT.predir=RIGHT.predir) AND
					keyed(LEFT.postdir=RIGHT.postdir) AND
					keyed(LEFT.addr_suffix=RIGHT.suffix) AND
					keyed(LEFT.sec_range=RIGHT.sec_range)and
					keyed(right.source_code_2 = 'P') AND
					right.ln_fares_id[1] not in LN_PropertyV2_Services.input.srcRestrict,
				getFaresID1(LEFT, RIGHT), KEEP(500), LIMIT (0));


	WorkLayout getFaresID2(Layout_PropHistory_In l, LN_PropertyV2.key_assessor_parcelnum R) := TRANSFORM		
		SELF.seq := l.seq;
		SELF.fares_id := R.ln_fares_id;
	END;

	WorkLayout getFaresID3(Layout_PropHistory_In l, LN_PropertyV2.key_deed_parcelnum R) := TRANSFORM		
		SELF.seq := l.seq;
		SELF.fares_id := R.ln_fares_id;
	END;

	byAPN1 := JOIN (indata (in_fares_unformatted_apn<>''),
                  LN_PropertyV2.key_assessor_parcelnum,
                  keyed (Left.in_fares_unformatted_apn=Right.fares_unformatted_apn) and
									right.ln_fares_id[1] not in LN_PropertyV2_Services.input.srcRestrict,
                  getFaresID2 (Left, Right), KEEP(500), LIMIT (10000)); // can be more than 100,000

	byAPN2 := JOIN (indata (in_fares_unformatted_apn <> ''),
                  LN_PropertyV2.key_deed_parcelnum,
                  keyed (Left.in_fares_unformatted_apn = Right.fares_unformatted_apn)  and
									right.ln_fares_id[1] not in LN_PropertyV2_Services.input.srcRestrict,
                  getFaresID3 (Left, Right), keep(500), LIMIT (10000)); // can be more than 100,000
				

	// Pick up current Tax Assesment data									
	fares_raw := if(exists(indata(in_fares_unformatted_apn<>'')), byAPN1+byAPN2, byAddr);
	fares := DEDUP(SORT(fares_raw, seq, fares_id), seq, fares_id);
	fares_count :=count(fares);
	fares_for_owner :=fares;
	
	addrsrc := record
		layout_address address;
		string2	source_code;
		unsigned4	seq;
		dataset(risk_indicators.layout_desc) hri_address {maxcount(consts.max_hri_addr)};
	end;
		
	addrsrc get_address(fares L, key_search R) := transform
		self.address.prim_range 	:= R.prim_Range;
		self.address.predir 	:= R.predir;
		self.address.prim_name	:= R.prim_name;
		self.address.suffix 	:= R.suffix;
		self.address.postdir 	:= R.postdir;
		self.address.unit_desig  := R.unit_desig;
		self.address.sec_range	:= R.sec_range;
		self.address.p_city_name := R.p_city_name;
		self.address.st		:= R.st;
		self.address.zip		:= R.zip;
		self.address.zip4		:= R.zip4;
		self.source_code 		:= R.source_code;
		self.seq 				:= L.seq;
		self.hri_address		:= [];
	end;
	
	sourceaddrs := join(fares,key_search,
						keyed(left.fares_id = right.ln_fares_id) and
						wild(right.which_orig) and
						wild(right.source_code_2) and
						keyed(right.source_code_1 = 'O'),
					get_address(LEFT,RIGHT), left outer, keep(500));

	sourcessorted := dedup(sort(sourceaddrs, seq, source_code, address.prim_range, address.prim_name, address.zip, -address.sec_range),
					seq, source_code, address.prim_range, address.prim_name, address.zip, 
					left.address.sec_range = right.address.sec_range or right.address.sec_range = '');

	maxHRIPer_Value := 50;
	doxie.mac_AddHRIAddress(sourcessorted, sources_whri, address.zip, address.prim_name, address.suffix, address.predir, address.postdir, address.prim_range, address.sec_range);

	avm_data := append_AVM_function(inData, doAVM);
	
	emptyResults add_property_value(emptyResults L, avm_data R) := transform
    self.property_value := R; 
		self := L;
	end;
	withPropValue := join(emptyResults, avm_data, (left.reqData.seq = right.seq), 
						add_property_value(LEFT,RIGHT), left outer, 
						atmost(left.reqData.seq=right.seq, 100), keep(1));
	
		
	emptyResults add_source_addr(emptyResults L, sources_whri R) := transform
		self.address := R.address;
		self.hri_address := choosen(R.hri_address, consts.max_hri_addr);
		self := L;
	end;
	
	empty_whriAddr := join(withPropValue, sources_whri,
							left.reqdata.seq = Right.seq and
							right.source_code[2] = 'P' and 
						  (left.reqdata.in_state = '' or left.reqdata.in_state  = right.address.st),
					    add_source_addr(LEFT,RIGHT), left outer,LIMIT(0));

	// make sure there is no more than one unique address per seq
	cttab := table(empty_whriAddr, {unsigned seq := reqData.seq, unsigned ct := count(group)}, reqData.seq);
	nonUniqueAddress := exists(cttab(ct > 1));
	
	emptyResults add_mailing_addr(EmptyResults L, sources_whri R) := transform
		self.mailing_Address := R.address;
		self.HRI_Mailing_Address := choosen(R.hri_address, consts.max_hri_addr);		
		self := L;
	end;
	
	emptyWHRI := join(empty_whriAddr, sources_whri,
					left.reqdata.seq = right.seq and
					right.source_code[2] = 'O',
				add_mailing_addr(LEFT,RIGHT), left outer, keep(1));
				
				
	WorkAssessment getAssessor(WorkLayout l, key_assess r) := TRANSFORM
		SELF := l;
		SELF.currentAssessment.tax_year := IF(r.tax_year='', '0000', r.tax_year);
		self.currentassessment.tax_amount := stringlib.stringfilterout(r.tax_amount,'.');
		SELF.currentAssessment := r;
	END;
	
	assessments := JOIN(fares, 
					key_assess,
					KEYED(LEFT.fares_id=RIGHT.ln_fares_id) and right.ln_fares_id[2]='A',
					getAssessor(LEFT, RIGHT),
					LIMIT (0), KEEP (1));

	lastAssessment := DEDUP(SORT(assessments, seq, -currentAssessment.tax_year), seq);
	
	arec := record
		worklayout;
		string5	vendor_source_flag;
		string10	fares_land_use;
		layout_assessment_data currentassessment;
		end;

	arec code_map(LastAssessment L) := transform
		self.currentassessment.has_pool := L.currentassessment.pool_code not in ['','0','00','000'];
		self.currentassessment.hri_address := [];
		self.currentassessment.assessed_land_value := ut.rmv_ld_zeros(L.currentassessment.assessed_land_value);
		self.currentassessment.assessed_improvement_value := ut.rmv_ld_zeros(L.currentassessment.assessed_improvement_value);
		self.currentassessment.assessed_total_value := ut.rmv_ld_zeros(L.currentassessment.assessed_total_value);
		self.currentassessment.tax_amount := ut.rmv_ld_zeros(L.currentassessment.tax_amount);
		self.currentassessment.market_land_value := ut.rmv_ld_zeros(L.currentassessment.market_land_value);
		self.currentassessment.market_improvement_value := ut.rmv_ld_zeros(L.currentassessment.market_improvement_value);
		self.currentassessment.market_total_value := ut.rmv_ld_zeros(L.currentassessment.market_total_value);
		// self.currentassessment.fares_calculated_total_value := ut.rmv_ld_zeros(L.currentassessment.fares_calculated_total_value);
		
		// source flag used to be string5 -> 
		// new values 'F' for 'FAR_F', 'S' for 'FAR_S', 'O' for 'OKCTY', and 'D' for 'DAYTN'
		
		self.vendor_source_flag  := map(L.currentassessment.vendor_source_flag='F' => 'FAR_F',
										L.currentassessment.vendor_source_flag='S' => 'FAR_s',
										L.currentassessment.vendor_source_flag='O' => 'OKCTY',
										L.currentassessment.vendor_source_flag='D' => 'DAYTN',
										'');
		
		// self.fares_land_use 	:= L.currentassessment.fares_land_use;
		self := L;
		self := [];
	end;
	
	pre_last_assess_mapped := project(lastassessment,code_map(LEFT));

	// Get field descriptions
	Codes.Mac_GetPropertyCode(pre_last_assess_mapped,wac,Codes.Key_Codes_V3, 'FARES_2580','AIR_CONDITIONING',
			currentassessment.air_conditioning_code,currentassessment.ac_code_desc);
	Codes.Mac_GetPropertyCode(wac,wheating,Codes.Key_Codes_V3, 'FARES_2580','HEATING',
			currentassessment.heating_code,currentassessment.heating_code_desc);
	Codes.Mac_GetPropertyCode(wheating,wfuel,Codes.Key_Codes_V3, 'FARES_2580','FUEL',
			currentassessment.heating_fuel_type_code,currentassessment.fuel_type_desc);
	Codes.Mac_GetPropertyCode(wfuel,wcover,Codes.Key_Codes_V3, 'FARES_2580','ROOF_COVER',
			currentassessment.roof_cover_code,currentassessment.roof_cover_desc);
	Codes.Mac_GetPropertyCode(wcover,wroof,Codes.Key_Codes_V3, 'FARES_2580','ROOF',
			currentassessment.roof_type_code,currentassessment.roof_type_desc);
	Codes.Mac_GetPropertyCode(wroof,Last_assess_mapped,Codes.Key_Codes_V3, 'FARES_2580','STYLE',
			currentassessment.style_code,currentassessment.style_desc);		
		

	best_plus := record
		doxie.layout_best;
		string12  ln_fares_id;
		unsigned6 bdid :=0;
		dataset(risk_indicators.Layout_Desc) HRI_ADDRESS {maxcount(consts.max_hri_addr)};
	end;	
	
	// Assure name is populated by either company name or first, middle, last from search key,
	// this is important for name matching to set dmdata2
	best_plus get_owner_did(fares L, key_search R) := transform
		cleaned:=address.CleanPerson73(R.cname);
		pop_w_cname := R.fname='' and R.mname='' and R.lname='';
		self.fname:= if(pop_w_cname,cleaned[6..25],R.fname);
		self.mname :=if(pop_w_cname,cleaned[26..45],R.mname);
		self.lname :=if(pop_w_cname,cleaned[46..65],R.lname);
		self := R;
		self :=[];
	end;
	
	// Make allowance for owners with a bdid and dedup by did,bdid, or name for those without
	Owner_wdids_bdids := dedup(sort(join(fares_for_owner, key_search,
						keyed(Left.fares_id = right.ln_fares_id),
				   get_owner_did(LEFT,RIGHT)),did,bdid,lname,fname,mname),(left.did=right.did and left.bdid=right.bdid)
					 and ((left.did <>0 or left.bdid <> 0) or (ut.NameMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname)<3)));
				   
	
	doxie.layout_references into_ref(owner_wdids_bdids L) := transform
		self := L;
	end;
	
	owner_did := dedup(sort(project(owner_wdids_bdids(did<>0), into_ref(LEFT)),did),did);

	doxie_cbrs.layout_supergroup into_ref2(owner_wdids_bdids L) := transform
		self.group_id := 0;
		self.level := 0;
		self := L;
	end;	
		
	owner_bdid :=dedup(sort(project(owner_wdids_bdids(did=0 and bdid<>0),into_ref2(LEFT)),bdid),bdid);
	
	// get best records by did
	OB0 := doxie.best_records(owner_did, includeDOD:=true, modAccess := mod_access);
	
	// get best records by bdid
	OB1 := doxie_cbrs.fn_best_records(owner_bdid, false);
	
	// best records for ones missing did and bdid stay as is, better than nothing
	OB2 :=owner_wdids_bdids(did=0 and bdid=0);
	

	
	best_plus best_from_bdid(OB1 L):=transform
		cleaned:=address.CleanPerson73(L.Company_Name);
		self.fname:= cleaned[6..25];
		self.mname :=cleaned[26..45];
		self.lname :=cleaned[46..65];
		self :=L;
		self :=[];
	END;
	
	
	ob0plus := project(ob0, transform(best_plus, self.ln_fares_id:=[], self := Left, self.hri_address := []));
	
	ob1plus :=project(ob1, best_from_bdid(left));
	
	
	doxie.mac_AddHRIAddress(ob0plus, pre_ownerBests_did)
	
	doxie.mac_AddHRIAddress(ob1plus, pre_ownerBests_bdid)
	
	doxie.mac_AddHRIAddress(ob2,pre_ownerBests_nodid_bdid)
	
	
	ownerBests := pre_ownerbests_did+pre_ownerbests_bdid + pre_ownerBests_nodid_bdid;


	layout_deed_mortgage_summary get_deed_summary(fares L, key_deed R) := transform
		self.seq := L.seq;
		self.first_td_loan_amount := if ((integer)R.first_td_loan_amount = 0, '', ut.rmv_ld_zeros(R.first_td_loan_amount));
		self.second_td_loan_amount := if ((integer)R.second_td_loan_amount = 0, '', ut.rmv_ld_zeros(R.second_td_loan_amount));
		// title company names are notoriously corrupt in the key
		self.title_company_name := stringlib.stringfilter(R.title_company_name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ');
		// fares_forclosure can have corruption as well
		// self.fares_foreclosure := stringlib.stringfilter(R.fares_foreclosure,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ');
		// and fares_equity_flag
		// self.fares_equity_flag := stringlib.stringfilter(R.fares_equity_flag,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ');
		self := R;
		self := [];
	end;
	
	dmData0 := JOIN(fares, 
				key_deed,
				keyed(LEFT.fares_id=RIGHT.ln_fares_id) and right.ln_fares_id[2]='D', 
				get_deed_summary(LEFT,RIGHT),
				limit(0), keep(1));	
	// Make buyers and sellers child datasets as opposed to using so many denormalize statements
	dmrec := record
		dmData0;
		dataset(Layout_PersonData) buyers  {maxcount(consts.max_buyers)};
		dataset(Layout_PersonData) sellers {maxcount(consts.max_sellers)};
		string1 source;
		best_plus and not ln_fares_id;  // fares_id will already exist in dmData0
	end;	
	
	dmrec into_dm(dmData0 L) := transform
		self := L;
		self := [];
	end;
	
	dmData00 := project(dmData0, into_dm(LEFT));

	Layout_PersonData_wbdid :=RECORD
		location_services.Layout_PersonData;
		location_services.Layout_address;
		unsigned6 bdid;
		string12  ln_fares_id;
	END;
	
	Layout_PersonData_wbdid into_person(best_plus L,codes.Key_Codes_V3 r) := transform
		self.did := L.did;
		self.bdid :=L.bdid;
		self.current_address := dataset([{L.prim_range, L.predir, L.prim_name, L.suffix, L.postdir, L.unit_desig, L.sec_range, L.city_name, L.st, L.zip, L.zip4, L.addr_dt_last_seen, choosen(L.hri_address,consts.max_hri_addr)}], layout_person_address); 
		self.mortgage_fraud_area := Length(trim(L.phone)) = 10 and r.long_desc ='YES';
		self.phones := choosen( location_services.get_Phone_Info(L.phone, L.lname, L.prim_range, L.predir, L.prim_name, L.sec_range, L.st, L.zip), consts.max_phones);
		self.HRI_SSN := location_services.Get_SSN_INFO(L.ssn, L.ssn_unmasked, L.valid_ssn, L.dob, L.did);
		self := l;
		self :=[];
	end;


	dmrec get_buyer_names(dmData00 L, key_search R) := transform
		cleaned:=address.CleanPerson73(R.cname);
		name_populated :=R.fname <>'' or R.mname <> '' or R.lname <>'';
		self.did :=R.did;
		self.bdid :=R.bdid;
		self.source :=R.source_code_1;
		self.fname :=if(name_populated,R.fname,cleaned[6..25]);
		self.mname :=if(name_populated,R.mname,cleaned[26..45]);
		self.lname :=if(name_populated,R.lname,cleaned[46..65]);
		self := L;
	end;
	
	// get same naming procedure as owner_w_dids_bdids so that name matching for dmdata2 works
	dmData1 :=dedup(join(dmData00,key_search,
					keyed(left.ln_fares_id = right.ln_fares_id),
			get_buyer_names(LEFT, RIGHT),keep(100)),seq,ln_fares_id,source,did,bdid,all);


	Layout_PersonData person_from_dmData(key_search L):=Transform
		self.current_address :=dataset([{L.prim_range, L.predir, L.prim_name, L.suffix, L.postdir, L.unit_desig, L.sec_range, L.p_city_name, L.st, L.zip, L.zip4, '',[]}], layout_person_address);
		self := l;
		self :=[]
	END;	

	dmrec get_buyers_sellers(DmData1 L,Layout_PersonData_wbdid R):=Transform
		noname := L.fname='' and L.mname='' and L.lname='';
		from_R := project(R,transform(Layout_PersonData,
																	self.fname:=if(noname,left.fname,L.fname),
																	self.lname :=if(noname,left.lname,L.lname),
																	self.mname :=if(noname,left.mname,L.mname),self:=left));

		self.buyers		:= if(L.source ='O',from_R);
		self.sellers	:= if(L.source ='S',from_R);
		self.ln_fares_id := L.ln_fares_id;
		self :=R;
		self :=L;
	END;
	
	ownerbests_wphone_hrissn :=join(ownerbests,codes.Key_Codes_V3,right.file_name='MORTGAGE_FRAUD'and right.field_name='AREA_CODE'
		and right.field_name2='' and left.phone[1..3]=right.code,into_person(left,right),left outer, atmost(1));

  // function to check if both ln-fares are either from fares source or non-fares source:
	boolean no_commingling (string12 L, string12 R) := (L[1] = 'R') = (R[1] = 'R');

	// join by did and bdid and only do name matching when these are absent
	dmData2 :=sort(join(dmData1,ownerbests_wphone_hrissn,
					left.did = right.did and left.bdid=right.bdid and ((right.bdid<>0 or right.did<>0) or (no_commingling(left.ln_fares_id,right.ln_fares_id) and ut.NameMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname)<3)),get_buyers_sellers(left,right),left outer),seq,ln_fares_id);
					
	// get current owners by filtering dmdata2 since ownerbest data was joined to make this attribute
	dmlatest := sort(dmdata2(~(did=0 and fname='' and lname='' and prim_range='' and prim_name='' and zip='') and
	recording_date = max(dmdata2(source='O'),recording_date),source='O'),did=0 and bdid=0,did,bdid,fname,lname,mname);
	currentowners :=dedup(dmlatest,(left.did=right.did and left.bdid=right.bdid and left.did<>0) or ((right.bdid=0 and right.did=0) and ut.NameMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname)<3));

					
	dmrec roll_buyers_sellers(dmData2 L,dmData2 R):=Transform
		self.buyers :=choosen((L.buyers+R.buyers)(~(did=0 and fname='' and lname='' and mname='')),consts.max_buyers);
		Self.sellers :=choosen((L.sellers+R.sellers)(~(did=0 and fname='' and lname='' and mname='')),consts.max_sellers);
		self :=l;
	END;
	
	dmData3 :=rollup(dmData2,roll_buyers_sellers(left,right),seq,ln_fares_id);

	dmData4 :=project(dmData3, transform(dmrec, self.buyers :=left.buyers(~(did=0 and fname='' and lname='' and mname='')),self.sellers :=left.sellers(~(did=0 and fname='' and lname='' and mname='')),self:=left));
	
	dmData := dedup(dmdata4,
					except vendor_source_flag,
							fares_refi_flag, 
					 	  ln_fares_id,
						  buyer_mailing_address_care_of_name,
						  seller_mailing_full_street_address,
						  seller_mailing_address_unit_number,
						  seller_mailing_address_citystatezip, all);
	dmData_s := sort(dmData, seq, -(if(recording_date<>'',recording_date,contract_date)), ln_fares_id);
									
	digits := ['0','1','2','3','4','5','6','7','8','9'];
	string add_dash(String s) := if (s[length(trim(s)) - 8] in digits and
							   s[length(trim(s))] in digits,
							   s[1 .. length(trim(s))-4] + '-' + s[length(trim(s))-3 .. length(trim(s))],
							   s);
	
w_vendor_source_flag :=record
	Layout_PropertyTransaction;
END;
	
	
	w_vendor_source_flag cvtLPTD(DmData l, string addr1, dataset(risk_indicators.layout_desc) hri_addr) := TRANSFORM
		self.partiesatsameaddress := L.buyer_mailing_full_street_address = L.seller_mailing_full_street_address 
																	and L.buyer_mailing_address_unit_number = L.seller_mailing_address_unit_number 
																	and L.buyer_mailing_address_citystatezip = L.seller_mailing_address_citystatezip 
																	and L.buyer_mailing_full_street_address <> '';
		SELF.deed.buyer_mailing_address_care_of_name := L.buyer_mailing_address_care_of_name;
		SELF.deed.buyer_mailing_full_street_address := L.buyer_mailing_full_street_address;
		SELF.deed.buyer_mailing_address_unit_number := L.buyer_mailing_address_unit_number;
		SELF.deed.buyer_mailing_address_citystatezip := add_dash(L.buyer_mailing_address_citystatezip);
		SELF.deed.contract_date := L.contract_date;
		SELF.deed.recording_date := L.recording_date;
		SELF.deed.lender_name := L.lender_name;
		self.deed.first_td_lender_type_code := L.first_td_lender_type_code;
		self.deed.second_td_lender_type_code := L.second_td_lender_type_code;
		self.deed.Total_Mortgage_Amount := (string)((integer)L.first_td_loan_amount + (integer)L.second_td_loan_amount);
		SELF.deed.first_td_loan_amount := ut.rmv_ld_zeros(L.first_td_loan_amount);
		SELF.deed.second_td_loan_amount := ut.rmv_ld_zeros(L.second_td_loan_amount);
		SELF.deed.first_td_loan_type_code := L.first_td_loan_type_code;
		SELF.deed.fares_mortgage_deed_type := L.fares_mortgage_deed_type;
		self.deed.mortgage_deed_subtype := map(L.fares_foreclosure != '' => codes.FARES_1080.FORECLOSURE(L.fares_foreclosure,L.vendor_source_flag),
									    L.fares_refi_flag != '' => codes.FARES_1080.REFI_FLAG(L.fares_refi_flag, L.vendor_source_flag),
									    L.fares_equity_flag != '' => codes.FARES_1080.EQUITY_FLAG( L.fares_equity_flag, L.vendor_source_flag),
									    '');  // these codes are fares specific and will not be in the v3 key for nonfares data
		SELF.deed.fares_mortgage_term_code := L.fares_mortgage_term_code;
		SELF.deed.fares_mortgage_term := L.fares_mortgage_term;
		SELF.deed.document_type_code := L.document_type_code;
		SELF.deed.document_type_desc := get_document_desc(L.vendor_source_flag,L.document_type_code);
		SELF.deed.fares_transaction_type := L.fares_transaction_type;
		SELF.deed.document_number := L.document_number;
		SELF.deed.recorder_book_number := l.recorder_book_number;
		SELF.deed.recorder_page_number := L.recorder_page_number;
		SELF.deed.concurrent_mortgage_book_page_document_number := L.concurrent_mortgage_book_page_document_number;	
		self.deed.hri_address := choosen(hri_addr, consts.max_hri_addr);
		self.sale.sales_price := ut.rmv_ld_zeros(L.sales_price);
		self.sale.contract_date := l.contract_date;
		self.sale.recording_date := L.recording_date;
		self.sale.title_company_name := L.title_company_name;
		self.sale.buyer1 := L.buyer1;
		self.sale.buyer2 := L.buyer2;
		self.sale.seller1 := L.seller1;
		self.sale.seller2 := l.seller2;
		self.sale.buyers :=choosen(l.buyers, consts.max_buyers); 
		self.sale.sellers := choosen(L.Sellers, consts.max_sellers);
	     // following is a 'best' approximation without cleaning addresses.
		self.mailingsameaspropertyaddress := ut.stringsimilar(trim(addr1,all),trim(self.deed.buyer_mailing_full_street_address,all)) < 3;
		self.sourcePropertyRecordId := L.ln_fares_id;
		self.vendor_source_flag := L.vendor_source_flag;
		self := []; // the description fields are initially blank because they get populated later in trans_new
	END;
	
	string zerofill(string s) := if ((integer)s = 0, s, intformat((integer)s,6,1) + stringlib.stringfilterout(s,'1234567890'));


	Layout_PersonData into_person2(dmrec L, codes.Key_Codes_V3 r) := transform
		self.did := L.did;
		self.current_address := dataset([{L.prim_range, L.predir, L.prim_name, L.suffix, L.postdir, L.unit_desig, L.sec_range, L.city_name, L.st, L.zip, L.zip4, L.addr_dt_last_seen, choosen(L.hri_address,consts.max_hri_addr)}], layout_person_address); 
		self.phones := choosen( get_Phone_Info(L.phone, L.lname, L.prim_range, L.predir, L.prim_name, L.sec_range, L.st, L.zip), consts.max_phones);
		self.HRI_SSN := location_services.Get_SSN_INFO(L.ssn, L.ssn_unmasked, L.valid_ssn, L.dob, L.did);
		self.mortgage_fraud_area := Length(trim(L.phone)) = 10 and r.long_desc ='YES';
		self := l;
	end;



	doxie.Layout_AddressSearch 
	xtract4AddrSrch(Location_Services.Layout_PropHistory_Out l) := TRANSFORM
		self.seq := L.reqdata.seq;
		self.state := L.address.st;
		SELF := L.address;
	END;

	addressArgs := PROJECT(emptyWHRI,xtract4AddrSrch(LEFT));

	addr_didList := doxie.did_from_address(addressArgs,true);

	doxie.layout_references xtract4References(addr_didList l) := TRANSFORM
		SELF.did := l.did;
	END;

	didList := PROJECT(addr_didList, xtract4REferences(LEFT));

	bestRecords_all := sort(doxie.best_records(didList, modAccess := mod_access),-addr_dt_last_seen);
	
	// restrict minors
	bestRecords	:= bestRecords_all(ut.PermissionTools.GLB.minorOK(age));

	string os(string s) := if (s ='', '', trim(s) + ' ');

	layout_resident into_resident(bestRecords L) := transform
		self.did := L.did;
		self.full_name := os(L.fname) + os(L.mname) + trim(L.lname);// + trim(L.name_suffix);
		self.HRI_SSN := choosen(location_services.get_SSN_info(L.ssn, L.ssn_unmasked, L.valid_ssn, L.dob, L.did), consts.max_hri_ssn);
		self.phone_Info := choosen( get_Phone_Info(L.phone, L.lname, L.prim_range, L.predir, L.prim_name, L.sec_range, L.st, L.zip), consts.max_hri_phone);
		// skip taken out in favor of filter in add_trans_new transform because of bug with skip in child datasets
		self.dt_last_seen := L.addr_dt_last_seen;
	end;


	// Do projects inside of join transform to get owners, current residents, and transactions. Current assessment
	// fields from last_assess_mapped able to be added with one line.
	Layout_PropHistory_Out add_trans_new(Layout_PropHistory_Out L,last_assess_mapped R) := Transform
		dm_match 				:= choosen(dmData_s(seq=L.reqdata.seq),consts.max_transact);
		formatted_dm := project(dm_match, cvtLPTD(LEFT, address.Addr1FromComponents(L.reqdata.prim_range, L.reqdata.predir, zerofill(L.reqdata.prim_name), L.reqdata.addr_suffix, L.reqdata.postdir, '', ''), choosen(L.hri_address,consts.max_hri_addr)));

		// using codes v3 key as opposed to using codes lookup attribute
		Codes.Mac_GetPropertyCode(formatted_dm,wMorg,Codes.Key_Codes_V3, 'FARES_2580','MORTGAGE_TERM_CODE',
			deed.fares_mortgage_term_code,deed.mortgage_term_units)
		Codes.Mac_GetPropertyCode(wMorg,wDoc,Codes.Key_Codes_V3, 'FARES_1080','DOCUMENT_TYPE',
			deed.document_type_code,deed.document_type_desc)
		Codes.Mac_GetPropertyCode(wDoc,wTrans,Codes.Key_Codes_V3, 'FARES_1080','TRANSACTION_TYPE',
			deed.fares_transaction_type,deed.transaction_type)
		Codes.Mac_GetPropertyCode(wTrans,wLoan,Codes.Key_Codes_V3, 'FARES_1080','MORTGAGE_LOAN_TYPE_CODE',
			deed.first_td_loan_type_code,deed.loan_type_desc)
		
		Layout_PropertyTransaction addVend(wLoan L) := transform
			self.vendor_source_desc := LN_PropertyV2_Services.fn_vendor_source(L.vendor_source_flag);
			self.vendor_source_flag := LN_PropertyV2_Services.fn_vendor_source_obscure(L.vendor_source_flag);
			self := L;
		end;
		transactions := project(wLoan,addVend(left));		

		owner_match 		:= choosen(currentowners(seq=L.reqdata.seq),10);
		bestrec_match 	:= choosen(bestrecords(prim_range = L.address.prim_range and
																	Prim_name = L.address.prim_name and
																	sec_Range = L.address.sec_range and
																	zip = L.address.zip),10);
		self.currentassessment :=R.currentassessment;	
		self.deedsummary.vacantlot := (R.vendor_source_flag = 'FAR_F' and R.fares_land_use = '400') or
							(R.vendor_source_flag = 'FAR_S' and R.fares_land_use in ['400','481','480','453']);
		self.owners := join(owner_match,codes.Key_Codes_V3,right.file_name='MORTGAGE_FRAUD'and right.field_name='AREA_CODE'
		and right.field_name2='' and left.phone[1..3]=right.code,into_person2(left,right),left outer, atmost(1));

		self.current_residents := project(bestrec_match, into_resident(LEFT))(ut.daysApart((string)dt_last_seen, todays_date) <= 365);
		self.transactions := sort(dedup(sort(transactions,
			record,except sourcePropertyRecordId),record, except sourcePropertyRecordId),-sale.recording_date); // dedup on dataset with child datasets seems to be working
		self.deedsummary.totalDeedTransfers := if (l.reqdata.seq = 0, 0, count(self.transactions));	
		self.DeedSummary.TotalDeedTransferPeriod := min(dm_match,(integer)recording_date);
		self.DeedSummary.lastDeedTransfer := max(dm_match,(integer)recording_date);
		self.DeedSummary.LastSaleDate	:= max(dm_match,(integer)recording_date);
		self.deedsummary.PeriodSinceOwnerVacatedProperty := 0;	
		self.deedsummary.warnings := 
			if(
				ut.daysapart((string)self.deedsummary.lastDeedTransfer, todays_date) < 180,
				dataset([{'Deed transferred within last 6 months (' + ((string)ut.daysapart((string)self.deedsummary.lastDeedTransfer, todays_date)) + ' days ago)'}],{string64 warning})
			) &
			if(
				ut.daysapart((string)self.deedsummary.lastsaledate, todays_date) < 180,
				dataset([{'Seller acquired property within last 180 days (' + ((string)ut.daysapart((string)self.deedsummary.lastsaledate, todays_date)) + ' days ago)'}],{string64 warning})
			);					  	
		
		self := l;
	end;

	withTrans0 := sort(join(emptyWHRI,last_assess_mapped,left.reqData.seq=right.seq,
										add_trans_new(left,right),left outer,keep(1)),reqdata.seq);
		

	withTrans0 calc_summary_periods(withTrans0 L) := transform
		self.deedsummary.totaldeedtransferPeriod := if ((integer)L.deedsummary.totaldeedtransferperiod = 0, 0, ut.DaysApart((string)L.deedsummary.totaldeedtransferperiod,todays_date) div 30);
		self.deedsummary.lastdeedtransfer := if ((integer)l.deedsummary.lastdeedtransfer = 0, 0, ut.daysapart(todays_date,(string)l.deedsummary.lastdeedtransfer));
		self := L;
	end;
	
	withResidentsFares := project(NOFOLD(withTrans0), calc_summary_periods(LEFT));


	
	withResidentsFares check_res_to_owner(withResidentsFares L) := transform
		numOwnerResident := count(join(L.owners, L.current_Residents,
							left.did = right.did,
					transform({boolean foo}, self.foo := true)));
		self.deedsummary.warnings := L.deedsummary.warnings + if (numOwnerResident = 0 and count(L.owners) != 0, dataset([{'Owner is not resident'}],{string64 warning}));
		self.deedsummary.PeriodSinceOwnerVacatedProperty := if (NumOwnerResident = 0 and count(L.owners) != 0, L.deedsummary.LastDeedTransfer,0);
		self := L;
	end;
	
	withOwnerCompare := project(withResidentsFares, check_res_to_owner(LEFT));
	
	
	out_preCompliance :=get_royalfields(withOwnerCompare,fares_count);

// output(pre_last_assess_mapped, named('pre_last_assess_mapped'));

	// Compliance code...
	
	// suppression
	Suppress.MAC_Suppress_Child.nokeyLinked(out_preCompliance,,out_pull1,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did,,owners,true);
	Suppress.MAC_Suppress_Child.nokeyLinked(out_pull1,,out_pull2,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did,,current_residents,true);
	Suppress.MAC_Suppress_Child.nokeyLinked(out_pull2,,out_pull3,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,hri_ssn[1].ssn,,owners,true);
	Suppress.MAC_Suppress_Child.nokeyLinked(out_pull3,,out_pull4,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,hri_ssn[1].ssn,,current_residents,true);
	Suppress.MAC_Suppress_Child.nokeyLinked(out_pull4,,out_pull5,mod_access.application_type,Suppress.Constants.LinkTypes.DID,sale.buyers[1].did,,transactions,true);
	Suppress.MAC_Suppress_Child.nokeyLinked(out_pull5,,out_pull6,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,sale.buyers[1].hri_ssn[1].ssn,,transactions,true);
	Suppress.MAC_Suppress_Child.nokeyLinked(out_pull6,,out_pull7,mod_access.application_type,Suppress.Constants.LinkTypes.DID,sale.sellers[1].did,,transactions,true);
	Suppress.MAC_Suppress_Child.nokeyLinked(out_pull7,,out_pull8,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,sale.sellers[1].hri_ssn[1].ssn,,transactions,true);
	// NOTE: The entries above with [1] are child datasets where there could conceivably
	//       be more than one record.  Ideally, we should have a way to suppress based on
	//       any of them rather than just the first.
	
	// NOTE: We should also mask SSNs in grandchildren and great-grandchildren...
	// owners/hri_ssn/ssn
	// current_residents/hri_ssn/ssn
	// transactions/sale.buyers/hri_ssn/ssn
	// transactions/sale.sellers/hri_ssn/ssn
	
	// output(byAPN1, named('phf_byAPN1'));
	// output(byAPN2, named('phf_byAPN2'));
	// output(sourceaddrs, named('phf_sourceaddrs'));
	// output(sources_whri, named('phf_sources_whri'));
	// output(empty_whriAddr, named('phf_empty_whriAddr'));
	// output(cttab, named('phf_cttab'));
	// output(indata, named('phf_indata') );
	// output(emptyResults, named('phf_emptyResults'));
	// output(avm_data, named('phf_avm_data'));
	// output(withPropValue, named('phf_withPropValue'));	
  // output(withPropValue, named('phf_withPropValue'));

	if (nonUniqueAddress, fail(203, doxie.ErrorCodes(203)));
	return out_pull8;

END;