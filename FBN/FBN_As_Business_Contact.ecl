IMPORT Business_Header, ut;

//*************************************************************************
// Translate Contact from FBN to Business Contact Format
//*************************************************************************

BH_File := Business_Header.File_Business_Header;

// Join FBN Businesses from Business Headers and Corresponding Contacts
FBN_Contact_Names := File_FBN(name_typ <> 'B' AND lname<>'');
FBN_Contact_Names_Dist := DISTRIBUTE(FBN_Contact_Names(file_st <> '', filing_num <> '', filing_dt <> ''), HASH(file_st, TRIM(filing_num), TRIM(filing_dt)));
FBN_Business_Headers_Dist := DISTRIBUTE(FBN_As_Business_Header(vendor_id[1..2] <> '', vendor_id[3..22] <> '', vendor_id[23..30] <> ''), HASH((string2)(vendor_id[1..2]), TRIM((string20)(vendor_id[3..22])), TRIM((string8)(vendor_id[23..30]))));

Business_Header.Layout_Business_Contact_Full Translate_FBN_to_BCF(Layout_FBN L, Business_Header.Layout_Business_Header R) := TRANSFORM
SELF.did := (UNSIGNED6)L.did;
SELF.company_title := MAP(//L.name_typ = 'O' => 'OWNER',
                          L.name_typ = 'O' => 'CONTACT',
                          L.name_typ = 'R' => 'AGENT/REGISTRANT',
                          L.name_typ = 'A' => 'AGENT',
                          L.name_typ = 'F' => 'OFFICER',
                          L.name_typ = 'W' => 'OWNER/AGENT',
                          '');
SELF.vendor_id := R.vendor_id;
SELF.source := 'F';
SELF.name_suffix := L.suffix;
SELF.name_score := Business_Header.CleanName(L.fname,L.mname,L.lname, L.suffix)[142];
SELF.city := L.p_city_name;
SELF.state := L.st;
SELF.zip := (UNSIGNED3)L.zip5;
SELF.zip4 := (UNSIGNED2)L.zip4;
SELF.company_source_group := R.source_group;
SELF.company_name := R.company_name;
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
SELF.phone := (UNSIGNED6)L.phone10;
SELF.email_address := '';
SELF.dt_first_seen := (UNSIGNED4)L.filing_dt;
SELF.dt_last_seen := (UNSIGNED4)IF(L.dt_last_rpt <> '', L.dt_last_rpt + '00',
                           IF(L.dt_first_rpt <> '', L.dt_first_rpt + '00', L.filing_dt));
SELF.record_type := IF(L.filing_num[1..3]='EXP' OR
                    ((INTEGER)L.expiration_dt <> 0 AND ((INTEGER)(L.expiration_dt[5..8]+L.expiration_dt[1..4]) < (INTEGER)Stringlib.GetDateYYYYMMDD())), 'H', 'C');
SELF := L;
END;

FBN_Contacts := JOIN(FBN_Contact_Names_Dist,
                       FBN_Business_Headers_Dist,
                       LEFT.file_st = (string2)(RIGHT.vendor_id[1..2]) AND
                       LEFT.filing_num = (string20)(RIGHT.vendor_id[3..22]) AND
                       LEFT.filing_dt = (string8)(RIGHT.vendor_id[23..30]),
                       Translate_FBN_to_BCF(LEFT, RIGHT),
                       LOCAL);

EXPORT FBN_As_Business_Contact := FBN_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix)) : PERSIST('TEMP::FBN_Contacts_As_BC');