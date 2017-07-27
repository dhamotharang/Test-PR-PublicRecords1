#workunit('name', 'Corporate Stats ' + corporate.Corp4_Build_Date);

Corporations := Corporate.File_Corp4_Base;

// Valid File Type Codes
Set_File_Types := ['A05','A10','A13','A15','A20',
                   'B05','B10','B15','B20',
                   'C05','C10','C15','C20','C25','C30',
                   'D15','D20','D25','D28','D30','D33','D35','D40','D42','D43','D45','D46','D50','D55',
                   'F15','F20','F23','F25','F28','F30','F35','F40','F42','F43','F45','F46','F48','F50','F55','F80','F85',
                   'G05','G08','G10',
                   'H05',
                   'I05','I10','I15',
                   'L05','L10','L14','L15','L20',
                   'M05','M10','M15','M20',
                   'N05','N10','N15','N20','N25','N30','N35','N40','N45',
                   'O05',
                   'P05','P10','P15','P20','P25','P30','P35',
                   'R05','R10','R15',
                   'S05','S10','S15','S20',
                   'T05','T10',
                   'U01','U03','U05',
                   'W05','W10'];

Layout_Corp_Slim := RECORD
string2   state_origin;
string350 abbrev_legal_name;
string1   orig_address_ind;
string70  street;
string32  orig_city;
string2   orig_state;
string9   zip;
string2   incorp_state;
string2   orig_filing_state;
string1   foreign_domestic_flag;
string1   incorp_flag;
string1   partner_proprietor_flag;
string350 orig_reg_agent_name;
string70  orig_reg_agent_street;
string32  orig_reg_agent_city;
string2   orig_reg_agent_state;
string9   orig_reg_agent_zip5;
string32  fed_tax_id_9;
string32  state_tax_id;
string8   sic_code;
string8   date_incorp;
string8   date_orig_filing;
string8   rcnt_filing;
string1   term_of_existence_flag;
string8   term_exist;
string1   profit_code;
string1   status;
string3   status_descp;
string3   file_type;
string8   extract_date;
string6   vendor_nbr;
string1   tracking_code;
STRING350 reg_agent_name;
STRING70  reg_agent_street;
STRING32  reg_agent_city;
STRING2   reg_agent_state;
STRING9   reg_agent_zip5;
STRING1   address_ind;
STRING1   reg_agent_source_ind; 
STRING1   suppress_ra_addr;
STRING1   record_type;
END;

Layout_Corp_Slim InitCorporate(Corporate.Layout_Corporate_Base L) := TRANSFORM
SELF := L;
END;

Corp_Init := PROJECT(Corporations, InitCorporate(LEFT));

Layout_Corp_Stat := record
Corp_Init.state_origin;
INTEGER4  abbrev_legal_name_count := SUM(GROUP, IF(Corp_Init.abbrev_legal_name<>'',1,0));
INTEGER4  orig_address_ind_count := SUM(GROUP, IF(Corp_Init.orig_address_ind<>'',1,0));
INTEGER4  street_count := SUM(GROUP, IF(Corp_Init.street<>'',1,0));
INTEGER4  orig_city_count := SUM(GROUP, IF(Corp_Init.orig_city<>'',1,0));
INTEGER4  orig_state_count := SUM(GROUP, IF(Corp_Init.orig_state<>'',1,0));
INTEGER4  zip_count := SUM(GROUP, IF(Corp_Init.zip<>'',1,0));
INTEGER4  incorp_state_count := SUM(GROUP, IF(Corp_Init.incorp_state<>'',1,0));
INTEGER4  orig_filing_state_count := SUM(GROUP, IF(Corp_Init.orig_filing_state<>'',1,0));

// Foreign Domestic Flag
INTEGER4  foreign_domestic_flag_count:= SUM(GROUP, IF(Corp_Init.foreign_domestic_flag<>'',1,0));
INTEGER4  foreign_domestic_flag_D:= SUM(GROUP, IF(Corp_Init.foreign_domestic_flag='D',1,0));
INTEGER4  foreign_domestic_flag_F:= SUM(GROUP, IF(Corp_Init.foreign_domestic_flag='F',1,0));
INTEGER4  foreign_domestic_flag_U:= SUM(GROUP, IF(Corp_Init.foreign_domestic_flag='U',1,0));
INTEGER4  foreign_domestic_flag_O:= SUM(GROUP, IF(Corp_Init.foreign_domestic_flag='O',1,0));
INTEGER4  foreign_domestic_flag_other:= SUM(GROUP, IF(Corp_Init.foreign_domestic_flag<>'' AND
                                                      (Corp_Init.foreign_domestic_flag NOT IN ['D','F','U','O']),1,0));
INTEGER4  foreign_domestic_flag_blank:= SUM(GROUP, IF(Corp_Init.foreign_domestic_flag='',1,0));


// Icorp Flag
INTEGER4  incorp_flag_count := SUM(GROUP, IF(Corp_Init.incorp_flag<>'',1,0));
INTEGER4  incorp_flag_I := SUM(GROUP, IF(Corp_Init.incorp_flag='I',1,0));
INTEGER4  incorp_flag_N := SUM(GROUP, IF(Corp_Init.incorp_flag='N',1,0));
INTEGER4  incorp_flag_U := SUM(GROUP, IF(Corp_Init.incorp_flag='U',1,0));
INTEGER4  incorp_flag_other := SUM(GROUP, IF(Corp_Init.incorp_flag<>'' AND
                                            (Corp_Init.incorp_flag NOT IN ['I','N','U']),1,0));
INTEGER4  incorp_flag_blank := SUM(GROUP, IF(Corp_Init.incorp_flag='',1,0));

// Partner Proprietor Flag
INTEGER4  partner_proprietor_flag_count := SUM(GROUP, IF(Corp_Init.partner_proprietor_flag<>'',1,0));
INTEGER4  partner_proprietor_flag_G := SUM(GROUP, IF(Corp_Init.partner_proprietor_flag='G',1,0));
INTEGER4  partner_proprietor_flag_L := SUM(GROUP, IF(Corp_Init.partner_proprietor_flag='L',1,0));
INTEGER4  partner_proprietor_flag_O := SUM(GROUP, IF(Corp_Init.partner_proprietor_flag='O',1,0));
INTEGER4  partner_proprietor_flag_P := SUM(GROUP, IF(Corp_Init.partner_proprietor_flag='P',1,0));
INTEGER4  partner_proprietor_flag_S := SUM(GROUP, IF(Corp_Init.partner_proprietor_flag='S',1,0));
INTEGER4  partner_proprietor_flag_D := SUM(GROUP, IF(Corp_Init.partner_proprietor_flag='D',1,0));
INTEGER4  partner_proprietor_flag_C := SUM(GROUP, IF(Corp_Init.partner_proprietor_flag='C',1,0));
INTEGER4  partner_proprietor_flag_U := SUM(GROUP, IF(Corp_Init.partner_proprietor_flag='U',1,0));

INTEGER4  partner_proprietor_flag_other := SUM(GROUP, IF(Corp_Init.partner_proprietor_flag<>'' AND
                                                        (Corp_Init.partner_proprietor_flag NOT IN ['G','L','O','P','S','D','C','U']),1,0));
INTEGER4  partner_proprietor_flag_blank := SUM(GROUP, IF(Corp_Init.partner_proprietor_flag='',1,0));

INTEGER4  orig_reg_agent_name_count := SUM(GROUP, IF(Corp_Init.orig_reg_agent_name<>'',1,0));
INTEGER4  orig_reg_agent_street_count := SUM(GROUP, IF(Corp_Init.orig_reg_agent_street<>'',1,0));
INTEGER4  orig_reg_agent_city_count := SUM(GROUP, IF(Corp_Init.orig_reg_agent_city<>'',1,0));
INTEGER4  orig_reg_agent_state_count := SUM(GROUP, IF(Corp_Init.orig_reg_agent_state<>'',1,0));
INTEGER4  orig_reg_agent_zip5_count := SUM(GROUP, IF(Corp_Init.orig_reg_agent_zip5<>'',1,0));
INTEGER4  fed_tax_id_9_count := SUM(GROUP, IF(Corp_Init.fed_tax_id_9<>'',1,0));
INTEGER4  state_tax_id_count := SUM(GROUP, IF(Corp_Init.state_tax_id<>'',1,0));
INTEGER4  sic_code_count := SUM(GROUP, IF(Corp_Init.sic_code<>'',1,0));
INTEGER4  date_incorp_count := SUM(GROUP, IF(Corp_Init.date_incorp<>'',1,0));
INTEGER4  date_orig_filing_count := SUM(GROUP, IF(Corp_Init.date_orig_filing<>'',1,0));
INTEGER4  rcnt_filing_count := SUM(GROUP, IF(Corp_Init.rcnt_filing<>'',1,0));

// Term of existence flag
INTEGER4  term_of_existence_flag_count := SUM(GROUP, IF(Corp_Init.term_of_existence_flag<>'',1,0));
INTEGER4  term_of_existence_flag_D := SUM(GROUP, IF(Corp_Init.term_of_existence_flag='D',1,0));
INTEGER4  term_of_existence_flag_N := SUM(GROUP, IF(Corp_Init.term_of_existence_flag='N',1,0));
INTEGER4  term_of_existence_flag_P := SUM(GROUP, IF(Corp_Init.term_of_existence_flag='P',1,0));
INTEGER4  term_of_existence_flag_U := SUM(GROUP, IF(Corp_Init.term_of_existence_flag='U',1,0));
INTEGER4  term_of_existence_flag_other := SUM(GROUP, IF(Corp_Init.term_of_existence_flag<>'' AND
                                                       (Corp_Init.term_of_existence_flag NOT IN ['D','N','P','U']),1,0));
INTEGER4  term_of_existence_flag_blank := SUM(GROUP, IF(Corp_Init.term_of_existence_flag='',1,0));

INTEGER4  term_exist_count := SUM(GROUP, IF(Corp_Init.term_exist<>'',1,0));

// Profit Code
INTEGER4  profit_code_count := SUM(GROUP, IF(Corp_Init.profit_code<>'',1,0));
INTEGER4  profit_code_N := SUM(GROUP, IF(Corp_Init.profit_code='N',1,0));
INTEGER4  profit_code_P := SUM(GROUP, IF(Corp_Init.profit_code='P',1,0));
INTEGER4  profit_code_U := SUM(GROUP, IF(Corp_Init.profit_code='U',1,0));
INTEGER4  profit_code_other := SUM(GROUP, IF(Corp_Init.profit_code<>'' AND
                                            (Corp_Init.profit_code NOT IN ['N','P','U']),1,0));
INTEGER4  profit_code_blank := SUM(GROUP, IF(Corp_Init.profit_code='',1,0));

// Status
INTEGER4  status_count := SUM(GROUP, IF(Corp_Init.status<>'',1,0));
INTEGER4  status_A := SUM(GROUP, IF(Corp_Init.status='A',1,0));
INTEGER4  status_I := SUM(GROUP, IF(Corp_Init.status='I',1,0));
INTEGER4  status_U := SUM(GROUP, IF(Corp_Init.status='U',1,0));
INTEGER4  status_F := SUM(GROUP, IF(Corp_Init.status='F',1,0));
INTEGER4  status_D := SUM(GROUP, IF(Corp_Init.status='D',1,0));
INTEGER4  status_R := SUM(GROUP, IF(Corp_Init.status='R',1,0));
INTEGER4  status_T := SUM(GROUP, IF(Corp_Init.status='T',1,0));
INTEGER4  status_other := SUM(GROUP, IF(Corp_Init.status<>'' AND
                                        (Corp_Init.status NOT IN ['A','I','U','F','D','R','T']),1,0));
INTEGER4  status_blank := SUM(GROUP, IF(Corp_Init.status='',1,0));

// Status Description
INTEGER4  status_descp_count := SUM(GROUP, IF(Corp_Init.status_descp<>'',1,0));
INTEGER4  status_descp_valid := SUM(GROUP, IF(Corp_Init.status_descp<>'' AND (INTEGER)Corp_Init.status_descp >= 1
                                                                         AND (INTEGER)Corp_Init.status_descp <= 80,1,0));
INTEGER4  status_descp_invalid := SUM(GROUP, IF(Corp_Init.status_descp<>'' AND (INTEGER)Corp_Init.status_descp < 1
                                                                         AND (INTEGER)Corp_Init.status_descp > 80,1,0));
INTEGER4  status_descp_blank := SUM(GROUP, IF(Corp_Init.status_descp='',1,0));

// File Type
INTEGER4  file_type_count := SUM(GROUP, IF(Corp_Init.file_type<>'',1,0));
INTEGER4  file_type_valid := SUM(GROUP, IF(Corp_Init.file_type<>'' AND (Corp_Init.file_type IN Set_File_Types),1,0));
INTEGER4  file_type_invalid := SUM(GROUP, IF(Corp_Init.file_type<>'' AND (Corp_Init.file_type NOT IN Set_File_Types),1,0));
INTEGER4  file_type_blank := SUM(GROUP, IF(Corp_Init.file_type='',1,0));

INTEGER4  extract_date_count := SUM(GROUP, IF(Corp_Init.extract_date<>'',1,0));
INTEGER4  vendor_nbr_count := SUM(GROUP, IF(Corp_Init.vendor_nbr<>'',1,0));
INTEGER4  tracking_code_count := SUM(GROUP, IF(Corp_Init.tracking_code<>'',1,0));
INTEGER4  reg_agent_name_count := SUM(GROUP, IF(Corp_Init.reg_agent_name<>'',1,0));
INTEGER4  reg_agent_street_count := SUM(GROUP, IF(Corp_Init.reg_agent_street<>'',1,0));
INTEGER4  reg_agent_city_count := SUM(GROUP, IF(Corp_Init.reg_agent_city<>'',1,0));
INTEGER4  reg_agent_state_count := SUM(GROUP, IF(Corp_Init.reg_agent_state<>'',1,0));
INTEGER4  reg_agent_zip5_count := SUM(GROUP, IF(Corp_Init.reg_agent_zip5<>'',1,0));

// Address indicator
INTEGER4  address_ind_count := SUM(GROUP, IF(Corp_Init.address_ind<>'',1,0));
INTEGER4  address_ind_A := SUM(GROUP, IF(Corp_Init.address_ind='A',1,0));
INTEGER4  address_ind_B := SUM(GROUP, IF(Corp_Init.address_ind='B',1,0));
INTEGER4  address_ind_C := SUM(GROUP, IF(Corp_Init.address_ind='C',1,0));
INTEGER4  address_ind_E := SUM(GROUP, IF(Corp_Init.address_ind='E',1,0));
INTEGER4  address_ind_F := SUM(GROUP, IF(Corp_Init.address_ind='F',1,0));
INTEGER4  address_ind_H := SUM(GROUP, IF(Corp_Init.address_ind='H',1,0));
INTEGER4  address_ind_M := SUM(GROUP, IF(Corp_Init.address_ind='M',1,0));
INTEGER4  address_ind_P := SUM(GROUP, IF(Corp_Init.address_ind='P',1,0));
INTEGER4  address_ind_O := SUM(GROUP, IF(Corp_Init.address_ind='O',1,0));
INTEGER4  address_ind_R := SUM(GROUP, IF(Corp_Init.address_ind='R',1,0));
INTEGER4  address_ind_other := SUM(GROUP, IF(Corp_Init.address_ind<>'' AND
                                            (Corp_Init.address_ind NOT IN ['A','B','C','E','F','H','M','P','O','R']),1,0));
INTEGER4  address_ind_blank := SUM(GROUP, IF(Corp_Init.address_ind='',1,0));

// Registered Agent source indicator
INTEGER4  reg_agent_source_ind_R := SUM(GROUP, IF(Corp_Init.reg_agent_source_ind='R',1,0));
INTEGER4  reg_agent_source_ind_C := SUM(GROUP, IF(Corp_Init.reg_agent_source_ind='C',1,0));

// Suppress Registered Agent Address
INTEGER4  suppress_ra_addr_Y := SUM(GROUP, IF(Corp_Init.suppress_ra_addr='Y',1,0));
INTEGER4  suppress_ra_addr_blank := SUM(GROUP, IF(Corp_Init.suppress_ra_addr='',1,0));

// Record Type
INTEGER4  record_type_C := SUM(GROUP, IF(Corp_Init.record_type='C',1,0));
INTEGER4  record_type_H := SUM(GROUP, IF(Corp_Init.record_type='H',1,0));

INTEGER4 total:= COUNT(GROUP);
END;

Corp_Stat := TABLE(Corp_Init, Layout_Corp_Stat, state_origin, FEW);

OUTPUT(Corp_Stat);