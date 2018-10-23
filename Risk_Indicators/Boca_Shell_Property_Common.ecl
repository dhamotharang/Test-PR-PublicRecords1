IMPORT _Control, Data_services, Doxie, LN_PropertyV2, LN_PropertyV2_Services, RiskWise, Suppress, profilebooster;
onThor := _Control.Environment.OnThor;

EXPORT Boca_Shell_Property_Common(GROUPED DATASET(Layout_PropertyRecord) p_address,
                                  GROUPED DATASET(Layout_Boca_Shell_ids) ids_only, 
																  BOOLEAN includeRelatives = TRUE,
																  BOOLEAN filter_out_fares = FALSE,
																  BOOLEAN is_FCRA = FALSE,
																	LN_PropertyV2_Services.interfaces.Iinput_report input_mod,
																  BOOLEAN ViewDebugs = FALSE,
																	BOOLEAN is_from_PB = FALSE) := FUNCTION

	// --------------------[ CONSTANTS ]-------------------

		STRING1   ASSESSMENT_RECORD := 'A';
		STRING1   DEED_RECORD       := 'D';
		STRING1   MORTGAGE          := 'M';
		STRING1   OWNER             := 'O';
		STRING1   BUYER             := 'B';
		STRING1   SELLER            := 'S';
		STRING1   PROPERTY          := 'P';
		STRING1   FARES             := 'A';
		STRING1   FIDELITY          := 'B';
		STRING1   SEARCHED_BY_LEXID := '9';
		STRING1   SEARCHED_BY_ADDR  := '0';
		UNSIGNED1 APPLICANT_OWNED   := 1;
		UNSIGNED1 FAMILY_OWNED      := 2;
		UNSIGNED1 APPLICANT_SOLD    := 3;
		UNSIGNED1 FAMILY_SOLD       := 4;
		UNSIGNED1 FIRSTNAME_MATCH   := 5;
		UNSIGNED1 NO_NAME_MATCH     := 6;
		UNSIGNED1 NOTHING_FOUND     := 0;

	// --------------------[ LAYOUTS ]-------------------

	layout_properties_temp_pre := record
		LN_PropertyV2_Services.layouts.core;
		LN_PropertyV2_Services.layouts.deeds.result.tmp  deed;
		LN_PropertyV2_Services.layouts.assess.result.tmp assessment;
		DATASET(LN_PropertyV2_Services.layouts.parties.pparty) parties;
		STRING2	 deed_st;
		STRING2	 assm_st;
	end;

// slim down the layouts as much as we can to reduce memory usage in here
	layout_deed_slim := record
		STRING8  contract_date;
		STRING33 fares_transaction_type_desc;
		STRING8  first_td_due_date;
		STRING11 first_td_loan_amount;
		STRING8  recording_date;
		STRING11 sales_price;
		STRING4  type_financing;	
	end;
	
	layout_assessment_slim := record
		STRING1  fid_type;
		STRING1  vendor_source_flag;
		STRING11 assessed_total_value;
		STRING4  assessed_value_year;
		STRING9  building_area;
		STRING4  effective_year_built;
		STRING3  garage_type_code;
		STRING11 market_total_value;
		STRING11 mortgage_loan_amount;
		STRING5  mortgage_loan_type_code;
		STRING8  no_of_baths;
		STRING5  no_of_bedrooms;
		STRING3  no_of_buildings;
		STRING2  no_of_partial_baths;
		STRING5  no_of_rooms;
		STRING5  no_of_stories;
		STRING5  no_of_units;
		STRING5  parking_no_of_cars;
		STRING8  prior_recording_date;
		STRING11 prior_sales_price;
		STRING8  recording_date;
		STRING8  sale_date;
		STRING11 sales_price;
		STRING4  standardized_land_use_code;
		STRING5  style_code;
		STRING4  tax_year;
		STRING4  year_built;	
	end;
	
	layout_entity_slim := RECORD
   string20 fname;
   string20 lname;
   string12 did;
  END;
	

	layout_parties_slim := record
		string1 party_type;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string2 st;
		string5 zip;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string7 geo_blk;
		DATASET(layout_entity_slim) entity{maxcount(10)};
	 END;	
	
	layout_properties_temp := record
		LN_PropertyV2_Services.layouts.core;
		layout_deed_slim       deed;
		layout_assessment_slim assessment;
		DATASET(layout_parties_slim) parties;
	end;
	
	layout_ids_plus_fares := RECORD
			UNSIGNED4 seq;
			UNSIGNED1 NAProp := 0;
			UNSIGNED3 historydate;
			UNSIGNED6 inp_did;
			BOOLEAN  isrelat;     // indicates that, when FALSE, the DID is that of the input subject; when TRUE, it’s that of the input subject’s relative
			STRING20 inp_fname;   // first name of the input subject
			STRING20 inp_lname;   // last name of the input subject
			STRING20 prange := '';
			STRING20 pname := '';
			STRING12 ln_fares_id;
			STRING1  dataSrce;
			unsigned p_address_dt_first_seen := 0;
			unsigned p_address_dt_last_seen := 0;
	END;
	
	layout_key_Property_did := RECORDOF(LN_PropertyV2.key_Property_did());
	
	layout_property_plus_id := RECORD
		layout_properties_temp;
		STRING8 unique_prop_id;
	END;

	layout_full_plus_ids := RECORD
		layout_ids_plus_fares AND NOT ln_fares_id;
		layout_property_plus_id;
	END;
	
	layout_full_temp := RECORD
		Risk_Indicators.Layouts.layout_relat_prop_plusv4;
		UNSIGNED1 property_status;
		UNSIGNED  property_purchase_amount;
		UNSIGNED4 property_purchase_date;
		UNSIGNED  property_prior_purchase_amount;
		UNSIGNED4 property_prior_purchase_date;
		UNSIGNED  property_sale_amount;
		UNSIGNED4 property_sale_date;
		UNSIGNED1 property_seq_no;
		BOOLEAN   is_sold;
		STRING8   unique_prop_id;
	END;
	
	// --------------------[ FUNCTIONS ]--------------------

	// The following function returns an ad hoc, unique property value to use together 
	// with the seq value for linking the same properties among many DEED_RECORDs and ASSESSMENT_RECORDs. 
	// We wouldn't ever want to use this id among, say, 1 million records, but among all
	// the properties owned by a particular person, it's unique enough.
	STRING8 unique_property_id(STRING prim_range, STRING prim_name) :=
		StringLib.StringFilter(
			StringLib.StringToUpperCase(
				TRIM(prim_range) + TRIM(prim_name)
			), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	);
	
	getPropertyId(DATASET(layout_parties_slim) parties) :=
		FUNCTION
			_property := parties(party_type = PROPERTY)[1];
			RETURN unique_property_id(_property.prim_range, _property.prim_name);
		END;
		
	getMortgageType(STRING mortgage_loan_type_code, STRING vendor_source_flag) :=
		FUNCTION
			loan_type_code := TRIM(stringlib.stringtouppercase(mortgage_loan_type_code));
			is_fares       := vendor_source_flag = FARES;
			is_fidelity    := vendor_source_flag = FIDELITY;
			mortgage_type  := iid_constants.mortgage_type(is_fidelity, is_fares, loan_type_code);
			RETURN mortgage_type;
		END;

	getFinancingType(STRING finance_type_code, STRING vendor_source_flag) :=
		FUNCTION
			finance_type_cd := TRIM(stringlib.stringtouppercase(finance_type_code));
			is_fares        := vendor_source_flag = FARES;
			is_fidelity     := vendor_source_flag = FIDELITY;
			mortgage_type   := iid_constants.type_financing(is_fidelity, is_fares, finance_type_cd);
			RETURN mortgage_type;
		END;
	
	UNSIGNED1 getPropertyStatus(layout_full_plus_ids le) :=
		FUNCTION
			// NOTE: Someone who's "family" has the same last name but a different first name.
			is_good_match := Risk_Indicators.g;
			
			fname_match_owner1 := is_good_match(FnameScore(le.inp_fname,le.parties(party_type = OWNER)[1].entity[1].fname));
			lname_match_owner1 := is_good_match(LnameScore(le.inp_lname,le.parties(party_type = OWNER)[1].entity[1].lname));
			fname_match_owner2 := is_good_match(FnameScore(le.inp_fname,le.parties(party_type = OWNER)[1].entity[2].fname));
			lname_match_owner2 := is_good_match(LnameScore(le.inp_lname,le.parties(party_type = OWNER)[1].entity[2].lname));
			fname_match_owner3 := is_good_match(FnameScore(le.inp_fname,le.parties(party_type = OWNER)[1].entity[3].fname));
			lname_match_owner3 := is_good_match(LnameScore(le.inp_lname,le.parties(party_type = OWNER)[1].entity[3].lname));
			fname_match_owner4 := is_good_match(FnameScore(le.inp_fname,le.parties(party_type = OWNER)[1].entity[4].fname));
			lname_match_owner4 := is_good_match(LnameScore(le.inp_lname,le.parties(party_type = OWNER)[1].entity[4].lname));

			fname_match_sellr1 := is_good_match(FnameScore(le.inp_fname,le.parties(party_type = SELLER)[1].entity[1].fname));
			lname_match_sellr1 := is_good_match(LnameScore(le.inp_lname,le.parties(party_type = SELLER)[1].entity[1].lname));
			fname_match_sellr2 := is_good_match(FnameScore(le.inp_fname,le.parties(party_type = SELLER)[1].entity[2].fname));
			lname_match_sellr2 := is_good_match(LnameScore(le.inp_lname,le.parties(party_type = SELLER)[1].entity[2].lname));
			fname_match_sellr3 := is_good_match(FnameScore(le.inp_fname,le.parties(party_type = SELLER)[1].entity[3].fname));
			lname_match_sellr3 := is_good_match(LnameScore(le.inp_lname,le.parties(party_type = SELLER)[1].entity[3].lname));
			fname_match_sellr4 := is_good_match(FnameScore(le.inp_fname,le.parties(party_type = SELLER)[1].entity[4].fname));
			lname_match_sellr4 := is_good_match(LnameScore(le.inp_lname,le.parties(party_type = SELLER)[1].entity[4].lname));
		
			property_status :=
				MAP(
					le.inp_did<>0 and le.inp_did IN 
						[
							(UNSIGNED6)le.parties(party_type = OWNER)[1].entity[1].did,
							(UNSIGNED6)le.parties(party_type = OWNER)[1].entity[2].did,
							(UNSIGNED6)le.parties(party_type = OWNER)[1].entity[3].did,
							(UNSIGNED6)le.parties(party_type = OWNER)[1].entity[4].did
						]                                        => APPLICANT_OWNED,
					lname_match_owner1 AND  fname_match_owner1 => APPLICANT_OWNED,
					lname_match_owner2 AND  fname_match_owner2 => APPLICANT_OWNED,
					lname_match_owner3 AND  fname_match_owner3 => APPLICANT_OWNED,
					lname_match_owner4 AND  fname_match_owner4 => APPLICANT_OWNED,
					
					lname_match_owner1 AND ~fname_match_owner1 => FAMILY_OWNED,
					lname_match_owner2 AND ~fname_match_owner2 => FAMILY_OWNED,
					lname_match_owner3 AND ~fname_match_owner3 => FAMILY_OWNED,
					lname_match_owner4 AND ~fname_match_owner4 => FAMILY_OWNED,

					le.inp_did<>0 and le.inp_did IN 
						[
							(UNSIGNED6)le.parties(party_type = SELLER)[1].entity[1].did,
							(UNSIGNED6)le.parties(party_type = SELLER)[1].entity[2].did,
							(UNSIGNED6)le.parties(party_type = SELLER)[1].entity[3].did,
							(UNSIGNED6)le.parties(party_type = SELLER)[1].entity[4].did
						]                                        => APPLICANT_SOLD,					
					lname_match_sellr1 AND  fname_match_sellr1 => APPLICANT_SOLD,
					lname_match_sellr2 AND  fname_match_sellr2 => APPLICANT_SOLD,
					lname_match_sellr3 AND  fname_match_sellr3 => APPLICANT_SOLD,
					lname_match_sellr4 AND  fname_match_sellr4 => APPLICANT_SOLD,
					
					lname_match_sellr1 AND ~fname_match_sellr1 => FAMILY_SOLD,
					lname_match_sellr2 AND ~fname_match_sellr2 => FAMILY_SOLD,
					lname_match_sellr3 AND ~fname_match_sellr3 => FAMILY_SOLD,
					lname_match_sellr4 AND ~fname_match_sellr4 => FAMILY_SOLD,
					
					// Strictly speaking, the following are for naprop calculation only.
					~lname_match_owner1 AND  fname_match_owner1 => FIRSTNAME_MATCH,
					~lname_match_owner2 AND  fname_match_owner2 => FIRSTNAME_MATCH,
					~lname_match_owner3 AND  fname_match_owner3 => FIRSTNAME_MATCH,
					~lname_match_owner4 AND  fname_match_owner4 => FIRSTNAME_MATCH,
					
					~lname_match_sellr1 AND  fname_match_sellr1 => FIRSTNAME_MATCH,
					~lname_match_sellr2 AND  fname_match_sellr2 => FIRSTNAME_MATCH,
					~lname_match_sellr3 AND  fname_match_sellr3 => FIRSTNAME_MATCH,
					~lname_match_sellr4 AND  fname_match_sellr4 => FIRSTNAME_MATCH,
					
					~lname_match_owner1 AND ~fname_match_owner1 => NO_NAME_MATCH,
					~lname_match_owner2 AND ~fname_match_owner2 => NO_NAME_MATCH,
					~lname_match_owner3 AND ~fname_match_owner3 => NO_NAME_MATCH,
					~lname_match_owner4 AND ~fname_match_owner4 => NO_NAME_MATCH,
					
					~lname_match_sellr1 AND ~fname_match_sellr1 => NO_NAME_MATCH,
					~lname_match_sellr2 AND ~fname_match_sellr2 => NO_NAME_MATCH,
					~lname_match_sellr3 AND ~fname_match_sellr3 => NO_NAME_MATCH,
					~lname_match_sellr4 AND ~fname_match_sellr4 => NO_NAME_MATCH,
					
					/* default.............................. : */  NOTHING_FOUND
				);
			
			RETURN property_status;
		END;

	// "Owner occupied" means the Owner's mailing address is the same as the Property's street address.
	BOOLEAN isOwnerOccupied(layout_full_plus_ids le) :=
		FUNCTION
			_property := le.parties(party_type = PROPERTY)[1];
			_owner    := le.parties(party_type = OWNER)[1];
			
			derived_address_id_property := unique_property_id(_property.prim_range, _property.prim_name);			
			derived_address_id_owner    := unique_property_id(_owner.prim_range, _owner.prim_name);	
			
			RETURN derived_address_id_property = derived_address_id_owner;			
		END;

	// Name-Address-Property ownership values:
	//   0 - Nothing Found
	//   1 - Address owned by other
	//   2 - First Name and Address match property record
	//   3 - Last Name and Address match property record
	//   4 - First Name, Last Name and Address match property	
	UNSIGNED1 calc_napprop(UNSIGNED1 property_status = NOTHING_FOUND) := 
		MAP(
			property_status = NO_NAME_MATCH   => 1,
			property_status = FIRSTNAME_MATCH => 2,
			property_status = FAMILY_OWNED    => 3,
			property_status = FAMILY_SOLD     => 3,
			property_status = APPLICANT_OWNED => 4,
			property_status = APPLICANT_SOLD  => 4,
			/* default...................: */    NOTHING_FOUND
		);
		
	// --------------------[ MAIN ]--------------------
	
	// 1. Get ln_fares_ids...:
	


	// We're synthesizing a "temp" Index, since the join to the existing Index LN_PropertyV2.key_Property_did(is_FCRA) is time-consuming. More than we would expect. The question
	// is still open whether the calculations that define key_property_did are responsible for
	// the lag, but performance metrics show that the temp key defined below is faster. -cda
	KeyName_nonFCRA := Data_services.Data_location.Prefix('Property') + 'thor_data400::key::ln_propertyv2::' + doxie.Version_SuperKey + '::search.did';
	KeyName_FCRA    := Data_services.Data_location.Prefix('Property') + 'thor_data400::key::ln_propertyv2::fcra::' + doxie.Version_SuperKey + '::search.did';

	keyname_property_did := IF( is_FCRA, KeyName_FCRA, KeyName_nonFCRA );

	temp_key_property_did :=
		INDEX(
			LN_PropertyV2.file_search_building,
			{s_did := (unsigned)did, string1 source_code_2 := source_code[2]},
			{ln_fares_id, source_code, lname, fname, prim_range, predir, prim_name, suffix, postdir, sec_range, st, p_city_name, zip, county, geo_blk},
			keyname_property_did, 
			OPT
		);
	
	// 1.a. ...by DID...
	ids := ids_only(did != 0);

layout_ids_plus_fares append_fares_id_by_DID(ids le, temp_key_property_did rt) := transform
		SELF.historydate := le.historydate;
		SELF.inp_did     := le.did;
		SELF.inp_fname   := le.fname;
		SELF.inp_lname   := le.lname;
		SELF.prange      := rt.prim_range;
		SELF.pname       := rt.prim_name;
		SELF.ln_fares_id := rt.ln_fares_id;
		SELF.dataSrce    := SEARCHED_BY_LEXID;
		SELF := le;
end;

	ids_plus_fares_by_did_roxie :=
		JOIN(ids, temp_key_property_did, 
			KEYED(LEFT.did = RIGHT.s_did) AND
			KEYED(RIGHT.source_code_2 = PROPERTY) AND
			(includeRelatives OR ~LEFT.isrelat),
			append_fares_id_by_DID(left, right),
			KEEP(100), 
			ATMOST(RiskWise.max_atmost) 
		);

	// dataset named 'ids' coming in contains all input DIDs, relative DIDs and neighborhood DIDs.  
	// going to dedup this down to all unique DIDs before searching property data
	unique_dids := dedup( sort( distribute(ids, did), did, local), did, local ) ;
	ids_plus_fares_by_did_thor :=

		JOIN( 
			unique_dids, 
			distribute(pull(temp_key_property_did(source_code_2 = PROPERTY)), s_did), // LN_PropertyV2.key_Property_did(is_FCRA),
			LEFT.did = RIGHT.s_did,
			append_fares_id_by_DID(left, right),
			KEEP(100), 
			ATMOST(left.did=right.s_did, RiskWise.max_atmost) ,
			local
		);

#IF(onThor)
	ids_plus_fares_by_did := group(ids_plus_fares_by_did_thor, seq); // add group by seq to make both branches have same grouping
#ELSE
	ids_plus_fares_by_did := ids_plus_fares_by_did_roxie;
#END

	// 1.b. Now get ln_fares_ids by Address. Note that if the applicant lived in an apartment,
	// this join won't return any records for it, unless it was a condo.
	p_addr_roxie := 
		DEDUP(
			SORT(
				p_address,
				seq, did, isrelat, fname, lname, prim_range, prim_name, sec_range, city_name, st, zip5

			),
			seq, did, isrelat, fname, lname, prim_range, prim_name, sec_range, city_name, st, zip5
		);	
	
	p_addr_thor := 
		DEDUP(
			SORT(
				distribute(p_address, did),
				did, prim_range, prim_name, sec_range, city_name, st, zip5, isrelat, fname, lname, local
			),
			did, prim_range, prim_name, sec_range, city_name, st, zip5, local
		);
		
	#IF(onThor)
		p_addr := group(p_addr_thor, seq);
	#ELSE
		p_addr := p_addr_roxie;
	#END

kaf := LN_PropertyV2.key_addr_fid(is_FCRA);

layout_ids_plus_fares append_fares_id_by_addr(p_addr le, kaf rt) := transform
	SELF.historydate := le.historydate,
	SELF.inp_did     := le.did,
	SELF.inp_fname   := le.fname,
	SELF.inp_lname   := le.lname,
	SELF.ln_fares_id := rt.ln_fares_id,
	SELF.dataSrce    := SEARCHED_BY_ADDR,
	// hold onto the dates from each address to filter by later.  must make sure the address dates are within the dates that person lived there
	self.p_address_dt_first_seen := le.date_first_seen;  
	self.p_address_dt_last_seen := le.date_last_seen;
	SELF := le,			
	SELF := []
end;

	ids_plus_fares_by_address_roxie := 
		JOIN(
			p_addr(prim_name<>''), kaf,
			KEYED(LEFT.prim_name = RIGHT.prim_name) AND
			KEYED(LEFT.prim_range = RIGHT.prim_range) AND
			KEYED(LEFT.zip5 = RIGHT.zip) AND
			KEYED(LEFT.predir = RIGHT.predir) AND
			KEYED(LEFT.postdir = RIGHT.postdir) AND
			KEYED(LEFT.addr_suffix = RIGHT.suffix) AND
			KEYED(LEFT.sec_range = RIGHT.sec_range) AND
			KEYED(right.source_code_2 = PROPERTY),
			append_fares_id_by_addr(left, right),
			INNER,
			KEEP(1000), 
			ATMOST(RiskWise.max_atmost) 
		);
	
		ids_plus_fares_by_address_thor := 
		JOIN(
			distribute(p_addr(prim_name<>''), hash64(prim_name, prim_range, zip5, sec_range)), 
			distribute(pull(kaf(source_code_2 = PROPERTY)), hash64(prim_name, prim_range, zip, sec_range)),
			LEFT.prim_name = RIGHT.prim_name AND
			LEFT.prim_range = RIGHT.prim_range AND
			LEFT.zip5 = RIGHT.zip AND
			LEFT.predir = RIGHT.predir AND
			LEFT.postdir = RIGHT.postdir AND
			LEFT.addr_suffix = RIGHT.suffix AND
			LEFT.sec_range = RIGHT.sec_range,
			append_fares_id_by_addr(left, right),
			INNER,
			KEEP(1000), 
			ATMOST(RiskWise.max_atmost),
			local
		);
		
	#IF(onThor)
		ids_plus_fares_by_address := group(ids_plus_fares_by_address_thor, seq);
	#ELSE
		ids_plus_fares_by_address := ids_plus_fares_by_address_roxie;
	#END
  
	ids_plus_fares_temp := ungroup(ids_plus_fares_by_did + ids_plus_fares_by_address);
	
	ids_plus_fares_roxie := 
		DEDUP( 
			SORT( // this sort is costly (1)
				(UNGROUP(ids_plus_fares_by_did) + UNGROUP(ids_plus_fares_by_address)), 
				seq, inp_did, ln_fares_id, -(UNSIGNED)(dataSrce = SEARCHED_BY_LEXID) 
			), 
			seq, inp_did, ln_fares_id 
		);	
	
	ids_plus_fares_and_seq := 
		DEDUP( 
			SORT( // this sort is costly (1)
				distribute((UNGROUP(ids_plus_fares_by_did) + UNGROUP(ids_plus_fares_by_address)), seq), 
				seq, inp_did, ln_fares_id, -(UNSIGNED)(dataSrce = SEARCHED_BY_LEXID), local 
			), 
			seq, inp_did, ln_fares_id, local 
		);
		
// dedup the dids and ln_fares_ids so we're only searching the property data 1 time with those combinations
// do it now just for the thor job, but likely would be a good idea to do this in roxie version as well 
// for batch transactions performance enhancement
	ids_plus_fares_thor := 
	dedup(
		sort(
				distribute(ids_plus_fares_temp, inp_did), 
				inp_did, ln_fares_id, -(UNSIGNED)(dataSrce = SEARCHED_BY_LEXID), local),
				inp_did, ln_fares_id, local);
	
	#IF(onThor)
		ids_plus_fares := ids_plus_fares_thor;
	#ELSE
		ids_plus_fares := ids_plus_fares_roxie;
	#END

	// output(ids_plus_fares_by_address,all, named('ids_plus_fares_by_address'));
	// output(ids_plus_fares_by_did_ddpd,all, named('ids_plus_fares_by_did_ddpd'));
	// output(ids_plus_fares,all, named('ids_plus_fares'));
	
	
	// 2. Get Property report records by ln_fares_id. These Property records are those 
	// that are output for the LN Property Report Service: very wide with single-record 
	// child datasets Deeds and Assessments, and a child dataset of multiple Parties also.
	
	
	property_fids_for_search := 
		PROJECT(
			ids_plus_fares, 
			TRANSFORM( LN_PropertyV2_Services.layouts.search_fid,
				SELF.ln_fares_id := LEFT.ln_fares_id,
				SELF.search_did  := LEFT.inp_did,
				SELF.isDeepDive  := FALSE
			)
		);
	
	// 2.a. Call function fn_get_report(); type results explicitly for reference:
	LN_PropertyV2_Services.layouts.combined.tmp property_records_full_raw := 
		LN_PropertyV2_Services.fn_get_report_2(
			in_fids           := property_fids_for_search,
			skipPenaltyFilter := TRUE,
			inMaxProperties   := 0,
			inTrimBySortBy    := FALSE,
			nonSS             := suppress.constants.NonSubjectSuppression.doNothing,
			isFCRA            := is_FCRA,
			in_mod            := input_mod);

	// 2.b. Convert single-record child datasets into datarows for rolling up later.
	// (You can't rollup a child dataset within a dataset.)
	property_records_full_pre :=
		PROJECT(
			property_records_full_raw,
			TRANSFORM( layout_properties_temp_pre,
				SELF.deed       := LEFT.deeds[1];
				SELF.assessment := LEFT.assessments[1];
				SELF.parties    := LEFT.parties;
	// need to extract state from deed and assessment record so we can filter out restricted states for Profile Booster
				deed_comma 			:= stringlib.stringfind(LEFT.deeds[1].property_address_citystatezip, ',', 1);
				deed_st    			:= LEFT.deeds[1].property_address_citystatezip[deed_comma+2..deed_comma+3];  //city is followed by comma and space, then state
				SELF.deed_st    := deed_st;
				assm_comma 			:= stringlib.stringfind(LEFT.assessments[1].property_city_state_zip, ',', 1);
				assm_st    			:= LEFT.assessments[1].property_city_state_zip[assm_comma+2..assm_comma+3];  //city is followed by comma and space, then state
				SELF.assm_st    := assm_st;
				SELF            := LEFT;
			)
		);

	// 2.c. And now project into a (much) slimmer layout to conserve memory.
	property_records_full := 
		PROJECT(if(is_from_PB,  //need to filter out restricted states if this is being called from Profile Booster
			property_records_full_pre(TRIM(stringlib.stringtouppercase(deed_st)) not in ProfileBooster.Constants.setPropertyStatesRes and TRIM(stringlib.stringtouppercase(assm_st)) not in ProfileBooster.Constants.setPropertyStatesRes),
			property_records_full_pre),
			TRANSFORM( layout_properties_temp,
				SELF.deed       := LEFT.deed;
				SELF.assessment := LEFT.assessment;
				SELF.parties    := project(LEFT.parties, transform(layout_parties_slim, 
																														self.entity := project(left.entity, transform(layout_entity_slim, self := left)),
																														self := left)
																	);
				SELF            := LEFT;			
			)
		);
	
	// 3. Append an ad hoc, unique-enough property identifer. This will help differentiate
	// the properties one from another while avoiding problems raised by using the APN 
	// or the full street address.
	ds_property_recs_raw_with_uniqueid :=
		PROJECT(
			property_records_full,
			TRANSFORM( layout_property_plus_id,
				SELF.unique_prop_id := getPropertyId(LEFT.parties),
				SELF := LEFT,
				SELF := []
			)
		);

	// 4. Filter property records:
	
	// 4.a. Use a Join filter to remove property records more recent than the historydate.
	ds_property_recs_filt_a_roxie := 
		JOIN(
			ids_plus_fares_roxie, ds_property_recs_raw_with_uniqueid,
			LEFT.ln_fares_id = RIGHT.ln_fares_id AND
			// REMOVE RECORDS THAT ARE OUTSIDE THE BOUNDS OF THE ADDRESS DATES
			(UNSIGNED3)(RIGHT.sortby_date[1..6]) >= LEFT.p_address_dt_first_seen and 
			((UNSIGNED3)(RIGHT.sortby_date[1..6]) <= LEFT.p_address_dt_last_seen or LEFT.p_address_dt_last_seen=0) and
			// remove records that are after the history date
			(UNSIGNED3)(RIGHT.sortby_date[1..6]) <= LEFT.historydate,
			TRANSFORM( layout_full_plus_ids,
				self.seq := left.seq,  // just for personal sanity sake, map the seq number from the left dataset
				SELF := RIGHT, 
				SELF := LEFT
			),
			INNER,
			KEEP(1)
		);

	ds_property_recs_filt_a_local :=
		SORT(
			JOIN(
				distribute(ids_plus_fares_and_seq, hash(ln_fares_id)), 
				distribute(ds_property_recs_raw_with_uniqueid, hash(ln_fares_id)),
				LEFT.ln_fares_id = RIGHT.ln_fares_id AND
				// REMOVE RECORDS THAT ARE OUTSIDE THE BOUNDS OF THE ADDRESS DATES
				(UNSIGNED3)(RIGHT.sortby_date[1..6]) >= LEFT.p_address_dt_first_seen and 
				((UNSIGNED3)(RIGHT.sortby_date[1..6]) <= LEFT.p_address_dt_last_seen or LEFT.p_address_dt_last_seen=0) and
				// remove records that are after the history date
				(UNSIGNED3)(RIGHT.sortby_date[1..6]) <= LEFT.historydate,
				TRANSFORM( layout_full_plus_ids,
					self.seq := left.seq,  // just for personal sanity sake, map the seq number from the left dataset
					SELF := RIGHT, 
					SELF := LEFT
				),
				INNER,
				KEEP(1)
			, local),
			seq, inp_did, ln_fares_id, -(UNSIGNED)(dataSrce = SEARCHED_BY_LEXID)) 
			;
	
	#IF(onThor)
		ds_property_recs_filt_a := ds_property_recs_filt_a_local;
	#ELSE
		ds_property_recs_filt_a := ds_property_recs_filt_a_roxie;
	#END
  
	// 4.b. Filter out FARES records if indicated.
	ds_property_recs_filt_b := ds_property_recs_filt_a(vendor_source_flag = FIDELITY OR NOT filter_out_fares);
	
	// 4.c. Filter out records that are of type Mortgage (these are noise).
	ds_property_recs_filt_c := ds_property_recs_filt_b(ln_fares_id[2] != MORTGAGE);
	
	// 4.d. Filter out records that have a blank street address (indicating there's no 
	// property address associated with the record, and so it's not usable).
	ds_property_recs_filt_d := ds_property_recs_filt_c(parties(party_type = PROPERTY)[1].prim_name != '');
	// Filter off records that are PO Boxes or that don't have a prim range as unparsable
	ds_property_recs_filt_d2 := ds_property_recs_filt_d(parties(party_type = PROPERTY)[1].prim_range != '');

	// 4.e. Use a Transform/Skip to filter out records obtained via lex_id, keeping:
	//   o  ...assessment records where the applicant is listed as an Owner
	//   o  ...deed records where the applicant is listed as a Buyer (which 
	//      is a type of Owner) or Seller
	//   o  All records obtained via address-only are retained. These records--regardless 
	//      of who owned the property while the applicant lived there--can provide useful 
	//      data that may be used to infer the applicant’s relationship to the property owner.
	layout_full_plus_ids xfm_filter_out_non_ownership_records( layout_full_plus_ids le ) :=
		TRANSFORM, SKIP( 
				le.dataSrce = SEARCHED_BY_LEXID AND
				(
					(le.fid_type = ASSESSMENT_RECORD AND getPropertyStatus(le) NOT IN [ APPLICANT_OWNED ]) 
					OR
					(le.fid_type = DEED_RECORD AND getPropertyStatus(le) NOT IN [ APPLICANT_OWNED, APPLICANT_SOLD ])
				)
			)
			SELF := le;
		END;
	
	ds_property_recs_filt_e := 
		PROJECT( ds_property_recs_filt_d2, xfm_filter_out_non_ownership_records(LEFT) );
	// 4.f. Calculate naprop value for each property record, and obtain the highest value per group.
	ds_property_recs_with_naprop := 
		PROJECT( 
			ds_property_recs_filt_e, 
			TRANSFORM( layout_full_plus_ids,
				SELF.naprop := calc_napprop(getPropertyStatus(LEFT)),
				SELF := LEFT
			)
		);


	ds_property_recs_with_naprop_grpd := 
		GROUP( SORT( ds_property_recs_with_naprop, seq, inp_did, unique_prop_id ), seq, inp_did, unique_prop_id );
	
	tbl_naprop_values_local_roxie := 
		TABLE( 
			ds_property_recs_with_naprop_grpd, 
			{seq, inp_did, unique_prop_id, max_naprop_local := MAX(GROUP, naprop)}, 
			seq, inp_did, unique_prop_id, local
		);
		
	tbl_naprop_values_local_thor := 
		TABLE( 
			ds_property_recs_with_naprop, 
			{seq, inp_did, unique_prop_id, max_naprop_local := MAX(GROUP, naprop)}, 
			seq, inp_did, unique_prop_id, local
		);
	
	#IF(onThor)
		tbl_naprop_values_local := tbl_naprop_values_local_thor;
	#ELSE
		tbl_naprop_values_local := tbl_naprop_values_local_roxie;
	#END
  
	tbl_naprop_values := 
		TABLE( 
			tbl_naprop_values_local, 
			{seq, inp_did, unique_prop_id, max_naprop := MAX(GROUP, max_naprop_local)}, 
			seq, inp_did, unique_prop_id
		);
	
	
	// 5. Get the two most recent assessment records for each property--one record each 
	// of vendor_source_flag 'A' (FARES) and 'B' (FIDELITY).
	
	// 5.a. Filter to obtain assessment records only.
	ds_assess_recs_FARES    := ds_property_recs_with_naprop(fid_type = ASSESSMENT_RECORD AND vendor_source_flag = FARES);
	ds_assess_recs_FIDELITY := ds_property_recs_with_naprop(fid_type = ASSESSMENT_RECORD AND vendor_source_flag = FIDELITY);

	// 5.a.1. Since FIDELITY assessment records are sometimes poorly populated, roll these up and 
	// preserve any values that must be used in the final transform. Keep the most recent of 
	// each value.
	ds_assess_recs_FIDELITY_rolled :=
		ROLLUP(
			SORT( ds_assess_recs_FIDELITY, seq, inp_did, unique_prop_id, -(UNSIGNED)(sortby_date[1..4]) ),
			LEFT.seq = RIGHT.seq AND
			LEFT.inp_did = RIGHT.inp_did AND
			LEFT.unique_prop_id = RIGHT.unique_prop_id,
			TRANSFORM( layout_full_plus_ids,
				SELF.assessment.sales_price                := IF( LEFT.assessment.sales_price != '', LEFT.assessment.sales_price, RIGHT.assessment.sales_price ),
				SELF.assessment.prior_sales_price          := IF( LEFT.assessment.prior_sales_price != '', LEFT.assessment.prior_sales_price, RIGHT.assessment.prior_sales_price ),
				SELF.assessment.market_total_value         := IF( LEFT.assessment.market_total_value != '', LEFT.assessment.market_total_value, RIGHT.assessment.market_total_value ),
				SELF.assessment.prior_recording_date       := IF( LEFT.assessment.prior_recording_date != '', LEFT.assessment.prior_recording_date, RIGHT.assessment.prior_recording_date ),
				SELF.assessment.sale_date                  := IF( LEFT.assessment.sale_date != '', LEFT.assessment.sale_date, RIGHT.assessment.sale_date ),
				SELF.assessment.assessed_total_value       := IF( LEFT.assessment.assessed_total_value != '', LEFT.assessment.assessed_total_value, RIGHT.assessment.assessed_total_value ),
				SELF.assessment.year_built                 := IF( LEFT.assessment.year_built != '', LEFT.assessment.year_built, RIGHT.assessment.year_built ),
				SELF.assessment.effective_year_built       := IF( LEFT.assessment.effective_year_built != '', LEFT.assessment.effective_year_built, RIGHT.assessment.effective_year_built ),
				SELF.assessment.mortgage_loan_amount       := IF( LEFT.assessment.mortgage_loan_amount != '', LEFT.assessment.mortgage_loan_amount, RIGHT.assessment.mortgage_loan_amount ),
				SELF.assessment.mortgage_loan_type_code    := IF( LEFT.assessment.mortgage_loan_type_code != '', LEFT.assessment.mortgage_loan_type_code, RIGHT.assessment.mortgage_loan_type_code ),
				SELF.assessment.standardized_land_use_code := IF( LEFT.assessment.standardized_land_use_code != '', LEFT.assessment.standardized_land_use_code, RIGHT.assessment.standardized_land_use_code ),
				SELF.assessment.building_area              := IF( LEFT.assessment.building_area != '', LEFT.assessment.building_area, RIGHT.assessment.building_area ),
				SELF.assessment.no_of_buildings            := IF( LEFT.assessment.no_of_buildings != '', LEFT.assessment.no_of_buildings, RIGHT.assessment.no_of_buildings ),
				SELF.assessment.no_of_units                := IF( LEFT.assessment.no_of_units != '', LEFT.assessment.no_of_units, RIGHT.assessment.no_of_units ),
				SELF.assessment.no_of_stories              := IF( LEFT.assessment.no_of_stories != '', LEFT.assessment.no_of_stories, RIGHT.assessment.no_of_stories ),
				SELF.assessment.no_of_rooms                := IF( LEFT.assessment.no_of_rooms != '', LEFT.assessment.no_of_rooms, RIGHT.assessment.no_of_rooms ),
				SELF.assessment.no_of_bedrooms             := IF( LEFT.assessment.no_of_bedrooms != '', LEFT.assessment.no_of_bedrooms, RIGHT.assessment.no_of_bedrooms ),
				SELF.assessment.no_of_baths                := IF( LEFT.assessment.no_of_baths != '', LEFT.assessment.no_of_baths, RIGHT.assessment.no_of_baths ),
				SELF.assessment.no_of_partial_baths        := IF( LEFT.assessment.no_of_partial_baths != '', LEFT.assessment.no_of_partial_baths, RIGHT.assessment.no_of_partial_baths ),
				SELF.assessment.garage_type_code           := IF( LEFT.assessment.garage_type_code != '', LEFT.assessment.garage_type_code, RIGHT.assessment.garage_type_code ),
				SELF.assessment.parking_no_of_cars         := IF( LEFT.assessment.parking_no_of_cars != '', LEFT.assessment.parking_no_of_cars, RIGHT.assessment.parking_no_of_cars ),
				SELF.assessment.style_code                 := IF( LEFT.assessment.style_code != '', LEFT.assessment.style_code, RIGHT.assessment.style_code ),
				SELF.assessment.assessed_value_year        := IF( LEFT.assessment.assessed_value_year != '', LEFT.assessment.assessed_value_year, RIGHT.assessment.assessed_value_year ),
				SELF.assessment.tax_year                   := IF( LEFT.assessment.tax_year != '', LEFT.assessment.tax_year, RIGHT.assessment.tax_year ),
				SELF.deed                                  := LEFT.deed,
				SELF.parties                               := LEFT.parties,
				SELF                                       := LEFT
			)
		);
	
	// 5.b. Sort and group, ensuring that our grouping includes the vendor_source_flag. Retain
	// the higher market value.
	ds_assess_recs_grpd := 
		GROUP(
			SORT( 
				(ds_assess_recs_FARES + ds_assess_recs_FIDELITY_rolled), 
				seq,
				inp_did,
				unique_prop_id,
				vendor_source_flag, // This will sort FARES ('A') ahead of FIDELITY ('B').
				-(UNSIGNED)(sortby_date[1..4]), 
				-(UNSIGNED)assessment.market_total_value
			), 
			seq, inp_did, unique_prop_id, vendor_source_flag
		);
		
	// 5.c. topn(1) to obtain the single most recent record for each vendor_source_flag.
	ds_assess_recs_most_recent_pre := 
		TOPN( ds_assess_recs_grpd, 1, seq, inp_did, unique_prop_id, vendor_source_flag );
	
	// 5.d. Transform previous purchase dates and prices since they are displayed in different
	// fields in FARES and FIDELITY records.
	// NOTES:
	//   o   FARES records list the previous purchase price as prior_sales_price; FIDELITY *often* lists as sales_price
	//   o   FARES records list the previous purchase date as prior_recording_date; FIDELITY lists as recording_date
	ds_assess_recs_most_recent :=
		PROJECT(
			ds_assess_recs_most_recent_pre,
			TRANSFORM( layout_full_plus_ids,
				SELF.assessment := 
					PROJECT(
						LEFT.assessment,
						TRANSFORM( layout_assessment_slim, // LN_PropertyV2_Services.layouts.assess.result.tmp,
							SELF.prior_sales_price :=
								IF( LEFT.fid_type = ASSESSMENT_RECORD AND LEFT.vendor_source_flag = FIDELITY AND LEFT.prior_sales_price = '', LEFT.sales_price, LEFT.prior_sales_price ),
							SELF.prior_recording_date :=
								IF( LEFT.fid_type = ASSESSMENT_RECORD AND LEFT.vendor_source_flag = FIDELITY AND LEFT.prior_recording_date = '', LEFT.recording_date, LEFT.prior_recording_date ),
							SELF := LEFT
						)
					),
				SELF := LEFT
			)
		);

	// 6. Now, get the two most recent Deed records for each property--one record of
	// each of vendor_source_flag 'A' (FARES) and 'B' (FIDELITY).
	
	// 6.a. Filter to obtain deed records only.
	ds_deed_recs := ds_property_recs_with_naprop(fid_type = DEED_RECORD);

	// 6.b. Those Deed records having no Seller are usually refinance transactions. Throw 
	// them out.
	ds_deed_recs_filt_a := ds_deed_recs(EXISTS(parties(party_type = SELLER)));

	// 6.c. Filter out FARES Deed records that don't have to do with the sale of a property.
	ds_deed_recs_filt_b := 
		ds_deed_recs_filt_a(deed.fares_transaction_type_desc IN ['','RESALE']);
	
	// 6.d. Sort and group on unique property id and vendor_sorce_flag ('A' or 'B'). 
	ds_deed_recs_grpd := 
		GROUP(
			SORT( 
				ds_deed_recs_filt_b, /* by */
				seq,
				inp_did,
				unique_prop_id,
				vendor_source_flag,
				-(UNSIGNED)sortby_date
			), 
			seq, inp_did, unique_prop_id, vendor_source_flag
		);
	

	// 6.e. topn(1) to obtain the single most recent record for each vendor_source_flag.
	ds_deed_recs_most_recent := 
		TOPN( ds_deed_recs_grpd, 1, seq, inp_did, unique_prop_id, vendor_source_flag );
	
	// 7. Now, union the assessments and deeds together and sort them so that each property's
	// FARES assessment and deed are adjacent, and FIDELITY's assessment and deed are adjacent.
	// Determine the most recent records among those of types 'A' and 'B'. We must use data from 
	// both the Assessment and the Deed to complete the final record layout.
	
	// 7.a. Union the Assessment and Deed records; sort, group, and topn(1) by unique_prop_id 
	// to find the most recent record, whether it be an assessment or a deed, having type 'A' 
	// or type 'B'. We will favor type 'A' records, since they are preferred over type 'B' records.
	ds_assessments_and_deeds_most_recent := 
		SORT(
			( UNGROUP(ds_assess_recs_most_recent) + UNGROUP(ds_deed_recs_most_recent) ),
			seq,
			inp_did,
			unique_prop_id,  
			-(UNSIGNED)(vendor_source_flag = FARES),
			-(UNSIGNED)(sortby_date[1..4])
		);

	// 7.b. The following code removes either a singleton assessment record or deed record.
	// In most cases by this time each property will have 4 records associated with it,
	// two from each vendor: a FARES assessment record, a FARES deed record; a FIDELITY 
	// assessment record, and a FIDELITY deed record. Sometimes though, the following may 
	// happen:
	//   o  there is only one record total--this can happen if the property has been just
	//   purchased (so it's a deed record from one or the other vendor), or the property
	//   has been owned for a very long time (so it's an assessment record from one or the
	//   other vendor). This is not an issue.
	//   o  there are only two records total--this can happen when the above scenario 
	//   occurs where we have records from both vendors, or there is a deed record and an
	//   assessment record from one vendor or the other. This is not an issue either.
	//   o  there are three records--one vendor has supplied both an assessment and a 
	//   deed record, and the other vendor supplied either an assessment or deed record.
	//   We want to eliminate the singleton record in this case since there is a good
	//   assessment-deed pair whose data we can return to the customer.

	ds_assessments_and_deeds_most_recent_grpd := 
		GROUP(ds_assessments_and_deeds_most_recent, seq, inp_did, unique_prop_id );

	layout_temp := RECORD
		UNSIGNED4 seq;
		UNSIGNED6 inp_did;
		STRING8 unique_prop_id;
		DATASET(layout_full_plus_ids) recs;
	END;
	
	layout_temp xfm_throw_out_singleton_records(layout_full_plus_ids le, DATASET(layout_full_plus_ids) allRows) :=
		TRANSFORM 
			SELF.seq            := le.seq;
			SELF.inp_did        := le.inp_did;
			SELF.unique_prop_id := le.unique_prop_id;
			SELF.recs := 
				IF( 
					COUNT(allRows) = 3, 
					MAP(
						allRows[1].vendor_source_flag = allRows[2].vendor_source_flag => allRows[1..2],
						allRows[2..3]
					), 
					allRows 
				);
		END;
	
	ds_assessments_and_deeds_temp :=
		ROLLUP(
			ds_assessments_and_deeds_most_recent_grpd,
			GROUP,
			xfm_throw_out_singleton_records(LEFT,ROWS(LEFT))
		);
	
	layout_full_plus_ids norm_property_recs(layout_full_plus_ids R) :=
		TRANSFORM
			SELF := R;
		END;
	
	ds_assessments_and_deeds_unioned := 
		NORMALIZE( ds_assessments_and_deeds_temp, LEFT.recs, norm_property_recs(RIGHT) );
	
	// Not sure if the property records remained grouped, so we're going to regroup them.
	ds_assessments_and_deeds_most_recent_regrpd :=
		GROUP(
			SORT(
				UNGROUP(ds_assessments_and_deeds_unioned),
				seq,
				inp_did,
				unique_prop_id,  
				-(UNSIGNED)(vendor_source_flag = FARES),
				-(UNSIGNED)(sortby_date[1..4])
			),
			seq, inp_did, unique_prop_id
		);
				
	// 7.c. Use a TOPN to obtain the first property record from each group. This is a 
	// representative record of type FARES or FIDELTY that we'll use to select the other
	// FARES or FIDELITY record.
	ds_assessments_and_deeds_grpd_best_choice := 
		TOPN( ds_assessments_and_deeds_most_recent_regrpd, 1, seq, inp_did, unique_prop_id );

	// 7.d. Now join the representative record (single record for each property containing
	// either a FARES or FIDELITY vendor_source_flag) back to the most recent deeds and 
	// assessment records to obtain the best pair of records. 
	ds_assessments_and_deeds_best_vendor_source := 
		JOIN(
			ds_assessments_and_deeds_most_recent,
			UNGROUP(ds_assessments_and_deeds_grpd_best_choice),
			LEFT.seq = RIGHT.seq AND
			LEFT.inp_did = RIGHT.inp_did AND
			LEFT.unique_prop_id = RIGHT.unique_prop_id AND
			LEFT.vendor_source_flag = RIGHT.vendor_source_flag,
			TRANSFORM(LEFT),
			INNER
		);

	// 8. For each property, roll the Assessment, Deed, and Parties data into a single property record.
	// Assumption: in the case where, for any particular property, the most recent Assessment and 
	// Deed records occur in the same year, the Deed is the last to have occurred and therefore
	// indicates the owner has sold the property. Else the Assessment record is the most recent and 
	// so indicates that the owner is still...well...the owner. In any case there should be only two 
	// records per property--one Assessment and one Deed--to roll up.
	ds_best_vendor_source_sorted :=
		SORT(
			ds_assessments_and_deeds_best_vendor_source,
			seq, inp_did, unique_prop_id, -(UNSIGNED)(sortby_date[1..4]), -(UNSIGNED)(fid_type = DEED_RECORD)
		);


	// .. Preserve both Deeds and Assessments data; choose which Parties to preserve.
	ds_best_vendor_source_rolled := 
		ROLLUP(
			ds_best_vendor_source_sorted,
			TRANSFORM( layout_full_plus_ids,
				SELF.deed       := IF( LEFT.fid_type = DEED_RECORD, LEFT.deed, RIGHT.deed ), 
				SELF.assessment := IF( LEFT.fid_type = DEED_RECORD, RIGHT.assessment, LEFT.assessment ), 
				SELF.parties    := LEFT.parties,
				SELF := LEFT
			),
			seq, inp_did, unique_prop_id
		);

	// 10. Transform Assessment data to final output layout (with extra fields).
	layout_full_temp xfm_to_final_layout( layout_full_plus_ids le, tbl_naprop_values rt ) := 
		TRANSFORM
			SELF.naprop                         := rt.max_naprop;
			
			// -----[ Local aliases and derived values ]-----
			_deed             := le.deed;
			_assess           := le.assessment;
			_property         := le.parties(party_type = PROPERTY)[1];			
			_property_status  := getPropertyStatus(le);
			_property_is_sold := _property_status IN [APPLICANT_SOLD];
			
			// For sold properties:
			_property_prior_purchase_amount := (INTEGER)IF( _property_is_sold, _assess.prior_sales_price, '' );
			_property_prior_purchase_date   := (INTEGER)IF( _property_is_sold, _assess.prior_recording_date, '' );
			_property_sale_amount           := (INTEGER)IF( _property_is_sold, _deed.sales_price, '' );
			_property_sale_date             := (INTEGER)IF( _property_is_sold, IF( _deed.contract_date != '', _deed.contract_date, _deed.recording_date ), '' );

			// For owned properties:
			_property_purchase_amount := (INTEGER)IF( _property_status IN [APPLICANT_OWNED], IF( _deed.sales_price != '', _deed.sales_price, _assess.sales_price ), '' );
			_property_purchase_date := 
				(INTEGER)IF( 
					_property_status IN [APPLICANT_OWNED,FAMILY_OWNED],
					MAP( // then
						_deed.contract_date != ''  => _deed.contract_date, 
						_deed.recording_date != '' => _deed.recording_date,
						_assess.sale_date != ''    => _assess.sale_date, 
						'' // default
					), 
					'' // else
				);
			// Start transform.
			SELF.seq                            := le.seq;
			SELF.did                            := le.inp_did;
			SELF.ad                             := le.fid_type;
			
			SELF.isrelat                        := le.isrelat;

			SELF.property_status_applicant      := MAP( le.isrelat => ' ', _property_status = APPLICANT_SOLD => SELLER, _property_status = APPLICANT_OWNED  => OWNER, ' ' ); 
			SELF.property_status_family         := MAP( le.isrelat and _property_status in [APPLICANT_SOLD, FAMILY_SOLD]    => SELLER, 
																									le.isrelat and _property_status IN [APPLICANT_OWNED, FAMILY_OWNED]   => OWNER, 
																									' ' ); 
			
			// Populate the following fields only if the Applicant is either the Owner or 
			// Seller of the property.
			applicant_is_owner           := _property_status = APPLICANT_OWNED;
			applicant_is_seller          := _property_status = APPLICANT_SOLD;
			applicant_is_owner_or_seller := _property_status IN [APPLICANT_OWNED,APPLICANT_SOLD];
	
			//property count/total = count of all the owned properties for owned / count of all sold properties for sold
			SELF.property_count                 :=  IF( applicant_is_owner_or_seller, 1, 0 );
			SELF.property_total                 :=  IF( applicant_is_owner_or_seller, 1, 0 );
			//property_owned_purchase_total = sum of all the property_purchase_amount for owned 
			SELF.property_owned_purchase_total  :=  MAP( applicant_is_owner => _property_purchase_amount, 
			//property_owned_purchase_total = sum of all the _property_sale_amount for sold 
																									 applicant_is_seller => _property_sale_amount, 0 );
			//property_owned_purchase_count = count of the property_purchase_amount > 0  for owned 															 
			SELF.property_owned_purchase_count  :=  MAP( applicant_is_owner => if(_property_purchase_amount > 0, 1, 0), 
			//property_owned_purchase_count = count of the _property_sale_amount > 0 for sold 					
																									applicant_is_seller => if( _property_sale_amount> 0, 1, 0), 0);
			//property_owned_assessed_total = sum of all the assessed_total_value(populated more often then market value) for owned / sold 
			SELF.property_owned_assessed_total  :=  IF( applicant_is_owner_or_seller, (INTEGER)_assess.assessed_total_value, 0 ); 
			//property_owned_assessed_count = count of the owned assessed_total_value > 0 for owned / sold														 			
			SELF.property_owned_assessed_count  :=  IF( applicant_is_owner_or_seller and (INTEGER)_assess.assessed_total_value > 0, 1, 0 );
	
			SELF.purchase_date                  := MAP( applicant_is_owner => _property_purchase_date, applicant_is_seller => _property_prior_purchase_date, 0 ); 
			SELF.built_date            := (INTEGER)(IF( applicant_is_owner_or_seller, IF( _assess.year_built != '', _assess.year_built, _assess.effective_year_built ), '0' ));
			SELF.purchase_amount                :=  IF( applicant_is_owner_or_seller, IF( _property_purchase_amount != 0, _property_purchase_amount, _property_prior_purchase_amount ), 0 );
			SELF.mortgage_amount      := (INTEGER)(MAP( applicant_is_owner =>	IF( _assess.mortgage_loan_amount != '', _assess.mortgage_loan_amount, _deed.first_td_loan_amount ), applicant_is_seller => _assess.mortgage_loan_amount, '0' ));
			SELF.mortgage_date        := (INTEGER)(MAP( applicant_is_owner =>	MAX( _deed.contract_date, _deed.recording_date, _assess.sale_date ), applicant_is_seller => _assess.sale_date, '0' ));
			SELF.mortgage_type                  :=  IF( applicant_is_owner_or_seller, getMortgageType(_assess.mortgage_loan_type_code, le.vendor_source_flag), '' );			
			SELF.type_financing                 :=  IF( applicant_is_owner, getFinancingType(_deed.type_financing, le.vendor_source_flag), '' );
			SELF.first_td_due_date              :=  IF( applicant_is_owner AND _deed.first_td_due_date != '', _deed.first_td_due_date, '' );
			SELF.assessed_amount       := (INTEGER)(IF( applicant_is_owner_or_seller, _assess.market_total_value, '0' ));   // NOTE! Technically this is wrong (an assessed value is only the same as the market value strictly by coincidence), but it's intentional and per the requirements.
			SELF.assessed_total_value  := (INTEGER)(IF( applicant_is_owner_or_seller, _assess.assessed_total_value, '0' )); 
			assessed_year := MAP( _assess.assessed_value_year != '' => _assess.assessed_value_year, 
														_assess.assessed_value_year != '' => _assess.assessed_value_year, 
														_assess.tax_year != '' => _assess.tax_year, 
														'' );
			SELF.assessed_value_year            :=  IF( applicant_is_owner_or_seller, assessed_year, '' );
			SELF.purchase_date_by_did           := MAP( applicant_is_owner => _property_purchase_date, applicant_is_seller => _property_prior_purchase_date, 0 );
			SELF.sale_date_by_did               :=  IF( applicant_is_seller, _property_sale_date, 0 );

			// Populate the remaining fields as usual.
			SELF.address_score                  := 0;     // never populated here
			SELF.house_number_match             := FALSE; // never populated here
			SELF.isbestmatch                    := FALSE; // never populated here
			SELF.unit_count                     := 0;     // never populated here
			SELF.geo12_fc_index                 := 0;     // never populated here
			SELF.geo11_fc_index                 := 0;     // never populated here
			SELF.fips_fc_index                  := 0;     // never populated here
			SELF.source_count                   := 0;     // never populated here
			SELF.sources                        := '';    // never populated here
			SELF.credit_sourced                 := FALSE; // never populated here
			SELF.eda_sourced                    := FALSE; // never populated here
			SELF.dl_sourced                     := FALSE; // never populated here
			SELF.voter_sourced                  := FALSE; // never populated here
			SELF.utility_sourced                := FALSE; // never populated here
			SELF.occupant_owned                 := isOwnerOccupied(le); 
			SELF.applicant_owned                := _property_status = APPLICANT_OWNED;
			SELF.applicant_sold                 := _property_status = APPLICANT_SOLD;
			SELF.family_owned                   := _property_status = FAMILY_OWNED;
			SELF.family_sold                    := _property_status = FAMILY_SOLD;
			SELF.applicant_buy_found            := _property_status = APPLICANT_OWNED; // NOTE: Sometimes in the case where there is a property long owned, there may be no record of a Deed; just Assessments. Can we then say applicant_buy_found?
			SELF.applicant_sale_found           := _property_status = APPLICANT_SOLD;
			SELF.family_buy_found               := _property_status = FAMILY_OWNED;
			SELF.family_sale_found              := _property_status = FAMILY_SOLD;
			SELF.date_first_seen                := 0;     // never populated here
			SELF.date_last_seen                 := 0;     // never populated here
			SELF.standardized_land_use_code     := _assess.standardized_land_use_code;
			SELF.building_area                  := (INTEGER)_assess.building_area;
			SELF.no_of_buildings                := IF( _assess.no_of_buildings != '', (INTEGER)_assess.no_of_buildings, (INTEGER)_assess.no_of_units );
			SELF.no_of_stories                  := (INTEGER)_assess.no_of_stories;
			SELF.no_of_rooms                    := (INTEGER)_assess.no_of_rooms;
			SELF.no_of_bedrooms                 := (INTEGER)_assess.no_of_bedrooms;
			SELF.no_of_baths                    := (INTEGER)_assess.no_of_baths;
			SELF.no_of_partial_baths            := (INTEGER)_assess.no_of_partial_baths;
			SELF.garage_type_code               := _assess.garage_type_code;
			SELF.parking_no_of_cars             := (INTEGER)_assess.parking_no_of_cars;
			SELF.style_code                     := _assess.style_code;
			SELF.hr_address                     := FALSE; // never populated here
			SELF.hr_company                     := '';    // never populated here
			SELF.prim_range                     := _property.prim_range;
			SELF.predir                         := _property.predir;
			SELF.prim_name                      := _property.prim_name;
			SELF.addr_suffix                    := _property.suffix;
			SELF.postdir                        := _property.postdir;
			SELF.unit_desig                     := _property.unit_desig;
			SELF.sec_range                      := _property.sec_range;
			SELF.city_name                      := _property.p_city_name;
			SELF.st                             := _property.st;
			SELF.zip5                           := _property.zip;
			SELF.county                         := _property.county;
			SELF.geo_blk                        := _property.geo_blk;
			SELF.lat                            := _property.geo_lat;
			SELF.long                           := _property.geo_long;
			SELF.census_age                     := '';    // never populated here
			SELF.census_income                  := '';    // never populated here
			SELF.census_home_value              := '';    // never populated here
			SELF.census_education               := '';    // never populated here
			SELF.full_match                     := FALSE; // never populated here
			SELF.census_loose                   := TRUE;  // hard-coded; I don't know why
			SELF.datasrce                       := le.datasrce;
			SELF.sale_price1                    := 0;     // to be populated below
			SELF.sale_date1                     := 0;     // to be populated below
			SELF.prev_purch_price1              := 0;     // to be populated below
			SELF.prev_purch_date1               := 0;     // to be populated below
			SELF.sale_price2                    := 0;     // to be populated below
			SELF.sale_date2                     := 0;     // to be populated below
			SELF.prev_purch_price2              := 0;     // to be populated below
			SELF.prev_purch_date2               := 0;     // to be populated below
			
			// temp fields for use later in xfm_add_most_recently_sold_data( ):
			SELF.property_status                := _property_status;
			SELF.property_purchase_amount       := _property_purchase_amount;
			SELF.property_purchase_date         := _property_purchase_date;
			SELF.property_prior_purchase_amount := _property_prior_purchase_amount;
			SELF.property_prior_purchase_date   := _property_prior_purchase_date;
			SELF.property_sale_amount           := _property_sale_amount;
			SELF.property_sale_date             := _property_sale_date;
			SELF.property_seq_no                := 1;
			SELF.is_sold                        := _property_is_sold;
			SELF.unique_prop_id                 := le.unique_prop_id;
			SELF := [];
		END;
	
	ds_final_pre := join( ds_best_vendor_source_rolled, tbl_naprop_values,
		left.seq=right.seq and left.inp_did=right.inp_did and left.unique_prop_id=right.unique_prop_id, xfm_to_final_layout(LEFT, right), left outer, keep(1)	);
	
	ds_property_sold_records  := ds_final_pre( is_sold );
	ds_property_owned_records := ds_final_pre( NOT is_sold );
	
	// 10.a. Add a seq number to each property associated with each applicant.
	ds_property_sold_plus_seq_no := 
		ITERATE( 
			SORT(	ds_property_sold_records,	seq, did, -sale_date_by_did, -purchase_date_by_did, RECORD	), 
			TRANSFORM( layout_full_temp,
				SELF.property_seq_no := IF( LEFT.seq = RIGHT.seq AND LEFT.did = RIGHT.did, LEFT.property_seq_no + 1, 2 ), // Because we assigned '1' to each record in the transform above
				SELF := RIGHT
			)
		);

	ds_final_pre_plus_seq_no := 
		SORT( 
			(ds_property_owned_records + ds_property_sold_plus_seq_no), 
			seq, did, -property_purchase_date, property_seq_no
		);

	// 10.b. Fill in data concerning the two most recently-sold properties; slim to final layout.
	
	Risk_Indicators.Layouts.Layout_Relat_Prop_Plus_BusInd xfm_add_most_recently_sold_data(layout_full_temp le) :=
		TRANSFORM
			SELF.sale_price1       := IF( le.property_seq_no = 2, le.property_sale_amount, 0 );
			SELF.sale_date1        := IF( le.property_seq_no = 2, le.property_sale_date, 0 );
			SELF.prev_purch_price1 := IF( le.property_seq_no = 2, le.property_prior_purchase_amount, 0 );
			SELF.prev_purch_date1  := IF( le.property_seq_no = 2, le.property_prior_purchase_date, 0 );
			SELF.sale_price2       := IF( le.property_seq_no = 3, le.property_sale_amount, 0 );
			SELF.sale_date2        := IF( le.property_seq_no = 3, le.property_sale_date, 0 );
			SELF.prev_purch_price2 := IF( le.property_seq_no = 3, le.property_prior_purchase_amount, 0 );
			SELF.prev_purch_date2  := IF( le.property_seq_no = 3, le.property_prior_purchase_date, 0 );
			SELF.Residential_or_Business_Ind  := '';
			SELF.historydate  		 := 0;
			SELF := le;
		END;
	
	ds_final := PROJECT( ds_final_pre_plus_seq_no,	xfm_add_most_recently_sold_data(LEFT)	);
	
	// 11. Group and sort in the same way as legacy boca shell property attributes. Return.
	Single_Property := SORT(GROUP(SORT(ds_final,seq),seq),prim_name,prim_range,zip5,sec_range,census_loose,dataSrce);

	
	// output(onThor, named('onThor'));
	
	// IF( ViewDebugs, OUTPUT( ids_plus_fares_by_did, NAMED('ids_plus_fares_by_did') ) );
	// IF( ViewDebugs, OUTPUT( ids_plus_fares_by_did_ddpd, NAMED('ids_plus_fares_by_did_ddpd') ) );
	// IF( ViewDebugs, OUTPUT( p_address_filt_a, NAMED('p_address_filt_a') ) );
	// IF( ViewDebugs, OUTPUT( p_address_filt_b, NAMED('p_address_filt_b') ) );
	// IF( ViewDebugs, OUTPUT( ids_plus_fares_by_did, NAMED('ids_plus_fares_by_did') ) );
	// IF( ViewDebugs, OUTPUT( ids_plus_fares_by_address, NAMED('ids_plus_fares_by_address') ) );
	// IF( ViewDebugs, OUTPUT( ids_plus_fares, NAMED('ids_plus_fares') ) );
// OUTPUT( ids_plus_fares_temp, NAMED('ids_plus_fares_temp') );
// OUTPUT( ids_plus_fares, NAMED('ids_plus_fares') );
	
	// IF( ViewDebugs, OUTPUT( ds_property_recs_raw_with_uniqueid, NAMED('property_recs_all') ) );
	// IF( ViewDebugs, OUTPUT( ds_property_recs_filt_a, NAMED('property_recs_filt_a') ) );
	// IF( ViewDebugs, OUTPUT( ds_property_recs_filt_b, NAMED('property_recs_filt_b') ) );
	// IF( ViewDebugs, OUTPUT( ds_property_recs_filt_c, NAMED('property_recs_filt_c') ) );
	// IF( ViewDebugs, OUTPUT( ds_property_recs_filt_d, NAMED('property_recs_filt_d') ) );
	// IF( ViewDebugs, OUTPUT( ds_property_recs_filt_e, NAMED('property_recs_filt') ) );
	// IF( ViewDebugs, OUTPUT( ds_property_recs_with_naprop, NAMED('property_recs_with_naprop') ) );
	// IF( ViewDebugs, OUTPUT( tbl_naprop_values, NAMED('tbl_naprop_values') ) );
	
	// IF( ViewDebugs, OUTPUT( ds_assess_recs_FARES, NAMED('assess_recs_FARES') ) );
	// IF( ViewDebugs, OUTPUT( ds_assess_recs_FIDELITY, NAMED('assess_recs_FIDELITY') ) );
	// IF( ViewDebugs, OUTPUT( ds_assess_recs_FIDELITY_rolled, NAMED('assess_recs_FIDELITY_rolled') ) );
	// IF( ViewDebugs, OUTPUT( ds_assess_recs_most_recent, NAMED('assess_recs_most_recent') ) );
	
	// IF( ViewDebugs, OUTPUT( ds_deed_recs, NAMED('deed_recs') ) );
	// IF( ViewDebugs, OUTPUT( ds_deed_recs_filt_b, NAMED('deed_recs_filt') ) );
	// IF( ViewDebugs, OUTPUT( ds_deed_recs_most_recent, NAMED('deed_recs_most_recent') ) );
	
	// IF( ViewDebugs, OUTPUT( ds_assessments_and_deeds_most_recent, NAMED('all_recs_most_recent') ) );
	// IF( ViewDebugs, OUTPUT( ds_assessments_and_deeds_best_vendor_source, NAMED('best_vendor_source') ) );
	// IF( ViewDebugs, OUTPUT( ds_best_vendor_source_rolled, NAMED('best_vendor_source_rolled') ) );
	// IF( ViewDebugs, OUTPUT( ds_final_found, NAMED('ds_final_found') ) );
	// IF( ViewDebugs, OUTPUT( ds_final_pre, NAMED('final_pre') ) );
	// IF( ViewDebugs, OUTPUT( ds_final_not_found, NAMED('final_not_found') ) );	
	
	// output(ids_only, named('ids_only'));
	// output(p_address, named('p_address'));
	// output(ids_plus_fares_by_did, named('ids_plus_fares_by_did'));
	// output(ids_plus_fares_by_address, named('ids_plus_fares_by_address'));
	// output(ids_plus_fares, named('ids_plus_fares'));
	// output(property_fids_for_search, named('property_fids_for_search'));
	// output(property_records_full_raw, named('property_records_full_raw'));
	// output(property_records_full_pre, named('property_records_full_pre'));
	// output(property_records_full, named('property_records_full'));
	// output(ds_property_recs_raw_with_uniqueid, named('ds_property_recs_raw_with_uniqueid'));
	// output(ds_property_recs_filt_d2, named('ds_property_recs_filt_d2'));
	// output(ds_property_recs_filt_e, named('ds_property_recs_filt_e'));
	// output(ds_assess_recs_FARES, named('ds_assess_recs_FARES'));
	// output(ds_assess_recs_FIDELITY, named('ds_assess_recs_FIDELITY'));
	// output(ds_assess_recs_FIDELITY_rolled, named('ds_assess_recs_FIDELITY_rolled'));
	// output(ds_assess_recs_most_recent_pre, named('ds_assess_recs_most_recent_pre'));
	// output(ds_assess_recs_most_recent, named('ds_assess_recs_most_recent'));
	// output(ds_deed_recs, named('ds_deed_recs'));
	// output(ds_deed_recs_most_recent, named('ds_deed_recs_most_recent'));
	// output(ds_assessments_and_deeds_unioned, named('ds_assessments_and_deeds_unioned'));
	// output(ds_assessments_and_deeds_grpd_best_choice, named('ds_assessments_and_deeds_grpd_best_choice'));
	// output(ds_assessments_and_deeds_best_vendor_source, named('ds_assessments_and_deeds_best_vendor_source'));
	// output(ds_best_vendor_source_sorted, named('ds_best_vendor_source_sorted'));
	// output(ds_best_vendor_source_rolled, named('ds_best_vendor_source_rolled'));
	// output(ds_final_pre, named('ds_final_pre'));
	// output(ds_property_owned_records, named('ds_property_owned_records'));
	// output(ds_property_sold_records, named('ds_property_sold_records'));
	// output(ds_final, named('ds_final'));
	// output(single_property, named('single_property'));

	RETURN Single_Property;

END;