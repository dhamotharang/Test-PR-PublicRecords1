IMPORT Gong_Neustar, ut, cellphone, Risk_indicators,mdr;

EXPORT YellowPages_Base_Gong(
   string																	  pversion
  ,dataset(Gong_Neustar.Layout_Gong_Did   )	pGongFull = Gong_Neustar.File_Gong_full
	,dataset(Layout_YellowPages_Base_V2_bip	)	pYpBase		= YellowPages.YellowPages_Base_YP(pversion)

) :=
function

// Filter off the historical YP records
dYpBase := pYpBase(record_type <> 'H');

Layout_Gong_Slim := RECORD
string1           listing_type_gov;
string11          filedate;
string120         listed_name;
string10          phone10;
string10          prim_range; 
string2           predir;
string28          prim_name;
string4           suffix;
string2           postdir;
string10          unit_desig;
string8           sec_range;
string25          p_city_name;
string28          v_prim_name;
string25          v_city_name;
string2           st;
string5           z5;
string4           z4;
string4           cart;
string1           cr_sort_sz;
string4           lot;
string1           lot_order;
string2           dpbc;
string1           chk_digit;
string2           rec_type;
string5           county_code;
string10          geo_lat;
string11          geo_long;
string4           msa;
string7           geo_blk;
string1           geo_match;
string4           err_stat;
string5           name_prefix;
string20          name_first;
string20          name_middle;
string20          name_last;
string5           name_suffix;
END;

// Initialize Gong Match file
Layout_Gong_Slim InitGongMatch(pGongFull L) := TRANSFORM
SELF := L;
END;

Gong_Match_Init := PROJECT(pGongFull(listing_type_bus<>'', listed_name <> '', publish_code IN ['P','U']), InitGongMatch(LEFT));

// Keep Gong Records which do not match Yellow Pages
// Join YellowPage Listings to Gong by phone
Gong_Match_Phone_Dist := DISTRIBUTE(Gong_Match_Init(phone10<>''), HASH(phone10));
Yellow_Pages_Phone_Dist := DISTRIBUTE(dYpBase(phone10<>''), HASH(phone10));

Layout_Gong_Slim MatchGong(Layout_Gong_Slim L, YellowPages.Layout_YellowPages_Base_V2_bip R) := TRANSFORM
SELF := L;
END;

GongToYP_Phone_NoMatch := JOIN(Gong_Match_Phone_Dist,
                               Yellow_Pages_Phone_Dist,
                               LEFT.phone10 = RIGHT.phone10 AND
                                 ut.CompanySimilar100((STRING125)LEFT.listed_name, RIGHT.business_name) <= 20,
                               MatchGong(LEFT, RIGHT),
                               LEFT ONLY,
                               LOCAL);

OUTPUT(COUNT(GongToYP_Phone_NoMatch), NAMED('COUNT_GongToYP_Phone_NoMatch_'+pversion));

// Join YellowPage to Gong by Primary Address
GongToYP_Phone_NoMatch_Dist := DISTRIBUTE(GongToYP_Phone_NoMatch((INTEGER)z5<>0, prim_name<>''), HASH(z5, prim_name, prim_range));
YellowPages_Addr_Dist := DISTRIBUTE(dYpBase((INTEGER)zip<>0, prim_name<>''), HASH(zip, prim_name, prim_range));

GongToYP_Addr_Primary_NoMatch := JOIN(GongToYP_Phone_NoMatch_Dist,
                                      YellowPages_Addr_Dist,
                                      LEFT.z5 = RIGHT.zip AND
                                        LEFT.prim_name = RIGHT.prim_name AND
                                        LEFT.prim_range = RIGHT.prim_range AND
                                        ut.NNEQ(LEFT.sec_range, RIGHT.sec_range) AND
                                        ut.CompanySimilar100((STRING125)LEFT.listed_name, RIGHT.business_name) <= 20,
                                      MatchGong(LEFT, RIGHT),
                                      LEFT ONLY,
                                      LOCAL);

OUTPUT(COUNT(GongToYP_Addr_Primary_NoMatch), NAMED('COUNT_GongToYP_Addr_Primary_NoMatch_'+pversion));

// Join YellowPages to Gong by Vanity Address
GongToYP_Addr_Primary_NoMatch_Dist := DISTRIBUTE(GongToYP_Addr_Primary_NoMatch((INTEGER)z5<>0, v_prim_name<>'', v_prim_name <> prim_name), HASH(z5, v_prim_name, prim_range));


GongToYP_Addr_Vanity_NoMatch := JOIN(GongToYP_Addr_Primary_NoMatch_Dist,
                                     YellowPages_Addr_Dist,
                                     LEFT.z5 = RIGHT.zip AND
                                       LEFT.v_prim_name = RIGHT.prim_name AND
                                       LEFT.prim_range = RIGHT.prim_range AND
                                       ut.NNEQ(LEFT.sec_range, RIGHT.sec_range) AND
                                       ut.CompanySimilar100((STRING125)LEFT.listed_name, RIGHT.business_name) <= 20,
                                     MatchGong(LEFT, RIGHT),
                                     LEFT ONLY,
                                     LOCAL);

OUTPUT(COUNT(GongToYP_Addr_Vanity_NoMatch), NAMED('COUNT_GongToYP_Addr_Vanity_NoMatch_'+pversion));

// Create final output
GongToYP_Addr_NoMatch := GongToYP_Addr_Primary_NoMatch((INTEGER)z5<>0, v_prim_name<>'', v_prim_name = prim_name) + GongToYP_Addr_Vanity_NoMatch;
//append phone type
YellowPages.NPA_PhoneType(GongToYP_Addr_NoMatch,phone10,phoneType,appnd_GongToYP_Addr_NoMatch);

// Format non-matched Gong Business Records as pseudo-YellowPage records
YellowPages.Layout_YellowPages_Base_V2_bip FormatGongToYP(appnd_GongToYP_Addr_NoMatch L) := TRANSFORM
SELF.primary_key := '';
SELF.business_name := L.listed_name;
SELF.orig_street := StringLib.StringCleanSpaces(TRIM(L.prim_range) + ' ' + TRIM(L.predir) + ' ' + TRIM(L.prim_name) + ' ' +
                    TRIM(L.suffix) + ' ' + TRIM(L.postdir) + ' ' + TRIM(L.unit_desig) + ' ' +
                    TRIM(L.sec_range));
SELF.orig_city := L.p_city_name;
SELF.orig_state := L.st;
SELF.orig_zip := L.z5 + L.z4;
SELF.orig_latitude := L.geo_lat;
SELF.orig_longitude := L.geo_long;
SELF.orig_phone10 := L.phone10;
SELF.phone10 := L.phone10;
SELF.heading_string := '';
SELF.sic_code := '';
SELF.toll_free_indicator := '';
SELF.fax_indicator := '';
SELF.pub_date := L.filedate[1..8];
SELF.index_value := '';
SELF.naics_code := '';
SELF.web_address := '';
SELF.email_address := '';
SELF.employee_code := '';
SELF.executive_title := '';
SELF.executive_name := '';
SELF.derog_legal_indicator := '';
SELF.record_type := '';
SELF.addr_suffix_flag := '';
SELF.prim_range := L.prim_range;
SELF.predir := L.predir;
SELF.prim_name := L.prim_name;
SELF.suffix := L.suffix;
SELF.postdir := L.postdir;
SELF.unit_desig := L.unit_desig;
SELF.sec_range := L.sec_range;
SELF.p_city_name := L.p_city_name;
SELF.v_city_name := L.v_city_name;
SELF.st := L.st;
SELF.zip := L.z5;
SELF.zip4 := L.z4;
SELF.cart := L.cart;
SELF.cr_sort_sz := L.cr_sort_sz;
SELF.lot := L.lot;
SELF.lot_order := L.lot_order;
SELF.dpbc := L.dpbc;
SELF.chk_digit := L.chk_digit;
SELF.rec_type := L.rec_type;
SELF.ace_fips_st := L.county_code[1..2];
SELF.county := L.county_code[3..5];
SELF.geo_lat := L.geo_lat;
SELF.geo_long := L.geo_long;
SELF.msa := L.msa;
SELF.geo_blk := L.geo_blk;
SELF.geo_match := L.geo_match;
SELF.err_stat := L.err_stat;
SELF.bus_name_flag := '';
SELF.aka_name := '';
SELF.title := L.name_prefix;
SELF.fname := L.name_first;
SELF.mname := L.name_middle;
SELF.lname := L.name_last;
SELF.name_suffix := L.name_suffix;
SELF.name_score := '';
SELF.exec_title := '';
SELF.exec_fname := '';
SELF.exec_mname := '';
SELF.exec_lname := '';
SELF.exec_name_suffix := '';
SELF.exec_name_score := '';
SELF.nn_fix_city := '';
SELF.nn_fix_state := '';
SELF.nn_fix_zip := '';
SELF.nn_fix_ace_flag := '';
SELF.nn_fix_alt_city1 := '';
SELF.nn_fix_alt_zip1 := '';
SELF.nn_fix_alt_city2 := '';
SELF.nn_fix_alt_zip2 := '';
SELF.n_fix_state := '';
SELF.address_override := '';
SELF.phone_override := '';    // 'G' if replaced from Gong phone
SELF.phone_type := L.phoneType;
SELF.source := IF(L.listing_type_gov <> ''
                   OR ut.GovName(ut.CleanCompany(L.listed_name)), MDR.sourceTools.src_Gong_Government, MDR.sourceTools.src_Gong_Business);
self		:= [];

END;

GongToYP_Formatted := PROJECT(appnd_GongToYP_Addr_NoMatch, FormatGongToYP(LEFT));
OUTPUT(COUNT(GongToYP_Formatted), NAMED('COUNT_GongToYP_Formatted_'+pversion));

returndataset := GongToYP_Formatted : PERSIST(persistnames().YellowPagesBaseGong);

return returndataset;

end;