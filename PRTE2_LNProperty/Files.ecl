IMPORT UT, doxie, standard, ut, doxie_ln, NID,census_data, LN_Propertyv2,AID, AID_Build,BIPV2,LN_PropertyV2_Fast,std, PRTE2_LNProperty_Ins;
EXPORT files := module

	ln_propertyv2_deed_in_all := DATASET('~PRTE::IN::ln_propertyv2::deed', Layouts.prte__ln_propertyV2__base__deed, CSV(HEADING(0), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
 EXPORT ln_propertyv2_deed_in := ln_propertyv2_deed_in_all(ln_fares_id!='ln_fares_id');

	ln_propertyv2_tax_in_all := DATASET('~PRTE::IN::ln_propertyv2::tax', Layouts.prte__ln_propertyV2__base__tax, CSV(HEADING(0), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
 
 Export ln_propertyv2_tax_in := project(ln_propertyv2_tax_in_all(ln_fares_id != 'ln_fares_id' and ln_fares_id != ''),
 Transform(Layouts.prte__ln_propertyV2__base__tax,
           self.cust_name:=if(Left.cust_name='0','',Left.cust_name);
           Self:=Left;
 ));

 ln_propertyv2_search_in_all := DATASET('~PRTE::IN::ln_propertyv2::search', Layouts.prte__ln_propertyV2__base__search, CSV(HEADING(0), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );
 EXPORT ln_propertyv2_search_in :=ln_propertyv2_search_in_all(ln_fares_id!='ln_fares_id');

	EXPORT ln_propertyv2_deed_base := DATASET('~PRTE::BASE::ln_propertyv2::deed', Layouts.deed_mortgage_common_model_base_out, THOR );
	EXPORT ln_propertyv2_deed := Project(ln_propertyv2_deed_base, Layouts.layout_deed_mortgage_common_model_base - [bug_num, cust_name]);
	
	EXPORT ln_propertyv2_tax_base := DATASET('~PRTE::BASE::ln_propertyv2::tax', Layouts.property_common_model_base_out, THOR );
	EXPORT ln_propertyv2_tax := Project(ln_propertyv2_tax_base, Layouts.layout_property_common_model_base - [bug_num, cust_name]);

	Shared ln_propertyv2_search_base := DATASET('~PRTE::BASE::ln_propertyv2::search', Layouts.New_Search_Layout, THOR );
	EXPORT ln_propertyv2_search := Project(ln_propertyv2_search_base, Layouts.layout_search_building - [bug_num, cust_name]);

  EXPORT file_deed_common_model_base_scrubs := Project(ln_propertyv2_deed, Layouts.layout_deed_mortgage_common_model_base_scrubs);
	
	EXPORT file_property_common_model_base_scrubs := Project(ln_propertyv2_tax, Layouts.layout_property_common_model_base_scrubs);
	
	EXPORT ln_propertyv2_alpha_deed := PROJECT(	PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS(ln_fares_id[2] = 'D' ), 
										TRANSFORM(	Layouts.layout_deed_mortgage_common_model_base,
													SELF := LEFT, 
													SELF := []));

	EXPORT ln_propertyv2_alpha_tax := PROJECT(	PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS(ln_fares_id[2] = 'A' ), 
										TRANSFORM( 	Layouts.layout_property_common_model_base, 
													SELF := LEFT, 
													SELF := []));

	EXPORT ln_propertyv2_alpha_search := PROJECT(	PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS, 
											TRANSFORM(Layouts.layout_search_building,
													SELF := LEFT, 
													SELF := []));

	EXPORT DS_addlfarestax_fid := DATASET([], Layouts.layout_addl_fares_tax );

	EXPORT DS_addllegal_fid := DATASET([],Layouts.layout_addl_legal );

	EXPORT DS_addlfaresdeed_fid := DATASET([],Layouts.layout_addl_fares_deed );

	EXPORT DS_addlnames_fid := DATASET([],Layouts.layout_addl_names );

	EXPORT file_search_fid_linkid := PROJECT(ln_propertyv2_search_base, TRANSFORM(Layouts.layout_search_fid, self := left, self := []));

	EXPORT file_search_building_did_out := Project(ln_propertyv2_search, TRANSFORM(Layouts.Layout_DID_Out, self := left, self := []));

	EXPORT file_search_building_dedup := dedup(ln_propertyv2_search,did, ln_fares_id,source_code, all);
	 ////////////file_search_fid_county//////////
	fat_rec := record
	 ln_propertyv2_search;
	 string18 county_name := '';
	 source_code_2 := ln_propertyv2_search.source_code[2];
	end;

	with_field := table(ln_propertyv2_search((unsigned)did > 0), fat_rec);

	census_data.MAC_Fips2County(with_field,st,county[3..5],county_name,with_all_dups);

	krec := record
		with_all_dups.ln_fares_id;
		string18 o_county_name;
		string18 p_county_name;
	end;

	krec splitc(with_all_dups l) := transform
		self.ln_fares_id := l.ln_fares_id;
		self.o_county_name := if(l.source_code[2] = 'O', l.county_name, '');
		self.p_county_name := if(l.source_code[2] = 'P', l.county_name, '');
	end;

	needsroll := project(with_all_dups(county_name <> ''), splitc(left));
		
	krec rollem(krec l, krec r) := transform
		self.o_county_name := if(l.o_county_name = '', r.o_county_name, l.o_county_name);
		self.p_county_name := if(l.p_county_name = '', r.p_county_name, l.p_county_name);
		self := l;
	end;

	EXPORT file_search_fid_county  := rollup(sort(needsroll,ln_fares_id), left.ln_fares_id = right.ln_fares_id, rollem(left, right));
	all_prop_ddp := doxie_ln.Fn_ComputeOwnerForKeyv2(
											ln_propertyv2_search,
											ln_propertyv2_tax,
											ln_propertyv2_deed,
											DATASET([], Layouts.layout_addl_fares_deed)).records;

	noln_prop_ddp := doxie_ln.Fn_ComputeOwnerForKeyv2(ln_propertyv2_search(	ln_fares_id[1] <> 'D'),
																ln_propertyv2_tax(ln_fares_id[1] <> 'D'),
																ln_propertyv2_deed(ln_fares_id[1] <> 'D'),
																DATASET([], Layouts.layout_addl_fares_deed)).records;

	nofares_prop_ddp :=doxie_ln.Fn_ComputeOwnerForKeyv2(	ln_propertyv2_search(ln_fares_id[1] <> 'R'),
												ln_propertyv2_tax(ln_fares_id[1] <> 'R'),
												ln_propertyv2_deed(ln_fares_id[1] <> 'R'),
												DATASET([], Layouts.layout_addl_fares_deed)).records;

	Layouts.dd0_rec make_dd0_rec(ln_propertyv2_search l) := transform
		self.fname := NID.PreferredFirstVersionedStr(l.fname, NID.version);
		self := l;
	end;

	dd0_ddp := dedup(project(ln_propertyv2_search(prim_name!='' and zip!=''), make_dd0_rec(left)),record,all);

	Layouts.ddr addLNowner(dd0_ddp l, all_prop_ddp r) := transform
		self.LN_owner := r.zip5 <> '';
		self := l;
	end;

	dd1 := join(dd0_ddp, all_prop_ddp,
			   left.prim_name = right.prim_name and 
			   left.prim_range = right.prim_range and 
			   left.zip = right.zip5 and 
			   left.predir = right.predir and 
			   left.postdir = right.postdir and 
			   left.suffix = right.addr_suffix and 
			   left.sec_range = right.sec_Range and 
			   left.lname = right.lname and  
			   left.fname = right.fname and
			   left.name_suffix = right.name_suffix,
			   addLNowner(left, right), left outer);

	Layouts.ddr addowner(dd1 l, noln_prop_ddp r) := transform
		self.owner := r.zip5 <> '';
		self := l;
	end;

	dd := join(dd1, noln_prop_ddp,
			   left.prim_name = right.prim_name and 
			   left.prim_range = right.prim_range and 
			   left.zip = right.zip5 and 
			   left.predir = right.predir and 
			   left.postdir = right.postdir and 
			   left.suffix = right.addr_suffix and 
			   left.sec_range = right.sec_Range and 
			   left.lname = right.lname and  
			   left.fname = right.fname and
			   left.name_suffix = right.name_suffix,
			   addowner(left, right), left outer);


	Layouts.ddr addnofaresowner(dd l,  nofares_prop_ddp r) := transform
		self.nofares_owner :=r.zip5 <>'';
		self := l;
	end;

	ddd := join(dd,nofares_prop_ddp,
			   left.prim_name = right.prim_name and 
			   left.prim_range = right.prim_range and 
			   left.zip = right.zip5 and 
			   left.predir = right.predir and 
			   left.postdir = right.postdir and 
			   left.suffix = right.addr_suffix and 
			   left.sec_range = right.sec_Range and 
			   left.lname = right.lname and  
			   left.fname = right.fname and
			   left.name_suffix = right.name_suffix,
			   addnofaresowner(left, right), left outer);
			   
	EXPORT KEY_ADDR_FID_PREP := ddd ;
	///////////////////file_assessor_pcn_df//////////////////////////////////////////////
	assessor_pcn_dfd := ln_propertyv2_tax( ln_fares_id != '');
	assessor_pcn_d_ln := assessor_pcn_dfd(ln_fares_id[1]!='R'); 
	assessor_pcn_d_fa := assessor_pcn_dfd(ln_fares_id[1]='R');
	assessor_pcn_d_fa_d := assessor_pcn_d_fa(fares_unformatted_apn != LN_Propertyv2.fn_strip_pnum(apna_or_pin_number)); 
	assessor_pcn_d_fa_s := assessor_pcn_d_fa(fares_unformatted_apn = LN_Propertyv2.fn_strip_pnum(apna_or_pin_number)); 

	assessor_pcn_d_fa_d tnorm(assessor_pcn_d_fa_d L, integer cnt) := transform
		self.fares_unformatted_apn := choose(cnt, l.fares_unformatted_apn, LN_Propertyv2.fn_strip_pnum(l.apna_or_pin_number));						  
	  self := L;
	end;
						   
	assessor_pcn_norm_file := normalize(assessor_pcn_d_fa_d, 2, tnorm(left, counter));
	assessor_pcn_d := assessor_pcn_d_ln + assessor_pcn_d_fa_s + assessor_pcn_norm_file ; 
		
	EXPORT file_assessor_pcn_df := dedup(assessor_pcn_d(fares_unformatted_apn !=''),fares_unformatted_apn,ln_fares_id,all);
	//////////FILE_deed_pcn_df///////////////
	deed_pcn_dfd := ln_propertyv2_deed(ln_fares_id != '');
	deed_pcn_d_ln := deed_pcn_dfd(ln_fares_id[1]!='R'); 
	deed_pcn_d_fa := deed_pcn_dfd(ln_fares_id[1]='R');
	deed_pcn_d_fa_d := deed_pcn_d_fa(fares_unformatted_apn != LN_Propertyv2.fn_strip_pnum(apnt_or_pin_number)); 
	deed_pcn_d_fa_s := deed_pcn_d_fa(fares_unformatted_apn = LN_Propertyv2.fn_strip_pnum(apnt_or_pin_number)); 

	deed_pcn_d_fa_d tnorm(deed_pcn_d_fa_d L, integer cnt) := transform
		self.fares_unformatted_apn := choose(cnt, l.fares_unformatted_apn, LN_Propertyv2.fn_strip_pnum(l.apnt_or_pin_number));						      
		self := L;
	end;				   
	deed_pcn_norm_file := normalize(deed_pcn_d_fa_d, 2, tnorm(left, counter));
	deed_pcn_d := deed_pcn_d_ln + deed_pcn_d_fa_s + deed_pcn_norm_file ; 
		
	EXPORT FILE_deed_pcn_df := dedup(deed_pcn_d(fares_unformatted_apn !=''),fares_unformatted_apn,ln_fares_id,all);
	//////////dZipLoanAmt////////////
	dSearch				:=	ln_propertyv2_search	(source_code[2]	=	'P'
										and	ln_fares_id[2]	in	['D','M']
										and	zip	!=	''
										and	zip	!=	'00000'	);								
	
	Layouts.rCleanZip_layout	tAppendCleanZip(ln_propertyv2_deed	le,ln_propertyv2_search	ri)	:= transform
		self	:=	le;
		self	:=	ri;
	end;
	dDeedMortClean	:=	join(	ln_propertyv2_deed,
							dSearch,
							left.ln_fares_id	=	right.ln_fares_id,
							tAppendCleanZip(left,right),
							keep(1)
						);

	Layouts.rDeedMortgLoanDtNorm_layout	tNormLoanDate(dDeedMortClean	pInput,integer	cnt)	:= transform
		self.loan_date	:=	choose(	cnt,
								pInput.recording_date,
								pInput.contract_date,
								pInput.arm_reset_date,
								pInput.first_td_due_date		
							  );
		self	 :=	pInput;
	end;

	dDeedNormLoanDate	:=	normalize(dDeedMortClean,4,tNormLoanDate(left,counter));

	Layouts.rDeedMortgNorm_layout	tNormLoanAmt(dDeedNormLoanDate	pInput,integer	cnt)	:= transform
		self.loan_amount	:=	choose(cnt,pInput.first_td_loan_amount);
		self							:=	pInput;
	end;
	dDeedNormLoanAmt	:=	normalize(dDeedNormLoanDate,1,tNormLoanAmt(left,counter));
	export dZipLoanAmt	:=	dDeedNormLoanAmt(	loan_amount		!=	''
										and	loan_date		!=	''
										and	zip			!=	''
									 );
	////////dAvgSalesPriceSort////////////
	key_zip_avg_sales_price_dDeedSlim := PROJECT(ln_propertyv2_deed(    (vendor_source_flag IN ['F','S'] and ut.CleanSpacesAndUpper(document_type_code) NOT IN Constants.Fares_NoOnwershipChangeDocTypes)
											or (vendor_source_flag NOT IN ['F','S'] and ut.CleanSpacesAndUpper(document_type_code) NOT IN Constants.OKC_NoOnwershipChangeDocTypes)),
										TRANSFORM(Layouts.key_zip_avg_sales_price_rDeedSlim_Layout,
											SELF.best_date := IF((INTEGER)LEFT.recording_date != 0,LEFT.recording_date,LEFT.contract_date),
											SELF := LEFT));

	key_zip_avg_sales_price_dSearchSlim := PROJECT(ln_propertyv2_search(ln_fares_id[2] = 'D' and source_code[2]	=	'P' and (INTEGER)zip != 0),Layouts.key_zip_avg_sales_price_rSearchSlim_Layout);

	Layouts.key_zip_avg_sales_price_rCleanZip_Layout tAppendCleanZip(Layouts.key_zip_avg_sales_price_rDeedSlim_Layout le,Layouts.key_zip_avg_sales_price_rSearchSlim_Layout ri)	:=
	TRANSFORM,SKIP((INTEGER)le.best_date = 0 or ((INTEGER)le.best_date[1..4] + 20 < (INTEGER)((STRING8)Std.Date.Today())[1..4])) //skip records with blank date or date less than 20 years
		SELF.year  := (INTEGER)le.best_date[1..4];
		SELF.month := (INTEGER)le.best_date[5..6];
		SELF       := le;
		SELF       := ri;
	END;

	dDeedAppendCleanZip := JOIN(key_zip_avg_sales_price_dDeedSlim,
						key_zip_avg_sales_price_dSearchSlim,
						LEFT.ln_fares_id = RIGHT.ln_fares_id,
						tAppendCleanZip(LEFT,RIGHT),
						KEEP(1));

	dDeedAppendCleanZipFilter := dDeedAppendCleanZip(zip !=	'' and (INTEGER)sales_price != 0);

	rAvgSalesPriceByZip_Layout := RECORD
		dDeedAppendCleanZipFilter.zip;
		dDeedAppendCleanZipFilter.year;
		dDeedAppendCleanZipFilter.month;
		REAL avg_sales_price := ROUND(AVE(GROUP,(REAL)dDeedAppendCleanZipFilter.sales_price));
	END;

	dAvgSalesPriceByZip := TABLE(dDeedAppendCleanZipFilter,rAvgSalesPriceByZip_Layout,zip,year,month);

	rAvgSalesPriceByZip4_Layout := RECORD
		dDeedAppendCleanZipFilter.zip;
		dDeedAppendCleanZipFilter.zip4;
		dDeedAppendCleanZipFilter.year;
		dDeedAppendCleanZipFilter.month;
		REAL avg_sales_price := ROUND(AVE(GROUP,(REAL)dDeedAppendCleanZipFilter.sales_price));
	END;

	dAvgSalesPriceByZip4 := TABLE(dDeedAppendCleanZipFilter(zip4 != ''),rAvgSalesPriceByZip4_Layout,zip,zip4,year,month);

	dAvgSalesPrice := dAvgSalesPriceByZip4 + PROJECT(dAvgSalesPriceByZip,TRANSFORM(rAvgSalesPriceByZip4_Layout,SELF.zip4 := '',SELF := LEFT));

	EXPORT dAvgSalesPriceSort := DEDUP(SORT(dAvgSalesPrice,zip,zip4,year,month),zip,zip4,year,month,all);
	/////////////////file_tax_summary/////////////////
	Layouts.rAssesSlim_layout	tPropZip(ln_propertyv2_tax	le,ln_propertyv2_search	ri)	:= transform
		self.zip									:=	ri.zip;
		self.tax_year							:=	le.tax_year;
		self.assessed_total_value	:=	(integer)	le.assessed_total_value;
		self.tax_amount						:=	(integer)	le.tax_amount;
	end;
	res	:=	join(	ln_propertyv2_tax(tax_year !=	'',assessed_total_value	!= '',tax_amount !=	''),
					ln_propertyv2_search(source_code[2] = 'P', zip != ''),
					left.ln_fares_id	=	right.ln_fares_id,
					tPropZip(left,right),
					keep(1)
				);
		
	res2	:=	res(tax_year	<>	'', zip	<>	'',assessed_total_value	<>	0,tax_amount	<>	0);
	rOut_layout	:= record
		res2.zip;
		res2.tax_year;
		integer8	avg_tax		:=	ave(group,res2.tax_amount);
		integer8	avg_value	:=	ave(group,res2.assessed_total_value);
	end;
	EXPORT file_tax_summary	:=	table(res2,rOut_layout,res2.zip,res2.tax_year);
	///////////////////file_search_autokey/////////////
	dParty := ln_propertyv2_search(source_code[1]!='C');

	Layouts.layout_autokey_rec tra(ln_propertyv2_search l) := transform
		self.addr.st := l.st;
		self.addr.addr_suffix := l.suffix ; 
		self.addr.zip5 := l.zip ;
		self.addr.fips_state := l.county[1..2] ;
		self.addr.fips_county := l.county[3..5];
		self.addr.addr_rec_type := l.rec_type;  
		self.addr.cbsa := l.msa;
		self.name.name_score := '' ;  
		self.name := l;
		self.addr := l;
		self.cname := if(trim(l.cname) in ln_propertyv2.furniture_words or trim(l.nameasis) in ln_propertyv2.furniture_words,'',l.cname);
		self := l ; 
	end;

	d2 := project(ln_propertyv2_search(source_code[1]!='C'), tra(left));

	layouts.dwr mdw(d2 L) := transform
		ft								:= LN_Propertyv2.fn_fid_type(L.ln_fares_id);
		pt								:= L.source_code[1];
		self.fid_type			:= ft;
		self.lookups			:= (unsigned4)(ut.bit_set(1, doxie.lookup_bit( ft )) | ut.bit_set(1, doxie.lookup_bit( 'PARTY_'+pt )));
		isPerson					:= (L.cname='');
		noAddr						:= row([],standard.Addr);
		noName						:= row([],standard.Name);
		self.DID          := if(isPerson, L.DID,					0);
		self.person_addr	:= if(isPerson, L.addr,					noAddr);
		self.person_name	:= if(isPerson, L.name,					noName);
		self.phone				:= if(isPerson, L.phone_number,	'');
		self.app_SSN			:= if(isPerson, L.app_SSN,			'');
		self.BDID         := if(isPerson, 0,							L.BDID);
		self.cname        := if(isPerson, '',							L.cname);
		self.company_addr := if(isPerson, noAddr,					L.addr);
		self.bphone       := if(isPerson, '',							L.phone_number);
		self.app_tax_id   := if(isPerson, '',							L.app_tax_id);
		self := L;
	end;

	b := project(d2, mdw(left));

	export file_search_autokey := dedup(b, record, all);

	//////////////file_ownership_did//////////////////

	Ownership_did_t_base	:=	project(file_search_building_did_out(did<>0,source_code[1..2] in ['OP','BP']),Layouts.Ownership_did_l_base);

	Ownership_did_t_assess	:=	project(ln_propertyv2_tax,Layouts.Ownership_did_l_assess);

	Ownership_did_t_deed	:=	project(ln_propertyv2_deed,Layouts.Ownership_did_l_deed);

	Layouts.layout_ownership_did 	toOwn(Ownership_did_t_base	L)	:=	transform
		self.current								:=	false;
		self.fips_code								:=	'';
		self.orig_state								:=	'';
		self.orig_county							:=	'';
		self.unformatted_apn							:=	'';
		self.legal_brief_description						:=	'';
		self.dt_first_seen							:=	L.dt_first_seen*100;
		self.dt_last_seen							:=	L.dt_last_seen*100;
		self.rawaid								:=	L.append_rawaid;
		self.aceaid								:=	0; // assigned later
		self.hist								:=	dataset([{L.dt_first_seen*100,L.ln_fares_id,L.did}],recordof(Layouts.layout_ownership_did.hist));	
		self									:=	L;
	end;
	ds_raw	:=	project(Ownership_did_t_base,toOwn(left));

	Layouts.layout_ownership_did addAssess(Layouts.layout_ownership_did L,Ownership_did_t_assess R)	:=	transform
		self.fips_code								:=	if(R.fips_code<>'',R.fips_code,skip);
		self.orig_state							:=	R.state_code;
		self.orig_county							:=	R.county_name;
		self.unformatted_apn						:=	LN_PropertyV2.fn_strip_pnum(R.fares_unformatted_apn,true);
		self.legal_brief_description					:=	R.legal_brief_description;
		self										:=	L;
	end;
	ds_assess_j	:=	join(	ds_raw(hist[1].ln_fares_id[2]='A'),
							Ownership_did_t_assess,
							left.hist[1].ln_fares_id	=	right.ln_fares_id,
							addAssess(left,right)
				);
	Layouts.layout_ownership_did addDeed_xf(Layouts.layout_ownership_did L,Ownership_did_t_deed R)	:=	transform
		self.fips_code								:=	if(R.fips_code<>'',R.fips_code,skip);
		self.orig_state							:=	R.state;
		self.orig_county							:=	R.county_name;
		self.unformatted_apn						:=	LN_PropertyV2.fn_strip_pnum(R.fares_unformatted_apn,true);
		self.legal_brief_description					:=	R.legal_brief_description;
		self										:=	L;
	end;
	ds_deed_j	:=	join(	ds_raw(hist[1].ln_fares_id[2]= 'D') + ds_raw(hist[1].ln_fares_id[1..2] ='OM' ),
						Ownership_did_t_deed,
						left.hist[1].ln_fares_id = right.ln_fares_id,
						addDeed_xf(left,right));

	ds_combined_noaid_od	:=	ds_assess_j(rawaid=0)	+	ds_deed_j(rawaid=0);
	ds_improved := ds_combined_noaid_od(unformatted_apn<>'');
	ds_prop	:=	group(sort(ds_improved,fips_code,unformatted_apn,-dt_last_seen,hist[1].ln_fares_id),fips_code,unformatted_apn);
	ds_curr	:=	ungroup(iterate(ds_prop,transform(Layouts.layout_ownership_did,self.current:=((counter=1) or (left.current and (left.hist[1].ln_fares_id=right.hist[1].ln_fares_id)) or (left.current and (left.dt_last_seen <> 0 and right.dt_last_seen <>0 and left.dt_last_seen = right.dt_last_seen)) ),self:=right)));

	Layouts.layout_ownership_did toRoll(Layouts.layout_ownership_did L,Layouts.layout_ownership_did R)	:=	transform
		self.current		:=	L.current or R.current;			// if any record is the latest,then we're the current owner
		self.dt_first_seen	:=	ut.min2(L.dt_first_seen,	R.dt_first_seen);
		self.dt_last_seen	:=	max(L.dt_last_seen,	R.dt_last_seen);
		self.hist			:=	if((count(L.hist)=LN_PropertyV2.Constants.maxRecsByOwnership),L.hist,L.hist&R.hist);
		self				:=	L;
	end;
	ds_sort         :=	sort(ds_curr,did,fips_code,unformatted_apn,-hist[1].dt_seen,-hist[1].ln_fares_id,-hist[1].owner_did);
	ds_roll_od         :=	rollup(ds_sort,toRoll(left,right),did,fips_code,unformatted_apn);

	j1:= project(	ds_roll_od(aceaid =0), 
					transform({ds_improved, boolean new_flag }, 
						self:=left, 
						self.new_flag := left.current)
			) ;
	d_sort := dedup(sort(j1(prim_range <> '' and prim_name <>'' and zip <>''), 
						did,  prim_range, prim_name, sec_range ,zip, -new_flag,aceaid
					),
				did,  prim_range, prim_name, sec_range ,zip); 

	dsImproved := join(j1 ,d_sort , 
			   left.did = right.did and 
							(left.prim_range = right.prim_range and 
							 left.prim_name = right.prim_name and 
							 left.sec_range = right.sec_range and 
							 left.zip = right.zip)
							 , transform({j1}, 
							 self.new_flag := if(  left.did = right.did and 
							(left.prim_range = right.prim_range and 
							 left.prim_name = right.prim_name and 
							 left.sec_range = right.sec_range and 
							 left.zip = right.zip ) , right.new_flag , left.new_flag) ,  
							 self := left) , left outer ); 
	export	file_ownership_did	:=	project(dsImproved, transform(Layouts.layout_ownership_did, self.current := left.new_flag, self:= left));
	///////////////file_search_fid///////////////////////////
	export file_search_fid(boolean IsFCRA = false) := function
		file_search_bld_Bip := project(file_search_building_did_out, {recordof(file_search_building_did_out),  unsigned8 persistent_record_id := 0}); 
		append_puid_  := ln_propertyV2.fn_append_puid(file_search_bld_Bip);
		append_puid := project(append_puid_, {Layouts.layout_search_building_orig, BIPV2.IDlayouts.l_xlink_ids, 
								string2		ln_party_status,
								string6		ln_percentage_ownership,
								string2		ln_entity_type,
								string8		ln_estate_trust_date,
								string1		ln_goverment_type,
								integer2	xadl2_weight,
								string2 	Addr_ind,
								string1 	Best_addr_ind,
								unsigned6 addr_tx_id,
								string1   best_addr_tx_id,
								unsigned8	Location_id,
								string1   best_locid});

		in_file := append_puid(ln_fares_id <> '');
		d:= in_file(ln_fares_id[1] != 'R');
		d patch_deed_dates(d le, ln_propertyv2_deed ri) := TRANSFORM
			patch_date := ri.recording_date;
			SELF.process_date := IF((unsigned)patch_date=0,le.process_date,patch_date);
			SELF := le;
		END;

		deed_check := JOIN(d(ln_fares_id[2]<>'A'), ln_propertyv2_deed(ln_fares_id[1] != 'R'),
									 LEFT.ln_fares_id=RIGHT.ln_fares_id, patch_deed_dates(LEFT,RIGHT),KEEP(1));

		d patch_assess_dates(d le, ln_propertyv2_tax ri) := TRANSFORM
			patch_date := IF(ri.recording_date != '', ri.recording_date, ri.sale_date);
			SELF.process_date := IF((unsigned)patch_date=0,le.process_date,patch_date);
			SELF := le;
		END;

		assessment_check := JOIN(d(ln_fares_id[2]='A'), ln_propertyv2_tax(ln_fares_id[1] != 'R'), 
												LEFT.ln_fares_id=RIGHT.ln_fares_id, patch_assess_dates(LEFT,RIGHT),KEEP(1));

		all_check := deed_check+assessment_check;

		base_file0 := if(IsFCRA, all_check, in_file);
		LN_PropertyV2_Fast.FCRA_compliance_MAC(isFCRA,base_file0,file_out);
		return  file_out;

	END;
END;