import BIPV2, ut, MDR;

//set flags
layout_with_flags := record
recordof(BIPV2.Files.business_header_building);
string44 source_for_votes := '';
string1 company_name_flag := '';
string1 company_fein_flag := '';
string1 company_phone_flag := '';
string1 company_url_flag := '';
string1 address_flag := '';
end;

//add address flag to source fields so it can be use in valid address funtion
layout_with_flags b_header_t(BIPV2.Files.business_header_building le) := transform
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
self.source_for_votes := le.source + le.vl_id + intformat(address_votes, 3,1);
self := le;
end;

with_address_flags := project(BIPV2.Files.business_header_building, b_header_t(left));

//calculate phone score for non_gong recs
score_non_gong := with_address_flags (not(MDR.sourceTools.SourceIsGong_Business		(source)
					or 	MDR.sourceTools.SourceIsGong_Government	(source)));

no_score_gong := project(with_address_flags(MDR.sourceTools.SourceIsGong_Business	(source)
										or 	MDR.sourceTools.SourceIsGong_Government	(source)),
										transform(layout_with_flags,
															self.source_for_votes := if(left.company_phone <> '', trim(left.source_for_votes, left, right) + intformat(left.phone_score, 4,1), '0000'),
															self := left));
					
layout_with_flags calc_phone_score (layout_with_flags le) := transform
	STRING10 sf(INTEGER ph) := INTFORMAT(ph, 10, 1);
	INTEGER ph_score(INTEGER ph) := 2 * (
							IF(sf(ph)[9..10] = '00', 500, 0) +
							IF(sf(ph)[8..10] = '000', 500, 0) +
							IF(sf(ph)[1..3] IN ['800','811','822','833','844','855','866','877','888'], 250, 0));
	SELF.source_for_votes := if(le.company_phone <> '', trim(le.source_for_votes, left, right) + intformat(ph_score((unsigned)le.company_phone), 4,1) + (string)le.company_fein[1],
																												trim(le.source_for_votes, left, right) + '0000') + (string)le.company_fein[1];
	SELF := le;
END;

scored_non_gong := project(score_non_gong,calc_phone_score(LEFT));

all_phone_scored := scored_non_gong + no_score_gong;

EXPORT In_Base := all_phone_scored;