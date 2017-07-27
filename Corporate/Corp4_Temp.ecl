//************************************************************
// Process Corporate file in Corp4 Layout
//************************************************************

Corporate.Layout_Corp4_Temp InitCorporate(Corporate.Layout_Corp4 L) := TRANSFORM
// Make sure name, street, city is upper case
SELF.abbrev_legal_name := Stringlib.StringToUpperCase(L.abbrev_legal_name);
SELF.street := Stringlib.StringToUpperCase(L.street);
SELF.orig_city := Stringlib.StringToUpperCase(L.orig_city);
SELF.prior_name := Stringlib.StringToUpperCase(L.prior_name);
SELF.prior_street := Stringlib.StringToUpperCase(L.prior_street);
SELF.orig_prior_city := Stringlib.StringToUpperCase(L.orig_prior_city);
SELF.orig_reg_agent_name := Stringlib.StringToUpperCase(L.orig_reg_agent_name);
SELF.orig_reg_agent_street := Stringlib.StringToUpperCase(L.orig_reg_agent_street);
SELF.orig_reg_agent_city := Stringlib.StringToUpperCase(L.orig_reg_agent_city);
SELF.officer1_name := Stringlib.StringToUpperCase(L.officer1_name);
SELF.officer1_title := Stringlib.StringToUpperCase(L.officer1_title);
SELF.officer1_street := Stringlib.StringToUpperCase(L.officer1_street);
SELF.officer1_city := Stringlib.StringToUpperCase(L.officer1_city);
SELF.officer2_name := Stringlib.StringToUpperCase(L.officer2_name);
SELF.officer2_title := Stringlib.StringToUpperCase(L.officer2_title);
SELF.officer2_street := Stringlib.StringToUpperCase(L.officer2_street);
SELF.officer2_city := Stringlib.StringToUpperCase(L.officer2_city);
SELF.officer3_name := Stringlib.StringToUpperCase(L.officer3_name);
SELF.officer3_title := Stringlib.StringToUpperCase(L.officer3_title);
SELF.officer3_street := Stringlib.StringToUpperCase(L.officer3_street);
SELF.officer3_city := Stringlib.StringToUpperCase(L.officer3_city);
SELF.officer4_name := Stringlib.StringToUpperCase(L.officer4_name);
SELF.officer4_title := Stringlib.StringToUpperCase(L.officer4_title);
SELF.officer4_street := Stringlib.StringToUpperCase(L.officer4_street);
SELF.officer4_city := Stringlib.StringToUpperCase(L.officer4_city);
SELF.officer5_name := Stringlib.StringToUpperCase(L.officer5_name);
SELF.officer5_title := Stringlib.StringToUpperCase(L.officer5_title);
SELF.officer5_street := Stringlib.StringToUpperCase(L.officer5_street);
SELF.officer5_city := Stringlib.StringToUpperCase(L.officer5_city);

// Save original value of charter number
SELF.orig_sos_charter_nbr := L.sos_charter_nbr;
SELF.sos_charter_nbr := MAP(L.state_origin = 'CA' => 'C' + L.sos_charter_nbr,
                        L.sos_charter_nbr);
// Fix NY Status
SELF.status := MAP(L.state_origin = 'NY' AND (L.status IN ['U', ' ']) AND L.term_of_existence_flag = 'D' AND
                     L.term_exist < L.extract_date => 'I',
                   L.state_origin = 'NY' AND (L.status IN ['U', ' ']) AND L.term_of_existence_flag = 'D' AND
                     L.term_exist >= L.extract_date  => 'A',
                   L.status);
// Blank TX File Type, Blank file type if 'O05' Other and foreign domestic
// flag is populated
SELF.file_type := MAP(L.state_origin = 'TX' => '',
                      L.file_type = 'O05' AND L.foreign_domestic_flag <> '' => '',
                      L.file_type);
// Initialize Registered Agent Information in Temp
SELF.reg_agent_name := L.orig_reg_agent_name;
SELF.reg_agent_street := L.orig_reg_agent_street;
SELF.reg_agent_city := L.orig_reg_agent_city;
SELF.reg_agent_state := L.orig_reg_agent_state;
SELF.reg_agent_zip5 := L.orig_reg_agent_zip5;
// Check for 'SAME AS' in  officer_street and copy to officer prim_name
SELF.o1_prim_name := MAP(L.officer1_street[1..7]='SAME AS' => L.officer1_street,
                         L.o1_prim_name);
SELF.o2_prim_name := MAP(L.officer2_street[1..7]='SAME AS' => L.officer2_street,
                         L.o2_prim_name);
SELF.o3_prim_name := MAP(L.officer3_street[1..7]='SAME AS' => L.officer3_street,
                         L.o3_prim_name);
SELF.o4_prim_name := MAP(L.officer4_street[1..7]='SAME AS' => L.officer4_street,
                         L.o4_prim_name);
SELF.o5_prim_name := MAP(L.officer5_street[1..7]='SAME AS' => L.officer5_street,
                         L.o5_prim_name);
// Initialize Address Indicator to Original Address Indicator
SELF.address_ind := L.orig_address_ind;
// Initialize date first seen and date last seen to extract date
SELF.dt_first_seen := L.extract_date;
SELF.dt_last_seen := L.extract_date;
SELF := L;
END;

// Initial Corp4 Base, Exclude MA > 10/2001 and < 06/2002 and NV not 09/29/2001
//   and IL, IA, MI, MO, OK, TX, and WA < 200211
Corp4_Init_Base := PROJECT(Corporate.File_Corp4_Init(state_origin NOT IN ['MA','NV','IL','IA','MI','MO','OK','TX','WA','TN','UT', 'AR','MD','PA','WY', 'MT', 'SD'] OR
                           (state_origin = 'MA' AND (INTEGER)(extract_date[1..6]) <= 200110) OR
                           (state_origin = 'MA' AND (INTEGER)(extract_date[1..6]) >= 200206) OR
						   (state_origin = 'NV' AND (INTEGER)(extract_date[1..8]) <> 20010929) OR
                           (state_origin = 'TN' AND (INTEGER)(extract_date[1..6]) >= 200212) OR
                           (state_origin = 'UT' AND (INTEGER)(extract_date[1..6]) >= 200212) OR
						   (state_origin = 'MT' AND (INTEGER)(extract_date[1..8]) <> 20030420) OR
                           (state_origin IN ['IL','IA','MI','MO','OK','TX','WA'] AND (INTEGER)(extract_date[1..6]) >= 200211) or
						   (state_origin IN ['AR','MD','PA','WY'] AND (INTEGER)(extract_date[1..6]) >= 200302) OR
                           (state_origin = 'SD' AND (INTEGER)(extract_date[1..8]) <> 20030915)), InitCorporate(LEFT));


//************************************************************
// Special initialization process for Nevada
//************************************************************

NevadaPrefixList := ['U-','V-','W-','X-'];

NumChars := ['0','1','2','3','4','5','6','7','8','9'];

Layout_Corp_NV := RECORD
Corporate.Layout_Corp4_Temp;
STRING3  charter_number_prefix;
STRING12 charter_number;
END;

Layout_Corp_NV CleanCharterNum(Corporate.Layout_Corp4_Temp L) := TRANSFORM
SELF.charter_number_prefix := IF(L.sos_charter_nbr[1..2] IN ['U-','V-','W-','X-'], L.sos_charter_nbr[1..2], '  ');
SELF.charter_number := MAP(L.sos_charter_nbr[1..2] IN ['U-','V-','W-','X-'] => L.sos_charter_nbr[3..],
                           L.sos_charter_nbr[1] IN NumChars AND L.sos_charter_nbr[2] IN NumChars AND
                             LENGTH(TRIM(L.sos_charter_nbr)) = 10 => L.sos_charter_nbr[5..9] + '.' + L.sos_charter_nbr[10] + '-' + L.sos_charter_nbr[1..4],
                           L.sos_charter_nbr);
SELF := L;
END;

// Split out prefix and charter number and distribute by charter number
NV_Corp := PROJECT(Corp4_Init_Base(state_origin = 'NV'), CleanCharterNum(LEFT));
NV_Corp_Dist := DISTRIBUTE(NV_Corp, HASH(charter_number));

// Sort and group by charter number and name
NV_Corp_Dist_Sort := SORT(NV_Corp_Dist, charter_number, abbrev_legal_name, LOCAL);
NV_Corp_Grpd := GROUP(NV_Corp_Dist_Sort, charter_number, abbrev_legal_name, LOCAL);
NV_Corp_Grpd_Sort := SORT(NV_Corp_Grpd, IF(charter_number_prefix <> '', 0, 1));

Layout_Corp_NV PropagatePrefix(Layout_Corp_NV L, Layout_Corp_NV R) := TRANSFORM
SELF.charter_number_prefix := MAP(L.charter_number_prefix <> '' AND R.charter_number_prefix = '' => L.charter_number_prefix,
                                  R.charter_number_prefix);
SELF := R;
END;

// Iterate to propagate any prefix and ungroup
NV_Corp_Grpd_Iter := GROUP(ITERATE(NV_Corp_Grpd_Sort, PropagatePrefix(LEFT, RIGHT)));

// Sort and group by charter number and address
NV_Corp_Dist_Sort_Addr := SORT(NV_Corp_Grpd_Iter, charter_number, zip5, prim_name, prim_range, LOCAL);
NV_Corp_Grpd_Addr := GROUP(NV_Corp_Dist_Sort_Addr, charter_number, zip5, prim_name, prim_range, LOCAL);
NV_Corp_Grpd_Addr_Sort := SORT(NV_Corp_Grpd_Addr, IF(charter_number_prefix <> '', 0, 1));

// Iterate to propagate any prefix and ungroup
// Don't propagate if we have blanks in the address (prim_name OR zip5)
Layout_Corp_NV PropagatePrefixAddr(Layout_Corp_NV L, Layout_Corp_NV R) := TRANSFORM
SELF.charter_number_prefix := MAP(L.charter_number_prefix <> '' AND R.charter_number_prefix = '' AND
                                  R.prim_name <> '' AND R.zip5 <> '' => L.charter_number_prefix,
                                  R.charter_number_prefix);
SELF := R;
END;

NV_Corp_Grpd_Iter1 := GROUP(ITERATE(NV_Corp_Grpd_Addr_Sort, PropagatePrefixAddr(LEFT, RIGHT)));

// Search name for specific strings to set prefixes for blank prefixes
NV_Corp_NoPrefix := NV_Corp_Grpd_Iter1(charter_number_prefix = '');

Layout_Corp_NV SetPrefix(Layout_Corp_NV L) := TRANSFORM
SELF.charter_number_prefix := MAP(Stringlib.StringFind(L.abbrev_legal_name, ' LLP ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, ',LLP ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, ' L.L.P. ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, 'LIMITED LIABILITY PART', 1) > 0 => 'U-',
                                  Stringlib.StringFind(L.abbrev_legal_name, ' LLC ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, ',LLC ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, ' L.L.C. ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, 'LIMITED LIABILITY CORP', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, 'LIMITED LIABILITY COMP', 1) > 0 => 'V-',
                                  Stringlib.StringFind(L.abbrev_legal_name, ' L.P. ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, ' LP ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, ',LP ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, 'LIMITED PARTNERSHIP', 1) > 0 => 'W-',
                                  Stringlib.StringFind(L.abbrev_legal_name, ' INC. ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, ' CORP. ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, ',INC. ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, ' CORPORATION ', 1) > 0 OR
                                    Stringlib.StringFind(L.abbrev_legal_name, ' INCORPORATED ', 1) > 0 => 'X-',
                                  '');
SELF := L;
END;

NV_Corp_Fix_Prefix := PROJECT(NV_Corp_NoPrefix, SetPrefix(LEFT));

NV_Corp_Prefix := NV_Corp_Grpd_Iter1(charter_number_prefix <> '') + NV_Corp_Fix_Prefix;

Corporate.Layout_Corp4_Temp FormatNV(Layout_Corp_NV L) := TRANSFORM
SELF.partner_proprietor_flag := MAP(L.charter_number_prefix = 'U-' AND L.partner_proprietor_flag IN ['O', ' '] => 'D',
                                    L.charter_number_prefix = 'V-' AND L.partner_proprietor_flag IN ['O', ' '] => 'C',
                                    L.charter_number_prefix = 'W-' AND L.partner_proprietor_flag IN ['O', ' '] => 'L',
                                    L.partner_proprietor_flag);
SELF.incorp_flag := MAP(L.charter_number_prefix = 'X-' AND L.incorp_flag IN ['U', ' '] => 'I',
                    L.incorp_flag);
SELF.sos_charter_nbr := MAP(L.charter_number_prefix = 'U-' => 'LLP' + L.charter_number,
                            L.charter_number_prefix = 'V-' => 'LLC' + L.charter_number,
                            L.charter_number_prefix = 'W-' => 'LP' + L.charter_number,
                            L.charter_number_prefix = 'X-' => 'C' + L.charter_number,
                            L.charter_number);
SELF := L;
END;

NV_Corp4_Init := PROJECT(NV_Corp_Prefix, FormatNV(LEFT));
COUNT(NV_Corp4_Init);

Corp4_Init := Corp4_Init_Base(state_origin <> 'NV') + NV_Corp4_Init;
COUNT(Corp4_Init);


//************************************************************
// Propagate All Information Forward To Blank Fields
//************************************************************

Corp4_Init_Dist := DISTRIBUTE(Corp4_Init, HASH(state_origin, sos_charter_nbr));
Corp4_Init_Sort := SORT(Corp4_Init_Dist, state_origin, sos_charter_nbr, LOCAL);
Corp4_Init_Grpd := GROUP(Corp4_Init_Sort, state_origin, sos_charter_nbr, LOCAL);
Corp4_Init_Grpd_Sort := SORT(Corp4_Init_Grpd, extract_date);

// Transform assumes if any officer name or city is non-blank, there is a new
// set of officers

Corp4_Init_Propagate := GROUP(ITERATE(Corp4_Init_Grpd_Sort, Corporate.TRA_Corp4_PropagateFields(LEFT, RIGHT)));
COUNT(Corp4_Init_Propagate);

//************************************************************
// Populate Blank Registered Agent from Contact
//************************************************************

RA_Title_Codes := ['39','40'];

Corp4_RA_Blank := Corp4_Init_Propagate(orig_reg_agent_name = '' AND orig_reg_agent_street = '' AND
                                       ((officer1_name <> '' AND officer1_title IN RA_Title_Codes) OR
                                       (officer2_name <> '' AND officer2_title IN RA_Title_Codes) OR
                                       (officer3_name <> '' AND officer3_title IN RA_Title_Codes) OR
                                       (officer4_name <> '' AND officer4_title IN RA_Title_Codes) OR
                                       (officer5_name <> '' AND officer5_title IN RA_Title_Codes)));

Corp4_RA := Corp4_Init_Propagate(NOT(orig_reg_agent_name = '' AND orig_reg_agent_street = '' AND
                                       ((officer1_name <> '' AND officer1_title IN RA_Title_Codes) OR
                                       (officer2_name <> '' AND officer2_title IN RA_Title_Codes) OR
                                       (officer3_name <> '' AND officer3_title IN RA_Title_Codes) OR
                                       (officer4_name <> '' AND officer4_title IN RA_Title_Codes) OR
                                       (officer5_name <> '' AND officer5_title IN RA_Title_Codes))));

Corp4_RA_Blank_Proj := PROJECT(Corp4_RA_Blank, Corporate.TRA_Corp4_MoveContactToRA(LEFT));

Corp4_RA_Updated := Corp4_RA + Corp4_RA_Blank_Proj;
COUNT(Corp4_RA_Updated);
COUNT(Corp4_RA_Updated(reg_agent_source_ind='C'));

//************************************************************
// Determine if Registered Agent is also an Officer
//************************************************************

Layout_Corp4_Temp CheckRAOfficer(Layout_Corp4_Temp L) := TRANSFORM
SELF.ra_officer_also := IF((L.officer1_name <> '' AND L.officer1_title NOT IN RA_Title_Codes
                            AND  L.o1_fname = L.o6_fname AND
                                 L.o1_mname = L.o6_mname AND
                                 L.o1_lname = L.o6_lname AND
                                 L.o1_name_suffix = L.o6_name_suffix) OR
                           (L.officer2_name <> '' AND L.officer2_title NOT IN RA_Title_Codes
                            AND  L.o2_fname = L.o6_fname AND
                                 L.o2_mname = L.o6_mname AND
                                 L.o2_lname = L.o6_lname AND
                                 L.o2_name_suffix = L.o6_name_suffix) OR
                           (L.officer3_name <> '' AND L.officer3_title NOT IN RA_Title_Codes
                            AND  L.o3_fname = L.o6_fname AND
                                 L.o3_mname = L.o6_mname AND
                                 L.o3_lname = L.o6_lname AND
                                 L.o3_name_suffix = L.o6_name_suffix) OR
                           (L.officer4_name <> '' AND L.officer4_title NOT IN RA_Title_Codes
                            AND  L.o4_fname = L.o6_fname AND
                                 L.o4_mname = L.o6_mname AND
                                 L.o4_lname = L.o6_lname AND
                                 L.o4_name_suffix = L.o6_name_suffix) OR
                           (L.officer5_name <> '' AND L.officer5_title NOT IN RA_Title_Codes
                            AND  L.o5_fname = L.o6_fname AND
                                 L.o5_mname = L.o6_mname AND
                                 L.o5_lname = L.o6_lname AND
                                 L.o5_name_suffix = L.o6_name_suffix),
                           'Y',L.ra_officer_also);
SELF := L;
END;

Corp4_RA_Officer := PROJECT(Corp4_RA_Updated, CheckRAOfficer(LEFT));

//************************************************************
// Populate Blank Corporate Address from Registered Agent
//************************************************************

Corp4_CA_Blank := Corp4_RA_Officer(prim_name = '' AND p_city_name = '');
Corp4_CA := Corp4_RA_Officer(NOT(prim_name = '' AND p_city_name = ''));

Corp4_CA_Blank_Proj := PROJECT(Corp4_CA_Blank(NOT(ra_prim_name = '' AND ra_p_city_name = '')), Corporate.TRA_Corp4_MoveRAtoCorpAddress(LEFT));
Corp4_CA_Blank_Not_Proj := Corp4_CA_Blank(ra_prim_name = '' AND ra_p_city_name = '');

Corp4_CA_Updated := Corp4_CA + Corp4_CA_Blank_Proj + Corp4_CA_Blank_Not_Proj;
COUNT(Corp4_CA_Updated);
COUNT(Corp4_CA_Updated(suppress_ra_addr='Y'));


//************************************************************
// Populate Blank Contact/OFficer Address from Corporate Address
//************************************************************

BOOLEAN CheckKeywords(STRING70 street) := 
          street = 'SAME' OR
          street = 'NONE LISTED' OR
          street = 'NONE' OR
          street = 'ADDRESS NOT LISTED' OR
          street = 'ERROR' OR
          street = 'SAME ADDRESS' OR
          street = 'MMMMM' OR
          street = 'ERR' OR
          street = 'ER' OR
          street = 'ENTRY ERROR';


Corporate.Layout_Corp4_Temp SetOfficerBlankFlags(Corporate.Layout_Corp4_Temp L) := TRANSFORM
SELF.o1_addr_blank := IF(L.officer1_name <> '' AND
                               ((L.officer1_street = '' AND L.officer1_city = '' AND
                                 L.officer1_state = '' AND L.officer1_zip = '') OR
                                CheckKeywords(L.officer1_street)), 'Y', 'N');
SELF.o2_addr_blank := IF(L.officer2_name <> '' AND
                               ((L.officer2_street = '' AND L.officer2_city = '' AND
                                 L.officer2_state = '' AND L.officer2_zip = '') OR
                                CheckKeywords(L.officer2_street)), 'Y', 'N');
SELF.o3_addr_blank := IF(L.officer3_name <> '' AND
                               ((L.officer3_street = '' AND L.officer3_city = '' AND
                                 L.officer3_state = '' AND L.officer3_zip = '') OR
                                CheckKeywords(L.officer3_street)), 'Y', 'N');
SELF.o4_addr_blank := IF(L.officer4_name <> '' AND
                               ((L.officer4_street = '' AND L.officer4_city = '' AND
                                 L.officer4_state = '' AND L.officer4_zip = '') OR
                                CheckKeywords(L.officer4_street)), 'Y', 'N');
SELF.o5_addr_blank := IF(L.officer5_name <> '' AND
                               ((L.officer5_street = '' AND L.officer5_city = '' AND
                                 L.officer5_state = '' AND L.officer5_zip = '') OR
                                CheckKeywords(L.officer5_street)), 'Y', 'N');
SELF := L;
END;


Corp4_OA_Blank_Set := PROJECT(Corp4_CA_Updated, SetOfficerBlankFlags(LEFT));

Corp4_OA_Updated := PROJECT(Corp4_OA_Blank_Set, Corporate.TRA_Corp4_MoveCAtoOfficer(LEFT));
COUNT(Corp4_OA_Updated);
COUNT(Corp4_OA_Updated(abbrev_legal_name<>''));
COUNT(Corp4_OA_Updated(abbrev_legal_name=''));

Corp4_Discards := Corp4_OA_Updated(abbrev_legal_name='') : PERSIST('TEMP::Corp4_Discards');

EXPORT Corp4_Temp := Corp4_OA_Updated(abbrev_legal_name<>'') + Corp4_Discards(FALSE) : PERSIST('TEMP::Corp4');