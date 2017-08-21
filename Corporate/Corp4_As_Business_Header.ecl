IMPORT Business_Header, ut;

//*************************************************************************
// Translate Corporate to Common Business Header Format
//*************************************************************************

// Filter Base file to remove records where Registered Agent Address has
// been propagated to Corporate Address unless the Registered Agent is an
// officer of the corporation

Layout_Corporate_Base BlankCorpAddress(Layout_Corporate_Base l) := transform
self.prim_range := '';
self.predir := '';
self.prim_name := '';
self.addr_suffix := '';
self.postdir := '';
self.unit_desig := '';
self.sec_range := '';
self.p_city_name := '';
self.state := '';
self.zip5 := '';
self.zip4 := '';
self.county := '';
self.msa := '';
self.geo_lat := '';
self.geo_long := '';
self := l;
end;



Corp4_RA_Addr := File_Corp4_Base(not(
                              suppress_ra_addr<>'Y' OR
                              (suppress_ra_addr='Y' AND
                               ra_officer_also='Y' AND
                               (Datalib.CompanyClean(reg_agent_name))[41..120] = '' AND
                                (integer)((address.cleanPerson73(reg_agent_name))[71..73]) >= 85
                               ))) : PERSIST('TMTEMP::Corp_Companies_RA');

Corp4_Blank_Addr := project(Corp4_RA_Addr, BlankCorpAddress(left));


Corp4_Init := File_Corp4_Base(stringlib.stringfind(abbrev_legal_name, '0000000000', 1) = 0,
                               suppress_ra_addr<>'Y' OR
                              (suppress_ra_addr='Y' AND
                               ra_officer_also='Y' AND
                               (Datalib.CompanyClean(reg_agent_name))[41..120] = '' AND
                                (integer)((address.cleanPerson73(reg_agent_name))[71..73]) >= 85
                               ));

Corp4_Clean := Corp4_Init + Corp4_Blank_Addr;

Layout_Corp_Local := RECORD
UNSIGNED6 record_id := 0;
Layout_Corporate_Base;
END;

Layout_BHF_Local := RECORD
Business_Header.Layout_Business_Header;
STRING1 source_type;
UNSIGNED6 orig_id;
UNSIGNED6 split_id := 0;
STRING1 NTYP;
END;

// Add unique record id to Corporate file
Layout_Corp_Local AddRecordID(Layout_Corporate_Base L) := TRANSFORM
SELF := L;
END;

// Don't use Corporate records where the the Registered Agent address is the corporate address
Corp_Init := PROJECT(Corp4_Clean, AddRecordID(LEFT));

ut.MAC_Sequence_Records(Corp_Init, record_id, Corp_Seq)

Layout_BHF_Local  Translate_Corporate_to_BHF(Layout_Corp_Local L, INTEGER CTR, STRING1 NTYP) := TRANSFORM
SELF.orig_id := L.record_id;
SELF.NTYP := NTYP;
SELF.vendor_id := (QSTRING34)((STRING34)(L.state_origin+L.sos_ter_nbr));
SELF.phone := 0;
SELF.phone_score := 0;
SELF.source := 'C';
SELF.source_group := (QSTRING34)((STRING34)(L.state_origin+L.sos_ter_nbr));
SELF.source_type := MAP(NTYP='1' AND CTR=1 => NTYP,
                          NTYP='1' AND CTR= 2 AND NOT(L.prior_street='' AND L.prior_city='' AND L.prior_state='' AND L.prior_zip='') => NTYP,
                          NTYP='2' AND CTR=1 => NTYP,
                          NTYP='2' AND CTR=2 AND NOT(L.prior_street='' AND L.prior_city='' AND L.prior_state='' AND L.prior_zip='') => NTYP,
                          '');
SELF.company_name := IF(NTYP='1', L.abbrev_legal_name, L.prior_name);
SELF.prim_range := CHOOSE(CTR, L.prim_range, L.prior_prim_range);
SELF.predir := CHOOSE(CTR, L.predir, L.prior_predir);
SELF.prim_name := CHOOSE(CTR, stringlib.stringtouppercase(L.prim_name),
                                stringlib.stringtouppercase(L.prior_prim_name));
SELF.addr_suffix := CHOOSE(CTR, stringlib.stringtouppercase(L.addr_suffix),
                                  stringlib.stringtouppercase(L.prior_addr_suffix));
SELF.postdir := CHOOSE(CTR, stringlib.stringtouppercase(L.postdir),
                              stringlib.stringtouppercase(L.prior_postdir));
SELF.unit_desig := CHOOSE(CTR, stringlib.stringtouppercase(L.unit_desig),
                                 stringlib.stringtouppercase(L.prior_unit_desig));
SELF.sec_range := CHOOSE(CTR, L.sec_range, L.prior_sec_range);
SELF.city := CHOOSE(CTR, stringlib.stringtouppercase(L.p_city_name),
                           stringlib.stringtouppercase(L.prior_p_city_name));
SELF.state := CHOOSE(CTR, stringlib.stringtouppercase(L.state),
                            stringlib.stringtouppercase(L.prior_st));
SELF.zip := CHOOSE(CTR, (UNSIGNED3)L.zip5, (UNSIGNED3)L.prior_zip5);
SELF.zip4 := CHOOSE(CTR, (UNSIGNED2)L.zip4, (UNSIGNED2)L.prior_zip4);
SELF.county := CHOOSE(CTR, L.county, L.prior_county);
SELF.msa := CHOOSE(CTR, L.msa, L.prior_msa);
SELF.geo_lat := CHOOSE(CTR, L.geo_lat, L.prior_geo_lat);
SELF.geo_long := CHOOSE(CTR, L.geo_long, L.prior_geo_long);
SELF.dt_first_seen := (UNSIGNED4)L.dt_first_seen;
SELF.dt_last_seen := (UNSIGNED4)L.dt_last_seen;
SELF.dt_vendor_first_reported := (UNSIGNED4)L.dt_first_seen;
SELF.dt_vendor_last_reported := (UNSIGNED4)L.dt_last_seen;
SELF.fein := IF(L.fed_tax_id_9[3] <> '-', (UNSIGNED4)L.fed_tax_id_9, (UNSIGNED4)(L.fed_tax_id_9[1..2] + L.fed_tax_id_9[4..10]));
SELF.current := IF(L.record_type = 'C' AND NTYP = '1', TRUE, FALSE);
END;

from_corporate_1 := NORMALIZE(Corp_Seq, 2, Translate_Corporate_to_BHF(LEFT, COUNTER, '1'));
from_corporate_2 := NORMALIZE(Corp_Seq(prior_name <> '', stringlib.stringfind(prior_name, '0000000000', 1) = 0), 2, Translate_Corporate_to_BHF(LEFT, COUNTER, '2'));
// Filter out secondary records with a blank address
from_corporate_combined := from_corporate_1(source_type<>'') + from_corporate_2(source_type<>'');
from_corporate := DEDUP(from_corporate_combined, orig_id, company_name, zip, prim_range, prim_name, ALL);

ut.MAC_Sequence_Records(from_corporate, split_id, from_corporate_seq)

// Group by original id and name type
from_corporate_dist := DISTRIBUTE(from_corporate_seq, hash(orig_id));
from_corporate_sort := SORT(from_corporate_dist, orig_id, ntyp, LOCAL);
from_corporate_grpd := GROUP(from_corporate_sort, orig_id, ntyp, LOCAL);
from_corporate_grpd_sort := SORT(from_corporate_grpd, split_id);

Layout_BHF_Local SetGroupId(Layout_BHF_Local L, Layout_BHF_Local R) := TRANSFORM
SELF.group1_id := IF(L.group1_id <> 0, L.group1_id, R.split_id);
SELF := R;
END;

// Set group id for primary name and addesses, prior name and addresses
from_corporate_iter := GROUP(ITERATE(from_corporate_grpd_sort, SetGroupId(LEFT, RIGHT)));

// Calculate stat to determine count by group_id
Layout_Group_List := RECORD
from_corporate_iter.group1_id;
END;

corp_group_list := TABLE(from_corporate_iter, Layout_Group_List);

Layout_Group_Stat := RECORD
corp_group_list.group1_id;
cnt := COUNT(GROUP);
END;

corp_group_stat := TABLE(corp_group_list, Layout_Group_Stat, group1_id);

// Clean single group ids and format
Business_Header.Layout_Business_Header FormatToBHF(Layout_BHF_Local L, Layout_Group_Stat R) := TRANSFORM
SELF.group1_id := R.group1_id;
SELF := L;
END;

corp_group_clean := JOIN(from_corporate_iter,
                         corp_group_stat(cnt > 1),
                         LEFT.group1_id = RIGHT.group1_id,
                         FormatToBHF(LEFT, RIGHT),
                         LEFT OUTER,
                         LOOKUP);

// Rollup
Business_Header.Layout_Business_Header RollupCorp(Business_Header.Layout_Business_Header L, Business_Header.Layout_Business_Header R) := TRANSFORM
SELF.dt_first_seen := 
            ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
		    ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
SELF.dt_last_seen := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
SELF.company_name := IF(L.company_name = '', R.company_name, L.company_name);
SELF.group1_id := IF(L.group1_id = 0, R.group1_id, L.group1_id);
SELF.vendor_id := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
                     L.vendor_id = '', R.vendor_id, L.vendor_id);
SELF.source_group := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
                     L.source_group = '', R.source_group, L.source_group);
SELF.phone := IF(L.phone = 0, R.phone, L.phone);
SELF.phone_score := IF(L.phone = 0, R.phone_score, L.phone_score);
SELF.fein := IF(L.fein = 0, R.fein, L.fein);
SELF.prim_range := IF(l.prim_range = '' AND l.zip4 = 0, r.prim_range, l.prim_range);
SELF.predir := IF(l.predir = '' AND l.zip4 = 0, r.predir, l.predir);
SELF.prim_name := IF(l.prim_name = '' AND l.zip4 = 0, r.prim_name, l.prim_name);
SELF.addr_suffix := IF(l.addr_suffix = '' AND l.zip4 = 0, r.addr_suffix, l.addr_suffix);
SELF.postdir := IF(l.postdir = '' AND l.zip4 = 0, r.postdir, l.postdir);
SELF.unit_desig := IF(l.unit_desig = ''AND l.zip4 = 0, r.unit_desig, l.unit_desig);
SELF.sec_range := IF(l.sec_range = '' AND l .zip4 = 0, r.sec_range, l.sec_range);
SELF.city := IF(l.city = '' AND l.zip4 = 0, r.city, l.city);
SELF.state := IF(l.state = '' AND l.zip4 = 0, r.state, l.state);
SELF.zip := IF(l.zip = 0 AND l.zip4 = 0, r.zip, l.zip);
SELF.zip4 := IF(l.zip4 = 0, r.zip4, l.zip4);
SELF.county := IF(l.county = '' AND l.zip4 = 0, r.county, l.county);
SELF.msa := IF(l.msa = '' AND l.zip4 = 0, r.msa, l.msa);
SELF.geo_lat := IF(l.geo_lat = '' AND l.zip4 = 0, r.geo_lat, l.geo_lat);
SELF.geo_long := IF(l.geo_long = '' AND l.zip4 = 0, r.geo_long, l.geo_long);
SELF := L;
END;

corp_clean_dist := DISTRIBUTE(corp_group_clean,
                    HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));
corp_clean_sort := SORT(corp_clean_dist, zip, prim_range, prim_name, source_group, company_name,
                    IF(sec_range <> '', 0, 1), sec_range,
                    IF(phone <> 0, 0, 1), phone,
                    IF(fein <> 0, 0, 1), fein,
                    dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);
corp_clean_rollup := ROLLUP(corp_clean_sort,
			        left.zip = right.zip and
			          left.prim_name = right.prim_name and
			          left.prim_range = right.prim_range and
                      left.source_group = right.source_group and
			          left.company_name = right.company_name and
			          (right.sec_range = '' OR left.sec_range = right.sec_range) and
                      (right.phone = 0 OR left.phone = right.phone) and
			          (right.fein = 0 OR left.fein = right.fein),
                    RollupCorp(LEFT, RIGHT),
                    LOCAL) : PERSIST('TMTEMP::Corp_Company_Rollup');

EXPORT Corp4_As_Business_Header := corp_clean_rollup;