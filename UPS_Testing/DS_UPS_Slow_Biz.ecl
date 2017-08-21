import UPS_Services;
Constants := UPS_Services.constants;
export DS_UPS_Slow_Biz := DATASET( [
    { 'E', '', '', 'WATTS', '', 'CALDWELL', 'ID', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '6834 NW 77TH CT', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WESSEL', '', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'POPPLER', '867 CLEVELAND AVE S', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEARS ROEBUCK CO', 'RICHMOND RD', '', 'OH', '44143', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ST FERDINAND CHURCH', 'CORONEL', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ESCROW FOR YOU', 'OCEAN VIEW', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JERRY GADDIS', '6TH ST', 'MORGAN CITY', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '8116 S TRYON ST', 'CHARLOTTE', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '9821KATY FWY', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ARBOR OAKS', '715 SEMINOLE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SGT CRISTIAN CRUZ', '14555  SCHOOL ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ENDO PHARMA', '100  ENDO WAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'HAROLD', '', '', 'MILLER', '195 CO RT', 'MEXXIO', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HOMETOWN HEALTH CARE', '1681  WOODBRIDGE PARK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'GLORIA', '', '', 'NOMURA', '8TH', 'STOCKTON', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '28 WESTHAMPTON WAY', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KENDRA MARTIN', 'SUMMIT AVE', 'GREENSBORO', '', '27405', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1830 1ST AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PATTY', '', '', 'MITCHELL', '4981 MONTEZUMA', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'UNION VILLAGE CENTER', '', 'UNION', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MELODY', '', '', 'LEIGHANN', 'TREESONG RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LEE', '', '', 'BAYLESS', '1110 3RD AVE', 'SEATTLE', 'WA', '98101', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WAL MART', '1030  HUNTERS CROSSING DR', 'CYPRESS', 'TX', '77429', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BANK OF AMERICA', 'MEETING ST', 'CHARLESTON SC 29401', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A 1 PRO HOME SERVICE', '', '', 'MD', '20602', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '8500 BLUEBONNET', 'BATON ROUGE', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PURVEY', '1ST', 'GAINESVILLE', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CTS', '', 'YORK', 'PA', '17404', '', Constants.TAG_ENTITY_BIZ }
  , { 'KATHY', '', '', 'MULLER', '3825 TAMARA', '', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'AL', '', '', 'STONE', '125 OLD FINCHER DR', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LUANN', '', '', 'RICHARD', 'LAKEVIEW', '', 'MI', '48467', '', Constants.TAG_ENTITY_BIZ }
  , { 'CYNTHIA', '', '', 'J', '331 HILTON TERRACE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOE', '', '', 'FLORES', '', 'SAN JUAN PUEBLO', 'NM', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RON', '', '', 'RAMSEY', '', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAMES', '', '', 'ADAMS', '', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RE NU', '32ND', 'GRAND RAPIDS', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BREINLNIGER', '212  DICKERSON HOLLOW LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CSI', '5351  HWY 311', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ST CLAIR TOWNSHIP', 'JACKSON', 'OVERPECK', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TO A TEE', '7125 GIRLS SCHOOL AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '314 E 41 ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GUIMARAES', '207 22ND', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CABINET SHOWROOM', 'MAIN', '', 'NY', '11944', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SHARON MCGINNIS', '105 E IVY BRIDGE DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KONNAND', '117 N MAIN ST', '', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MEH GERALD CHU', '605  BODE WEST RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RUTH', '', '', 'WRIGHT', 'PO BOX 9839', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'MCFARLAND', '702 N COLLEGE AVE    APT 4', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MYERS', '160 COZAD', '', 'OH', '45434', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EVANS', '871 DYKE', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HENDRICK', '1255 FRANKLIN ALEXANDER', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '600  MERIDIAN ST EXT', 'GROTON', 'CT', '6340', '', Constants.TAG_ENTITY_BIZ }
  , { 'BREE', '', '', 'SMITH', '533 NE 3RD AVE', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PHUONG', '', '', 'PHAM', 'MAIN ST', 'HERSHEY', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'QUARTERMAN', 'FOREST MOUNTAIN', '', 'VT', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PC MALL', '', 'MEMPHIS', 'TN', '38118', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HOOTEN CONSTRUCTION', 'CORNERSVILLE HWY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'WILLIAM', '', '', 'WARD', '', 'NEWMAN', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'A', '', '', 'CAIRO', '', 'STATEN ISLAND', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BEAR', '2518 BROWN MILL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALLEN DULANEY', 'MAGNOLIA ST', 'EDWARDS', 'MS', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DIANE', '', '', 'OCONNOR', '1050  OAK CREEK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ELIZABETH', '', '', 'BLUM', 'DOBY RIDGE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'ZELKE', '', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'C&S AUTO REPAIR', 'MAIN ST', 'TARBORO', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAMES', '', '', 'MADY', '110  DRAPER LN     1G', 'HASTINGS ON HUDSON', '', '0', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOSEPH', '', '', 'RUMORE', '374 STOCKHOLM ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RABUL', '15419 GREAT GLEN LN', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KENNEY', '7', 'CENTENNIAL', 'CO', '80112', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '13501 KATY  FWY', 'HOUSTON', 'TX', '77382', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'U S BORAX', '14486  BORAX RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DIVA', '', 'LOUISVILLE', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DANNY', 'R', '', 'WOOTEN', '', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FISKAA AUTO SALES', 'W MAIN ST', 'NELLISTON', 'NY', '13410', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROBERT OLSON', '3833RD ST', 'LAGUNA BEACH', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GIVENS', '', '', '', '38109', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'T N & ASSOCIATES', 'S ILLINOIS AVE', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ANDREW', '', '', 'GOODWILL', 'PINE', '', 'PA', '16748', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '430 S CAPITOL ST', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '150 MONUMENT RD', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOE', '', '', 'DUNN', '113 OMER ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ATHOL ANIMAL CONTROL', 'MAIN ST', 'ATHOL', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STEWART', '281', 'LEXINGTON', 'KY', '40503', '', Constants.TAG_ENTITY_BIZ }
  , { 'STEPHEN', '', '', 'PEARL', '1056 CHURCHILL ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SALEM AQUATIC CENTER', '1287 G.A.R. DRIVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ATT', '', 'LOUISVILLE', 'KY', '40212', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHELLE', '', '', 'WALSTON', 'PO BOX 17608', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HEATHER LEWIS', '7300 W 110TH ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KIM', '', '', 'SANDERS', '3874 BLACK HOLLOW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARIA', '', '', 'RIVERIA', '3340 RESIVOUR RD NW', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MANTECA EQUIPMENT RENTAL', 'MAIN', 'MANTECA', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'WATTS', '6561 NW 21ST CT', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALLIED WASTE', '7100  CHURCH RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'USCHO', '22510 HIGHWAY 7', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ERIC', '', '', 'LAI', '5470', 'LA JOLLA', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'J SMITH', '1591  JULIUS ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KIM', '', '', 'ROBERTSON', '502 BAR CK RANCH', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BLAKE ROBINSON', '6866  ROYAL HARVEST WAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MONAHAN', '1055 LISMORE LN', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CLARK', 'BAYVIEW AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HAWS', '179', '', 'NY', '11763', '', Constants.TAG_ENTITY_BIZ }
  , { 'LORI', '', '', 'DELUCCA', '204 CLYDESDALE CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '6975 W 2ND LN', 'HIALEAH', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CMYK DESIGN', '9808 NW 80TH AVE', '', 'FL', '33016', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HALLEY', '', '', '', '62206', '', Constants.TAG_ENTITY_BIZ }
  , { 'AUDREY', '', '', 'CREWELL', 'W BARNET', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'HOWARD', '', '', 'BRYANT', 'WOODLAND ST', '', '', '38401', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CRAWFORD & CO', '', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BIRD DOG CAT FISH', '', 'SAN ANTONIO', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '319 LAFAYETTE ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JUST 2 TEASE', '835 NE GREEN OAKS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JOHN GUSTAFSON', '2823  RIVERVIEW DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SANDY', '', '', 'FAWZI', '300 COLUMBUS CIR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CURRY', '226 BROGILEAU AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BOB', '', '', 'BROOKS', '9443 MISERY POINT RD NW', '', 'WA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'GUSTAFSON', '2823 RIVERVIEW DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '225 PARK AVE S', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ATT', '15240 MAIN ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'DUNLAP', '18616 LAKELAND DR', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'NICK', '', '', 'TORRES', '9460 106TH AVE N', 'LARGO', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CAROL', '', '', 'CAMPBELL', '', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IVY', '600', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '520 S PARK RD', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KELLYS', '201  PUTNAM ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A KAETER', '', 'ST CLOUD', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JULIA', '', '', 'FREEMAN', '4112 26TH TERRACE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'HWY 90', '', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRENDA', '', '', 'ROSS', '325 MARKET ST', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '11301 ROCKVILLE PIKE', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FIORELAS', '7008 LAKE CHARLESTON SHORE BLVD', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SUSAN', '', '', 'LODENQUAI', '3RD', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'YOLANDA', '', '', 'HOCK', 'MAIN ST', 'LISBON', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WS STONE', 'CREEK SIDE RD', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JESUS', '', '', 'ROJAS', '11  RETOSE', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KATHY', '', '', 'BIONDI', '1315 VALLEY CT', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROB', '', '', 'REA', '250  M ST EXT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'NADINE', '', '', 'BUENO', '8593 HOLLOWAY', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'J W MCCORMICK', '', 'BOSTON', 'MA', '2109', '', Constants.TAG_ENTITY_BIZ }
  , { 'BILL', '', '', 'PRIEST', '201 EAST JOHN CARPENTER FWY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LSI', 'E 4TH STREET', 'GREELEY', 'CO', '80631', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '6031 NW 99TH AVE', 'MIAMI', 'FL', '33178', '', Constants.TAG_ENTITY_BIZ }
  , { 'DON', '', '', 'FLOWERS', '2409 CO RD 205', 'HEADLAND', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'YVETTE', '', '', 'WILLIAMS', '844', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'MORRIS', '3608 SOMMERVILLE PL RD', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3415 S SEPULVEDA', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DUMAS', '', 'INVERNESS', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TINA', '', '', 'GROMAN', '4831  35TH AVE SW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PC PRO', 'DEPOSIT DR', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '. NICOLE HAWKINS', '11052  SANTE FE ST N', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KEVIN', '', '', 'MCCAUL', 'WASHINGTON ST', 'CAMBRIDGE', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NICHOLS', 'ROBY', '', 'NH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MANDY', '', '', 'MAIER', '3674 NORTH PEACHTREE RD', 'ATL', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '117 HOLLEMAN', 'COLLEGE STATION', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RALPH', '', '', 'HENRY', '11 S MERIDIAN RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SHIPMAN', '2725 S 6TH', '', 'NE', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DEBBIE HAMMES', '1400  EASTEX VETERINARY CLINIC', 'HUMBLE', 'TX', '77338', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3336 EDENBORN AVE', 'METARIE', 'LA', '70002', '', Constants.TAG_ENTITY_BIZ }
  , { 'C', '', '', 'JEWELL', '18213 JONAMAC AVE', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'FRANK', '', '', 'DUTTON', '66 GARDENS RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BROADWAY SQUARE APARTMENTS', '8751  BROADWAY', 'HOUSTON', 'TX', '77461', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '8720 N KENDALL DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAMES', '', '', 'WILSON', '1901 CREEK RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '557 BROADWAY', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '636 11TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THE JUDY COMPANY', '5 & OAKE ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CARLTON', '', '', 'HICKS', '640 MAIN ST', 'CLERMONT', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SMITH', '', '', '', '48843', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PROCO', '', 'STOCKTON', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CTS TECH', '', 'INDIANAPOLIS', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FROOTS', '640 W CROSVILLE RD', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'K1432719720', '', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'W LINCOLN AVE', 'ATLANTIC HIGHLANDS', 'NJ', '7716', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SAMS CLUB', '738 ARBOR CIRCLE DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'J SMITH', '1591  JULIUS ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MENDEZ', '', 'EAGLE PASS', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DOLLY', '', '', 'HARRIS', 'HICKORY', 'GARY', 'IN', '46403', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CHAPMAN CORP.', 'ELM DR', 'WAYNESBURG', 'PA', '15301', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2839 PACES FERRY RD', 'ATLANTA', 'GA', '30326', '', Constants.TAG_ENTITY_BIZ }
  , { 'M', '', '', 'SANCHEZ', '', 'NEW HAVEN', 'CT', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'J MART JAPANESE GROCERY STORE', '', 'VIRIGNIA BEACH', 'VA', '23462', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GRACE', ' LOW', '18  BIRCHWOOD PARK DR', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AT&T', '1000  NORTH POINT', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KUM AND GO', '121ST ST', 'DES MOINES', 'IA', '50322', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'MAZZEI', '16 W 751 56TH ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CAROL', '', '', 'CARLIN', '123 MAIN 209', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KOHL S', '', 'MENTOR', 'OH', '44060', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SIMMS', '6714 MESQUITE CT', 'DISTRICT HEIGHTS', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ADI', '3060 PRAIRIE VALLEY CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KENNY', '', '', 'DOLL', '3544 TABLE ROCK', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CRL', 'STE 120', 'CARROLLTON', 'TX', '75006', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HAROLD WILSON', 'WILSON MOUNTAIN', 'DOUGLAS CITY', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CENTRUM', 'HUBBARD', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ELIZABETH', '', '', 'BLUM', 'DOBY RIDGE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LINDA', '', '', 'FLEMING', '', 'DOUGLASVILLE', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRACY', '322 CLEVELAND ROAD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '8849 VILLA LA JOLLA DR', 'LA JOLLA', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BECKETT', 'PATTERSON', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CHEVALIER', '32259', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PATRICK', '', '', 'RAY', '49TH PL', '', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THOMAS W CUMMINGS', 'THOMAS W CUMMINGS', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRACEY', '4030 S QUENTNO DR', 'CHANDLER', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SHANNON KEOGH', 'OAK AVE', 'CUBA', 'MO', '65453', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A', '267 RICHLAND ST', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ANTHONY LITTLETON', '21773  STATE RTE 1', 'GUILFORD', 'IN', '47022', '', Constants.TAG_ENTITY_BIZ }
  , { 'DAVID', '', '', 'COSSAOU', 'MONTCALM', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2185 BOLTON STREET', 'BRONX', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LUCAS', '', '', '', '20774', '', Constants.TAG_ENTITY_BIZ }
  , { 'ALEXYS', '', '', 'RUCKDASCHEL', '7TH AVE SE', 'JAMESTOWN', 'ND', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RICHARD', '', '', 'BALDWIN', '118 ARAPAHOE RIDGE', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'XEDIN TECH', 'STE 100E', 'ROUND ROCK', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STOTT', 'MAIN ST', 'WONEWOC', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A PEAK EQUIP', '', 'OKLAHOMA CITY', 'OK', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '241 CENTRAL PARK', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HORNE', '', '', '', '75243', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHRISTINA', '', '', 'MILLER', '6192 FRANCIS', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BOROUGH OF ATLANTIC HIGHLANDS', 'W LINCOLN AVE', 'ATLANTIC HIGHLANDS', 'NJ', '7716', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GARCIA', '', 'BLUNTZER', 'TX', '78025', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'D & M SUPPLY', '510 CAVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THOMPSON CONTRACTING', '101  PETFINDER LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RIVERA', '10 BROAD ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'XANDER', '195 NE 10TH AVE', 'MIAMI', 'FL', '33179', '', Constants.TAG_ENTITY_BIZ }
  , { 'VICTORIA', '', '', 'BELL', '4818 WOODLAND ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '505 UNIVERSITY DR', 'COLLEGE STATION', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HECTOR TOPIO', '3456  FULTON ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'HARRY', '', '', 'BRILL', '8 TOWN LINE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LONDONDERRY', '574 MAMMOTH RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DENNIS', '', '', 'BROWN', 'WALNUT ST STE 200', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHARLIE', '', '', 'BOYLE', 'POB 511', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '451 MEADOW LANE', '', 'CO', '80439', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '300 PARK AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3001 NE 185TH ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MIKE MCCALL', '616 OCEAN FRONT', 'NEWPORT BEACH', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'R', '', '', 'GRIFFIN', '1303 WYNDHAM DR', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JERRY', '', '', 'MESSER', '15 S 5TH', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARY', '', '', 'WILSON', '819 ETH', 'MITCHELL', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KATHERINE', '', '', 'SHIRILLA', '6169 EMORY LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JOHN GUSTAFSON', '2823  RIVERVIEW DR', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ANN KENNEDY', '10 KNOLLCREST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JOSE MANUEL ALARES', '11', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MELISSA', '', '', 'MACE', '12008 BROWN RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'R', '', '', 'WALSH', '36023 SAINT TOPEZ', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BUSBY', '950 WHITESETTLEMENT', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'NICK', '', '', 'HERNANDEZ', '', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CAPRI POOLS', '1287 G A R DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRUJILLO', '643', 'BOULDER', 'CO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SAM BURRS', '1078  MALLARD LN', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DE4BBIE', '', '', 'STEPHENS', '57 S WALNUT BEND RD', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JACKSON', '9256 KORN BRUST DR', '', 'CO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '158', 'NORTH VENICE', 'FL', '34275', '', Constants.TAG_ENTITY_BIZ }
  , { 'SUZANNE', '', '', 'MOE', 'TWIN BRIDGE DR', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DEMBA  DIALLO', '968 NORLAKE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'AARON', '', '', 'JOHNSON', 'MORRIS', 'FAYETTEVILLE', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARIA', '', '', 'LEON', '15TH ST', '', 'DC', '20005', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'DE NEVE DR', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LOWES', '3460 JEFFERSON PK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'VINCENT', '', '', 'RANDAZZO', '9106  SUMMER WAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'PRISCILLA', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RANDALL', '', 'WINTER PARK', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MERCER', '', 'NEW YORK', 'NY', '10036', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOLLAR GENERAL', '', 'SYLACAUGA', 'AL', '35150', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PAYNE', '2119 RIVERROCK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PAYNE', '2119 RIVERROCK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BENNETT', '3101', 'RICHMOND', 'VA', '23221', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JOSEPH MORANDI DO', '665  MARTINSVILLE RD    STE 218', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HEATHER LEWIS', '7300 W 110TH ST    STE 670', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BATTLE', '', '', '', '1852', '', Constants.TAG_ENTITY_BIZ }
  , { 'YVETTE', '', '', 'WILLIAMS', '844', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SCHINDLER', '', 'SAGINAW', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RYDER', '103 COMMERCE CIR', '', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEARS', '', 'ELYRIA', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '208 E 51ST ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GATEWAY MALL', '', 'BRONX', 'NY', '10451', '', Constants.TAG_ENTITY_BIZ }
  , { 'JULIA', '', '', 'FREEMAN', '4112 26TH TERRACE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'J', '606 RUTH ST', '', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RILEE KELSEY', 'RR 1', 'BONE GAP', 'IL', '62815', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '5S. NICOLE HAWKINS', '11052  SANTE FE ST N', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PRITI', '', '', 'PRITI JANA', '135  BRIARWOOD DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LEE', '98 ARBOUR LN', '', 'FL', '33428', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ORTING WWTP', '902 ROCKY ROAD NE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ALISON', '', '', 'CLIFFORD', '25 26TH AVENUE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FEDCO', '1363 CAPITAL DR', '', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JEAN WILLIE', '12053 HWY 1078', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2301 W SAHARA', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'GAYLE', '', '', 'JOHNSON', '', 'FORT SMITH', 'AR', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RUTH', '', '', 'JANSEN', '', 'LARGO', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LARK', 'SAGEBRUSH', 'DALLAS', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'USPS', 'MAIN ST', 'FLORA', 'MS', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DS WATERS', '', 'RIVERSIDE', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DENARD', '140 TABGLEWOOD DR', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1300 HOLLMAN ST', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2800 LASALLE PLZ', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JUSTIN', '', '', 'WILLIS', '', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JASON', '', '', 'HUANG', '5078', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PEGGY', '', '', 'BARTO', 'LOCUST', '', 'PA', '15003', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'V', '33 AXIS MONDI RD', '', 'ME', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BINKS', '', 'BROOKLYN', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BLOCKBUSTER', '', 'MCKINNEY', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DAVID KAPP', '100  VETERANS HWY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'M', '4206  GENSEN DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '300 W 21ST ST', 'NEW YORK CITY', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'C', '', '', 'PARK', '124 GRAND AVE', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MCWILLIAMS', '2141 E 500 N', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BRUN', '', 'SHREVEPORT', 'LA', '71107', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRIAN', '', '', 'JONES', '205 .BLUEBIRD', '', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CYNTHIA', '', '', 'KERSEY', '', '', 'AZ', '85050', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROLANDO', '', '', 'GOMEZ', '5629 CHILDER ST', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LORD', '333 W PERSHING RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JANUS', '', 'TEMPLE', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LORD', '333 W PERSHING RD', '', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '8200 JONES BRANCH DR', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LISA', '', '', 'BENDER', '7429 US HIGHWAY 522', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SIEMENS BUILDING TECH', '', 'CLEVELAND', 'OH', '44125', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '811 VERMONT AVE', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SW MISSOURI CREDIT UNION', '', 'SPRINGFIELD', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN C', '', '', 'HOWE', '', '', 'CT', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHRIS', '', '', 'MUYLLE', '11650  LANTERN RD    STE 216', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1701 N STATE ST', '', 'MS', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '414 W 120TH ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WYNNS', '', 'STATESBORO', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CYNTHIA', '', '', 'ADAMS', 'CENTRAL AVE', 'ALBANY', 'NY', '12206', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GRAVES', '2831 QUAIL HOLLO', 'FARMINGTON HILLS', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LUCAS', '', 'PEARISBURG', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WRIGHT', '2141 COLLETTE LN', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'A', '', '', 'MARTIN', '111 OBRIAN WAY', '', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'DRUMHELLER', '5 FAWN LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JERRY', '', '', 'GILLESPIE', '7504 N BROOKLYN PL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'ELM', 'MASON CITY', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '800 N CAPITOL ST NW', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '12900 GARDEN GROVE', 'GARDEN GROVE', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PROVIDENCE O CHRISTMAS TREES', '4831  35TH AVE SW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KIMBERLY', '', '', 'KNAPP', '1214 COUNTRY GARDEN LANE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'LAKESIDE DR', 'GRANBY', 'CT', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALAM INVESTMENT LLC', 'JIM BOUHACHEM AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BABLITZ', '438 MORRISSVILLE RD APT 3D', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JANE JOHNSTON', '778  UNION RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SUSAN C PACKIE', 'WOODLAND RD', 'GREEN VILLAGE', 'NJ', '79350071', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALLEN', '107 CHEROKEE', '', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KELLEY', '', '', 'MATTHEWS', 'N STATE ST', 'BRANDON', 'MS', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FAMILY DOLLAR', 'HIGH', 'HAMILTON', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HUGHES', '', '', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DONOFRIO', '320199  PO BOX', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALLISON JOHNSON', '814 N MARKET ST 2', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CHRISTOPHER RANDALL', '1140  BROADWAY     STE 1604', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CINDY', '', '', 'CLARK', '', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A', '15  BICENTENNIAL CIR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1732 SW 5TH CT', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MILLER', '2034 TOWNE LAKE HILLS', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DONNA', '', '', 'KENT', '97 VALLEY RD', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ERIC', '', '', 'SUTTON', '14744 TWIN BAYS RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EDS', '101 WOODCREST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ANDREW', '', '', 'GOODWILL', 'PINE', '', 'PA', '16743', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WEGMANS', '5360 GENESEE ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARY', '', 'COLD SPRING', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'I', '', '', 'DRIVAS', '34 COLESHEERS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RAMSEY', '40108 MOURA', 'PALMDALE', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEZ', '13  TH AVE', 'BROOKLYN', 'NY', '11219', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'RYAN', '128 S MT VERNON AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LUIS', '', '', 'RIVERA', '10 BROAD ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '\\', '1681 WOODBRIDGE PARK', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ZUNIGA', '38423', 'PALMDALE', 'CA', '93551', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HARAIZ', '', 'WEST COLUMBIA', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ICE CREAM 4 YOU', '', 'LARGO', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CONSTANANCE', '', '', 'LEITNER', '229 DOUGLAS ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HAGINS', '', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALLEN', '808 CAMBRIDGE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'GEORGE', '', '', 'PETERSON', '127 MARTIN BURG LN', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'DAMES FERRY RD', 'FORSYTH', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CRILLY', '', '', '', '75025', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JH KNIGHT II', 'PEACHTREE RD', 'ATLANTA', 'GA', '30324', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TURNER', '', 'SPRINGFIELD', 'MO', '65809', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CLOUTIER', 'PO', '', 'ME', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BANK OF AMERICA', 'CHESTNUT ST', '', 'CT', '6811', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SHINKER', '22 GREEN ST', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '840 N LARRABEE ST', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KOSCH', '7951 BELLAGIO DR', '', 'NE', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STATER BROS', '375 DE BERRY', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DANIEL E', '', '', 'AMES', '4953 MARY LOUISE CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TERRY ALLUMS', '173 WOODWORTH AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRUCE', '', '', 'OSTERWELL', '17TH AVE', 'SAN FRANCISCO', 'CA', '94121', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '163 AMSTERDAM', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HARRIS', '', '', '', '55407', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'MORRICE', '', 'HOUSTON', 'TX', '77005', '', Constants.TAG_ENTITY_BIZ }
  , { 'DEMBA', '', '', 'DIALLO', '968 NORLAKE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARTIN', '184 ALHAMBRA WAY', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CATHERINE', '', '', 'WELLS', '12503 5TH NW', 'SEATTLE', 'WA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LISA', '', '', 'BONET', '', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TIMEWISE', '', 'WILLIS', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '274 MADISON AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ICENOGLE', '842 SUNDOWN LN', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CHRYSALIS SALON AND SPA', '4610 GARFIELD', 'MIDLAND', 'TX', '79705', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'SOMERSET COURT', 'NEWPORT', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ECKSTEIN', 'CARDINAL CREEK', '', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DANIEL', '', '', 'MACHOWIZ', '6235 VENICE DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'STACY', '', '', 'ROBINSON', '', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '702 N COLLEGE AVE', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PHYLLIS A', '', '', 'SWARTZ', '262 KOLB RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '621 S NEW BALLAS', 'ST LOUIS', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JESSE', '', '', 'BREWER', '', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HENDRICK', '1255 FRANKLIN ALEXANDER', '', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MCAFEE', 'FRANKLIN', 'LA VALLE', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FAMILY DOLLAR INC', '67TH AVE', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CITY OF GIRARD', 'RR 1', 'SPRINGFIELD', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DAN', '', '', 'MACLEAN', '5829 GREENHAVEN DR', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GILLERAN', '2991 11 MILE', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KEITH', '', '', '', 'SMITH', '', 'MN', '56065', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1005 MACON HWY', 'ATHENS', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ALLEN', '', '', 'DIAZ', '', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HORNETS', '2000 SEGNETTE BLVD', '', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ELIZABETH', '', '', 'BLUM', '4137 DOBY BRIDGE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THE SHIRTS', '13  TH AVE', 'BROOKLYN', 'NY', '11219', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'COOPER', '107 MERITAGE ST', 'GREER', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRACEY', '4030 S QUENTNO', 'CHANDLER', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'MAIN ST', 'EVANSVILLE', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MSH', '5009 HONEYGO', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SULLIVAN COMPUTER CORP / DATA  DOC', '521  SOLOMON WAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CLARK CINDY', '22724 BAYVIEW AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'KNIGHT', '5631 ST RT 505', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KAI', '', '', 'BRAY', '', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'POINTER', '714 W 111TH ST', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ANNE', '', '', 'LARSON', '', 'PLEASANTON', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SMITH', '3109 W 80TH', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2961 INDUSTRAIL RD', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ANDREW', '', '', 'SMITH', '10 ATHORPE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROBICHEAU', '19TH', 'MONTELLO', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DEB', '', '', 'MURRAY', '20 XMAS TREE', '', 'NH', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'EDGAR B', '', '', 'DICKSON', '', 'MELBOURNE BEACH', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LAUREN', '', '', 'GALLIGAN', 'RIDGE', '', 'NY', '10598', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MCDONALDS', '', 'INVERNESS', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GFS', '1672  MARION MT GILEAD RD', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MATT', '', '', 'WOLFF', '88 STEELE ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DE LEON', 'PARK MEADOWS', 'CHULA VISTA', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MACKENZIE', 'COLONIAL', 'SAINT CLAIR SHORES', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BABLITZ', '438 MORRISSVILLE RD APT 3D', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'J', '', '', 'WEBER', '8TH', 'EL PASO', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WAI LEUNG LAM', '2329  24TH AVE    FL 3', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ASHLEY', '', '', 'TAYLOR', '4594 TERRACE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EMPI', '1281 BROWN ST', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DIEBOLD', 'RIFKIN', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PUROCLEAN   TRENARY', '2419  COUNTRY CLUB ROAD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CRAIG', '', '', 'FENNEMORE', 'CENTRAL', '', 'AZ', '85323', '', Constants.TAG_ENTITY_BIZ }
  , { 'LEON', '', '', 'PEREZ SANCHEZ', '7922 PINES BLVD', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IRS', '844 KING ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'PRICE', 'BROWNSVILLE', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'YVETTE', '', '', 'WILLIAMS', 'KING ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TRACY', '', '', 'MOORE', '', 'MONROE', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROSEBERRY', '', '', 'TIMBER', 'CENTRAL AVE', '`', 'CO', '80459', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '18101 LORAIN', 'CLEVELAND', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GLOBAL', '', 'SAN ANTONIO', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '255 W 43RDST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MOSS CHIROPRACTIC', '1805 SE 16TH AVE', 'OCALA', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FURNITURE 4 LESS', '124 W. 4TH', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MORTON', '337 CROSBY RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2900 VIA FORTUNA', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LINDSEY FOSTER', '1  DISCOVERY PL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DEBBIE GARRETT', '1415  JACKSONVILLE HWY', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FOGLE', '5515 TARRINGTON', 'FAYETTEVILLE', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALLEN', '29 E 700 N', 'PROVO', 'UT', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'REEBOK', '', 'ORLANDO', 'FL', '32819', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GREEN', '2530 TUSCARAWAS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SHELLY', '', '', 'BROWN', '', 'SUMTER', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JONES', '13600  EVERGREEN', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DEBORAH', '', '', 'LANG', '', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '301 GEORGE BUSH DR', 'COLLEGE STATION', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KMART', '1151 S OTSEGO AVE', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PATRICIA', '', '', 'BARRON', '', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'AMANDA', '', '', 'DECKER', 'GREENWOOD PLACE', 'LOUISVILLE', 'KY', '40272', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CYCLERY', '3308 W 44TH', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '509 MADISON AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'TOPSY LN', 'CARSON CITY', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FORD', 'CLINTON AVE', 'MINNEAPOLIS', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'K.O.N.E.', '', 'NEWARK', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IRS', '2716  COBRE VALLE LN', 'PLANO', 'TX', '75023', '', Constants.TAG_ENTITY_BIZ }
  , { '[AUL', '', '', 'MALONEY', '', '', 'MA', '1257', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1 PINEHURST CIR', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EDJ LEASING C/O COLLIER', '130  EDWARD JONES BLVD', 'MARYLAND HEIGHTS', 'MO', '630433000', '', Constants.TAG_ENTITY_BIZ }
  , { 'RICHARD', '', '', 'MOORE', '307 COLLIN LANE', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SC DEPT OF PROB. PAROLE & PARDON', '160  LAWENFORCE CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CAROL', '', '', 'KELLEY', '2863 KELLEYS GLEN', '', 'WA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RENT 1ST', '1320 NW SHERIDAN     STE 102', '', 'OK', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KLEINBERG ELECTRIC INC', '/E  15TH ST', 'BROOKLYN', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MOS', '1421 CHAMBERS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MOS', '1421 CHAMBERS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'EXCHANGE ST', 'LEOMINSTER', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THE TRANNY SHOP', 'SOUTH MAIN ST', 'PALMER', 'MA', '1069', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOLTON BEARS', '6479  MADISEN LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JETRO CASH CARRY', '1030 W DIVISION', 'CHICAGO', 'IL', '60643', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '731 VISTA ISLES DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RAYMORE', 'HIGHLAND', '', 'PA', '19355', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'OTHERWISE', 'E7577 SMITH ROAD', '', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ANNE', '', '', 'JACKSON', '', 'ST LOUIS', 'MO', '63116', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HACH', '', 'FORT COLLINS', 'CO', '80538', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '4031 NE 17TH TER', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'WILLIAM', '', '', 'COOK', '230 BOWMANS BOTTOM', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CORONADO MEDICAL GROUP', 'PROSPECT', 'CORONADO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '11 MARTIME AVE', 'WHITE PLAINS', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MANORCARE', '505  WEYMAN RD', 'WHITEHALL', 'PA', '18052', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'FIRST', 'SARALAND', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'G', '201 MAPLEBROOK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SANDERS', 'GORDON', '', 'MS', '38930', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CHRISTMAN', '3795 LEONARD', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ELIZABETH', '', '', 'BLUM', '4137 DOBY BRIDGE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '4447 N CENTRAL', 'DALLAS', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRANNY SHOP', 'SOUTH MAIN ST', 'PALMER', 'MA', '1069', '', Constants.TAG_ENTITY_BIZ }
  , { 'PERE', '', '', 'PERS', '1414 MADISON AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'H&R BLOCK', '', 'FRIENDSHIP', 'WI', '539340491', '', Constants.TAG_ENTITY_BIZ }
  , { 'RICARDO', '', '', 'MEJIA', 'LAKEVIEW DR', 'WESTON', 'FL', '33326', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KUKLA', '', '', '', '43623', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HENDRICK', '1255 FRANKLIN ALEXANDER', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ARMSTRONG', 'NORRIS FERRY', 'SHREVEPORT', 'LA', '71106', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TATTOO ROLO', '39 E PULTENEY ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JAMES E LONG', '1016 W EDGEWOOD DR', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'CARTER', 'APT 306', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DURA COOL', '4944 GLEN LANE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ANNE', '', '', 'TAYLOR', '', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SHELL OIL', '3333 ROUTE 6 S', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'VINALHAVEN WATER DISTRICT', 'MAIN', 'VINALHAVEN', 'ME', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MOORE', '203', 'CLEVELAND', 'TX', '77328', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'PACIFIC AVE', 'WEDNESBURY', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SANCHEZ', '374 SIERRA MADRE', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WWTP', '902 ROCKY ROAD NE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MIKE', '', '', 'MORRIS', '5TH & OAK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RETAIL', '137 HWY 87', '', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IRS', '201 TOWER PARK', 'WATERLOO', 'IA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LEIGHANN', 'TREESONG RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AAA AUTO CLUB SO', '601 EAST ATLANTIC BLVD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALFA', '', 'FISHERS', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ANDREW', '', '', 'SMITH', '10 ATHORPE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5217 OLD SPICEWOOD SPRINGS RD', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CATHY', '', '', 'WAGNER', '312 N LIBERTY', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOLLAR GENERAL 9767', '', 'CLEVELAND', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MIKE', '', '', 'RUSSO', '', '', 'RI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CAROL', '', '', 'SCOTT', '68 GRANDVIEW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BUCHAN', '5016 SADDLE HORN', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHARLEY', '', '', 'COOK', '851  TIP TOP RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HOMETOWN HEALTH CARE', '1681 WOODBRIDGE PARK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IPOLITO', '824 S MACDILL AVE', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NATIONAL PARK INN', '5945 CORN HUSTER DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARILYNN', '', '', 'MASON', '6025 GARCIA', 'KAUFMAN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1540 BROADWAY', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'CEDAR CREEK', 'CONROE', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NEES', ' KAY E', '1120 E HOWARD MILLER DR', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MCGINEES', '', 'WILMINGTON', 'DE', '19808', '', Constants.TAG_ENTITY_BIZ }
  , { 'TIFFANY', '', '', 'REED', '5121 SWEET BAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KAMAN IND. TECH.', '', 'MARIETTA', 'GA', '30066', '', Constants.TAG_ENTITY_BIZ }
  , { 'VICTORIA', '', '', 'BELL', '4818 WOODLAND ST', '', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NACE DENNIS', 'HIGHLAND', 'LOGANVILLE', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NVEC', '10323 LOMOND DR', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BLAKE ROBINSON', '6866  ROYAL HARVEST WAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WERTH', '11100 SHELBY OAKS DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'AUGUSTA', 'SAVANNAH', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'COLLEEN CARROL', '3731  TANGLEWOOD LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CARDON', 'SYCAMORE', 'LOS ALAMOS', 'NM', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MONICA', '', '', 'GARCIA', '', 'MIAMI', 'FL', '33183', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5000 SW 75TH AVE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'SMITH', '', 'ALBUQUERQUE', 'NM', '87112', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARIA', '', '', 'RIVERIA', '3340 RESIVOR RD NW', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'COUNTY ROAD E', 'WESTFIELD', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HACH', '', 'FORT COLLINS', 'CO', '80537', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2857 NE 32ND ST', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'ELLIS', '', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TOM', '', '', 'WILLIAMS', '4900  FROLICH LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MULGREWS', 'CARELTON ST', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MI T M CORPORATION', '', '', 'IA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'V. MONROE/MARTE KLIESH', 'APT 4102', 'LARGO', 'FL', '33773', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PARSONS', '', 'RENO', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DEBORAH', '', '', 'BATTISTO', '2240 MORTON GROVE ROAD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DAVID', '', '', 'REED', '12067 7TH AVENUE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'YARNELL', 'BROADWAY', '', 'AZ', '85362', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRAD', '', '', 'JOHNSON', 'SUMMERSTON', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARCO', '', '', 'ESTRADA', '308 N PRIMROSE LN', 'STANFIELD', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'L', '8119 TOWNLEY ROAD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HARTLEY', '3211', 'RICHMOND', 'VA', '23221', '', Constants.TAG_ENTITY_BIZ }
  , { 'STACIE', '', '', 'ROBINSON', '', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RANDY', '', '', 'PREJEAN', '673 LAKEWOOD DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BELL', '', '', 'ME', '4901', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2999 NE 199TH ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'STATE RD', 'KULPTOWN', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KEVIN', '', '', 'CLARK', '', 'WALLACETON', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'GAIL', '', '', 'TYLER', '289 FLOWER COURT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MASON', 'E 8TH AVE', 'BIRDSBORO', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MULLEN', '', '', '', '77096', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BEARS GRAPHIC & SCREENING', '7307  GEORGE WASHINGTON MEM HWY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GRUBER & CO', 'STE 1040', 'ATLANTA', 'GA', '30328', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1 MAIN STREET', 'ROOSEVELT ISLAND', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GARNER METAL', 'S MAIN ST', 'MONROE', 'OH', '45050', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'THE LAURELS', 'ENFIELD', 'CT', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DIANE KELLY', '6415 BABCOCK', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LISA LANDIS', '100 S LOGAN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HELLER', '282 VIA NARANGA', '', 'FL', '33432', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GT FEILDS', '', 'BIRMINGHAM', 'AL', '35259', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A', '267 RICHLAND', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'K', '', '', 'VALDES', '', 'DAYTON', 'OH', '45434', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KELLOGGS', '', 'CHICAGO', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '10560 MAIN ST', 'ALEXANDRIA', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MEAG NEW YORK', '544  MADISON AVE', 'NY', 'NY', '10022', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'L', '2557 WALNUT PIKE DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHNSON', '', '', 'SMITH', '', 'JOPLIN', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'COSTA', '', 'NAMPA', 'ID', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'HEATHER', '', '', 'LOWE', '801 AVE E', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARLYS', '', '', 'OLSON', '', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '8977 WILES RD', 'CORAL SPRINGS', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '305 FAYETTE ST', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BOBBY', '', '', 'MILLIGAN', 'WATER WOOD DR', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HALEY', 'RIVERVIEW', 'STOCKTON', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CAROL', '', '', 'ROKOSS', '9703 COMMON CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAMES', '', '', 'DAVIS', '13692 FM 1994', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RICK', '', '', 'LEWIS', '5956 SMITH HILL RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'OCONNOR', '1050 OAK CREEK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JACKSON', '606 RUTH ST', '', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHRIS', '', '', 'MUYLLE', '11650  LANTERN RD    STE 216', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAMES', '', '', 'GACKSTETTER', '18TH AVE NO', 'ST CLOUD', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'YUE LI', 'WEST     APT 3508', 'CHICAGO', '', 'IL', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'POWELL', '2604 THOMSON TOWN RD', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARCUS', '', '', 'WARE', '859 CONVENTION CENTER BLVD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'K&B AUTO SALES', '', 'HICKORY', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DESIREE ROGERS', '3303 W CREST ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JILL', '', '', 'NEWMAN', '10107 GARY RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FERGUSON', '55500  GRAND RIVER AVE', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ZIETLOW', '', '', '', '49456', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'MAIN ST', 'CANTON', 'MS', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAMES', '', '', 'STARKEY', '', 'CLARKSBURG', 'WV', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SCHAFFER', 'RR1 BOX135', 'DUBOIS', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'UNIDENT', '1818', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JAMES LUI', '7301 BAYMEADOWS WAY', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DAN', '', '', 'BILLMAN', '2802A LUCON RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SC JOHNSON', 'GRAND', 'RACINE', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SHINDE', '279 WINTHROP ST N', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '110 SE 24TH ST', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JIM', '', '', 'BELOW', '453 FOREST AVE', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SMITHS', '5TH', 'COVINGTON', 'KY', '41011', '', Constants.TAG_ENTITY_BIZ }
  , { 'ALBERT', '', '', 'CULTON', '', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'A', '', '', 'CAIRO', '507 MYRTLE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THIESSE', '1675 STELLER CT', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KEN', '', '', 'MAYO', '247 FULTON RUN RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1901 6TH AVE N', '', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RYAN', '1305 W ENOS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FEREDOM ABSTRACT CORP', '105  MAXESS RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GAP', '', 'SAN FRANCISCO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KELONE', '', 'PEORIA', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JAMES BUCCI', '2  RIVERSIDE DR    STE 502', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SCHLICHT', '20921  LAHSER RD', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEARS', '', 'PONTIAC', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'M', '', '', 'BRONERSKY', 'MAIN ST 2ND FLOOR', 'LOUISVILLE', 'KY', '40212', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JOHN BILLION', '7769  ISLAND DR', 'MIRAMAR', 'FL', '33023', '', Constants.TAG_ENTITY_BIZ }
  , { 'RANDY', '', '', 'MYERS', '', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JEVAN', '', '', 'JOHNSON', 'KAITE TODD DR', '', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1901 BRICKELL AVE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ARIAS SPA', 'PEACHTREE RD', 'ATLANTA', 'GA', '30324', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GREGORY M. CHAIT', '1201 W PEACHTREE ST NE', 'ATLANTA', 'GA', '30307', '', Constants.TAG_ENTITY_BIZ }
  , { 'DIANE', '', '', 'OCONNOR', '1050 OAK CREEK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ALICE', '', '', 'JONES', '', 'SACRAMENTO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SHARON', '', '', 'SWEENEY', '', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'GERI', '', '', 'ERICKSON', '551 XIMINES LANE N', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LIZ', '', '', 'MEYERS', '', 'LUBBOCK', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '408 NE 6 ST', '', 'FL', '33304', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WHITTIER', 'N 56TH WAY', 'SCOTTSDALE', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5900 NW 46 TERR', '', 'FL', '33319', '', Constants.TAG_ENTITY_BIZ }
  , { 'B', '', '', 'MOORE', '', 'BOSTON', 'MA', '2215', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WA YAN IRENE  KWOK', 'WEST     APT 2714', 'CHICAGO', '', 'IL', '', Constants.TAG_ENTITY_BIZ }
  , { 'ELLEN', '', '', 'FOSTER', 'PO BOX 2835', 'BIRCH RUN', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DELL', '', 'OKLAHOMA CITY', 'OK', '62', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MACHULIS', '147 CRAWFORD RD', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRAYLOR', '98 ST ANDREWS DR', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SUNG BOOTH', '3RD ST', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '33 S 6TH ST', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CINTAS', '', 'SPARKS', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GADDIS', '', 'FAIRFIELD', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROSS', 'KIETZKE LN', 'RENO', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3914 MURPHY CANYON RD', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DYNAMIC SIGHTS AND SOUNDS', 'PECAN LN', 'SALISBURY', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'F & J SERVICE CENTER', '', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DOROTHY', '', '', 'WALTER', '', '', 'PA', '16662', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHARLES', '', '', 'HOFFMAN', '3250 S LEHIGH GORGE DR', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PARSONS', '', 'RENO', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2301 VANDERBILT PL', 'NASHVILLE', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'HENRY', '', '', 'SCHEIN', '27468  WORLD CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'G', '201 MAPLEBROOK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'THEODORE', '', '', 'VAZQUEZ', '4522 HOFFNER RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'C', '', '', 'COOK', '851 TIP TOP RD', '', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RMCI', '', 'ALBUQUERQUE', 'NM', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAMES', '', '', 'BROWN', '327 RAYBROOK ROAD', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BARNICLE', '908 CANONERO DR', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AQUATIC CENTER', '1287', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'VERIZON', '035 SEARCH RING', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SEAN', '', '', 'HIGGINS', 'FAIRVIEW', 'SWARTHMORE', 'PA', '19081', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'STATE RD', 'KULPTOWN', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CARPENTER', '275 RIVERCREST DR', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STOTT', 'MAIN ST', 'UNION CENTER', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MEG', '', '', 'LINDBERG', '3RD ST', '', 'CO', '80440', '', Constants.TAG_ENTITY_BIZ }
  , { 'GAIL', '', '', 'TYLER', '289 FLOWER COURT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3 LONG WHARF', 'NEW HAVEN', 'CT', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KELLY', '', '', 'PIERCE', '', '', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KIM', '', '', 'HO', '2ND ST', '', 'LA', '7420', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DR. WEINER', '', 'MERRICK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KNIGHT', '', '', '', '25414', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JAMES', '', 'DOUGLASVILLE', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HESS CORP', '', 'TAMPA', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LINDA', '', '', 'PHEE', '58  WITCHTOWN RD    APT 503', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'RODGERS', '', 'DUBLIN', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOE', '55  BLACKBERRY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'VAUGHN', '815 BRIDA WREATH', '', 'MD', '21208', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '8529 CANDLEWOOD DR', 'OKLAHOMA CITY', 'OK', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FRYDA CASTILLO', '530  ARLINGTON PL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LIVINGSTON FAMILY CARE CENTER', '1ST', 'FAIRBURY', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SAM', '', '', 'RYBURN', '338 SHARON AMITY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CITI TREND', 'LINCOLN HWY', 'MATTESON', 'IL', '60443', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WALTER ELIAS', '4585 N SYCAMORE', 'LOS ANGELES', 'CA', '90065', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'POPA', '', 'LAS VEGAS', 'NV', '89139', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1078 MALLARD', 'PEOTONE', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MINGLEDORFFS', '5165 KENNEDY RD', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PETER', '', '', 'MASON', 'E 8TH AVE', 'BIRDSBORO', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PETER', '', '', 'MASON', '4220 E 8TH AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAN', '', '', 'DEIS', '5650 NW 56TH PL', 'OCALA', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ARMSTRONG', '7245 GREEN MEADOWS', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHRISTOPHER', '', '', 'GEHM', '3 BAY WILLOW CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LIU', '', 'MALDEN', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CURRIE', '477 EMORY OAKS DR', 'BRYAN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'US BUREAU OF CUSTOMS AND BORDE', '', 'MIAMI', 'FL', '33122', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRADLEY', '', '', 'YOUNG', '', 'NEWBURY', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SHARON', '', '', 'JOHNSON', '9975 GARSONS WAY NW', '', 'WA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '4550 POST OAK PLACE', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WAYNE CENTER', '30  WEST AVE', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MCDONALD', '', '', 'MI', '48346', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'LONDON WAY', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EVERGREEN COMMONS', 'STATE', 'HOLLAND', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CAPRI POOLS', '1287 GAR DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JANET', '', '', 'MCFARLANE', '3RD', 'SYKESVILLE', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '9000 SHERIDAN ST', 'HOLLYWOOD', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHRIS', '', '', 'NELSON', '809 W PENNSYLVANNIA AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'XEROX CORP', '', 'LONG BEACH', 'CA', '90745', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RATNER', '4308 MORNINGSIDE', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ZINTERHOFER', '165 MAIN ST', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'UNITED STATES', 'HWY 16', 'MARION', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '900 W. GROVE PKWY', '', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SPAGNOLIA', '10 POINT RICH', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NAVARRO', '3529  INDIAN CREEK WAY     B', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NAVARRO', '3529  INDIAN CREEK WAY     B', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RANDALL CLEARY', '4550 POST OAK PLACE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SIMMONS', 'N 10TH', 'KILLEEN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MASTERFOODS', '3186  CANYON RD     H0AF472N', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MELODY', '', '', 'LEIGHANN', '', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DANNY', '3776 GENELEVA', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STRONG', 'LAKEVIEW DR', 'HANOVERTON', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ARMSTRONG', '7035 LAKEVIEW DR', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'STEPHEN', '', '', 'TYREE', '532  NORTH AVE W', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JONATHAN', '', '', 'TORRES', '304 AVE H APT A', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TWC', '', 'COSTA MESA', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ST MARKS CHURCH', 'MULBERRY', 'BELLAIRE', 'TX', '77401', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '4041 ESSEN', 'BATON ROUGE', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MOORE', '', '', '', '63028', '', Constants.TAG_ENTITY_BIZ }
  , { 'RONALD', '', '', 'HERRING', '11920 NORTH HILL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WACHOVIA BANK', '1525 W WT HARRIS BLVD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2601 S OLIVE', 'PINE BLUFF', 'AR', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'OWENS', 'HILL RD', 'ONEIDA', 'NY', '13421', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WHITNEY HOLLADAY', 'COUNTY ROAD 17', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LANS', '', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SHADE', '7013 EBONY CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '112 N MAIN ST', '', 'IA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'M', '4206 N GENSEN DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'USPS', '153 MAIN STREET', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARLENE', '', '', 'REALI', '615 E RIVER RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'INFINEX INVESTMENTS', 'MAIN', 'FREDERICK', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '709', 'ALBANY', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRIAN', '', '', 'JONES', '205 BLUEBIRD', '', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'J', '', '', 'HOLLIDAY', '7025 FRANDALL AVE', '', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HOOKER', '311 GOODLAND', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1401 PEACHTREE ST', 'ATL', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3 WASHINGTON CIRCLE', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KRAFT FOODS', '250 NECK ROAD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BERNARD', '', '', 'PORTER', '361 JONES AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '350 HUDSON ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'J D K', 'ELK TRAIL', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARTHA MORSE', '915  WAVERLY RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'M', 'JUDICIARY SQ', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '11301 WILSHIRE', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LIDO', '', 'DALLAS', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TREVA', '', '', 'BROWN', 'BLANCHE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BUIKEMA', 'STATE', 'HOLLAND', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'EVERGREEN LN', 'PALM CITY', 'FL', '34990', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRENT', '32288 PLEASENT RIDGE', '', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KOALA T CARE LEARNING CENTER', '', 'LIBERTY', 'MO', '64068', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'C A BEAN', '', '', 'MD', '20659', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HD SUPPLY', '', 'RIVERSIDE', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '101 WASHINGTON AVE S', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SUZANNE', '', '', 'GIESZER', '', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HARTMAN', 'JEFFERSON ST', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TOM', '', '', 'EVANS', '102 BELCHER ST', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'SCHMIDT', '1819  ALLIGATOR ST', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2900 UNIVERSITY SQ', 'TARPON SPRINGS', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STROUHALS TIRE', '', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ERIC', '', '', 'SUTTON', '14744 TWIN BAYS RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ADAM', '', '', 'SZUBIN', '1300 PENNSYLVANIA AVE NW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1 MAIN ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'T MOBILE', '', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CITITREND', 'LINCOLN HWY', 'MATTESON', 'IL', '60443', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BAILEY', '13630 CYNTHIANA', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SPINA & ADAMS COLLISION', '1161 OAKS RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARSHALL', '658 POWERS FERRY', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5TH ST SE', 'CAIRO', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3322 W END AVE', 'NASHVILLE', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1320 MAIN ST', 'COLUMBIA', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BEAR', '2518 BROWN MILL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HOMETOWN HEALTH CARE', '1681  WOODBRIDGE PARK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LIGHTING SUZUKI', '14523 N FLORIDA', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'R A SHORT CO', '', 'MATTHEWS', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DRIVE MEDICAL DESIGN', '250 KENNEDY DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BROWN', '3810 GWYNN OAK AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2570 LINCOLN BLVD', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'XIONG', '', '', '', '54476', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PRIVETTE', 'SPRING HARVEST', '', 'NC', '28110', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STAPLES', '45 CEDAR LANE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '7570 NW 14 ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WOODWARD GOVERNOR', '', 'LOVELAND', 'CO', '80538', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '2 BROTHERS', 'W MONROE ST', '', 'IN', '46733', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1050 E CACUS', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'REED', '262 ELM ST', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '600 13TH ST', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PEP BOYS', 'WASHINGTON RD', 'AUGUSTA', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ISD AND SOLUTION', 'MUSTANG', 'ALVIN', 'TX', '77511', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GARNER METAL', 'S MAIN ST', 'MONROE', 'OH', '45050', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IRS', '8101 TOM MARTIN DR ROOM 151', 'BIRMINGHAM', 'AL', '35211', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BARBER', 'BELL ROAD', 'BIRMINGHAM', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRIMMEL IRISH PHILLIPS', '500 LOCUST HILL AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HARRISON MONTGOMERY', '502 WINNACUNNET RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MEYER', '', '', '', '60615', '', Constants.TAG_ENTITY_BIZ }
  , { 'JESSICA', '', '', 'RICHART', '2423 ELLIS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SULLIVAN', '', '', '', '64056', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'PALMER', 'CHERRY', '', 'CT', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DR DANDELION', '8  GARRISON ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GONZALEZ', '', 'ROGERS', 'AR', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'OLIVER', 'EAST RD', '', 'MA', '1266', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AVENUE', '33850 GRATIOT', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '303 E 60TH ST&apos;', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DS WATERS', '5331 NW 35TH TER', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '79 S MAIN ST', 'WILKES BARRE', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JORGE', '', '', 'PIZA', 'MARKEY', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NYSDC', '101 MAIN ST', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'RR 4 BOX 112', '', 'TX', '78577', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'ERIC', '', 'MILES', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KATARINA', '', '', 'ELDER', 'POBOX 2336', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DELAWARE PARK', 'LINCOLN PKWY', 'BUFFALO', 'NY', '14201', '', Constants.TAG_ENTITY_BIZ }
  , { 'LIZ', '', '', 'YOUNG', '15TH ST', 'KENOSHA', 'WI', '53144', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '401 CONGRESS AVENUE', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HARRISON MONTGOMERY', '502  WINNACUNNET RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LINDA', '', '', 'WILSON', '185 ROLLING ACRES RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'VOGEL', 'N6W31449', 'WAUKESHA', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '351 E 4TH ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOLLAR GENERAL', '', 'SYLACAUGA', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WRIGHT', '2141 COLLETTE LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1501 NW 10 AVE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '16830 KINGBURG', 'GRANADA HILLS', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RSENTHAL', '101 WISCONSIN AVE', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MIKE WOODHAMS', 'ROBERTS', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TYLER', '289 FLOWER COURT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EDWARD BENNETT WILLIAMS', '', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '80 BROAD ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LOWES', 'JEFFERSON PK', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BOB', '', '', 'BAKER', '4665 PARKHILL', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'CEDAR CREEK DR', '', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DAVID', '', '', 'WILSON', 'VALLEY RD', 'EUSTIS', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PAYNE', '2119 RIVER ROCK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHELLE', '', '', 'FINK', '1365 STATE ROUTE 66', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GREEN', '2530 TUSCARAWAS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FRANCISE TAX BOARD', 'SHERMAN WAY', 'VAN NUYS', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '630 N 9TH', 'CARLISLE', 'IA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5301 BLUE LAGOON DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2100 M ST', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SHAEDING', '', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DEBORAH MCCORMICK', '', 'HUNTINGTON BEACH', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NG', '', 'WOODSIDE', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'NICK', '', '', 'WOLFORD', '6TH ST', 'DOVER', 'NH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1000 E 41ST', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SNYDER', '800 HARBOR LAKES DR. APT.#108', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JEFFREY JOHNSON', '5611  119TH AVE SE   STE 5', 'BELLEVUE', 'WA', '980063799', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SPEARMAN', '5001 N CONGRESS  AVE', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EYEMASTER', '6002  SLIDE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'T MOBILE USA   9868', 'STE 417', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'OWENS', '505 HILL RD', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A', '1267 S RICHLAND', '', 'IN', '46221', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'U S BORAX', '14486  BORAX RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DAVIS', 'RT 257', 'SENECA', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1731 NW 47TH AVE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '502 N MAIN', 'WEATHERFORD', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DHEMECOURT', '714 REEDS REEF', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TODD', '', '', '', '97527', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'POSITROL', 'VIRGINIA', 'CINCINNATI', 'OH', '45227', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'OROZCO', '908 DEVONSHIRE', 'FULLERTON', 'CA', '92831', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'C A SHORT CO', '', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WILLIAMSON HIGH SCHOOL', '1567 E DUBLIN ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THE PADDY WAGON', '18940 E 12TH ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LEE', '', '', 'MILLER', '55 SOUTH FAYETTE ST', '', 'PA', '19612', '', Constants.TAG_ENTITY_BIZ }
  , { 'RICHARD', '', '', 'ELLIS', '', 'VISALIA', 'CA', '93291', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BRW AND ASSOCIATES', 'FM 78', 'SAN ANTONIO', 'TX', '78244', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ST LAWRENCE UNIVERSITY', '23  ROMODA DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NORTHWAY', '', 'TOPEKA', 'KS', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KCC', '', 'TOPEKA', 'KS', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STAPLES', '45 CEDAR LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHRIS', '', '', 'CARLSON', '44450 FOX HOLLOW', 'EUGENE', 'OR', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MICHE  BAG', '1381  COUNTY RD', 'MINEOLA', 'TX', '75773', '', Constants.TAG_ENTITY_BIZ }
  , { 'DANIEL', '', '', 'WRIGHT', 'MIRRAMAC', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HACH', '', 'LOVELAND', 'CO', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CAMERON', '', '', 'TAYLOR', '6394 BERCHVIEW DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '120 CENTRAL PARK S', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5022 W AVE N', 'PALMDALE', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SARA HOWELL', '5207 DEERFIELD CREEK PLACE', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RYDER', '249  OLD ST LOUIS RD', 'FORT WORTH', 'TX', '76115', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'REITZ MEMORIAL HIGH SCHOOL', '1500  LINCOLN AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'HANNAH', '', '', 'VANHISE', '6112 42ND STREET', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRADLEY', '', '', 'JOHNSON', '5738 SUMMERSTON', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DAVIS', '', '', 'WI', '53158', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARCIA', '', '', 'LEACH', '34250 N 60TH ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STRATEGIC EQUITY FUNDING', 'S LAKE AVE', 'PASADENA', 'CA', '91101', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARK', '200 W 58TH ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'N BROAD ST', 'EUFAULA', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RON', '', '', 'JOHNSON', '11400 MICHAEL', '', 'OK', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'OHP', '', 'MUSKOGEE', 'OK', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARIA', '', '', 'RIVERIA', '3340 RESIVOR RD NW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEARS', '', '', 'OH', '44221', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TF ENTERPRISE', '3218 GAINES BASIN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5225 KATY FWY', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1025 CONNECTICUT AVE', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LAIL', '2603 ICARD RIDGE', 'STATESVILLE', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GREEN', '317 CENTRAL AVE', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'INNES', 'BRIAN&apos;S VIEW', '', 'NH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'US POST OFFICE', '225 MICHIGAN', 'GRAND RAPIDS', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1530 S OLIVE', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FSD AND SOLUTION', 'MUSTANG', 'ALVIN', 'TX', '77511', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RUIZ NIDIA AMPARO', '1900 NW 21ST     STE 220', 'MIAMI', 'FL', '33172', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'C A A F', '', 'LOS ANGELES', 'CA', '90045', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOON', '', '', 'LEE', '', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAMELA', '', '', 'WOLF', '805  LIBERTY CREEK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BREILNIGER', '212 DICKERSON HOLLOW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ELIZABETH', '', '', 'BARTON', 'PINE', 'VERONA', 'KY', '41092', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5541 S EVERETT AVE', 'CHICAGO', '', '60634', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RUELAS', '414 HIGH ST', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LEWIS TREE SERVICE INC', '1303 NW 15TH AVE', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'T MOBILE', '', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'T MOBILE', '', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1215 5TH AVENUE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IBM', '150 KETTLETON', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '9333 PARK BLVD', 'SEMINOLE', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TETRA POINT FUELS', '1301 MAYHILL', 'DENTON', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRIAN', '', '', 'JONES', 'BLUEBIRD', '', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '133 SE 17TH ST', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '9970 SW 88 ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A&B MCKEON GLASS & MIRROR', '69  ROLF ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3030 N 3RD ST', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WOLFE CENTER', '13TH', 'MERCED', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FLUIDICS INC.', '7-  GARFIELD RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'EVANS', '48600 FAIRWAY LN #112', 'CHISAGO CITY', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'SHAW', '2216 CASMORE', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WINTERS', '', '', '', '33629', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'F', '230 PEASE RD', '', 'ME', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BABLITZ', '438 MORRISSVILLE RD APT 3D', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'STEVE', '', '', 'JONES', '738 ARBOR CIRCLE DR', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SERURE', '327 MIDDLE COUNTRY', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JESUS', '', '', 'ROJAS', '11 RETOSE', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ADAMS', '878  COLD SPRINGS RD', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '10100 INTERNATIONAL', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HENRY FORD W BLOOMFIELD HOSPI', 'WEST MAPLE RD', 'WEST BLOOMFIELD', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DAVID', '', '', 'HERMANN', '33 SUNSET DR', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '555 NEW JERSEY AVE NW', 'WASHINGTON', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '301 N HARRISON', 'PRINCETON', 'NJ', '8540', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PARAG', '', '', '', '32901', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROSS', '', 'RENO', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'THOMAS', '', '', 'MURPHY', '24307 RIPPLLING CREEK WAY', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1945 ALLEN PKWY', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MCLAUGHLIN', '191 UNITY RD', '', 'ME', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ADDIAS', '', 'SPARTANBURG', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DIANE', '', '', 'OCONNOR', '1050  OAK CREEK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GRIFFIN', '', '', '', '70815', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KATHIE', '', '', 'MCCAULEY', '4140 N 34TH ST', '', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LINDA', '', '', 'DREWS', '2605 COLLEGE COURT', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DEVINE', '143 WESTMINISTER', '', 'RI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BED BATH & BEYOND #0279', '2838 N BROADWAY     STE 1', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EDWARD JONES', '429 E MICHIGAN AVE', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'C', '', '', 'JEWELL', '10213 JONAMAC AVE', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHRISTY', '', '', 'PERRINE', '', '', 'WV', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TOM', '', '', 'SPENCE', '71011  STUDABACK AVE    STE 318', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WITTER', '3232 ROSE BUD DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SMITH BARNEY', '', 'BROOKLYN', 'NY', '112350000', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', 'H', '', 'RICHARDS', 'COBY DR', '', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SALONTECH', '58  SEAVIEW BLVD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CHARLOTTE', 'EAGLE BEND', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RUSSELL', '2040 DEYERLE AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEGWICK CMS', '33 S 6TH ST', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GOUDY CONSTRUCTION CO', '10777 MAIN', 'SEATTLE', 'WA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ADI', '3060 PRAIRIE VALLEY CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HEBISEN', '5531 NW 29TH CT', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CONNIE', '', '', 'TAYLOR', '', 'YUCAIAP', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'GREEN COVE RD', 'HUNTSVILLE', 'AL', '35803', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RAMIREZ', 'W GROVE ST', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GENE FREEMAN', '2616  RIDGEVILLE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALLGOOD', '1624 LAS PALMAS DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1285 6TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '740 MACON ST', 'WARNER ROBINS', 'GA', '31098', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'WILSON', '3069 JOHNSTOWN RD', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'SOUTH MAIN ST', 'PALMER', 'MA', '1069', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '409 LAKE VISTA', 'COCKEYSVILLE', 'MD', '21030', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KENNARD', '117 N MAIN ST', '', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ED', '', '', 'KOESTER', 'WASHINGTON', 'CEDARBURG', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GARMERS', '12 27TH AVE NE', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BAREFOOT GENERAL STORE', '4708 HWY 17 S', '', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KRISTEN', '', '', 'GLASSCOCK', 'GRANT', '', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CENTENE CORP', '', 'ST LOUIS', 'MO', '63105', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'G_L OUTDOOR POWER EQUIPMENT', '', 'VERMILION', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HERNANDO COUNTY CLERK OF COURT', 'JEFFERSON', 'BROOKSVILLE', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RUSSELL', '', '', '', '27604', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JUST 2 TEASE', '835 NE GREEN OAKS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MACKENZIE', '', 'SAINT CLAIR SHORES', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BEN', '', '', 'WILLS', '2030 LONDON AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'S', '', '', 'GIFFORD', '25 MAIN ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WOLFF SHOE COMPANY', '1705  LARKIN WILLIAMS RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LEAR CORP', '850 INDUSTRIAL CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN REED', '', '', 'RAYHER', '490  POST ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARCIA', '', '', 'LEACH', '34250 N 60TH ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'MILES', '', 'MCREA', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1770 E BUENA VISTA', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SEAN', '', '', 'HIGGINS', 'FAIRVIEW ROAD', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EDWARD JONES', '', 'CHARLOTTE', 'NC', '28226', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LARSON', '16630 N 7TH ST', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DEAN', '', '', 'GRAHAM', 'GRANT', 'MILWAUKEE', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '555 JOHN MUIR', 'SAN FRANCISCO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'SHAW', '2216 CASMORE', '', 'VA', '24523', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAUL', '', '', 'ANDERSON', 'MAPLE DR S', 'CAMBRIDGE', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '4954 FIELD ST', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAT', '', '', 'RUOSS', 'CONOCOHEAGUE RD', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1524 W BRADLEY', 'PEORIA', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '809 W UNION ST', 'MORGANTON', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TUCKER', '941 BUCKHORN', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRIAD', '', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'COSLO MANUFACTURING', 'SPRING GROVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JERRY', '', '', 'JOHNSON', '2097', 'CHARLESTON', 'SC', '29414', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'POYOTTE', '', 'GREENBELT', 'MD', '20770', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROGER', '', '', 'ROSE', '', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '12506 LAKE UNDERHILL', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '200 N BAYSHORE DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PETER', '', '', 'LEWIS', '901 MAIN ST', 'BUNOLA', 'PA', '15020', '', Constants.TAG_ENTITY_BIZ }
  , { 'AUDREY', '', '', 'CREWELL', '24031 BARNET', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '4848 N CENTRAL', 'CHICAGO', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEPTIC TANK SYSTEMS', '12TH', '', 'MI', '49408', '', Constants.TAG_ENTITY_BIZ }
  , { 'MIKE', '', '', 'KIRSCHNER', '8918 KENNETH CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KELLYS', 'PUTNAM ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '7825 FAY AVE STE 200', 'LA JOLLA', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BEARS GRAPHIC & SCREENING', '7307  GEORGE WASHINGTON MEM HWY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JENNIFER', '', '', 'MURRAY', '4115 PINCAY OAKS LANE', '', 'CT', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARY', '', '', 'LAKE', '23660 PRESCOTT', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3 WASHINGTON CIR', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'NOREEN', '', '', 'MILES', '5970 N COUNTY RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BATHERS', '1118 E MAIN ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ALAN', '', '', 'STOCK', '1631 ELMHURST RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5399 PLAYA VISTA', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARLIN', '1010 E ST CLAIR ST', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THOMAS LEE', '1610  KELLOGG DR', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '. NICOLE HAWKINS', '11052  SANTE FE ST N', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAY', '', '', 'HARDEE', '342 LOGANVILLE HWY', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GBX', 'PO BOX 936174', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARGARET', '', '', 'BECKER', '52ND AVE N', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ELI', '', '', 'BORNTRAGER', '3043  205TH', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'CURRY', '226 BROGILEAU AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BADGER', 'WOODLANDS ACRES', '', 'ME', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BORDERS BOOKS', '1937  MACARTHUR RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TO A TEE', '7125 GIRLS SCHOOL AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'M TRACK MCKENNA SCHOOL', 'SPRUCE ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AMERICAN', '6223  HIGWAY 90', 'MILTON', 'FL', '32170', '', Constants.TAG_ENTITY_BIZ }
  , { 'CONSTANCE', '', '', 'LEITNER', 'DOUGLAS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MONICA', '', '', 'FLORES', '13200 NORTH', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'NOELLA', '', '', 'YOUNG', '', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JASON', '', '', 'WRIGHT', 'JEFFERSON ST', 'BANCROFT', 'WV', '25011', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SANDRA CLARK', 'JACKSON ST', 'SAN JOSE', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'STEPHAN', '', '', 'JOHNSON', '', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'STROMINGER', 'LEXINGTON', '', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STOP & SHOP', 'BALLTOWN RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DORIS', '', '', 'PRINDLE', '398 PRICHARD ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PARADIES', '', '', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'WILCOX', '350 NORTH HACIENDA BLVD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HIPPIE CHICK', '6002 SLIDE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BURY', 'BROADWAY', '', 'NY', '12865', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GORDON', '', '', 'NY', '11937', '', Constants.TAG_ENTITY_BIZ }
  , { 'LOUIS', '', '', 'HUGHES', 'PO BOX 393', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HMX', '', '', 'IL', '60611', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IRS', '', 'WATERLOO', 'IA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'INN', 'MAIN ST', 'SALADO', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JULIE QUIJANO', 'PO BOX 26665', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SMITH', '', 'E FREETOWN', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CLARK', 'BAYVIEW AVE', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SAUCIER', '1551 COPICUT RD', '', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BRACY', 'TREESONG RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARSIA', '', '', 'HILL', '', '', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1239 BROADWAY', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CAROL', '', '', 'SMITH', '105 WEST ST', '', 'DE', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'HARRIS', '', 'WASHINGTON', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'WILLIAM', '', '', 'COOK', '230 BOWMANS BOTTOM', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DENA', '', '', 'LORD', '333 W PERSHING RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TODD', '', '', 'HORTON', '52ND', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SCOTT', '', '', 'BENSON', 'KIVA', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KOHLS', '', '44512', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HOMETOWN HEALTH CARE', '1681 WOODBRIDGE PARK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GLOBAL BOATING US', '437  J ST    STE 202', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARK', '', '', 'RESMESSEN', '4TH ST', 'WEST DES MOINES', 'IA', '50265', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'C', '6914 CLYATT STONE RD', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BILL', '', '', 'CATTS', '15 SOUTH MILLER', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAUL', '', '', 'WHITE', '63392 E OAK LANE', '', 'OK', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAMES', '', '', 'JOHNSON', '', 'BIRMINGHAM', 'AL', '35209', '', Constants.TAG_ENTITY_BIZ }
  , { 'STEPHANIE', '', '', 'EVANS', '14408 PIPER GLEN', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '320 W STATE ROUTE 14', '', 'OH', '44408', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1190 NW 95TH ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GEORGIANNA HUNTER', 'E 42ND ST', 'BROOKLYN', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'YU', '', '', 'HAO', 'SOLANO PARK CIR    APT 4324', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARIE', '', '', 'ROSE', '321 DANIEL DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BETTY', '', '', 'PHILLIPS', 'CHERRY FORK RD', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RICELAND', '918 NEW MADRID', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAUL', '', '', 'ZIMMERMAN', 'MAIN ST', 'BELLEVILLE', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RUSSELL', '', '', 'SEARS', '11 CONCORD COMMONS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ANDRUS', '3753', 'LANCASTER', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JACKSON', '606 RUTH ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DAVID', '', '', 'COX', '4624 WEAKLY HOLLOW RD', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '555 BROADWAY', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'POWELL', '2604 THOMSON TOWN RD', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SMITH', '', 'TOBYHANNA', 'PA', '11692', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THOMPSON CONTRACTING', '101  PETFINDER LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5757 W CENTURY BLVD', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'WILLIAM', '', '', 'BENNETT', '46 VINE ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LANG', '8119 TOWNLEY ROAD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '920 N 28TH ST', 'MILWAUKEE', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'L', '2557 WALNUT PIKE DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WILLIAM ANDERSON', 'WINDSOR GREEN', '', 'SC', '29579', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IRS', '1000 SOUTH PINE ISLAND RD', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PURVEY', '1ST', 'GAINESVILLE', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'XM SONIC THEATER', '', 'WASHINGTON', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'AUDREY', '', '', 'CREWELL', 'W BARNET', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ANGELA', '', '', 'PERRY', 'KING ARTHUR COURT', 'INDIANAPOLIS', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1101 JUNIPER ST', 'ATLANTA', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KMART', 'PROSPECT AVE', 'WEST ORANGE', 'NJ', '7052', '', Constants.TAG_ENTITY_BIZ }
  , { 'DANNY', '', '', 'MAYES', 'UPPER OAKWOOD', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1401 AVOCADO AVE', 'REDLANDS', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SARA', '', '', 'HINCKLEY', '38600  ZIP INDUSTRIAL BLVD     B', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JASON', '', '', 'COLLINS', '921 VIEWMONT DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOE', '', '', 'DUNN', '113 OMER ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARTIN', '', '', 'FAIRFAX', 'BROADWAY', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HELEN SUMMERS', '1300  PARK WEST BLVD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JENNIFER', '', '', 'JONES', '712 CEDAR CT', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1215 5TH AVENUE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LUDWIG', '', '', '', '53081', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '20700 AVALON', 'CARSON', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SAC', '', 'CORPUS CHRISTI', 'TX', '78416', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WALONICK', '1200 1ST ST', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHELLE', '', '', 'PAINTER', '24081 S MOUNTAIN HOUSE', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'THERESA', '', '', 'BETIL', 'HIGHLAND', 'SOMERVILLE', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BIRDS EYE AUTO', 'N WALNUT AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROTH', '703 THOMPSON FALLS', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '208 E 51ST ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'APPERSON', '16838 ROYAL CREST DR', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AT&T', '75  MIDDLESEX TPKE    STE 1050A', '', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROCK', '743 WOODFORD WAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NEW BALTIMORE REFORMED CHURCH', 'WASHINGTON AVE', 'NEW BALTIMORE', 'NY', '12124', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'US POST OFFICE', '225  MICHIGAN', 'GRAND RAPIDS', 'MI', '49503', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOL', '1947 507TH', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAMES', '', '', 'GRIFFIN', '3709  PICKFORD AVE', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WALGREEN', '', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BROWER', '', '', 'MCKENZIE', 'OAK BRIDGE', 'HERNANDO', 'MS', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAM', '', '', 'WOLF', '805 LIBERTY CREEK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HAIR BY DAMIAN', '5713 CENTRE AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ARBYS', '165 STEPHENS WAY', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BERROLA', 'PONTIAC AVE', '', 'RI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICKEY', '', '', 'SMITH', '1056 EMILY RD', '', 'CT', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CAO', '', 'RICHARDSON', 'TX', '75080', '', Constants.TAG_ENTITY_BIZ }
  , { 'J', '', '', 'ONEIL', 'HILLENGLADE', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'T MOBILE', 'STE 417', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A', 'RICHLAND', '', 'IN', '46221', '', Constants.TAG_ENTITY_BIZ }
  , { 'POLLY', '', '', 'GREEN', '2530 TUSCARAWAS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TOM', '', '', 'BERG', '2902', '', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BARRY', '', '', 'HIRST', '14403 SPRING MOUNTAIN DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHARLOTTE', '', '', 'SMITH', '8605 SCENIC HOLLOW', '', 'MS', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'L', '', '', 'TADD', '613 BELLAIRE DRIVE', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WAYNE WRIGHT LLP', '10801 GATEWAY W', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ELIZABETH', '', '', 'BURKE', '', 'AUSTIN', 'TX', '78705', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FULON', '5045 STATE ROUTE 73', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SENCO', '', 'CINCINNATI', 'OH', '45244', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROCOURT', '', '', '', '33176', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LAIL', '2603 ICARD RIDGE', 'TAYLORSVILLE', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DATHAN', '', '', 'JONES', '1 COMMUNITY PL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRACY', '322 CLEVELAND ROAD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'PINE ST', 'RENSSELAER', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JESSICA', '', '', 'REYNA', '501 E SAM HOUSTON', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BROMBERG', '2000 TOWERSIDE TER', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'INSTRUMENTATION', '8502 112TH AVE NW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MCPHILLIPS', '351 BREAKER ST', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DEVOS & CO', '', '', 'NJ', '7901', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARCIA', '', '', 'LEACH', '34250 N 60TH', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MD ANDERSON CANCER CENTER', '', 'BASTROP', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MIKE', '', '', 'SCIULLO', '', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARY OWENS', '25670 N SHORE PL', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BECKY', '', '', 'SMITH', '', 'WAMSUTTER', 'WY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '140 BAY STREET', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DELLY', '', '', '', '48302', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHRIS', '', '', 'NELSON', '809 W PENNSYLVANNIA AVE', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PATRICK', '', '', 'FELDPAUSH', 'GRAND RIVER', 'EAGEL', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '590 MALABAR', 'PALM BAY', 'FL', '32909', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARIA', '', '', 'HILL', '15TH ST', '', 'DC', '20005', '', Constants.TAG_ENTITY_BIZ }
  , { 'BARBARA', '', '', 'HUGHES', 'HAMPTON', 'GARDNERVILLE', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FRENCH', 'MEADOWBROOK', 'MARTIN', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SGT CRISTIAN CRUZ', '14555  SCHOOL ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'K O N E', '', 'NEWARK', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DEBEVOISE AND PLIMPTON', '919  3RD AVE', 'NEW YORK', 'NY', '10016', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STATIC TECH', '138 WEYMOUTH ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RONNIE', '', '', 'MULLINS', '27468  WORLD CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DESIREE', '', '', 'ROGERS', '3303 W CREST ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '510 HIGHLAND AVE', '', '', '48381', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BELL', '3002  PIONER WAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NELSON', '905 BEACON HIL RD', 'NORFOLK', 'VA', '23502', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'L', '8119 TOWNLEY ROAD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'USPS', '17345 PACIFIC', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JONES', '3600  EVERGREEN', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARIA VARGAS', '8944 S ROBERTS RD', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SUSAN', '', '', 'JOHNSON', '207', 'FAIRFIELD', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BEATTY AND PETERSEN', '107 S 1ST', '', 'IA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MIKE', '', '', 'HANLEY', 'NE 28TH ST', 'VANCOUVER', 'WA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THE ONE BOGY', '8TH', 'LONG BEACH', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AMEIRCAN TIRE', '311 E STATE RTE 176', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TOM', '', '', 'WILLIAMS', '4900  FROLICH LN', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'SMITH', '280 RECTOR PLACE', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GAMET', '2840 N MILWAUKEE', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEARS', '1140  SHAW AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STOUT', '401 SHORELINE DR #314', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BARBRETTA', '', '', 'REAVES', '115 MACEW LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GENERAL MILLS', '2423 ELLIS ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'L E MYERS CO', 'BRANDY RD', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STEPHANIE TURNER', '202  MARCH PARK BLVD SE    B104', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3000 N CONGRESS AVE', 'BONTON BEACH', 'FL', '33426', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LEIGHANN', 'TREESONG RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '417 5TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FEMA', '', 'BOSTON', 'MA', '2109', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'SHAG BARK TRL', 'GAINESVILLE', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'EAGLE BEND', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BREITZER', 'OTTAWA', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRENDY PHONES', 'LAFAYETTE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ZACHARY', '', '', 'WEEDEN', '2 COLLEGE HILL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RHONEY', '', 'SPARTANBURG', 'SC', '29301', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2300 HOLCOMB BRIDGE RD', 'ROSWELL', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JULIA', '', '', 'MORRIS', 'PINE BLVD', 'NASHVILLE', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KNIGHT', '1039 RED OAK', 'OXFORD', 'AL', '36203', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DEMAIO', '', '', 'FL', '33071', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'DOUGLAS ST', 'BOSTON', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEARS', '', 'LOUISVILLE', 'KY', '40216', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARYLAND FRAUD', '5115 PISTOL RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARCIA', '', '', 'LEACH', '34250 N 60TH', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'A', '', '', 'MARTIN', '111 OBRIAN WAY', 'COLUMBIA', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AAA  AUTO CLUB SOUTH', '601 E ATLANTIC BLVD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'M TRACK MCKENNA SCHOOL', 'SPRUCE ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WORLDUNIMAX LOGISTICS', 'MAIN', 'CARSON', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TOP GRILL', '1176 MCCORMICK AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STOTT', 'MAIN ST', 'ELROY', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '7000 N 16TH ST', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHARLIE', '', '', 'JONES', '125 WAYNE BLACK DR', '', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'SW 112TH ST', '', 'OR', '97062', '', Constants.TAG_ENTITY_BIZ }
  , { 'THOMAS', '', '', 'JACKSON', '5540 UNIVERSITY POINTE', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '225 6TH ST', 'SANTA MONICA', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAMES', '', '', 'WALSH', '23030  WINDING BROOK WAY', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KRISTINA', '', '', 'GORDAN', '5037 MIRANDA', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THE TOWN BARBER', 'MAIN', 'DAGSBORO', 'DE', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'OTTER CREEK RD', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'OTTER CREEK RD', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SUSAN', '', '', 'WOOD', '8335', '', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FOSTER', '2971 PAR CIR', '', 'FL', '33446', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BURCHILL', '', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BED BATH & BEYOND #0279', '2838 N BROADWAY     STE 1', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5032 FORBES AVE', 'PITTSBURGH', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EYE MASTER', '', 'LUBBOCK', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LINDA', '', '', 'DOZIER', '', 'LUBBOCK', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JAMES', '', '', 'WILSON', '1901 CREEK RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HOUSING AUTHORITY', '10TH AVE N', '', 'SC', '29577', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RUANE', '', '', '', '80134', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '10790 WILSHIRE', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MATT', '', '', 'POORE', 'MAGNOLIA', '', 'CA', '94939', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PIZZA HUT', '8757 GRISSOM', 'SAN ANTONIO', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5025 THACHER RD', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'INTERNAL  REVENUE SERVICE', '130 S ELMWOOD AVE    RM 109', 'ANDOVER', 'MA', '18104544', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BLEEKER', '509 WATCHUNG AVE', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALSTON & BIRD', '1201 W PEACHTREE ST NE', 'ATLANTA', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '25TH AVE', 'SAN FRANCISCO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'STEVE', '', '', 'JONES', '738 ARBOR CIRCLE DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LAURA', '', '', 'SERBIN', 'WILSON', '', 'AZ', '85338', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GARNER METAL', 'S MAIN ST', 'MONROE', 'OH', '45050', '', Constants.TAG_ENTITY_BIZ }
  , { 'SCOTT', '', '', 'GARDNER', 'BROADWAY RD', '', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAMELA', '', '', 'WOLF', '805 LIBERTY CREEK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A & M GREEN POWER', '', 'RED OAK', 'IA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'B&L', '1400 N GOODMAN ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '12760 HIGH BLUFF DR', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'MAZZEI', '16 W 751 56TH ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GONZALEZ', '', 'ROGERS', 'AR', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'DANIEL ELLIS', 'CHARLESTON', 'SC', '29412', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1010 NORTHERN BLVD  .', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SETH', '', '', 'WILLIAMS', '', 'MARTINEZ', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BROKS', '', '', 'WILLIAMS', '', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LW SUPPLY', 'HICKORY FLAT', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GAIL GISCLAIR', 'E MAIN ST', 'GALLIANO', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOLLAR GENERAL', '', 'WARREN', 'OH', '44511', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CAMPBELL', '1037 ELMWOOD DR', '', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '821 MAIN', '', 'TX', '78501', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KEN MAYO', '247  FULTONS RUN RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KNOTEK', 'PO BOX 1122', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARIA', '', '', 'ROSR', '321 DANIAL DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BURLINGTON COAT', 'S WANAMAKET RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'J AND L INDUSTRIAL SUPPLY', 'PACIFIC AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FURNITURE 4 LESS', '124 W. 4TH', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MORTON', '337 CROSBY RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LINDS', '', '', 'DREWS', 'COLLEGE COURT', 'COLLEGE STATION', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DUNN', '113 HOMER ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'FREULER DR', 'AYDEN', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'HARRIS BRANCH', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HOTEL', 'INDIAN SCHOOL RD', '', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CLARK', '22724 BAYVIEW AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LEVINGTON & ASSOC', '1418 BEECH AVE', 'MCALLEN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FISHER AND SAULS', '100 2ND AVE', 'SAINT PETERSBURG', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '8201 S TAMIAMI', 'SARASOTA', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROBINSON', '8631 PREAKNESS', '', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3001 S HANOVER ST', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'UNG', '', 'RIVERSIDE', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1211 CONNECTICUT AVE', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HAWKINS', '5101 SPAUDING', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PROVIDENCE O CHRISTMAS TREES', '4831  35TH AVE SW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GOODWILL', 'PINE', '', 'PA', '16743', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NORRIS', '6909 67TH AVE N', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3771 S MCCLINTOCK', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HISLOP', 'P O BOX 478', 'PORTSMOUTH', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '219 N MAPLE ST', 'ENFIELD', 'CT', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3880  WOODMERE PK BLVD', 'ENGLEWOOD', 'FL', '34293', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BOSTON', '190 DOUGLAS', '', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KEVIN J KIRKPATRICK', '30201  RONDAVO RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CLARK CINDY', 'BAYVIEW AVE', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3900 N CHARLES ST', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3131 E CAMELBACK RD', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WELLS FARGO BANK', '', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STEVENS', 'W. SAINT LAWRENCE', 'BELOIT', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HANCOCK BANK', 'MAIN', 'MADISONVILLE', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DARLING', 'HAYES ST', '', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'SMITH', 'ROUTE 380', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BENITTA ANDERSON', 'LASSEN', '', 'CA', '91325', '', Constants.TAG_ENTITY_BIZ }
  , { 'DEREK', '', '', '', 'RIDGE RD', 'ELVERSON', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'MAIN', 'WAKESHA', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALSTON & BIRD', '1201 W PEACHTREE ST NE', 'ATLANTA', 'GA', '30307', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MONRO MFFLR', 'PARK AVE W', 'MANSFIELD', 'OH', '44906', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GWU', '', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BARTON', '', 'EVANSVILLE', 'IN', '47711', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'POWELL', '2604 THOMPSON TOWN RD', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'NANCY', '', '', 'RABUL', '15419 GREAT GLEN LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HILL', '132 COMMERICAL', 'BELLEVILLE', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PUROCLEAN   TRENARY', '2419  COUNTRY CLUB ROAD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'ROYAL HARVEST WAY', 'SALT LAKE CITY', 'UT', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DANNY', '3776 GENELEVA', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SAM BURRS', '1078  MALLARD LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAUL', '', '', 'GATTO', '', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HERNANDEZ', '', '', '', '33314', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'M R I INC', '', 'SAN ANTONIO', 'TX', '78248', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SAWYERS MOTORCYCLES', '10995 OAK RIDGE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROY', '', '', 'MINAGAWA', '58 WOODSWAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HOME DEPOT', 'RIDGE BLUFF', 'SAN ANTONIO', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '26300 FORD RD', 'DEARBORN HEIGHTS', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '11845 W OLYMPIC', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1111 BRAND', 'GLENDALE', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JASON', '', '', 'COLLINS', '921 VIEWMONT DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TOMPKINS', '', '', 'DC', '20004', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MORGAN STANLEY SMITH BARNEY', '3825  LYNNHAVEN RD    STE 6', 'WALDORF', 'MD', '20604', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BAILEY', '', 'CASTLE ROCK', 'CO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'YAVAPAI TV SERVICE', 'BROADWAY', '', 'AZ', '85362', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THE INN AT SALADO', 'NORTH MAIN ST', 'SALADO', 'TX', '76571', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MERIDIAN INVESTIGATIVE GROUP', 'CENTRAL', 'ST PETE', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JIMMY', '', '', 'WELBORN', '', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOSH H', '', '', 'JACOBS', '1615 W 10TH', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARK', '', '', 'CLARE', '1700 WOODLANDS', '', 'OH', '43537', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AMERICAN BRIDGE CO.', '1  RANDALLS ISLAND PARK', 'NY. NY', 'NY', '10035', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '730 6TH AVE NE', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SUBWAY', '225 NE 138TH AVE', 'VANCOUVER', 'WA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARILYN', '', '', 'CHILDUSE', 'PENNSYLVANIA', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JONN DEERE', 'BROADWAY', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'GOVERNORS', '', 'SC', '29455', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GANZA', '1150', '', 'DC', '20024', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DIRT S', '444  OLD NEIGHBORHOOD RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CACI', '', 'DAYTON', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'C', '6914 CLYATT STONE RD', 'ALAPAHA', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LOWES', '', 'MOBERLY', 'MO', '65270', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DONOFRIO', '320199  PO BOX', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BILL', '', '', 'KOURI', '3333 BEDISON ST', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'H', '', '', 'OLF', '', 'SEATTLE', 'WA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WITHERS', '120 PENNOCK TRACE', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RIANG', '', '', 'RI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WEST ADAMS PREPARATORY HIGH SCHOOL', 'WASHINGTON BL', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'GENNELL', '', '', 'MARX', '30370 ST DAVIDS DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LG &E', '', 'LOUISVILLE', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A', '15  BICENTENNIAL CIR', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'C A BEAN', '', '', 'MD', '20659', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'HINKLE', 'COUNTY LINE RD', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3975 N NELLIS', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2678 MT MORIAH TERRACE', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JONN DEERE', 'BROADWAY', 'STOCKTON', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HERBERT', '', 'BOWIE', 'MD', '20716', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WILSON', '11  FRANKLIN LOOP SE', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ANN KENNEDY', '10 KNOLLCREST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'XAVIER', '', '', 'BELL', '3002  PIONER WAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'STEVE', '', '', 'WESLEY', '2568  ORCHARD CT', '', '', '97980', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2 N RIVERSIDE PLZ', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CROKER', '6490 INTERSTATE DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'LEXINGTON RIDGE DR', 'LEXINGTON', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JERRY', '', '', 'DOLAN', '285 KINGMAN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '112 N MAIN', '', 'IA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TAYLOR CO BOARD OF COMMSIONERS', '', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1000 FULTON PKWY', 'EVANSVILLE', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CLARK', 'LOMA VISTA', 'BILLINGS', 'MT', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WAGNER MOTORMART', '', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'COBB', '5302 CHERRIER PL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEARS', '7300 BUSTLETON AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LIN', '', '', 'KARMON', '2643', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ALLEN', '', '', 'DIAZ', '', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1099 14TH', '', 'DC', '20570', '', Constants.TAG_ENTITY_BIZ }
  , { 'KEN', '', '', 'LEE', '1230 OAK RD', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KATHY', '', '', 'HELMS', '1814 AL HWY 125', '', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WALMART STORE #1514', '2201 MICHIGAN AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BETTY', '', '', 'PERKEY', '994 CR 5250', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOE', '55  BLACKBERRY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KNOX INSPECTION', '1410 S PARISH DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LINDA', '', '', 'MAY', '100 E 7TH', ' #301', 'KANSAS CITY', 'MO', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EYE MASTER', 'PO BOX 68471', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SIGMA', '225 E HOLLY', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FERNANDO GOMEZ', 'NW 37TH ST', 'DORAL', 'FL', '33166', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WEIR', '', 'HAMPTON', 'VA', '23668', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '7801 NW 37TH ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '11430 N KENDALL DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '60 EDGEWATER DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GARCIA MIDDLE SCHOOL', '', 'MISSOURI CITY', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '100 SE 3RD AVE', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BARNES NOBLE', '2211', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KATE ZIBELL', 'MAPLE ST', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DON', '', '', 'MURRAY', '3320 WHY 80 W', 'LABELLE', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROGERS TAYLOR', '24906 NORTH HAMPTON ST', 'SPRING', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JADE', '', '', 'THOMAS', '334 ARCHDALE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SCOTT', '', '', '', '64081', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'INTERNAL REVENUE SERVICE', '', 'KANSAS CITY', 'MO', '63197', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RAYFORD', 'MAIN', 'HESPERIA', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KIM', '', '', 'HO', '2ND ST', '', 'LA', '70420', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ENDO PHARMA', '100  ENDO WAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RETAIL', 'SHANDS PIER RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DRESBACK', '', '', 'WILLIAM', '1840 LAUREL LANE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GAUDET', '4301 LEBANON RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CITI CARDS', '21ST ST', '', 'IA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1902 AGUSTA', 'HOUSTON', 'TX', '77040', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TANNEHILL', '75990 BRANDT PLACE', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'REED', '5121 SWEET BAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JP MORGAN CHASE BANK', 'MAIN', 'BEXLEY', 'OH', '43209', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '98 SAN JACINTO', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1215 5TH AVENUE', 'NEW YORK', 'NY', '10029', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RICHARD BEHRENS ESQ', '10 BIRD WALK TOWNE SQUARE', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FRANKLIN COUNTY EXTENSION OFFICE', 'WALNUT ST', 'MEADVILLE', 'MS', '396530368', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HAIDEE BRYAN', '2558 E 219', 'LONG BEACH', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'J', '331 HILTON TERRACE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A BEAUTIFUL SMILE', '', 'SPRINGFIELD', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JACKIE', '', '', 'YOUNG', '', '', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HTE', '', 'HUNTINGTON BEACH', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1255 E CITRUS', 'REDLANDS', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LOWES', '3460 JEFFERSON PK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'STEVEN', '', '', 'WILSON', '1825  OAK BROOK DR', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CAROL', '', '', 'SCOTT', '68 GRANDVIEW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '146  CENTRAL  PARK  WEST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '150 2ND AVE N', 'ST PETERSBURG', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AZ OFFICE TECH', '100', 'PHOENIX', 'AZ', '85040', '', Constants.TAG_ENTITY_BIZ }
  , { 'HENRY', '', '', 'SCHEIN', '27468  WORLD CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FERRADO', '4721', 'CAPE CORAL', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BOB', '', '', 'BROOKS', '9443 MISSOURI POINT RD NW', '', 'WA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRIPLETT', '2557 WALNUT PIKE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CTA', '', '', 'MT', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'WRIGHT', '7176', '', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IRS', '201  PENN ST', 'BUFFALO', 'NY', '14202', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HOMELAND VINYL PRODUCTS', '3300 PINSON VALLEY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRIAN', '', '', 'ADLER', 'PINE ST', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LARRY', '', '', '', 'BAYOU', 'DONALDSONVILLE', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '20235 N CAVE CREEK RD', '', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HBI', 'HIGHLAND AVE E', '', 'MN', '55119', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KESSELL', '635 HI VIEW', '', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LENDER PROCESSING SERVICES', '601  RIVERSIDE AVE', 'JACKSONVILLE', 'FL', '32080', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'REED', '5121 SWEET BAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TIFFANY', '', '', 'REED', '5121 SWEET BAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BRINKMAN', '1106 FRANKLIN CT', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CIGNA', '6600 E CAMPUS CIR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TAKEDA', '6333 N STATE HEY 161', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KARLA', '', '', 'HARRIS', 'CHERRY', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WRIGHT', '2141 COLLETTE LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '32 BROADWAY', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '201 CENTRAL AVE', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CYCLERY', '3308 W 44TH', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NORRIS', 'ARBOR WAY', 'CANTON', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FLUIDICS INC.', '7-  GARFIELD RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AMASH', 'DEVONWOOD', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DENNIGER', '1558 PATE RD', 'WHITESBURG', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SIERRA VISTA MALL', '1140  SHAW AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RED LOBSTER', 'E 23RD ST', '', 'FL', '32405', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RIVER VALLEY BANK', '3210 E MAIN', 'MERRILL', 'WI', '54442', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROB', '', '', 'REA', '250  M ST EXT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CITI TREND #319', 'LINCOLN HWY', 'MATTESON', 'IL', '60443', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BEATTY', 'AZALEA', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2950 SW 16TH AVE', 'MIRAMAR', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DAWN MEYER', 'E 16TH', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KROGER', '172 W LOGAN ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5757 WILSHIRE', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '101 CLARK ST', 'BROOKLYN', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARUIA', '', 'HUNTINGTON BEACH', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '11545 W BERNARDO CT', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BROWN', '1214 PLEASANT', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MALYS', '', 'MUNCIE', 'IN', '47303', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DICK', 'MAIN', 'CLINTON', 'ME', '4927', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BURLINGTON COAT', 'S WANAMAKET RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAMELA', '', '', 'WOLF', '805 LIBERTY CREEK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SMDC', '4505 W SUPERIOR ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EBELTIFTKRISTIN', '3751 HOWARD HUGHES', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ATT', '15240 MAIN ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '475 RIVERSIDE BLVD', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EATON CORP', 'JERONIMO', 'IRVINE', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IKON', '', 'MACON', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'AT&T', '', '', 'TN', '37201', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BENNETT', '', 'MOBILE', 'AL', '36521', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GIGLIA', '', '', '', '45220', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KAWNEER CO', '600 KAWNEER DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JEFF', '', '', 'GETZ', '', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'METRON', '44TH AVE', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'WILLIAMS', '', '', 'BRADLEY', '840 MCTOWLEY', 'LOUISVILLE', 'KY', '40219', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1130 PARK AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GOTT', '', '', 'CO', '80134', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ILLINOIS ST. ANDREW SOC.', '28TH ST', 'NORTH RIVERSIDE', 'IL', '60546', '', Constants.TAG_ENTITY_BIZ }
  , { 'MIKE', '', '', 'MORRIS', '5TH & OAK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NATGUN', 'VALLEY VIEW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JP MORGAN CHASE', '14202 FM 2920', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1959 NE PACIFIC', 'SEATTLE', 'WA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PETERSON', '4986', 'WILLMAR', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HSI', '1820 OLD FIRE TOWER RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JORGE', '', '', 'GARCIA', '5621 NW 2ND TER', 'MIAMI', 'FL', '33166', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'GUILLORY', '', 'HOUSTON', 'TX', '77096', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LIFEWAY CHRISTIAN', '', '', 'WA', '98188', '', Constants.TAG_ENTITY_BIZ }
  , { 'TIMOTHY', '', '', 'PETERS', 'VIA BEGUINE', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ESTELLA', '', '', 'TAYLOR', 'PALM DRIVE', 'SATELLITE BEACH', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '201 N CENTRAL AVE', 'PHOENIX', 'AZ', '85001', '', Constants.TAG_ENTITY_BIZ }
  , { 'VICTOR', '', '', 'HAUGHRON', '1071 N WATERVILLE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1050 CONN AVE NW', '', 'DC', '20030', '', Constants.TAG_ENTITY_BIZ }
  , { 'MATT', '', '', 'WOLFF', '88 STEELE ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HUDSON NEWS', '38600  ZIP INDUSTRIAL BLVD     B', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '4660 LA JOLLA VILLAGE DR', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5052', 'LINE LEXINGTON', 'PA', '18932', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '7171 FOREST LN', 'DALLAS', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BSH', '', 'COLUMBUS', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TAKAO', '', '', 'OHNUMA', '5TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TIFFANY', '', '', 'REED', '5121 SWEET BAY ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LAURA', '', '', 'ADAMS', '878  COLD SPRINGS RD', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ABC', 'TYCO ROAD', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FRAME GUILD', '1137 PENN AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BROKS', '', '', 'WILLIAMS', '844', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '8000 NW 31ST ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KEN', '', '', 'WINTERS', '5 CHAPEL LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CASA DE BENAVIDEZ', '4TH', 'ALBUQUERQUE', 'NM', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '151 NORTH DELAWARE ST', 'INDIANAPOLIS', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BUDICH', '', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1900 M ST', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'REGALIA', '', '', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DURA COOL', '4944 GLEN LANE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TRACEY', '', '', 'BAIRD', '', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TOYS R US', '1200 LANCASTER DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3401 DALE RD', 'MODESTO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SMITH', '', 'MCCONNELL AFB', 'KS', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHEAL', '', '', 'HORNE', '206 SE JOHNS ST', 'LAKE CITY', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'HONG', '', '', 'ZHANG', '', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SPAGNOLIA', '10 POINT RICH DR', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRACY MOTOR', '322 CLEVELAND', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MASTERCARD', '2200  MASTERCARD BLVD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'WILLIAM', '', '', 'WARD', '940 N 2410 E', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LAND N SEA', '', 'KANSAS CITY', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '217 E 96 TH ST', 'NEW YORK', 'NY', '10128', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'COLE', '3126 N RIVERSIDE DR', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'B', '1706  MONTE BELL CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TREVA', '', '', 'BROWN', 'BLANCHE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MOORE', '37 JAQUITH RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARY', '', '', 'DEARMAN', '65  2ND AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KATE', '', '', 'GORDON', '4384', 'BIRMINGHAM', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAMELA', '', '', 'JONES', 'PO BOX 341', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WINDRUNNER', '797 LANCASTER AVE  SUITE 14', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KIM', '', '', 'WINIGER', 'LAKE', 'RACINE', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARK', '', '', 'DIAS', '', 'FAIRFIELD', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JADE', '', '', 'THOMAS', '334 ARCHDALE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KAWNEER CO', '600 KAWNEER DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '11000 PLEASANT VALLEY RD', 'CLEVELAND', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SARAH', '', '', 'MILLER', '110 5TH AVER', 'NEW YORK CITY', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NYSDC', '101 MAIN ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JENNIFER', '', '', 'HILL', '1350 ROOSEVELT PARK BLDVD', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GESA', '', '', 'WA', '99352', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3 WASHINGTON CIRCLE', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LIU', '308', 'MALDEN', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JUDY', '', '', 'MARTIN', 'MAIN STREET', 'LISBON', 'NY', '13658', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DAVIS', '167 MAIN', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ATLANTIC FIRE DEPARTMENT', '675  PONCE DE LEON', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAM', '', '', 'WOLF', '805 LIBERTY CREEK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BETH', '', '', 'HALE', '304 W GARDENIA DR', '', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ADELIA', '', '', 'LOPEZ', 'J M FM 476', 'POTEET', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RON', '', '', 'PACKARD', 'KINNEAR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'VOGEL', 'N6W31449', '', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CITI TREND', 'LINCOLN HWY', 'MATTESON', 'IL', '60443', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOLLAR GENERAL', '', '', 'FL', '33980', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CLIFFORD KELLY', '133 W DAVIS ST', '', 'VA', '22701', '', Constants.TAG_ENTITY_BIZ }
  , { 'REBECCA', '', '', 'MILLER', '6766 COUNTY ROAD 18', 'LOVELAND', 'CO', '80537', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PAT HAGGETT', '1800  ST LUCIE BLVD', 'STUART', 'FL', '34996', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '4300 GOODELLOW', 'ST LOUIS', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'YVETTE', '', '', 'WILLIAMS', '844', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PRISILLAS', '1251 MAIN ST', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '201 S PROSPECT', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1050 E PIEDMONT RD', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DEMBA', '', '', 'DIALLO', '968 NORLAKE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '8201 S TAMIAMI', 'SARASOTA', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'G R AUTO & TRUCK REPAIR', '', 'WHITE PLAINS', 'NY', '10607', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3801 NEBRASKA AVE', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOANNE', '', '', 'CURRO', '1841 SOUTHFORK PL', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MAILYS', '', 'MUNCIE', 'IN', '47303', '', Constants.TAG_ENTITY_BIZ }
  , { 'DOUG', '', '', 'SYMONS', 'MAIN STREET', 'LISBON', 'NY', '13658', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WARREN', '7813 SW 77 CT', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'REINER', '7 RUSSELL', '', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HAMMER', '6107 W AIRPORT BLVD', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JIM', '', '', 'FINK', 'WASHINGTON', 'CASPER', 'WY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'THE LAURELS', 'ENFIELD', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THOMPSON', '210 NE 10TH AV', 'JOLIET', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARTHA MORSE', '915  WAVERLY RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'G AND R ENTERPRISES', 'WEST MAIN ST', 'HOPKINTON', 'MA', '1748', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BUTTERWORTH', '1500 WEST BROOK CT', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RIVERA', '173 E 120TH ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '745 5TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ADAMIAN', '601 E ATLANTIC BLVD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BEVERLY', '', '', 'TRUCSHEITT', 'MEADOW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LARRY', '', '', 'LEWIS', 'PARK HILL', 'COLLIERVILLE', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'VENTRA', 'BRETON RD', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'USPS', '17875 NW 57TH ST', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '25900 NORTHWESTERN HWY', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HOWARD', '', 'LAUREL', 'MS', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RICK', '', '', 'LEWIS', '5956 SMITH HILL RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STEVE & STACY', '130 VIRGINIA ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BAKER', '4665 PARKHILL', 'LITTLEROCK', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IRVING', '1150', '', 'DC', '20024', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'M', '', '', 'JOHNSON', '', 'ROSEVILLE', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BRANDY RUSSELL', '9431 SILVER MAPLES', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CONLEY', '', 'ASTORIA', 'NY', '11106', '', Constants.TAG_ENTITY_BIZ }
  , { 'KEVIN', '', '', 'ELLIOTT', 'GROUND PLUM CIR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALBERTSONS', 'TAYLOR', 'SHERMAN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'R 1 BOX 212 A', 'WAYNETOWN', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CARISSA ROSE', 'BROAD', 'BLOOMFIELD', 'NJ', '7003', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ARMED FORCES RESERVE CENTER', 'GRAND AVE', 'PINELLAS PARK', 'FL', '33782', '', Constants.TAG_ENTITY_BIZ }
  , { 'JUAN', '', '', 'LEBRON', '3418 HUMMUCK DR APT 106', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HYATT', '', 'LOS ANGELES', 'CA', '90067', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'SANDERS', 'PO BOX 442', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1200 BINZ', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BROKS', '', '', 'WILLIAMS', 'KING ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5453 DELMAR', 'ST LOUIS', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'COLE', '', '', '', '22191', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PEAK', '', 'ALEXANDRIA', 'VA', '22301', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5150 OAK RIDGE', 'PAHRUMP', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHRISTOHER', '', '', 'LAMPE', '106 TUSCANY LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KATHY', '', '', 'MULLER', '', '', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'US BANK', '', 'FAIRFIELD', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TRACEY', '', '', 'JENKINS', '', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ANTHONY', '', '', 'SMITH', '2125 AIRPORT', '', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3 WASHINGTON CIRCLE', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SOUTHEAST BANK AND TRUST', 'CONGRESS PARKWAY', '', 'TN', '37303', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KIRSCHNER', '', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'C', '6914 CLYATT STONE RD', '', 'GA', '31632', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BOYS AND GIRLS', '1806 N FLAMINGO RD     450', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARYLIN', '', '', 'ADAMS', 'EVERGREEN', 'SHERIDAN', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERTS', '', '', 'ANDREAS', '709 COUNTRY LANE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STATER BROS', 'DE BERRY', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '6909 N LOOP 1604 E', 'SAN ANTONIO', 'TX', '78241', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROGOWSKI', '', '', 'CT', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LLOYE', '', '', 'KLUG', '1ST AVE W', 'UPSALA', 'MN', '56384', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PIERCE', '4188 ANDERTON', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CLARK', 'BAYVIEW AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CROZIER', '', 'CHEYENNE', 'WY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DAVE', '', '', 'MCDANIAL', 'BROOKSIDE DR', 'GRIMES', 'IA', '50111', '', Constants.TAG_ENTITY_BIZ }
  , { 'LINDA', '', '', 'JONES', '130 HUNTIINGTON SHORES', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'YVETTE', '', '', 'WILLIAMS', 'KING ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'P F CHANGS', '10 PROVIDENCE TOWN CENTER', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MACK', '55 S FAYETTE ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SQUARE D', '', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '507 E MICHIGAN ST', 'MILWAUKEE', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CSI', '', 'ST CLOUD', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '6550 FANNIN', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'GAIL', '', '', 'TYLER', '289 FLOWER COURT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TAYLOR', '1503 EVANGELINA', '', 'FL', '34266', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '760 HARBOR BEND', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'STROMINGER MD', 'LEXINGTON ST', '', 'MA', '21282513', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TOYS R US', '1200 LANCASTER DR NE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LAFORCE && STEVENS', '132 W 31ST ST', 'NEW YORK CITY', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROADWAY', '', 'RIALTO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EQUITY', '8055 E TUFTS', '', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'VASSOLO', '', 'SAINT LOUIS', 'MO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LOWES', '', 'MOBERLY', 'MO', '65270', '', Constants.TAG_ENTITY_BIZ }
  , { 'SAIKIA', '', '', 'SMITH', '9053 KEIR ST', '', 'CA', '92116', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ACME', '', 'CONCORD', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RENEBERG', 'ROBERT', '19524  SANDCASTLE LN', '', 'CA', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SURE CROP CHEMICAL', 'MAIN ST', 'MELBETA', 'NE', '69355', '', Constants.TAG_ENTITY_BIZ }
  , { 'JACKIE', '', '', 'WILLIAMS', '150 KETTLETON', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CHF RECORDS', '700 KANSAS', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '15950 US HIGHWAY 441', 'MOUNT DORA', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PETERSON', '882 S COUNTRY MANOR', 'ALPINE', 'UT', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '7345 E ACOMA DR', '', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MIKE', '', '', 'SCHOLL', '625 W LIBERTY', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BROKS', '', '', 'WILLIAMS', 'KING ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WASHINGTON', '', 'LEESBURG', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'R E MICHEL', '680 CAROLINA RD', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'REBECCA', '', '', 'HUNTON', 'CENTRAL', 'MELBOURNE', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LEISER', '10500 ROCKVILLE', 'ROCKVILLE', 'MD', '20814', '', Constants.TAG_ENTITY_BIZ }
  , { 'ELISE', '', '', 'FOLK', '261 CEDARHURST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FETTY & DONALLY', '1225 I ST NW', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DIAZ', 'E 53RD ST', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'MAIN ST', '', 'NY', '11975', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '276 5TH AVE', 'NEW YORK CITY', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SANDRA', '', '', 'SNYDER', 'ROSEDALE AVE', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BRW AND ASSOCIATES', 'FM 78', 'SAN ANTONIO', 'TX', '78244', '', Constants.TAG_ENTITY_BIZ }
  , { 'ASHLEY', '', '', 'TAYLOR', '4594 TERRACE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DUNN', '113 HOMER ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MORGAN', '', '', 'FRIES', '2283 MOSS SIDE COURT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MELISSA', '', '', 'MACE', '12008 BROWN RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KROGER', '172 W LOGAN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CHASE BANK', 'MAIN', 'BEXLEY', 'OH', '43209', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'STATER BROS', 'DEBERRY', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'WAYNE', '', '', 'SCHMITZ', '9110 COUNTY HIGHWAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KEVIN FOUTZ', 'COLCHESTER DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NORTH AUSTIN MED CENTER', '12221 MOPAC', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'DRY MONIA', 'NEW BERN', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ANNIE', '', '', 'GUILLORY', '8TH ST', 'FGENTON', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MACK', '55 S FAYETTE ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '11767 S DIXIE HWY', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOLLAR GENERAL', '', 'CRYSTAL RIVER', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DR LYNN WILSON', '1536 W 25', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KOHLS', '', 'MENTOR', 'OH', '44060', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'FORESTWOOD CIR', '', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARCUS', '', '', 'WARE', '859 CONVENTION CENTER BLVD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CURRIE', '477 E MORY OAKS DR', 'BRYAN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CROY', 'E WILLIAMS RD', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'USAID', '', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DAVID', '', '', 'REED', '12067 7TH AVENUE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EMPIRE STATE ADMISSIONS', '2  UNION AVE', '', '', '11286', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'T MOBILE #9868', '', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EWCO', '', '', '', '97230', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'T', '2557 WALNUT PIKE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'AUSTIN', '', '', 'POWELL', '', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'WILLIAM', '', '', 'HEALY', '', 'LOUISVILLE', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3900 LAS VEGAS', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CARLOS ARANGO', '3713 NW 17TH ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1700 WOODBURY', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MAUREEN SIMPSON', '550 NORTH FLOWER ORD', 'COSTA MESA', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARRIOTT', '', 'SPRING', 'TX', '77380', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JIM KAMMERDIEMER', 'MAIN ST', '', 'PA', '16346', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GA MILLER LUMBER CO', '', 'WILLIAMSPORT', 'MD', '21795', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SAWYERS MOTORCYCLES', '10995 OAKRIDGE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '55 5TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PAUL', '', '', 'ZIMMERMAN', 'MAIN ST', 'BELLEVILLE', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1660 PEACHTREE ST', 'ATLANTA', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SIMMONS', '5924 OWL NEST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MATILDE', '', '', 'LUNA', 'SUNSET', 'BRONX', 'NY', '10465', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRADLEY', '', '', 'JOHNSON', '5738 SUMMERSTON', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ALLISON', '', '', 'STRAIN', 'RT 1', 'GREENFIELD', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1133 5TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'YMCA', '3030 N 3RD ST', '', 'AZ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MOORE', '37 JAQUITH RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '837 5 AVE S', 'NAPLES', 'FL', '34102', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOLLAR TREE', '7610 S ALAMEDA ST', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BARBARA', '', '', 'WILKIE', '1244 EVANSBURG RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'AUDREY', '', '', 'CREWELL', '24031 HIGHWAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROLANDO', '', '', 'GOMEZ', '5629 CHILDER ST', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '445 S FIGUEROA', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '7 LINCOLN SQUARE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'TRACY', '', '', 'MOORE', '1003 SHA NELLE', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DALE', '', '', 'SEWELL', '3460 JEFFERSON PK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3 WASHINGTON', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BEN', '', '', 'WILLS', '2030 LONDON AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'GRIFFITH', '700 VERDUN', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ZEIH', '4145 NE CHAPEL MANOR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JIM', '', '', 'DALY', '7321 ARBUTUS DR', '', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BARD', '', 'COVINGTON', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PROJECT TELEPHONE   WORDEN', 'MAIN ST', 'WORDEN', 'MT', '59088', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ATT', 'MAIN ST 2ND FLOOR', 'LOUISVILLE', 'KY', '40212', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARY OWENS', '25670 N SHORE PL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOLTON BEARS', '6479  MADISEN LN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MILLSAP', '208 FRANKLIN', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RICK', '', '', 'HENDRICK', '1255 FRANKLIN ALEXANDER', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '21500 NORTHWESTERN HWY', 'SOUTHFIELD', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CAMERON', '', '', 'TAYLOR', '6394 BERCHVIEW DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'INDIAN LAND ELEMENTARY', '4137 DOBY BRIDGE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CAAF', '', 'LOS ANGELES', 'CA', '90045', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'D&D', '', 'KINGSPORT', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HULL', '', 'GREENFIELD', 'OH', '45123', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SHEAD', '', 'TULSA', 'OK', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BRIAN SHEPHERD', '8937 CRESCENT LODGE DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RORY SIGGINS', '553  OLD STILL RD', 'WAKE FOREST', 'NC', '27587', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRAD', '', '', 'JOHNSON', 'SUMMERSTON', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CIRIGNANO', '5 BIRCH RD', '', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRIAD', '', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LANG', '8119 TOWNLEY ROAD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JEAN WILLIE', '12053 HWY 1078', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROMERO', '7563 COYARE RUN W', '', 'FL', '33433', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KNAPP LOGISTICS AUTOMATION', '2124 BARRETT PARK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '18851 NW 29TH AVE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TAYLOR', '26825', 'ATHENS', 'AL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'POLICE', '', 'MONROE', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WINDFOHR DESIGN', '3310 WEST MAIN', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'SAM', '', '', 'BROWN', '664 LINCOLN', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'COBB', '5302 CHERRIER PL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ADVANCE AUTO', 'UNION', 'BUFFALO', 'NY', '14225', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3335 S A ST', 'OXNARD', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TRATTORIA', '135 WEST THIRD ST', 'NEW YORK', 'NY', '10004', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'G', '201 MAPLEBROOK DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CALICO', '1041 KENOSHA', '', 'OK', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'Z WEST INSURANCE GROUP INC', '71222 S GRIFFITH PLACE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'REDLINE PREFORMANCE PRODUCTS', '50TH ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ROBERT MORREALE', '6734 GREGORY CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NOBLES TIRE', 'PARK AVE', 'HOUMA', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARY', '', '', 'WILSON', '1365 FREEWAY BLVD', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PANERA BREAD', '541 VISTA AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MOULDER', '1451 SLATE MINEN DR', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SMOOTHIE KING', 'FEDERAL HWY', 'HOLLYWOOD', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SOLOMON', '7110', 'BETHESDA', 'MD', '20817', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JACKSON', '606 RUTH ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MFI', 'MAIN ST', 'HAVELOCK', 'NC', '28532', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2924', '', 'NY', '11959', '', Constants.TAG_ENTITY_BIZ }
  , { 'LUIS', '', '', 'VALOY', '305 MAIN ST', 'HAZLETON', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARLENE REALI', '615 E RIVER RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PARK', '84631 LIVE OAK', 'FORT HOOD', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WILLIAMS', '240 MOTOR', 'HOWELL', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CARLSON', '1991 E JOPPA RD', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PALMETTO GENERAL HOSPITAL', '2001 W 68TH ST', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'RIVER AVE N', 'INDIANAPOLIS', 'IN', '462110001', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ERIC', '', '', 'SUTTON', '14744 TWIN BAYS RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'D', '', '', 'BRUMFIELD', '5450 PRAIRIE STONE PWK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOL', '1947 507TH', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BRIAN', '', '', 'HODGSON', 'MAIN', 'FREDONIA', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SPAGNOLIA', '10 PT RICH', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '520 8TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MCDONALDS', '', 'LUBBOCK', 'TX', '79416', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A PEAK', '', 'OKLAHOMA CITY', 'OK', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '511 SE 3RD ST', 'OCALA', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RANDALL CLEARY', '4550 POST OAK PLACE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'GARY', '', '', 'CRUCE', '', '', 'KY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '100 SE 2 ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JULIE', '', '', 'ANDERSON', '52', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CARQUEST AUTO PARTS', '', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PAMELA AND ROSE', '100 MAIN ST', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'JOHN YOUNG PARKWAY', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PORTILLO', '7720', 'HOLLYWOOD', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KELLYS', 'PUTNAM ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'WILLIAM', '', '', 'JUSTICE', '', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DIANE', '', '', 'BROWN', '400 ATRIUM DR', '', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WALTER', '1040 S PARKWAY FRONTAGE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1111 HOWE AVE', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'CASTILE CT', 'WOODBRIDGE', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'C', '', '', 'STRICKLAND', '1978 HAMS', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DICKS', 'MAIN', 'CLINTON', 'ME', '4927', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HAMMER', '6107 W AIRPORT', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ALTOBELL', '13065 CAMINITO CARMEL LAND', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'FORD', '382 FORD', '', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NANCY DERIAN', '', 'LOS ANGELES', 'CA', '90024', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'EMILS JEWELY', 'PARK AVE', '', 'NY', '13903', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'RODGERS', '2121 US HWY 441', 'DUBLIN', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BRINKMAN', '1106  FRANKLIN CT', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KROGERS', '2010 STERLING RUN BLVD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MILLER', '', '', 'MO', '64050', '', Constants.TAG_ENTITY_BIZ }
  , { 'JACKIE', '', '', 'WILLIAMS', '150 KETTLETON', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'HERMAN', '', '', 'MEDINA', '22  RANGER RDG', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARLENE REALI', '615 E MAIN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RONA', '', '', 'DOVE', 'HICKORY KNOLL', 'SANDY SPRING', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HENDRICK', '1255 FRANKLIN ALEXANDER', '', 'LA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5925 KIRBY', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JEFF', '', '', 'KING', 'POINT WHITE DR', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DEMBA  DIALLO', '968 NORLAKE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARIE', '', '', 'ROSE', '321 DANIEL DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1300 CLAY ST', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HUNG K TRAN', 'APT 218', 'WESTMINSTER', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KEN', '', '', 'MAYO', '247 FULTON RUN RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JULIE', '', '', 'FISK', 'WASHINGTON AVE', 'NEW BALTIMORE', 'NY', '12124', '', Constants.TAG_ENTITY_BIZ }
  , { 'LARRY', '', '', 'BELL', '4401 WHEELER ST', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LINDA', '', '', 'DREWS', '2605 COLLEGE COURT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'C', '6914', 'ALAPAHA', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LAUREN', '', '', 'WRIGHT', 'NW 8TH CT', 'ANKENY', 'IA', '50023', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CLARK', 'PO BOX 5039', 'FORT HOOD', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FAMILY DOLLAR', 'HIGH', 'HAMILTON', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CHAPMAN', '2100 TORENCE CHAPEL ROAD', 'CORNELIUS', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GONZALEZ', 'FRANKLIN SQ', 'RANDOLPH', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'COSLO', 'SPRING GROVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JACKIE', '', '', 'WILLIAMS', '150 KETTLETON', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'TEXAS BURGER', '', 'MIDLAND', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CHESTER', '5126 149TH AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GALLET & ASSOCIATES  CUL', '1716  2ND AVE NW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'S GINNYS', '', 'MIAMI', 'FL', '33156', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KINNEY', '', 'MERIDIAN', 'ID', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'PATRICIA', '', '', 'DISE', '969 BRIDGE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WOODWARD GOVERNOR', '', 'LOVELAND', 'CO', '80538', '', Constants.TAG_ENTITY_BIZ }
  , { 'KATIE', '', '', 'BRANNAN', '425 S 5TH', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOSHUA', '', '', 'DAVID', 'FAIRVIEW', 'ROANOKE', 'VA', '24011', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '255 ALHMABRA CIR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DAVID', '', '', 'SAWYER', '12 OAKS', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '901 LEOPARD', 'CORPUS CHRISTI', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'ROMANO', '350 WILBUR HENRY', '', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KEN MAYO', '247  FULTONS RUN RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SMITH', '201 NORTH HOSKINS ROAD', 'CHARLOTTE', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PROVIDENCE GATEWAY', '', '', 'RI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MIKE CHAT', 'VALLEY', '', 'CA', '91607', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BABLITZ', '438 NORRISSVILLE RD APT 3D', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DON', '', '', 'VICTORS', '4TH', 'PASCO', 'WA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHUCK', '', '', 'HAMMETT', '627 GILLETTE DRIVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '317 MADISON AVE', 'NEW YORK', 'NY', '10017', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LISA LANDIS', '100 S LOGAN', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DEPAUL FAMILY SERVICES', 'WATERLICK RD', 'LYNCHBURG', 'VA', '24502', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'MELROSE', 'IRVINGTON', 'NJ', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NATGUN', '29 VALLEY VIEW', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'OBERMAYER', '12 SHERATON DR', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MCKESSON', 'COMMERCE BLVD', '', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MR CLYDE HODGES', 'PO BOX 802172', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CHRISTINA NAVA', '', 'LONG BEACH', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHRIS', '', '', 'EDEN', '', 'CHICAGO', 'IL', '60661', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '250 S STAGECOACH TRAIL', 'SAN MARCO', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'MCLEAN', 'FOOTHILL BLVD', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOHN', '', '', 'BINU', '', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '447 IRVING AVE', 'WILLOUGHBY', 'OH', '44094', '', Constants.TAG_ENTITY_BIZ }
  , { 'ERIC', '', '', 'SUTTON', '14744 TWIN BAYS RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'A', '', '', 'CAIRO', '507 MYRTLE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LOCKHEED', '1040 S PARKWAY FRONTAGE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DONATOS', 'HIGH', 'HAMILTON', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JANE JOHNSTON', '778  UNION RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HALL', '', '', '', '32963', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KELLOG BROWN & ROOT', '601  JEFFERSON ST', 'HOUSTON', 'TX', '77001', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NATIONAL PARK INN', '5945 CORN HUSTER DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BROWN', '3810 GWYNN OAK AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SUTHERLAND', '5001 143RD', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'G E MONEY', '', 'INDEPENDENCE', 'MO', '64050', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CAPRI POOLS', '1287 G A R DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ERIN WAGNER', '520  MAIN ST', 'GRAPEVINE', 'TX', '76051', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '9130 LEESWOOD RD', '', 'MD', '21014', '', Constants.TAG_ENTITY_BIZ }
  , { 'MARY', '', '', 'CLARK', '98 GAWOM DR', '', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHELE', '', '', 'ALEXANDER', '1307 COZBY', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GAN', '', 'MATTHEWS', 'NC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'D', '', '', 'POLL', '', 'MARBLE', 'CO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '200 CONSTITUTION', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SODEXO', '', 'AUGUSTA', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WILLIAMS', '', '', '', '33619', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LEINHARDT', '', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '303 PEACHTREE CENTER AVE', 'ATLANTA', 'GA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARCY CASINO IN DELAWARE PARK', 'LINCOLN PKWY', 'BUFFALO', 'NY', '14201', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MADISON BANK OF MARYLAND', '6800  HARFORD RD', 'BALTIMORE', 'MD', '21221', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5757 WILSHIRE', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FALCONE', 'E 22ND ST', 'BROOKLYN', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'QUARLES', '', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '5601 N SHERIDAN', 'CHICAGO', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ST CLAIR', '2522 SUMMIT', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'RIVERA', '10 BROAD ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RICHARD', '', '', 'NYLEN', 'PO BOX 46043', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '311 MAIN ST', '', 'NY', '12839', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MASTER CHEMICAL', '1056 CHURCHILL CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'DANIEL E', '', '', 'AMES', '4953 MARY LOUISE CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '19925 GULF BLVD', 'INDIAN SHORES', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MD ANDERSON CANCER CENTER', '', 'BASTROP', 'TX', '78602', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KANE', '40 W GATE PARKWAY UNIT L', '', '', '28806', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JENKINS', '9040 HUDSON RD STE 203', '', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '11160 VIERS MILL', 'WHEATON', 'MD', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '4140 SW 28TH WAY', 'FT LAUDERDALE', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KIMBERLY', '', '', 'JONES', '', 'LAKE VIEW', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'LABLEURT', 'S MAIN ST', '', 'OH', '44262', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ZHANG JINGSHU', '912 RIVER AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'N COUNTY CENTER', 'RTE 22', '', 'NY', '1', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', 'FIELD ST', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'OCONNOR', '', 'CINCINNATI', 'OH', '45246', '', Constants.TAG_ENTITY_BIZ }
  , { 'DANIEL', '', '', 'SALAZAR', '7TH', 'CAPE CORAL', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DC MARTIN', '36TH', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A', '6107 W AIRPORT', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ASHLEY TAYLOR', '4594 TERRACE', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BETTY', '', '', 'PERKEY', '994 CR 5250', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'RUTH ANN', '', '', 'REGAN', 'HIGHLAND ST', 'MARLBORO', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '44505 FORD', 'CANTON', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'LORI', '', '', 'WILLIAMS', '2323 NW GRAND', '', 'OK', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CO', '500 NW 12TH AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'WILLIAM', '', '', 'BENNETT', '46 VINE ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'NANACY', '', '', 'CHAPPLE', '7TH', '', 'PA', '15010', '', Constants.TAG_ENTITY_BIZ }
  , { 'MICHAEL', '', '', 'THOMSON', '34 ROBIN HOOD RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FIRST BAPTIST CHURCH', '2517 N 107TH AVE', '', 'AZ', '85323', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DURA KOOL', '', '', 'IL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DRESSEL', '1025 CREEK COURT', '', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'A', '', '', 'MARTIN', '111 OBRIAN WAY', 'COLUMBIA', 'SC', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'KELLY', '', '', 'CURELL', '232 MOUNT TOM RD', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'YVETTE', '', '', 'WILLIAMS', '', '', 'PA', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JEFFREY S', '', '', 'ASHER', '1203 CHRISTINA CT', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'ROBERT', '', '', 'ELLIOT', 'BROADWAY STREET', 'SPRINGFIELD', 'VA', '22134', '', Constants.TAG_ENTITY_BIZ }
  , { 'CHRIS', '', '', 'NELSON', '809 W PENNSYLVANNIA AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THE PANTRY', '', 'SHREVEPORT', 'LA', '71107', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JOSEPH PIETROCINI', '2364 BECKETT CIR', '', 'OH', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '2001 NW 31ST AVE', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'NOVACK', 'SW PALATINE HILL RD', '', 'OR', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BIRDS EYE AUTO', 'N WALNUT AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'NATASHA', '', '', 'ROBINSON', 'NORTH AVE', 'FT PIERCE', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'HUBBARD HALL', 'MAIN ST', 'CAMBRIDGE', 'NY', '12816', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GREEN', '317 CENTRAL AVE', 'INDIANAPOLIS', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'NOREEN', '', '', 'MILES', '5970 N COUNTY RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '3  TIMES SQ', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BRENDA  ROSS MS', '325  MARKET ST', '', 'TN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1133 BROADWAY', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '800 CYPRESS GROVE', '', 'FL', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'IRS', '8101 TOM MARTIN DR', 'ADAMSVILLE', 'AL', '35005', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'THE JUDY COMPANY', '5 & OAKE ST', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'KLEINBERG ELECTRIC INC', '/E  15TH ST', 'BROOKLYN', 'NY', '11229', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1555 N VINE ST', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PIERCE', '4188 ANDERTON', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GOLDEN OAK', 'PO BOX 4277', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '955 PRATT AVE', 'ELF GROVE VILLAGE', '', '60006', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'POWELL', '925 DIXIE DR', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'JOANNA', '', '', 'KLEIN', '9625 HAWLEY DR', '', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'JOHNSTON MURPHY', '145 BROADWAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1160 CAMINO CRUZ BLANCA', 'SANTA FE', 'NM', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WIENS', 'ADAMS MILL RD', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEALING', '', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '76 MAIN ST', 'NORTH READING', 'MA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'WALGREENS', 'MAIN ST', 'PROVIDNECE', 'RI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'FSI', '', 'ST CLOUD', 'MN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BENNINGHOFF', '4226 N 22ND', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'SEARS', '1140  SHAW AVE', 'CLOVIS', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'GENE FREEMAN', '2616  RIDGEVILLE RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'MARY OWENS', '25670 N SHORE PL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '1100 NEW YORK AVE', '', 'DC', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'PAYNE', '2119 RIVER ROCK', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BELL', '3002  PIONER WAY', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '10300 EATON PLACE', '', 'VA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOMINOS', '956  CHERRY ST', '', 'CO', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'DOLLAR GENERAL', '', 'SMITHVILLE', 'TX', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'A', '267 S RICHLAND ST', '', 'IN', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'C A SIMON', '', '', 'PA', '15236', '', Constants.TAG_ENTITY_BIZ }
  , { 'JIM', '', '', 'ZUNDEL', '71222 S GRIFFITH PL', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BURGER', '', 'VENTURA', 'CA', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CARPENTER', '6830 STATE ST', '', 'MI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'CLARK CINDY', '22724 BAYVIEW AVE', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'BRACY', 'TREESONG RD', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', 'ST MARTIN', '8TH', 'CLINTONVILLE', 'WI', '', '', Constants.TAG_ENTITY_BIZ }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_BIZ }
  , { 'BEVERLY', '', '', 'TRUCSHEITT', 'MEADOW', '', '', '80439', '', Constants.TAG_ENTITY_BIZ }
  ], UPS_Testing.layout_TestCase);
