Import Didville,Doxie, address, ProfileBooster;

EXPORT Transforms := MODULE

//generate final output - get relatives
EXPORT Didville.Layouts.out_with_seq_rec get_out_rel(Didville.Layouts.out_with_seq_rec l, Didville.Layouts.best_with_email_profile_rec r,
                                    boolean CompareInputAddrWithRel = false,boolean CompareInputAddrNameWithRel = false,
                                    unsigned cnt) := transform

    self.rel_depth_1 := if(cnt=1, (string)r.depth, l.rel_depth_1);
    self.rel_first_name_1 := if(cnt=1, r.fname, l.rel_first_name_1);
    self.rel_middle_name_1 := if(cnt=1, r.mname, l.rel_middle_name_1);
    self.rel_last_name_1 := if(cnt=1, r.lname, l.rel_last_name_1);
    self.rel_address_1 := if(cnt=1, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                                    l.rel_address_1);
    self.rel_city_1 := if(cnt=1, r.city_name, l.rel_city_1);
    self.rel_state_1 := if(cnt=1, r.st, l.rel_state_1);
    self.rel_zipcode_1 := if(cnt=1, r.zip + r.zip4, l.rel_zipcode_1);
    self.rel_phone_1 := if(cnt=1, r.phone, l.rel_phone_1);

    self.rel_ssn_1   := if(cnt=1, r.ssn, l.rel_ssn_1);
    self.rel_dob_1   := if(cnt=1, if(r.dob=0, '',(string) r.dob),
                                  l.rel_dob_1);
    self.rel_dod_1   := if(cnt=1, r.dod, l.rel_dod_1);
    self.rel_dm_deceased_flag_1 := if(cnt=1,r.dod <> '', l.rel_dm_deceased_flag_1);
    self.rel_relationship_1 := if(cnt=1, r.relationship, l.rel_relationship_1);
    self.rel_relationship_type_1 := if(cnt=1, r.relationship_type, l.rel_relationship_type_1);
    self.rel_relationship_confidence_1 := if(cnt=1, r.relationship_confidence, l.rel_relationship_confidence_1);

    self.rel_depth_2 := if(cnt=2, (string)r.depth, l.rel_depth_2);
    self.rel_first_name_2 := if(cnt=2, r.fname, l.rel_first_name_2);
    self.rel_middle_name_2 := if(cnt=2, r.mname, l.rel_middle_name_2);
    self.rel_last_name_2 := if(cnt=2, r.lname, l.rel_last_name_2);
    self.rel_address_2 := if(cnt=2, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                                    l.rel_address_2);
    self.rel_city_2 := if(cnt=2, r.city_name, l.rel_city_2);
    self.rel_state_2 := if(cnt=2, r.st, l.rel_state_2);
    self.rel_zipcode_2 := if(cnt=2, r.zip + r.zip4, l.rel_zipcode_2);
    self.rel_phone_2 := if(cnt=2, r.phone, l.rel_phone_2);
    self.rel_ssn_2   := if(cnt=2, r.ssn, l.rel_ssn_2);
    self.rel_dob_2   := if(cnt=2, if(r.dob=0, '',(string) r.dob),
                                  l.rel_dob_2);
    self.rel_dod_2   := if(cnt=2, r.dod, l.rel_dod_2);
    self.rel_dm_deceased_flag_2 := if(cnt=2,r.dod <> '', l.rel_dm_deceased_flag_2);
    self.rel_relationship_2 := if(cnt=2, r.relationship, l.rel_relationship_2);
    self.rel_relationship_type_2 := if(cnt=2, r.relationship_type, l.rel_relationship_type_2);
    self.rel_relationship_confidence_2 := if(cnt=2, r.relationship_confidence, l.rel_relationship_confidence_2);

    self.rel_depth_3 := if(cnt=3, (string)r.depth, l.rel_depth_3);
    self.rel_first_name_3 := if(cnt=3, r.fname, l.rel_first_name_3);
    self.rel_middle_name_3 := if(cnt=3, r.mname, l.rel_middle_name_3);
    self.rel_last_name_3 := if(cnt=3, r.lname, l.rel_last_name_3);
    self.rel_address_3 := if(cnt=3, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                                    l.rel_address_3);
    self.rel_city_3 := if(cnt=3, r.city_name, l.rel_city_3);
    self.rel_state_3 := if(cnt=3, r.st, l.rel_state_3);
    self.rel_zipcode_3 := if(cnt=3, r.zip + r.zip4, l.rel_zipcode_3);
    self.rel_phone_3 := if(cnt=3, r.phone, l.rel_phone_3);
    self.rel_ssn_3   := if(cnt=3, r.ssn, l.rel_ssn_3);
    self.rel_dob_3   := if(cnt=3, if(r.dob=0, '',(string) r.dob),
                                  l.rel_dob_3);
    self.rel_dod_3   := if(cnt=3, r.dod, l.rel_dod_3);
    self.rel_dm_deceased_flag_3 :=if(cnt=3,r.dod <> '', l.rel_dm_deceased_flag_3);
    self.rel_relationship_3 := if(cnt=3, r.relationship, l.rel_relationship_3);
    self.rel_relationship_type_3 := if(cnt=3, r.relationship_type, l.rel_relationship_type_3);
    self.rel_relationship_confidence_3 := if(cnt=3, r.relationship_confidence, l.rel_relationship_confidence_3);

    self.rel_depth_4 := if(cnt=4, (string)r.depth, l.rel_depth_4);
    self.rel_first_name_4 := if(cnt=4, r.fname, l.rel_first_name_4);
    self.rel_middle_name_4 := if(cnt=4, r.mname, l.rel_middle_name_4);
    self.rel_last_name_4 := if(cnt=4, r.lname, l.rel_last_name_4);
    self.rel_address_4 := if(cnt=4, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                                    l.rel_address_4);
    self.rel_city_4 := if(cnt=4, r.city_name, l.rel_city_4);
    self.rel_state_4 := if(cnt=4, r.st, l.rel_state_4);
    self.rel_zipcode_4 := if(cnt=4, r.zip + r.zip4, l.rel_zipcode_4);
    self.rel_phone_4 := if(cnt=4, r.phone, l.rel_phone_4);
    self.rel_ssn_4   := if(cnt=4, r.ssn, l.rel_ssn_4);
    self.rel_dob_4   := if(cnt=4, if(r.dob=0, '',(string) r.dob),
                                  l.rel_dob_4);
    self.rel_dod_4   := if(cnt=4, r.dod, l.rel_dod_4);
    self.rel_dm_deceased_flag_4 := if(cnt=4,r.dod <> '', l.rel_dm_deceased_flag_4);
    self.rel_relationship_4 := if(cnt=4, r.relationship, l.rel_relationship_4);
    self.rel_relationship_type_4 := if(cnt=4, r.relationship_type, l.rel_relationship_type_4);
    self.rel_relationship_confidence_4 := if(cnt=4, r.relationship_confidence, l.rel_relationship_confidence_4);

    self.rel_depth_5 := if(cnt=5, (string)r.depth, l.rel_depth_5);
    self.rel_first_name_5 := if(cnt=5, r.fname, l.rel_first_name_5);
    self.rel_middle_name_5 := if(cnt=5, r.mname, l.rel_middle_name_5);
    self.rel_last_name_5 := if(cnt=5, r.lname, l.rel_last_name_5);
    self.rel_address_5 := if(cnt=5, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                                    l.rel_address_5);
    self.rel_city_5 := if(cnt=5, r.city_name, l.rel_city_5);
    self.rel_state_5 := if(cnt=5, r.st, l.rel_state_5);
    self.rel_zipcode_5 := if(cnt=5, r.zip + r.zip4, l.rel_zipcode_5);
    self.rel_phone_5 := if(cnt=5, r.phone, l.rel_phone_5);
    self.rel_ssn_5   := if(cnt=5, r.ssn, l.rel_ssn_5);
    self.rel_dob_5   := if(cnt=5, if(r.dob=0, '',(string) r.dob),
                                  l.rel_dob_5);
    self.rel_dod_5   := if(cnt=5, r.dod, l.rel_dod_5);
    self.rel_dm_deceased_flag_5 := if(cnt=5,r.dod <> '', l.rel_dm_deceased_flag_5);
    self.rel_relationship_5 := if(cnt=5, r.relationship, l.rel_relationship_5);
    self.rel_relationship_type_5 := if(cnt=5, r.relationship_type, l.rel_relationship_type_5);
    self.rel_relationship_confidence_5 := if(cnt=5, r.relationship_confidence, l.rel_relationship_confidence_5);

    self.rel_depth_6 := if(cnt=6, (string)r.depth, l.rel_depth_6);
    self.rel_first_name_6 := if(cnt=6, r.fname, l.rel_first_name_6);
    self.rel_middle_name_6 := if(cnt=6, r.mname, l.rel_middle_name_6);
    self.rel_last_name_6 := if(cnt=6, r.lname, l.rel_last_name_6);
    self.rel_address_6 := if(cnt=6, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                                    l.rel_address_6);
    self.rel_city_6 := if(cnt=6, r.city_name, l.rel_city_6);
    self.rel_state_6 := if(cnt=6, r.st, l.rel_state_6);
    self.rel_zipcode_6 := if(cnt=6, r.zip + r.zip4, l.rel_zipcode_6);
    self.rel_phone_6 := if(cnt=6, r.phone, l.rel_phone_6);
    self.rel_ssn_6   := if(cnt=6, r.ssn, l.rel_ssn_6);
    self.rel_dob_6   := if(cnt=6, if(r.dob=0, '',(string) r.dob),
                                  l.rel_dob_6);
    self.rel_dod_6   := if(cnt=6, r.dod, l.rel_dod_6);
    self.rel_dm_deceased_flag_6 := if(cnt=6,r.dod <> '', l.rel_dm_deceased_flag_6);
    self.rel_relationship_6 := if(cnt=6, r.relationship, l.rel_relationship_6);
    self.rel_relationship_type_6 := if(cnt=6, r.relationship_type, l.rel_relationship_type_6);
    self.rel_relationship_confidence_6 := if(cnt=6, r.relationship_confidence, l.rel_relationship_confidence_6);

    self.rel_depth_7 := if(cnt=7, (string)r.depth, l.rel_depth_7);
    self.rel_first_name_7 := if(cnt=7, r.fname, l.rel_first_name_7);
    self.rel_middle_name_7 := if(cnt=7, r.mname, l.rel_middle_name_7);
    self.rel_last_name_7 := if(cnt=7, r.lname, l.rel_last_name_7);
    self.rel_address_7 := if(cnt=7, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                                    l.rel_address_7);
    self.rel_city_7 := if(cnt=7, r.city_name, l.rel_city_7);
    self.rel_state_7 := if(cnt=7, r.st, l.rel_state_7);
    self.rel_zipcode_7 := if(cnt=7, r.zip + r.zip4, l.rel_zipcode_7);
    self.rel_phone_7 := if(cnt=7, r.phone, l.rel_phone_7);
    self.rel_ssn_7   := if(cnt=7, r.ssn, l.rel_ssn_7);
    self.rel_dob_7   := if(cnt=7, if(r.dob=0, '',(string) r.dob),
                                  l.rel_dob_7);
    self.rel_dod_7   := if(cnt=7, r.dod, l.rel_dod_7);
    self.rel_dm_deceased_flag_7 := if(cnt=7,r.dod <> '', l.rel_dm_deceased_flag_7);
    self.rel_relationship_7 := if(cnt=7, r.relationship, l.rel_relationship_7);
    self.rel_relationship_type_7 := if(cnt=7, r.relationship_type, l.rel_relationship_type_7);
    self.rel_relationship_confidence_7 := if(cnt=7, r.relationship_confidence, l.rel_relationship_confidence_7);

    self.rel_depth_8 := if(cnt=8, (string)r.depth, l.rel_depth_8);
    self.rel_first_name_8 := if(cnt=8, r.fname, l.rel_first_name_8);
    self.rel_middle_name_8 := if(cnt=8, r.mname, l.rel_middle_name_8);
    self.rel_last_name_8 := if(cnt=8, r.lname, l.rel_last_name_8);
    self.rel_address_8 := if(cnt=8, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                                    l.rel_address_8);
    self.rel_city_8 := if(cnt=8, r.city_name, l.rel_city_8);
    self.rel_state_8 := if(cnt=8, r.st, l.rel_state_8);
    self.rel_zipcode_8 := if(cnt=8, r.zip + r.zip4, l.rel_zipcode_8);
    self.rel_phone_8 := if(cnt=8, r.phone, l.rel_phone_8);
    self.rel_ssn_8   := if(cnt=8, r.ssn, l.rel_ssn_8);
    self.rel_dob_8   := if(cnt=8, if(r.dob=0, '',(string) r.dob),
                                  l.rel_dob_8);
    self.rel_dod_8   := if(cnt=8, r.dod, l.rel_dod_8);
    self.rel_dm_deceased_flag_8 := if(cnt=8,r.dod <> '', l.rel_dm_deceased_flag_8);
    self.rel_relationship_8 := if(cnt=8, r.relationship, l.rel_relationship_8);
    self.rel_relationship_type_8 := if(cnt=8, r.relationship_type, l.rel_relationship_type_8);
    self.rel_relationship_confidence_8 := if(cnt=8, r.relationship_confidence, l.rel_relationship_confidence_8);

    self.rel_depth_9 := if(cnt=9, (string)r.depth, l.rel_depth_9);
    self.rel_first_name_9 := if(cnt=9, r.fname, l.rel_first_name_9);
    self.rel_middle_name_9 := if(cnt=9, r.mname, l.rel_middle_name_9);
    self.rel_last_name_9 := if(cnt=9, r.lname, l.rel_last_name_9);
    self.rel_address_9 := if(cnt=9, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                                    l.rel_address_9);
    self.rel_city_9 := if(cnt=9, r.city_name, l.rel_city_9);
    self.rel_state_9 := if(cnt=9, r.st, l.rel_state_9);
    self.rel_zipcode_9 := if(cnt=9, r.zip + r.zip4, l.rel_zipcode_9);
    self.rel_phone_9 := if(cnt=9, r.phone, l.rel_phone_9);
    self.rel_ssn_9   := if(cnt=9, r.ssn, l.rel_ssn_9);
    self.rel_dob_9   := if(cnt=9, if(r.dob=0, '',(string) r.dob),
                                  l.rel_dob_9);
    self.rel_dod_9   := if(cnt=9, r.dod, l.rel_dod_9);
    self.rel_dm_deceased_flag_9 := if(cnt=9,r.dod <> '', l.rel_dm_deceased_flag_9);
    self.rel_relationship_9 := if(cnt=9, r.relationship, l.rel_relationship_9);
    self.rel_relationship_type_9 := if(cnt=9, r.relationship_type, l.rel_relationship_type_9);
    self.rel_relationship_confidence_9 := if(cnt=9, r.relationship_confidence, l.rel_relationship_confidence_9);

    self.rel_depth_10 := if(cnt=10, (string)r.depth, l.rel_depth_10);
    self.rel_first_name_10 := if(cnt=10, r.fname, l.rel_first_name_10);
    self.rel_middle_name_10 := if(cnt=10, r.mname, l.rel_middle_name_10);
    self.rel_last_name_10 := if(cnt=10, r.lname, l.rel_last_name_10);
    self.rel_address_10 := if(cnt=10, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                                    l.rel_address_10);
    self.rel_city_10 := if(cnt=10, r.city_name, l.rel_city_10);
    self.rel_state_10 := if(cnt=10, r.st, l.rel_state_10);
    self.rel_zipcode_10 := if(cnt=10, r.zip + r.zip4, l.rel_zipcode_10);
    self.rel_phone_10 := if(cnt=10, r.phone, l.rel_phone_10);
    self.rel_ssn_10   := if(cnt=10, r.ssn, l.rel_ssn_10);
    self.rel_dob_10   := if(cnt=10, if(r.dob=0, '',(string) r.dob),
                                  l.rel_dob_10);
    self.rel_dod_10   := if(cnt=10, r.dod, l.rel_dod_10);
    self.rel_dm_deceased_flag_10 := if(cnt=10,r.dod <> '', l.rel_dm_deceased_flag_10);
    self.rel_relationship_10 := if(cnt=10, r.relationship, l.rel_relationship_10);
    self.rel_relationship_type_10 := if(cnt=10, r.relationship_type, l.rel_relationship_type_10);
    self.rel_relationship_confidence_10 := if(cnt=10, r.relationship_confidence, l.rel_relationship_confidence_10);

    self.RelAssocNeigh_Flag:='Y';

    rel_addr1_match := if (cnt=1,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ;
    rel_addr2_match := if (cnt=2,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ;
    rel_addr3_match := if (cnt=3,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ;
    rel_addr4_match := if (cnt=4,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ;
    rel_addr5_match := if (cnt=5,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ;
    rel_addr6_match := if (cnt=6,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ;
    rel_addr7_match := if (cnt=7,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ;
    rel_addr8_match := if (cnt=8,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ;
    rel_addr9_match := if (cnt=9,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ;
    rel_addr10_match := if (cnt=10,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5, false) ;
    self.input_addr_matched_rel := CompareInputAddrWithRel and
                 (l.input_addr_matched_rel OR
                 (rel_addr1_match or rel_addr2_match or rel_addr3_match or rel_addr4_match or rel_addr5_match or rel_addr6_match or rel_addr7_match or rel_addr8_match or rel_addr9_match or rel_addr10_match));

    rel_addr1_name_match := if (cnt=1,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ;
    rel_addr2_name_match := if (cnt=2,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ;
    rel_addr3_name_match := if (cnt=3,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ;
    rel_addr4_name_match := if (cnt=4,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ;
    rel_addr5_name_match := if (cnt=5,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ;
    rel_addr6_name_match := if (cnt=6,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ;
    rel_addr7_name_match := if (cnt=7,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ;
    rel_addr8_name_match := if (cnt=8,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ;
    rel_addr9_name_match := if (cnt=9,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ;
    rel_addr10_name_match := if (cnt=10,r.prim_range = l.prim_range and r.prim_name =l.prim_name and r.zip = l.z5 and r.lname = l.name_last, false) ;
    self.input_addr_name_matched_rel := CompareInputAddrNameWithRel and
                 (l.input_addr_name_matched_rel OR
                 (rel_addr1_name_match or rel_addr2_name_match or rel_addr3_name_match or rel_addr4_name_match or rel_addr5_name_match or rel_addr6_name_match or rel_addr7_name_match or rel_addr8_name_match or rel_addr9_name_match or rel_addr10_name_match));


    self.rel_title_1 := if(cnt=1, r.title, l.rel_title_1);
    self.rel_title_2 := if(cnt=2, r.title, l.rel_title_2);
    self.rel_title_3 := if(cnt=3, r.title, l.rel_title_3);
    self.rel_title_4 := if(cnt=4, r.title, l.rel_title_4);
    self.rel_title_5 := if(cnt=5, r.title, l.rel_title_5);
    self.rel_title_6 := if(cnt=6, r.title, l.rel_title_6);
    self.rel_title_7 := if(cnt=7, r.title, l.rel_title_7);
    self.rel_title_8 := if(cnt=8, r.title, l.rel_title_8);
    self.rel_title_9 := if(cnt=9, r.title, l.rel_title_9);
    self.rel_title_10 := if(cnt=10, r.title, l.rel_title_10);

    self.rel_name_suffix_1 := if(cnt=1, r.name_suffix, l.rel_name_suffix_1);
    self.rel_name_suffix_2 := if(cnt=2, r.name_suffix, l.rel_name_suffix_2);
    self.rel_name_suffix_3 := if(cnt=3, r.name_suffix, l.rel_name_suffix_3);
    self.rel_name_suffix_4 := if(cnt=4, r.name_suffix, l.rel_name_suffix_4);
    self.rel_name_suffix_5 := if(cnt=5, r.name_suffix, l.rel_name_suffix_5);
    self.rel_name_suffix_6 := if(cnt=6, r.name_suffix, l.rel_name_suffix_6);
    self.rel_name_suffix_7 := if(cnt=7, r.name_suffix, l.rel_name_suffix_7);
    self.rel_name_suffix_8 := if(cnt=8, r.name_suffix, l.rel_name_suffix_8);
    self.rel_name_suffix_9 := if(cnt=9, r.name_suffix, l.rel_name_suffix_9);
    self.rel_name_suffix_10 := if(cnt=10, r.name_suffix, l.rel_name_suffix_10);

    self.rel_email_1 := if(cnt=1, r.email, l.rel_email_1);
    self.rel_email_2 := if(cnt=2, r.email, l.rel_email_2);
    self.rel_email_3 := if(cnt=3, r.email, l.rel_email_3);
    self.rel_email_4 := if(cnt=4, r.email, l.rel_email_4);
    self.rel_email_5 := if(cnt=5, r.email, l.rel_email_5);
    self.rel_email_6 := if(cnt=6, r.email, l.rel_email_6);
    self.rel_email_7 := if(cnt=7, r.email, l.rel_email_7);
    self.rel_email_8 := if(cnt=8, r.email, l.rel_email_8);
    self.rel_email_9 := if(cnt=9, r.email, l.rel_email_9);
    self.rel_email_10 := if(cnt=10, r.email, l.rel_email_10);

    self.rel_donotmail_1 := if(cnt=1, r.donotmail, l.rel_donotmail_1);
    self.rel_donotmail_2 := if(cnt=2, r.donotmail, l.rel_donotmail_2);
    self.rel_donotmail_3 := if(cnt=3, r.donotmail, l.rel_donotmail_3);
    self.rel_donotmail_4 := if(cnt=4, r.donotmail, l.rel_donotmail_4);
    self.rel_donotmail_5 := if(cnt=5, r.donotmail, l.rel_donotmail_5);
    self.rel_donotmail_6 := if(cnt=6, r.donotmail, l.rel_donotmail_6);
    self.rel_donotmail_7 := if(cnt=7, r.donotmail, l.rel_donotmail_7);
    self.rel_donotmail_8 := if(cnt=8, r.donotmail, l.rel_donotmail_8);
    self.rel_donotmail_9 := if(cnt=9, r.donotmail, l.rel_donotmail_9);
    self.rel_donotmail_10 := if(cnt=10, r.donotmail, l.rel_donotmail_10);

    self.rel_ProspectAge_1 := if(cnt=1, r.ProspectAge, l.rel_ProspectAge_1);
    self.rel_ProspectAge_2 := if(cnt=2, r.ProspectAge, l.rel_ProspectAge_2);
    self.rel_ProspectAge_3 := if(cnt=3, r.ProspectAge, l.rel_ProspectAge_3);
    self.rel_ProspectAge_4 := if(cnt=4, r.ProspectAge, l.rel_ProspectAge_4);
    self.rel_ProspectAge_5 := if(cnt=5, r.ProspectAge, l.rel_ProspectAge_5);
    self.rel_ProspectAge_6 := if(cnt=6, r.ProspectAge, l.rel_ProspectAge_6);
    self.rel_ProspectAge_7 := if(cnt=7, r.ProspectAge, l.rel_ProspectAge_7);
    self.rel_ProspectAge_8 := if(cnt=8, r.ProspectAge, l.rel_ProspectAge_8);
    self.rel_ProspectAge_9 := if(cnt=9, r.ProspectAge, l.rel_ProspectAge_9);
    self.rel_ProspectAge_10 := if(cnt=10, r.ProspectAge, l.rel_ProspectAge_10);

    self.rel_ProspectGender_1 := if(cnt=1, r.ProspectGender, l.rel_ProspectGender_1);
    self.rel_ProspectGender_2 := if(cnt=2, r.ProspectGender, l.rel_ProspectGender_2);
    self.rel_ProspectGender_3 := if(cnt=3, r.ProspectGender, l.rel_ProspectGender_3);
    self.rel_ProspectGender_4 := if(cnt=4, r.ProspectGender, l.rel_ProspectGender_4);
    self.rel_ProspectGender_5 := if(cnt=5, r.ProspectGender, l.rel_ProspectGender_5);
    self.rel_ProspectGender_6 := if(cnt=6, r.ProspectGender, l.rel_ProspectGender_6);
    self.rel_ProspectGender_7 := if(cnt=7, r.ProspectGender, l.rel_ProspectGender_7);
    self.rel_ProspectGender_8 := if(cnt=8, r.ProspectGender, l.rel_ProspectGender_8);
    self.rel_ProspectGender_9 := if(cnt=9, r.ProspectGender, l.rel_ProspectGender_9);
    self.rel_ProspectGender_10 := if(cnt=10, r.ProspectGender, l.rel_ProspectGender_10);

    self.rel_ProspectMaritalStatus_1 := if(cnt=1, r.ProspectMaritalStatus, l.rel_ProspectMaritalStatus_1);
    self.rel_ProspectMaritalStatus_2 := if(cnt=2, r.ProspectMaritalStatus, l.rel_ProspectMaritalStatus_2);
    self.rel_ProspectMaritalStatus_3 := if(cnt=3, r.ProspectMaritalStatus, l.rel_ProspectMaritalStatus_3);
    self.rel_ProspectMaritalStatus_4 := if(cnt=4, r.ProspectMaritalStatus, l.rel_ProspectMaritalStatus_4);
    self.rel_ProspectMaritalStatus_5 := if(cnt=5, r.ProspectMaritalStatus, l.rel_ProspectMaritalStatus_5);
    self.rel_ProspectMaritalStatus_6 := if(cnt=6, r.ProspectMaritalStatus, l.rel_ProspectMaritalStatus_6);
    self.rel_ProspectMaritalStatus_7 := if(cnt=7, r.ProspectMaritalStatus, l.rel_ProspectMaritalStatus_7);
    self.rel_ProspectMaritalStatus_8 := if(cnt=8, r.ProspectMaritalStatus, l.rel_ProspectMaritalStatus_8);
    self.rel_ProspectMaritalStatus_9 := if(cnt=9, r.ProspectMaritalStatus, l.rel_ProspectMaritalStatus_9);
    self.rel_ProspectMaritalStatus_10 := if(cnt=10, r.ProspectMaritalStatus, l.rel_ProspectMaritalStatus_10);

    self.rel_ProspectEstimatedIncomeRange_1 := if(cnt=1, r.ProspectEstimatedIncomeRange, l.rel_ProspectEstimatedIncomeRange_1);
    self.rel_ProspectEstimatedIncomeRange_2 := if(cnt=2, r.ProspectEstimatedIncomeRange, l.rel_ProspectEstimatedIncomeRange_2);
    self.rel_ProspectEstimatedIncomeRange_3 := if(cnt=3, r.ProspectEstimatedIncomeRange, l.rel_ProspectEstimatedIncomeRange_3);
    self.rel_ProspectEstimatedIncomeRange_4 := if(cnt=4, r.ProspectEstimatedIncomeRange, l.rel_ProspectEstimatedIncomeRange_4);
    self.rel_ProspectEstimatedIncomeRange_5 := if(cnt=5, r.ProspectEstimatedIncomeRange, l.rel_ProspectEstimatedIncomeRange_5);
    self.rel_ProspectEstimatedIncomeRange_6 := if(cnt=6, r.ProspectEstimatedIncomeRange, l.rel_ProspectEstimatedIncomeRange_6);
    self.rel_ProspectEstimatedIncomeRange_7 := if(cnt=7, r.ProspectEstimatedIncomeRange, l.rel_ProspectEstimatedIncomeRange_7);
    self.rel_ProspectEstimatedIncomeRange_8 := if(cnt=8, r.ProspectEstimatedIncomeRange, l.rel_ProspectEstimatedIncomeRange_8);
    self.rel_ProspectEstimatedIncomeRange_9 := if(cnt=9, r.ProspectEstimatedIncomeRange, l.rel_ProspectEstimatedIncomeRange_9);
    self.rel_ProspectEstimatedIncomeRange_10 := if(cnt=10, r.ProspectEstimatedIncomeRange, l.rel_ProspectEstimatedIncomeRange_10);

    self.rel_ProspectCollegeAttended_1 := if(cnt=1, r.ProspectCollegeAttended, l.rel_ProspectCollegeAttended_1);
    self.rel_ProspectCollegeAttended_2 := if(cnt=2, r.ProspectCollegeAttended, l.rel_ProspectCollegeAttended_2);
    self.rel_ProspectCollegeAttended_3 := if(cnt=3, r.ProspectCollegeAttended, l.rel_ProspectCollegeAttended_3);
    self.rel_ProspectCollegeAttended_4 := if(cnt=4, r.ProspectCollegeAttended, l.rel_ProspectCollegeAttended_4);
    self.rel_ProspectCollegeAttended_5 := if(cnt=5, r.ProspectCollegeAttended, l.rel_ProspectCollegeAttended_5);
    self.rel_ProspectCollegeAttended_6 := if(cnt=6, r.ProspectCollegeAttended, l.rel_ProspectCollegeAttended_6);
    self.rel_ProspectCollegeAttended_7 := if(cnt=7, r.ProspectCollegeAttended, l.rel_ProspectCollegeAttended_7);
    self.rel_ProspectCollegeAttended_8 := if(cnt=8, r.ProspectCollegeAttended, l.rel_ProspectCollegeAttended_8);
    self.rel_ProspectCollegeAttended_9 := if(cnt=9, r.ProspectCollegeAttended, l.rel_ProspectCollegeAttended_9);
    self.rel_ProspectCollegeAttended_10 := if(cnt=10, r.ProspectCollegeAttended, l.rel_ProspectCollegeAttended_10);

    self.rel_CrtRecCnt_1 := if(cnt=1, r.CrtRecCnt, l.rel_CrtRecCnt_1);
    self.rel_CrtRecCnt_2 := if(cnt=2, r.CrtRecCnt, l.rel_CrtRecCnt_2);
    self.rel_CrtRecCnt_3 := if(cnt=3, r.CrtRecCnt, l.rel_CrtRecCnt_3);
    self.rel_CrtRecCnt_4 := if(cnt=4, r.CrtRecCnt, l.rel_CrtRecCnt_4);
    self.rel_CrtRecCnt_5 := if(cnt=5, r.CrtRecCnt, l.rel_CrtRecCnt_5);
    self.rel_CrtRecCnt_6 := if(cnt=6, r.CrtRecCnt, l.rel_CrtRecCnt_6);
    self.rel_CrtRecCnt_7 := if(cnt=7, r.CrtRecCnt, l.rel_CrtRecCnt_7);
    self.rel_CrtRecCnt_8 := if(cnt=8, r.CrtRecCnt, l.rel_CrtRecCnt_8);
    self.rel_CrtRecCnt_9 := if(cnt=9, r.CrtRecCnt, l.rel_CrtRecCnt_9);
    self.rel_CrtRecCnt_10 := if(cnt=10, r.CrtRecCnt, l.rel_CrtRecCnt_10);

    self.rel_CrtRecLienJudgCnt_1 := if(cnt=1, r.CrtRecLienJudgCnt, l.rel_CrtRecLienJudgCnt_1);
    self.rel_CrtRecLienJudgCnt_2 := if(cnt=2, r.CrtRecLienJudgCnt, l.rel_CrtRecLienJudgCnt_2);
    self.rel_CrtRecLienJudgCnt_3 := if(cnt=3, r.CrtRecLienJudgCnt, l.rel_CrtRecLienJudgCnt_3);
    self.rel_CrtRecLienJudgCnt_4 := if(cnt=4, r.CrtRecLienJudgCnt, l.rel_CrtRecLienJudgCnt_4);
    self.rel_CrtRecLienJudgCnt_5 := if(cnt=5, r.CrtRecLienJudgCnt, l.rel_CrtRecLienJudgCnt_5);
    self.rel_CrtRecLienJudgCnt_6 := if(cnt=6, r.CrtRecLienJudgCnt, l.rel_CrtRecLienJudgCnt_6);
    self.rel_CrtRecLienJudgCnt_7 := if(cnt=7, r.CrtRecLienJudgCnt, l.rel_CrtRecLienJudgCnt_7);
    self.rel_CrtRecLienJudgCnt_8 := if(cnt=8, r.CrtRecLienJudgCnt, l.rel_CrtRecLienJudgCnt_8);
    self.rel_CrtRecLienJudgCnt_9 := if(cnt=9, r.CrtRecLienJudgCnt, l.rel_CrtRecLienJudgCnt_9);
    self.rel_CrtRecLienJudgCnt_10 := if(cnt=10, r.CrtRecLienJudgCnt, l.rel_CrtRecLienJudgCnt_10);

    self.rel_CrtRecBkrptCnt_1 := if(cnt=1, r.CrtRecBkrptCnt, l.rel_CrtRecBkrptCnt_1);
    self.rel_CrtRecBkrptCnt_2 := if(cnt=2, r.CrtRecBkrptCnt, l.rel_CrtRecBkrptCnt_2);
    self.rel_CrtRecBkrptCnt_3 := if(cnt=3, r.CrtRecBkrptCnt, l.rel_CrtRecBkrptCnt_3);
    self.rel_CrtRecBkrptCnt_4 := if(cnt=4, r.CrtRecBkrptCnt, l.rel_CrtRecBkrptCnt_4);
    self.rel_CrtRecBkrptCnt_5 := if(cnt=5, r.CrtRecBkrptCnt, l.rel_CrtRecBkrptCnt_5);
    self.rel_CrtRecBkrptCnt_6 := if(cnt=6, r.CrtRecBkrptCnt, l.rel_CrtRecBkrptCnt_6);
    self.rel_CrtRecBkrptCnt_7 := if(cnt=7, r.CrtRecBkrptCnt, l.rel_CrtRecBkrptCnt_7);
    self.rel_CrtRecBkrptCnt_8 := if(cnt=8, r.CrtRecBkrptCnt, l.rel_CrtRecBkrptCnt_8);
    self.rel_CrtRecBkrptCnt_9 := if(cnt=9, r.CrtRecBkrptCnt, l.rel_CrtRecBkrptCnt_9);
    self.rel_CrtRecBkrptCnt_10 := if(cnt=10, r.CrtRecBkrptCnt, l.rel_CrtRecBkrptCnt_10);

    self.rel_OccProfLicense_1 := if(cnt=1, r.OccProfLicense, l.rel_OccProfLicense_1);
    self.rel_OccProfLicense_2 := if(cnt=2, r.OccProfLicense, l.rel_OccProfLicense_2);
    self.rel_OccProfLicense_3 := if(cnt=3, r.OccProfLicense, l.rel_OccProfLicense_3);
    self.rel_OccProfLicense_4 := if(cnt=4, r.OccProfLicense, l.rel_OccProfLicense_4);
    self.rel_OccProfLicense_5 := if(cnt=5, r.OccProfLicense, l.rel_OccProfLicense_5);
    self.rel_OccProfLicense_6 := if(cnt=6, r.OccProfLicense, l.rel_OccProfLicense_6);
    self.rel_OccProfLicense_7 := if(cnt=7, r.OccProfLicense, l.rel_OccProfLicense_7);
    self.rel_OccProfLicense_8 := if(cnt=8, r.OccProfLicense, l.rel_OccProfLicense_8);
    self.rel_OccProfLicense_9 := if(cnt=9, r.OccProfLicense, l.rel_OccProfLicense_9);
    self.rel_OccProfLicense_10 := if(cnt=10, r.OccProfLicense, l.rel_OccProfLicense_10);

    self.rel_OccProfLicenseCategory_1 := if(cnt=1, r.OccProfLicenseCategory, l.rel_OccProfLicenseCategory_1);
    self.rel_OccProfLicenseCategory_2 := if(cnt=2, r.OccProfLicenseCategory, l.rel_OccProfLicenseCategory_2);
    self.rel_OccProfLicenseCategory_3 := if(cnt=3, r.OccProfLicenseCategory, l.rel_OccProfLicenseCategory_3);
    self.rel_OccProfLicenseCategory_4 := if(cnt=4, r.OccProfLicenseCategory, l.rel_OccProfLicenseCategory_4);
    self.rel_OccProfLicenseCategory_5 := if(cnt=5, r.OccProfLicenseCategory, l.rel_OccProfLicenseCategory_5);
    self.rel_OccProfLicenseCategory_6 := if(cnt=6, r.OccProfLicenseCategory, l.rel_OccProfLicenseCategory_6);
    self.rel_OccProfLicenseCategory_7 := if(cnt=7, r.OccProfLicenseCategory, l.rel_OccProfLicenseCategory_7);
    self.rel_OccProfLicenseCategory_8 := if(cnt=8, r.OccProfLicenseCategory, l.rel_OccProfLicenseCategory_8);
    self.rel_OccProfLicenseCategory_9 := if(cnt=9, r.OccProfLicenseCategory, l.rel_OccProfLicenseCategory_9);
    self.rel_OccProfLicenseCategory_10 := if(cnt=10, r.OccProfLicenseCategory, l.rel_OccProfLicenseCategory_10);

    self.rel_OccBusinessAssociation_1 := if(cnt=1, r.OccBusinessAssociation, l.rel_OccBusinessAssociation_1);
    self.rel_OccBusinessAssociation_2 := if(cnt=2, r.OccBusinessAssociation, l.rel_OccBusinessAssociation_2);
    self.rel_OccBusinessAssociation_3 := if(cnt=3, r.OccBusinessAssociation, l.rel_OccBusinessAssociation_3);
    self.rel_OccBusinessAssociation_4 := if(cnt=4, r.OccBusinessAssociation, l.rel_OccBusinessAssociation_4);
    self.rel_OccBusinessAssociation_5 := if(cnt=5, r.OccBusinessAssociation, l.rel_OccBusinessAssociation_5);
    self.rel_OccBusinessAssociation_6 := if(cnt=6, r.OccBusinessAssociation, l.rel_OccBusinessAssociation_6);
    self.rel_OccBusinessAssociation_7 := if(cnt=7, r.OccBusinessAssociation, l.rel_OccBusinessAssociation_7);
    self.rel_OccBusinessAssociation_8 := if(cnt=8, r.OccBusinessAssociation, l.rel_OccBusinessAssociation_8);
    self.rel_OccBusinessAssociation_9 := if(cnt=9, r.OccBusinessAssociation, l.rel_OccBusinessAssociation_9);
    self.rel_OccBusinessAssociation_10 := if(cnt=10, r.OccBusinessAssociation, l.rel_OccBusinessAssociation_10);

    self.rel_OccBusinessTitleLeadership_1 := if(cnt=1, r.OccBusinessTitleLeadership, l.rel_OccBusinessTitleLeadership_1);
    self.rel_OccBusinessTitleLeadership_2 := if(cnt=2, r.OccBusinessTitleLeadership, l.rel_OccBusinessTitleLeadership_2);
    self.rel_OccBusinessTitleLeadership_3 := if(cnt=3, r.OccBusinessTitleLeadership, l.rel_OccBusinessTitleLeadership_3);
    self.rel_OccBusinessTitleLeadership_4 := if(cnt=4, r.OccBusinessTitleLeadership, l.rel_OccBusinessTitleLeadership_4);
    self.rel_OccBusinessTitleLeadership_5 := if(cnt=5, r.OccBusinessTitleLeadership, l.rel_OccBusinessTitleLeadership_5);
    self.rel_OccBusinessTitleLeadership_6 := if(cnt=6, r.OccBusinessTitleLeadership, l.rel_OccBusinessTitleLeadership_6);
    self.rel_OccBusinessTitleLeadership_7 := if(cnt=7, r.OccBusinessTitleLeadership, l.rel_OccBusinessTitleLeadership_7);
    self.rel_OccBusinessTitleLeadership_8 := if(cnt=8, r.OccBusinessTitleLeadership, l.rel_OccBusinessTitleLeadership_8);
    self.rel_OccBusinessTitleLeadership_9 := if(cnt=9, r.OccBusinessTitleLeadership, l.rel_OccBusinessTitleLeadership_9);
    self.rel_OccBusinessTitleLeadership_10 := if(cnt=10, r.OccBusinessTitleLeadership, l.rel_OccBusinessTitleLeadership_10);

    self.rel_HHEstimatedIncomeRange_1 := if(cnt=1, r.HHEstimatedIncomeRange, l.rel_HHEstimatedIncomeRange_1);
    self.rel_HHEstimatedIncomeRange_2 := if(cnt=2, r.HHEstimatedIncomeRange, l.rel_HHEstimatedIncomeRange_2);
    self.rel_HHEstimatedIncomeRange_3 := if(cnt=3, r.HHEstimatedIncomeRange, l.rel_HHEstimatedIncomeRange_3);
    self.rel_HHEstimatedIncomeRange_4 := if(cnt=4, r.HHEstimatedIncomeRange, l.rel_HHEstimatedIncomeRange_4);
    self.rel_HHEstimatedIncomeRange_5 := if(cnt=5, r.HHEstimatedIncomeRange, l.rel_HHEstimatedIncomeRange_5);
    self.rel_HHEstimatedIncomeRange_6 := if(cnt=6, r.HHEstimatedIncomeRange, l.rel_HHEstimatedIncomeRange_6);
    self.rel_HHEstimatedIncomeRange_7 := if(cnt=7, r.HHEstimatedIncomeRange, l.rel_HHEstimatedIncomeRange_7);
    self.rel_HHEstimatedIncomeRange_8 := if(cnt=8, r.HHEstimatedIncomeRange, l.rel_HHEstimatedIncomeRange_8);
    self.rel_HHEstimatedIncomeRange_9 := if(cnt=9, r.HHEstimatedIncomeRange, l.rel_HHEstimatedIncomeRange_9);
    self.rel_HHEstimatedIncomeRange_10 := if(cnt=10, r.HHEstimatedIncomeRange, l.rel_HHEstimatedIncomeRange_10);

    self.rel_RaAMmbrCnt_1 := if(cnt=1, r.RaAMmbrCnt, l.rel_RaAMmbrCnt_1);
    self.rel_RaAMmbrCnt_2 := if(cnt=2, r.RaAMmbrCnt, l.rel_RaAMmbrCnt_2);
    self.rel_RaAMmbrCnt_3 := if(cnt=3, r.RaAMmbrCnt, l.rel_RaAMmbrCnt_3);
    self.rel_RaAMmbrCnt_4 := if(cnt=4, r.RaAMmbrCnt, l.rel_RaAMmbrCnt_4);
    self.rel_RaAMmbrCnt_5 := if(cnt=5, r.RaAMmbrCnt, l.rel_RaAMmbrCnt_5);
    self.rel_RaAMmbrCnt_6 := if(cnt=6, r.RaAMmbrCnt, l.rel_RaAMmbrCnt_6);
    self.rel_RaAMmbrCnt_7 := if(cnt=7, r.RaAMmbrCnt, l.rel_RaAMmbrCnt_7);
    self.rel_RaAMmbrCnt_8 := if(cnt=8, r.RaAMmbrCnt, l.rel_RaAMmbrCnt_8);
    self.rel_RaAMmbrCnt_9 := if(cnt=9, r.RaAMmbrCnt, l.rel_RaAMmbrCnt_9);
    self.rel_RaAMmbrCnt_10 := if(cnt=10, r.RaAMmbrCnt, l.rel_RaAMmbrCnt_10);

    self.rel_RaAMedIncomeRange_1 := if(cnt=1, r.RaAMedIncomeRange, l.rel_RaAMedIncomeRange_1);
    self.rel_RaAMedIncomeRange_2 := if(cnt=2, r.RaAMedIncomeRange, l.rel_RaAMedIncomeRange_2);
    self.rel_RaAMedIncomeRange_3 := if(cnt=3, r.RaAMedIncomeRange, l.rel_RaAMedIncomeRange_3);
    self.rel_RaAMedIncomeRange_4 := if(cnt=4, r.RaAMedIncomeRange, l.rel_RaAMedIncomeRange_4);
    self.rel_RaAMedIncomeRange_5 := if(cnt=5, r.RaAMedIncomeRange, l.rel_RaAMedIncomeRange_5);
    self.rel_RaAMedIncomeRange_6 := if(cnt=6, r.RaAMedIncomeRange, l.rel_RaAMedIncomeRange_6);
    self.rel_RaAMedIncomeRange_7 := if(cnt=7, r.RaAMedIncomeRange, l.rel_RaAMedIncomeRange_7);
    self.rel_RaAMedIncomeRange_8 := if(cnt=8, r.RaAMedIncomeRange, l.rel_RaAMedIncomeRange_8);
    self.rel_RaAMedIncomeRange_9 := if(cnt=9, r.RaAMedIncomeRange, l.rel_RaAMedIncomeRange_9);
    self.rel_RaAMedIncomeRange_10 := if(cnt=10, r.RaAMedIncomeRange, l.rel_RaAMedIncomeRange_10);

    self.rel_RaACollegeAttendedMmbrCnt_1 := if(cnt=1, r.RaACollegeAttendedMmbrCnt, l.rel_RaACollegeAttendedMmbrCnt_1);
    self.rel_RaACollegeAttendedMmbrCnt_2 := if(cnt=2, r.RaACollegeAttendedMmbrCnt, l.rel_RaACollegeAttendedMmbrCnt_2);
    self.rel_RaACollegeAttendedMmbrCnt_3 := if(cnt=3, r.RaACollegeAttendedMmbrCnt, l.rel_RaACollegeAttendedMmbrCnt_3);
    self.rel_RaACollegeAttendedMmbrCnt_4 := if(cnt=4, r.RaACollegeAttendedMmbrCnt, l.rel_RaACollegeAttendedMmbrCnt_4);
    self.rel_RaACollegeAttendedMmbrCnt_5 := if(cnt=5, r.RaACollegeAttendedMmbrCnt, l.rel_RaACollegeAttendedMmbrCnt_5);
    self.rel_RaACollegeAttendedMmbrCnt_6 := if(cnt=6, r.RaACollegeAttendedMmbrCnt, l.rel_RaACollegeAttendedMmbrCnt_6);
    self.rel_RaACollegeAttendedMmbrCnt_7 := if(cnt=7, r.RaACollegeAttendedMmbrCnt, l.rel_RaACollegeAttendedMmbrCnt_7);
    self.rel_RaACollegeAttendedMmbrCnt_8 := if(cnt=8, r.RaACollegeAttendedMmbrCnt, l.rel_RaACollegeAttendedMmbrCnt_8);
    self.rel_RaACollegeAttendedMmbrCnt_9 := if(cnt=9, r.RaACollegeAttendedMmbrCnt, l.rel_RaACollegeAttendedMmbrCnt_9);
    self.rel_RaACollegeAttendedMmbrCnt_10 := if(cnt=10, r.RaACollegeAttendedMmbrCnt, l.rel_RaACollegeAttendedMmbrCnt_10);

    self.rel_RaACrtRecMmbrCnt_1 := if(cnt=1, r.RaACrtRecMmbrCnt, l.rel_RaACrtRecMmbrCnt_1);
    self.rel_RaACrtRecMmbrCnt_2 := if(cnt=2, r.RaACrtRecMmbrCnt, l.rel_RaACrtRecMmbrCnt_2);
    self.rel_RaACrtRecMmbrCnt_3 := if(cnt=3, r.RaACrtRecMmbrCnt, l.rel_RaACrtRecMmbrCnt_3);
    self.rel_RaACrtRecMmbrCnt_4 := if(cnt=4, r.RaACrtRecMmbrCnt, l.rel_RaACrtRecMmbrCnt_4);
    self.rel_RaACrtRecMmbrCnt_5 := if(cnt=5, r.RaACrtRecMmbrCnt, l.rel_RaACrtRecMmbrCnt_5);
    self.rel_RaACrtRecMmbrCnt_6 := if(cnt=6, r.RaACrtRecMmbrCnt, l.rel_RaACrtRecMmbrCnt_6);
    self.rel_RaACrtRecMmbrCnt_7 := if(cnt=7, r.RaACrtRecMmbrCnt, l.rel_RaACrtRecMmbrCnt_7);
    self.rel_RaACrtRecMmbrCnt_8 := if(cnt=8, r.RaACrtRecMmbrCnt, l.rel_RaACrtRecMmbrCnt_8);
    self.rel_RaACrtRecMmbrCnt_9 := if(cnt=9, r.RaACrtRecMmbrCnt, l.rel_RaACrtRecMmbrCnt_9);
    self.rel_RaACrtRecMmbrCnt_10 := if(cnt=10, r.RaACrtRecMmbrCnt, l.rel_RaACrtRecMmbrCnt_10);

    self.rel_RaAOccBusinessAssocMmbrCnt_1 := if(cnt=1, r.RaAOccBusinessAssocMmbrCnt, l.rel_RaAOccBusinessAssocMmbrCnt_1);
    self.rel_RaAOccBusinessAssocMmbrCnt_2 := if(cnt=2, r.RaAOccBusinessAssocMmbrCnt, l.rel_RaAOccBusinessAssocMmbrCnt_2);
    self.rel_RaAOccBusinessAssocMmbrCnt_3 := if(cnt=3, r.RaAOccBusinessAssocMmbrCnt, l.rel_RaAOccBusinessAssocMmbrCnt_3);
    self.rel_RaAOccBusinessAssocMmbrCnt_4 := if(cnt=4, r.RaAOccBusinessAssocMmbrCnt, l.rel_RaAOccBusinessAssocMmbrCnt_4);
    self.rel_RaAOccBusinessAssocMmbrCnt_5 := if(cnt=5, r.RaAOccBusinessAssocMmbrCnt, l.rel_RaAOccBusinessAssocMmbrCnt_5);
    self.rel_RaAOccBusinessAssocMmbrCnt_6 := if(cnt=6, r.RaAOccBusinessAssocMmbrCnt, l.rel_RaAOccBusinessAssocMmbrCnt_6);
    self.rel_RaAOccBusinessAssocMmbrCnt_7 := if(cnt=7, r.RaAOccBusinessAssocMmbrCnt, l.rel_RaAOccBusinessAssocMmbrCnt_7);
    self.rel_RaAOccBusinessAssocMmbrCnt_8 := if(cnt=8, r.RaAOccBusinessAssocMmbrCnt, l.rel_RaAOccBusinessAssocMmbrCnt_8);
    self.rel_RaAOccBusinessAssocMmbrCnt_9 := if(cnt=9, r.RaAOccBusinessAssocMmbrCnt, l.rel_RaAOccBusinessAssocMmbrCnt_9);
    self.rel_RaAOccBusinessAssocMmbrCnt_10 := if(cnt=10, r.RaAOccBusinessAssocMmbrCnt, l.rel_RaAOccBusinessAssocMmbrCnt_10);

    self := l;
  end;

  //generate final output - get roomies
EXPORT Didville.Layouts.out_with_seq_rec get_out_roomie(Didville.Layouts.out_with_seq_rec l, Didville.Layouts.best_with_email_profile_rec r, unsigned cnt) := transform
    self.asso_first_name_1 := if(cnt=1, r.fname, l.asso_first_name_1);
    self.asso_middle_name_1 := if(cnt=1, r.mname, l.asso_middle_name_1);
    self.asso_last_name_1 := if(cnt=1, r.lname, l.asso_last_name_1);
    self.asso_address_1 := if(cnt=1, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.asso_address_1);
    self.asso_city_1 := if(cnt=1, r.city_name, l.asso_city_1);
    self.asso_state_1 := if(cnt=1, r.st, l.asso_state_1);
    self.asso_zipcode_1 := if(cnt=1, r.zip + r.zip4, l.asso_zipcode_1);
    self.asso_phone_1 := if(cnt=1, r.phone, l.asso_phone_1);
    self.asso_ssn_1   := if(cnt=1, r.ssn, l.asso_ssn_1);
    self.asso_dob_1   := if(cnt=1, if(r.dob=0, '',(string) r.dob),
                                   l.asso_dob_1);
    self.asso_dod_1   := if(cnt=1, r.dod, l.asso_dod_1);
    self.asso_dm_deceased_flag_1 := if(cnt=1,r.dod <> '', l.asso_dm_deceased_flag_1);
    self.asso_relationship_1 := if(cnt=1, r.relationship, l.asso_relationship_1);
    self.asso_relationship_type_1 := if(cnt=1, r.relationship_type, l.asso_relationship_type_1);
    self.asso_relationship_confidence_1 := if(cnt=1, r.relationship_confidence, l.asso_relationship_confidence_1);

    self.asso_first_name_2 := if(cnt=2, r.fname, l.asso_first_name_2);
    self.asso_middle_name_2 := if(cnt=2, r.mname, l.asso_middle_name_2);
    self.asso_last_name_2 := if(cnt=2, r.lname, l.asso_last_name_2);
    self.asso_address_2 := if(cnt=2, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.asso_address_2);
    self.asso_city_2 := if(cnt=2, r.city_name, l.asso_city_2);
    self.asso_state_2 := if(cnt=2, r.st, l.asso_state_2);
    self.asso_zipcode_2 := if(cnt=2, r.zip + r.zip4, l.asso_zipcode_2);
    self.asso_phone_2 := if(cnt=2, r.phone, l.asso_phone_2);
    self.asso_ssn_2   := if(cnt=2, r.ssn, l.asso_ssn_2);
    self.asso_dob_2   := if(cnt=2, if(r.dob=0, '',(string) r.dob),
                                   l.asso_dob_2);
    self.asso_dod_2   := if(cnt=2, r.dod, l.asso_dod_2);
    self.asso_dm_deceased_flag_2 := if(cnt=2,r.dod <> '', l.asso_dm_deceased_flag_2);
    self.asso_relationship_2 := if(cnt=2, r.relationship, l.asso_relationship_2);
    self.asso_relationship_type_2 := if(cnt=2, r.relationship_type, l.asso_relationship_type_2);
    self.asso_relationship_confidence_2 := if(cnt=2, r.relationship_confidence, l.asso_relationship_confidence_2);

    self.asso_first_name_3 := if(cnt=3, r.fname, l.asso_first_name_3);
    self.asso_middle_name_3 := if(cnt=3, r.mname, l.asso_middle_name_3);
    self.asso_last_name_3 := if(cnt=3, r.lname, l.asso_last_name_3);
    self.asso_address_3 := if(cnt=3, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.asso_address_3);
    self.asso_city_3 := if(cnt=3, r.city_name, l.asso_city_3);
    self.asso_state_3 := if(cnt=3, r.st, l.asso_state_3);
    self.asso_zipcode_3 := if(cnt=3, r.zip + r.zip4, l.asso_zipcode_3);
    self.asso_phone_3 := if(cnt=3, r.phone, l.asso_phone_3);
    self.asso_ssn_3   := if(cnt=3, r.ssn, l.asso_ssn_3);
    self.asso_dob_3   := if(cnt=3, if(r.dob=0, '',(string) r.dob),
                                   l.asso_dob_3);
    self.asso_dod_3   := if(cnt=3, r.dod, l.asso_dod_3);
    self.asso_dm_deceased_flag_3 := if(cnt=3,r.dod <> '', l.asso_dm_deceased_flag_3);
    self.asso_relationship_3 := if(cnt=3, r.relationship, l.asso_relationship_3);
    self.asso_relationship_type_3 := if(cnt=3, r.relationship_type, l.asso_relationship_type_3);
    self.asso_relationship_confidence_3 := if(cnt=3, r.relationship_confidence, l.asso_relationship_confidence_3);

    self.asso_first_name_4 := if(cnt=4, r.fname, l.asso_first_name_4);
    self.asso_middle_name_4 := if(cnt=4, r.mname, l.asso_middle_name_4);
    self.asso_last_name_4 := if(cnt=4, r.lname, l.asso_last_name_4);
    self.asso_address_4 := if(cnt=4, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.asso_address_4);
    self.asso_city_4 := if(cnt=4, r.city_name, l.asso_city_4);
    self.asso_state_4 := if(cnt=4, r.st, l.asso_state_4);
    self.asso_zipcode_4 := if(cnt=4, r.zip + r.zip4, l.asso_zipcode_4);
    self.asso_phone_4 := if(cnt=4, r.phone, l.asso_phone_4);
    self.asso_ssn_4   := if(cnt=4, r.ssn, l.asso_ssn_4);
    self.asso_dob_4   := if(cnt=4, if(r.dob=0, '',(string) r.dob),
                                   l.asso_dob_4);
    self.asso_dod_4   := if(cnt=4, r.dod, l.asso_dod_4);
    self.asso_dm_deceased_flag_4 := if(cnt=4,r.dod <> '', l.asso_dm_deceased_flag_4);
    self.asso_relationship_4 := if(cnt=4, r.relationship, l.asso_relationship_4);
    self.asso_relationship_type_4 := if(cnt=4, r.relationship_type, l.asso_relationship_type_4);
    self.asso_relationship_confidence_4 := if(cnt=4, r.relationship_confidence, l.asso_relationship_confidence_4);

    self.asso_first_name_5 := if(cnt=5, r.fname, l.asso_first_name_5);
    self.asso_middle_name_5 := if(cnt=5, r.mname, l.asso_middle_name_5);
    self.asso_last_name_5 := if(cnt=5, r.lname, l.asso_last_name_5);
    self.asso_address_5 := if(cnt=5, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.asso_address_5);
    self.asso_city_5 := if(cnt=5, r.city_name, l.asso_city_5);
    self.asso_state_5 := if(cnt=5, r.st, l.asso_state_5);
    self.asso_zipcode_5 := if(cnt=5, r.zip + r.zip4, l.asso_zipcode_5);
    self.asso_phone_5 := if(cnt=5, r.phone, l.asso_phone_5);
    self.asso_ssn_5   := if(cnt=5, r.ssn, l.asso_ssn_5);
    self.asso_dob_5   := if(cnt=5, if(r.dob=0, '',(string) r.dob),
                                   l.asso_dob_5);
    self.asso_dod_5   := if(cnt=5, r.dod, l.asso_dod_5);
    self.asso_dm_deceased_flag_5 := if(cnt=5,r.dod <> '', l.asso_dm_deceased_flag_5);
    self.asso_relationship_5 := if(cnt=5, r.relationship, l.asso_relationship_5);
    self.asso_relationship_type_5 := if(cnt=5, r.relationship_type, l.asso_relationship_type_5);
    self.asso_relationship_confidence_5 := if(cnt=5, r.relationship_confidence, l.asso_relationship_confidence_5);

    self.asso_first_name_6 := if(cnt=6, r.fname, l.asso_first_name_6);
    self.asso_middle_name_6 := if(cnt=6, r.mname, l.asso_middle_name_6);
    self.asso_last_name_6 := if(cnt=6, r.lname, l.asso_last_name_6);
    self.asso_address_6 := if(cnt=6, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.asso_address_6);
    self.asso_city_6 := if(cnt=6, r.city_name, l.asso_city_6);
    self.asso_state_6 := if(cnt=6, r.st, l.asso_state_6);
    self.asso_zipcode_6 := if(cnt=6, r.zip + r.zip4, l.asso_zipcode_6);
    self.asso_phone_6 := if(cnt=6, r.phone, l.asso_phone_6);
    self.asso_ssn_6   := if(cnt=6, r.ssn, l.asso_ssn_6);
    self.asso_dob_6   := if(cnt=6, if(r.dob=0, '',(string) r.dob),
                                   l.asso_dob_6);
    self.asso_dod_6   := if(cnt=6, r.dod, l.asso_dod_6);
    self.asso_dm_deceased_flag_6 := if(cnt=6,r.dod <> '', l.asso_dm_deceased_flag_6);
    self.asso_relationship_6 := if(cnt=6, r.relationship, l.asso_relationship_6);
    self.asso_relationship_type_6 := if(cnt=6, r.relationship_type, l.asso_relationship_type_6);
    self.asso_relationship_confidence_6 := if(cnt=6, r.relationship_confidence, l.asso_relationship_confidence_6);

    self.asso_first_name_7 := if(cnt=7, r.fname, l.asso_first_name_7);
    self.asso_middle_name_7 := if(cnt=7, r.mname, l.asso_middle_name_7);
    self.asso_last_name_7 := if(cnt=7, r.lname, l.asso_last_name_7);
    self.asso_address_7 := if(cnt=7, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.asso_address_7);
    self.asso_city_7 := if(cnt=7, r.city_name, l.asso_city_7);
    self.asso_state_7 := if(cnt=7, r.st, l.asso_state_7);
    self.asso_zipcode_7 := if(cnt=7, r.zip + r.zip4, l.asso_zipcode_7);
    self.asso_phone_7 := if(cnt=7, r.phone, l.asso_phone_7);
    self.asso_ssn_7   := if(cnt=7, r.ssn, l.asso_ssn_7);
    self.asso_dob_7   := if(cnt=7, if(r.dob=0, '',(string) r.dob),
                                   l.asso_dob_7);
    self.asso_dod_7   := if(cnt=7, r.dod, l.asso_dod_7);
    self.asso_dm_deceased_flag_7 := if(cnt=7,r.dod <> '', l.asso_dm_deceased_flag_7);
    self.asso_relationship_7 := if(cnt=7, r.relationship, l.asso_relationship_7);
    self.asso_relationship_type_7 := if(cnt=7, r.relationship_type, l.asso_relationship_type_7);
    self.asso_relationship_confidence_7 := if(cnt=7, r.relationship_confidence, l.asso_relationship_confidence_7);

    self.asso_first_name_8 := if(cnt=8, r.fname, l.asso_first_name_8);
    self.asso_middle_name_8 := if(cnt=8, r.mname, l.asso_middle_name_8);
    self.asso_last_name_8 := if(cnt=8, r.lname, l.asso_last_name_8);
    self.asso_address_8 := if(cnt=8, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.asso_address_8);
    self.asso_city_8 := if(cnt=8, r.city_name, l.asso_city_8);
    self.asso_state_8 := if(cnt=8, r.st, l.asso_state_8);
    self.asso_zipcode_8 := if(cnt=8, r.zip + r.zip4, l.asso_zipcode_8);
    self.asso_phone_8 := if(cnt=8, r.phone, l.asso_phone_8);
    self.asso_ssn_8   := if(cnt=8, r.ssn, l.asso_ssn_8);
    self.asso_dob_8   := if(cnt=8, if(r.dob=0, '',(string) r.dob),
                                   l.asso_dob_8);
    self.asso_dod_8   := if(cnt=8, r.dod, l.asso_dod_8);
    self.asso_dm_deceased_flag_8 := if(cnt=8,r.dod <> '', l.asso_dm_deceased_flag_8);
    self.asso_relationship_8 := if(cnt=8, r.relationship, l.asso_relationship_8);
    self.asso_relationship_type_8 := if(cnt=8, r.relationship_type, l.asso_relationship_type_8);
    self.asso_relationship_confidence_8 := if(cnt=8, r.relationship_confidence, l.asso_relationship_confidence_8);

    self.asso_first_name_9 := if(cnt=9, r.fname, l.asso_first_name_9);
    self.asso_middle_name_9 := if(cnt=9, r.mname, l.asso_middle_name_9);
    self.asso_last_name_9 := if(cnt=9, r.lname, l.asso_last_name_9);
    self.asso_address_9 := if(cnt=9, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.asso_address_9);
    self.asso_city_9 := if(cnt=9, r.city_name, l.asso_city_9);
    self.asso_state_9 := if(cnt=9, r.st, l.asso_state_9);
    self.asso_zipcode_9 := if(cnt=9, r.zip + r.zip4, l.asso_zipcode_9);
    self.asso_phone_9 := if(cnt=9, r.phone, l.asso_phone_9);
    self.asso_ssn_9   := if(cnt=9, r.ssn, l.asso_ssn_9);
    self.asso_dob_9   := if(cnt=9, if(r.dob=0, '',(string) r.dob),
                                   l.asso_dob_9);
    self.asso_dod_9   := if(cnt=9, r.dod, l.asso_dod_9);
    self.asso_dm_deceased_flag_9 := if(cnt=9,r.dod <> '', l.asso_dm_deceased_flag_9);
    self.asso_relationship_9 := if(cnt=9, r.relationship, l.asso_relationship_9);
    self.asso_relationship_type_9 := if(cnt=9, r.relationship_type, l.asso_relationship_type_9);
    self.asso_relationship_confidence_9 := if(cnt=9, r.relationship_confidence, l.asso_relationship_confidence_9);

    self.asso_first_name_10 := if(cnt=10, r.fname, l.asso_first_name_10);
    self.asso_middle_name_10 := if(cnt=10, r.mname, l.asso_middle_name_10);
    self.asso_last_name_10 := if(cnt=10, r.lname, l.asso_last_name_10);
    self.asso_address_10 := if(cnt=10, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.asso_address_10);
    self.asso_city_10 := if(cnt=10, r.city_name, l.asso_city_10);
    self.asso_state_10 := if(cnt=10, r.st, l.asso_state_10);
    self.asso_zipcode_10 := if(cnt=10, r.zip + r.zip4, l.asso_zipcode_10);
    self.asso_phone_10 := if(cnt=10, r.phone, l.asso_phone_10);
    self.asso_ssn_10   := if(cnt=10, r.ssn, l.asso_ssn_10);
    self.asso_dob_10   := if(cnt=10, if(r.dob=0, '',(string) r.dob),
                                   l.asso_dob_10);
    self.asso_dod_10   := if(cnt=10, r.dod, l.asso_dod_10);
    self.asso_dm_deceased_flag_10 := if(cnt=10,r.dod <> '', l.asso_dm_deceased_flag_10);
    self.asso_relationship_10 := if(cnt=10, r.relationship, l.asso_relationship_10);
    self.asso_relationship_type_10 := if(cnt=10, r.relationship_type, l.asso_relationship_type_10);
    self.asso_relationship_confidence_10 := if(cnt=10, r.relationship_confidence, l.asso_relationship_confidence_10);

    self.RelAssocNeigh_Flag:='Y';

    self.asso_title_1 := if(cnt=1, r.title, l.asso_title_1);
    self.asso_title_2 := if(cnt=2, r.title, l.asso_title_2);
    self.asso_title_3 := if(cnt=3, r.title, l.asso_title_3);
    self.asso_title_4 := if(cnt=4, r.title, l.asso_title_4);
    self.asso_title_5 := if(cnt=5, r.title, l.asso_title_5);
    self.asso_title_6 := if(cnt=6, r.title, l.asso_title_6);
    self.asso_title_7 := if(cnt=7, r.title, l.asso_title_7);
    self.asso_title_8 := if(cnt=8, r.title, l.asso_title_8);
    self.asso_title_9 := if(cnt=9, r.title, l.asso_title_9);
    self.asso_title_10 := if(cnt=10, r.title, l.asso_title_10);

    self.asso_name_suffix_1 := if(cnt=1, r.name_suffix, l.asso_name_suffix_1);
    self.asso_name_suffix_2 := if(cnt=2, r.name_suffix, l.asso_name_suffix_2);
    self.asso_name_suffix_3 := if(cnt=3, r.name_suffix, l.asso_name_suffix_3);
    self.asso_name_suffix_4 := if(cnt=4, r.name_suffix, l.asso_name_suffix_4);
    self.asso_name_suffix_5 := if(cnt=5, r.name_suffix, l.asso_name_suffix_5);
    self.asso_name_suffix_6 := if(cnt=6, r.name_suffix, l.asso_name_suffix_6);
    self.asso_name_suffix_7 := if(cnt=7, r.name_suffix, l.asso_name_suffix_7);
    self.asso_name_suffix_8 := if(cnt=8, r.name_suffix, l.asso_name_suffix_8);
    self.asso_name_suffix_9 := if(cnt=9, r.name_suffix, l.asso_name_suffix_9);
    self.asso_name_suffix_10 := if(cnt=10, r.name_suffix, l.asso_name_suffix_10);

    self.asso_email_1 := if(cnt=1, r.email, l.asso_email_1);
    self.asso_email_2 := if(cnt=2, r.email, l.asso_email_2);
    self.asso_email_3 := if(cnt=3, r.email, l.asso_email_3);
    self.asso_email_4 := if(cnt=4, r.email, l.asso_email_4);
    self.asso_email_5 := if(cnt=5, r.email, l.asso_email_5);
    self.asso_email_6 := if(cnt=6, r.email, l.asso_email_6);
    self.asso_email_7 := if(cnt=7, r.email, l.asso_email_7);
    self.asso_email_8 := if(cnt=8, r.email, l.asso_email_8);
    self.asso_email_9 := if(cnt=9, r.email, l.asso_email_9);
    self.asso_email_10 := if(cnt=10, r.email, l.asso_email_10);

    self.asso_donotmail_1 := if(cnt=1, r.donotmail, l.asso_donotmail_1);
    self.asso_donotmail_2 := if(cnt=2, r.donotmail, l.asso_donotmail_2);
    self.asso_donotmail_3 := if(cnt=3, r.donotmail, l.asso_donotmail_3);
    self.asso_donotmail_4 := if(cnt=4, r.donotmail, l.asso_donotmail_4);
    self.asso_donotmail_5 := if(cnt=5, r.donotmail, l.asso_donotmail_5);
    self.asso_donotmail_6 := if(cnt=6, r.donotmail, l.asso_donotmail_6);
    self.asso_donotmail_7 := if(cnt=7, r.donotmail, l.asso_donotmail_7);
    self.asso_donotmail_8 := if(cnt=8, r.donotmail, l.asso_donotmail_8);
    self.asso_donotmail_9 := if(cnt=9, r.donotmail, l.asso_donotmail_9);
    self.asso_donotmail_10 := if(cnt=10, r.donotmail, l.asso_donotmail_10);

    self.asso_ProspectAge_1 := if(cnt=1, r.ProspectAge, l.asso_ProspectAge_1);
    self.asso_ProspectAge_2 := if(cnt=2, r.ProspectAge, l.asso_ProspectAge_2);
    self.asso_ProspectAge_3 := if(cnt=3, r.ProspectAge, l.asso_ProspectAge_3);
    self.asso_ProspectAge_4 := if(cnt=4, r.ProspectAge, l.asso_ProspectAge_4);
    self.asso_ProspectAge_5 := if(cnt=5, r.ProspectAge, l.asso_ProspectAge_5);
    self.asso_ProspectAge_6 := if(cnt=6, r.ProspectAge, l.asso_ProspectAge_6);
    self.asso_ProspectAge_7 := if(cnt=7, r.ProspectAge, l.asso_ProspectAge_7);
    self.asso_ProspectAge_8 := if(cnt=8, r.ProspectAge, l.asso_ProspectAge_8);
    self.asso_ProspectAge_9 := if(cnt=9, r.ProspectAge, l.asso_ProspectAge_9);
    self.asso_ProspectAge_10 := if(cnt=10, r.ProspectAge, l.asso_ProspectAge_10);

    self.asso_ProspectGender_1 := if(cnt=1, r.ProspectGender, l.asso_ProspectGender_1);
    self.asso_ProspectGender_2 := if(cnt=2, r.ProspectGender, l.asso_ProspectGender_2);
    self.asso_ProspectGender_3 := if(cnt=3, r.ProspectGender, l.asso_ProspectGender_3);
    self.asso_ProspectGender_4 := if(cnt=4, r.ProspectGender, l.asso_ProspectGender_4);
    self.asso_ProspectGender_5 := if(cnt=5, r.ProspectGender, l.asso_ProspectGender_5);
    self.asso_ProspectGender_6 := if(cnt=6, r.ProspectGender, l.asso_ProspectGender_6);
    self.asso_ProspectGender_7 := if(cnt=7, r.ProspectGender, l.asso_ProspectGender_7);
    self.asso_ProspectGender_8 := if(cnt=8, r.ProspectGender, l.asso_ProspectGender_8);
    self.asso_ProspectGender_9 := if(cnt=9, r.ProspectGender, l.asso_ProspectGender_9);
    self.asso_ProspectGender_10 := if(cnt=10, r.ProspectGender, l.asso_ProspectGender_10);

    self.asso_ProspectMaritalStatus_1 := if(cnt=1, r.ProspectMaritalStatus, l.asso_ProspectMaritalStatus_1);
    self.asso_ProspectMaritalStatus_2 := if(cnt=2, r.ProspectMaritalStatus, l.asso_ProspectMaritalStatus_2);
    self.asso_ProspectMaritalStatus_3 := if(cnt=3, r.ProspectMaritalStatus, l.asso_ProspectMaritalStatus_3);
    self.asso_ProspectMaritalStatus_4 := if(cnt=4, r.ProspectMaritalStatus, l.asso_ProspectMaritalStatus_4);
    self.asso_ProspectMaritalStatus_5 := if(cnt=5, r.ProspectMaritalStatus, l.asso_ProspectMaritalStatus_5);
    self.asso_ProspectMaritalStatus_6 := if(cnt=6, r.ProspectMaritalStatus, l.asso_ProspectMaritalStatus_6);
    self.asso_ProspectMaritalStatus_7 := if(cnt=7, r.ProspectMaritalStatus, l.asso_ProspectMaritalStatus_7);
    self.asso_ProspectMaritalStatus_8 := if(cnt=8, r.ProspectMaritalStatus, l.asso_ProspectMaritalStatus_8);
    self.asso_ProspectMaritalStatus_9 := if(cnt=9, r.ProspectMaritalStatus, l.asso_ProspectMaritalStatus_9);
    self.asso_ProspectMaritalStatus_10 := if(cnt=10, r.ProspectMaritalStatus, l.asso_ProspectMaritalStatus_10);

    self.asso_ProspectEstimatedIncomeRange_1 := if(cnt=1, r.ProspectEstimatedIncomeRange, l.asso_ProspectEstimatedIncomeRange_1);
    self.asso_ProspectEstimatedIncomeRange_2 := if(cnt=2, r.ProspectEstimatedIncomeRange, l.asso_ProspectEstimatedIncomeRange_2);
    self.asso_ProspectEstimatedIncomeRange_3 := if(cnt=3, r.ProspectEstimatedIncomeRange, l.asso_ProspectEstimatedIncomeRange_3);
    self.asso_ProspectEstimatedIncomeRange_4 := if(cnt=4, r.ProspectEstimatedIncomeRange, l.asso_ProspectEstimatedIncomeRange_4);
    self.asso_ProspectEstimatedIncomeRange_5 := if(cnt=5, r.ProspectEstimatedIncomeRange, l.asso_ProspectEstimatedIncomeRange_5);
    self.asso_ProspectEstimatedIncomeRange_6 := if(cnt=6, r.ProspectEstimatedIncomeRange, l.asso_ProspectEstimatedIncomeRange_6);
    self.asso_ProspectEstimatedIncomeRange_7 := if(cnt=7, r.ProspectEstimatedIncomeRange, l.asso_ProspectEstimatedIncomeRange_7);
    self.asso_ProspectEstimatedIncomeRange_8 := if(cnt=8, r.ProspectEstimatedIncomeRange, l.asso_ProspectEstimatedIncomeRange_8);
    self.asso_ProspectEstimatedIncomeRange_9 := if(cnt=9, r.ProspectEstimatedIncomeRange, l.asso_ProspectEstimatedIncomeRange_9);
    self.asso_ProspectEstimatedIncomeRange_10 := if(cnt=10, r.ProspectEstimatedIncomeRange, l.asso_ProspectEstimatedIncomeRange_10);

    self.asso_ProspectCollegeAttended_1 := if(cnt=1, r.ProspectCollegeAttended, l.asso_ProspectCollegeAttended_1);
    self.asso_ProspectCollegeAttended_2 := if(cnt=2, r.ProspectCollegeAttended, l.asso_ProspectCollegeAttended_2);
    self.asso_ProspectCollegeAttended_3 := if(cnt=3, r.ProspectCollegeAttended, l.asso_ProspectCollegeAttended_3);
    self.asso_ProspectCollegeAttended_4 := if(cnt=4, r.ProspectCollegeAttended, l.asso_ProspectCollegeAttended_4);
    self.asso_ProspectCollegeAttended_5 := if(cnt=5, r.ProspectCollegeAttended, l.asso_ProspectCollegeAttended_5);
    self.asso_ProspectCollegeAttended_6 := if(cnt=6, r.ProspectCollegeAttended, l.asso_ProspectCollegeAttended_6);
    self.asso_ProspectCollegeAttended_7 := if(cnt=7, r.ProspectCollegeAttended, l.asso_ProspectCollegeAttended_7);
    self.asso_ProspectCollegeAttended_8 := if(cnt=8, r.ProspectCollegeAttended, l.asso_ProspectCollegeAttended_8);
    self.asso_ProspectCollegeAttended_9 := if(cnt=9, r.ProspectCollegeAttended, l.asso_ProspectCollegeAttended_9);
    self.asso_ProspectCollegeAttended_10 := if(cnt=10, r.ProspectCollegeAttended, l.asso_ProspectCollegeAttended_10);

    self.asso_CrtRecCnt_1 := if(cnt=1, r.CrtRecCnt, l.asso_CrtRecCnt_1);
    self.asso_CrtRecCnt_2 := if(cnt=2, r.CrtRecCnt, l.asso_CrtRecCnt_2);
    self.asso_CrtRecCnt_3 := if(cnt=3, r.CrtRecCnt, l.asso_CrtRecCnt_3);
    self.asso_CrtRecCnt_4 := if(cnt=4, r.CrtRecCnt, l.asso_CrtRecCnt_4);
    self.asso_CrtRecCnt_5 := if(cnt=5, r.CrtRecCnt, l.asso_CrtRecCnt_5);
    self.asso_CrtRecCnt_6 := if(cnt=6, r.CrtRecCnt, l.asso_CrtRecCnt_6);
    self.asso_CrtRecCnt_7 := if(cnt=7, r.CrtRecCnt, l.asso_CrtRecCnt_7);
    self.asso_CrtRecCnt_8 := if(cnt=8, r.CrtRecCnt, l.asso_CrtRecCnt_8);
    self.asso_CrtRecCnt_9 := if(cnt=9, r.CrtRecCnt, l.asso_CrtRecCnt_9);
    self.asso_CrtRecCnt_10 := if(cnt=10, r.CrtRecCnt, l.asso_CrtRecCnt_10);

    self.asso_CrtRecLienJudgCnt_1 := if(cnt=1, r.CrtRecLienJudgCnt, l.asso_CrtRecLienJudgCnt_1);
    self.asso_CrtRecLienJudgCnt_2 := if(cnt=2, r.CrtRecLienJudgCnt, l.asso_CrtRecLienJudgCnt_2);
    self.asso_CrtRecLienJudgCnt_3 := if(cnt=3, r.CrtRecLienJudgCnt, l.asso_CrtRecLienJudgCnt_3);
    self.asso_CrtRecLienJudgCnt_4 := if(cnt=4, r.CrtRecLienJudgCnt, l.asso_CrtRecLienJudgCnt_4);
    self.asso_CrtRecLienJudgCnt_5 := if(cnt=5, r.CrtRecLienJudgCnt, l.asso_CrtRecLienJudgCnt_5);
    self.asso_CrtRecLienJudgCnt_6 := if(cnt=6, r.CrtRecLienJudgCnt, l.asso_CrtRecLienJudgCnt_6);
    self.asso_CrtRecLienJudgCnt_7 := if(cnt=7, r.CrtRecLienJudgCnt, l.asso_CrtRecLienJudgCnt_7);
    self.asso_CrtRecLienJudgCnt_8 := if(cnt=8, r.CrtRecLienJudgCnt, l.asso_CrtRecLienJudgCnt_8);
    self.asso_CrtRecLienJudgCnt_9 := if(cnt=9, r.CrtRecLienJudgCnt, l.asso_CrtRecLienJudgCnt_9);
    self.asso_CrtRecLienJudgCnt_10 := if(cnt=10, r.CrtRecLienJudgCnt, l.asso_CrtRecLienJudgCnt_10);

    self.asso_CrtRecBkrptCnt_1 := if(cnt=1, r.CrtRecBkrptCnt, l.asso_CrtRecBkrptCnt_1);
    self.asso_CrtRecBkrptCnt_2 := if(cnt=2, r.CrtRecBkrptCnt, l.asso_CrtRecBkrptCnt_2);
    self.asso_CrtRecBkrptCnt_3 := if(cnt=3, r.CrtRecBkrptCnt, l.asso_CrtRecBkrptCnt_3);
    self.asso_CrtRecBkrptCnt_4 := if(cnt=4, r.CrtRecBkrptCnt, l.asso_CrtRecBkrptCnt_4);
    self.asso_CrtRecBkrptCnt_5 := if(cnt=5, r.CrtRecBkrptCnt, l.asso_CrtRecBkrptCnt_5);
    self.asso_CrtRecBkrptCnt_6 := if(cnt=6, r.CrtRecBkrptCnt, l.asso_CrtRecBkrptCnt_6);
    self.asso_CrtRecBkrptCnt_7 := if(cnt=7, r.CrtRecBkrptCnt, l.asso_CrtRecBkrptCnt_7);
    self.asso_CrtRecBkrptCnt_8 := if(cnt=8, r.CrtRecBkrptCnt, l.asso_CrtRecBkrptCnt_8);
    self.asso_CrtRecBkrptCnt_9 := if(cnt=9, r.CrtRecBkrptCnt, l.asso_CrtRecBkrptCnt_9);
    self.asso_CrtRecBkrptCnt_10 := if(cnt=10, r.CrtRecBkrptCnt, l.asso_CrtRecBkrptCnt_10);

    self.asso_OccProfLicense_1 := if(cnt=1, r.OccProfLicense, l.asso_OccProfLicense_1);
    self.asso_OccProfLicense_2 := if(cnt=2, r.OccProfLicense, l.asso_OccProfLicense_2);
    self.asso_OccProfLicense_3 := if(cnt=3, r.OccProfLicense, l.asso_OccProfLicense_3);
    self.asso_OccProfLicense_4 := if(cnt=4, r.OccProfLicense, l.asso_OccProfLicense_4);
    self.asso_OccProfLicense_5 := if(cnt=5, r.OccProfLicense, l.asso_OccProfLicense_5);
    self.asso_OccProfLicense_6 := if(cnt=6, r.OccProfLicense, l.asso_OccProfLicense_6);
    self.asso_OccProfLicense_7 := if(cnt=7, r.OccProfLicense, l.asso_OccProfLicense_7);
    self.asso_OccProfLicense_8 := if(cnt=8, r.OccProfLicense, l.asso_OccProfLicense_8);
    self.asso_OccProfLicense_9 := if(cnt=9, r.OccProfLicense, l.asso_OccProfLicense_9);
    self.asso_OccProfLicense_10 := if(cnt=10, r.OccProfLicense, l.asso_OccProfLicense_10);

    self.asso_OccProfLicenseCategory_1 := if(cnt=1, r.OccProfLicenseCategory, l.asso_OccProfLicenseCategory_1);
    self.asso_OccProfLicenseCategory_2 := if(cnt=2, r.OccProfLicenseCategory, l.asso_OccProfLicenseCategory_2);
    self.asso_OccProfLicenseCategory_3 := if(cnt=3, r.OccProfLicenseCategory, l.asso_OccProfLicenseCategory_3);
    self.asso_OccProfLicenseCategory_4 := if(cnt=4, r.OccProfLicenseCategory, l.asso_OccProfLicenseCategory_4);
    self.asso_OccProfLicenseCategory_5 := if(cnt=5, r.OccProfLicenseCategory, l.asso_OccProfLicenseCategory_5);
    self.asso_OccProfLicenseCategory_6 := if(cnt=6, r.OccProfLicenseCategory, l.asso_OccProfLicenseCategory_6);
    self.asso_OccProfLicenseCategory_7 := if(cnt=7, r.OccProfLicenseCategory, l.asso_OccProfLicenseCategory_7);
    self.asso_OccProfLicenseCategory_8 := if(cnt=8, r.OccProfLicenseCategory, l.asso_OccProfLicenseCategory_8);
    self.asso_OccProfLicenseCategory_9 := if(cnt=9, r.OccProfLicenseCategory, l.asso_OccProfLicenseCategory_9);
    self.asso_OccProfLicenseCategory_10 := if(cnt=10, r.OccProfLicenseCategory, l.asso_OccProfLicenseCategory_10);

    self.asso_OccBusinessAssociation_1 := if(cnt=1, r.OccBusinessAssociation, l.asso_OccBusinessAssociation_1);
    self.asso_OccBusinessAssociation_2 := if(cnt=2, r.OccBusinessAssociation, l.asso_OccBusinessAssociation_2);
    self.asso_OccBusinessAssociation_3 := if(cnt=3, r.OccBusinessAssociation, l.asso_OccBusinessAssociation_3);
    self.asso_OccBusinessAssociation_4 := if(cnt=4, r.OccBusinessAssociation, l.asso_OccBusinessAssociation_4);
    self.asso_OccBusinessAssociation_5 := if(cnt=5, r.OccBusinessAssociation, l.asso_OccBusinessAssociation_5);
    self.asso_OccBusinessAssociation_6 := if(cnt=6, r.OccBusinessAssociation, l.asso_OccBusinessAssociation_6);
    self.asso_OccBusinessAssociation_7 := if(cnt=7, r.OccBusinessAssociation, l.asso_OccBusinessAssociation_7);
    self.asso_OccBusinessAssociation_8 := if(cnt=8, r.OccBusinessAssociation, l.asso_OccBusinessAssociation_8);
    self.asso_OccBusinessAssociation_9 := if(cnt=9, r.OccBusinessAssociation, l.asso_OccBusinessAssociation_9);
    self.asso_OccBusinessAssociation_10 := if(cnt=10, r.OccBusinessAssociation, l.asso_OccBusinessAssociation_10);

    self.asso_OccBusinessTitleLeadership_1 := if(cnt=1, r.OccBusinessTitleLeadership, l.asso_OccBusinessTitleLeadership_1);
    self.asso_OccBusinessTitleLeadership_2 := if(cnt=2, r.OccBusinessTitleLeadership, l.asso_OccBusinessTitleLeadership_2);
    self.asso_OccBusinessTitleLeadership_3 := if(cnt=3, r.OccBusinessTitleLeadership, l.asso_OccBusinessTitleLeadership_3);
    self.asso_OccBusinessTitleLeadership_4 := if(cnt=4, r.OccBusinessTitleLeadership, l.asso_OccBusinessTitleLeadership_4);
    self.asso_OccBusinessTitleLeadership_5 := if(cnt=5, r.OccBusinessTitleLeadership, l.asso_OccBusinessTitleLeadership_5);
    self.asso_OccBusinessTitleLeadership_6 := if(cnt=6, r.OccBusinessTitleLeadership, l.asso_OccBusinessTitleLeadership_6);
    self.asso_OccBusinessTitleLeadership_7 := if(cnt=7, r.OccBusinessTitleLeadership, l.asso_OccBusinessTitleLeadership_7);
    self.asso_OccBusinessTitleLeadership_8 := if(cnt=8, r.OccBusinessTitleLeadership, l.asso_OccBusinessTitleLeadership_8);
    self.asso_OccBusinessTitleLeadership_9 := if(cnt=9, r.OccBusinessTitleLeadership, l.asso_OccBusinessTitleLeadership_9);
    self.asso_OccBusinessTitleLeadership_10 := if(cnt=10, r.OccBusinessTitleLeadership, l.asso_OccBusinessTitleLeadership_10);

    self.asso_HHEstimatedIncomeRange_1 := if(cnt=1, r.HHEstimatedIncomeRange, l.asso_HHEstimatedIncomeRange_1);
    self.asso_HHEstimatedIncomeRange_2 := if(cnt=2, r.HHEstimatedIncomeRange, l.asso_HHEstimatedIncomeRange_2);
    self.asso_HHEstimatedIncomeRange_3 := if(cnt=3, r.HHEstimatedIncomeRange, l.asso_HHEstimatedIncomeRange_3);
    self.asso_HHEstimatedIncomeRange_4 := if(cnt=4, r.HHEstimatedIncomeRange, l.asso_HHEstimatedIncomeRange_4);
    self.asso_HHEstimatedIncomeRange_5 := if(cnt=5, r.HHEstimatedIncomeRange, l.asso_HHEstimatedIncomeRange_5);
    self.asso_HHEstimatedIncomeRange_6 := if(cnt=6, r.HHEstimatedIncomeRange, l.asso_HHEstimatedIncomeRange_6);
    self.asso_HHEstimatedIncomeRange_7 := if(cnt=7, r.HHEstimatedIncomeRange, l.asso_HHEstimatedIncomeRange_7);
    self.asso_HHEstimatedIncomeRange_8 := if(cnt=8, r.HHEstimatedIncomeRange, l.asso_HHEstimatedIncomeRange_8);
    self.asso_HHEstimatedIncomeRange_9 := if(cnt=9, r.HHEstimatedIncomeRange, l.asso_HHEstimatedIncomeRange_9);
    self.asso_HHEstimatedIncomeRange_10 := if(cnt=10, r.HHEstimatedIncomeRange, l.asso_HHEstimatedIncomeRange_10);

    self.asso_RaAMmbrCnt_1 := if(cnt=1, r.RaAMmbrCnt, l.asso_RaAMmbrCnt_1);
    self.asso_RaAMmbrCnt_2 := if(cnt=2, r.RaAMmbrCnt, l.asso_RaAMmbrCnt_2);
    self.asso_RaAMmbrCnt_3 := if(cnt=3, r.RaAMmbrCnt, l.asso_RaAMmbrCnt_3);
    self.asso_RaAMmbrCnt_4 := if(cnt=4, r.RaAMmbrCnt, l.asso_RaAMmbrCnt_4);
    self.asso_RaAMmbrCnt_5 := if(cnt=5, r.RaAMmbrCnt, l.asso_RaAMmbrCnt_5);
    self.asso_RaAMmbrCnt_6 := if(cnt=6, r.RaAMmbrCnt, l.asso_RaAMmbrCnt_6);
    self.asso_RaAMmbrCnt_7 := if(cnt=7, r.RaAMmbrCnt, l.asso_RaAMmbrCnt_7);
    self.asso_RaAMmbrCnt_8 := if(cnt=8, r.RaAMmbrCnt, l.asso_RaAMmbrCnt_8);
    self.asso_RaAMmbrCnt_9 := if(cnt=9, r.RaAMmbrCnt, l.asso_RaAMmbrCnt_9);
    self.asso_RaAMmbrCnt_10 := if(cnt=10, r.RaAMmbrCnt, l.asso_RaAMmbrCnt_10);

    self.asso_RaAMedIncomeRange_1 := if(cnt=1, r.RaAMedIncomeRange, l.asso_RaAMedIncomeRange_1);
    self.asso_RaAMedIncomeRange_2 := if(cnt=2, r.RaAMedIncomeRange, l.asso_RaAMedIncomeRange_2);
    self.asso_RaAMedIncomeRange_3 := if(cnt=3, r.RaAMedIncomeRange, l.asso_RaAMedIncomeRange_3);
    self.asso_RaAMedIncomeRange_4 := if(cnt=4, r.RaAMedIncomeRange, l.asso_RaAMedIncomeRange_4);
    self.asso_RaAMedIncomeRange_5 := if(cnt=5, r.RaAMedIncomeRange, l.asso_RaAMedIncomeRange_5);
    self.asso_RaAMedIncomeRange_6 := if(cnt=6, r.RaAMedIncomeRange, l.asso_RaAMedIncomeRange_6);
    self.asso_RaAMedIncomeRange_7 := if(cnt=7, r.RaAMedIncomeRange, l.asso_RaAMedIncomeRange_7);
    self.asso_RaAMedIncomeRange_8 := if(cnt=8, r.RaAMedIncomeRange, l.asso_RaAMedIncomeRange_8);
    self.asso_RaAMedIncomeRange_9 := if(cnt=9, r.RaAMedIncomeRange, l.asso_RaAMedIncomeRange_9);
    self.asso_RaAMedIncomeRange_10 := if(cnt=10, r.RaAMedIncomeRange, l.asso_RaAMedIncomeRange_10);

    self.asso_RaACollegeAttendedMmbrCnt_1 := if(cnt=1, r.RaACollegeAttendedMmbrCnt, l.asso_RaACollegeAttendedMmbrCnt_1);
    self.asso_RaACollegeAttendedMmbrCnt_2 := if(cnt=2, r.RaACollegeAttendedMmbrCnt, l.asso_RaACollegeAttendedMmbrCnt_2);
    self.asso_RaACollegeAttendedMmbrCnt_3 := if(cnt=3, r.RaACollegeAttendedMmbrCnt, l.asso_RaACollegeAttendedMmbrCnt_3);
    self.asso_RaACollegeAttendedMmbrCnt_4 := if(cnt=4, r.RaACollegeAttendedMmbrCnt, l.asso_RaACollegeAttendedMmbrCnt_4);
    self.asso_RaACollegeAttendedMmbrCnt_5 := if(cnt=5, r.RaACollegeAttendedMmbrCnt, l.asso_RaACollegeAttendedMmbrCnt_5);
    self.asso_RaACollegeAttendedMmbrCnt_6 := if(cnt=6, r.RaACollegeAttendedMmbrCnt, l.asso_RaACollegeAttendedMmbrCnt_6);
    self.asso_RaACollegeAttendedMmbrCnt_7 := if(cnt=7, r.RaACollegeAttendedMmbrCnt, l.asso_RaACollegeAttendedMmbrCnt_7);
    self.asso_RaACollegeAttendedMmbrCnt_8 := if(cnt=8, r.RaACollegeAttendedMmbrCnt, l.asso_RaACollegeAttendedMmbrCnt_8);
    self.asso_RaACollegeAttendedMmbrCnt_9 := if(cnt=9, r.RaACollegeAttendedMmbrCnt, l.asso_RaACollegeAttendedMmbrCnt_9);
    self.asso_RaACollegeAttendedMmbrCnt_10 := if(cnt=10, r.RaACollegeAttendedMmbrCnt, l.asso_RaACollegeAttendedMmbrCnt_10);

    self.asso_RaACrtRecMmbrCnt_1 := if(cnt=1, r.RaACrtRecMmbrCnt, l.asso_RaACrtRecMmbrCnt_1);
    self.asso_RaACrtRecMmbrCnt_2 := if(cnt=2, r.RaACrtRecMmbrCnt, l.asso_RaACrtRecMmbrCnt_2);
    self.asso_RaACrtRecMmbrCnt_3 := if(cnt=3, r.RaACrtRecMmbrCnt, l.asso_RaACrtRecMmbrCnt_3);
    self.asso_RaACrtRecMmbrCnt_4 := if(cnt=4, r.RaACrtRecMmbrCnt, l.asso_RaACrtRecMmbrCnt_4);
    self.asso_RaACrtRecMmbrCnt_5 := if(cnt=5, r.RaACrtRecMmbrCnt, l.asso_RaACrtRecMmbrCnt_5);
    self.asso_RaACrtRecMmbrCnt_6 := if(cnt=6, r.RaACrtRecMmbrCnt, l.asso_RaACrtRecMmbrCnt_6);
    self.asso_RaACrtRecMmbrCnt_7 := if(cnt=7, r.RaACrtRecMmbrCnt, l.asso_RaACrtRecMmbrCnt_7);
    self.asso_RaACrtRecMmbrCnt_8 := if(cnt=8, r.RaACrtRecMmbrCnt, l.asso_RaACrtRecMmbrCnt_8);
    self.asso_RaACrtRecMmbrCnt_9 := if(cnt=9, r.RaACrtRecMmbrCnt, l.asso_RaACrtRecMmbrCnt_9);
    self.asso_RaACrtRecMmbrCnt_10 := if(cnt=10, r.RaACrtRecMmbrCnt, l.asso_RaACrtRecMmbrCnt_10);

    self.asso_RaAOccBusinessAssocMmbrCnt_1 := if(cnt=1, r.RaAOccBusinessAssocMmbrCnt, l.asso_RaAOccBusinessAssocMmbrCnt_1);
    self.asso_RaAOccBusinessAssocMmbrCnt_2 := if(cnt=2, r.RaAOccBusinessAssocMmbrCnt, l.asso_RaAOccBusinessAssocMmbrCnt_2);
    self.asso_RaAOccBusinessAssocMmbrCnt_3 := if(cnt=3, r.RaAOccBusinessAssocMmbrCnt, l.asso_RaAOccBusinessAssocMmbrCnt_3);
    self.asso_RaAOccBusinessAssocMmbrCnt_4 := if(cnt=4, r.RaAOccBusinessAssocMmbrCnt, l.asso_RaAOccBusinessAssocMmbrCnt_4);
    self.asso_RaAOccBusinessAssocMmbrCnt_5 := if(cnt=5, r.RaAOccBusinessAssocMmbrCnt, l.asso_RaAOccBusinessAssocMmbrCnt_5);
    self.asso_RaAOccBusinessAssocMmbrCnt_6 := if(cnt=6, r.RaAOccBusinessAssocMmbrCnt, l.asso_RaAOccBusinessAssocMmbrCnt_6);
    self.asso_RaAOccBusinessAssocMmbrCnt_7 := if(cnt=7, r.RaAOccBusinessAssocMmbrCnt, l.asso_RaAOccBusinessAssocMmbrCnt_7);
    self.asso_RaAOccBusinessAssocMmbrCnt_8 := if(cnt=8, r.RaAOccBusinessAssocMmbrCnt, l.asso_RaAOccBusinessAssocMmbrCnt_8);
    self.asso_RaAOccBusinessAssocMmbrCnt_9 := if(cnt=9, r.RaAOccBusinessAssocMmbrCnt, l.asso_RaAOccBusinessAssocMmbrCnt_9);
    self.asso_RaAOccBusinessAssocMmbrCnt_10 := if(cnt=10, r.RaAOccBusinessAssocMmbrCnt, l.asso_RaAOccBusinessAssocMmbrCnt_10);

    self := l;
  end;

  //generate final output - get input address nbrs
EXPORT Didville.Layouts.out_with_seq_rec get_out_nbr_in(Didville.Layouts.out_with_seq_rec l, Didville.Layouts.nbr_with_email_profile_rec r, unsigned cnt) := transform
    self.nbr_first_name_input_1 := if(cnt=1, r.fname, l.nbr_first_name_input_1);
    self.nbr_last_name_input_1 := if(cnt=1, r.lname, l.nbr_last_name_input_1);
    self.nbr_address_input_1 := if(cnt=1, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.nbr_address_input_1);
    self.nbr_city_input_1 := if(cnt=1, r.city_name, l.nbr_city_input_1);
    self.nbr_state_input_1 := if(cnt=1, r.st, l.nbr_state_input_1);
    self.nbr_zipcode_input_1 := if(cnt=1, r.zip + r.zip4, l.nbr_zipcode_input_1);
    self.nbr_phone_input_1 := if(cnt=1, r.phone, l.nbr_phone_input_1);
    self.nbr_dod_input_1   := if(cnt=1, r.dod, l.nbr_dod_input_1);
    self.nbr_dm_deceased_flag_input_1 := if(cnt=1, r.dod <>'',l.nbr_dm_deceased_flag_input_1);

    self.nbr_first_name_input_2 := if(cnt=2, r.fname, l.nbr_first_name_input_2);
    self.nbr_last_name_input_2 := if(cnt=2, r.lname, l.nbr_last_name_input_2);
    self.nbr_address_input_2 := if(cnt=2, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.nbr_address_input_2);
    self.nbr_city_input_2 := if(cnt=2, r.city_name, l.nbr_city_input_2);
    self.nbr_state_input_2 := if(cnt=2, r.st, l.nbr_state_input_2);
    self.nbr_zipcode_input_2 := if(cnt=2, r.zip + r.zip4, l.nbr_zipcode_input_2);
    self.nbr_phone_input_2 := if(cnt=2, r.phone, l.nbr_phone_input_2);
    self.nbr_dod_input_2   := if(cnt=2, r.dod, l.nbr_dod_input_2);
    self.nbr_dm_deceased_flag_input_2 := if(cnt=2, r.dod <>'',l.nbr_dm_deceased_flag_input_2);

    self.nbr_first_name_input_3 := if(cnt=3, r.fname, l.nbr_first_name_input_3);
    self.nbr_last_name_input_3 := if(cnt=3, r.lname, l.nbr_last_name_input_3);
    self.nbr_address_input_3 := if(cnt=3, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.nbr_address_input_3);
    self.nbr_city_input_3 := if(cnt=3, r.city_name, l.nbr_city_input_3);
    self.nbr_state_input_3 := if(cnt=3, r.st, l.nbr_state_input_3);
    self.nbr_zipcode_input_3 := if(cnt=3, r.zip + r.zip4, l.nbr_zipcode_input_3);
    self.nbr_phone_input_3 := if(cnt=3, r.phone, l.nbr_phone_input_3);
    self.nbr_dod_input_3   := if(cnt=3, r.dod, l.nbr_dod_input_3);
    self.nbr_dm_deceased_flag_input_3 := if(cnt=3, r.dod <>'',l.nbr_dm_deceased_flag_input_3);

    self.RelAssocNeigh_Flag:='Y';

    self.nbr_title_1 := if(cnt=1, r.title, l.nbr_title_1);
    self.nbr_title_2 := if(cnt=2, r.title, l.nbr_title_2);
    self.nbr_title_3 := if(cnt=3, r.title, l.nbr_title_3);

    self.nbr_middle_name_input_1 := if(cnt=1, r.mname, l.nbr_middle_name_input_1);
    self.nbr_middle_name_input_2 := if(cnt=2, r.mname, l.nbr_middle_name_input_2);
    self.nbr_middle_name_input_3 := if(cnt=3, r.mname, l.nbr_middle_name_input_3);

    self.nbr_name_suffix_1 := if(cnt=1, r.name_suffix, l.nbr_name_suffix_1);
    self.nbr_name_suffix_2 := if(cnt=2, r.name_suffix, l.nbr_name_suffix_2);
    self.nbr_name_suffix_3 := if(cnt=3, r.name_suffix, l.nbr_name_suffix_3);

    self.nbr_email_input_1 := if(cnt=1, r.email, l.nbr_email_input_1);
    self.nbr_email_input_2 := if(cnt=2, r.email, l.nbr_email_input_2);
    self.nbr_email_input_3 := if(cnt=3, r.email, l.nbr_email_input_3);

    self.nbr_donotmail_input_1 := if(cnt=1, r.donotmail, l.nbr_donotmail_input_1);
    self.nbr_donotmail_input_2 := if(cnt=2, r.donotmail, l.nbr_donotmail_input_2);
    self.nbr_donotmail_input_3 := if(cnt=3, r.donotmail, l.nbr_donotmail_input_3);

    self.nbr_ProspectAge_input_1 := if(cnt=1, r.ProspectAge, l.nbr_ProspectAge_input_1);
    self.nbr_ProspectAge_input_2 := if(cnt=2, r.ProspectAge, l.nbr_ProspectAge_input_2);
    self.nbr_ProspectAge_input_3 := if(cnt=3, r.ProspectAge, l.nbr_ProspectAge_input_3);

    self.nbr_ProspectGender_input_1 := if(cnt=1, r.ProspectGender, l.nbr_ProspectGender_input_1);
    self.nbr_ProspectGender_input_2 := if(cnt=2, r.ProspectGender, l.nbr_ProspectGender_input_2);
    self.nbr_ProspectGender_input_3 := if(cnt=3, r.ProspectGender, l.nbr_ProspectGender_input_3);

    self.nbr_ProspectMaritalStatus_input_1 := if(cnt=1, r.ProspectMaritalStatus, l.nbr_ProspectMaritalStatus_input_1);
    self.nbr_ProspectMaritalStatus_input_2 := if(cnt=2, r.ProspectMaritalStatus, l.nbr_ProspectMaritalStatus_input_2);
    self.nbr_ProspectMaritalStatus_input_3 := if(cnt=3, r.ProspectMaritalStatus, l.nbr_ProspectMaritalStatus_input_3);

    self.nbr_ProspectEstimatedIncomeRange_input_1 := if(cnt=1, r.ProspectEstimatedIncomeRange, l.nbr_ProspectEstimatedIncomeRange_input_1);
    self.nbr_ProspectEstimatedIncomeRange_input_2 := if(cnt=2, r.ProspectEstimatedIncomeRange, l.nbr_ProspectEstimatedIncomeRange_input_2);
    self.nbr_ProspectEstimatedIncomeRange_input_3 := if(cnt=3, r.ProspectEstimatedIncomeRange, l.nbr_ProspectEstimatedIncomeRange_input_3);

    self.nbr_ProspectCollegeAttended_input_1 := if(cnt=1, r.ProspectCollegeAttended, l.nbr_ProspectCollegeAttended_input_1);
    self.nbr_ProspectCollegeAttended_input_2 := if(cnt=2, r.ProspectCollegeAttended, l.nbr_ProspectCollegeAttended_input_2);
    self.nbr_ProspectCollegeAttended_input_3 := if(cnt=3, r.ProspectCollegeAttended, l.nbr_ProspectCollegeAttended_input_3);

    self.nbr_CrtRecCnt_input_1 := if(cnt=1, r.CrtRecCnt, l.nbr_CrtRecCnt_input_1);
    self.nbr_CrtRecCnt_input_2 := if(cnt=2, r.CrtRecCnt, l.nbr_CrtRecCnt_input_2);
    self.nbr_CrtRecCnt_input_3 := if(cnt=3, r.CrtRecCnt, l.nbr_CrtRecCnt_input_3);

    self.nbr_CrtRecLienJudgCnt_input_1 := if(cnt=1, r.CrtRecLienJudgCnt, l.nbr_CrtRecLienJudgCnt_input_1);
    self.nbr_CrtRecLienJudgCnt_input_2 := if(cnt=2, r.CrtRecLienJudgCnt, l.nbr_CrtRecLienJudgCnt_input_2);
    self.nbr_CrtRecLienJudgCnt_input_3 := if(cnt=3, r.CrtRecLienJudgCnt, l.nbr_CrtRecLienJudgCnt_input_3);

    self.nbr_CrtRecBkrptCnt_input_1 := if(cnt=1, r.CrtRecBkrptCnt, l.nbr_CrtRecBkrptCnt_input_1);
    self.nbr_CrtRecBkrptCnt_input_2 := if(cnt=2, r.CrtRecBkrptCnt, l.nbr_CrtRecBkrptCnt_input_2);
    self.nbr_CrtRecBkrptCnt_input_3 := if(cnt=3, r.CrtRecBkrptCnt, l.nbr_CrtRecBkrptCnt_input_3);

    self.nbr_OccProfLicense_input_1 := if(cnt=1, r.OccProfLicense, l.nbr_OccProfLicense_input_1);
    self.nbr_OccProfLicense_input_2 := if(cnt=2, r.OccProfLicense, l.nbr_OccProfLicense_input_2);
    self.nbr_OccProfLicense_input_3 := if(cnt=3, r.OccProfLicense, l.nbr_OccProfLicense_input_3);

    self.nbr_OccProfLicenseCategory_input_1 := if(cnt=1, r.OccProfLicenseCategory, l.nbr_OccProfLicenseCategory_input_1);
    self.nbr_OccProfLicenseCategory_input_2 := if(cnt=2, r.OccProfLicenseCategory, l.nbr_OccProfLicenseCategory_input_2);
    self.nbr_OccProfLicenseCategory_input_3 := if(cnt=3, r.OccProfLicenseCategory, l.nbr_OccProfLicenseCategory_input_3);

    self.nbr_OccBusinessAssociation_input_1 := if(cnt=1, r.OccBusinessAssociation, l.nbr_OccBusinessAssociation_input_1);
    self.nbr_OccBusinessAssociation_input_2 := if(cnt=2, r.OccBusinessAssociation, l.nbr_OccBusinessAssociation_input_2);
    self.nbr_OccBusinessAssociation_input_3 := if(cnt=3, r.OccBusinessAssociation, l.nbr_OccBusinessAssociation_input_3);

    self.nbr_OccBusinessTitleLeadership_input_1 := if(cnt=1, r.OccBusinessTitleLeadership, l.nbr_OccBusinessTitleLeadership_input_1);
    self.nbr_OccBusinessTitleLeadership_input_2 := if(cnt=2, r.OccBusinessTitleLeadership, l.nbr_OccBusinessTitleLeadership_input_2);
    self.nbr_OccBusinessTitleLeadership_input_3 := if(cnt=3, r.OccBusinessTitleLeadership, l.nbr_OccBusinessTitleLeadership_input_3);

    self.nbr_HHEstimatedIncomeRange_input_1 := if(cnt=1, r.HHEstimatedIncomeRange, l.nbr_HHEstimatedIncomeRange_input_1);
    self.nbr_HHEstimatedIncomeRange_input_2 := if(cnt=2, r.HHEstimatedIncomeRange, l.nbr_HHEstimatedIncomeRange_input_2);
    self.nbr_HHEstimatedIncomeRange_input_3 := if(cnt=3, r.HHEstimatedIncomeRange, l.nbr_HHEstimatedIncomeRange_input_3);

    self.nbr_RaAMmbrCnt_input_1 := if(cnt=1, r.RaAMmbrCnt, l.nbr_RaAMmbrCnt_input_1);
    self.nbr_RaAMmbrCnt_input_2 := if(cnt=2, r.RaAMmbrCnt, l.nbr_RaAMmbrCnt_input_2);
    self.nbr_RaAMmbrCnt_input_3 := if(cnt=3, r.RaAMmbrCnt, l.nbr_RaAMmbrCnt_input_3);

    self.nbr_RaAMedIncomeRange_input_1 := if(cnt=1, r.RaAMedIncomeRange, l.nbr_RaAMedIncomeRange_input_1);
    self.nbr_RaAMedIncomeRange_input_2 := if(cnt=2, r.RaAMedIncomeRange, l.nbr_RaAMedIncomeRange_input_2);
    self.nbr_RaAMedIncomeRange_input_3 := if(cnt=3, r.RaAMedIncomeRange, l.nbr_RaAMedIncomeRange_input_3);

    self.nbr_RaACollegeAttendedMmbrCnt_input_1 := if(cnt=1, r.RaACollegeAttendedMmbrCnt, l.nbr_RaACollegeAttendedMmbrCnt_input_1);
    self.nbr_RaACollegeAttendedMmbrCnt_input_2 := if(cnt=2, r.RaACollegeAttendedMmbrCnt, l.nbr_RaACollegeAttendedMmbrCnt_input_2);
    self.nbr_RaACollegeAttendedMmbrCnt_input_3 := if(cnt=3, r.RaACollegeAttendedMmbrCnt, l.nbr_RaACollegeAttendedMmbrCnt_input_3);

    self.nbr_RaACrtRecMmbrCnt_input_1 := if(cnt=1, r.RaACrtRecMmbrCnt, l.nbr_RaACrtRecMmbrCnt_input_1);
    self.nbr_RaACrtRecMmbrCnt_input_2 := if(cnt=2, r.RaACrtRecMmbrCnt, l.nbr_RaACrtRecMmbrCnt_input_2);
    self.nbr_RaACrtRecMmbrCnt_input_3 := if(cnt=3, r.RaACrtRecMmbrCnt, l.nbr_RaACrtRecMmbrCnt_input_3);

    self.nbr_RaAOccBusinessAssocMmbrCnt_input_1 := if(cnt=1, r.RaAOccBusinessAssocMmbrCnt, l.nbr_RaAOccBusinessAssocMmbrCnt_input_1);
    self.nbr_RaAOccBusinessAssocMmbrCnt_input_2 := if(cnt=2, r.RaAOccBusinessAssocMmbrCnt, l.nbr_RaAOccBusinessAssocMmbrCnt_input_2);
    self.nbr_RaAOccBusinessAssocMmbrCnt_input_3 := if(cnt=3, r.RaAOccBusinessAssocMmbrCnt, l.nbr_RaAOccBusinessAssocMmbrCnt_input_3);

    self := l;
  end;

   //generate final output - get input address nbrs
EXPORT Didville.Layouts.out_with_seq_rec get_out_nbr_best(Didville.Layouts.out_with_seq_rec l, Didville.Layouts.nbr_with_email_profile_rec r, unsigned cnt) := transform
    self.nbr_first_name_Updated_1 := if(cnt=1, r.fname, l.nbr_first_name_Updated_1);
    self.nbr_last_name_Updated_1 := if(cnt=1, r.lname, l.nbr_last_name_Updated_1);
    self.nbr_address_Updated_1 := if(cnt=1, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.nbr_address_Updated_1);
    self.nbr_city_Updated_1 := if(cnt=1, r.city_name, l.nbr_city_Updated_1);
    self.nbr_state_Updated_1 := if(cnt=1, r.st, l.nbr_state_Updated_1);
    self.nbr_zipcode_Updated_1 := if(cnt=1, r.zip + r.zip4, l.nbr_zipcode_Updated_1);
    self.nbr_phone_Updated_1 := if(cnt=1, r.phone, l.nbr_phone_Updated_1);
    self.nbr_dod_Updated_1   := if(cnt=1, r.dod, l.nbr_dod_Updated_1);
    self.nbr_dm_deceased_flag_Updated_1 := if(cnt=1, r.dod <>'',l.nbr_dm_deceased_flag_Updated_1);


    self.nbr_first_name_Updated_2 := if(cnt=2, r.fname, l.nbr_first_name_Updated_2);
    self.nbr_last_name_Updated_2 := if(cnt=2, r.lname, l.nbr_last_name_Updated_2);
    self.nbr_address_Updated_2 := if(cnt=2, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.nbr_address_Updated_2);
    self.nbr_city_Updated_2 := if(cnt=2, r.city_name, l.nbr_city_Updated_2);
    self.nbr_state_Updated_2 := if(cnt=2, r.st, l.nbr_state_Updated_2);
    self.nbr_zipcode_Updated_2 := if(cnt=2, r.zip + r.zip4, l.nbr_zipcode_Updated_2);
    self.nbr_phone_Updated_2 := if(cnt=2, r.phone, l.nbr_phone_Updated_2);
    self.nbr_dod_Updated_2   := if(cnt=2, r.dod, l.nbr_dod_Updated_2);
    self.nbr_dm_deceased_flag_Updated_2 := if(cnt=2, r.dod <>'',l.nbr_dm_deceased_flag_Updated_2);


    self.nbr_first_name_Updated_3 := if(cnt=3, r.fname, l.nbr_first_name_Updated_3);
    self.nbr_last_name_Updated_3 := if(cnt=3, r.lname, l.nbr_last_name_Updated_3);
    self.nbr_address_Updated_3 := if(cnt=3, address.Addr1FromComponents(r.prim_range, r.predir, r.prim_name,
                                                                   r.suffix, r.postdir, r.unit_desig, r.sec_range),
                  l.nbr_address_Updated_3);
    self.nbr_city_Updated_3 := if(cnt=3, r.city_name, l.nbr_city_Updated_3);
    self.nbr_state_Updated_3 := if(cnt=3, r.st, l.nbr_state_Updated_3);
    self.nbr_zipcode_Updated_3 := if(cnt=3, r.zip + r.zip4, l.nbr_zipcode_Updated_3);
    self.nbr_phone_Updated_3 := if(cnt=3, r.phone, l.nbr_phone_Updated_3);
    self.nbr_dod_Updated_3   := if(cnt=3, r.dod, l.nbr_dod_Updated_3);
    self.nbr_dm_deceased_flag_Updated_3 :=if(cnt=3, r.dod <>'',l.nbr_dm_deceased_flag_Updated_3);

    self.RelAssocNeigh_Flag:='Y';

    self.nbr_title_Updated_1 := if(cnt=1, r.title, l.nbr_title_Updated_1);
    self.nbr_title_Updated_2 := if(cnt=2, r.title, l.nbr_title_Updated_2);
    self.nbr_title_Updated_3 := if(cnt=3, r.title, l.nbr_title_Updated_3);

    self.nbr_middle_name_Updated_1 := if(cnt=1, r.mname, l.nbr_middle_name_Updated_1);
    self.nbr_middle_name_Updated_2 := if(cnt=2, r.mname, l.nbr_middle_name_Updated_2);
    self.nbr_middle_name_Updated_3 := if(cnt=3, r.mname, l.nbr_middle_name_Updated_3);

    self.nbr_name_suffix_Updated_1 := if(cnt=1, r.name_suffix, l.nbr_name_suffix_Updated_1);
    self.nbr_name_suffix_Updated_2 := if(cnt=2, r.name_suffix, l.nbr_name_suffix_Updated_2);
    self.nbr_name_suffix_Updated_3 := if(cnt=3, r.name_suffix, l.nbr_name_suffix_Updated_3);

    self.nbr_email_updated_1 := if(cnt=1, r.email, l.nbr_email_updated_1);
    self.nbr_email_updated_2 := if(cnt=2, r.email, l.nbr_email_updated_2);
    self.nbr_email_updated_3 := if(cnt=3, r.email, l.nbr_email_updated_3);

    self.nbr_donotmail_updated_1 := if(cnt=1, r.donotmail, l.nbr_donotmail_updated_1);
    self.nbr_donotmail_updated_2 := if(cnt=2, r.donotmail, l.nbr_donotmail_updated_2);
    self.nbr_donotmail_updated_3 := if(cnt=3, r.donotmail, l.nbr_donotmail_updated_3);

    self.nbr_ProspectAge_updated_1 := if(cnt=1, r.ProspectAge, l.nbr_ProspectAge_updated_1);
    self.nbr_ProspectAge_updated_2 := if(cnt=2, r.ProspectAge, l.nbr_ProspectAge_updated_2);
    self.nbr_ProspectAge_updated_3 := if(cnt=3, r.ProspectAge, l.nbr_ProspectAge_updated_3);

    self.nbr_ProspectGender_updated_1 := if(cnt=1, r.ProspectGender, l.nbr_ProspectGender_updated_1);
    self.nbr_ProspectGender_updated_2 := if(cnt=2, r.ProspectGender, l.nbr_ProspectGender_updated_2);
    self.nbr_ProspectGender_updated_3 := if(cnt=3, r.ProspectGender, l.nbr_ProspectGender_updated_3);

    self.nbr_ProspectMaritalStatus_updated_1 := if(cnt=1, r.ProspectMaritalStatus, l.nbr_ProspectMaritalStatus_updated_1);
    self.nbr_ProspectMaritalStatus_updated_2 := if(cnt=2, r.ProspectMaritalStatus, l.nbr_ProspectMaritalStatus_updated_2);
    self.nbr_ProspectMaritalStatus_updated_3 := if(cnt=3, r.ProspectMaritalStatus, l.nbr_ProspectMaritalStatus_updated_3);

    self.nbr_ProspectEstimatedIncomeRange_updated_1 := if(cnt=1, r.ProspectEstimatedIncomeRange, l.nbr_ProspectEstimatedIncomeRange_updated_1);
    self.nbr_ProspectEstimatedIncomeRange_updated_2 := if(cnt=2, r.ProspectEstimatedIncomeRange, l.nbr_ProspectEstimatedIncomeRange_updated_2);
    self.nbr_ProspectEstimatedIncomeRange_updated_3 := if(cnt=3, r.ProspectEstimatedIncomeRange, l.nbr_ProspectEstimatedIncomeRange_updated_3);

    self.nbr_ProspectCollegeAttended_updated_1 := if(cnt=1, r.ProspectCollegeAttended, l.nbr_ProspectCollegeAttended_updated_1);
    self.nbr_ProspectCollegeAttended_updated_2 := if(cnt=2, r.ProspectCollegeAttended, l.nbr_ProspectCollegeAttended_updated_2);
    self.nbr_ProspectCollegeAttended_updated_3 := if(cnt=3, r.ProspectCollegeAttended, l.nbr_ProspectCollegeAttended_updated_3);

    self.nbr_CrtRecCnt_updated_1 := if(cnt=1, r.CrtRecCnt, l.nbr_CrtRecCnt_updated_1);
    self.nbr_CrtRecCnt_updated_2 := if(cnt=2, r.CrtRecCnt, l.nbr_CrtRecCnt_updated_2);
    self.nbr_CrtRecCnt_updated_3 := if(cnt=3, r.CrtRecCnt, l.nbr_CrtRecCnt_updated_3);

    self.nbr_CrtRecLienJudgCnt_updated_1 := if(cnt=1, r.CrtRecLienJudgCnt, l.nbr_CrtRecLienJudgCnt_updated_1);
    self.nbr_CrtRecLienJudgCnt_updated_2 := if(cnt=2, r.CrtRecLienJudgCnt, l.nbr_CrtRecLienJudgCnt_updated_2);
    self.nbr_CrtRecLienJudgCnt_updated_3 := if(cnt=3, r.CrtRecLienJudgCnt, l.nbr_CrtRecLienJudgCnt_updated_3);

    self.nbr_CrtRecBkrptCnt_updated_1 := if(cnt=1, r.CrtRecBkrptCnt, l.nbr_CrtRecBkrptCnt_updated_1);
    self.nbr_CrtRecBkrptCnt_updated_2 := if(cnt=2, r.CrtRecBkrptCnt, l.nbr_CrtRecBkrptCnt_updated_2);
    self.nbr_CrtRecBkrptCnt_updated_3 := if(cnt=3, r.CrtRecBkrptCnt, l.nbr_CrtRecBkrptCnt_updated_3);

    self.nbr_OccProfLicense_updated_1 := if(cnt=1, r.OccProfLicense, l.nbr_OccProfLicense_updated_1);
    self.nbr_OccProfLicense_updated_2 := if(cnt=2, r.OccProfLicense, l.nbr_OccProfLicense_updated_2);
    self.nbr_OccProfLicense_updated_3 := if(cnt=3, r.OccProfLicense, l.nbr_OccProfLicense_updated_3);

    self.nbr_OccProfLicenseCategory_updated_1 := if(cnt=1, r.OccProfLicenseCategory, l.nbr_OccProfLicenseCategory_updated_1);
    self.nbr_OccProfLicenseCategory_updated_2 := if(cnt=2, r.OccProfLicenseCategory, l.nbr_OccProfLicenseCategory_updated_2);
    self.nbr_OccProfLicenseCategory_updated_3 := if(cnt=3, r.OccProfLicenseCategory, l.nbr_OccProfLicenseCategory_updated_3);

    self.nbr_OccBusinessAssociation_updated_1 := if(cnt=1, r.OccBusinessAssociation, l.nbr_OccBusinessAssociation_updated_1);
    self.nbr_OccBusinessAssociation_updated_2 := if(cnt=2, r.OccBusinessAssociation, l.nbr_OccBusinessAssociation_updated_2);
    self.nbr_OccBusinessAssociation_updated_3 := if(cnt=3, r.OccBusinessAssociation, l.nbr_OccBusinessAssociation_updated_3);

    self.nbr_OccBusinessTitleLeadership_updated_1 := if(cnt=1, r.OccBusinessTitleLeadership, l.nbr_OccBusinessTitleLeadership_updated_1);
    self.nbr_OccBusinessTitleLeadership_updated_2 := if(cnt=2, r.OccBusinessTitleLeadership, l.nbr_OccBusinessTitleLeadership_updated_2);
    self.nbr_OccBusinessTitleLeadership_updated_3 := if(cnt=3, r.OccBusinessTitleLeadership, l.nbr_OccBusinessTitleLeadership_updated_3);

    self.nbr_HHEstimatedIncomeRange_updated_1 := if(cnt=1, r.HHEstimatedIncomeRange, l.nbr_HHEstimatedIncomeRange_updated_1);
    self.nbr_HHEstimatedIncomeRange_updated_2 := if(cnt=2, r.HHEstimatedIncomeRange, l.nbr_HHEstimatedIncomeRange_updated_2);
    self.nbr_HHEstimatedIncomeRange_updated_3 := if(cnt=3, r.HHEstimatedIncomeRange, l.nbr_HHEstimatedIncomeRange_updated_3);

    self.nbr_RaAMmbrCnt_updated_1 := if(cnt=1, r.RaAMmbrCnt, l.nbr_RaAMmbrCnt_updated_1);
    self.nbr_RaAMmbrCnt_updated_2 := if(cnt=2, r.RaAMmbrCnt, l.nbr_RaAMmbrCnt_updated_2);
    self.nbr_RaAMmbrCnt_updated_3 := if(cnt=3, r.RaAMmbrCnt, l.nbr_RaAMmbrCnt_updated_3);

    self.nbr_RaAMedIncomeRange_updated_1 := if(cnt=1, r.RaAMedIncomeRange, l.nbr_RaAMedIncomeRange_updated_1);
    self.nbr_RaAMedIncomeRange_updated_2 := if(cnt=2, r.RaAMedIncomeRange, l.nbr_RaAMedIncomeRange_updated_2);
    self.nbr_RaAMedIncomeRange_updated_3 := if(cnt=3, r.RaAMedIncomeRange, l.nbr_RaAMedIncomeRange_updated_3);

    self.nbr_RaACollegeAttendedMmbrCnt_updated_1 := if(cnt=1, r.RaACollegeAttendedMmbrCnt, l.nbr_RaACollegeAttendedMmbrCnt_updated_1);
    self.nbr_RaACollegeAttendedMmbrCnt_updated_2 := if(cnt=2, r.RaACollegeAttendedMmbrCnt, l.nbr_RaACollegeAttendedMmbrCnt_updated_2);
    self.nbr_RaACollegeAttendedMmbrCnt_updated_3 := if(cnt=3, r.RaACollegeAttendedMmbrCnt, l.nbr_RaACollegeAttendedMmbrCnt_updated_3);

    self.nbr_RaACrtRecMmbrCnt_updated_1 := if(cnt=1, r.RaACrtRecMmbrCnt, l.nbr_RaACrtRecMmbrCnt_updated_1);
    self.nbr_RaACrtRecMmbrCnt_updated_2 := if(cnt=2, r.RaACrtRecMmbrCnt, l.nbr_RaACrtRecMmbrCnt_updated_2);
    self.nbr_RaACrtRecMmbrCnt_updated_3 := if(cnt=3, r.RaACrtRecMmbrCnt, l.nbr_RaACrtRecMmbrCnt_updated_3);

    self.nbr_RaAOccBusinessAssocMmbrCnt_updated_1 := if(cnt=1, r.RaAOccBusinessAssocMmbrCnt, l.nbr_RaAOccBusinessAssocMmbrCnt_updated_1);
    self.nbr_RaAOccBusinessAssocMmbrCnt_updated_2 := if(cnt=2, r.RaAOccBusinessAssocMmbrCnt, l.nbr_RaAOccBusinessAssocMmbrCnt_updated_2);
    self.nbr_RaAOccBusinessAssocMmbrCnt_updated_3 := if(cnt=3, r.RaAOccBusinessAssocMmbrCnt, l.nbr_RaAOccBusinessAssocMmbrCnt_updated_3);

    self := l;
  end;

EXPORT FMac_profile_input(indata) := FUNCTIONMACRO

  ProfileBooster.Layouts.Layout_PB_In Profile_out(RECORDOF(indata) l) := TRANSFORM
    SELF.LexId := l.did;
    SELF.name_first := l.fname;
    SELF.name_middle := l.mname;
    SELF.name_last := l.lname;
    SELF.name_suffix := l.name_suffix;
    SELF.ssn := l.ssn;
    SELF.dob := (String)l.dob;
    SELF.streetnumber := l.prim_range;
    SELF.streetpredirection := l.predir;
    SELF.streetname := l.prim_name;
    SELF.streetsuffix := l.suffix;
    SELF.streetpostdirection := l.postdir;
    SELF.unitdesignation := l.unit_desig;
    SELF.City_name := l.city_name;
    SELF.st := l.st;
    SELF.z5 := l.zip;
    SELF :=[];
    END;

   outdata := PROJECT(indata,Profile_out(LEFT));
  RETURN outdata;
ENDMACRO;

EXPORT ProfileBooster.Layouts.Layout_PB_In Profile_acct(ProfileBooster.Layouts.Layout_PB_In l , integer cnt) := TRANSFORM
  SELF.Acctno := (String30)Hash64(l.LexId,l.name_first,l.name_middle,l.name_last,l.name_suffix,l.ssn,l.dob,l.streetnumber,
                        l.streetpredirection,l.streetname,l.streetsuffix,l.streetpostdirection,l.unitdesignation,l.City_name,l.st,l.z5);
  SELF.seq := cnt;
  SELF := L;
  SELF := [];
END;

END;