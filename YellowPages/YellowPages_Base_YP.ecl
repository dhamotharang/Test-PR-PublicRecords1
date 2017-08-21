IMPORT Gong_Neustar, ut, cellphone, Risk_Indicators, mdr;

EXPORT YellowPages_Base_YP(
   string																	              pversion
	,dataset(Gong_Neustar.Layout_Gong_Did               )	pGongFull = Gong_Neustar.File_Gong_full
	,dataset(YellowPages.Layout_YellowPages_Base_v2_bip	)	pYp				= CleanedInputAID(pversion)

) :=
function

Layout_Gong_Slim := RECORD
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
END;

// Initialize Gong Match file
Layout_Gong_Slim InitGongMatch(pGongFull L) := TRANSFORM
	SELF := L;
END;

Gong_Match_Init := PROJECT(pGongFull(listing_type_bus<>'', listed_name <> '', err_stat[1]='S'), InitGongMatch(LEFT));
//COUNT(Gong_Match_Init);

// Clean up area code field in phone numbers for enhancement
STRING10 FixPhone(STRING10 phone) :=
  MAP(LENGTH(TRIM(phone)) = 10 AND phone[1..3] IN ['000','   ','0  ','  0'] =>
         '000' + phone[4..10],
      phone);

// Add record id to Yellow Pages for deduping and project to common base
Layout_YellowPages_Seq := RECORD
	INTEGER8 record_id := 0;
	RECORDOF(pYp);
END;

Layout_YellowPages_Seq InitYellowPagesMatch(pYp L) := TRANSFORM
	SELF.phone10 := FixPhone(L.orig_phone10);
	/*SELF.address_override := MAP(L.err_stat[1] = 'E' AND L.n_err_stat[1] = 'S' => 'N',
                       L.err_stat[1] = 'E' AND L.nn_err_stat[1] = 'S' => 'X',
                       '');*/
	SELF.phone_override := IF(L.orig_phone10 <> FixPhone(L.orig_phone10), '?', '');
	// Temporary fix for Bob
	SELF.bus_name_flag := IF(L.bus_name_flag = 'Y', 'B', L.bus_name_flag);
	SELF.source := mdr.sourceTools.src_Yellow_Pages;
	self.suffix := L.suffix;
	SELF := L;
	self	:=	[];
END;

YellowPages_Init := PROJECT(pYp, InitYellowPagesMatch(LEFT));

ut.MAC_Sequence_Records(YellowPages_Init, record_id, YellowPages_Seq);
//COUNT(YellowPages_Seq);

// Enhance Phone Number Area Codes
//Gong.MAC_Enhance_Phones(YellowPages_Seq, phone10, st, p_city_name, zip, YellowPages_Seq_Enhanced)

// Join YellowPage Listings which did not clean to Gong by phone
Gong_Match_Phone_Dist := DISTRIBUTE(Gong_Match_Init(phone10<>''), HASH(phone10));
//Yellow_Pages_Phone_Dist := DISTRIBUTE(YellowPages_Seq_Enhanced(phone10<>'', err_stat[1]<>'S'), HASH(phone10));
Yellow_Pages_Phone_Dist := DISTRIBUTE(YellowPages_Seq(phone10<>'', err_stat[1]<>'S'), HASH(phone10));

// Replace YellowPage Listing address with Gong Address
Layout_YellowPages_Seq MatchYP(Layout_Gong_Slim L, Layout_YellowPages_Seq R) := TRANSFORM
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
	SELF.address_override := 'G';
	SELF := R;
END;

YellowPages_Phone := JOIN(Gong_Match_Phone_Dist,
                          Yellow_Pages_Phone_Dist,
                          LEFT.phone10 = RIGHT.phone10 AND
                            ut.CompanySimilar100((STRING125)LEFT.listed_name, RIGHT.business_name) <= 20,
                          MatchYP(LEFT, RIGHT),
                          LOCAL);

YellowPages_Phone_Dedup := DEDUP(YellowPages_Phone, record_id, ALL);
//COUNT(YellowPages_Phone_Dedup);

// Join YellowPage to Gong by Primary Address
Gong_Match_Primary_Addr_Dist := DISTRIBUTE(Gong_Match_Init((INTEGER)z5<>0, prim_name<>''), HASH(z5, prim_name, prim_range));
YellowPages_Addr_Dist := DISTRIBUTE(YellowPages_Seq(err_stat[1]<>'S', (INTEGER)zip<>0, prim_name<>''), HASH(zip, prim_name, prim_range));

YellowPages_Addr_Primary := JOIN(Gong_Match_Primary_Addr_Dist,
                                 YellowPages_Addr_Dist,
                                 LEFT.z5 = RIGHT.zip AND
                                   LEFT.prim_name = RIGHT.prim_name AND
                                   LEFT.prim_range = RIGHT.prim_range AND
                                   ut.NNEQ(LEFT.sec_range, RIGHT.sec_range) AND
                                   ut.CompanySimilar100((STRING125)LEFT.listed_name, RIGHT.business_name) <= 20,
                                 MatchYP(LEFT, RIGHT),
                                 LOCAL);

//COUNT(YellowPages_Addr_Primary);

// Join YellowPages to Gong by Vanity Address
Gong_Match_Vanity_Addr_Dist := DISTRIBUTE(Gong_Match_Init((INTEGER)z5<>0, v_prim_name<>'', v_prim_name <> prim_name), HASH(z5, v_prim_name, prim_range));


YellowPages_Addr_Vanity := JOIN(Gong_Match_Vanity_Addr_Dist,
                                 YellowPages_Addr_Dist,
                                 LEFT.z5 = RIGHT.zip AND
                                   LEFT.v_prim_name = RIGHT.prim_name AND
                                   LEFT.prim_range = RIGHT.prim_range AND
                                   ut.NNEQ(LEFT.sec_range, RIGHT.sec_range) AND
                                   ut.CompanySimilar100((STRING125)LEFT.listed_name, RIGHT.business_name) <= 20,
                                 MatchYP(LEFT, RIGHT),
                                 LOCAL);

//COUNT(YellowPages_Addr_Vanity);

YellowPages_Addr_Combined := YellowPages_Addr_Primary + YellowPages_Addr_Vanity;
YellowPages_Addr_Dedup := DEDUP(YellowPages_Addr_Combined, record_id, ALL);

//COUNT(YellowPages_Addr_Dedup);

YellowPages_Addr_Phone := YellowPages_Addr_Dedup + YellowPages_Phone_Dedup;
YellowPages_Addr_Phone_Dedup := DEDUP(YellowPages_Addr_Phone, record_id, ALL);

//COUNT(YellowPages_Addr_Phone_Dedup);

// Combine Updated records with full file and Dedup to keep updated records
YellowPages_Combined := YellowPages_Seq + YellowPages_Addr_Phone_Dedup;
YellowPages_Combined_Dist := DISTRIBUTE(YellowPages_Combined, HASH(record_id));
YellowPages_Combined_Sort := SORT(YellowPages_Combined_Dist, record_id, IF(address_override='G', 0, 1), LOCAL);
YellowPages_Combined_Dedup := DEDUP(YellowPages_Combined_Sort, record_id, LOCAL);

//COUNT(YellowPages_Combined_Dedup);

Layout_YellowPages_Seq InitYellowPagesType(Layout_YellowPages_Seq L) := TRANSFORM
	SELF.phone_override := IF(L.phone_override = '?' AND L.phone10[1..3] <> '000', 'N', '');
	SELF := L;
END;

YellowPages_Type_Init := PROJECT(YellowPages_Combined_Dedup, InitYellowPagesType(LEFT));


//-----------------------------------------------------------------------------------------------------------------------
//add phonetype to yellow pages 
YellowPages.NPA_PhoneType(YellowPages_Type_Init,phone10,phoneType,appnd_YellowPages_Type_Init);

YellowPages_Type_Addr_Dist := DISTRIBUTE(appnd_YellowPages_Type_Init(phone_type='', (INTEGER)zip<>0, prim_name<>''), HASH(zip, prim_name, prim_range));
//COUNT(YellowPages_Type_Addr_Dist);

//-----------------------------------------------------------------------------------------------------------------------
//add phonetype to gong file
YellowPages.NPA_PhoneType(Gong_Match_Primary_Addr_Dist,phone10,phoneType,appnd_Gong_Match_Primary_Addr_Dist);

// Replace YellowPage Listing address with Gong Address
Layout_YellowPages_Seq MatchYPPhone(appnd_Gong_Match_Primary_Addr_Dist L, YellowPages_Type_Addr_Dist R) := TRANSFORM
	SELF.phone10 := IF(R.phone10 <> L.phone10, L.phone10, R.phone10);
	SELF.phone_override := IF(R.phone10 <> L.phone10, 'G', R.phone_override);
	SELF.phone_type := IF(R.phone10 <> L.phone10, L.phoneType, R.phone_type);
	SELF := R;
END;

YellowPages_Type_Addr_Primary := JOIN(appnd_Gong_Match_Primary_Addr_Dist,
                                      YellowPages_Type_Addr_Dist,
                                      LEFT.z5 = RIGHT.zip AND
                                        LEFT.prim_name = RIGHT.prim_name AND
                                        LEFT.prim_range = RIGHT.prim_range AND
                                        ut.NNEQ(LEFT.sec_range, RIGHT.sec_range) AND
                                        ut.CompanySimilar100((STRING125)LEFT.listed_name, RIGHT.business_name) <= 20,
                                      MatchYPPhone(LEFT, RIGHT),
                                      LOCAL);

YellowPages_Type_Primary_Dedup := DEDUP(YellowPages_Type_Addr_Primary, record_id, ALL);

// Combine Updated records with full file and Dedup to keep updated records
YellowPages_Type_Combined := YellowPages_Type_Init + YellowPages_Type_Primary_Dedup;
YellowPages_Type_Combined_Dist := DISTRIBUTE(YellowPages_Type_Combined, HASH(record_id));
YellowPages_Type_Combined_Sort := SORT(YellowPages_Type_Combined_Dist, record_id, IF(phone_override = 'G', 0, 1), LOCAL);
YellowPages_Type_Combined_Dedup := DEDUP(YellowPages_Type_Combined_Sort, record_id, LOCAL);

//COUNT(YellowPages_Type_Combined_Dedup);

// Project to Base Format
YellowPages.Layout_YellowPages_Base_V2_bip FormatYPBase(Layout_YellowPages_Seq L) := TRANSFORM
	SELF := L;
END;

returndataset 			:= PROJECT(YellowPages_Type_Combined_Dedup, FormatYPBase(LEFT)) : PERSIST(persistnames().YellowPagesBaseYP);

return returndataset;

end;