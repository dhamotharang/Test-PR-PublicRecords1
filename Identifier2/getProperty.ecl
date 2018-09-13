import LN_PropertyV2_Services, iesp, doxie, riskwise, risk_indicators, ut, LN_PropertyV2, std;

export getProperty(dataset(identifier2.layout_Identifier2) indata, 
								boolean owned_any_property=false,
								boolean ever_owned_input_property=false,
								boolean currently_own_input_property=false,
								integer Ever_Owned_Input_Property_InPastNumberOfYears=0,
								boolean IncludePropDetails=false) := function

	kp := ln_propertyv2.key_prop_address_v4;
  key_did := LN_PropertyV2.key_Property_did(false);
  key_search := LN_PropertyV2.key_search_fid(false);

	iesp.transform_property.working_layout append_fid_by_did( indata le, key_did ri ) := TRANSFORM
		self.ln_fares_id := ri.ln_fares_id;
		self := le;
		self := [];
	END;
	iesp.transform_property.working_layout append_fid_by_addr( indata le, kp ri ) := TRANSFORM
		self.ln_fares_id := ri.ln_fares_id;
		self.ln_fares_ids := set( ri.fares, ln_fare_id );
		self := le;
		self := [];
	END;
	fids_byAddr_fares := join(indata, ln_propertyv2.key_prop_address_v4,
		left.prim_name != ''
			and left.z5 != ''
			and keyed(left.prim_range = right.prim_range)
			and keyed(left.prim_name = right.prim_name)
			and keyed(right.sec_range in ['',left.sec_range])
			and keyed(left.z5 = right.zip)
			and keyed(left.addr_suffix = right.suffix),
		append_fid_by_addr(LEFT,RIGHT), ATMOST(100)
	);
	fids_byAddr_nofares := join(indata, ln_propertyv2.key_prop_address_v4_no_fares,
		left.prim_name != ''
			and left.z5 != ''
			and keyed(left.prim_range = right.prim_range)
			and keyed(left.prim_name = right.prim_name)
			and keyed(right.sec_range in ['',left.sec_range])
			and keyed(left.z5 = right.zip)
			and keyed(left.addr_suffix = right.suffix),
		append_fid_by_addr(LEFT,RIGHT), ATMOST(100)
	);
	fids_byAddr := if( 'R' in LN_PropertyV2_Services.input.srcRestrict, fids_byAddr_nofares, fids_byAddr_fares );

	iesp.transform_property.working_layout norm_fares( fids_byAddr le, integer c ) := TRANSFORM
		self.ln_fares_id := le.ln_fares_ids[c];
		self := le;
	END;
	fids_byAddr_normed := normalize( fids_byAddr, count(left.ln_fares_ids), norm_fares(left,counter) );
	
	
	fids_byDid := join( indata, key_did,
		keyed(right.s_did in ID2Common.didset(left))
			and LN_PropertyV2_Services.input.lookupVal in ['',LN_PropertyV2.fn_fid_type(right.ln_fares_id)]
			and LN_PropertyV2_Services.input.partyType in ['',right.source_code[1]]
			and right.ln_fares_id[1] not in LN_PropertyV2_Services.input.srcRestrict, // fares restriction
		append_fid_by_did(left,right), ATMOST(100)
	);
	
	// per John Evanoff, if CurrentlyOwn and EverOwned are both turned off, we omit by-address search and only do by-DID
	with_fids_dupes := if( owned_any_property, fids_byDid )
		+ if( ever_owned_input_property or currently_own_input_property, fids_byAddr_normed )
	;
	with_fids := dedup( sort( with_fids_dupes, ln_fares_id ), ln_fares_id );

	mkRI( string code ) := dataset([iesp.ECL2ESP.setRiskIndicator(code,Identifier2.getRiskStatusDesc(code))],iesp.share.t_RiskIndicator);
	blankRI := dataset([],iesp.share.t_RiskIndicator);

	iesp.transform_property.working_layout address_filter( iesp.transform_property.working_layout le, key_search ri ) := TRANSFORM
		
		self.dt_last_seen := ri.dt_last_seen;
		self.dt_vendor_last_reported := ri.dt_vendor_last_reported;
		
		self.isAddressMatch :=
			le.prim_range=ri.prim_range
			and le.prim_name=ri.prim_name
			and (le.in_zipcode=ri.zip
				or le.z5=ri.zip
   				or (le.in_city=ri.p_city_name and le.in_state=ri.st)
				or (le.p_city_name=ri.p_city_name and le.st=ri.st)
				)
			and ut.NNEQ(le.sec_range,ri.sec_range)
		;

		fmatch( string onfile ) := id2common.isfirstmatch( le.fname, onfile );
		lmatch( string onfile ) := le.lname=onfile;

		isDIDMatch := ri.did!=0 and ri.did in [le.did,le.did2,le.did3];
		self.isDIDMatch := isDIDMatch;

		// ownership is determined by any of the following:
		// 1. input did matches did on file
		// 2. input first and last are found somewhere within [first,middle,last] on file. first can use preferred (JIM=JAMES), but both names must be exact matches (OLSON != OLSEN)
		// 3. input first and last are found somewhere within the company name (eg, 'ESTATE OF JOHN DOE')
		self.isOwner :=
			isDIDMatch
			or (
				    (fmatch(ri.fname) or fmatch(ri.mname) or fmatch(ri.lname))
				and (lmatch(ri.fname) or lmatch(ri.mname) or lmatch(ri.lname))
			)
			or ID2Common.EstateMatch( le.fname, le.lname, ri.cname )
		;

		// self.fares_did := if(self.isowner, ri.did, skip);
		self.fares_did := ri.did;
		
		self := le;
	END;
	addr_filtered := join( with_fids, key_search,
		left.ln_fares_id != ''
			and keyed(left.ln_fares_id=right.ln_fares_id)
			and right.source_code_2='P'
      and right.source_code_1 in ['O','B'], 
		address_filter(left,right),
		atmost(riskwise.max_atmost)
	);

	// DEED SECTION
	deeds := join( addr_filtered, LN_PropertyV2.key_deed_fid(false),
			keyed(left.ln_fares_id=right.ln_fares_id),
		iesp.transform_property.deed_assess.format_deed_all(left,right), atmost(riskwise.max_atmost) );

	iesp.transform_property.working_layout populateDeeds( iesp.transform_property.working_layout le ) := TRANSFORM
		isLeCurrentOwner := le.isAddressMatch and le.isOwner;
		ownedAny       := le.isDIDMatch;
		everOwned      := le.isAddressMatch and le.isOwner
			and (
				Ever_Owned_Input_Property_InPastNumberOfYears = 0
				or ut.Age( MAP(
					le.dt_vendor_last_reported < iesp.constants.identifier2c.yearOnly      => le.dt_vendor_last_reported * 10000,
					le.dt_vendor_last_reported < iesp.constants.identifier2c.yearMonthOnly => le.dt_vendor_last_reported * 100,
					le.dt_vendor_last_reported),
					Std.Date.Today()) < Ever_Owned_Input_Property_InPastNumberOfYears
				)
		;

		self.EverOwnedInputProperty.deed    := if( ever_owned_input_property and everOwned, le.deed );
		self.CurrentlyOwnInputProperty.deed := if( currently_own_input_property and le.isAddressMatch, le.deed ); // keep all deeds regardless of who is the owner, but they must be for the input property
		self.isCurrentDeedOwner             := currently_own_input_property and le.isOwner and le.isAddressMatch;

		self.OwnedAnyProperty.UniqueDeedsCount := if( owned_any_property and ownedAny, 1, 0 );
		self.OwnedAnyProperty.deed             := if( owned_any_property and ownedAny, le.deed );
		
		self := le;
	END;
	deeds_populated := project( deeds, populateDeeds(left) );

	boolean takeLeft( string le_lnfares, string ri_lnfares, unsigned3 le_datelast, unsigned3 ri_datelast ) :=
		(le_lnfares != '' and ri_lnfares  = '')                                   // take the left if it's the only one populated
		or (le_lnfares != '' and ri_lnfares != '' and le_datelast >= ri_datelast) // or if both are ppoulated, take left if it's newer
                                                                              // else if neither are populated or only the right is, then take the right
	;

	iesp.transform_property.working_layout deedRoll( iesp.transform_property.working_layout le, iesp.transform_property.working_layout ri ) := TRANSFORM
		// for current ownership, pick the newer over older
 		curr_takeLeft := takeleft( le.CurrentlyOwnInputProperty.deed.SourcePropertyRecordId, ri.CurrentlyOwnInputProperty.deed.SourcePropertyRecordId, le.dt_last_seen, ri.dt_last_seen ) /*or le.isOwner and not ri.isOwner*/; 
		self.isCurrentDeedOwner := if( curr_takeLeft, le.isCurrentDeedOwner, ri.isCurrentDeedOwner );
		self.CurrentlyOwnInputProperty := if( curr_takeLeft, le.CurrentlyOwnInputProperty, ri.CurrentlyOwnInputProperty );
		self.dt_last_seen := if( curr_takeLeft, le.dt_last_seen, ri.dt_last_seen );
		self.isAddressMatch := if( curr_takeLeft, le.isAddressMatch, ri.isAddressMatch );
		self.isDIDMatch := if( curr_takeLeft, le.isDIDMatch, ri.isDIDMatch );
		self.isOwner := if( curr_takeLeft, le.isOwner, ri.isOwner );
		
		// newer record over older
 		ever_takeLeft := takeleft( le.EverOwnedInputProperty.deed.SourcePropertyRecordId, ri.EverOwnedInputProperty.deed.SourcePropertyRecordId, le.dt_last_seen, ri.dt_last_seen ) or le.isOwner and not ri.isOwner;
		self.EverOwnedInputProperty := if( ever_takeleft, le.EverOwnedInputProperty, ri.EverOwnedInputProperty );
		
		propMatch :=
			le.z5=ri.deed.PropertyAddress.zip5
			and le.prim_name=ri.deed.PropertyAddress.streetname
			and le.prim_range=ri.deed.PropertyAddress.streetnumber
			and le.sec_range=ri.deed.PropertyAddress.unitnumber;
		self.OwnedAnyProperty.UniqueDeedsCount := le.OwnedAnyProperty.UniqueDeedsCount + if( propMatch, 0, ri.OwnedAnyProperty.UniqueDeedsCount );

		// newer over older
		any_takeLeft := takeleft( le.OwnedAnyProperty.deed.SourcePropertyRecordId, ri.OwnedAnyProperty.deed.SourcePropertyRecordId, le.dt_last_seen, ri.dt_last_seen ) or le.isOwner and not ri.isOwner;
   		self.OwnedAnyProperty   := if( any_takeLeft, le.OwnedAnyProperty, ri.OwnedAnyProperty );

		self := le;
	END;
	deeds_sorted := sort( deeds_populated, deed.PropertyAddress.zip5, deed.PropertyAddress.StreetName, deed.PropertyAddress.StreetNumber, deed.PropertyAddress.UnitNumber, -dt_last_seen, -isOwner);
	deeds_rolled := rollup( deeds_sorted, true, deedRoll(left,right) );


	// ASSESSOR SECTION
	assessors := join( addr_filtered, LN_PropertyV2.key_assessor_fid(false),
			keyed(left.ln_fares_id=right.ln_fares_id),
      iesp.transform_property.deed_assess.format_assess_all(left,right), atmost(riskwise.max_atmost) );

	iesp.transform_property.working_layout populateAssessors( iesp.transform_property.working_layout le ) := TRANSFORM
		ownedAny       := owned_any_property and le.isDIDMatch; // only poulate the OwnedAnyProperty if it's requested
		everOwned      := le.isAddressMatch and le.isOwner
			and (
				Ever_Owned_Input_Property_InPastNumberOfYears = 0
				or ut.Age( MAP(
					le.dt_vendor_last_reported < iesp.constants.identifier2c.yearOnly      => le.dt_vendor_last_reported * 10000,
					le.dt_vendor_last_reported < iesp.constants.identifier2c.yearMonthOnly => le.dt_vendor_last_reported * 100,
					le.dt_vendor_last_reported),
					(integer)Std.Date.Today()) < Ever_Owned_Input_Property_InPastNumberOfYears
				)
		;
		
		self.EverOwnedInputProperty.Assessment        := if( ever_owned_input_property and everOwned, le.assess );
		self.CurrentlyOwnInputProperty.Assessment     := if( currently_own_input_property and le.isAddressMatch, le.assess ); // copy all assessments forward, but they must be the input property
		self.isCurrentAssessorOwner                   := currently_own_input_property and le.isOwner and le.isAddressMatch;
		
		self.OwnedAnyProperty.UniquePropertiesCount   := if( owned_any_property and ownedAny, 1, 0 );
		self.OwnedAnyProperty.Assessment              := if( owned_any_property and ownedAny, le.assess );

		self := le;
	END;
	assessors_populated := project( assessors, populateAssessors(left) );


	iesp.transform_property.working_layout assessorRoll( iesp.transform_property.working_layout le, iesp.transform_property.working_layout ri ) := TRANSFORM		
		// for current ownership, pick the newer over older
		propMatch := 
			le.z5=ri.assess.PropertyAddress.zip5
			and le.prim_name=ri.assess.PropertyAddress.streetname
			and le.prim_range=ri.assess.PropertyAddress.streetnumber
			and le.sec_range=ri.assess.PropertyAddress.unitnumber;

		

		curr_takeLeft := takeleft( le.CurrentlyOwnInputProperty.assessment.SourcePropertyRecordId, ri.CurrentlyOwnInputProperty.assessment.SourcePropertyRecordId, le.dt_last_seen, ri.dt_last_seen ) /*or le.isOwner and not ri.isOwner*/; 
		self.CurrentlyOwnInputProperty := if( curr_takeLeft, le.CurrentlyOwnInputProperty, ri.CurrentlyOwnInputProperty );
		self.isCurrentAssessorOwner := if( curr_takeLeft, le.isCurrentAssessorOwner, ri.isCurrentAssessorOwner );
		self.dt_last_seen := if( curr_takeLeft, le.dt_last_seen, ri.dt_last_seen );
		self.isAddressMatch := if( curr_takeLeft, le.isAddressMatch, ri.isAddressMatch );
		self.isDIDMatch := if( curr_takeLeft, le.isDIDMatch, ri.isDIDMatch );
		self.isOwner := if( curr_takeLeft, le.isOwner, ri.isOwner );
		
		ever_takeLeft := takeleft( le.EverOwnedInputProperty.assessment.SourcePropertyRecordId, ri.EverOwnedInputProperty.assessment.SourcePropertyRecordId, le.dt_last_seen, ri.dt_last_seen ) or le.isOwner and not ri.isOwner;
		self.EverOwnedInputProperty := if( ever_takeLeft, le.EverOwnedInputProperty, ri.EverOwnedInputProperty );
		
		// for any property, pick something not currently owned
		any_takeLeft := takeleft( le.OwnedAnyProperty.assessment.SourcePropertyRecordId, ri.OwnedAnyProperty.assessment.SourcePropertyRecordId, le.dt_last_seen, ri.dt_last_seen ) or le.isOwner and not ri.isOwner;
		self.OwnedAnyProperty.UniquePropertiesCount := le.OwnedAnyProperty.UniquePropertiesCount + if( propMatch, 0, ri.OwnedAnyProperty.UniquePropertiesCount );
		self.OwnedAnyProperty       := if( any_takeLeft, le.OwnedAnyProperty, ri.OwnedAnyProperty );

		self := le;
	END;
  
	assessors_sorted := sort( assessors_populated, assess.PropertyAddress.zip5, assess.PropertyAddress.streetname, assess.PropertyAddress.streetnumber, assess.PropertyAddress.unitnumber, -dt_last_seen, -isOwner);
	assessors_rolled := rollup( assessors_sorted, true, assessorRoll(left,right) );


	iesp.transform_property.working_layout combine_prop( iesp.transform_property.working_layout le, iesp.transform_property.working_layout ri ) := TRANSFORM
		ever_IsPropertyOwner  :=
			le.EverOwnedInputProperty.deed.PropertyAddress.zip5 != ''
			or le.EverOwnedInputProperty.deed.PropertyAddress.streetname != ''
			or le.EverOwnedInputProperty.deed.PropertyAddress.streetnumber != ''
			or le.EverOwnedInputProperty.deed.PropertyAddress.unitnumber != ''
			or ri.EverOwnedInputProperty.assessment.PropertyAddress.zip5 != ''
			or ri.EverOwnedInputProperty.assessment.PropertyAddress.streetname != ''
			or ri.EverOwnedInputProperty.assessment.PropertyAddress.streetnumber != ''
			or ri.EverOwnedInputProperty.assessment.PropertyAddress.unitnumber != ''
		;
		self.EverOwnedInputProperty.deed             := if( IncludePropDetails, le.EverOwnedInputProperty.deed );
		self.EverOwnedInputProperty.assessment       := if( IncludePropDetails, ri.EverOwnedInputProperty.assessment );
		self.EverOwnedInputProperty.IsPropertyOwner  := ever_IsPropertyOwner;
		self.EverOwnedInputProperty.RiskIndicators   := if( ever_owned_input_property and not ever_IsPropertyOwner, mkRI('EN'), blankRI );
		self.EverOwnedInputProperty.StatusIndicators := if( ever_owned_input_property and     ever_IsPropertyOwner, mkRI('EF'), blankRI );

		currentDeed       := le.isCurrentDeedOwner;
		currentAssessor   := ri.isCurrentAssessorOwner;
		deedDate     := le.dt_last_seen;
		assessorDate := ri.dt_last_seen;

		self.CurrentlyOwnInputProperty.deed             := if( IncludePropDetails, le.CurrentlyOwnInputProperty.deed );
		self.CurrentlyOwnInputProperty.assessment       := if( IncludePropDetails, ri.CurrentlyOwnInputProperty.assessment );
		curr_IsPropertyOwner  := currentDeed and currentAssessor                         // set as current owner if the individual is on the most recent deed and assessor record
			or (currentDeed     and (deedDate     >= assessorDate or ~ri.isAddressMatch))  // or is on the most recent deed and it is more recent than the assessor or there is no assessor for the prop 
			or (currentAssessor and (assessorDate >= deedDate or ~le.isAddressMatch))      // or is on the most recent assessor and it is more recent than the deed or there is no deed for the prop
		;
		self.CurrentlyOwnInputProperty.IsPropertyOwner  := curr_IsPropertyOwner;
		self.CurrentlyOwnInputProperty.RiskIndicators   := if( currently_own_input_property and not curr_IsPropertyOwner, mkRI('CN'), blankRI );
		self.CurrentlyOwnInputProperty.StatusIndicators := if( currently_own_input_property and     curr_IsPropertyOwner, mkRI('CF'), blankRI );

		any_IsPropertyOwner :=
			le.OwnedAnyProperty.deed.PropertyAddress.zip5 != ''
			or le.OwnedAnyProperty.deed.PropertyAddress.streetname != ''
			or le.OwnedAnyProperty.deed.PropertyAddress.streetnumber != ''
			or le.OwnedAnyProperty.deed.PropertyAddress.unitnumber != ''
			or ri.OwnedAnyProperty.assessment.PropertyAddress.zip5 != ''
			or ri.OwnedAnyProperty.assessment.PropertyAddress.streetname != ''
			or ri.OwnedAnyProperty.assessment.PropertyAddress.streetnumber != ''
			or ri.OwnedAnyProperty.assessment.PropertyAddress.unitnumber != ''
		;
		self.OwnedAnyProperty.IsPropertyOwner := any_IsPropertyOwner;
		self.OwnedAnyProperty.UniqueDeedsCount      := le.OwnedAnyProperty.UniqueDeedsCount;
		self.OwnedAnyProperty.UniquePropertiesCount := le.OwnedAnyProperty.UniquePropertiesCount;
		self.OwnedAnyProperty.RiskIndicators   := if( owned_any_property and not any_IsPropertyOwner, mkRI('AN'), blankRI );
		self.OwnedAnyProperty.StatusIndicators := if( owned_any_property and     any_IsPropertyOwner, mkRI('AF'), blankRI );
		self.OwnedAnyProperty.deed             := if( IncludePropDetails, le.OwnedAnyProperty.deed );
		self.OwnedAnyProperty.assessment       := if( IncludePropDetails, ri.OwnedAnyProperty.assessment );

		self := ri;
	END;

	// because joins are inner, deeds and assessors are not guaranteed to be populated. perform a check here to ensure we have records going into the final join
	deeds_pop := if( exists(deeds_rolled), deeds_rolled, project( indata, transform( iesp.transform_property.working_layout, self := left, self := [] ) ) );
	assessors_pop := if( exists(assessors_rolled), assessors_rolled, project( indata, transform( iesp.transform_property.working_layout, self := left, self := [] ) ) );

	combined := join( deeds_pop, assessors_pop, left.seq=right.seq, combine_prop(left,right) );

	slimmed := project( combined, identifier2.layout_Identifier2 );
 
  // output(owned_any_property, named('owned_any_property'));
  // output(ever_owned_input_property, named('ever_owned_input_property'));
  // output(currently_own_input_property, named('currently_own_input_property'));
  // output(Ever_Owned_Input_Property_InPastNumberOfYears, named('Ever_Owned_Input_Property_InPastNumberOfYears'));
  // output(fids_byAddr_fares, named('fids_byAddr_fares'));
  // output(fids_byAddr_nofares, named('fids_byAddr_nofares'));
  // output(fids_byAddr, named('fids_byAddr'));
  // output(fids_byAddr_normed, named('fids_byAddr_normed'));
  // output(fids_byDid, named('fids_byDid'));
  // output(with_fids_dupes, named('with_fids_dupes'));
  // output(with_fids, named('with_fids'));
  // output(addr_filtered, named('addr_filtered'));
  // output(deeds_sorted, named('deeds_sorted'));
  // output(deeds_rolled, named('deeds_rolled'));  
  // output(assessors_sorted, named('assessors_sorted'));
  // output(assessors_rolled, named('assessors_rolled'));
  
	return slimmed;
end;