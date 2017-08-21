IMPORT ut, Business_Header,mdr;

export fGong_As_Business_Header(dataset(layout_historyaid) pHistoryFile) := 
function

//*************************************************************************
// Translate Gong Business Records to Common Business Header Format
//*************************************************************************


Gong_Business := pHistoryFile(listing_type_bus<>'',publish_code IN ['P','U'], current_record_flag = 'Y');

Layout_Gong_Temp := RECORD
Business_Header.Layout_Business_Header_New;
string10          group_seq;
string254         caption_text;
string10          phone10;
unsigned2         phone_number_score := 0;
unsigned2         phone_sequence_score := 0;
boolean           ebc_flag;
END;

Layout_Gong_Temp  Translate_Gong_to_BHF(layout_historyaid L) := TRANSFORM
SELF.company_name := L.listed_name;
SELF.vl_id := (STRING34)(L.bell_id + L.group_id);
SELF.vendor_id := (QSTRING34)((STRING34)(L.bell_id + L.group_id));
SELF.zip := (UNSIGNED3)L.z5;
SELF.zip4 := (UNSIGNED2)L.z4;
SELF.phone := (UNSIGNED6)((UNSIGNED8)L.phone10);
SELF.phone_score := 0;
SELF.addr_suffix := L.suffix;
SELF.city := L.v_city_name;
SELF.state := L.st;
SELF.county := L.county_code[3..5];
SELF.source := IF(L.listing_type_gov <> ''
                   OR ut.GovName(ut.CleanCompany(L.listed_name))
									, MDR.sourceTools.src_Gong_Government
									, MDR.sourceTools.src_Gong_Business
							);
SELF.dt_first_seen := (UNSIGNED4)StringLib.GetDateYYYYMMDD();
SELF.dt_last_seen := (UNSIGNED4)StringLib.GetDateYYYYMMDD();
SELF.dt_vendor_first_reported := (UNSIGNED4)(L.filedate[1..8]);
SELF.dt_vendor_last_reported := (UNSIGNED4)StringLib.GetDateYYYYMMDD();
SELF.current := TRUE;
//SELF.ebc_flag := L.bell_id = 'BS' AND (Business_Header.CheckEBCName(L.listed_name) OR Business_Header.CheckEBCPhone(L.phone10));
// Do not use group ids from Bell South
SELF.ebc_flag := L.bell_id = 'BS';
SELF := L;
END;

// Initialize Gong Information
Gong_Init := PROJECT(Gong_Business, Translate_Gong_to_BHF(LEFT));

ut.MAC_Sequence_Records(Gong_Init, group1_id, Gong_Seq)

// Group to set group id
Gong_Dist := DISTRIBUTE(Gong_Seq, HASH(vendor_id));
Gong_Dist_Sort := SORT(Gong_Dist, vendor_id, LOCAL);
Gong_Group0 := GROUP(Gong_Dist_Sort, vendor_id, LOCAL);
Gong_Group_Sort0 := SORT(Gong_Group0, group1_id);

// Iterate to set group id
Layout_Gong_Temp SetGroupID(Layout_Gong_Temp L, Layout_Gong_Temp R) := TRANSFORM
SELF.group1_id := IF(L.group1_id = 0, R.group1_id, L.group1_id);
SELF := R;
END;

Gong_Init_ID := (GROUP(ITERATE(Gong_Group_Sort0, SetGroupID(LEFT, RIGHT))));

// Group to determine phone score
Gong_Group1 := GROUP(Gong_Init_ID((INTEGER)phone10 <> 0), vendor_id, LOCAL);

// Sort by phone number order and score
Gong_Group_Sort1 := SORT(Gong_Group1, -phone10);

Layout_Gong_Temp Score_Phone_Number_Order(Layout_Gong_Temp L, Layout_Gong_Temp R) := TRANSFORM
SELF.phone_number_score := L.phone_number_score + 1;
SELF.phone_score := IF(R.phone10[9..10] = '00', 500, 0) +
                    IF(R.phone10[8..10] = '000', 500, 0) +
                    IF(R.phone10[1..3] IN ['800','811','822','833','844','855','866','877','888'], 250, 0) +
                    MAP(Stringlib.Stringfind(R.caption_text, 'MAIN NUMBER', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'MAIN OFFICE', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'GENERAL INFORMATION', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'INFORMATION CENTER', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'GENERAL OFFICES', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'EXECUTIVE OFFICES', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'ADMINISTRATIVE OFFICES', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'PUBLIC INFORMATION', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'CAMPUS INFORMATION', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'STORE INFORMATION', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'INQUIRIES', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'GENERAL OFFICES', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'RESERVATIONS & INFORMATION', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'OPERATOR', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'SWITCHBOARD', 1) > 0 => 1000,
                        Stringlib.Stringfind(R.caption_text, 'INFORMATION', 1) > 0 => 750,
                        Stringlib.Stringfind(R.caption_text, 'ADMINISTRATION', 1) > 0 => 750,
                        Stringlib.Stringfind(R.caption_text, 'CORPORATE OFFICE', 1) > 0 => 750,
                        Stringlib.Stringfind(R.caption_text, 'CUSTOMER SERVICE', 1) > 0 => 750,
                        Stringlib.Stringfind(R.caption_text, 'ALL OTHER MATTERS', 1) > 0 => 500,
                        Stringlib.Stringfind(R.caption_text, 'ALL OTHER DEPARTMENTS', 1) > 0 => 500,
                        Stringlib.Stringfind(R.caption_text, 'ALL OTHER CALLS', 1) > 0 => 500,
                        Stringlib.Stringfind(R.caption_text, 'UNLISTED DEPARTMENTS', 1) > 0 => 500,
                        Stringlib.Stringfind(R.caption_text, 'DEPARTMENTS NOT LISTED', 1) > 0 => 500,
                        Stringlib.Stringfind(R.caption_text, 'LOCAL OFFICES', 1) > 0 => 500,
                        Stringlib.Stringfind(R.caption_text, 'GENERAL', 1) > 0 => 250,
                        Stringlib.Stringfind(R.caption_text, 'MAIN', 1) > 0 => 250,
                        Stringlib.Stringfind(R.caption_text, 'SERVICE', 1) > 0 => 250,
                        Stringlib.Stringfind(R.caption_text, 'ASSISTANCE', 1) > 0 => 250,
                        Stringlib.Stringfind(R.caption_text, 'RESERVATIONS', 1) > 0 => 250,

                        0);          
SELF := R;
END;

Gong_Group_Iter1 := ITERATE(Gong_Group_Sort1, Score_Phone_Number_Order(LEFT, RIGHT));

// Sort by group sequence and score
Gong_Group_Sort2 := SORT(Gong_Group_Iter1, -group_seq);

Layout_Gong_Temp Score_Phone_Group_Sequence(Layout_Gong_Temp L, Layout_Gong_Temp R) := TRANSFORM
SELF.phone_sequence_score := L.phone_sequence_score + 1;
SELF := R;
END;

Gong_Group_Iter2 := GROUP(ITERATE(Gong_Group_Sort2, Score_Phone_Group_Sequence(LEFT, RIGHT)));

// Combine Scored phones with blank phones
Gong_Scored := Gong_Group_Iter2 + Gong_Init_ID((INTEGER)phone10=0);

// Special processing to clear group id for phone listing groups that appear to
// be Executive Business Centers (unrelated companies which are billed on the
// same account by the service provider).
Gong_Scored_Dist := DISTRIBUTE(Gong_Scored, HASH(vendor_id));
Gong_Scored_Dist_Sort := SORT(Gong_Scored_Dist, vendor_id, LOCAL);
Gong_Scored_Group := GROUP(Gong_Scored_Dist_Sort, vendor_id, LOCAL);
Gong_Scored_Group_Sort := SORT(Gong_Scored_Group, IF(ebc_flag, 0, 1));

Layout_Gong_Temp PropagateEBCFlag(Layout_Gong_Temp L, Layout_Gong_Temp R) := TRANSFORM
SELF.ebc_flag := IF(L.ebc_flag, L.ebc_flag, R.ebc_flag);
SELF.group1_id := IF(SELF.ebc_flag, 0, R.group1_id);
SELF := R;
END;

Gong_Scored_Group_Iter := GROUP(ITERATE(Gong_Scored_Group_Sort, PropagateEBCFlag(LEFT, RIGHT)));

// Project to Business Header Base Format
Business_Header.Layout_Business_Header_New Format_to_BHF(Layout_Gong_Temp L) := TRANSFORM
SELF.phone_score := L.phone_score + (L.phone_number_score * 2) + L.phone_sequence_score;
SELF := L;
END;

return  PROJECT(Gong_Scored_Group_Iter, Format_To_BHF(LEFT));

end;
