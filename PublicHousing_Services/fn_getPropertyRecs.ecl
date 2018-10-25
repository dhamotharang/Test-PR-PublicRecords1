IMPORT BatchDatasets, BatchServices, BatchShare, LN_PropertyV2_Services;

// High-level summary:
//
// The following function returns three Property records having the following layout side-by-side 
// (i.e. denormalized):
//
//	RECORD
//		STRING1  prop_owner;         // 0 (zero) - Individual Owns Property 1
//		STRING1  prop_sold;          // S - Individual Sold Property 1
//		STRING70 property_address;   // Property Address 1 found
//		STRING25 property_city;      // Property City found Property Address found
//		STRING2  property_state;     // Property State found
//		STRING10 property_zip;       // Property Zip found 
//		STRING12 total_value;        // Total Value of Property
//		STRING8  sale_date;          // Sale Date
//		STRING12 sale_price;         // Sale Price
//		STRING90 name_seller;        // Name of Seller
//		STRING12 mortgage_amount;    // Mortgage amount
//		STRING12 assess_value;       // Assessed value
//		STRING12 total_market_value; // Total market value
//		STRING8  recording_date;     // Recording date
//	END;
//	
// Some of the fields are specific to Assessments; others are specific to Deeds; still
// others may be gathered from either an Assessment or a Deed record. Furthermore, we
// must ensure that we return records that are composed of either entirely FARES or
// FIDELITY data; we cannot mix data from the two types in the same record.

EXPORT fn_getPropertyRecs(DATASET(Layouts.batch_in) ds_batch_in, DATASET(Layouts.batch_out) ds_batch_out_with_best_address, IParams.BatchParams in_mod) := 
	FUNCTION
	
		prop_val_threshold := (UNSIGNED)in_mod.PropertyValueThreshold;
		prop_yr_threshold  := (UNSIGNED)in_mod.PropertyYearThreshold;
		
		// --------------------[ CONSTANTS ]-------------------

		STRING1 ASSESSMENT := 'A';
		STRING1 DEED       := 'D';
		STRING1 OWNER      := 'O';
		STRING1 SELLER     := 'S';
		STRING1 PROPERTY   := 'P';
		STRING1 FARES      := 'A';
		STRING1 THE_OWNER  := '0'; // a zero
		STRING1 THE_SELLER := 'S';
	
		// --------------------[ LAYOUTS ]--------------------

		layout_property_plus_id := RECORD
			BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos;
			STRING unique_prop_id;
		END;

		rec_property_slim := RECORD   // 4.1.16... / Step 10 (Property)
			BatchShare.Layouts.ShareAcct;
			STRING45 apn; 
			STRING8  unique_prop_id;
			STRING2  rec_type;
			STRING8  sortby_date;
			STRING1  vendor_source_flag;
			STRING1  prop_owner;         // 0 (zero) - Individual Owns Property 1
			STRING1  prop_sold;          // S - Individual Sold Property 1
			STRING70 property_address;   // Property Address 1 found
			STRING25 property_city;      // Property City found Property Address found
			STRING2  property_state;     // Property State found
			STRING10 property_zip;       // Property Zip found 
			STRING12 total_value;        // Total Value of Property
			STRING8  sale_date;          // Sale Date
			STRING12 sale_price;         // Sale Price
			STRING90 name_seller;        // Name of Seller
			STRING12 mortgage_amount;    // Mortgage amount
			STRING12 assess_value;       // Assessed value
			STRING12 total_market_value; // Total market value
			STRING8  recording_date;     // Recording date
		END;

		// --------------------[ FUNCTIONS ]--------------------

		// The following function calculates a property identifier that will be unique among
		// a batch of 100 records, using the prim_range plus prim_name only. We're truncating 
		// the identifier to 8 chars, since on very rare occasions a sec_range will be mistaken 
		// for part of the prim_range, e.g. the address "85 BERKSHIRE D, WEST PALM BEACH, FL, 33417" 
		// points to a condo, and there are at least 4 variants to the prim_range: 85 BERKSHIRE D, 
		// 85 BERKSHIRE D 850, 85 BERKSHIRE 850, and 85 BERKSHIRE. Reducing the length of this 
		// property identifier to 8 chars will greatly reduce the chance of one or more variants 
		// of an address being mistaken for different addresses altogether.
		//
		// Why aren't we using the APN? Because not only is it a dirty record identifier (having 
		// dashes, spaces, padding zeroes), it's possible to have more than one APN refer to the
		// same property, e.g. see APNs for 3140 BROOKS ST, DAYTON, OH, 45420; or 3681 ECHO HILL LN, 
		// BEAVERCREEK, OH, 45430. Unacceptable.
		fn_calculate_property_id(DATASET(LN_PropertyV2_Services.layouts.parties.pparty) parties) :=
			FUNCTION
				proprty := parties(party_type = PROPERTY)[1];
				
				STRING8 unique_property_id :=
					StringLib.StringFilter(
						StringLib.StringToUpperCase(
							TRIM(proprty.prim_range) + TRIM(proprty.prim_name)
						), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	);
				
				RETURN unique_property_id;
			END;
		
		// The following function assembles a street address from the pertaining atomic parts.
		STRING fn_DisplayPropAddr( DATASET(LN_PropertyV2_Services.layouts.parties.pparty) party) :=
			FUNCTION
				RETURN TRIM(party[1].prim_range) 
						 + IF( TRIM(party[1].predir)    != '', ' ' + TRIM(party[1].predir), '' )
						 + IF( TRIM(party[1].prim_name) != '', ' ' + TRIM(party[1].prim_name), '' )
						 + IF( TRIM(party[1].suffix)    != '', ' ' + TRIM(party[1].suffix), '' )
						 + IF( TRIM(party[1].postdir)   != '', ' ' + TRIM(party[1].postdir), '' )
						 + IF( TRIM(party[1].unit_desig)!= '', ' ' + TRIM(party[1].unit_desig), '' ) 
						 + IF( TRIM(party[1].sec_range) != '', ' ' + TRIM(party[1].sec_range), '' );
			END;

		// The following function determines whether the search subject is the owner of a property.
		BOOLEAN fn_determine_property_ownership(layout_property_plus_id le, Layouts.batch_in ri) :=
			FUNCTION
				// A Homeowner can be an Assessee in a assessment record or a Buyer in a deed record.
				// Both of these are identified in the Parties child dataset as having party_type = 'O'.
				homeowner := le.parties(party_type = OWNER)[1]; 

				entity_1_is_owner := 
						homeowner.entity[1].lname = ri.name_last AND homeowner.entity[1].fname[1..3] = ri.name_first[1..3];

				entity_2_is_owner := 
						homeowner.entity[2].lname = ri.name_last AND homeowner.entity[2].fname[1..3] = ri.name_first[1..3];

				RETURN entity_1_is_owner OR entity_2_is_owner;
			END;

		// --------------------[ MAIN ]--------------------

		// 1. Get raw property records. We want to pass in only the SSN, since passing in a name and
		// address will obtain records for the property at that address only. We want all properties.
		ds_batch_in_for_properties :=
			PROJECT(
				ds_batch_in,
				TRANSFORM( Layouts.batch_in,
					SELF.acctno := LEFT.acctno,
					SELF.ssn := LEFT.ssn,
					SELF := []
				)
			);
	
		BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos 
				ds_property_recs_raw := SORT( BatchDatasets.fetch_Property_recs(ds_batch_in_for_properties), -((UNSIGNED)sortby_date) );
				
		// 2. Since APNs are often not consistent for the same property, call a function that 
		// returns an ad hoc, unique property value to use together with the acctno for linking 
		// the same properties among many DEEDs and ASSESSMENTs. We wouldn't ever want to use 
		// this id among, say 1 million records, but in a batch of 100, it's unique enough.
		ds_property_recs_raw_with_id :=
			PROJECT(
				ds_property_recs_raw,
				TRANSFORM( layout_property_plus_id,
					SELF.unique_prop_id := fn_calculate_property_id(LEFT.parties),
					SELF := LEFT
				)
			);

		// 3.a. Filter out any records having a blank street address. It indicates there's
		// no property address associated with the record, and so it's not usable.
		ds_property_recs_filt_on_primname := 
				ds_property_recs_raw_with_id( parties(party_type = PROPERTY)[1].prim_name != '' );

		// 3.b. Filter out any records having a blank prim_range, since it indicates a faulty 
		// address (this is a known problem with FIDELITY property records). Two rules to follow:
		//   1. Perform the filter when there are other records for the same property that have 
		//      a valid prim_range. 
		//   2. Do not perform the filter if all the property records for a particular address 
		//      have no prim_range, since this will leave us with no records at all for an address.
		// The filtering described above is accomplished via a dedup, where one of the conditions is
		// an inequality. This effectively filters the records according to the rules described. See
		// builder window runnable ECL code attached to #142285 for demo.
			
		ds_property_recs_filt_on_primname_sorted := 
			SORT(
				ds_property_recs_filt_on_primname,
				acctno, 
				parties(party_type = PROPERTY)[1].prim_name,
				-((UNSIGNED)(parties(party_type = PROPERTY)[1].prim_range != '')), 
				-((UNSIGNED)sortby_date)
			);

		ds_property_recs_filt_on_primrange := 
			DEDUP(
				ds_property_recs_filt_on_primname_sorted,
				LEFT.acctno = RIGHT.acctno, 
				parties(party_type = PROPERTY)[1].prim_name,
				LEFT.parties(party_type = PROPERTY)[1].prim_range != RIGHT.parties(party_type = PROPERTY)[1].prim_range
			);		
			
		// NOTE: for the following three major sections, we're making a big deal about finding
		// records having vendor_source_flags 'A' (FARES) and 'B' (FIDELITY). Our business rule
		// concerning property data is that we cannot return property records containing "mixed"
		// data, i.e. from both FARES and FIDELITY. The record must consist of only FARES, or 
		// only FIDELITY data.
		
		// --------------------[ PROCESS ASSESSMENT RECORDS ]--------------------

		// 4. The goal here is to arrive at two of the most recent assessment records for each 
		// property--one record each of vendor_source_flag 'A' and 'B'.

		ds_assess_recs := ds_property_recs_filt_on_primrange(fid_type = ASSESSMENT);	

		// 4.a. Sometimes, we'll have two assessment records having the same sortby_date, and  
		// this usually indicates (1) when the sortby_date is '20120000' for example, two  
		// assessment records were generated in the same calendar year--one near the beginning, 
		// and other near the end; or (2) when a homeowner has purchased a parcel of land and 
		// then built a house on it, one record describes the assessment of the land only, and 
		// the other describes the total assessed value of the land plus the house. In either 
		// case, we're looking for the assessment record having the higher market value.
		// 
		// NOTE, scenario (2) is a case when the same property may have two different APNs.
		ds_assess_recs_grpd := 
			GROUP(
				SORT( 
					ds_assess_recs, /* by */
					acctno, 
					unique_prop_id,
					vendor_source_flag, 
					-(UNSIGNED)sortby_date, 
					-MAX( 
						(UNSIGNED)assessments[1].market_total_value, 
						(UNSIGNED)assessments[1].fares_calculated_total_value 
					) 
				), 
				acctno, unique_prop_id, vendor_source_flag
			);

		ds_assess_recs_topn := 
				TOPN( ds_assess_recs_grpd, 1, acctno, unique_prop_id, vendor_source_flag );
					
		// 4.b. Slim the Assessment records.
		rec_property_slim xfm_slim_assess_rec(layout_property_plus_id le) :=
			TRANSFORM
					is_owner := fn_determine_property_ownership( le, ds_batch_in(acctno = le.acctno)[1] );
					max_total_market_value := 
						MAX( 
							(UNSIGNED)le.assessments[1].market_total_value, 
							(UNSIGNED)le.assessments[1].fares_calculated_total_value 
						);
				SELF.acctno             := le.acctno;
				SELF.apn                := le.assessments[1].apna_or_pin_number;
				SELF.unique_prop_id     := le.unique_prop_id;
				SELF.rec_type           := le.fid_type;
				SELF.sortby_date        := le.sortby_date;
				SELF.vendor_source_flag := le.vendor_source_flag;
				SELF.prop_owner         := IF( is_owner, THE_OWNER, '' );
				SELF.prop_sold          := IF( NOT is_owner, THE_SELLER, '' );
				SELF.property_address   := fn_DisplayPropAddr(le.parties(party_type = PROPERTY));
				SELF.property_city      := le.parties(party_type = PROPERTY)[1].p_city_name;
				SELF.property_state     := le.parties(party_type = PROPERTY)[1].st;
				SELF.property_zip       := le.parties(party_type = PROPERTY)[1].zip;
				SELF.total_value := 
					MAP(
						max_total_market_value > 0                   => (STRING)max_total_market_value,
						le.assessments[1].assessed_total_value != '' => le.assessments[1].assessed_total_value,
						le.assessments[1].sales_price != ''          => le.assessments[1].sales_price,
						le.assessments[1].mortgage_loan_amount != '' => le.assessments[1].mortgage_loan_amount,
						/* default..............................: */    ''
					); 
				SELF.sale_date          := le.assessments[1].sale_date;
				SELF.sale_price         := le.assessments[1].sales_price;
				SELF.name_seller        := le.parties(party_type = SELLER)[1].orig_names[1].orig_name;
				SELF.mortgage_amount    := le.assessments[1].mortgage_loan_amount;
				SELF.assess_value       := le.assessments[1].assessed_total_value;
				SELF.total_market_value := le.assessments[1].market_total_value;
				SELF.recording_date     := IF( TRIM(le.assessments[1].recording_date) != '', le.assessments[1].recording_date, le.assessments[1].prior_recording_date );	
			END;

		ds_assess_recs_slim := PROJECT(ds_assess_recs_topn, xfm_slim_assess_rec(LEFT));

		// --------------------[ PROCESS DEEDS RECORDS ]--------------------

		// 5. As above with Assessments, the goal here is to arrive at two of the most recent 
		// deed records for each property--one record of vendor_source_flag 'A' (FARES), and 
		// the other record of vendor_source_flag 'B' (FIDELITY).
		
		ds_deed_recs := ds_property_recs_filt_on_primrange(fid_type = DEED);

		// 5.a. Those Deed records having no Seller are usually refinance transactions. Throw 
		// them out.
		ds_deed_recs_having_seller := ds_deed_recs(EXISTS(parties(party_type = SELLER)));

		// 5.b. Sort and group on unique property id and vendor_sorce_flag ('A' or 'B'); then 
		// topn(1) to obtain the most recent record for each vendor_source_flag.
		ds_deed_recs_grpd := 
			GROUP(
				SORT( 
					ds_deed_recs_having_seller, /* by */
					acctno, 
					unique_prop_id,
					vendor_source_flag, 
					-(UNSIGNED)sortby_date
				), 
				acctno, unique_prop_id, vendor_source_flag
			);

		ds_deed_recs_topn := 
				TOPN( ds_deed_recs_grpd, 1, acctno, unique_prop_id, vendor_source_flag );
				
		// 5.c. Slim the Deed records.	
		rec_property_slim xfm_slim_deed_rec(layout_property_plus_id le) :=
			TRANSFORM
					is_owner := fn_determine_property_ownership( le, ds_batch_in(acctno = le.acctno)[1] );
					max_total_market_value := 
						MAX( 
							(UNSIGNED)le.assessments[1].market_total_value, 
							(UNSIGNED)le.assessments[1].fares_calculated_total_value 
						);
				SELF.acctno             := le.acctno;
				SELF.apn                := le.deeds[1].apnt_or_pin_number;
				SELF.unique_prop_id     := le.unique_prop_id;
				SELF.rec_type           := le.fid_type;
				SELF.sortby_date        := le.sortby_date;
				SELF.vendor_source_flag := le.vendor_source_flag;
				SELF.prop_owner         := IF( is_owner, THE_OWNER, '' );
				SELF.prop_sold          := IF( NOT is_owner, THE_SELLER, '' );
				SELF.property_address   := fn_DisplayPropAddr(le.parties(party_type = PROPERTY));
				SELF.property_city      := le.parties(party_type = PROPERTY)[1].p_city_name;
				SELF.property_state     := le.parties(party_type = PROPERTY)[1].st;
				SELF.property_zip       := le.parties(party_type = PROPERTY)[1].zip;
				SELF.total_value := 
					MAP(
						max_total_market_value > 0                   => (STRING)max_total_market_value,
						le.assessments[1].assessed_total_value != '' => le.assessments[1].assessed_total_value,
						le.deeds[1].sales_price != ''                => le.deeds[1].sales_price,
						le.deeds[1].first_td_loan_amount != ''       => le.deeds[1].first_td_loan_amount,
						/* default..............................: */    ''
					); 

				SELF.sale_date          := le.deeds[1].contract_date;
				SELF.sale_price         := le.deeds[1].sales_price;
				SELF.name_seller        := le.parties(party_type = SELLER)[1].orig_names[1].orig_name;
				SELF.mortgage_amount    := le.deeds[1].first_td_loan_amount;
				SELF.assess_value       := ''; // assessment data only
				SELF.total_market_value := ''; // assessment data only
				SELF.recording_date     := le.deeds[1].recording_date;	
			END;

		ds_deed_recs_slim := PROJECT(ds_deed_recs_topn, xfm_slim_deed_rec(LEFT));

		// 6. Take the Assessment and Deed records and determine the most recent among those
		// of types 'A' and 'B'. We must use data from both the Assessment and the Deed to 
		// complete the final record layout.
		
		// 6.a. Union the Assessment and Deed records; sort, group, and topn(1) by unique_prop_id 
		// to find the most recent record, whether it be an assessment or a deed, having type 'A' 
		// or type 'B'. ***We will favor type 'A' records slightly***, since they are preferred 
		// over type 'B' records: we are sorting on the year of the sortby_date and then by Fares
		// record. So, even if a Fidelity ('B') record occurs earlier in the same year as a Fares 
		// ('A') record, this sort will still rank the Fares record higher.
		ds_property_recs_slim := 
			SORT(
				( UNGROUP(ds_assess_recs_slim) + UNGROUP(ds_deed_recs_slim) ),
				acctno, 
				unique_prop_id,
				-(UNSIGNED)(sortby_date[1..4]), 
				-(UNSIGNED)(vendor_source_flag = FARES)
			);

		ds_property_recs_slim_grpd := GROUP(ds_property_recs_slim, acctno, unique_prop_id );
		
		ds_property_recs_grpd_most_recent := 
			TOPN( ds_property_recs_slim_grpd, 1, acctno, unique_prop_id );

		// 6.b. Now use a join to obtain both the assessment and deed records having the same acctno 
		// and vendor_source_type. What we want is the pair of property records (assessment and deed) 
		// that is most recent. 
		ds_property_recs_best_vendor_source := 
			JOIN(
				ds_property_recs_slim,
				UNGROUP(ds_property_recs_grpd_most_recent),
				LEFT.acctno = RIGHT.acctno AND
				LEFT.unique_prop_id = RIGHT.unique_prop_id AND
				LEFT.vendor_source_flag = RIGHT.vendor_source_flag,
				TRANSFORM(LEFT),
				INNER, KEEP(1)
			);

		// 6.c. Regroup for the group-rollup that follows, which constructs the normalized, final
		// property section layout. Note that each group shall consist of 1 assessment record 
		// and/or 1 deed record. Note that we will almost always have an assessment record and 
		// usually a deed record. But it's not unusual to have no deed record at all.
		ds_property_recs_regrpd := 
			GROUP( SORT( ds_property_recs_best_vendor_source, acctno, unique_prop_id ), acctno, unique_prop_id );

		rec_property_slim xfm_rollup_property_recs_slim(rec_property_slim le, DATASET(rec_property_slim) allRows) :=
			TRANSFORM
					// Attributes local to this transform:
					a := allRows(rec_type = ASSESSMENT)[1];
					d := allRows(rec_type = DEED)[1];
					use_assessment_data := (UNSIGNED)a.sortby_date >= (UNSIGNED)d.sortby_date;
					
				SELF.acctno             := IF( use_assessment_data, a.acctno            , d.acctno );
				SELF.apn                := IF( use_assessment_data, a.apn               , d.apn );
				SELF.unique_prop_id     := IF( use_assessment_data, a.unique_prop_id    , d.unique_prop_id );
				SELF.sortby_date        := IF( use_assessment_data, a.sortby_date       , d.sortby_date );
				SELF.prop_owner         := IF( use_assessment_data, a.prop_owner        , d.prop_owner );
				SELF.prop_sold          := IF( use_assessment_data, a.prop_sold         , d.prop_sold );
				SELF.property_address   := IF( use_assessment_data, a.property_address  , d.property_address );
				SELF.property_city      := IF( use_assessment_data, a.property_city     , d.property_city );
				SELF.property_state     := IF( use_assessment_data, a.property_state    , d.property_state );
				SELF.property_zip       := IF( use_assessment_data, a.property_zip      , d.property_zip );
				SELF.total_value        := IF( use_assessment_data, a.total_value       , d.total_value );
				SELF.sale_date          := IF( use_assessment_data, a.sale_date         , d.sale_date );
				SELF.sale_price         := IF( use_assessment_data, a.sale_price        , d.sale_price );
				SELF.name_seller        := IF( use_assessment_data, a.name_seller       , d.name_seller );
				SELF.mortgage_amount    := IF( use_assessment_data, a.mortgage_amount   , d.mortgage_amount );
				SELF.assess_value       := IF( use_assessment_data, a.assess_value      , '' );
				SELF.total_market_value := IF( use_assessment_data, a.total_market_value, '' );
				SELF.recording_date     := IF( use_assessment_data, a.recording_date    , d.recording_date );
				SELF := [];
			END;
				
		ds_property_recs_pre_unfiltered :=
			ROLLUP( ds_property_recs_regrpd, GROUP, xfm_rollup_property_recs_slim(LEFT,ROWS(LEFT)) );
		
		// 7. Filter property records based on threshold values supplied by the customer. This
		// will affect the total number of properties counted and the total value of properties
		// owned in the transform below, but Product Management affirms this is the rule to follow.
		ds_property_recs_pre := 
				ds_property_recs_pre_unfiltered(
					(UNSIGNED)total_value >= prop_val_threshold
						AND
					(UNSIGNED)sortby_date[1..4] >= prop_yr_threshold
				);				
				
		// 8. For the output, we want to return the three records having the most value. But, we must
		// provide both a total value and a total count of the properties the subject currently owns
		// and which meet the threshold criteria above.
		ds_property_recs_pre_regrpd := 
				GROUP( SORT( UNGROUP(ds_property_recs_pre), acctno, -(UNSIGNED)total_value ), acctno );
		
		// 9. Denormalize the property records into the final, concatenated layout using a group-rollup.
		Layouts.rec_property 
				xfm_rollup_properties(rec_property_slim le, DATASET(rec_property_slim) allRows) :=
					TRANSFORM
						SELF.acctno               := le.acctno;
							// Total Property Value of ALL property(ies) the input subject currently owns
						SELF.property_value       := (STRING)(SUM( allRows,(UNSIGNED)(allRows.total_value) )); 
							// Total number of properties the Input subject currently owns 
						SELF.property_owned       := (STRING)(COUNT( allRows(prop_owner = THE_OWNER) ));       
							// -----[ Property 1 ]-----
						SELF.prop_owner_1         := allRows[1].prop_owner;
						SELF.prop_sold_1          := allRows[1].prop_sold;
						SELF.property_address_1   := allRows[1].property_address;
						SELF.property_city_1      := allRows[1].property_city;
						SELF.property_state_1     := allRows[1].property_state;
						SELF.property_zip_1       := allRows[1].property_zip;
						SELF.total_value_1        := allRows[1].total_value;
						SELF.sale_date_1          := allRows[1].sale_date;
						SELF.sale_price_1         := allRows[1].sale_price;
						SELF.name_seller_1        := allRows[1].name_seller;
						SELF.mortgage_amount_1    := allRows[1].mortgage_amount;
						SELF.assess_value_1       := allRows[1].assess_value;
						SELF.total_market_value_1 := allRows[1].total_market_value;
						SELF.recording_date_1     := allRows[1].recording_date;
						// -----[ Property 2 ]-----
						SELF.prop_owner_2         := allRows[2].prop_owner;
						SELF.prop_sold_2          := allRows[2].prop_sold;
						SELF.property_address_2   := allRows[2].property_address;
						SELF.property_city_2      := allRows[2].property_city;
						SELF.property_state_2     := allRows[2].property_state;
						SELF.property_zip_2       := allRows[2].property_zip;
						SELF.total_value_2        := allRows[2].total_value;
						SELF.sale_date_2          := allRows[2].sale_date;
						SELF.sale_price_2         := allRows[2].sale_price;
						SELF.name_seller_2        := allRows[2].name_seller;
						SELF.mortgage_amount_2    := allRows[2].mortgage_amount;
						SELF.assess_value_2       := allRows[2].assess_value;
						SELF.total_market_value_2 := allRows[2].total_market_value;
						SELF.recording_date_2     := allRows[2].recording_date;
						// -----[ Property 3 ]-----
						SELF.prop_owner_3         := allRows[3].prop_owner;
						SELF.prop_sold_3          := allRows[3].prop_sold;
						SELF.property_address_3   := allRows[3].property_address;
						SELF.property_city_3      := allRows[3].property_city;
						SELF.property_state_3     := allRows[3].property_state;
						SELF.property_zip_3       := allRows[3].property_zip;
						SELF.total_value_3        := allRows[3].total_value;
						SELF.sale_date_3          := allRows[3].sale_date;
						SELF.sale_price_3         := allRows[3].sale_price;
						SELF.name_seller_3        := allRows[3].name_seller;
						SELF.mortgage_amount_3    := allRows[3].mortgage_amount;
						SELF.assess_value_3       := allRows[3].assess_value;
						SELF.total_market_value_3 := allRows[3].total_market_value;
						SELF.recording_date_3     := allRows[3].recording_date;
					END;

		ds_property_recs :=
			ROLLUP( ds_property_recs_pre_regrpd, GROUP, xfm_rollup_properties(LEFT,ROWS(LEFT)) );

		// 10. Finally: fill in prop_owner_addr_1 and prop_owner_addr_2 in the Best Address 
		// section (see Req. 4.1.16.8).
		ds_best_addr_prop_owner_addr_1_filled_in :=
			JOIN(
				ds_batch_out_with_best_address,
				ds_property_recs_pre_unfiltered,
				LEFT.acctno = RIGHT.acctno AND
				LEFT.best_address_1 = RIGHT.property_address AND
				LEFT.best_zip_1 = RIGHT.property_zip,
				TRANSFORM( Layouts.batch_out,
					SELF.prop_owner_addr_1 := 
						IF(
							LEFT.acctno = RIGHT.acctno AND
							LEFT.best_address_1 = RIGHT.property_address AND
							LEFT.best_zip_1 = RIGHT.property_zip, 
							'Y',
							''
						),
					SELF := LEFT,
					SELF := []
				),
				LEFT OUTER, 
				KEEP(1)
			);

		ds_best_addr_prop_owner_addr_2_filled_in :=
			JOIN(
				ds_best_addr_prop_owner_addr_1_filled_in,
				ds_property_recs_pre_unfiltered,
				LEFT.acctno = RIGHT.acctno AND
				LEFT.best_address_2 = RIGHT.property_address AND
				LEFT.best_zip_2 = RIGHT.property_zip,
				TRANSFORM( Layouts.batch_out,
					SELF.prop_owner_addr_2 := 
						IF(
							LEFT.acctno = RIGHT.acctno AND
							LEFT.best_address_2 = RIGHT.property_address AND
							LEFT.best_zip_2 = RIGHT.property_zip, 
							'Y',
							''
						),
					SELF := LEFT,
					SELF := []
				),
				LEFT OUTER, 
				KEEP(1)
			);		
			
		// 11. Append Property records to final layout. Set property_flag. Return.
		ds_batch_out_with_property_data := 
			JOIN(
				ds_best_addr_prop_owner_addr_2_filled_in, ds_property_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( Layouts.batch_out, 
					SELF.acctno := LEFT.acctno, 
					SELF.property_flag := 
							IF( 
								RIGHT.prop_owner_1 = '0' OR RIGHT.prop_owner_2 = '0' OR RIGHT.prop_owner_3 = '0' OR
								RIGHT.prop_sold_1 = 'S' OR RIGHT.prop_sold_2 = 'S' OR RIGHT.prop_sold_3 = 'S', 
								'Y', 
								'' 
							),
					SELF := RIGHT, 
					SELF := LEFT, 
					SELF := [] 
				),
				LEFT OUTER,
				KEEP(1)
			);
				
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_property_recs_raw, NAMED('Property_results') ) );
		
		IF( in_mod.ViewDebugs, 
				OUTPUT( ds_property_recs_pre_unfiltered, NAMED('ds_property_recs_pre') ) );
		
		RETURN ds_batch_out_with_property_data;

	END;
