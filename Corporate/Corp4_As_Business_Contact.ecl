IMPORT Business_Header, ut;

//*************************************************************************
// Translate Contact from Corporate to Business Contact Format
//*************************************************************************

BH_File := Business_Header.File_Business_Header;

// Determine if contact date range overlaps company date range
BOOLEAN ValidDateRange(UNSIGNED4 contact_dt_first_seen,
                       UNSIGNED4 contact_dt_last_seen,
                       UNSIGNED4 company_dt_first_seen,
                       UNSIGNED4 company_dt_last_seen) :=
    (contact_dt_first_seen >= company_dt_first_seen AND
        contact_dt_first_seen <= company_dt_last_seen) OR
    (contact_dt_last_seen >= company_dt_first_seen AND
        contact_dt_last_seen <= company_dt_last_seen) OR
    (company_dt_first_seen >= contact_dt_first_seen AND
        company_dt_last_seen <= contact_dt_last_seen);


// Join Corporations from Business Headers and Corresponding Contacts
Corp_Contacts_Dist := DISTRIBUTE(Corporate.File_Corp4_Contacts_Base_DID(state_origin <> '', sos_ter_nbr<>''), HASH(TRIM(state_origin), TRIM(sos_ter_nbr)));
Corp_Business_Headers_Dist := DISTRIBUTE(BH_File(source[1] = 'C', vendor_id[1..2] <> '', vendor_id[3..34] <> ''), HASH(TRIM(vendor_id[1..2]), TRIM(vendor_id[3..34])));

Business_Header.Layout_Business_Contact_Full Translate_Corp4_to_BCF(Corporate.Layout_Corp_Contacts_DID L, Business_Header.Layout_Business_Header_Base R) := TRANSFORM
SELF.did := (UNSIGNED6)L.did;
SELF.company_title := IF(L.officer_title = 'HA', 'REGISTERED AGENT', GetCorpTitle((INTEGER1)L.officer_title));
SELF.vendor_id := (QSTRING34)((STRING34)(L.state_origin+L.sos_ter_nbr));
SELF.source := 'C';
SELF.name_score := Business_Header.CleanName(L.fname,L.mname,L.lname, L.name_suffix)[142];
SELF.city := L.p_city_name;
SELF.zip := (UNSIGNED3)L.zip5;
SELF.zip4 := (UNSIGNED2)L.zip4;
SELF.company_name := R.company_name;
SELF.company_source_group := R.source_group;
SELF.company_prim_range := R.prim_range;
SELF.company_predir := R.predir;
SELF.company_prim_name := R.prim_name;
SELF.company_addr_suffix := R.addr_suffix;
SELF.company_postdir := R.postdir;
SELF.company_unit_desig := R.unit_desig;
SELF.company_sec_range := R.sec_range;
SELF.company_city := R.city;
SELF.company_state := R.state;
SELF.company_zip := R.zip;
SELF.company_zip4 := R.zip4;
SELF.company_phone := R.phone;
SELF.company_fein := R.fein;
SELF.phone := 0;
SELF.email_address := '';
SELF.dt_first_seen := (UNSIGNED4)(L.dt_first_seen);
SELF.dt_last_seen := (UNSIGNED4)(L.dt_last_seen);
SELF := L;
END;

Corp4_Contacts := JOIN(Corp_Contacts_Dist,
                       Corp_Business_Headers_Dist,
                       LEFT.state_origin = RIGHT.vendor_id[1..2] AND
                       LEFT.sos_ter_nbr = RIGHT.vendor_id[3..34] AND
                       ValidDateRange((UNSIGNED4)LEFT.dt_first_seen, (UNSIGNED4)LEFT.dt_last_seen, RIGHT.dt_first_seen, RIGHT.dt_last_seen),
                       Translate_Corp4_to_BCF(LEFT, RIGHT),
                       LOCAL);

EXPORT Corp4_As_Business_Contact := Corp4_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix))  : PERSIST('TEMP::Corp4_Contacts_As_BC');