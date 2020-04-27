import address, liensv2, ut, risk_indicators;

Layout_Liens_Info := RECORD
	unsigned1 count;
	unsigned4 earliest_filing_date;
	unsigned4 most_recent_filing_date;
	unsigned total_amount;
END;

layout_liens_party := RECORD
// string50 tmsid;
// string50 rmsid;
// string orig_full_debtorname := '';
// string orig_name := '';
// string30 orig_lname := '';
// string30 orig_fname := '';
// string orig_mname := '';
// string orig_suffix := '';
// string9 tax_id := '';
// string9 ssn := '';
// string cname := '';
// string orig_address1 := '';
// string orig_address2 := '';
// string orig_city := '';
// string orig_state := '';
// string orig_zip5 := '';
// string orig_zip4 := '';
// string orig_county := '';
// string orig_country :='';
address.Layout_Clean182;
string12 geo_link;
// string phone := '';
// string name_type := '';
// string12 DID  := '';
// string12 BDID := '';
// string8  date_first_seen := '';
// string8  date_last_seen := '';
// string8  date_vendor_first_reported := '';
// string8  date_vendor_last_reported := '';
end;
slimmerrec := RECORD
	layout_liens_party;
	unsigned6	did;

	UNSIGNED1 liens_recent_unreleased_count := 0;
	UNSIGNED1 liens_historical_unreleased_count := 0;
	UNSIGNED1 liens_unreleased_count30 := 0;
	UNSIGNED1 liens_unreleased_count90 := 0;
	UNSIGNED1 liens_unreleased_count180 := 0;
	UNSIGNED1 liens_unreleased_count12 := 0;
	UNSIGNED1 liens_unreleased_count24 := 0;
	UNSIGNED1 liens_unreleased_count36 := 0;
	UNSIGNED1 liens_unreleased_count60 := 0;
	string8 last_liens_unreleased_date := '';

	UNSIGNED1 liens_recent_released_count := 0;
	UNSIGNED1 liens_historical_released_count := 0;
	UNSIGNED1 liens_released_count30 := 0;
	UNSIGNED1 liens_released_count90 := 0;
	UNSIGNED1 liens_released_count180 := 0;
	UNSIGNED1 liens_released_count12 := 0;
	UNSIGNED1 liens_released_count24 := 0;
	UNSIGNED1 liens_released_count36 := 0;
	UNSIGNED1 liens_released_count60 := 0;
	UNSIGNED4 last_liens_released_date := 0;

	UNSIGNED1 eviction_recent_unreleased_count := 0;
	UNSIGNED1 eviction_historical_unreleased_count := 0;
	UNSIGNED1 eviction_recent_released_count := 0;
	UNSIGNED1 eviction_historical_released_count := 0;
	UNSIGNED1 eviction_count;
	UNSIGNED1 eviction_count30 := 0;
	UNSIGNED1 eviction_count90 := 0;
	UNSIGNED1 eviction_count180 := 0;
	UNSIGNED1 eviction_count12 := 0;
	UNSIGNED1 eviction_count24 := 0;
	UNSIGNED1 eviction_count36 := 0;
	UNSIGNED1 eviction_count60 := 0;
	UNSIGNED4 last_eviction_date := 0;

	Layout_Liens_Info liens_unreleased_civil_judgment;
	Layout_Liens_Info liens_released_civil_judgment;
	Layout_Liens_Info liens_unreleased_federal_tax;
	Layout_Liens_Info liens_released_federal_tax;
	Layout_Liens_Info liens_unreleased_foreclosure;
	Layout_Liens_Info liens_released_foreclosure;
	Layout_Liens_Info liens_unreleased_landlord_tenant;
	Layout_Liens_Info liens_released_landlord_tenant;
	Layout_Liens_Info liens_unreleased_lispendens;
	Layout_Liens_Info liens_released_lispendens;
	Layout_Liens_Info liens_unreleased_other_lj;
	Layout_Liens_Info liens_released_other_lj;
	Layout_Liens_Info liens_unreleased_other_tax;
	Layout_Liens_Info liens_released_other_tax;
	Layout_Liens_Info liens_unreleased_small_claims;
	Layout_Liens_Info liens_released_small_claims;
END;
slimrec := RECORD
	slimmerrec;
	// liens extras
	string50 tmsid;
	STRING50 rmsid;
END;

//

mygetdate := ut.GetDate;

slimrec get_liens(LiensV2.file_liens_party le, liensv2.file_liens_main rt) := TRANSFORM
	self.tmsid := le.tmsid;
	self.rmsid := le.rmsid;

	clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(le.orig_address1, le.orig_city, le.orig_state, le.orig_zip5);
	self.prim_range := clean_address [1..10];
	self.predir := clean_address [11..12];
	self.prim_name := clean_address [13..40];
	self.addr_suffix := clean_address [41..44];
	self.postdir := clean_address [45..46];
	self.unit_desig := clean_address [47..56];
	self.sec_range := clean_address [57..65];
	self.p_city_name := clean_address [90..114];
	self.st := clean_address [115..116];
	self.zip := clean_address [117..121];
	self.zip4 := clean_address[122..125];
	self.county := clean_address[143..145];
	self.geo_lat := clean_address[146..155];
	self.geo_long := clean_address[156..166];
	self.msa := clean_address[167..170];
	self.geo_blk := clean_address[171..177];
	self.geo_match := clean_address[178];

	//build geolink for AddrRisk
	self.geo_link := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];

	self.v_city_name := le.v_city_name;
	self.cr_sort_sz := le.cr_sort_sz;
	self.cart := le.cart;
	self.lot := le.lot;
	self.lot_order := le.lot_order;
	self.dbpc := le.dbpc;
	self.chk_digit := le.chk_digit;
	self.rec_type := le.rec_type;
	self.err_stat := le.err_stat;

	history_date := 999999;
	isRecent := ut.DaysApart(le.date_first_seen,myGetDate)<365*2+1;

	// Unreleased Liens--------------------------------
	self.last_liens_unreleased_date := if((INTEGER)le.date_last_seen=0, le.date_first_seen, '');
	SELF.liens_recent_unreleased_count := (INTEGER)(le.rmsid<>'' AND
																				 (INTEGER)le.date_last_seen=0 AND
																					isRecent);
	SELF.liens_historical_unreleased_count := (INTEGER)(le.rmsid<>'' AND
																						(INTEGER)le.date_last_seen=0 AND
																						~isRecent);

	SELF.liens_unreleased_count30 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,30,history_date));
	SELF.liens_unreleased_count90 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,90,history_date));
	SELF.liens_unreleased_count180 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,180,history_date));
	SELF.liens_unreleased_count12 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(1),history_date));
	SELF.liens_unreleased_count24 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2),history_date));
	SELF.liens_unreleased_count36 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3),history_date));
	SELF.liens_unreleased_count60 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen=0 and
																				risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5),history_date));

	// Released Liens	-----------------------------------
	SELF.last_liens_released_date := if((INTEGER)le.date_last_seen<>0, (unsigned)le.date_first_seen, 0);
	SELF.liens_recent_released_count := (INTEGER)(le.rmsid<>'' AND
																			(INTEGER)le.date_last_seen<>0 AND
																			isRecent);
	SELF.liens_historical_released_count := (INTEGER)(le.rmsid<>'' AND
																					(INTEGER)le.date_last_seen<>0 AND
																					~isRecent);

	SELF.liens_released_count30 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,30,history_date));
	SELF.liens_released_count90 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,90,history_date));
	SELF.liens_released_count180 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,180,history_date));
	SELF.liens_released_count12 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(1),history_date));
	SELF.liens_released_count24 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2),history_date));
	SELF.liens_released_count36 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3),history_date));
	SELF.liens_released_count60 := (INTEGER)(le.rmsid<>'' AND (INTEGER)le.date_last_seen<>0 and
																			risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5),history_date));


	isEviction := rt.eviction='Y';

	// evictions
	SELF.eviction_recent_unreleased_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen=0 AND isRecent);
	SELF.eviction_historical_unreleased_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen=0 AND ~isRecent);
	SELF.eviction_recent_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND isRecent);
	SELF.eviction_historical_released_count := (INTEGER)(isEviction and (INTEGER)le.date_last_seen<>0 AND ~isRecent);

	SELF.eviction_count := (integer)(isEviction);
	SELF.eviction_count30 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,30,history_date));
	SELF.eviction_count90 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,90,history_date));
	SELF.eviction_count180 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,180,history_date));
	SELF.eviction_count12 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(1),history_date));
	SELF.eviction_count24 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(2),history_date));
	SELF.eviction_count36 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(3),history_date));
	SELF.eviction_count60 := (integer)(isEviction and risk_indicators.iid_constants.checkdays(myGetDate,(STRING8)le.date_first_seen,ut.DaysInNYears(5),history_date));

	SELF.last_eviction_date := if(isEviction, (unsigned)le.date_first_seen, 0);

	// they want liens seperated by type and released or unreleased for boca shell 3.0
	ftd := trim(stringlib.stringtouppercase(rt.filing_type_desc));
	goodResult := rt.rmsid<>'';
	unreleased := (unsigned)le.date_last_seen=0;
	released := (unsigned)le.date_last_seen<>0;

	isCivilJudgment := ftd in risk_indicators.iid_constants.setCivilJudgment and goodResult and unreleased;
	isCivilJudgmentReleased := ftd in risk_indicators.iid_constants.setCivilJudgment and goodResult and released;
	isFederalTax := ftd in risk_indicators.iid_constants.setFederalTax and goodResult and unreleased;
	isFederalTaxReleased := ftd in risk_indicators.iid_constants.setFederalTax and goodResult and released;
	isForeclosure := ftd in risk_indicators.iid_constants.setForeclosure and goodResult and unreleased;
	isForeclosureReleased := ftd in risk_indicators.iid_constants.setForeclosure and goodResult and released;
	isLandlordTenant := ftd in risk_indicators.iid_constants.setLandlordTenant and goodResult and unreleased;
	isLandlordTenantReleased := ftd in risk_indicators.iid_constants.setLandlordTenant and goodResult and released;
	isLisPendens := ftd in risk_indicators.iid_constants.setLisPendens and goodResult and unreleased;
	isLisPendensReleased := ftd in risk_indicators.iid_constants.setLisPendens and goodResult and released;
	isOtherLJ := ftd not in risk_indicators.iid_constants.setOtherLJ and goodResult and unreleased;
	isOtherLJReleased := ftd not in risk_indicators.iid_constants.setOtherLJ and goodResult and released;
	isOtherTax := ftd in risk_indicators.iid_constants.setOtherTax and goodResult and unreleased;
	isOtherTaxReleased := ftd in risk_indicators.iid_constants.setOtherTax and goodResult and released;
	isSmallClaims := ftd in risk_indicators.iid_constants.setSmallClaims and goodResult and unreleased;
	isSmallClaimsReleased := ftd in risk_indicators.iid_constants.setSmallClaims and goodResult and released;

	self.liens_unreleased_civil_judgment.count := (integer)isCivilJudgment;
	self.liens_unreleased_civil_judgment.earliest_filing_date := if(isCivilJudgment, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_civil_judgment.most_recent_filing_date := if(isCivilJudgment, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_civil_judgment.total_amount := if(isCivilJudgment, (real)rt.amount, 0);

	self.liens_released_civil_judgment.count := (integer)isCivilJudgmentReleased;
	self.liens_released_civil_judgment.earliest_filing_date := if(isCivilJudgmentReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_civil_judgment.most_recent_filing_date := if(isCivilJudgmentReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_civil_judgment.total_amount := if(isCivilJudgmentReleased, (real)rt.amount, 0);

	self.liens_unreleased_federal_tax.count := (integer)isFederalTax;
	self.liens_unreleased_federal_tax.earliest_filing_date := if(isFederalTax, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_federal_tax.most_recent_filing_date := if(isFederalTax, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_federal_tax.total_amount := if(isFederalTax, (real)rt.amount, 0);

	self.liens_released_federal_tax.count := (integer)isFederalTaxReleased;
	self.liens_released_federal_tax.earliest_filing_date := if(isFederalTaxReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_federal_tax.most_recent_filing_date := if(isFederalTaxReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_federal_tax.total_amount := if(isFederalTaxReleased, (real)rt.amount, 0);

	self.liens_unreleased_foreclosure.count := (integer)isForeclosure;
	self.liens_unreleased_foreclosure.earliest_filing_date := if(isForeclosure, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_foreclosure.most_recent_filing_date := if(isForeclosure, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_foreclosure.total_amount := if(isForeclosure, (real)rt.amount, 0);

	self.liens_released_foreclosure.count := (integer)isForeclosureReleased;
	self.liens_released_foreclosure.earliest_filing_date := if(isForeclosureReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_foreclosure.most_recent_filing_date := if(isForeclosureReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_foreclosure.total_amount := if(isForeclosureReleased, (real)rt.amount, 0);

	self.liens_unreleased_landlord_tenant.count := (integer)isLandlordTenant;
	self.liens_unreleased_landlord_tenant.earliest_filing_date := if(isLandlordTenant, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_landlord_tenant.most_recent_filing_date := if(isLandlordTenant, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_landlord_tenant.total_amount := if(isLandlordTenant, (real)rt.amount, 0);

	self.liens_released_landlord_tenant.count := (integer)isLandlordTenantReleased;
	self.liens_released_landlord_tenant.earliest_filing_date := if(isLandlordTenantReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_landlord_tenant.most_recent_filing_date := if(isLandlordTenantReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_landlord_tenant.total_amount := if(isLandlordTenantReleased, (real)rt.amount, 0);

	self.liens_unreleased_lispendens.count := (integer)isLisPendens;
	self.liens_unreleased_lispendens.earliest_filing_date := if(isLisPendens, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_lispendens.most_recent_filing_date := if(isLisPendens, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_lispendens.total_amount := if(isLisPendens, (real)rt.amount, 0);

	self.liens_released_lispendens.count := (integer)isLisPendensReleased;
	self.liens_released_lispendens.earliest_filing_date := if(isLisPendensReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_lispendens.most_recent_filing_date := if(isLisPendensReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_lispendens.total_amount := if(isLisPendensReleased, (real)rt.amount, 0);

	self.liens_unreleased_other_lj.count := (integer)isOtherLJ;
	self.liens_unreleased_other_lj.earliest_filing_date := if(isOtherLJ, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_other_lj.most_recent_filing_date := if(isOtherLJ, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_other_lj.total_amount := if(isOtherLJ, (real)rt.amount, 0);

	self.liens_released_other_lj.count := (integer)isOtherLJReleased;
	self.liens_released_other_lj.earliest_filing_date := if(isOtherLJReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_other_lj.most_recent_filing_date := if(isOtherLJReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_other_lj.total_amount := if(isOtherLJReleased, (real)rt.amount, 0);

	self.liens_unreleased_other_tax.count := (integer)isOtherTax;
	self.liens_unreleased_other_tax.earliest_filing_date := if(isOtherTax, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_other_tax.most_recent_filing_date := if(isOtherTax, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_other_tax.total_amount := if(isOtherTax, (real)rt.amount, 0);

	self.liens_released_other_tax.count := (integer)isOtherTaxReleased;
	self.liens_released_other_tax.earliest_filing_date := if(isOtherTaxReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_other_tax.most_recent_filing_date := if(isOtherTaxReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_other_tax.total_amount := if(isOtherTaxReleased, (real)rt.amount, 0);

	self.liens_unreleased_small_claims.count := (integer)isSmallClaims;
	self.liens_unreleased_small_claims.earliest_filing_date := if(isSmallClaims, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_small_claims.most_recent_filing_date := if(isSmallClaims, (unsigned4)le.date_first_seen, 0);
	self.liens_unreleased_small_claims.total_amount := if(isSmallClaims, (real)rt.amount, 0);

	self.liens_released_small_claims.count := (integer)isSmallClaimsReleased;
	self.liens_released_small_claims.earliest_filing_date := if(isSmallClaimsReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_small_claims.most_recent_filing_date := if(isSmallClaimsReleased, (unsigned4)le.date_first_seen, 0);
	self.liens_released_small_claims.total_amount := if(isSmallClaimsReleased, (real)rt.amount, 0);


	self.did := (integer)le.did;
end;



lien_party_debtors := LiensV2.file_liens_party((integer)did != 0 and name_type='D');
lien_main := liensv2.file_liens_main;
w_main := join(lien_party_debtors, lien_main,  LEFT.rmsid=RIGHT.rmsid AND left.tmsid=right.tmsid,
									get_liens(LEFT, right), left outer);


slimrec roll_liens(slimrec le, slimrec rt) := TRANSFORM
	sameLien := le.tmsid=rt.tmsid and le.rmsid=rt.rmsid;

	SELF.liens_recent_unreleased_count := le.liens_recent_unreleased_count + IF(sameLien,0,rt.liens_recent_unreleased_count);
	SELF.liens_historical_unreleased_count := le.liens_historical_unreleased_count + IF(sameLien,0,rt.liens_historical_unreleased_count);
	SELF.liens_unreleased_count30 := le.liens_unreleased_count30 + IF(sameLien,0,rt.liens_unreleased_count30);
	SELF.liens_unreleased_count90 := le.liens_unreleased_count90 + IF(sameLien,0,rt.liens_unreleased_count90);
	SELF.liens_unreleased_count180 := le.liens_unreleased_count180 + IF(sameLien,0,rt.liens_unreleased_count180);
	SELF.liens_unreleased_count12 := le.liens_unreleased_count12 + IF(sameLien,0,rt.liens_unreleased_count12);
	SELF.liens_unreleased_count24 := le.liens_unreleased_count24 + IF(sameLien,0,rt.liens_unreleased_count24);
	SELF.liens_unreleased_count36 := le.liens_unreleased_count36 + IF(sameLien,0,rt.liens_unreleased_count36);
	SELF.liens_unreleased_count60 := le.liens_unreleased_count60 + IF(sameLien,0,rt.liens_unreleased_count60);

	SELF.liens_recent_released_count := le.liens_recent_released_count + IF(sameLien,0,rt.liens_recent_released_count);
	SELF.liens_historical_released_count := le.liens_historical_released_count + IF(sameLien,0,rt.liens_historical_released_count);
	SELF.liens_released_count30 := le.liens_released_count30 + IF(sameLien,0,rt.liens_released_count30);
	SELF.liens_released_count90 := le.liens_released_count90 + IF(sameLien,0,rt.liens_released_count90);
	SELF.liens_released_count180 := le.liens_released_count180 + IF(sameLien,0,rt.liens_released_count180);
	SELF.liens_released_count12 := le.liens_released_count12 + IF(sameLien,0,rt.liens_released_count12);
	SELF.liens_released_count24 := le.liens_released_count24 + IF(sameLien,0,rt.liens_released_count24);
	SELF.liens_released_count36 := le.liens_released_count36 + IF(sameLien,0,rt.liens_released_count36);
	SELF.liens_released_count60 := le.liens_released_count60 + IF(sameLien,0,rt.liens_released_count60);

	SELF.last_liens_unreleased_date := if((integer)le.last_liens_unreleased_date > (integer)rt.last_liens_unreleased_date, le.last_liens_unreleased_date, rt.last_liens_unreleased_date);
	SELF.last_liens_released_date := if((integer)le.last_liens_released_date > (integer)rt.last_liens_released_date, le.last_liens_released_date, rt.last_liens_released_date);

	SELF.eviction_recent_unreleased_count := le.eviction_recent_unreleased_count + IF(sameLien,0,rt.eviction_recent_unreleased_count);
	SELF.eviction_historical_unreleased_count := le.eviction_historical_unreleased_count + IF(sameLien,0,rt.eviction_historical_unreleased_count);
	SELF.eviction_recent_released_count := le.eviction_recent_released_count + IF(sameLien,0,rt.eviction_recent_released_count);
	SELF.eviction_historical_released_count := le.eviction_historical_released_count + IF(sameLien,0,rt.eviction_historical_released_count);

	SELF.eviction_count := le.eviction_count + IF(sameLien,0,rt.eviction_count);
	SELF.eviction_count30 := le.eviction_count30 + IF(sameLien,0,rt.eviction_count30);
	SELF.eviction_count90 := le.eviction_count90 + IF(sameLien,0,rt.eviction_count90);
	SELF.eviction_count180 := le.eviction_count180 + IF(sameLien,0,rt.eviction_count180);
	SELF.eviction_count12 := le.eviction_count12 + IF(sameLien,0,rt.eviction_count12);
	SELF.eviction_count24 := le.eviction_count24 + IF(sameLien,0,rt.eviction_count24);
	SELF.eviction_count36 := le.eviction_count36 + IF(sameLien,0,rt.eviction_count36);
	SELF.eviction_count60 := le.eviction_count60 + IF(sameLien,0,rt.eviction_count60);

	SELF.last_eviction_date := ut.max2(le.last_eviction_date,rt.last_eviction_date);

	self.liens_unreleased_civil_judgment.count := le.liens_unreleased_civil_judgment.count + IF(sameLien and le.liens_unreleased_civil_judgment.count>0,0,rt.liens_unreleased_civil_judgment.count);
	self.liens_unreleased_civil_judgment.earliest_filing_date := ut.Min2(le.liens_unreleased_civil_judgment.earliest_filing_date,rt.liens_unreleased_civil_judgment.earliest_filing_date);
	self.liens_unreleased_civil_judgment.most_recent_filing_date := ut.max2(le.liens_unreleased_civil_judgment.most_recent_filing_date,rt.liens_unreleased_civil_judgment.most_recent_filing_date);
	self.liens_unreleased_civil_judgment.total_amount := le.liens_unreleased_civil_judgment.total_amount + IF(sameLien and le.liens_unreleased_civil_judgment.total_amount>0,0,rt.liens_unreleased_civil_judgment.total_amount);

	self.liens_released_civil_judgment.count := le.liens_released_civil_judgment.count + IF(sameLien and le.liens_released_civil_judgment.count>0,0,rt.liens_released_civil_judgment.count);
	self.liens_released_civil_judgment.earliest_filing_date := ut.Min2(le.liens_released_civil_judgment.earliest_filing_date,rt.liens_released_civil_judgment.earliest_filing_date);
	self.liens_released_civil_judgment.most_recent_filing_date := ut.max2(le.liens_released_civil_judgment.most_recent_filing_date,rt.liens_released_civil_judgment.most_recent_filing_date);
	self.liens_released_civil_judgment.total_amount := le.liens_released_civil_judgment.total_amount + IF(sameLien and le.liens_released_civil_judgment.total_amount>0,0,rt.liens_released_civil_judgment.total_amount);

	self.liens_unreleased_federal_tax.count := le.liens_unreleased_federal_tax.count + IF(sameLien and le.liens_unreleased_federal_tax.count>0,0,rt.liens_unreleased_federal_tax.count);
	self.liens_unreleased_federal_tax.earliest_filing_date := ut.Min2(le.liens_unreleased_federal_tax.earliest_filing_date,rt.liens_unreleased_federal_tax.earliest_filing_date);
	self.liens_unreleased_federal_tax.most_recent_filing_date := ut.max2(le.liens_unreleased_federal_tax.most_recent_filing_date,rt.liens_unreleased_federal_tax.most_recent_filing_date);
	self.liens_unreleased_federal_tax.total_amount := le.liens_unreleased_federal_tax.total_amount + IF(sameLien and le.liens_unreleased_federal_tax.total_amount>0,0,rt.liens_unreleased_federal_tax.total_amount);

	self.liens_released_federal_tax.count := le.liens_released_federal_tax.count + IF(sameLien and le.liens_released_federal_tax.count>0,0,rt.liens_released_federal_tax.count);
	self.liens_released_federal_tax.earliest_filing_date := ut.Min2(le.liens_released_federal_tax.earliest_filing_date,rt.liens_released_federal_tax.earliest_filing_date);
	self.liens_released_federal_tax.most_recent_filing_date := ut.max2(le.liens_released_federal_tax.most_recent_filing_date,rt.liens_released_federal_tax.most_recent_filing_date);
	self.liens_released_federal_tax.total_amount := le.liens_released_federal_tax.total_amount + IF(sameLien and le.liens_released_federal_tax.total_amount>0,0,rt.liens_released_federal_tax.total_amount);

	self.liens_unreleased_foreclosure.count := le.liens_unreleased_foreclosure.count + IF(sameLien and le.liens_unreleased_foreclosure.count>0,0,rt.liens_unreleased_foreclosure.count);
	self.liens_unreleased_foreclosure.earliest_filing_date := ut.Min2(le.liens_unreleased_foreclosure.earliest_filing_date,rt.liens_unreleased_foreclosure.earliest_filing_date);
	self.liens_unreleased_foreclosure.most_recent_filing_date := ut.max2(le.liens_unreleased_foreclosure.most_recent_filing_date,rt.liens_unreleased_foreclosure.most_recent_filing_date);
	self.liens_unreleased_foreclosure.total_amount := le.liens_unreleased_foreclosure.total_amount + IF(sameLien and le.liens_unreleased_foreclosure.total_amount>0,0,rt.liens_unreleased_foreclosure.total_amount);

	self.liens_released_foreclosure.count := le.liens_released_foreclosure.count + IF(sameLien and le.liens_released_foreclosure.count>0,0,rt.liens_released_foreclosure.count);
	self.liens_released_foreclosure.earliest_filing_date := ut.Min2(le.liens_released_foreclosure.earliest_filing_date,rt.liens_released_foreclosure.earliest_filing_date);
	self.liens_released_foreclosure.most_recent_filing_date := ut.max2(le.liens_released_foreclosure.most_recent_filing_date,rt.liens_released_foreclosure.most_recent_filing_date);
	self.liens_released_foreclosure.total_amount := le.liens_released_foreclosure.total_amount + IF(sameLien and le.liens_released_foreclosure.total_amount>0,0,rt.liens_released_foreclosure.total_amount);

	self.liens_unreleased_landlord_tenant.count := le.liens_unreleased_landlord_tenant.count + IF(sameLien and le.liens_unreleased_landlord_tenant.count>0,0,rt.liens_unreleased_landlord_tenant.count);
	self.liens_unreleased_landlord_tenant.earliest_filing_date := ut.Min2(le.liens_unreleased_landlord_tenant.earliest_filing_date,rt.liens_unreleased_landlord_tenant.earliest_filing_date);
	self.liens_unreleased_landlord_tenant.most_recent_filing_date := ut.max2(le.liens_unreleased_landlord_tenant.most_recent_filing_date,rt.liens_unreleased_landlord_tenant.most_recent_filing_date);
	self.liens_unreleased_landlord_tenant.total_amount := le.liens_unreleased_landlord_tenant.total_amount + IF(sameLien and le.liens_unreleased_landlord_tenant.total_amount>0,0,rt.liens_unreleased_landlord_tenant.total_amount);

	self.liens_released_landlord_tenant.count := le.liens_released_landlord_tenant.count + IF(sameLien and le.liens_released_landlord_tenant.count>0,0,rt.liens_released_landlord_tenant.count);
	self.liens_released_landlord_tenant.earliest_filing_date := ut.Min2(le.liens_released_landlord_tenant.earliest_filing_date,rt.liens_released_landlord_tenant.earliest_filing_date);
	self.liens_released_landlord_tenant.most_recent_filing_date := ut.max2(le.liens_released_landlord_tenant.most_recent_filing_date,rt.liens_released_landlord_tenant.most_recent_filing_date);
	self.liens_released_landlord_tenant.total_amount := le.liens_released_landlord_tenant.total_amount + IF(sameLien and le.liens_released_landlord_tenant.total_amount>0,0,rt.liens_released_landlord_tenant.total_amount);

	self.liens_unreleased_lispendens.count := le.liens_unreleased_lispendens.count + IF(sameLien and le.liens_unreleased_lispendens.count>0,0,rt.liens_unreleased_lispendens.count);
	self.liens_unreleased_lispendens.earliest_filing_date := ut.Min2(le.liens_unreleased_lispendens.earliest_filing_date,rt.liens_unreleased_lispendens.earliest_filing_date);
	self.liens_unreleased_lispendens.most_recent_filing_date := ut.max2(le.liens_unreleased_lispendens.most_recent_filing_date,rt.liens_unreleased_lispendens.most_recent_filing_date);
	self.liens_unreleased_lispendens.total_amount := le.liens_unreleased_lispendens.total_amount + IF(sameLien and le.liens_unreleased_lispendens.total_amount>0,0,rt.liens_unreleased_lispendens.total_amount);

	self.liens_released_lispendens.count := le.liens_released_lispendens.count + IF(sameLien and le.liens_released_lispendens.count>0,0,rt.liens_released_lispendens.count);
	self.liens_released_lispendens.earliest_filing_date := ut.Min2(le.liens_released_lispendens.earliest_filing_date,rt.liens_released_lispendens.earliest_filing_date);
	self.liens_released_lispendens.most_recent_filing_date := ut.max2(le.liens_released_lispendens.most_recent_filing_date,rt.liens_released_lispendens.most_recent_filing_date);
	self.liens_released_lispendens.total_amount := le.liens_released_lispendens.total_amount + IF(sameLien and le.liens_released_lispendens.total_amount>0,0,rt.liens_released_lispendens.total_amount);

	self.liens_unreleased_other_lj.count := le.liens_unreleased_other_lj.count + IF(sameLien and le.liens_unreleased_other_lj.count>0,0,rt.liens_unreleased_other_lj.count);
	self.liens_unreleased_other_lj.earliest_filing_date := ut.Min2(le.liens_unreleased_other_lj.earliest_filing_date,rt.liens_unreleased_other_lj.earliest_filing_date);
	self.liens_unreleased_other_lj.most_recent_filing_date := ut.max2(le.liens_unreleased_other_lj.most_recent_filing_date,rt.liens_unreleased_other_lj.most_recent_filing_date);
	self.liens_unreleased_other_lj.total_amount := le.liens_unreleased_other_lj.total_amount + IF(sameLien and le.liens_unreleased_other_lj.total_amount>0,0,rt.liens_unreleased_other_lj.total_amount);

	self.liens_released_other_lj.count := le.liens_released_other_lj.count + IF(sameLien and le.liens_released_other_lj.count>0,0,rt.liens_released_other_lj.count);
	self.liens_released_other_lj.earliest_filing_date := ut.Min2(le.liens_released_other_lj.earliest_filing_date,rt.liens_released_other_lj.earliest_filing_date);
	self.liens_released_other_lj.most_recent_filing_date := ut.max2(le.liens_released_other_lj.most_recent_filing_date,rt.liens_released_other_lj.most_recent_filing_date);
	self.liens_released_other_lj.total_amount := le.liens_released_other_lj.total_amount + IF(sameLien and le.liens_released_other_lj.total_amount>0,0,rt.liens_released_other_lj.total_amount);

	self.liens_unreleased_other_tax.count := le.liens_unreleased_other_tax.count + IF(sameLien and le.liens_unreleased_other_tax.count>0,0,rt.liens_unreleased_other_tax.count);
	self.liens_unreleased_other_tax.earliest_filing_date := ut.Min2(le.liens_unreleased_other_tax.earliest_filing_date,rt.liens_unreleased_other_tax.earliest_filing_date);
	self.liens_unreleased_other_tax.most_recent_filing_date := ut.max2(le.liens_unreleased_other_tax.most_recent_filing_date,rt.liens_unreleased_other_tax.most_recent_filing_date);
	self.liens_unreleased_other_tax.total_amount := le.liens_unreleased_other_tax.total_amount + IF(sameLien and le.liens_unreleased_other_tax.total_amount>0,0,rt.liens_unreleased_other_tax.total_amount);

	self.liens_released_other_tax.count := le.liens_released_other_tax.count + IF(sameLien and le.liens_released_other_tax.count>0,0,rt.liens_released_other_tax.count);
	self.liens_released_other_tax.earliest_filing_date := ut.Min2(le.liens_released_other_tax.earliest_filing_date,rt.liens_released_other_tax.earliest_filing_date);
	self.liens_released_other_tax.most_recent_filing_date := ut.max2(le.liens_released_other_tax.most_recent_filing_date,rt.liens_released_other_tax.most_recent_filing_date);
	self.liens_released_other_tax.total_amount := le.liens_released_other_tax.total_amount + IF(sameLien and le.liens_released_other_tax.total_amount>0,0,rt.liens_released_other_tax.total_amount);

	self.liens_unreleased_small_claims.count := le.liens_unreleased_small_claims.count + IF(sameLien and le.liens_unreleased_small_claims.count>0,0,rt.liens_unreleased_small_claims.count);
	self.liens_unreleased_small_claims.earliest_filing_date := ut.Min2(le.liens_unreleased_small_claims.earliest_filing_date,rt.liens_unreleased_small_claims.earliest_filing_date);
	self.liens_unreleased_small_claims.most_recent_filing_date := ut.max2(le.liens_unreleased_small_claims.most_recent_filing_date,rt.liens_unreleased_small_claims.most_recent_filing_date);
	self.liens_unreleased_small_claims.total_amount := le.liens_unreleased_small_claims.total_amount + IF(sameLien and le.liens_unreleased_small_claims.total_amount>0,0,rt.liens_unreleased_small_claims.total_amount);

	self.liens_released_small_claims.count := le.liens_released_small_claims.count + IF(sameLien and le.liens_released_small_claims.count>0,0,rt.liens_released_small_claims.count);
	self.liens_released_small_claims.earliest_filing_date := ut.Min2(le.liens_released_small_claims.earliest_filing_date,rt.liens_released_small_claims.earliest_filing_date);
	self.liens_released_small_claims.most_recent_filing_date := ut.max2(le.liens_released_small_claims.most_recent_filing_date,rt.liens_released_small_claims.most_recent_filing_date);
	self.liens_released_small_claims.total_amount := le.liens_released_small_claims.total_amount + IF(sameLien and le.liens_released_small_claims.total_amount>0,0,rt.liens_released_small_claims.total_amount);

	SELF := rt;
END;

w_main_distr := DISTRIBUTE(w_main,HASH(did));
liens_and_main_rolled := ROLLUP(SORT(w_main_distr, did,tmsid,rmsid, local),LEFT.did=RIGHT.did, roll_liens(LEFT,RIGHT), local);

// remove the tmsid and rmsid from the final layout
liens_and_main_slimmed := PROJECT(liens_and_main_rolled,slimmerrec);

export file_liens := liens_and_main_slimmed;
