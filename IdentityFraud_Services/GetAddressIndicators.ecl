IMPORT $, iesp, doxie, USPIS_HotList, Advo, header, ut, risk_indicators;

header_rec := IdentityFraud_Services.layouts.slim_header;

adv := $.Constants.RiskCodes.Address; //Volassis, aka ADVO

// ADVO HRI codes by residency type (maybe, not needed)
integer AdvoCodeByAddressType (string1 cd) := MAP (
  cd = 'A' => adv.ADVO_RESIDENTIAL,      //
  cd = 'B' => adv.ADVO_BUSINESS,         //
  cd = 'C' => adv.ADVO_RESIDENTIAL_PRIM, //primarily residential with a possible business
  cd = 'D' => adv.ADVO_BUSINESS_PRIM,    //primarily business with a possible residence
0);

// this maps delivery type and address type to ADVO HRI codes 
// (compare to Advo .Lookup_Descriptions.Delivery_Type_Description_lookup, which uses one field for the same)
integer GetAdvoCode (string1 addr_cd, string1 delivery_cd) := function
  boolean is_res := (addr_cd = 'A') or (addr_cd = 'C');
  boolean is_bus := (addr_cd = 'B') or (addr_cd = 'D');
  return MAP (
    delivery_cd = 'A' => adv.ADVO_CURB,
    delivery_cd = 'B' => adv.ADVO_NDCBU,    //NEIGHBORHOOD DELIVERY AND COLLECTION BOX UNITS
    delivery_cd = 'C' => adv.ADVO_CENTRAL,
    delivery_cd = 'D' => adv.ADVO_OTHER,
    delivery_cd = 'E' => adv.ADVO_FACILITY, //FACILITY BOX
    delivery_cd = 'F' => adv.ADVO_CONTRACT, //CONTRACT BOX
    delivery_cd = 'G' => adv.ADVO_DETACHED, //DETACHED BOX
    delivery_cd = 'H' => adv.ADVO_NPU,      //NON-PERSONAL UNIT

    delivery_cd = 'Q' => adv.ADVO_GENERAL, // General Delivery
    delivery_cd = 'S' => adv.ADVO_CALLER,     // Caller Service Box
    delivery_cd = 'T' => adv.ADVO_REMITTANCE, // Remittance Box
    delivery_cd = 'U' => adv.ADVO_CONTEST, // Contest Box
    //delivery_cd = 'V' => adv.ADVO_OTHER,   // Other Box // not used?
  0);
end;


EXPORT $.layouts.address_did_rec GetAddressIndicators (
  dataset (header_rec) header_ext,
	dataset (IdentityFraud_Services.layouts.id_fraud_attributes) fraud_indices,
  IdentityFraud_Services.IParam._identityfraudreport param
	) := FUNCTION

  // ... address needs to be rolled up; auxiliary layouts for slimmming and rollup
  src_rec := record 
    header_rec.src; 
    header_rec._type; 
  end;

  addr_slim_rec := record
    header_rec and not [rid, src, phone, fname, mname, lname, name_suffix, 
                        county, valid_ssn, hhid, count];
    dataset (src_rec) sources {maxcount ($.Constants.MAX_SAME_ADDRESS)}; 
  end;

  address_hri_rec := record (addr_slim_rec)
    dataset (risk_indicators.layout_desc) hri_address {maxcount($.Constants.MAX_HRI)} := dataset([], risk_indicators.layout_desc);
  end;  

  // addresses; using person-report style (already rolled up) could be better, 
  // but it'll be difficult to join back to header to get counts...

  // Latest revision: same address = same address_line_1 AND (same city&state OR same zip)
  // This can be easily changed later; the main point is that indicators are fetched AFTER roll up,
  // which indeed affects content

  
  // save source as a dataset
  addr_slim_rec SetSourceAsDataset (header_rec L) := transform
    Self.sources := dataset ([{L.src, L._type}], src_rec);
    Self := L;
  end;
  header_addr := project (header_ext (zip != '' or (city_name != '' and st != '')), SetSourceAsDataset (Left));
  did_grouped := group (sort (header_addr, did), did);


  // ----------------------------------------------------------------------
  // ------------------------ ADDRESS ROLLUP ------------------------------
  // ----------------------------------------------------------------------
  // equality of address line 1 (is copy from doxie/mac_address_rollup)
  MAC_LineOneIsTheSame := MACRO
    (left.prim_range=right.prim_range) and 
    (left.prim_name=right.prim_name or
      (left.zip4<>'' and right.zip4='') and  //only rollup a mismatched prim_name when one is better than the other 
      (ut.StringSimilar(left.prim_name,right.prim_name)<3 or length(trim(left.prim_range))>2)
    ) and 
    ut.nneq(left.predir, right.predir) and
    ut.Sec_Range_Eq(left.sec_range, right.sec_range)<10
  ENDMACRO;

  addr_slim_rec RollSameAddreses (addr_slim_rec L, addr_slim_rec R) := transform
    Self.sources := choosen (L.sources + R.sources, $.Constants.MAX_SAME_ADDRESS);
    // ... and the rest is about the same as in doxie/tra_address_rollup
    Self.dt_first_seen := if (R.dt_first_seen = 0 or (L.dt_first_seen < R.dt_first_seen  and L.dt_first_seen>0), L.dt_first_seen, R.dt_first_seen);
    self.dt_last_seen := if (L.dt_last_seen > R.dt_last_seen, L.dt_last_seen, R.dt_last_seen);
    self.sec_range := if (length(trim(L.sec_range)) > length(trim(R.sec_range)), L.sec_range, R.sec_range);
    Self.not_in_bureau := L.not_in_bureau | R.not_in_bureau; // keep all indicators combined
    Self := L;
  end;

  // by ZIP
  sort_by_zip := sort (did_grouped, zip, 
                                    prim_range,prim_name, -sec_range, -predir, suffix='', zip4='', -dt_last_seen);
  rolled_by_zip := rollup (sort_by_zip, 
                           (Left.zip = Right.zip) and 
                           MAC_LineOneIsTheSame(), RollSameAddreses (Left, Right));

  // By CITY+STATE
  sort_by_city := sort (rolled_by_zip, st, city_name, 
                                       prim_range,prim_name, -sec_range, -predir, suffix='', zip4='', -dt_last_seen);
  rolled_by_city := rollup (sort_by_city, 
                            (Left.st = Right.st) and (Left.city_name = Right.city_name) and 
                            MAC_LineOneIsTheSame(), RollSameAddreses (Left, Right));


  // ----------------------------------------------------------------------
  // --------------------- attach standard HRIs ---------------------------
  // ----------------------------------------------------------------------
  address_hri_rec ToHRIAddress (addr_slim_rec L) := transform
    // Self.sources := if (param.count_by_source, dedup (L.sources, src, all), dedup (L.sources, _type, all));
    Self := L;
  end;
  header_addresses := project (rolled_by_city, ToHRIAddress (Left));

  maxHriPer_value := param.max_hri;
  doxie.mac_AddHRIAddress(header_addresses, header_address_hri);
	
	// Add address fraud indicators
	address_hri_rec tAddrFraudInd(header_address_hri le,fraud_indices ri) :=
	transform
		ri_addr_fraud := if(ri.DivAddrSuspIdentityCountNew,row({$.Constants.RiskCodes.Address.MULTIPLE,'FRAUD_IND'},risk_indicators.layout_desc));
		
	  self.hri_address := le.hri_address + ri_addr_fraud;
		self             := le;
	end;
	
	addr_fraud_hri := join (header_address_hri,
													fraud_indices,
													left.did = right.did and
													((left.zip = right.zip5) or ((left.st = right.st) and (left.city_name = right.v_city_name))) and
													MAC_LineOneIsTheSame(),
													tAddrFraudInd(left,right),
													left outer,
													limit(0),keep(1));
	
	// Format to iesp layout and add NLR indicators
  layouts.address_did_rec SetAssociatedAddresses (address_hri_rec L) := transform
    Self.did := L.did;
    Self.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
                     L.suffix, L.unit_desig, L.sec_range, L.city_name,
                     L.st, L.zip, L.zip4, L.county_name);
    Self.Location := row ({'', ''}, iesp.share.t_GeoLocation);

    Self.DateFirstSeen := iesp.ecl2esp.toDateYM (L.dt_first_seen);
    Self.DateLastSeen := iesp.ecl2esp.toDateYM (L.dt_last_seen);

    // get source categories' counts:
    R := project (L.sources, transform (header_rec, Self := Left, Self := []));
    Self.Sources := choosen (Functions.GetSources (R), iesp.Constants.IFR.MaxSourcetypes);
    // overal count:
    Self.SourceCount := if (param.count_by_source, count (dedup (R, src, all)), count (dedup (R, _type, all)));

    // no longer reported indicators
    ISC := Header.constants.no_longer_reported;
    ICRN := IdentityFraud_Services.Constants.RiskCodes.NLR;
    indicators := L.not_in_bureau;
    ri_nlr := if (indicators & ISC.addr_not_in_en = ISC.addr_not_in_en, Functions.GetRiskIndicator (ICRN.ADDRESS_EN)) +
              if (indicators & ISC.addr_not_in_eq = ISC.addr_not_in_eq, Functions.GetRiskIndicator (ICRN.ADDRESS_EQ)) +
              if (indicators & ISC.addr_not_in_tn = ISC.addr_not_in_tn, Functions.GetRiskIndicator (ICRN.ADDRESS_TU));

    // take all RIs together
    _indicators_deduped := dedup (L.hri_address, hri, all); // can contain dupes, see #70450
		// OSS platform issue - bug 146931
    // _indicators := if(exists (L.hri_address), project (_indicators_deduped, Functions.TransformRiskIndicators (Left))) + ri_nlr;
    _indicators := if (count (L.hri_address) + nofold (1) > 1, project (_indicators_deduped, Functions.TransformRiskIndicators (Left))) + ri_nlr;

    Self.RiskIndicators := choosen (_indicators, iesp.Constants.IFR.MaxIndicators);
  end;
  ri_base := project (addr_fraud_hri, SetAssociatedAddresses (left));

  // (conditionally) attach USPIS indicators
  layouts.address_did_rec AppendUSPISIndicators (layouts.address_did_rec L, USPIS_HotList.key_addr_search_zip R) := transform
    boolean is_matched := (R.zip != '');
    string _text := if (is_matched, if (R.comments != '', R.comments, $.Constants.USPIS_INDICATOR_TEXT), '');
    string formatted_date :=  R.dt_last_reported[5..6] + '/' + R.dt_last_reported[7..8] + '/' +R.dt_last_reported[1..4] ;
    string _date := if (R.dt_last_reported != '', ' reported on ' + formatted_date, '');
    uspis_ri := Functions.GetRiskIndicator ($.Constants.RiskCodes.Address.USPIS, _text + _date);
    Self.RiskIndicators := choosen (L.RiskIndicators + if (is_matched, uspis_ri), iesp.Constants.IFR.MaxIndicators);
    Self := L;
  end;
  ri_uspis := JOIN (ri_base, USPIS_HotList.key_addr_search_zip,
                    keyed (Left.Address.Zip5 = Right.zip) and 
                    keyed (Left.Address.StreetNumber = Right.prim_range) and  
                    keyed (Left.Address.StreetName = Right.prim_name) and  
                    keyed (Left.Address.StreetSuffix = Right.addr_suffix) and  
                    keyed (Left.Address.StreetPredirection = Right.predir) and  
                    keyed (Left.Address.StreetPostDirection = Right.postdir) and  
                    keyed (Left.Address.UnitNumber = Right.sec_range),
                    AppendUSPISIndicators (Left, Right),
                    // TODO: verify it is 1 : 1
                    keep (1), limit (0), LEFT OUTER);

  ri_base_uspis := if (param.include_ri_uspis, ri_uspis, ri_base);

  // (conditionally) attach ADVO indicators
  layouts.address_did_rec AppendADVOIndicators (layouts.address_did_rec L, Advo.Key_Addr1 R) := transform
    integer vac := if (L.Address.StreetName[1..6] = 'PO BOX', adv.ADVO_VACANT_PO, adv.ADVO_VACANT);
    ri_advo := if (R.address_vacancy_indicator   = 'Y', Functions.GetRiskIndicator (vac)) +
               if (R.seasonal_delivery_indicator = 'Y', Functions.GetRiskIndicator (adv.ADVO_SEASONAL)) +
               if (R.owgm_indicator = 'Y',              Functions.GetRiskIndicator (adv.ADVO_POBOX)) +
               if (R.drop_indicator = 'C',              Functions.GetRiskIndicator (adv.ADVO_CMRA)) +
               if (R.drop_indicator = 'Y',              Functions.GetRiskIndicator (adv.ADVO_IDA)) +
               if (R.residential_or_business_ind != '', Functions.GetRiskIndicator (AdvoCodeByAddressType (R.residential_or_business_ind))) +
               if (R.mixed_address_usage != '',         Functions.GetRiskIndicator (GetAdvoCode (R.residential_or_business_ind, R.mixed_address_usage)));               // TODO: ADVO has college as well
               // TODO: ADVO has college as well

    Self.RiskIndicators := choosen (L.RiskIndicators + if (R.zip != '' and exists (ri_advo), ri_advo),
                                    iesp.Constants.IFR.MaxIndicators);
    Self := L;
  end;

  // Must be exact match on all parts -- including sec range being blank.
  ri_advo := JOIN (ri_base_uspis, Advo.Key_Addr1,
                   keyed (Left.Address.Zip5 = Right.zip) and
                   keyed (Left.Address.StreetNumber = Right.prim_range) and
                   keyed (Left.Address.StreetName = Right.prim_name) and
                   keyed (Left.Address.StreetSuffix = Right.addr_suffix) and
                   keyed (Left.Address.StreetPredirection = Right.predir) and
                   keyed (Left.Address.StreetPostDirection = Right.postdir) and
                   keyed (Left.Address.UnitNumber = Right.sec_range),
                   AppendADVOIndicators (Left, Right),
                   // TODO: verify it is 1 : 1
                   keep (1), limit (0), LEFT OUTER);

  addresses := if (param.include_ri_advo, ri_advo, ri_base_uspis);

  return addresses;
END;
