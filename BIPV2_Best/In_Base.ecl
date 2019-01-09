import BIPV2, ut, MDR,BIPv2_HRCHY;

EXPORT In_Base( 
  dataset(BIPV2.CommonBase.Layout) pHrchyBase  = project(BIPV2.CommonBase.DS_CLEAN,BIPV2.CommonBase.Layout)
):= module
//set source_for_votes and flags
//source_for_votes
//  1..2 = source
//  3..36 = vl_id
//  37..39 = address indicators
// 40..43 = phone score indicators
// 44..44 = Phone Type (T, F or blank)
// 45..45 = first FEIN
// 46..46 = earliest nonzero company_filing_date
// 47..47 = is_sele_level indicator
// 48..48 = legal name indicator


//add address flag to source fields so it can be use in valid address funtion
BIPV2_Best.Layouts.In_Base_with_flags b_header_t(BIPV2.Files.business_header_building le) := transform
is_prim_range := if(le.prim_name != '', ut.bit_set(0,0),0);
is_prim_name  := if(le.prim_name != '', ut.bit_set(0,1),0);
is_sec_range  := if(le.sec_range != '', ut.bit_set(0,2),0);
is_city_name  := if(le.v_city_name != '', ut.bit_set(0,3),0);
is_zip        := if(le.zip != '', ut.bit_set(0,4),0);
is_zip4        := if(le.zip4 != '', ut.bit_set(0,5),0);
is_st					:= if(le.st != '', ut.bit_set(0,6),0);
is_pobox      := if(le.prim_name[1..7] != 'PO BOX ' and le.prim_name[1..3] not in ['RR ', 'HC '], ut.bit_set(0,7),0);
is_unit_desig := if(le.unit_desig != '', ut.bit_set(0,8),0);
address_votes := is_prim_range | is_prim_name |  is_sec_range | is_city_name | is_zip | is_zip4 |is_st | is_pobox | is_unit_desig;
self.source_for_votes := (string2)le.source + (string34)le.vl_id + intformat(address_votes, 3,1);
self := le;
end;

shared with_address_flags := project(pHrchyBase, b_header_t(left));

//calculate phone score for non_gong recs
shared score_non_gong := with_address_flags (not(MDR.sourceTools.SourceIsGong_Business		(source)
					or 	MDR.sourceTools.SourceIsGong_Government	(source)));

shared no_score_gong := project(with_address_flags(MDR.sourceTools.SourceIsGong_Business	(source)
										or 	MDR.sourceTools.SourceIsGong_Government	(source)),
										transform(BIPV2_Best.Layouts.In_Base_with_flags,
															self.source_for_votes := if(left.company_phone <> '', (string39)left.source_for_votes + intformat(left.phone_score, 4,1), '0000') +(string1)left.phone_type + (string)left.company_fein[1],
															self := left));
					
BIPV2_Best.Layouts.In_Base_with_flags calc_phone_score (BIPV2_Best.Layouts.In_Base_with_flags le) := transform
	STRING10 sf(INTEGER ph) := INTFORMAT(ph, 10, 1);
	INTEGER ph_score(INTEGER ph) := 2 * (
							IF(sf(ph)[9..10] = '00', 500, 0) +
							IF(sf(ph)[8..10] = '000', 500, 0) +
							IF(sf(ph)[1..3] IN ['800','811','822','833','844','855','866','877','888'], 250, 0));
	SELF.source_for_votes := if(le.company_phone <> '', (string39)le.source_for_votes + intformat(ph_score((unsigned)le.company_phone), 4,1) + (string1)le.phone_type + (string1)le.company_fein[1],
																											(string39)le.source_for_votes + '0000') + (string1)le.phone_type + (string1)le.company_fein[1];
	SELF := le;
END;

shared scored_non_gong := project(score_non_gong,calc_phone_score(LEFT));

shared all_phone_scored := project(scored_non_gong + no_score_gong,
													             transform(BIPV2_Best.Layouts.In_Base_with_flags,
																			 self.source_for_votes := (string45) left.source_for_votes+ '00' + if(left.company_name_type_raw = 'LEGAL' or left.company_name_type_derived = 'LEGAl', '1', '0'),
																			 self := left));


EXPORT For_Proxid := all_phone_scored;


//Add indicators for is_sele_level = true and earliest nonzero company_filing_date to source_for_votes
shared earliest_company_filing_date := dedup(sort(distribute(project(pHrchyBase(company_filing_date > 0), {pHrchyBase.seleid, pHrchyBase.company_filing_date, pHrchyBase.company_name}), 
																									hash(seleid)),
																							seleid, company_filing_date, local),
																				seleid, local);

												
shared flags_earliest_company_filing_date := join(distribute(all_phone_scored, hash(seleid)),
										      earliest_company_filing_date,
													left.seleid = right.seleid and
													//left.company_name = right.company_name,
													left.company_filing_date = right.company_filing_date and left.company_filing_date<>0,
													transform(BIPV2_Best.Layouts.In_Base_with_flags,
																		//SELF.source_for_votes := if(left.seleid = right.seleid and left.company_name = right.company_name, (string45) left.source_for_votes + '1' + left.source_for_votes[47..48],(string45) left.source_for_votes +'0' + left.source_for_votes[47..48]),
																		SELF.source_for_votes := if(left.seleid = right.seleid and left.company_filing_date = right.company_filing_date and left.company_filing_date<>0, (string45) left.source_for_votes + '1' + left.source_for_votes[47..48],(string45) left.source_for_votes +'0' + left.source_for_votes[47..48]),self := left),
													left outer,
													local);
											
shared is_sele_l := project(flags_earliest_company_filing_date,
														transform(BIPV2_Best.Layouts.In_Base_with_flags,
																		SELF.source_for_votes := if(left.is_sele_level, (string46) left.source_for_votes + '1'  + left.source_for_votes[48], (string46) left.source_for_votes + '0' + left.source_for_votes[48]),
																		self := left));	  
													
															
EXPORT For_Seleid := is_sele_l;
end;