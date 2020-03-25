﻿EXPORT Regulatory := module


	export layout_PhonePlusV2_Base := RECORD
				boolean in_flag;
				unsigned8 confidencescore;
				unsigned8 rules;
				string3 npa;
				string7 phone7;
				string10 cellphone;
				data16 cellphoneidkey;
				data16 phone7_did_key;
				unsigned6 pdid;
				unsigned6 did;
				string3 did_score;
				unsigned3 datefirstseen;
				unsigned3 datelastseen;
				unsigned3 datevendorlastreported;
				unsigned3 datevendorfirstreported;
				unsigned3 dt_nonglb_last_seen;
				string1 glb_dppa_flag;
				string5 glb_dppa_all;
				string2 vendor;
				string2 src;
				unsigned8 src_all;
				unsigned1 src_cnt;
				unsigned8 src_rule;
				unsigned1 append_avg_source_conf;
				unsigned1 append_max_source_conf;
				unsigned1 append_min_source_conf;
				unsigned1 append_total_source_conf;
				unsigned3 orig_dt_last_seen;
				string10 did_type;
				string90 origname;
				string25 address1;
				string25 address2;
				string25 address3;
				string20 origcity;
				string2 origstate;
				string9 origzip;
				string10 orig_phone;
				string8 dob;
				string10 agegroup;
				string8 gender;
				string50 email;
				string5 orig_listing_type;
				string2 listingtype;
				string2 orig_publish_code;
				string6 orig_phone_type;
				string13 orig_phone_usage;
				string80 company;
				unsigned3 orig_phone_reg_dt;
				string20 orig_carrier_code;
				string60 orig_carrier_name;
				string10 orig_conf_score;
				unsigned1 orig_rec_type;
				string100 clean_company;
				string10 prim_range;
				string2 predir;
				string28 prim_name;
				string4 addr_suffix;
				string2 postdir;
				string10 unit_desig;
				string8 sec_range;
				string25 p_city_name;
				string25 v_city_name;
				string2 state;
				string5 zip5;
				string4 zip4;
				string4 cart;
				string1 cr_sort_sz;
				string4 lot;
				string1 lot_order;
				string2 dpbc;
				string1 chk_digit;
				string2 rec_type;
				string2 ace_fips_st;
				string3 ace_fips_county;
				string10 geo_lat;
				string11 geo_long;
				string4 msa;
				string7 geo_blk;
				string1 geo_match;
				string4 err_stat;
				string5 title;
				string20 fname;
				string20 mname;
				string20 lname;
				string5 name_suffix;
				string3 name_score;
				unsigned6 bdid;
				unsigned1 bdid_score;
				unsigned4 append_npa_effective_dt;
				unsigned4 append_npa_last_change_dt;
				string1 append_dialable_ind;
				string30 append_place_name;
				string1 append_portability_indicator;
				string20 append_prior_area_code;
				unsigned8 append_nonpublished_match;
				string30 append_ocn;
				string1 append_time_zone;
				string2 append_nxx_type;
				string3 append_coctype;
				string4 append_scc;
				string25 append_phone_type;
				string1 append_company_type;
				string25 append_phone_use;
				string5 agreg_listing_type;
				unsigned1 max_orig_conf_score;
				unsigned1 min_orig_conf_score;
				unsigned1 cur_orig_conf_score;
				string1 activeflag;
				boolean eda_active_flag;
				unsigned4 eda_match;
				unsigned4 eda_phone_dt;
				unsigned4 eda_did_dt;
				unsigned4 eda_nm_addr_dt;
				unsigned4 eda_hist_match;
				unsigned4 eda_hist_phone_dt;
				unsigned4 eda_hist_did_dt;
				unsigned4 eda_hist_nm_addr_dt;
				string1 append_feedback_phone;
				unsigned4 append_feedback_phone_dt;
				string1 append_feedback_phone7_did;
				unsigned4 append_feedback_phone7_did_dt;
				string1 append_feedback_phone7_nm_addr;
				unsigned4 append_feedback_phone7_nm_addr_dt;
				unsigned4 append_ported_match;
				boolean append_seen_once_ind;
				unsigned1 append_indiv_phone_cnt;
				boolean append_indiv_has_active_eda_phone_flag;
				boolean append_latest_phone_owner_flag;
				unsigned6 hhid;
				unsigned1 hhid_score;
				data16 phone7_hhid_key;
				boolean append_best_addr_match_flag;
				boolean append_best_nm_match_flag;
				unsigned8 rawaid;
				unsigned8 cleanaid;
				boolean current_rec;
				unsigned4 first_build_date;
				unsigned4 last_build_date;
				unsigned4 global_sid;
				unsigned8 record_sid;
	 END;

  export applyPhonesPlusInj(ds) := 
	    functionmacro
						import suppress;
		        return Suppress.applyRegulatory.simple_append(PhonesPlus_Suppress, 'file_phonesplus_inj.thor', Phonesplus_v2.regulatory.layout_PhonePlusV2_Base);
			endmacro;


	export applyPhonesPlusSup_DIDPhone(ds) := 
				functionmacro
						import suppress;
						
						local PhonesPlus_DID_hash(recordof(ds) L) := HASHMD5(intformat((unsigned6)l.did,15,1),TRIM((string10) (l.cellphone[4..10] + l.cellphone[1..3]), left, right));
						local PhonesPlus_Suppress := suppress.applyregulatory.simple_sup(ds,'file_phonesplus_sup.txt', PhonesPlus_DID_hash);

						return PhonesPlus_Suppress;
				endmacro;

	export applyPhonesPlusSup_Phone(ds) := 
				functionmacro
						import suppress;
						local PhonesPlus_hash(recordof(ds) L) := HASHMD5(TRIM((string10) (l.cellphone[4..10] + l.cellphone[1..3]) , left, right));
						local PhonesPlus_Suppress := suppress.applyregulatory.simple_sup(ds,'file_phonesplus_sup.txt', PhonesPlus_hash);

						return PhonesPlus_Suppress;
	endmacro;
				
//
// perform append functions using applyRegulatory
//

		export applyPhonesPlusAll(ds) := 
				functionmacro
						import suppress;
						local PhonesPlus_Suppress := Phonesplus_v2.regulatory.applyPhonesPlusSup_Phone(ds) ;
						return Suppress.applyRegulatory.simple_append(PhonesPlus_Suppress, 'file_phonesplus_inj.thor', Phonesplus_v2.regulatory.layout_PhonePlusV2_Base);
				endmacro;			

	
//
// perform get functions using applyRegulatory
//
		export getPhonesPlusSup() := 
				functionmacro						
						import suppress;

						return suppress.applyregulatory.getFile('file_phonesplus_sup.txt', suppress.applyregulatory.layout_in);
				endmacro; 

		export getPhonesPlusInj() := 
				functionmacro										
						import suppress;

						return	suppress.applyregulatory.getFile('file_phonesplus_inj.thor', Phonesplus_v2.regulatory.layout_PhonePlusV2_Base);
				endmacro; 

end ;