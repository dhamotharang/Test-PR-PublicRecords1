/*--LIBRARY--*/
// This library performs business fetches.
// All logic for performing the fetch should be based here.
import business_header_ss,AutoStandardI,ut,doxie,business_header,autoheaderi,lib_metaphone;
LIBIN := autoheaderi.LIBIN;
LIBOUT := autoheaderi.LIBOUT;
// export LIB_FetchI_Hdr_Biz(LIBIN.FetchI_Hdr_Biz.full args) := MODULE,LIBRARY(LIBOUT.FetchI_Hdr_Biz)
export LIB_FetchI_Hdr_Biz(LIBIN.FetchI_Hdr_Biz.full args) := MODULE/*,LIBRARY*/(LIBOUT.FetchI_Hdr_Biz(args))
	shared string30 temp_fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(args,AutoStandardI.InterfaceTranslator.fname_value.params));
	shared boolean temp_nicknames := AutoStandardI.InterfaceTranslator.nicknames.val(project(args,AutoStandardI.InterfaceTranslator.nicknames.params));
	shared string30 temp_lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(args,AutoStandardI.InterfaceTranslator.lname_value.params));
	shared boolean temp_phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(project(args,AutoStandardI.InterfaceTranslator.phonetics.params));
	shared string120 temp_company_name_value := AutoStandardI.InterfaceTranslator.company_name_value.val(project(args,AutoStandardI.InterfaceTranslator.company_name_value.params));
	shared string120 temp_company_name_val_filt := AutoStandardI.InterfaceTranslator.company_name_val_filt.val(project(args,AutoStandardI.InterfaceTranslator.company_name_val_filt.params));
	shared string120 temp_company_name_val_filt2 := AutoStandardI.InterfaceTranslator.company_name_val_filt2.val(project(args,AutoStandardI.InterfaceTranslator.company_name_val_filt2.params));
	shared boolean temp_exact_only := AutoStandardI.InterfaceTranslator.exact_only.val(project(args,AutoStandardI.InterfaceTranslator.exact_only.params));
	shared string temp_prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(project(args,AutoStandardI.InterfaceTranslator.prange_value.params));
	shared string2 temp_predir_value := AutoStandardI.InterfaceTranslator.predir_value.val(project(args,AutoStandardI.InterfaceTranslator.predir_value.params));
	shared string temp_pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(args,AutoStandardI.InterfaceTranslator.pname_value.params));
	shared string4 temp_addr_suffix_value := AutoStandardI.InterfaceTranslator.addr_suffix_value.val(project(args,AutoStandardI.InterfaceTranslator.addr_suffix_value.params));
	shared string2 temp_postdir_value := AutoStandardI.InterfaceTranslator.postdir_value.val(project(args,AutoStandardI.InterfaceTranslator.postdir_value.params));
	shared string temp_sec_range_value := AutoStandardI.InterfaceTranslator.sec_range_value.val(project(args,AutoStandardI.InterfaceTranslator.sec_range_value.params));
	shared string temp_city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(args,AutoStandardI.InterfaceTranslator.city_value.params));
	shared string temp_state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(args,AutoStandardI.InterfaceTranslator.state_value.params));
	shared string5 temp_zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(project(args,AutoStandardI.InterfaceTranslator.zip_val.params));
	shared unsigned2 temp_mile_radius_value := AutoStandardI.InterfaceTranslator.mile_radius_value.val(project(args,AutoStandardI.InterfaceTranslator.mile_radius_value.params));
	shared set of integer4 temp_bh_zip_value := AutoStandardI.InterfaceTranslator.bh_zip_value.val(project(args,AutoStandardI.InterfaceTranslator.bh_zip_value.params));
	shared string10 temp_phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(args,AutoStandardI.InterfaceTranslator.phone_value.params));
	shared string10 temp_fein_val := AutoStandardI.InterfaceTranslator.fein_val.val(project(args,AutoStandardI.InterfaceTranslator.fein_val.params));
	shared unsigned4 temp_fein_value := AutoStandardI.InterfaceTranslator.fein_value.val(project(args,AutoStandardI.InterfaceTranslator.fein_value.params));
	shared unsigned6 temp_bdid_value := AutoStandardI.InterfaceTranslator.bdid_value.val(project(args,AutoStandardI.InterfaceTranslator.bdid_value.params));
	shared dataset({unsigned6 bdid}) temp_bdid_dataset := AutoStandardI.InterfaceTranslator.bdid_dataset.val(project(args,AutoStandardI.InterfaceTranslator.bdid_dataset.params));
	shared dataset(business_header_ss.Layout_BDID_InBatch) temp_precs := AutoStandardI.InterfaceTranslator.precs.val(project(args,AutoStandardI.InterfaceTranslator.precs.params));

	// REPLACES Business_Header.doxie_get_bdids_plus... SHOULD BE ROLLED UP ASAP
	export DATASET({unsigned6 BDID;unsigned4 seq;unsigned1 score}) do_plus := function

		WORD_SEARCH_MAX := 10000;
		EXACT_NAME_MAX := 10000;

		// word_header_index := Business_Header_SS.Key_BH_Header_Words;
		word_header_index := UPS_Testing.Key_BH_Header_Words2;
		bdid_city_zip_fein_phone_index := Business_Header_SS.Key_BH_BDID_City_Zip_Fein_Phone;
		fein_bdid_index := Business_Header_SS.Key_BH_FEIN;
		phone_bdid_index := Business_Header_SS.Key_BH_Phone;

		layout_res := RECORD
			UNSIGNED6 bdid;
			UNSIGNED1 seq;
			boolean did_skip := false;
		END;

		company_name_matchable := temp_company_name_val_filt != '';
		addr_matchable := exists(temp_precs(prim_name <> '' and ((integer)z5 > 0 or st != '')));
		phone_matchable := temp_phone_value <> '';
		fein_matchable := temp_fein_Value <> 0;
		exec_matchable := args.use_exec_search and trim(temp_lname_value) <> '';

		word_search_only := company_name_matchable AND ~phone_matchable AND ~fein_matchable AND ~addr_matchable;
		phone_only := phone_matchable AND ~company_name_matchable AND ~fein_matchable AND ~addr_matchable;
		fein_only := fein_matchable AND ~company_name_matchable AND ~phone_matchable AND ~addr_matchable;
		exec_only := exec_matchable AND ~company_name_matchable AND ~phone_matchable AND ~fein_matchable AND ~addr_matchable;

		//--------------------------------
		// Exact Company Name match.
		//--------------------------------
		string81 clean_company_name_value := ut.CleanCompany(temp_company_name_value);

		// Still needs a LIMIT or CHOOSEN here
		// exact_name_index_0 := business_header_ss.key_bh_companyname_unlimited(
													// clean_company_name_value[1..20] = clean_company_name20,
													// clean_company_name_value[21..80] = '' or
													// clean_company_name_value[21..80] = clean_company_name60);

		//rzip := bdid_city_zip_fein_phone_index.zip;
		boolean IsValidZip (integer rzip) := 
			(temp_state_value in ['CT','MA','ME','NH','NJ','PR','RI','VT','VI','AE'] and rzip >= 0 and rzip <= 09999) or
			(temp_state_value in ['DE','NY','PA'] and rzip >= 10000 and rzip <= 19999) or
			(temp_state_value in ['DC','MD','NC','SC','VA','WV'] and rzip >= 20000 and rzip <= 29999) or
			(temp_state_value in ['AL','FL','GA','MS','TN','AA'] and rzip >= 30000 and rzip <= 39999) or
			(temp_state_value in ['IN','KY','MI','OH'] and rzip >= 40000 and rzip <= 49999) or
			(temp_state_value in ['IA','MN','MT','ND','SD','WI'] and rzip >= 50000 and rzip <= 59999) or
			(temp_state_value in ['IL','KS','MO','NE'] and rzip >= 60000 and rzip <= 69999) or
			(temp_state_value in ['AR','LA','OK','TX'] and rzip >= 70000 and rzip <= 79999) or
			(temp_state_value in ['AZ','CO','ID','NM','NV','UT','WY'] and rzip >= 80000 and rzip <= 89999) or
			(temp_state_value in ['AK','AS','CA','GU','HI','MP','OR','WA','AP'] and rzip >= 90000 and rzip <= 99999);

		// No more than EXACT_NAME_MAX records required later
		// stat for maximum bdid+city is ~10000
		// exact_name_index := map(temp_zip_val = '' and temp_state_value <> '' and temp_city_value <> '' =>
														// join(exact_name_index_0, bdid_city_zip_fein_phone_index,
																 // keyed(left.bdid=right.bdid) and
																 // keyed(right.city=temp_city_value) and IsValidZip (right.zip),
																 // KEEP (EXACT_NAME_MAX + 1), LIMIT (2 * ut.limits. DEFAULT, SKIP)),
														// temp_zip_val = '' and temp_city_value <> '' =>
														// join(exact_name_index_0, bdid_city_zip_fein_phone_index,
																 // keyed(left.bdid=right.bdid) and
																 // keyed(right.city=temp_city_value),
																 // KEEP (EXACT_NAME_MAX + 1)),
														// temp_zip_val = '' and temp_state_value <> '' =>
														// join(exact_name_index_0, bdid_city_zip_fein_phone_index,
																 // keyed(left.bdid=right.bdid) and IsValidZip (right.zip),
																 // KEEP (EXACT_NAME_MAX + 1), LIMIT (2 * ut.limits. DEFAULT, SKIP)),
														// join(exact_name_index_0, bdid_city_zip_fein_phone_index,
																 // false,left outer, KEEP (EXACT_NAME_MAX + 1)));

		// layout_res ExactToResLayout(exact_name_index l) := TRANSFORM	
			// self.seq := 0;
			// SELF := l;
		// END;

		// res_exact_name := PROJECT(exact_name_index, ExactToResLayout(LEFT));

		// recordof(word_header_index) ExactToWordIndexLayout(exact_name_index l) := TRANSFORM	
			// self.seq := 1;
			// self.word := clean_company_name_value;
			// self.state := '';
			// self.bh_filepos := 0;
			// self.__filepos := 0;
			// SELF := l;
		// END;

		// word_exact_name := PROJECT(exact_name_index, ExactToWordIndexLayout(LEFT));

		//--------------------------------
		// Word Company Name match.
		//--------------------------------

		string10 mtp(string s) := lib_metaphone.MetaphoneLib.DMetaphone1(s);
		//10 is arbitrary
		
		BOOLEAN USEMETA := TRUE;
		//NEED TO ADD TO INTERFACE

		index_word_filt(boolean counting) := 
											word_header_index(company_name_matchable,
											
											keyed(
												mtp(temp_company_name_val_filt) = metaphone[1..LENGTH(TRIM(mtp(temp_company_name_val_filt)))] /*or
												(temp_company_name_val_filt2 <> '' and mtp(temp_company_name_val_filt2) = word[1..LENGTH(TRIM(mtp(temp_company_name_val_filt2)))])*/  //CEMTEMP  TODO  FIGURE THIS OUT
											),											
											keyed(
												temp_company_name_val_filt = word[1..LENGTH(TRIM(temp_company_name_val_filt))] or
												(temp_company_name_val_filt2 <> '' and temp_company_name_val_filt2 = word[1..LENGTH(TRIM(temp_company_name_val_filt2))]) or
												USEMETA
											), 
											 // counting OR wild(state) AND temp_state_value = '' or temp_state_value = state);
											 counting OR wild(state) AND keyed(temp_state_value = '' or temp_state_value = state));
											 
					//  *******   I MADE THIS LAST CONDITION KEYED AND ALLOWS MY STEAKHOUSE EXAMPLE TO WORK						 
											 

		//if some exact matches and too many word matches, just use exact rather than fail
		index_word_only := IF(word_search_only and count(index_word_filt(true)) >= 20000, 
													// IF(exists(exact_name_index_0), 
														 // word_exact_name,
														 if(args.nofail,
														 LIMIT(index_word_filt(false),20000, skip,keyed,count),
														 LIMIT(index_word_filt(false),20000, FAIL(12,doxie.ErrorCodes(12)),keyed,count)),
													CHOOSEN(SORT(LIMIT(index_word_filt(false),20000,SKIP,keyed,count),
																			 ut.stringsimilar(word, temp_company_name_val_filt), 
																			 bdid),5000));

		layout_index_filter := RECORD
			recordof(word_header_index) - [zip];
			QSTRING25 city;
			UNSIGNED3 zip;
			string6 zip_string;
			UNSIGNED4 fein;
			UNSIGNED4 phone;
		END;

		layout_index_filter AddFilterFields(word_header_index l, temp_precs r) := TRANSFORM
			SELF.city := r.p_city_name;
			SELF.zip := (UNSIGNED3)r.z5;
			SELF.fein := (integer)r.fein;
			SELF.phone := (UNSIGNED4)r.phone10;
			self.zip_string := l.zip;
			SELF := l;
		END;

		//index_prefilter := PROJECT(index_word_only, AddFilterFields(LEFT));
		index_prefilter := join(index_word_only, temp_precs, true, AddFilterFields(left, right), all);
			
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
			// SELF.__filepos := 0;
			self.zip := l.zip_string;
			SELF := l;
		END;

		filterable := 	temp_city_value != '' OR 
						temp_zip_val != '' OR 
						temp_fein_value != 0 OR
						temp_phone_value != '';

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
			temp_precs,
			res_normal_bdid,
			0,
			WORD_SEARCH_MAX,
			false)


		// no more than that needed later (compared with WORD_SEARCH_MAX)
		res_name_words := CHOOSEN (res_partial_name,	//+ PROJECT(res_normal_bdid, NormalToResLayout(LEFT)), 
															 WORD_SEARCH_MAX + 1);

		//---------------------------
		// Address-Only Match
		//---------------------------
		doxie.layout_addressSearch trafam(temp_precs l) := transform
			self.state := l.st;
			self.zip := l.z5;
			self := l;
		end;

		fam := project(temp_precs, trafam(left));
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
		IF(phone_only and not args.nofail,
			 LIMIT(phone_bdid_index(phone = (UNSIGNED6) temp_phone_value),5000,FAIL(13,doxie.ErrorCodes(13)),keyed,count),
			 LIMIT(phone_bdid_index(phone = (UNSIGNED6) temp_phone_value),5000,SKIP,keyed,count));
													


		res_fein_only := 
		IF(fein_only and not args.nofail, 
			 LIMIT(fein_bdid_index(fein = temp_fein_value),5000,FAIL(14,doxie.ErrorCodes(14)),keyed,count),
			 LIMIT(fein_bdid_index(fein = temp_fein_value),5000,SKIP,keyed,count));


			 
		res_exec_only :=
		business_header.Fetch_BC_State_LFName(temp_state_value, temp_fname_value, temp_lname_value, temp_nicknames, temp_phonetics and temp_lname_value<>'')(from_hdr = 'N');

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
			SELF.fein := temp_fein_value;
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

		res_phone_fein_join_nofail :=
		JOIN(
							PROJECT(res_phone_only, AddFein(LEFT)), 
							fein_bdid_index,
							keyed (LEFT.fein = RIGHT.fein) AND
							LEFT.bdid = RIGHT.bdid, TakePhoneFein(LEFT),
							LIMIT (ut.limits .DEFAULT,skip));


		res_phone_fein_join :=if(args.nofail,res_phone_fein_join_nofail,
													JOIN(
							PROJECT(res_phone_only, AddFein(LEFT)), 
							fein_bdid_index,
							keyed (LEFT.fein = RIGHT.fein) AND
							LEFT.bdid = RIGHT.bdid, TakePhoneFein(LEFT),
							LIMIT (ut.limits .DEFAULT))); // warning: this default can result in decreased output

		res_phone_fein_addr := IF(phone_matchable and fein_matchable,
							res_phone_fein_join,
							IF(phone_matchable, PROJECT(res_phone_only, PhoneToResLayout(LEFT)),
								IF(fein_matchable, PROJECT(res_fein_only, FeinToResLayout(LEFT)),
									 if (addr_matchable, fetched_by_addr,
							dataset([], layout_res)))));

		//--------------------------------
		// BDID match.
		//--------------------------------
		layout_res addseq(temp_bdid_dataset l):= transform
			self.bdid := l.bdid;
			self.seq := 1;
		end;

		res_bdid := project(temp_bdid_dataset, addseq(left));



		//------------------------------
		//Join name and phone fein addr matches
		//------------------------------
		res_word_plus := if(count(res_name_words)<=10000,res_name_words)
			// MAP(temp_exact_only																			 => LIMIT(res_exact_Name,EXACT_NAME_MAX, SKIP),
					// count(res_name_words)<=10000										 => res_name_words,
																															// LIMIT(res_exact_Name,EXACT_NAME_MAX,SKIP))
						(bdid > 0);//filter

		addrDidSkip := exists(res_phone_fein_addr(did_skip));
		res_word_pfa := join(res_phone_fein_addr, res_word_plus,
												 left.bdid = right.bdid)+
										res_Word_plus(addrDidSkip); 
									//if the addr list is incomplete (didskip), the allow all word matches thru

		//------------------------------
		//Pick some result sets
		//------------------------------
		// temp_r :=if(args.nofail,
				// LIMIT(res_exact_Name, EXACT_NAME_MAX,skip),
				// LIMIT(res_exact_Name, EXACT_NAME_MAX, FAIL(203,doxie.ErrorCodes(203))));
					
		temp_res :=res_name_words;
		// IF(temp_bdid_value<>0, res_bdid) +
		// IF(word_search_only, 
			// MAP(temp_exact_only                               => temp_r,
			// count(res_name_words) <= WORD_SEARCH_MAX => res_name_words,
					// temp_r)) +
		// IF(~word_search_only AND company_name_matchable,
			// res_word_pfa,
			// res_phone_fein_addr) +
		// IF(exec_only,res_executives);

		temp_res_ded := DEDUP(SORT(temp_res, bdid, seq), bdid);

		temp_exec_ded := dedup(sort(res_executives, bdid, seq), bdid);

		layout_res copy_res(layout_res l) := transform
			self := l;
		end;

		res := temp_res_ded + if(exec_matchable and ~exec_only,temp_exec_ded);
					 
		res_ded_0 := dedup(sort(res, bdid, seq), bdid);

		res_ded := if(args.nofail,
		limit(res_ded_0(true),2500,skip),
		limit(res_ded_0(true),2500,fail(203,doxie.errorcodes(203))));
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
			self.company_name := temp_company_name_value;
			self.prim_range := temp_prange_value;
			self.prim_name := temp_pname_value;
			self.predir := temp_predir_value;
			self.postdir := temp_postdir_value;
			self.addr_suffix := temp_addr_suffix_value;
			self.sec_range := temp_sec_range_value;
			self.p_city_name := temp_city_value;//moved that logic into mac_filter
			self.st := temp_state_value;
			self.z5 := temp_zip_val;//moved that logic into mac_filter
			self.phone10 := temp_phone_value;
			self.fein := temp_fein_val;
			self := l; // BDID + seq
		end;

		infile := project(res_ded, Format(left));
		
		mile_radius_value := temp_mile_radius_value;
		bh_zip_value := temp_bh_zip_value;

		Business_Header_SS.MAC_Filter_Matches(
			infile,
			filtered_res0
		)

		filtered_res1 := if(args.score_results,filtered_res0,infile(bdid>0));

		//slim down to the necessities
		outrec := record
			filtered_res1.BDID;
			filtered_res1.seq;
			filtered_res1.score;
		end;

		slim_res := table(filtered_res1, outrec);

		filtered_res := DEDUP(SORT(slim_res, bdid, -score), bdid);

		outres := project(filtered_res,{unsigned6 BDID;unsigned4 seq;unsigned1 score});	
		// output(count(index_word_filt(false)));
		// output(count(index_word_filt(true)));
		// output(mtp(temp_company_name_val_filt), named('mtp_temp_company_name_val_filt'));
		// output(temp_company_name_val_filt, named('temp_company_name_val_filt'));
		// output(mtp(temp_company_name_val_filt2), named('mtp_temp_company_name_val_filt2'));
		// output(temp_company_name_val_filt2, named('temp_company_name_val_filt2'));
		
		return outres;
	end;
	// REPLACES DOXIE_RAW.GET_BDIDS... USE THIS AS MAIN WHENEVER POSSIBLE.
	export DATASET(doxie.layout_ref_bdid) do := function
		return project(table(do_plus,{bdid}),doxie.layout_ref_bdid);
	end;
END;