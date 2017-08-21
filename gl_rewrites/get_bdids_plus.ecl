import business_header,business_header_ss,doxie,ut;
export get_bdids_plus(
	gl_rewrites.business_interfaces.i__get_bdids_plus in_parms) :=
		function
			WORD_SEARCH_MAX := 10000;
			EXACT_NAME_MAX := 10000;
			
			word_header_index := Business_Header_SS.Key_BH_Header_Words;
			bdid_city_zip_fein_phone_index := Business_Header_SS.Key_BH_BDID_City_Zip_Fein_Phone;
			fein_bdid_index := Business_Header_SS.Key_BH_FEIN;
			phone_bdid_index := Business_Header_SS.Key_BH_Phone;

			layout_res := RECORD
				UNSIGNED6 bdid;
				UNSIGNED1 seq;
				boolean did_skip := false;
			END;

			company_name_matchable := in_parms.company_name_val_filt != '';
			addr_matchable := exists(in_parms.precs(prim_name <> '' and (integer)z5 > 0));
			phone_matchable := in_parms.phone_value <> '';
			fein_matchable := in_parms.fein_Value <> 0;
			exec_matchable := trim(in_parms.lname_value) <> '';

			word_search_only := company_name_matchable AND ~phone_matchable AND ~fein_matchable AND ~addr_matchable;
			phone_only := phone_matchable AND ~company_name_matchable AND ~fein_matchable AND ~addr_matchable;
			fein_only := fein_matchable AND ~company_name_matchable AND ~phone_matchable AND ~addr_matchable;
			exec_only := exec_matchable AND ~company_name_matchable AND ~phone_matchable AND ~fein_matchable AND ~addr_matchable;

			//--------------------------------
			// Exact Company Name match.
			//--------------------------------
			string81 clean_company_name_value := ut.CleanCompany(in_parms.company_name_value);

			// Still needs a LIMIT or CHOOSEN here
			exact_name_index_0 := business_header_ss.key_bh_companyname_unlimited(
														clean_company_name_value[1..20] = clean_company_name20,
														clean_company_name_value[21..80] = '' or
														clean_company_name_value[21..80] = clean_company_name60);

			//rzip := bdid_city_zip_fein_phone_index.zip;
			boolean IsValidZip (integer rzip) := 
				(in_parms.state_value in ['CT','MA','ME','NH','NJ','PR','RI','VT','VI','AE'] and rzip >= 0 and rzip <= 09999) or
				(in_parms.state_value in ['DE','NY','PA'] and rzip >= 10000 and rzip <= 19999) or
				(in_parms.state_value in ['DC','MD','NC','SC','VA','WV'] and rzip >= 20000 and rzip <= 29999) or
				(in_parms.state_value in ['AL','FL','GA','MS','TN','AA'] and rzip >= 30000 and rzip <= 39999) or
				(in_parms.state_value in ['IN','KY','MI','OH'] and rzip >= 40000 and rzip <= 49999) or
				(in_parms.state_value in ['IA','MN','MT','ND','SD','WI'] and rzip >= 50000 and rzip <= 59999) or
				(in_parms.state_value in ['IL','KS','MO','NE'] and rzip >= 60000 and rzip <= 69999) or
				(in_parms.state_value in ['AR','LA','OK','TX'] and rzip >= 70000 and rzip <= 79999) or
				(in_parms.state_value in ['AZ','CO','ID','NM','NV','UT','WY'] and rzip >= 80000 and rzip <= 89999) or
				(in_parms.state_value in ['AK','AS','CA','GU','HI','MP','OR','WA','AP'] and rzip >= 90000 and rzip <= 99999);

			// No more than EXACT_NAME_MAX records required later
			// stat for maximum bdid+city is ~10000
			exact_name_index := map(in_parms.zip_val = '' and in_parms.state_value <> '' and in_parms.city_value <> '' =>
															join(exact_name_index_0, bdid_city_zip_fein_phone_index,
																	 keyed(left.bdid=right.bdid) and
																	 keyed(right.city=in_parms.city_value) and IsValidZip (right.zip),
																	 KEEP (EXACT_NAME_MAX + 1), LIMIT (2 * ut.limits. DEFAULT, SKIP)),
															in_parms.zip_val = '' and in_parms.city_value <> '' =>
															join(exact_name_index_0, bdid_city_zip_fein_phone_index,
																	 keyed(left.bdid=right.bdid) and
																	 keyed(right.city=in_parms.city_value),
																	 KEEP (EXACT_NAME_MAX + 1)),
															in_parms.zip_val = '' and in_parms.state_value <> '' =>
															join(exact_name_index_0, bdid_city_zip_fein_phone_index,
																	 keyed(left.bdid=right.bdid) and IsValidZip (right.zip),
																	 KEEP (EXACT_NAME_MAX + 1), LIMIT (2 * ut.limits. DEFAULT, SKIP)),
															join(exact_name_index_0, bdid_city_zip_fein_phone_index,
																	 false,left outer, KEEP (EXACT_NAME_MAX + 1)));

			layout_res ExactToResLayout(exact_name_index l) := TRANSFORM	
				self.seq := 0;
				SELF := l;
			END;

			res_exact_name := PROJECT(exact_name_index, ExactToResLayout(LEFT));

			recordof(word_header_index) ExactToWordIndexLayout(exact_name_index l) := TRANSFORM	
				self.seq := 1;
				self.word := clean_company_name_value;
				self.state := '';
				self.bh_filepos := 0;
				self.__filepos := 0;
				SELF := l;
			END;

			word_exact_name := PROJECT(exact_name_index, ExactToWordIndexLayout(LEFT));

			//--------------------------------
			// Word Company Name match.
			//--------------------------------


			index_word_filt(boolean counting) := 
												word_header_index(company_name_matchable,
												keyed(in_parms.company_name_val_filt = word[1..LENGTH(TRIM(in_parms.company_name_val_filt))] or
												(in_parms.company_name_val_filt2 <> '' and in_parms.company_name_val_filt2 = word[1..LENGTH(TRIM(in_parms.company_name_val_filt2))])
												), 
												 counting OR wild(state) AND (in_parms.state_value = '' or in_parms.state_value = state));

			//if some exact matches and too many word matches, just use exact rather than fail
			index_word_only := IF(word_search_only and count(index_word_filt(true)) >= 20000, 
														IF(exists(exact_name_index_0), 
															 word_exact_name,
															 LIMIT(index_word_filt(false),20000, FAIL(11,doxie.ErrorCodes(11)),keyed,count)),
														CHOOSEN(SORT(LIMIT(index_word_filt(false),20000,SKIP,keyed,count),
																				 ut.stringsimilar(word, in_parms.company_name_val_filt), 
																				 bdid),5000));

			layout_index_filter := RECORD
				Business_Header_SS.Layout_Header_Word_Index;
				QSTRING25 city;
				UNSIGNED3 zip;
				UNSIGNED4 fein;
				UNSIGNED4 phone;
			END;

			layout_index_filter AddFilterFields(word_header_index l, in_parms.precs r) := TRANSFORM
				SELF.city := r.p_city_name;
				SELF.zip := (UNSIGNED3)r.z5;
				SELF.fein := (integer)r.fein;
				SELF.phone := (UNSIGNED4)r.phone10;
				SELF := l;
			END;

			//index_prefilter := PROJECT(index_word_only, AddFilterFields(LEFT));
			index_prefilter := join(index_word_only, in_parms.precs, true, AddFilterFields(left, right), all);
				
			TYPEOF(index_prefilter) TakeLast(index_prefilter r) := TRANSFORM
				SELF := r;
			END;

			index_filtered := JOIN(	index_prefilter, bdid_city_zip_fein_phone_index, 
									LEFT.bdid = RIGHT.bdid AND
									(LEFT.city = '' OR LEFT.city = RIGHT.city OR LEFT.zip != 0) AND
									(LEFT.zip = 0 OR LEFT.zip = RIGHT.zip) AND
									(LEFT.fein = 0 OR LEFT.fein = RIGHT.fein) AND
									(LEFT.phone = 0 OR LEFT.phone = RIGHT.phone),
									TakeLast(LEFT), LIMIT (ut.limits.DEFAULT, SKIP));

			TYPEOF(word_header_index) SlimBack(index_prefilter l) := TRANSFORM
				SELF.__filepos := 0;
				SELF := l;
			END;

			filterable := 	in_parms.city_value != '' OR 
							in_parms.zip_val != '' OR 
							in_parms.fein_value != 0 OR
							in_parms.phone_value != '';

			res_full := IF(filterable, 
								PROJECT(index_filtered, SlimBack(LEFT)),
								index_word_only);

			layout_res NameToResLayout(word_header_index l) := TRANSFORM	
				SELF := l;
			END;

			res_partial_name := PROJECT(res_full, NameToResLayout(LEFT));

			//--------------------------------
			// Normal match using the slimsorts.
			//--------------------------------
			layout_res NormalToResLayout(Business_Header_SS.Layout_BDID_OutBatch l) := TRANSFORM	
				SELF.seq := 1;
				SELF.bdid := l.bdid;
			END;

			Business_Header_SS.MAC_BDID_Append(
				in_parms.precs,
				res_normal_bdid,
				0,
				WORD_SEARCH_MAX,
				false)


			// no more than that needed later (compared with WORD_SEARCH_MAX)
			res_name_words := CHOOSEN (res_partial_name	+ PROJECT(res_normal_bdid, NormalToResLayout(LEFT)), 
																 WORD_SEARCH_MAX + 1);

			//---------------------------
			// Address-Only Match
			//---------------------------
			doxie.layout_addressSearch trafam(in_parms.precs l) := transform
				self.state := l.st;
				self.zip := l.z5;
				self := l;
			end;

			fam := project(in_parms.precs, trafam(left));
			by_addr := Doxie.bdid_from_address(fam, true, company_name_matchable, 100);

			layout_res addr_into_res(by_addr L, integer C) := transform
				self.bdid := L.bdid;
				self.seq := C;
				self.did_skip := l.did_skip;
			end;

			fetched_by_addr := project(by_addr(bdid != 0),addr_into_res(LEFT,COUNTER));

			//--------------------------------
			// Phone / FEIN / Exec match.
			//--------------------------------

			res_phone_only := 
			IF(phone_only,
				 LIMIT(phone_bdid_index(phone = (UNSIGNED6) in_parms.phone_value),5000,FAIL(11,doxie.ErrorCodes(11)),keyed,count),
				 LIMIT(phone_bdid_index(phone = (UNSIGNED6) in_parms.phone_value),5000,SKIP,keyed,count));
														


			res_fein_only := 
			IF(fein_only, 
				 LIMIT(fein_bdid_index(fein = in_parms.fein_value),5000,FAIL(11,doxie.ErrorCodes(11)),keyed,count),
				 LIMIT(fein_bdid_index(fein = in_parms.fein_value),5000,SKIP,keyed,count));


				 
			res_exec_only :=
			business_header.Fetch_BC_State_LFName(in_parms.state_value, in_parms.fname_value, in_parms.lname_value, in_parms.nicknames, in_parms.phonetics and in_parms.lname_value<>'')(from_hdr = 'N');

			raw_executives := table(res_exec_only,{bdid,seq := 0,did_skip := false});

			layout_res project_executives(raw_executives L) := transform
				self.bdid := L.bdid;
				self.seq := L.seq;
				self.did_skip := L.did_skip;
			end;

			res_executives := project(raw_executives,project_executives(left));


			layout_phone_fein := RECORD
				UNSIGNED6 bdid;
				UNSIGNED6 phone;
				UNSIGNED4 fein;
			END;

			layout_phone_fein AddFein(res_phone_only l) := TRANSFORM
				SELF.fein := in_parms.fein_value;
				SELF := l;
			END;

			layout_res TakePhoneFein(layout_phone_fein l) := TRANSFORM
				SELF.seq := 0;
				SELF := l;
			END;

			layout_res PhoneToResLayout(res_phone_only l) := TRANSFORM
				SELF.seq := 0;
				SELF := l;
			END;

			layout_res FeinToResLayout(res_fein_only l) := TRANSFORM
				SELF.seq := 0;
				SELF := l;
			END;

			res_phone_fein_join := JOIN(
								PROJECT(res_phone_only, AddFein(LEFT)), 
								fein_bdid_index,
								keyed (LEFT.fein = RIGHT.fein) AND
								LEFT.bdid = RIGHT.bdid, TakePhoneFein(LEFT),
								LIMIT (ut.limits .DEFAULT)); // warning: this default can result in decreased output

			res_phone_fein_addr := IF(phone_matchable and fein_matchable,
								res_phone_fein_join,
								IF(phone_matchable, PROJECT(res_phone_only, PhoneToResLayout(LEFT)),
									IF(fein_matchable, PROJECT(res_fein_only, FeinToResLayout(LEFT)),
										 if (addr_matchable, fetched_by_addr,
								dataset([], layout_res)))));

			//--------------------------------
			// BDID match.
			//--------------------------------
			layout_res addseq(in_parms.bdid_dataset l):= transform
				self.bdid := l.bdid;
				self.seq := 1;
			end;

			res_bdid := project(in_parms.bdid_dataset, addseq(left));



			//------------------------------
			//Join name and phone fein addr matches
			//------------------------------
			res_word_plus := 
				MAP(in_parms.exact_only																			 => LIMIT(res_exact_Name,EXACT_NAME_MAX, SKIP),
						count(res_name_words)<=10000										 => res_name_words,
																																LIMIT(res_exact_Name,EXACT_NAME_MAX,SKIP))
							(bdid > 0);//filter

			addrDidSkip := exists(res_phone_fein_addr(did_skip));
			res_word_pfa := join(res_phone_fein_addr, res_word_plus,
													 left.bdid = right.bdid)+
											res_Word_plus(addrDidSkip); 
										//if the addr list is incomplete (didskip), the allow all word matches thru

			//------------------------------
			//Pick some result sets
			//------------------------------

			temp_res :=
			IF(in_parms.bdid_value<>0, res_bdid) +
			IF(word_search_only, 
				MAP(in_parms.exact_only                               => LIMIT(res_exact_Name, EXACT_NAME_MAX, FAIL(203,doxie.ErrorCodes(203))),
						count(res_name_words) <= WORD_SEARCH_MAX => res_name_words,
						LIMIT(res_exact_Name, EXACT_NAME_MAX, FAIL(203,doxie.ErrorCodes(203))))) +
			IF(~word_search_only AND company_name_matchable,
				res_word_pfa,
				res_phone_fein_addr) +
			IF(exec_only,res_executives);

			temp_res_ded := DEDUP(SORT(temp_res, bdid, seq), bdid);

			temp_exec_ded := dedup(sort(res_executives, bdid, seq), bdid);

			layout_res copy_res(layout_res l) := transform
				self := l;
			end;

			res := temp_res_ded + if(exec_matchable and ~exec_only,temp_exec_ded);
						 
			res_ded_0 := dedup(sort(res, bdid, seq), bdid);

			res_ded := limit(res_ded_0(true),2500,fail(203,doxie.errorcodes(203)));
			//res_ded := res_ded_0;

			layout_svc := RECORD
				Business_Header_SS.Layout_BDID_InBatch;
				UNSIGNED6 temp_id;
				UNSIGNED1 score := 0;
				UNSIGNED6 bdid;
			END;

			// Add the entered value back on so that we can filter on them
			layout_svc Format(res_ded l) := transform
				self.temp_id := 1;
				self.company_name := in_parms.company_name_value;
				self.prim_range := in_parms.prange_value;
				self.prim_name := in_parms.pname_value;
				self.predir := in_parms.predir_value;
				self.postdir := in_parms.postdir_value;
				self.addr_suffix := in_parms.addr_suffix_value;
				self.sec_range := in_parms.sec_range_value;
				self.p_city_name := in_parms.city_value;//moved that logic into mac_filter
				self.st := in_parms.state_value;
				self.z5 := in_parms.zip_val;//moved that logic into mac_filter
				self.phone10 := in_parms.phone_value;
				self.fein := in_parms.fein_val;
				self := l; // BDID + seq
			end;

			infile := project(res_ded, Format(left));

			bh_key := business_header_ss.Key_BH_BDID_pl;

			INTEGER min2(INTEGER l, INTEGER r) := IF(l < r, l, r);

			TYPEOF(infile) AddPenalty(infile l, bh_key r) := TRANSFORM
				SELF.score := 100 -  
					min2(10,IF(l.company_name = '', 0, ut.CompanySimilar(l.company_name, r.company_name)*2 + ut.StringSimilar(l.company_name, r.company_name))) -
					(9 * min2(10,
					IF(l.predir = '' OR r.predir = l.predir, 0, 1) +
					IF(l.postdir = '' OR r.postdir = l.postdir, 0, 1) +
					IF(l.addr_suffix = '' OR r.addr_suffix = l.addr_suffix, 0, 1) +
					MAP(l.prim_name = '' OR r.prim_name = l.prim_name => 0,
										 r.prim_name = '' => 8,
										 ut.stringsimilar(l.prim_name, r.prim_name)) +
					MAP((UNSIGNED8) l.prim_range = 0 OR (UNSIGNED8) r.prim_range = (UNSIGNED8) l.prim_range => 0,
										 (UNSIGNED8) r.prim_range = 0 => 2,
										 ut.stringsimilar(l.prim_range, r.prim_range)) +
					MAP(l.sec_range = '' OR r.sec_range = l.sec_range => 0,
										 r.sec_range = '' => 2,
										 ut.stringsimilar(l.sec_range, r.sec_range)) +
					MAP(l.p_city_name = '' OR in_parms.mile_radius_value > 0 OR r.city = l.p_city_name => 0,
										 r.city = '' AND l.z5 != '' => 1,
										 r.city = '' => 10,
										 ut.stringsimilar(l.p_city_name, r.city) < 3 => 1,
										 l.z5 != '' => 5,
										 10) +
					IF(l.st = '' OR r.state = l.st, 0, 10) +
					MAP(l.z5 = '' OR in_parms.mile_radius_value > 0  OR r.zip = (UNSIGNED3) l.z5 => 0,
										 r.zip = 0 AND l.p_city_name != '' AND l.st != '' => 5,
										 r.zip = 0 => 10,
										 10) +
						//but if the zip is blank bc a radius is being used, then make sure our company is in range
					IF(in_parms.mile_radius_value = 0 or in_parms.bh_zip_value = [] or r.zip in in_parms.bh_zip_value, 0, 10) +
					IF(l.phone10 = '' OR r.phone = (UNSIGNED6) l.phone10, 0, 10) +
					MAP(l.fein = '' OR r.fein = (UNSIGNED4) l.fein => 0,
						r.fein = 0 => 3,
						ut.stringsimilar(INTFORMAT(r.fein, 9, 1), l.fein))));

				SELF.bdid := IF(r.bdid = 0, 0, IF(SELF.score > 0, r.bdid, 0));
				SELF := l;
			END;	

			filtered_bdids := JOIN(
						infile, 
						bh_key,
					LEFT.bdid != 0 AND
					LEFT.bdid = RIGHT.bdid,
					AddPenalty(LEFT, RIGHT),
					LEFT OUTER, ATMOST(1000));

			bdids_sort := SORT(filtered_bdids, temp_id, bdid);

			// Rollup the results to get rid of the filtered records.
			// Multiple 0 bdids roll into one, nonzero replaces 0.
			TYPEOF(infile) take_right(bdids_sort r) := TRANSFORM
				SELF := r;
			END;

			outfile := ROLLUP(
				bdids_sort,
				LEFT.temp_id = RIGHT.temp_id AND LEFT.bdid = 0,
				take_right(RIGHT));

			//slim down to the necessities
			outrec := record
				outfile.BDID;
				outfile.seq;
				outfile.score;
			end;

			slim_res := table(outfile, outrec);

			filtered_res := DEDUP(SORT(slim_res, bdid, -score), bdid);

			rec := record
				unsigned6 BDID;
				UNSIGNED4 seq := 0;
				UNSIGNED1 score := 0;
			end;

			sif := record
				string CompanyName := in_parms.company_name_val;
				boolean ExactOnly := in_parms.exact_only;
				string Addr := in_parms.addr_value;
				string City := in_parms.city_val;
				string State := in_parms.state_val;
				string Zip := in_parms.zip_val;
				string Phone := in_parms.phone_value;
				string FEIN := in_parms.fein_val;
				string BDID := in_parms.bdid_val;
			end;

			soapres := soapcall(in_parms.adl_service_ip,'business_header.BH_SearchService',sif,dataset(rec));

			//outres := filtered_res;	
								//soapres;

			return if(in_parms.adl_service_ip='' or in_parms.forceLocal,
					 filtered_res,
					 soapres);
		end;
