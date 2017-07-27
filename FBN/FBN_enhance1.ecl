IMPORT FBN, Gong, UT, Business_Header;

// Add Unique Record ID and Seisint ID to FBN File
Layout_FBN AddIDFields(Layout_FBN_In L) := TRANSFORM
SELF.bdid := 0;
SELF.did := 0;
SELF.phone10 := Business_Header.CleanPhone(L.phone10);
SELF.new_fed_tax_id := L.fed_tax_id;
SELF := L;
END;

FBN_Init := PROJECT(File_FBN_In, AddIDFields(LEFT));

// Group records by location_cd, filing_num, filing_dt
FBN_Dist := DISTRIBUTE(FBN_Init, HASH(file_st, filing_num, filing_dt));
FBN_Sort := SORT(FBN_Dist, file_st, filing_num, filing_dt,
                                   MAP(name_typ = 'B' => 1,
                                       name_typ = 'O' => 2,
                                       name_typ = 'R' => 3,
                                       name_typ = 'A' => 4,
                                       name_typ = 'L' => 5,
                                       name_typ = 'W' => 6,
                                       7),
                                   IF(orig_zip='', 1, 0),
                                   LOCAL);

FBN_Grpd := GROUP(FBN_Sort, file_st, filing_num, filing_dt, LOCAL);

// Iterate through group to Propagate Address Info
Layout_FBN PropagateAddress(Layout_FBN L, Layout_FBN R) := TRANSFORM
SELF.prim_range := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.prim_range, R.prim_range);
SELF.predir := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.predir, R.predir);
SELF.prim_name := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.prim_name, R.prim_name);
SELF.addr_suffix := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.addr_suffix, R.addr_suffix);
SELF.postdir := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.postdir, R.postdir);
SELF.unit_desig := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.unit_desig, R.unit_desig);
SELF.sec_range := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.sec_range, R.sec_range);
SELF.p_city_name := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.p_city_name, R.p_city_name);
SELF.v_city_name := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.v_city_name, R.v_city_name);
SELF.st := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.st, R.st);
SELF.zip5 := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.zip5, R.zip5);
SELF.zip4 := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.zip4, R.zip4);
SELF.cart := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.cart, R.cart);
SELF.cr_sort_sz := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.cr_sort_sz, R.cr_sort_sz);
SELF.lot := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.lot, R.lot);
SELF.lot_order := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.lot_order, R.lot_order);
SELF.dpbc := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.dpbc, R.dpbc);
SELF.chk_digit := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.chk_digit, R.chk_digit);
SELF.rec_type := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.rec_type, R.rec_type);
SELF.ace_fips_st := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.ace_fips_st, R.ace_fips_st);
SELF.county := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.county, R.county);
SELF.geo_lat := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.geo_lat, R.geo_lat);
SELF.geo_long := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.geo_long, R.geo_long);
SELF.msa := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.msa, R.msa);
SELF.geo_blk := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.geo_blk, R.geo_blk);
SELF.geo_match := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.geo_match, R.geo_match);
SELF.err_stat := IF((R.street='' OR R.Street[1..4]='SAME') AND R.orig_zip = '', L.err_stat, R.err_stat);
SELF := R;
END;

FBN_Propagate_Addr := GROUP(ITERATE(FBN_Grpd, PropagateAddress(LEFT, RIGHT)));

// Enhance Phone Numbers
Gong.MAC_Enhance_Phones(FBN_Propagate_Addr, phone10, st, p_city_name, zip5, FBN_Phone_Enhanced)

EXPORT FBN_enhance1 := FBN_Phone_Enhanced : PERSIST('FBN::FBN_enhance1');