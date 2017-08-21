import LN_PropertyV2, doxie_ln, address, progressive_phone, ut, codes, Census_Data;
import VotersV2, Prof_LicenseV2, eMerges,doxie_files;


export mod_build := 
MODULE


	//********************

	// BUNCH OF PROPERTY WORK

	//********************
		
	export PropFile(
		boolean UseFares
		,unsigned Seed) := 
	FUNCTION

		//****** FILES I NEED
		searchfile := distribute(LN_PropertyV2.file_search_building, hash(ln_fares_id));						 
		assesfile0 := distribute(ln_propertyv2.File_Assessment_building, hash(ln_fares_id));
		assesfile := assesfile0(UseFares or FidelityProp.constants.isFidelity(vendor_source_flag));
		deedfile0 := distribute(ln_propertyv2.File_Deed_building, hash(ln_fares_id));
		deedfile := deedfile0(UseFares or FidelityProp.constants.isFidelity(vendor_source_flag));
		addlfile := ln_propertyv2.File_addl_fares_deed;
		codesv3 := Codes.file_codes_v3_in;


		//****** FIND THE MOST RECENT RECORDS
		cof := doxie_ln.Fn_ComputeOwnerForKeyv2(searchfile,assesfile,deedfile,addlfile).all_prop;

		cofd := 
		dedup(
			sort(
				cof, 
				ln_fares_id[2], 
				prim_range, 
				prim_name, 
				predir,
				zip5,
				sec_range,
				-date,
				-lname,
				-fname
			),
			ln_fares_id[2], 
			prim_range, 
			prim_name, 
			predir,
			zip5,
			sec_range
		);


		//****** PICK UP THE ADDRESS AND FARES IDS
		cof1 := 
		distribute(
			project(
				cofd,
				transform(
					FidelityProp.layouts.from_prop_fid,
					self.ln_fares_id := left.ln_fares_id,
					self.prop__address_1 := Address.Addr1FromComponents(left.prim_range, left.predir, left.prim_name, left.addr_suffix, left.postdir, left.unit_desig, left.sec_range),
					self.prop__city_1 := left.v_city_name;
					self.prop__state_1 := left.st;
					self.prop__zipcode_1 := left.zip5 + if(left.zip4 = '', '', '-' + left.zip4);
					self.prim_range := left.prim_range;
					self.prim_name := left.prim_name;
					self.predir := left.predir;
					self.zip5 := left.zip5;
					self.sec_range := left.sec_range;
					self.date := left.date;
					self := []
				)
			),
			hash(ln_fares_id)
		);


		//****** GET INFO FROM SEARCH FILE
		wsearch0 :=
		join(
			cof1,
			searchfile,  
			left.ln_fares_id = right.ln_fares_id
			and right.source_code = 'OP' and
			right.conjunctive_name_seq in ['','1'],
			transform(
				FidelityProp.layouts.from_prop_fid,
				self.name__owner__1_1 := trim(trim(right.lname) + ' ' + trim(right.fname) + ' ' + trim(right.mname), left, right);
				self.owner_1_did := right.did;
				self.fname := right.fname;
				self.mname := right.mname;
				self.lname := right.lname;
				self.county_code := right.county[3..5],
				self := left
			),
			left outer,
			keep(1),
			local
		);

		wsearch1 :=
		join(
			wsearch0,
			searchfile,
			left.ln_fares_id = right.ln_fares_id
			and right.source_code = 'OP' and
			(right.conjunctive_name_seq = '2' or right.fname <> left.fname or right.lname <> left.lname),
			transform(
				FidelityProp.layouts.from_prop_fid,
				self.name__owner__2_1 := trim(trim(right.lname) + ' ' + trim(right.fname) + ' ' + trim(right.mname), left, right);
				self.owner_2_did := right.did;
				self := left
			),
			left outer,
			keep(1),
			local
		);

		wsearch2 :=
		join(
			wsearch1,
			searchfile,
			left.ln_fares_id = right.ln_fares_id
			and right.source_code = 'SP' and
			right.conjunctive_name_seq in ['','1'],
			transform(
				FidelityProp.layouts.from_prop_fid,
				self.name__seller_1 := trim(trim(right.lname) + ' ' + trim(right.fname) + ' ' + trim(right.mname), left, right);
				self.seller_1_did := right.did;
				self := left
			),
			left outer,
			keep(1),
			local
		);

		wsearch :=
		join(
			wsearch2,
			searchfile,
			left.ln_fares_id = right.ln_fares_id
			and right.source_code = 'SP' and right.conjunctive_name_seq = '2',
			//(right.conjunctive_name_seq = '2' or right.fname <> left.fname or right.lname <> left.lname),
			transform(
				FidelityProp.layouts.from_prop_fid,
				self.name__seller_2_1 := trim(trim(right.lname) + ' ' + trim(right.fname) + ' ' + trim(right.mname), left, right);
				self.seller_2_did := right.did;
				self := left
			),
			left outer,
			keep(1),
			local
		);

		//****** GET INFO FROM DEED FILE
		wdeed :=
		join(
			wsearch(ln_fares_id[2] = 'D'),
			deedfile, 
			left.ln_fares_id = right.ln_fares_id,
			transform(
				FidelityProp.layouts.from_prop_fid,
				// self.name__owner__1_1 := right.name1,   //should i check buyer or borrower ind ??
				// self.name__owner__2_1 := right.name2,   //should i check buyer or borrower ind ??
				self.sale__date_1 := right.contract_date;
				self.recording__date_1 := right.recording_date;
				self.sale__price_1 := right.sales_price,
				// self.name__seller_1 := right.seller1,		//there is also seller2
				self.mortgage__amount_1 := 
				if(
					(integer)right.first_td_loan_amount + (integer)right.second_td_loan_amount > 0, 
					(string)((integer)right.first_td_loan_amount + (integer)right.second_td_loan_amount) , 
					''
				);
				self.legal__description_1 := right.legal_brief_description;
				self.parcel__number_1 := right.apnt_or_pin_number;
				self.deed_ln_fares_id := right.ln_fares_id;
				self.first_td_loan_type_code := right.first_td_loan_type_code; 
				self := left
			),
			left outer,
			local
		);


		//****** GET INFO FROM ASSESSOR FILE
		wassess :=
		join(
			wsearch(ln_fares_id[2] = 'A'),
			assesfile,  
			left.ln_fares_id = right.ln_fares_id,
			transform(
				FidelityProp.layouts.from_prop_fid,
				// self.name__owner__1_1 := right.assessee_name,  //doubt i will use this
				// self.name__owner__2_1 := right.second_assessee_name,  //doubt i will use this
				self.legal__description_1 := right.legal_brief_description,
				self.sale__date_1 := right.sale_date;
				self.recording__date_1 := right.recording_date;
				self.sale__price_1 := right.sales_price,
				self.mortgage__amount_1 := right.mortgage_loan_amount,
				self.assessed__value_1 := right.assessed_total_value;
				self.total__market__value_1 := right.market_total_value;
				self.tax_year_1 := right.tax_year;
				self.assessed_value_year_1 := right.assessed_value_year;
				self.parcel__number_1 := right.apna_or_pin_number;
				self.assessor_ln_fares_id := right.ln_fares_id;
				self.total__value_1 := 
				if(
					(integer)right.assessed_total_value > (integer)right.market_total_value,
					right.assessed_total_value,
					right.market_total_value
				);
				self := left
			),
			left outer,
			local
		);



		//****** PUT ALL THE PROPERTY INFO TOGETHER IN ONE RECORD
		strleft := 'left';
		strright := 'right';
			
		pick(string l1, string l2, unsigned4 ldate, string r1, string r2, unsigned4 rdate) :=
		FUNCTION

			
			whichuse :=
			map(
				ldate div 10000 - rdate div 10000 > 1 and l1 <> '' => strleft,
				rdate div 10000 - ldate div 10000 > 1 and r1 <> '' => strright,
				l1 <> '' and l2 <> '' => strleft,
				r1 <> '' and r2 <> '' => strright,
				l1 <> ''							=> strleft,
																 strright
			);

			return whichuse;
		end;

		wboth :=
		join(
			wdeed,
			wassess,
			left.prim_range = right.prim_range and
			left.prim_name = right.prim_name and
			left.predir = right.predir and
			left.sec_range = right.sec_range and
			left.zip5 = right.zip5,
			transform(
				FidelityProp.layouts.from_prop_fid,
				//from deed first, then assess		
				self.sale__date_1 := if(left.sale__date_1 = '', right.sale__date_1, left.sale__date_1);
				self.recording__date_1 := if(left.recording__date_1 = '', right.recording__date_1, left.recording__date_1);
				self.sale__price_1 := if(left.sale__price_1 = '', right.sale__price_1, left.sale__price_1);
				self.mortgage__amount_1 := if(left.mortgage__amount_1 = '', right.mortgage__amount_1, left.mortgage__amount_1);
				//from deed
				self.name__seller_1 := left.name__seller_1,
				self.seller_1_did := left.seller_1_did,
				self.name__seller_2_1 := left.name__seller_2_1,
				self.seller_2_did := left.seller_2_did,
				self.deed_ln_fares_id := left.deed_ln_fares_id,
				//from asses first, then deed
				self.legal__description_1 := if(right.legal__description_1 = '', left.legal__description_1, right.legal__description_1),
				self.parcel__number_1 := if(right.parcel__number_1 = '', left.parcel__number_1, right.parcel__number_1),
				//from asses
				self.assessed__value_1 := right.assessed__value_1,
				self.total__market__value_1 := right.total__market__value_1,
				self.tax_year_1 := right.tax_year_1,
				self.assessed_value_year_1 := right.assessed_value_year_1,
				self.total__value_1 := right.total__value_1,
				self.assessor_ln_fares_id := right.assessor_ln_fares_id,
				//from search
				useLeft := (strleft = pick(left.name__owner__1_1, left.name__owner__2_1, left.date, right.name__owner__1_1, right.name__owner__2_1, right.date));
				self.name__owner__1_1	:= if(useLeft, left.name__owner__1_1,	right.name__owner__1_1);
				self.name__owner__2_1	:= if(useLeft, left.name__owner__2_1,	right.name__owner__2_1);
				self.owner_1_did			:= if(useLeft, left.owner_1_did,			right.owner_1_did);
				self.owner_2_did			:= if(useLeft, left.owner_2_did,			right.owner_2_did);
				self									:= if(useLeft, left,									right);
			),
			full outer,
			HASH 
		);

		//***** Get the transaction type
		wtt :=
		join(
			distribute(wboth(deed_ln_fares_id <> ''), hash(deed_ln_fares_id)),
			distribute(addlfile(ln_fares_id <> ''), hash(ln_fares_id)),
			left.deed_ln_fares_id = right.ln_fares_id,
			transform(
				FidelityProp.layouts.from_prop_fid,
				self.fares_transaction_type_code := right.fares_transaction_type,
				self := left
			),
			left outer,
			LOCAL
		) +
		wboth(deed_ln_fares_id = '');

		//***** Decode the transaction type
		wtt_decode :=
		join(
			wtt,
			codesv3(file_name = 'FARES_1080' and field_name ='TRANSACTION_TYPE' and field_name2 = 'FAR_F'),
			left.fares_transaction_type_code = right.code,
			transform(
				FidelityProp.layouts.from_prop_fid,
				self.fares_transaction_type := right.long_desc,
				self := left
			),
			left outer,
			lookup
		);


//***** Decode the transaction loan type
		wtt_decode1 :=
		join(
			wtt_decode,
			codesv3(file_name = 'FARES_1080' and field_name ='MORTGAGE_LOAN_TYPE_CODE' and field_name2 in ['OKCTY','DAYTN','FAR_F','FAR_S']),
			left.first_td_loan_type_code = right.code,
			transform(
				FidelityProp.layouts.from_prop_fid,
			//	self.fares_transaction_type := if( left.fares_transaction_type <>'' and right.long_desc,
				self.Fidelity_transaction_type := right.long_desc ; 
				self := left
			),
			left outer,
			lookup
		);
		//***** Decode the county
			Census_Data.MAC_Fips2County(wtt_decode1,prop__state_1, county_code, county, wcounty)

		//***** Add an acctno
		wbothseq :=
		project(
			wcounty(name__owner__1_1 <> ''),  //filter out if we have no owner
			transform(
				FidelityProp.layouts.from_prop_fid,
				self.acctno := (string)(counter + Seed);
				self := left
			)
		);

		return wbothseq;
		
	END;//PropFile


	//*****************************************
	// Lookup DOB via DID from various sources
	//*****************************************
	export dataset(layouts.from_prop_fid_dob) AddDOB(dataset(layouts.from_prop_fid) ds_in) := function
		
		// some handy layouts
		l_out := FidelityProp.layouts.from_prop_fid_dob;
		l_tmp := record
			unsigned6	did;
			string8		dob_voter;
			string8		dob_proflic;
			string8		dob_ccw;
			string8		dob_hunt;
			string8   dob_crim; 
			string8		dt_last_seen;
		end;
		l_thin := record
			unsigned6	did;
			string8		dob;
			string8		dt_last_seen;
		end;
		
		// extract DIDs from ds_in
		did_raw := normalize(ds_in, 3, transform(l_tmp,
			self.did := case(counter,
				1 => left.owner_1_did,
				2 => left.owner_2_did,
				3 => left.seller_1_did,
				4 => left.seller_2_did,
				0
			);
			self := [];
		));
		did_dist := distribute(did_raw, hash(did));
		ds_dids := dedup(sort(did_dist(did<>0), did, local), did, local);
		
		// append DOB from voter registration
		f_vote := distribute(VotersV2.File_Voters_Building(did<>0,dob<>''), hash(did));
		ds_vote_raw := join(
			ds_dids, f_vote,
			left.did=right.did,
			transform(l_tmp,
				self.dob_voter		:= right.dob;
				self.dt_last_seen	:= right.date_last_seen;
				self := left
			),
			left outer, local
		);
		ds_vote := dedup(sort(ds_vote_raw, did, -dt_last_seen, local), did, local);
		
		// append DOB from professional licenses
		f_proflic := distribute(
			project(
				Prof_LicenseV2.File_Proflic_Base_Tiers(dob<>''),
				transform(l_thin,
					did := (unsigned6)left.did;
					self.did := if(did<>0,did,skip);
					self.dob := left.dob;
					self.dt_last_seen := left.date_last_seen;
				)
			),
			hash(did)
		);
		ds_proflic_raw := join(
			ds_vote, f_proflic,
			left.did=right.did,
			transform(l_tmp,
				self.dob_proflic	:= right.dob;
				self.dt_last_seen	:= right.dt_last_seen;
				self := left
			),
			left outer, local
		);
		ds_proflic := dedup(sort(ds_proflic_raw, did, -dt_last_seen, local), did, local);
		
		// append DOB from ccw
		f_ccw := distribute(
			project(
				pull(eMerges.key_ccw_rid(false))(dob<>''),
				transform(l_thin,
					did := (unsigned6)left.did_out;
					self.did := if(did<>0,did,skip);
					self.dob := left.dob;
					self.dt_last_seen := if(left.date_last_seen<>'',left.date_last_seen,left.file_acquired_date);
				)
			),
			hash(did)
		);
		ds_ccw_raw := join(
			ds_proflic, f_ccw,
			left.did=right.did,
			transform(l_tmp,
				self.dob_ccw			:= right.dob;
				self.dt_last_seen	:= right.dt_last_seen;
				self := left
			),
			left outer, local
		);
		ds_ccw := dedup(sort(ds_ccw_raw, did, -dt_last_seen, local), did, local);
		
		// append DOB from hunt
		f_hunt := distribute(
			project(
				pull(eMerges.Key_HuntFish_Rid(false))(dob<>''),
				transform(l_thin,
					did := (unsigned6)left.did_out;
					self.did := if(did<>0,did,skip);
					self.dob := left.dob;
					self.dt_last_seen := if(left.date_last_seen<>'',left.date_last_seen,left.file_acquired_date);
				)
			),
			hash(did)
		);
		ds_hunt_raw := join(
			ds_ccw, f_hunt,
			left.did=right.did,
			transform(l_tmp,
				self.dob_hunt			:= right.dob;
				self.dt_last_seen	:= right.dt_last_seen;
				self := left
			),
			left outer, local
		);
		ds_hunt := dedup(sort(ds_hunt_raw, did, -dt_last_seen, local), did, local);
		
	//append dob from crim 
	
	f_crim := distribute(
			project(
				pull(doxie_files.key_offenders())(dob<>''),
				transform(l_thin,
					did := (unsigned6)left.sdid;
					self.did := if(did<>0,did,skip);
					self.dob := left.dob;
					self.dt_last_seen := left.src_upload_date; //if(left.date_last_seen<>'',left.date_last_seen,left.file_acquired_date);
				)
			),
			hash(did)
		);
		ds_crim_raw := join(
			ds_hunt, f_crim,
			left.did=right.did,
			transform(l_tmp,
				self.dob_crim			:= right.dob;
				self.dt_last_seen	:= right.dt_last_seen;
				self := left
			),
			left outer, local
		);
		ds_crim := dedup(sort(ds_crim_raw, did, -dt_last_seen, local), did, local);
		
		// populate DOB info in full layout
		
		ds_full0a := join(
			distribute(ds_in(owner_1_did<>0),hash(owner_1_did)), ds_crim,
			left.owner_1_did=right.did,
			transform(l_out,
				self.owner_1_dob_voter		:= right.dob_voter;
  			self.owner_1_dob_proflic	:= right.dob_proflic;
  			self.owner_1_dob_ccw			:= right.dob_ccw;
  			self.owner_1_dob_hunt			:= right.dob_hunt;
				self.owner_1_dob_crim     := right.dob_crim; 
				self := left;
				self := [];
			),
			left outer, local
		);
		ds_full0b := project(ds_in(owner_1_did=0), transform(l_out, self:=left;self:=[])) + ds_full0a;
		
		ds_full1a := join(
			distribute(ds_full0b(owner_2_did<>0),hash(owner_2_did)), ds_crim,
			left.owner_2_did=right.did,
			transform(l_out,
				self.owner_2_dob_voter		:= right.dob_voter;
  			self.owner_2_dob_proflic	:= right.dob_proflic;
  			self.owner_2_dob_ccw			:= right.dob_ccw;
  			self.owner_2_dob_hunt			:= right.dob_hunt;
				self.owner_2_dob_crim     := right.dob_crim; 
				self := left;
			),
			left outer, local
		);
		ds_full1b := ds_full0b(owner_2_did=0)+ds_full1a;
		
		ds_full2a := join(
			distribute(ds_full1b(seller_1_did<>0),hash(seller_1_did)), ds_crim,
			left.seller_1_did=right.did,
			transform(l_out,
				self.seller_1_dob_voter		:= right.dob_voter;
  			self.seller_1_dob_proflic	:= right.dob_proflic;
  			self.seller_1_dob_ccw			:= right.dob_ccw;
  			self.seller_1_dob_hunt		:= right.dob_hunt;
				self.seller_1_dob_crim    := right.dob_crim; 

				self := left;
			),
			left outer, local
		);
		ds_full2b1 := ds_full1b(seller_1_did=0)+ds_full2a;
		
		ds_full2a1 := join(
			distribute(ds_full2b1(seller_2_did<>0),hash(seller_2_did)), ds_crim,
			left.seller_2_did=right.did,
			transform(l_out,
				self.seller_2_dob_voter		:= right.dob_voter;
  			self.seller_2_dob_proflic	:= right.dob_proflic;
  			self.seller_2_dob_ccw			:= right.dob_ccw;
  			self.seller_2_dob_hunt		:= right.dob_hunt;
				self.seller_2_dob_crim    := right.dob_crim; 

				self := left;
			),
			left outer, local
		);
		ds_full2b := ds_full2b1(seller_2_did=0)+ds_full2a1;
		
		results := ds_full2b;
		
		// Stats
		output(count(ds_dids),									named('num_dids'),				overwrite);
		output(count(ds_crim(dob_voter<>'')),		named('num_dob_voter'),		overwrite);
		output(count(ds_crim(dob_proflic<>'')),	named('num_dob_proflic'),	overwrite);
		output(count(ds_crim(dob_ccw<>'')),			named('num_dob_ccw'),			overwrite);
		output(count(ds_crim(dob_hunt<>'')),		named('num_dob_hunt'),		overwrite);
		output(count(ds_crim(dob_crim<>'')),		named('num_dob_crim'),		overwrite);
		output(count(ds_crim(dob_voter<>'' or dob_proflic<>'' or dob_ccw<>'' or dob_hunt<>'' or dob_crim <>'')), named('num_dob_any'), overwrite);
		
		return results;
	
	end;


	//********************

	// CALL PROGRESSIVE PHONES

	//********************
	
	export ProgressivePhones(
		// string8 date, 
		dataset(FidelityProp.layouts.from_prop_fid_dob) wbothseq) := 
	FUNCTION


		layout_progressive_batch_in := progressive_phone.layout_progressive_batch_in;

		layout_progressive_batch_in get_in(wbothseq l) := transform
			// clean_name := Address.CleanPersonFML73(l.name__owner__1_1);
			// clean_addr := Address.CleanAddress182(trim(l.address), trim(l.city) + ',' + trim(l.st) + ' ' + trim(l.zip));
			self.acctno := l.acctno;
			self.name_first := l.fname;
			self.name_middle := l.mname;
			self.name_last := l.lname;
			self.name_suffix := '';
			self.phoneno := '';//l.HomePhone;
			self.prim_range := l.prim_range;
			self.predir := l.predir;
			self.prim_name := l.prim_name;
			self.suffix := '';
			self.postdir := '';
			self.unit_desig := '';
			self.sec_range := l.sec_range;
			self.p_city_name := l.prop__city_1;
			self.st := l.prop__state_1;
			self.z5 := l.prop__zipcode_1[1..5];
			self.z4 := l.prop__zipcode_1[7..];
			self.ssn := '';//intformat((unsigned)l.ssn, 9, 1);
			self.dob := '';
			self := [];
		end;

		f_test_in := distribute(project(wbothseq, get_in(left))(z5 <> '' and prim_name <> ''), hash(acctno) % 100);


		roxie_ip := 'roxiebatch.br.seisint.com:9856';
		// roxie_ip := 'roxieqavip.br.seisint.com:9856';
		//roxie_ip := 'roxiedevvip.sc.seisint.com:9876';
		//roxie_ip := '10.173.195.5:9876';
		//roxie_ip := '10.173.202.5:9876';
		//roxie_ip := 'roxiedevvip.sc.seisint.com:9876';
			
		// layout_progressive_batch_out := progressive_phone.layout_progressive_batch_out;
		layout_progressive_batch_out := record(progressive_phone.layout_progressive_batch_out)
			string8 search_date;
			string8 subj_phone_date_last;
			unsigned6 did;
			integer1 sort_order_position;
			string4 royalty_type;
		end;
		
		insize := sizeof(layout_progressive_batch_in);	
		outsize := sizeof(layout_progressive_batch_out);
				
		//We want to use levels 1, 2, 3, and 6 (ES, SE, AP, PP)		
		out_data := PIPE(f_test_in, 'roxiepipe -iw '+ insize +' -t 1 -ow '
										+ outsize +' -b 10 -mr 2 -q "'
										+ '<progressive_phone.progressive_phone_batch_service  format=\'raw\'>'
										+ '<DedupOutputPhones>true</DedupOutputPhones>' 
										+ '<MaxPhoneCount>1000</MaxPhoneCount>'
										+ '<CountType1_Es_EDASEARCH>1</CountType1_Es_EDASEARCH>' 
										+ '<CountType2_Se_SKIPTRACESEARCH>1</CountType2_Se_SKIPTRACESEARCH>' 
										+ '<CountType3_Ap_PROGRESSIVEADDRESSSEARCH>1</CountType3_Ap_PROGRESSIVEADDRESSSEARCH>' 
										+ '<CountType4_Sp_POSSIBLESPOUSE>0</CountType4_Sp_POSSIBLESPOUSE>' 
										+ '<CountType4_Md_POSSIBLEPARENTS>0</CountType4_Md_POSSIBLEPARENTS>' 
										+ '<CountType4_Cl_CLOSESTRELATIVE>0</CountType4_Cl_CLOSESTRELATIVE>' 
										+ '<CountType4_Cr_CORESIDENT>0</CountType4_Cr_CORESIDENT>' 
										+ '<CountType5_Sx_EXPANDEDSKIPTRACESEARCH>0</CountType5_Sx_EXPANDEDSKIPTRACESEARCH>' 
										+ '<CountType6_Pp_PHONESPLUSSEARCH>1</CountType6_Pp_PHONESPLUSSEARCH>' 
										+ '<CountType7_UNVERIFIEDPHONE>0</CountType7_UNVERIFIEDPHONE>' 
										+ '<CountType_Ne_CLOSESTNEIGHBOR>0</CountType_Ne_CLOSESTNEIGHBOR>' 
										+ '<CountType_Wk_PEOPLEATWORK>0</CountType_Wk_PEOPLEATWORK>' 
										+ '<CountType_Rl_POSSIBLERELOCATION>0</CountType_Rl_POSSIBLERELOCATION>' 
										+ '<batch_in id=\'id\' format=\'raw\'></batch_in>'
										+ '</progressive_phone.progressive_phone_batch_service>" -h ' 
										+ roxie_ip + ' -vip -r Results', layout_progressive_batch_out);


		od_dist := distribute(out_data, hash(acctno));
		od_srt := sort(od_dist, acctno, sort_order, record, local);
		od_ddp := dedup(od_srt, acctno, local);
		od_p := 
		project(
			od_ddp,
			transform(
				FidelityProp.layouts.from_phone_plus,
				self.subj_first_1 := left.subj_first;
				self.subj_middle_1 := left.subj_middle;
				self.subj_last_1 := left.subj_last;
				self.subj_suffix_1 := left.subj_suffix;
				self.subj_phone10_1 := left.subj_phone10;
				self.subj_name__dual_1 := left.subj_name_dual;
				self.subj_phone_type_1 := left.subj_phone_type;
				self.subj_date_first_1 := left.subj_date_first;
				self.subj_date_last_1 := left.subj_date_last;
				self.acctno := left.acctno;
			)
		);





		//***** PUT TOGETHER THE PROPERTY AND PHONE INFO

		j :=
		join(
			wbothseq,
			od_p,
			left.acctno = right.acctno,
			transform(
				 FidelityProp.layouts.out_dob,
				//FidelityProp.layouts.out,
				self := right,
				self := left
			),
			left outer,
			hash
		) : independent;
		
		return j;
		
	END;//ProgressivePhones
	
	export CombineProp(
		dataset(FidelityProp.layouts.from_prop_fid) yesfares,
		dataset(FidelityProp.layouts.from_prop_fid) nofares) :=
	FUNCTION
	
		justfares :=
		join(
			yesfares,
			nofares,
			left.prim_range = right.prim_range and
			left.prim_name = right.prim_name and
			left.predir = right.predir and
			left.sec_range = right.sec_range and
			left.zip5 = right.zip5,
			hash,
			left only
		);

		both := nofares + justfares;

		return both;
	
	END;
	
	// =-=-=-= STEP 1a =-=-=-=
	export DoProp() :=
	FUNCTION
		yesfares := PropFile(true, Seed := 0)	: independent;
		no_fares := PropFile(false, Seed := max(yesfares, (unsigned)Acctno))	: independent;
		both 		 := CombineProp(yesfares, no_fares)	: independent;
		return both;
		// do_output := output(both,, '~thor_data400::cemtemp::wbothseq_'+in_date, overwrite);
		// myreturn := both : success(do_output);
		// return myreturn;
	END;
	
	// =-=-=-= STEP 1b =-=-=-=
	export DoPropDOB(
		dataset(layouts.from_prop_fid) in_prop) := 
	FUNCTION
		wdob			:= AddDOB(in_prop);
		return wdob;
		// do_output	:= output(wdob,,'~thor_data400::cemtemp::wdob_'+ in_date, overwrite);
		// myreturn	:= wdob : success(do_output);
		// return myreturn;
	END;
	
	// =-=-=-= STEP 2 =-=-=-=
	export DoPropWPhones(
		dataset(FidelityProp.layouts.from_prop_fid_dob) prop) :=
	FUNCTION
		wpho := ProgressivePhones(prop);
		return wpho;
		// do_output := output(wpho,,'~thor_data400::cemtemp::j_'+in_date, overwrite);
		// myreturn := wpho : success(do_output);
		// return myreturn;
	END;

	// =-=-=-= STEP 3 =-=-=-=
	export DoPatch(
		// NOTE: These types can be changed to out_dob as needed
		dataset(FidelityProp.layouts.out_dob) inf,
		dataset(FidelityProp.layouts.out_dob) prev) :=
	FUNCTION
		l_thin := record
			prev.parcel__number_1;
			prev.name__owner__1_1;
			prev.prop__address_1;
			prev.prop__zipcode_1;
			prev.sale__date_1;
			prev.name__seller_1;
		end;
		prev_thin := project(prev, l_thin);
		outf := join(
			inf, prev_thin,
			left.parcel__number_1=right.parcel__number_1
				and left.name__owner__1_1=right.name__owner__1_1
				and left.prop__address_1=right.prop__address_1
				and left.prop__zipcode_1=right.prop__zipcode_1
				and left.sale__date_1=right.sale__date_1,
			transform(recordof(inf), self.name__seller_1:=if(left.name__seller_1<>'',left.name__seller_1,right.name__seller_1),self:=left), 
			//self.name__seller_2:=if(left.name__seller_2<>'',left.name__seller_2,right.name__seller_2), self:=left),
			left outer, keep(1), hash
		);
		output(count(inf), named('num_inf'), overwrite);
		output(count(prev), named('num_prev'), overwrite);
		output(count(outf), named('num_outf'), overwrite);
		output(count(inf(name__seller_1<>'')), named('num_inf_sellers'), overwrite);
		output(count(prev(name__seller_1<>'')), named('num_prev_sellers'), overwrite);
		output(count(outf(name__seller_1<>'')), named('num_outf_sellers'), overwrite);
		/*	output(count(inf(name__seller_2<>'')), named('num_inf_sellers2'), overwrite);
		output(count(prev(name__seller_2<>'')), named('num_prev_sellers2'), overwrite);
		output(count(outf(name__seller_2<>'')), named('num_outf_sellers2'), overwrite);*/
		output(inf(parcel__number_1='05022-38-021-021'), named('inf_sample'), overwrite);
		output(prev(parcel__number_1='05022-38-021-021'), named('prev_sample'), overwrite);
		output(outf(parcel__number_1='05022-38-021-021'), named('outf_sample'), overwrite);
		
		return outf;
	END;
	
	// =-=-=-= Part of the "QA" Step 4 =-=-=-=
	export DoCounts(
		dataset(FidelityProp.layouts.from_prop_fid_dob) wbothseq,
		dataset(FidelityProp.layouts.out_dob) j,
		dataset(FidelityProp.layouts.from_prop_fid_dob) wbothseq_prev,
		dataset(FidelityProp.layouts.out_dob) j_prev) :=
	FUNCTION

		isFares(string fid) := fid <> '' and fid[1] = 'R';
		fcount := count(wbothseq(isFares(assessor_ln_fares_id) or isFares(deed_ln_fares_id)));
		tcount := count(j);
		pcount := count(j(subj_phone10_1 <> ''));
		
		fcount_prev := count(wbothseq_prev(isFares(assessor_ln_fares_id) or isFares(deed_ln_fares_id)));
		tcount_prev := count(j_prev);
		pcount_prev := count(j_prev(subj_phone10_1 <> ''));
		
		a2 := output(fcount_prev, named('fares_count_previous'));
		a3 := output(tcount_prev, named('total_count_previous'));
		a4 := output(pcount_prev, named('phone_count_previous'));

		b2 := output(fcount, named('fares_count'));
		b3 := output(tcount, named('total_count'));
		b4 := output(pcount, named('phone_count'));
		
		return sequential(a2,a3,a4,b2,b3,b4);
	END;
	
END;