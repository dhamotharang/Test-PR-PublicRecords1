import doxie, doxie_crs, suppress;

export header_presentation(DATASET(doxie.layout_presentation) presRecs, doxie.IDataAccess mod_access) := FUNCTION

doxie.MAC_Header_Field_Declare(); //ssn_value, score_threshold_value only!!

boolean include_hri := false : stored('IncludeHRI');
unsigned1 maxHriPer_value := 10 : stored('MaxHriPer');

boolean negate_true_defaults := false : STORED('ECL_NegateTrueDefaults'); // internal ECL use only
boolean return_waf := true : STORED('ReturnAlsoFound');
boolean include_wealsofound := return_waf AND ~negate_true_defaults;
boolean includeBankruptcyCount := false : stored('IncludeBankruptcyCount');

without_risk := doxie.base_presentation(presRecs);
rolled := doxie.header_base_rollup(without_risk, mod_access);

doxie.mac_AddHRISSN(rolled, with_ssn_risk, ~include_hri)
doxie.mac_AddHRIAddress(with_ssn_risk, with_addr_risk)
doxie.mac_AddHRIPhone(with_addr_risk, with_phone_risk, mod_access)

// Here HRIs are calculated for EDA phone (HeaderFileSearch doesn't use P+ to begin with),
// thus, there's no need to verify HRIs for P+ as in rollup service
ta1 := IF(include_hri, with_phone_risk, with_ssn_risk);

high_valid_ssn := 100; // default high value; lowest is best
srchedSSNMatch(string9 ssn) := (ssn_value<> '') and (ssn_value = ssn);

srtdSorted := sort(ta1,includedByHHID,penalt,if(srchedSSNMatch(ta1.ssn), valid_ssn_score(ta1.valid_ssn),high_valid_ssn), tnt_score(tnt),
              -MAX(first_seen,last_seen),phone<>listed_phone,lname,fname,mname,prim_range,did,phone,rid);

strdSortedCnsmr := sort(ta1,includedByHHID,penalt,if(srchedSSNMatch(ta1.ssn), valid_ssn_score(ta1.valid_ssn),high_valid_ssn), tnt_score(tnt),
              -last_seen, -dt_vendor_last_reported,phone<>listed_phone,lname,fname,mname,prim_range,did,phone,rid);

// if consumer switch the dates with the vendor dates after sorting.
srtdCnsmr := project(strdSortedCnsmr, TRANSFORM(RECORDOF(srtdSorted),
              self.first_seen := left.dt_vendor_first_reported,
              self.last_seen := left.dt_vendor_last_reported,
              self.dt_vendor_last_reported := left.last_seen,
              self.dt_vendor_first_reported := left.first_seen;
              self := left));

srtd2 := if (mod_access.isConsumer(), srtdCnsmr, srtdSorted);

doxie.MAC_Add_WeAlsoFound(srtd2, srtd2_waf, mod_access);
srtd3 := IF(include_wealsofound, srtd2_waf, srtd2);
doxie.Mac_Bk_Count(srtd3, srtd4, did, bk_count, doxie_crs.str_typeDebtor);
srtd5 := IF(includeBankruptcyCount, srtd4, srtd3);

Suppress.MAC_Mask(srtd5, with_mask, ssn, null, true, false, , , , mod_access.ssn_mask);
RETURN with_mask;

END;
