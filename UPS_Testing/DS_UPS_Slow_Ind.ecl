import UPS_Services;
Constants := UPS_Services.Constants;
export DS_UPS_Slow_Ind := DATASET( [
   { 'E', '', '', 'WATTS', '', 'CALDWELL', 'ID', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '6834 NW 77TH CT', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WESSEL', '', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'POPPLER', '867 CLEVELAND AVE S', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEARS ROEBUCK CO', 'RICHMOND RD', '', 'OH', '44143', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ST FERDINAND CHURCH', 'CORONEL', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ESCROW FOR YOU', 'OCEAN VIEW', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JERRY GADDIS', '6TH ST', 'MORGAN CITY', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '8116 S TRYON ST', 'CHARLOTTE', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '9821KATY FWY', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ARBOR OAKS', '715 SEMINOLE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SGT CRISTIAN CRUZ', '14555  SCHOOL ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ENDO PHARMA', '100  ENDO WAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'HAROLD', '', '', 'MILLER', '195 CO RT', 'MEXXIO', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HOMETOWN HEALTH CARE', '1681  WOODBRIDGE PARK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'GLORIA', '', '', 'NOMURA', '8TH', 'STOCKTON', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '28 WESTHAMPTON WAY', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KENDRA MARTIN', 'SUMMIT AVE', 'GREENSBORO', '', '27405', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1830 1ST AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'PATTY', '', '', 'MITCHELL', '4981 MONTEZUMA', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'UNION VILLAGE CENTER', '', 'UNION', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MELODY', '', '', 'LEIGHANN', 'TREESONG RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LEE', '', '', 'BAYLESS', '1110 3RD AVE', 'SEATTLE', 'WA', '98101', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WAL MART', '1030  HUNTERS CROSSING DR', 'CYPRESS', 'TX', '77429', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BANK OF AMERICA', 'MEETING ST', 'CHARLESTON SC 29401', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A 1 PRO HOME SERVICE', '', '', 'MD', '20602', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '8500 BLUEBONNET', 'BATON ROUGE', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PURVEY', '1ST', 'GAINESVILLE', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CTS', '', 'YORK', 'PA', '17404', '', Constants.TAG_ENTITY_IND }
  , { 'KATHY', '', '', 'MULLER', '3825 TAMARA', '', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { 'AL', '', '', 'STONE', '125 OLD FINCHER DR', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'LUANN', '', '', 'RICHARD', 'LAKEVIEW', '', 'MI', '48467', '', Constants.TAG_ENTITY_IND }
  , { 'CYNTHIA', '', '', 'J', '331 HILTON TERRACE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOE', '', '', 'FLORES', '', 'SAN JUAN PUEBLO', 'NM', '', '', Constants.TAG_ENTITY_IND }
  , { 'RON', '', '', 'RAMSEY', '', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAMES', '', '', 'ADAMS', '', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RE NU', '32ND', 'GRAND RAPIDS', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BREINLNIGER', '212  DICKERSON HOLLOW LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CSI', '5351  HWY 311', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ST CLAIR TOWNSHIP', 'JACKSON', 'OVERPECK', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TO A TEE', '7125 GIRLS SCHOOL AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '314 E 41 ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GUIMARAES', '207 22ND', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CABINET SHOWROOM', 'MAIN', '', 'NY', '11944', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SHARON MCGINNIS', '105 E IVY BRIDGE DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KONNAND', '117 N MAIN ST', '', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MEH GERALD CHU', '605  BODE WEST RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'RUTH', '', '', 'WRIGHT', 'PO BOX 9839', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'MCFARLAND', '702 N COLLEGE AVE    APT 4', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MYERS', '160 COZAD', '', 'OH', '45434', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EVANS', '871 DYKE', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HENDRICK', '1255 FRANKLIN ALEXANDER', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '600  MERIDIAN ST EXT', 'GROTON', 'CT', '6340', '', Constants.TAG_ENTITY_IND }
  , { 'BREE', '', '', 'SMITH', '533 NE 3RD AVE', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'PHUONG', '', '', 'PHAM', 'MAIN ST', 'HERSHEY', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'QUARTERMAN', 'FOREST MOUNTAIN', '', 'VT', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PC MALL', '', 'MEMPHIS', 'TN', '38118', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HOOTEN CONSTRUCTION', 'CORNERSVILLE HWY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'WILLIAM', '', '', 'WARD', '', 'NEWMAN', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'A', '', '', 'CAIRO', '', 'STATEN ISLAND', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BEAR', '2518 BROWN MILL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALLEN DULANEY', 'MAGNOLIA ST', 'EDWARDS', 'MS', '', '', Constants.TAG_ENTITY_IND }
  , { 'DIANE', '', '', 'OCONNOR', '1050  OAK CREEK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ELIZABETH', '', '', 'BLUM', 'DOBY RIDGE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'ZELKE', '', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'C&S AUTO REPAIR', 'MAIN ST', 'TARBORO', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAMES', '', '', 'MADY', '110  DRAPER LN     1G', 'HASTINGS ON HUDSON', '', '0', '', Constants.TAG_ENTITY_IND }
  , { 'JOSEPH', '', '', 'RUMORE', '374 STOCKHOLM ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RABUL', '15419 GREAT GLEN LN', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KENNEY', '7', 'CENTENNIAL', 'CO', '80112', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '13501 KATY  FWY', 'HOUSTON', 'TX', '77382', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'U S BORAX', '14486  BORAX RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DIVA', '', 'LOUISVILLE', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { 'DANNY', 'R', '', 'WOOTEN', '', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FISKAA AUTO SALES', 'W MAIN ST', 'NELLISTON', 'NY', '13410', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROBERT OLSON', '3833RD ST', 'LAGUNA BEACH', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GIVENS', '', '', '', '38109', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'T N & ASSOCIATES', 'S ILLINOIS AVE', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { 'ANDREW', '', '', 'GOODWILL', 'PINE', '', 'PA', '16748', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '430 S CAPITOL ST', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '150 MONUMENT RD', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOE', '', '', 'DUNN', '113 OMER ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ATHOL ANIMAL CONTROL', 'MAIN ST', 'ATHOL', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STEWART', '281', 'LEXINGTON', 'KY', '40503', '', Constants.TAG_ENTITY_IND }
  , { 'STEPHEN', '', '', 'PEARL', '1056 CHURCHILL ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SALEM AQUATIC CENTER', '1287 G.A.R. DRIVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ATT', '', 'LOUISVILLE', 'KY', '40212', '', Constants.TAG_ENTITY_IND }
  , { 'MICHELLE', '', '', 'WALSTON', 'PO BOX 17608', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HEATHER LEWIS', '7300 W 110TH ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'KIM', '', '', 'SANDERS', '3874 BLACK HOLLOW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARIA', '', '', 'RIVERIA', '3340 RESIVOUR RD NW', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MANTECA EQUIPMENT RENTAL', 'MAIN', 'MANTECA', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'WATTS', '6561 NW 21ST CT', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALLIED WASTE', '7100  CHURCH RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'USCHO', '22510 HIGHWAY 7', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'ERIC', '', '', 'LAI', '5470', 'LA JOLLA', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'J SMITH', '1591  JULIUS ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'KIM', '', '', 'ROBERTSON', '502 BAR CK RANCH', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BLAKE ROBINSON', '6866  ROYAL HARVEST WAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MONAHAN', '1055 LISMORE LN', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CLARK', 'BAYVIEW AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HAWS', '179', '', 'NY', '11763', '', Constants.TAG_ENTITY_IND }
  , { 'LORI', '', '', 'DELUCCA', '204 CLYDESDALE CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '6975 W 2ND LN', 'HIALEAH', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CMYK DESIGN', '9808 NW 80TH AVE', '', 'FL', '33016', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HALLEY', '', '', '', '62206', '', Constants.TAG_ENTITY_IND }
  , { 'AUDREY', '', '', 'CREWELL', 'W BARNET', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'HOWARD', '', '', 'BRYANT', 'WOODLAND ST', '', '', '38401', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CRAWFORD & CO', '', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BIRD DOG CAT FISH', '', 'SAN ANTONIO', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '319 LAFAYETTE ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JUST 2 TEASE', '835 NE GREEN OAKS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JOHN GUSTAFSON', '2823  RIVERVIEW DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'SANDY', '', '', 'FAWZI', '300 COLUMBUS CIR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CURRY', '226 BROGILEAU AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BOB', '', '', 'BROOKS', '9443 MISERY POINT RD NW', '', 'WA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'GUSTAFSON', '2823 RIVERVIEW DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '225 PARK AVE S', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ATT', '15240 MAIN ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'DUNLAP', '18616 LAKELAND DR', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'NICK', '', '', 'TORRES', '9460 106TH AVE N', 'LARGO', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'CAROL', '', '', 'CAMPBELL', '', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IVY', '600', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '520 S PARK RD', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KELLYS', '201  PUTNAM ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A KAETER', '', 'ST CLOUD', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JULIA', '', '', 'FREEMAN', '4112 26TH TERRACE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'HWY 90', '', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { 'BRENDA', '', '', 'ROSS', '325 MARKET ST', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '11301 ROCKVILLE PIKE', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FIORELAS', '7008 LAKE CHARLESTON SHORE BLVD', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'SUSAN', '', '', 'LODENQUAI', '3RD', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'YOLANDA', '', '', 'HOCK', 'MAIN ST', 'LISBON', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WS STONE', 'CREEK SIDE RD', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JESUS', '', '', 'ROJAS', '11  RETOSE', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'KATHY', '', '', 'BIONDI', '1315 VALLEY CT', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROB', '', '', 'REA', '250  M ST EXT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'NADINE', '', '', 'BUENO', '8593 HOLLOWAY', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'J W MCCORMICK', '', 'BOSTON', 'MA', '2109', '', Constants.TAG_ENTITY_IND }
  , { 'BILL', '', '', 'PRIEST', '201 EAST JOHN CARPENTER FWY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LSI', 'E 4TH STREET', 'GREELEY', 'CO', '80631', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '6031 NW 99TH AVE', 'MIAMI', 'FL', '33178', '', Constants.TAG_ENTITY_IND }
  , { 'DON', '', '', 'FLOWERS', '2409 CO RD 205', 'HEADLAND', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { 'YVETTE', '', '', 'WILLIAMS', '844', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'MORRIS', '3608 SOMMERVILLE PL RD', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3415 S SEPULVEDA', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DUMAS', '', 'INVERNESS', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'TINA', '', '', 'GROMAN', '4831  35TH AVE SW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PC PRO', 'DEPOSIT DR', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '. NICOLE HAWKINS', '11052  SANTE FE ST N', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'KEVIN', '', '', 'MCCAUL', 'WASHINGTON ST', 'CAMBRIDGE', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NICHOLS', 'ROBY', '', 'NH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MANDY', '', '', 'MAIER', '3674 NORTH PEACHTREE RD', 'ATL', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '117 HOLLEMAN', 'COLLEGE STATION', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'RALPH', '', '', 'HENRY', '11 S MERIDIAN RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SHIPMAN', '2725 S 6TH', '', 'NE', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DEBBIE HAMMES', '1400  EASTEX VETERINARY CLINIC', 'HUMBLE', 'TX', '77338', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3336 EDENBORN AVE', 'METARIE', 'LA', '70002', '', Constants.TAG_ENTITY_IND }
  , { 'C', '', '', 'JEWELL', '18213 JONAMAC AVE', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'FRANK', '', '', 'DUTTON', '66 GARDENS RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BROADWAY SQUARE APARTMENTS', '8751  BROADWAY', 'HOUSTON', 'TX', '77461', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '8720 N KENDALL DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAMES', '', '', 'WILSON', '1901 CREEK RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '557 BROADWAY', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '636 11TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THE JUDY COMPANY', '5 & OAKE ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'CARLTON', '', '', 'HICKS', '640 MAIN ST', 'CLERMONT', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SMITH', '', '', '', '48843', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PROCO', '', 'STOCKTON', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CTS TECH', '', 'INDIANAPOLIS', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FROOTS', '640 W CROSVILLE RD', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'K1432719720', '', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'W LINCOLN AVE', 'ATLANTIC HIGHLANDS', 'NJ', '7716', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SAMS CLUB', '738 ARBOR CIRCLE DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'J SMITH', '1591  JULIUS ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MENDEZ', '', 'EAGLE PASS', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'DOLLY', '', '', 'HARRIS', 'HICKORY', 'GARY', 'IN', '46403', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CHAPMAN CORP.', 'ELM DR', 'WAYNESBURG', 'PA', '15301', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2839 PACES FERRY RD', 'ATLANTA', 'GA', '30326', '', Constants.TAG_ENTITY_IND }
  , { 'M', '', '', 'SANCHEZ', '', 'NEW HAVEN', 'CT', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'J MART JAPANESE GROCERY STORE', '', 'VIRIGNIA BEACH', 'VA', '23462', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GRACE', ' LOW', '18  BIRCHWOOD PARK DR', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AT&T', '1000  NORTH POINT', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KUM AND GO', '121ST ST', 'DES MOINES', 'IA', '50322', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'MAZZEI', '16 W 751 56TH ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'CAROL', '', '', 'CARLIN', '123 MAIN 209', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KOHL S', '', 'MENTOR', 'OH', '44060', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SIMMS', '6714 MESQUITE CT', 'DISTRICT HEIGHTS', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ADI', '3060 PRAIRIE VALLEY CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'KENNY', '', '', 'DOLL', '3544 TABLE ROCK', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CRL', 'STE 120', 'CARROLLTON', 'TX', '75006', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HAROLD WILSON', 'WILSON MOUNTAIN', 'DOUGLAS CITY', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CENTRUM', 'HUBBARD', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'ELIZABETH', '', '', 'BLUM', 'DOBY RIDGE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LINDA', '', '', 'FLEMING', '', 'DOUGLASVILLE', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRACY', '322 CLEVELAND ROAD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '8849 VILLA LA JOLLA DR', 'LA JOLLA', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BECKETT', 'PATTERSON', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CHEVALIER', '32259', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'PATRICK', '', '', 'RAY', '49TH PL', '', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THOMAS W CUMMINGS', 'THOMAS W CUMMINGS', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRACEY', '4030 S QUENTNO DR', 'CHANDLER', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SHANNON KEOGH', 'OAK AVE', 'CUBA', 'MO', '65453', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A', '267 RICHLAND ST', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ANTHONY LITTLETON', '21773  STATE RTE 1', 'GUILFORD', 'IN', '47022', '', Constants.TAG_ENTITY_IND }
  , { 'DAVID', '', '', 'COSSAOU', 'MONTCALM', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2185 BOLTON STREET', 'BRONX', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LUCAS', '', '', '', '20774', '', Constants.TAG_ENTITY_IND }
  , { 'ALEXYS', '', '', 'RUCKDASCHEL', '7TH AVE SE', 'JAMESTOWN', 'ND', '', '', Constants.TAG_ENTITY_IND }
  , { 'RICHARD', '', '', 'BALDWIN', '118 ARAPAHOE RIDGE', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'XEDIN TECH', 'STE 100E', 'ROUND ROCK', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STOTT', 'MAIN ST', 'WONEWOC', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A PEAK EQUIP', '', 'OKLAHOMA CITY', 'OK', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '241 CENTRAL PARK', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HORNE', '', '', '', '75243', '', Constants.TAG_ENTITY_IND }
  , { 'CHRISTINA', '', '', 'MILLER', '6192 FRANCIS', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BOROUGH OF ATLANTIC HIGHLANDS', 'W LINCOLN AVE', 'ATLANTIC HIGHLANDS', 'NJ', '7716', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GARCIA', '', 'BLUNTZER', 'TX', '78025', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'D & M SUPPLY', '510 CAVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THOMPSON CONTRACTING', '101  PETFINDER LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RIVERA', '10 BROAD ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'XANDER', '195 NE 10TH AVE', 'MIAMI', 'FL', '33179', '', Constants.TAG_ENTITY_IND }
  , { 'VICTORIA', '', '', 'BELL', '4818 WOODLAND ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '505 UNIVERSITY DR', 'COLLEGE STATION', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HECTOR TOPIO', '3456  FULTON ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'HARRY', '', '', 'BRILL', '8 TOWN LINE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LONDONDERRY', '574 MAMMOTH RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'DENNIS', '', '', 'BROWN', 'WALNUT ST STE 200', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHARLIE', '', '', 'BOYLE', 'POB 511', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '451 MEADOW LANE', '', 'CO', '80439', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '300 PARK AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3001 NE 185TH ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MIKE MCCALL', '616 OCEAN FRONT', 'NEWPORT BEACH', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'R', '', '', 'GRIFFIN', '1303 WYNDHAM DR', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'JERRY', '', '', 'MESSER', '15 S 5TH', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARY', '', '', 'WILSON', '819 ETH', 'MITCHELL', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'KATHERINE', '', '', 'SHIRILLA', '6169 EMORY LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JOHN GUSTAFSON', '2823  RIVERVIEW DR', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ANN KENNEDY', '10 KNOLLCREST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JOSE MANUEL ALARES', '11', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MELISSA', '', '', 'MACE', '12008 BROWN RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'R', '', '', 'WALSH', '36023 SAINT TOPEZ', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BUSBY', '950 WHITESETTLEMENT', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'NICK', '', '', 'HERNANDEZ', '', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CAPRI POOLS', '1287 G A R DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRUJILLO', '643', 'BOULDER', 'CO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SAM BURRS', '1078  MALLARD LN', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'DE4BBIE', '', '', 'STEPHENS', '57 S WALNUT BEND RD', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JACKSON', '9256 KORN BRUST DR', '', 'CO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '158', 'NORTH VENICE', 'FL', '34275', '', Constants.TAG_ENTITY_IND }
  , { 'SUZANNE', '', '', 'MOE', 'TWIN BRIDGE DR', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DEMBA  DIALLO', '968 NORLAKE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'AARON', '', '', 'JOHNSON', 'MORRIS', 'FAYETTEVILLE', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARIA', '', '', 'LEON', '15TH ST', '', 'DC', '20005', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'DE NEVE DR', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LOWES', '3460 JEFFERSON PK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'VINCENT', '', '', 'RANDAZZO', '9106  SUMMER WAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'PRISCILLA', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RANDALL', '', 'WINTER PARK', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MERCER', '', 'NEW YORK', 'NY', '10036', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOLLAR GENERAL', '', 'SYLACAUGA', 'AL', '35150', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PAYNE', '2119 RIVERROCK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PAYNE', '2119 RIVERROCK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BENNETT', '3101', 'RICHMOND', 'VA', '23221', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JOSEPH MORANDI DO', '665  MARTINSVILLE RD    STE 218', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HEATHER LEWIS', '7300 W 110TH ST    STE 670', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BATTLE', '', '', '', '1852', '', Constants.TAG_ENTITY_IND }
  , { 'YVETTE', '', '', 'WILLIAMS', '844', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SCHINDLER', '', 'SAGINAW', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RYDER', '103 COMMERCE CIR', '', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEARS', '', 'ELYRIA', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '208 E 51ST ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GATEWAY MALL', '', 'BRONX', 'NY', '10451', '', Constants.TAG_ENTITY_IND }
  , { 'JULIA', '', '', 'FREEMAN', '4112 26TH TERRACE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'J', '606 RUTH ST', '', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RILEE KELSEY', 'RR 1', 'BONE GAP', 'IL', '62815', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '5S. NICOLE HAWKINS', '11052  SANTE FE ST N', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'PRITI', '', '', 'PRITI JANA', '135  BRIARWOOD DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LEE', '98 ARBOUR LN', '', 'FL', '33428', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ORTING WWTP', '902 ROCKY ROAD NE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ALISON', '', '', 'CLIFFORD', '25 26TH AVENUE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FEDCO', '1363 CAPITAL DR', '', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JEAN WILLIE', '12053 HWY 1078', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2301 W SAHARA', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { 'GAYLE', '', '', 'JOHNSON', '', 'FORT SMITH', 'AR', '', '', Constants.TAG_ENTITY_IND }
  , { 'RUTH', '', '', 'JANSEN', '', 'LARGO', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LARK', 'SAGEBRUSH', 'DALLAS', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'USPS', 'MAIN ST', 'FLORA', 'MS', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DS WATERS', '', 'RIVERSIDE', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DENARD', '140 TABGLEWOOD DR', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1300 HOLLMAN ST', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2800 LASALLE PLZ', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'JUSTIN', '', '', 'WILLIS', '', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'JASON', '', '', 'HUANG', '5078', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'PEGGY', '', '', 'BARTO', 'LOCUST', '', 'PA', '15003', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'V', '33 AXIS MONDI RD', '', 'ME', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BINKS', '', 'BROOKLYN', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BLOCKBUSTER', '', 'MCKINNEY', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DAVID KAPP', '100  VETERANS HWY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'M', '4206  GENSEN DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '300 W 21ST ST', 'NEW YORK CITY', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'C', '', '', 'PARK', '124 GRAND AVE', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MCWILLIAMS', '2141 E 500 N', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BRUN', '', 'SHREVEPORT', 'LA', '71107', '', Constants.TAG_ENTITY_IND }
  , { 'BRIAN', '', '', 'JONES', '205 .BLUEBIRD', '', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { 'CYNTHIA', '', '', 'KERSEY', '', '', 'AZ', '85050', '', Constants.TAG_ENTITY_IND }
  , { 'ROLANDO', '', '', 'GOMEZ', '5629 CHILDER ST', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LORD', '333 W PERSHING RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JANUS', '', 'TEMPLE', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LORD', '333 W PERSHING RD', '', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '8200 JONES BRANCH DR', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { 'LISA', '', '', 'BENDER', '7429 US HIGHWAY 522', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SIEMENS BUILDING TECH', '', 'CLEVELAND', 'OH', '44125', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '811 VERMONT AVE', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SW MISSOURI CREDIT UNION', '', 'SPRINGFIELD', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN C', '', '', 'HOWE', '', '', 'CT', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHRIS', '', '', 'MUYLLE', '11650  LANTERN RD    STE 216', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1701 N STATE ST', '', 'MS', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '414 W 120TH ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WYNNS', '', 'STATESBORO', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'CYNTHIA', '', '', 'ADAMS', 'CENTRAL AVE', 'ALBANY', 'NY', '12206', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GRAVES', '2831 QUAIL HOLLO', 'FARMINGTON HILLS', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LUCAS', '', 'PEARISBURG', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WRIGHT', '2141 COLLETTE LN', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'A', '', '', 'MARTIN', '111 OBRIAN WAY', '', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'DRUMHELLER', '5 FAWN LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JERRY', '', '', 'GILLESPIE', '7504 N BROOKLYN PL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'ELM', 'MASON CITY', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '800 N CAPITOL ST NW', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '12900 GARDEN GROVE', 'GARDEN GROVE', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PROVIDENCE O CHRISTMAS TREES', '4831  35TH AVE SW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'KIMBERLY', '', '', 'KNAPP', '1214 COUNTRY GARDEN LANE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'LAKESIDE DR', 'GRANBY', 'CT', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALAM INVESTMENT LLC', 'JIM BOUHACHEM AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BABLITZ', '438 MORRISSVILLE RD APT 3D', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JANE JOHNSTON', '778  UNION RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SUSAN C PACKIE', 'WOODLAND RD', 'GREEN VILLAGE', 'NJ', '79350071', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALLEN', '107 CHEROKEE', '', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { 'KELLEY', '', '', 'MATTHEWS', 'N STATE ST', 'BRANDON', 'MS', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FAMILY DOLLAR', 'HIGH', 'HAMILTON', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HUGHES', '', '', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DONOFRIO', '320199  PO BOX', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALLISON JOHNSON', '814 N MARKET ST 2', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CHRISTOPHER RANDALL', '1140  BROADWAY     STE 1604', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'CINDY', '', '', 'CLARK', '', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A', '15  BICENTENNIAL CIR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1732 SW 5TH CT', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MILLER', '2034 TOWNE LAKE HILLS', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'DONNA', '', '', 'KENT', '97 VALLEY RD', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { 'ERIC', '', '', 'SUTTON', '14744 TWIN BAYS RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EDS', '101 WOODCREST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ANDREW', '', '', 'GOODWILL', 'PINE', '', 'PA', '16743', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WEGMANS', '5360 GENESEE ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARY', '', 'COLD SPRING', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'I', '', '', 'DRIVAS', '34 COLESHEERS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RAMSEY', '40108 MOURA', 'PALMDALE', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEZ', '13  TH AVE', 'BROOKLYN', 'NY', '11219', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'RYAN', '128 S MT VERNON AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LUIS', '', '', 'RIVERA', '10 BROAD ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '\\', '1681 WOODBRIDGE PARK', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ZUNIGA', '38423', 'PALMDALE', 'CA', '93551', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HARAIZ', '', 'WEST COLUMBIA', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ICE CREAM 4 YOU', '', 'LARGO', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'CONSTANANCE', '', '', 'LEITNER', '229 DOUGLAS ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HAGINS', '', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALLEN', '808 CAMBRIDGE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'GEORGE', '', '', 'PETERSON', '127 MARTIN BURG LN', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'DAMES FERRY RD', 'FORSYTH', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CRILLY', '', '', '', '75025', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JH KNIGHT II', 'PEACHTREE RD', 'ATLANTA', 'GA', '30324', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TURNER', '', 'SPRINGFIELD', 'MO', '65809', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CLOUTIER', 'PO', '', 'ME', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BANK OF AMERICA', 'CHESTNUT ST', '', 'CT', '6811', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SHINKER', '22 GREEN ST', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '840 N LARRABEE ST', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KOSCH', '7951 BELLAGIO DR', '', 'NE', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STATER BROS', '375 DE BERRY', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'DANIEL E', '', '', 'AMES', '4953 MARY LOUISE CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TERRY ALLUMS', '173 WOODWORTH AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BRUCE', '', '', 'OSTERWELL', '17TH AVE', 'SAN FRANCISCO', 'CA', '94121', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '163 AMSTERDAM', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HARRIS', '', '', '', '55407', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'MORRICE', '', 'HOUSTON', 'TX', '77005', '', Constants.TAG_ENTITY_IND }
  , { 'DEMBA', '', '', 'DIALLO', '968 NORLAKE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARTIN', '184 ALHAMBRA WAY', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'CATHERINE', '', '', 'WELLS', '12503 5TH NW', 'SEATTLE', 'WA', '', '', Constants.TAG_ENTITY_IND }
  , { 'LISA', '', '', 'BONET', '', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TIMEWISE', '', 'WILLIS', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '274 MADISON AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ICENOGLE', '842 SUNDOWN LN', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CHRYSALIS SALON AND SPA', '4610 GARFIELD', 'MIDLAND', 'TX', '79705', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'SOMERSET COURT', 'NEWPORT', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ECKSTEIN', 'CARDINAL CREEK', '', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { 'DANIEL', '', '', 'MACHOWIZ', '6235 VENICE DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'STACY', '', '', 'ROBINSON', '', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '702 N COLLEGE AVE', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { 'PHYLLIS A', '', '', 'SWARTZ', '262 KOLB RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '621 S NEW BALLAS', 'ST LOUIS', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { 'JESSE', '', '', 'BREWER', '', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HENDRICK', '1255 FRANKLIN ALEXANDER', '', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MCAFEE', 'FRANKLIN', 'LA VALLE', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FAMILY DOLLAR INC', '67TH AVE', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CITY OF GIRARD', 'RR 1', 'SPRINGFIELD', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'DAN', '', '', 'MACLEAN', '5829 GREENHAVEN DR', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GILLERAN', '2991 11 MILE', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'KEITH', '', '', '', 'SMITH', '', 'MN', '56065', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1005 MACON HWY', 'ATHENS', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'ALLEN', '', '', 'DIAZ', '', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HORNETS', '2000 SEGNETTE BLVD', '', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { 'ELIZABETH', '', '', 'BLUM', '4137 DOBY BRIDGE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THE SHIRTS', '13  TH AVE', 'BROOKLYN', 'NY', '11219', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'COOPER', '107 MERITAGE ST', 'GREER', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRACEY', '4030 S QUENTNO', 'CHANDLER', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'MAIN ST', 'EVANSVILLE', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MSH', '5009 HONEYGO', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SULLIVAN COMPUTER CORP / DATA  DOC', '521  SOLOMON WAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CLARK CINDY', '22724 BAYVIEW AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'KNIGHT', '5631 ST RT 505', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { 'KAI', '', '', 'BRAY', '', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'POINTER', '714 W 111TH ST', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'ANNE', '', '', 'LARSON', '', 'PLEASANTON', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SMITH', '3109 W 80TH', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2961 INDUSTRAIL RD', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { 'ANDREW', '', '', 'SMITH', '10 ATHORPE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROBICHEAU', '19TH', 'MONTELLO', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { 'DEB', '', '', 'MURRAY', '20 XMAS TREE', '', 'NH', '', '', Constants.TAG_ENTITY_IND }
  , { 'EDGAR B', '', '', 'DICKSON', '', 'MELBOURNE BEACH', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'LAUREN', '', '', 'GALLIGAN', 'RIDGE', '', 'NY', '10598', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MCDONALDS', '', 'INVERNESS', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GFS', '1672  MARION MT GILEAD RD', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { 'MATT', '', '', 'WOLFF', '88 STEELE ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DE LEON', 'PARK MEADOWS', 'CHULA VISTA', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MACKENZIE', 'COLONIAL', 'SAINT CLAIR SHORES', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BABLITZ', '438 MORRISSVILLE RD APT 3D', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { 'J', '', '', 'WEBER', '8TH', 'EL PASO', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WAI LEUNG LAM', '2329  24TH AVE    FL 3', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ASHLEY', '', '', 'TAYLOR', '4594 TERRACE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EMPI', '1281 BROWN ST', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DIEBOLD', 'RIFKIN', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PUROCLEAN   TRENARY', '2419  COUNTRY CLUB ROAD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'CRAIG', '', '', 'FENNEMORE', 'CENTRAL', '', 'AZ', '85323', '', Constants.TAG_ENTITY_IND }
  , { 'LEON', '', '', 'PEREZ SANCHEZ', '7922 PINES BLVD', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IRS', '844 KING ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'PRICE', 'BROWNSVILLE', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'YVETTE', '', '', 'WILLIAMS', 'KING ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'TRACY', '', '', 'MOORE', '', 'MONROE', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROSEBERRY', '', '', 'TIMBER', 'CENTRAL AVE', '`', 'CO', '80459', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '18101 LORAIN', 'CLEVELAND', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GLOBAL', '', 'SAN ANTONIO', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '255 W 43RDST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MOSS CHIROPRACTIC', '1805 SE 16TH AVE', 'OCALA', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FURNITURE 4 LESS', '124 W. 4TH', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MORTON', '337 CROSBY RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2900 VIA FORTUNA', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LINDSEY FOSTER', '1  DISCOVERY PL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DEBBIE GARRETT', '1415  JACKSONVILLE HWY', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FOGLE', '5515 TARRINGTON', 'FAYETTEVILLE', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALLEN', '29 E 700 N', 'PROVO', 'UT', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'REEBOK', '', 'ORLANDO', 'FL', '32819', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GREEN', '2530 TUSCARAWAS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'SHELLY', '', '', 'BROWN', '', 'SUMTER', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JONES', '13600  EVERGREEN', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'DEBORAH', '', '', 'LANG', '', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '301 GEORGE BUSH DR', 'COLLEGE STATION', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KMART', '1151 S OTSEGO AVE', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'PATRICIA', '', '', 'BARRON', '', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'AMANDA', '', '', 'DECKER', 'GREENWOOD PLACE', 'LOUISVILLE', 'KY', '40272', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CYCLERY', '3308 W 44TH', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '509 MADISON AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'TOPSY LN', 'CARSON CITY', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FORD', 'CLINTON AVE', 'MINNEAPOLIS', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'K.O.N.E.', '', 'NEWARK', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IRS', '2716  COBRE VALLE LN', 'PLANO', 'TX', '75023', '', Constants.TAG_ENTITY_IND }
  , { '[AUL', '', '', 'MALONEY', '', '', 'MA', '1257', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1 PINEHURST CIR', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EDJ LEASING C/O COLLIER', '130  EDWARD JONES BLVD', 'MARYLAND HEIGHTS', 'MO', '630433000', '', Constants.TAG_ENTITY_IND }
  , { 'RICHARD', '', '', 'MOORE', '307 COLLIN LANE', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SC DEPT OF PROB. PAROLE & PARDON', '160  LAWENFORCE CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'CAROL', '', '', 'KELLEY', '2863 KELLEYS GLEN', '', 'WA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RENT 1ST', '1320 NW SHERIDAN     STE 102', '', 'OK', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KLEINBERG ELECTRIC INC', '/E  15TH ST', 'BROOKLYN', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MOS', '1421 CHAMBERS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MOS', '1421 CHAMBERS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'EXCHANGE ST', 'LEOMINSTER', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THE TRANNY SHOP', 'SOUTH MAIN ST', 'PALMER', 'MA', '1069', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOLTON BEARS', '6479  MADISEN LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JETRO CASH CARRY', '1030 W DIVISION', 'CHICAGO', 'IL', '60643', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '731 VISTA ISLES DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RAYMORE', 'HIGHLAND', '', 'PA', '19355', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'OTHERWISE', 'E7577 SMITH ROAD', '', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { 'ANNE', '', '', 'JACKSON', '', 'ST LOUIS', 'MO', '63116', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HACH', '', 'FORT COLLINS', 'CO', '80538', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '4031 NE 17TH TER', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'WILLIAM', '', '', 'COOK', '230 BOWMANS BOTTOM', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CORONADO MEDICAL GROUP', 'PROSPECT', 'CORONADO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '11 MARTIME AVE', 'WHITE PLAINS', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MANORCARE', '505  WEYMAN RD', 'WHITEHALL', 'PA', '18052', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'FIRST', 'SARALAND', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'G', '201 MAPLEBROOK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SANDERS', 'GORDON', '', 'MS', '38930', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CHRISTMAN', '3795 LEONARD', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'ELIZABETH', '', '', 'BLUM', '4137 DOBY BRIDGE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '4447 N CENTRAL', 'DALLAS', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRANNY SHOP', 'SOUTH MAIN ST', 'PALMER', 'MA', '1069', '', Constants.TAG_ENTITY_IND }
  , { 'PERE', '', '', 'PERS', '1414 MADISON AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'H&R BLOCK', '', 'FRIENDSHIP', 'WI', '539340491', '', Constants.TAG_ENTITY_IND }
  , { 'RICARDO', '', '', 'MEJIA', 'LAKEVIEW DR', 'WESTON', 'FL', '33326', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KUKLA', '', '', '', '43623', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HENDRICK', '1255 FRANKLIN ALEXANDER', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ARMSTRONG', 'NORRIS FERRY', 'SHREVEPORT', 'LA', '71106', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TATTOO ROLO', '39 E PULTENEY ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JAMES E LONG', '1016 W EDGEWOOD DR', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'CARTER', 'APT 306', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DURA COOL', '4944 GLEN LANE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ANNE', '', '', 'TAYLOR', '', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SHELL OIL', '3333 ROUTE 6 S', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'VINALHAVEN WATER DISTRICT', 'MAIN', 'VINALHAVEN', 'ME', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MOORE', '203', 'CLEVELAND', 'TX', '77328', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'PACIFIC AVE', 'WEDNESBURY', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SANCHEZ', '374 SIERRA MADRE', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WWTP', '902 ROCKY ROAD NE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MIKE', '', '', 'MORRIS', '5TH & OAK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RETAIL', '137 HWY 87', '', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IRS', '201 TOWER PARK', 'WATERLOO', 'IA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LEIGHANN', 'TREESONG RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AAA AUTO CLUB SO', '601 EAST ATLANTIC BLVD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALFA', '', 'FISHERS', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { 'ANDREW', '', '', 'SMITH', '10 ATHORPE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5217 OLD SPICEWOOD SPRINGS RD', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'CATHY', '', '', 'WAGNER', '312 N LIBERTY', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOLLAR GENERAL 9767', '', 'CLEVELAND', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'MIKE', '', '', 'RUSSO', '', '', 'RI', '', '', Constants.TAG_ENTITY_IND }
  , { 'CAROL', '', '', 'SCOTT', '68 GRANDVIEW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BUCHAN', '5016 SADDLE HORN', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHARLEY', '', '', 'COOK', '851  TIP TOP RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HOMETOWN HEALTH CARE', '1681 WOODBRIDGE PARK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IPOLITO', '824 S MACDILL AVE', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NATIONAL PARK INN', '5945 CORN HUSTER DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARILYNN', '', '', 'MASON', '6025 GARCIA', 'KAUFMAN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1540 BROADWAY', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'CEDAR CREEK', 'CONROE', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NEES', ' KAY E', '1120 E HOWARD MILLER DR', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MCGINEES', '', 'WILMINGTON', 'DE', '19808', '', Constants.TAG_ENTITY_IND }
  , { 'TIFFANY', '', '', 'REED', '5121 SWEET BAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KAMAN IND. TECH.', '', 'MARIETTA', 'GA', '30066', '', Constants.TAG_ENTITY_IND }
  , { 'VICTORIA', '', '', 'BELL', '4818 WOODLAND ST', '', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NACE DENNIS', 'HIGHLAND', 'LOGANVILLE', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NVEC', '10323 LOMOND DR', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BLAKE ROBINSON', '6866  ROYAL HARVEST WAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WERTH', '11100 SHELBY OAKS DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'AUGUSTA', 'SAVANNAH', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'COLLEEN CARROL', '3731  TANGLEWOOD LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CARDON', 'SYCAMORE', 'LOS ALAMOS', 'NM', '', '', Constants.TAG_ENTITY_IND }
  , { 'MONICA', '', '', 'GARCIA', '', 'MIAMI', 'FL', '33183', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5000 SW 75TH AVE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'SMITH', '', 'ALBUQUERQUE', 'NM', '87112', '', Constants.TAG_ENTITY_IND }
  , { 'MARIA', '', '', 'RIVERIA', '3340 RESIVOR RD NW', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'COUNTY ROAD E', 'WESTFIELD', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HACH', '', 'FORT COLLINS', 'CO', '80537', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2857 NE 32ND ST', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'ELLIS', '', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { 'TOM', '', '', 'WILLIAMS', '4900  FROLICH LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MULGREWS', 'CARELTON ST', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MI T M CORPORATION', '', '', 'IA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'V. MONROE/MARTE KLIESH', 'APT 4102', 'LARGO', 'FL', '33773', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PARSONS', '', 'RENO', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { 'DEBORAH', '', '', 'BATTISTO', '2240 MORTON GROVE ROAD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'DAVID', '', '', 'REED', '12067 7TH AVENUE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'YARNELL', 'BROADWAY', '', 'AZ', '85362', '', Constants.TAG_ENTITY_IND }
  , { 'BRAD', '', '', 'JOHNSON', 'SUMMERSTON', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARCO', '', '', 'ESTRADA', '308 N PRIMROSE LN', 'STANFIELD', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'L', '8119 TOWNLEY ROAD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HARTLEY', '3211', 'RICHMOND', 'VA', '23221', '', Constants.TAG_ENTITY_IND }
  , { 'STACIE', '', '', 'ROBINSON', '', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'RANDY', '', '', 'PREJEAN', '673 LAKEWOOD DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BELL', '', '', 'ME', '4901', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2999 NE 199TH ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'STATE RD', 'KULPTOWN', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'KEVIN', '', '', 'CLARK', '', 'WALLACETON', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { 'GAIL', '', '', 'TYLER', '289 FLOWER COURT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MASON', 'E 8TH AVE', 'BIRDSBORO', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MULLEN', '', '', '', '77096', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BEARS GRAPHIC & SCREENING', '7307  GEORGE WASHINGTON MEM HWY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GRUBER & CO', 'STE 1040', 'ATLANTA', 'GA', '30328', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1 MAIN STREET', 'ROOSEVELT ISLAND', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GARNER METAL', 'S MAIN ST', 'MONROE', 'OH', '45050', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'THE LAURELS', 'ENFIELD', 'CT', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DIANE KELLY', '6415 BABCOCK', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LISA LANDIS', '100 S LOGAN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HELLER', '282 VIA NARANGA', '', 'FL', '33432', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GT FEILDS', '', 'BIRMINGHAM', 'AL', '35259', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A', '267 RICHLAND', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { 'K', '', '', 'VALDES', '', 'DAYTON', 'OH', '45434', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KELLOGGS', '', 'CHICAGO', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '10560 MAIN ST', 'ALEXANDRIA', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MEAG NEW YORK', '544  MADISON AVE', 'NY', 'NY', '10022', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'L', '2557 WALNUT PIKE DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHNSON', '', '', 'SMITH', '', 'JOPLIN', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'COSTA', '', 'NAMPA', 'ID', '', '', Constants.TAG_ENTITY_IND }
  , { 'HEATHER', '', '', 'LOWE', '801 AVE E', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARLYS', '', '', 'OLSON', '', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '8977 WILES RD', 'CORAL SPRINGS', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '305 FAYETTE ST', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { 'BOBBY', '', '', 'MILLIGAN', 'WATER WOOD DR', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HALEY', 'RIVERVIEW', 'STOCKTON', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'CAROL', '', '', 'ROKOSS', '9703 COMMON CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAMES', '', '', 'DAVIS', '13692 FM 1994', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'RICK', '', '', 'LEWIS', '5956 SMITH HILL RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'OCONNOR', '1050 OAK CREEK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JACKSON', '606 RUTH ST', '', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHRIS', '', '', 'MUYLLE', '11650  LANTERN RD    STE 216', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAMES', '', '', 'GACKSTETTER', '18TH AVE NO', 'ST CLOUD', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'YUE LI', 'WEST     APT 3508', 'CHICAGO', '', 'IL', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'POWELL', '2604 THOMSON TOWN RD', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARCUS', '', '', 'WARE', '859 CONVENTION CENTER BLVD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'K&B AUTO SALES', '', 'HICKORY', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DESIREE ROGERS', '3303 W CREST ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JILL', '', '', 'NEWMAN', '10107 GARY RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FERGUSON', '55500  GRAND RIVER AVE', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ZIETLOW', '', '', '', '49456', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'MAIN ST', 'CANTON', 'MS', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAMES', '', '', 'STARKEY', '', 'CLARKSBURG', 'WV', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SCHAFFER', 'RR1 BOX135', 'DUBOIS', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'UNIDENT', '1818', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JAMES LUI', '7301 BAYMEADOWS WAY', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'DAN', '', '', 'BILLMAN', '2802A LUCON RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SC JOHNSON', 'GRAND', 'RACINE', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SHINDE', '279 WINTHROP ST N', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '110 SE 24TH ST', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'JIM', '', '', 'BELOW', '453 FOREST AVE', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SMITHS', '5TH', 'COVINGTON', 'KY', '41011', '', Constants.TAG_ENTITY_IND }
  , { 'ALBERT', '', '', 'CULTON', '', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'A', '', '', 'CAIRO', '507 MYRTLE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THIESSE', '1675 STELLER CT', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'KEN', '', '', 'MAYO', '247 FULTON RUN RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1901 6TH AVE N', '', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RYAN', '1305 W ENOS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FEREDOM ABSTRACT CORP', '105  MAXESS RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GAP', '', 'SAN FRANCISCO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KELONE', '', 'PEORIA', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JAMES BUCCI', '2  RIVERSIDE DR    STE 502', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SCHLICHT', '20921  LAHSER RD', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEARS', '', 'PONTIAC', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'M', '', '', 'BRONERSKY', 'MAIN ST 2ND FLOOR', 'LOUISVILLE', 'KY', '40212', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JOHN BILLION', '7769  ISLAND DR', 'MIRAMAR', 'FL', '33023', '', Constants.TAG_ENTITY_IND }
  , { 'RANDY', '', '', 'MYERS', '', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'JEVAN', '', '', 'JOHNSON', 'KAITE TODD DR', '', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1901 BRICKELL AVE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ARIAS SPA', 'PEACHTREE RD', 'ATLANTA', 'GA', '30324', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GREGORY M. CHAIT', '1201 W PEACHTREE ST NE', 'ATLANTA', 'GA', '30307', '', Constants.TAG_ENTITY_IND }
  , { 'DIANE', '', '', 'OCONNOR', '1050 OAK CREEK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ALICE', '', '', 'JONES', '', 'SACRAMENTO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'SHARON', '', '', 'SWEENEY', '', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'GERI', '', '', 'ERICKSON', '551 XIMINES LANE N', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'LIZ', '', '', 'MEYERS', '', 'LUBBOCK', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '408 NE 6 ST', '', 'FL', '33304', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WHITTIER', 'N 56TH WAY', 'SCOTTSDALE', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5900 NW 46 TERR', '', 'FL', '33319', '', Constants.TAG_ENTITY_IND }
  , { 'B', '', '', 'MOORE', '', 'BOSTON', 'MA', '2215', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WA YAN IRENE  KWOK', 'WEST     APT 2714', 'CHICAGO', '', 'IL', '', Constants.TAG_ENTITY_IND }
  , { 'ELLEN', '', '', 'FOSTER', 'PO BOX 2835', 'BIRCH RUN', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DELL', '', 'OKLAHOMA CITY', 'OK', '62', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MACHULIS', '147 CRAWFORD RD', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRAYLOR', '98 ST ANDREWS DR', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SUNG BOOTH', '3RD ST', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '33 S 6TH ST', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CINTAS', '', 'SPARKS', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GADDIS', '', 'FAIRFIELD', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROSS', 'KIETZKE LN', 'RENO', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3914 MURPHY CANYON RD', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DYNAMIC SIGHTS AND SOUNDS', 'PECAN LN', 'SALISBURY', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'F & J SERVICE CENTER', '', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { 'DOROTHY', '', '', 'WALTER', '', '', 'PA', '16662', '', Constants.TAG_ENTITY_IND }
  , { 'CHARLES', '', '', 'HOFFMAN', '3250 S LEHIGH GORGE DR', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PARSONS', '', 'RENO', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2301 VANDERBILT PL', 'NASHVILLE', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { 'HENRY', '', '', 'SCHEIN', '27468  WORLD CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'G', '201 MAPLEBROOK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'THEODORE', '', '', 'VAZQUEZ', '4522 HOFFNER RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'C', '', '', 'COOK', '851 TIP TOP RD', '', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RMCI', '', 'ALBUQUERQUE', 'NM', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAMES', '', '', 'BROWN', '327 RAYBROOK ROAD', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BARNICLE', '908 CANONERO DR', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AQUATIC CENTER', '1287', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'VERIZON', '035 SEARCH RING', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'SEAN', '', '', 'HIGGINS', 'FAIRVIEW', 'SWARTHMORE', 'PA', '19081', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'STATE RD', 'KULPTOWN', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CARPENTER', '275 RIVERCREST DR', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STOTT', 'MAIN ST', 'UNION CENTER', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { 'MEG', '', '', 'LINDBERG', '3RD ST', '', 'CO', '80440', '', Constants.TAG_ENTITY_IND }
  , { 'GAIL', '', '', 'TYLER', '289 FLOWER COURT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3 LONG WHARF', 'NEW HAVEN', 'CT', '', '', Constants.TAG_ENTITY_IND }
  , { 'KELLY', '', '', 'PIERCE', '', '', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { 'KIM', '', '', 'HO', '2ND ST', '', 'LA', '7420', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DR. WEINER', '', 'MERRICK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KNIGHT', '', '', '', '25414', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JAMES', '', 'DOUGLASVILLE', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HESS CORP', '', 'TAMPA', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'LINDA', '', '', 'PHEE', '58  WITCHTOWN RD    APT 503', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'RODGERS', '', 'DUBLIN', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOE', '55  BLACKBERRY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'VAUGHN', '815 BRIDA WREATH', '', 'MD', '21208', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '8529 CANDLEWOOD DR', 'OKLAHOMA CITY', 'OK', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FRYDA CASTILLO', '530  ARLINGTON PL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LIVINGSTON FAMILY CARE CENTER', '1ST', 'FAIRBURY', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'SAM', '', '', 'RYBURN', '338 SHARON AMITY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CITI TREND', 'LINCOLN HWY', 'MATTESON', 'IL', '60443', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WALTER ELIAS', '4585 N SYCAMORE', 'LOS ANGELES', 'CA', '90065', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'POPA', '', 'LAS VEGAS', 'NV', '89139', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1078 MALLARD', 'PEOTONE', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MINGLEDORFFS', '5165 KENNEDY RD', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'PETER', '', '', 'MASON', 'E 8TH AVE', 'BIRDSBORO', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'PETER', '', '', 'MASON', '4220 E 8TH AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAN', '', '', 'DEIS', '5650 NW 56TH PL', 'OCALA', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ARMSTRONG', '7245 GREEN MEADOWS', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHRISTOPHER', '', '', 'GEHM', '3 BAY WILLOW CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LIU', '', 'MALDEN', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CURRIE', '477 EMORY OAKS DR', 'BRYAN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'US BUREAU OF CUSTOMS AND BORDE', '', 'MIAMI', 'FL', '33122', '', Constants.TAG_ENTITY_IND }
  , { 'BRADLEY', '', '', 'YOUNG', '', 'NEWBURY', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'SHARON', '', '', 'JOHNSON', '9975 GARSONS WAY NW', '', 'WA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '4550 POST OAK PLACE', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WAYNE CENTER', '30  WEST AVE', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MCDONALD', '', '', 'MI', '48346', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'LONDON WAY', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EVERGREEN COMMONS', 'STATE', 'HOLLAND', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CAPRI POOLS', '1287 GAR DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JANET', '', '', 'MCFARLANE', '3RD', 'SYKESVILLE', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '9000 SHERIDAN ST', 'HOLLYWOOD', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHRIS', '', '', 'NELSON', '809 W PENNSYLVANNIA AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'XEROX CORP', '', 'LONG BEACH', 'CA', '90745', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RATNER', '4308 MORNINGSIDE', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ZINTERHOFER', '165 MAIN ST', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'UNITED STATES', 'HWY 16', 'MARION', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '900 W. GROVE PKWY', '', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SPAGNOLIA', '10 POINT RICH', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NAVARRO', '3529  INDIAN CREEK WAY     B', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NAVARRO', '3529  INDIAN CREEK WAY     B', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RANDALL CLEARY', '4550 POST OAK PLACE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SIMMONS', 'N 10TH', 'KILLEEN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MASTERFOODS', '3186  CANYON RD     H0AF472N', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MELODY', '', '', 'LEIGHANN', '', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DANNY', '3776 GENELEVA', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STRONG', 'LAKEVIEW DR', 'HANOVERTON', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ARMSTRONG', '7035 LAKEVIEW DR', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { 'STEPHEN', '', '', 'TYREE', '532  NORTH AVE W', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JONATHAN', '', '', 'TORRES', '304 AVE H APT A', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TWC', '', 'COSTA MESA', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ST MARKS CHURCH', 'MULBERRY', 'BELLAIRE', 'TX', '77401', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '4041 ESSEN', 'BATON ROUGE', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MOORE', '', '', '', '63028', '', Constants.TAG_ENTITY_IND }
  , { 'RONALD', '', '', 'HERRING', '11920 NORTH HILL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WACHOVIA BANK', '1525 W WT HARRIS BLVD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2601 S OLIVE', 'PINE BLUFF', 'AR', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'OWENS', 'HILL RD', 'ONEIDA', 'NY', '13421', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WHITNEY HOLLADAY', 'COUNTY ROAD 17', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LANS', '', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SHADE', '7013 EBONY CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '112 N MAIN ST', '', 'IA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'M', '4206 N GENSEN DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'USPS', '153 MAIN STREET', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARLENE', '', '', 'REALI', '615 E RIVER RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'INFINEX INVESTMENTS', 'MAIN', 'FREDERICK', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '709', 'ALBANY', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { 'BRIAN', '', '', 'JONES', '205 BLUEBIRD', '', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { 'J', '', '', 'HOLLIDAY', '7025 FRANDALL AVE', '', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HOOKER', '311 GOODLAND', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1401 PEACHTREE ST', 'ATL', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3 WASHINGTON CIRCLE', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KRAFT FOODS', '250 NECK ROAD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BERNARD', '', '', 'PORTER', '361 JONES AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '350 HUDSON ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'J D K', 'ELK TRAIL', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARTHA MORSE', '915  WAVERLY RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'M', 'JUDICIARY SQ', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '11301 WILSHIRE', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LIDO', '', 'DALLAS', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'TREVA', '', '', 'BROWN', 'BLANCHE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BUIKEMA', 'STATE', 'HOLLAND', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'EVERGREEN LN', 'PALM CITY', 'FL', '34990', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRENT', '32288 PLEASENT RIDGE', '', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KOALA T CARE LEARNING CENTER', '', 'LIBERTY', 'MO', '64068', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'C A BEAN', '', '', 'MD', '20659', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HD SUPPLY', '', 'RIVERSIDE', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '101 WASHINGTON AVE S', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'SUZANNE', '', '', 'GIESZER', '', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HARTMAN', 'JEFFERSON ST', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { 'TOM', '', '', 'EVANS', '102 BELCHER ST', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'SCHMIDT', '1819  ALLIGATOR ST', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2900 UNIVERSITY SQ', 'TARPON SPRINGS', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STROUHALS TIRE', '', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'ERIC', '', '', 'SUTTON', '14744 TWIN BAYS RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ADAM', '', '', 'SZUBIN', '1300 PENNSYLVANIA AVE NW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1 MAIN ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'T MOBILE', '', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CITITREND', 'LINCOLN HWY', 'MATTESON', 'IL', '60443', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BAILEY', '13630 CYNTHIANA', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SPINA & ADAMS COLLISION', '1161 OAKS RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARSHALL', '658 POWERS FERRY', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5TH ST SE', 'CAIRO', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3322 W END AVE', 'NASHVILLE', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1320 MAIN ST', 'COLUMBIA', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BEAR', '2518 BROWN MILL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HOMETOWN HEALTH CARE', '1681  WOODBRIDGE PARK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LIGHTING SUZUKI', '14523 N FLORIDA', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'R A SHORT CO', '', 'MATTHEWS', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DRIVE MEDICAL DESIGN', '250 KENNEDY DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BROWN', '3810 GWYNN OAK AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2570 LINCOLN BLVD', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'XIONG', '', '', '', '54476', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PRIVETTE', 'SPRING HARVEST', '', 'NC', '28110', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STAPLES', '45 CEDAR LANE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '7570 NW 14 ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WOODWARD GOVERNOR', '', 'LOVELAND', 'CO', '80538', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '2 BROTHERS', 'W MONROE ST', '', 'IN', '46733', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1050 E CACUS', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'REED', '262 ELM ST', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '600 13TH ST', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PEP BOYS', 'WASHINGTON RD', 'AUGUSTA', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ISD AND SOLUTION', 'MUSTANG', 'ALVIN', 'TX', '77511', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GARNER METAL', 'S MAIN ST', 'MONROE', 'OH', '45050', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IRS', '8101 TOM MARTIN DR ROOM 151', 'BIRMINGHAM', 'AL', '35211', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BARBER', 'BELL ROAD', 'BIRMINGHAM', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRIMMEL IRISH PHILLIPS', '500 LOCUST HILL AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HARRISON MONTGOMERY', '502 WINNACUNNET RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MEYER', '', '', '', '60615', '', Constants.TAG_ENTITY_IND }
  , { 'JESSICA', '', '', 'RICHART', '2423 ELLIS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SULLIVAN', '', '', '', '64056', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'PALMER', 'CHERRY', '', 'CT', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DR DANDELION', '8  GARRISON ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GONZALEZ', '', 'ROGERS', 'AR', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'OLIVER', 'EAST RD', '', 'MA', '1266', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AVENUE', '33850 GRATIOT', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '303 E 60TH ST&apos;', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DS WATERS', '5331 NW 35TH TER', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '79 S MAIN ST', 'WILKES BARRE', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JORGE', '', '', 'PIZA', 'MARKEY', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NYSDC', '101 MAIN ST', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'RR 4 BOX 112', '', 'TX', '78577', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'ERIC', '', 'MILES', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'KATARINA', '', '', 'ELDER', 'POBOX 2336', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DELAWARE PARK', 'LINCOLN PKWY', 'BUFFALO', 'NY', '14201', '', Constants.TAG_ENTITY_IND }
  , { 'LIZ', '', '', 'YOUNG', '15TH ST', 'KENOSHA', 'WI', '53144', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '401 CONGRESS AVENUE', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HARRISON MONTGOMERY', '502  WINNACUNNET RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LINDA', '', '', 'WILSON', '185 ROLLING ACRES RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'VOGEL', 'N6W31449', 'WAUKESHA', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '351 E 4TH ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOLLAR GENERAL', '', 'SYLACAUGA', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WRIGHT', '2141 COLLETTE LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1501 NW 10 AVE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '16830 KINGBURG', 'GRANADA HILLS', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RSENTHAL', '101 WISCONSIN AVE', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MIKE WOODHAMS', 'ROBERTS', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TYLER', '289 FLOWER COURT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EDWARD BENNETT WILLIAMS', '', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '80 BROAD ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LOWES', 'JEFFERSON PK', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { 'BOB', '', '', 'BAKER', '4665 PARKHILL', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'CEDAR CREEK DR', '', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { 'DAVID', '', '', 'WILSON', 'VALLEY RD', 'EUSTIS', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PAYNE', '2119 RIVER ROCK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHELLE', '', '', 'FINK', '1365 STATE ROUTE 66', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GREEN', '2530 TUSCARAWAS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FRANCISE TAX BOARD', 'SHERMAN WAY', 'VAN NUYS', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '630 N 9TH', 'CARLISLE', 'IA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5301 BLUE LAGOON DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2100 M ST', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SHAEDING', '', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DEBORAH MCCORMICK', '', 'HUNTINGTON BEACH', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NG', '', 'WOODSIDE', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'NICK', '', '', 'WOLFORD', '6TH ST', 'DOVER', 'NH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1000 E 41ST', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SNYDER', '800 HARBOR LAKES DR. APT.#108', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JEFFREY JOHNSON', '5611  119TH AVE SE   STE 5', 'BELLEVUE', 'WA', '980063799', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SPEARMAN', '5001 N CONGRESS  AVE', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EYEMASTER', '6002  SLIDE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'T MOBILE USA   9868', 'STE 417', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'OWENS', '505 HILL RD', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A', '1267 S RICHLAND', '', 'IN', '46221', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'U S BORAX', '14486  BORAX RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DAVIS', 'RT 257', 'SENECA', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1731 NW 47TH AVE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '502 N MAIN', 'WEATHERFORD', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DHEMECOURT', '714 REEDS REEF', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TODD', '', '', '', '97527', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'POSITROL', 'VIRGINIA', 'CINCINNATI', 'OH', '45227', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'OROZCO', '908 DEVONSHIRE', 'FULLERTON', 'CA', '92831', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'C A SHORT CO', '', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WILLIAMSON HIGH SCHOOL', '1567 E DUBLIN ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THE PADDY WAGON', '18940 E 12TH ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LEE', '', '', 'MILLER', '55 SOUTH FAYETTE ST', '', 'PA', '19612', '', Constants.TAG_ENTITY_IND }
  , { 'RICHARD', '', '', 'ELLIS', '', 'VISALIA', 'CA', '93291', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BRW AND ASSOCIATES', 'FM 78', 'SAN ANTONIO', 'TX', '78244', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ST LAWRENCE UNIVERSITY', '23  ROMODA DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NORTHWAY', '', 'TOPEKA', 'KS', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KCC', '', 'TOPEKA', 'KS', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STAPLES', '45 CEDAR LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHRIS', '', '', 'CARLSON', '44450 FOX HOLLOW', 'EUGENE', 'OR', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MICHE  BAG', '1381  COUNTY RD', 'MINEOLA', 'TX', '75773', '', Constants.TAG_ENTITY_IND }
  , { 'DANIEL', '', '', 'WRIGHT', 'MIRRAMAC', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HACH', '', 'LOVELAND', 'CO', '', '', Constants.TAG_ENTITY_IND }
  , { 'CAMERON', '', '', 'TAYLOR', '6394 BERCHVIEW DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '120 CENTRAL PARK S', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5022 W AVE N', 'PALMDALE', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SARA HOWELL', '5207 DEERFIELD CREEK PLACE', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RYDER', '249  OLD ST LOUIS RD', 'FORT WORTH', 'TX', '76115', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'REITZ MEMORIAL HIGH SCHOOL', '1500  LINCOLN AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'HANNAH', '', '', 'VANHISE', '6112 42ND STREET', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BRADLEY', '', '', 'JOHNSON', '5738 SUMMERSTON', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DAVIS', '', '', 'WI', '53158', '', Constants.TAG_ENTITY_IND }
  , { 'MARCIA', '', '', 'LEACH', '34250 N 60TH ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STRATEGIC EQUITY FUNDING', 'S LAKE AVE', 'PASADENA', 'CA', '91101', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARK', '200 W 58TH ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'N BROAD ST', 'EUFAULA', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { 'RON', '', '', 'JOHNSON', '11400 MICHAEL', '', 'OK', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'OHP', '', 'MUSKOGEE', 'OK', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARIA', '', '', 'RIVERIA', '3340 RESIVOR RD NW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEARS', '', '', 'OH', '44221', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TF ENTERPRISE', '3218 GAINES BASIN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5225 KATY FWY', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1025 CONNECTICUT AVE', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LAIL', '2603 ICARD RIDGE', 'STATESVILLE', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GREEN', '317 CENTRAL AVE', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'INNES', 'BRIAN&apos;S VIEW', '', 'NH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'US POST OFFICE', '225 MICHIGAN', 'GRAND RAPIDS', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1530 S OLIVE', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FSD AND SOLUTION', 'MUSTANG', 'ALVIN', 'TX', '77511', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RUIZ NIDIA AMPARO', '1900 NW 21ST     STE 220', 'MIAMI', 'FL', '33172', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'C A A F', '', 'LOS ANGELES', 'CA', '90045', '', Constants.TAG_ENTITY_IND }
  , { 'JOON', '', '', 'LEE', '', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'PAMELA', '', '', 'WOLF', '805  LIBERTY CREEK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BREILNIGER', '212 DICKERSON HOLLOW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ELIZABETH', '', '', 'BARTON', 'PINE', 'VERONA', 'KY', '41092', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5541 S EVERETT AVE', 'CHICAGO', '', '60634', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RUELAS', '414 HIGH ST', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LEWIS TREE SERVICE INC', '1303 NW 15TH AVE', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'T MOBILE', '', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'T MOBILE', '', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1215 5TH AVENUE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IBM', '150 KETTLETON', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '9333 PARK BLVD', 'SEMINOLE', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TETRA POINT FUELS', '1301 MAYHILL', 'DENTON', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'BRIAN', '', '', 'JONES', 'BLUEBIRD', '', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '133 SE 17TH ST', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '9970 SW 88 ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A&B MCKEON GLASS & MIRROR', '69  ROLF ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3030 N 3RD ST', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WOLFE CENTER', '13TH', 'MERCED', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FLUIDICS INC.', '7-  GARFIELD RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'EVANS', '48600 FAIRWAY LN #112', 'CHISAGO CITY', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'SHAW', '2216 CASMORE', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WINTERS', '', '', '', '33629', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'F', '230 PEASE RD', '', 'ME', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BABLITZ', '438 MORRISSVILLE RD APT 3D', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'STEVE', '', '', 'JONES', '738 ARBOR CIRCLE DR', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SERURE', '327 MIDDLE COUNTRY', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'JESUS', '', '', 'ROJAS', '11 RETOSE', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ADAMS', '878  COLD SPRINGS RD', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '10100 INTERNATIONAL', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HENRY FORD W BLOOMFIELD HOSPI', 'WEST MAPLE RD', 'WEST BLOOMFIELD', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'DAVID', '', '', 'HERMANN', '33 SUNSET DR', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '555 NEW JERSEY AVE NW', 'WASHINGTON', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '301 N HARRISON', 'PRINCETON', 'NJ', '8540', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PARAG', '', '', '', '32901', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROSS', '', 'RENO', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { 'THOMAS', '', '', 'MURPHY', '24307 RIPPLLING CREEK WAY', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1945 ALLEN PKWY', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MCLAUGHLIN', '191 UNITY RD', '', 'ME', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ADDIAS', '', 'SPARTANBURG', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { 'DIANE', '', '', 'OCONNOR', '1050  OAK CREEK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GRIFFIN', '', '', '', '70815', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'KATHIE', '', '', 'MCCAULEY', '4140 N 34TH ST', '', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { 'LINDA', '', '', 'DREWS', '2605 COLLEGE COURT', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DEVINE', '143 WESTMINISTER', '', 'RI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BED BATH & BEYOND #0279', '2838 N BROADWAY     STE 1', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EDWARD JONES', '429 E MICHIGAN AVE', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'C', '', '', 'JEWELL', '10213 JONAMAC AVE', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHRISTY', '', '', 'PERRINE', '', '', 'WV', '', '', Constants.TAG_ENTITY_IND }
  , { 'TOM', '', '', 'SPENCE', '71011  STUDABACK AVE    STE 318', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WITTER', '3232 ROSE BUD DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SMITH BARNEY', '', 'BROOKLYN', 'NY', '112350000', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', 'H', '', 'RICHARDS', 'COBY DR', '', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SALONTECH', '58  SEAVIEW BLVD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CHARLOTTE', 'EAGLE BEND', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RUSSELL', '2040 DEYERLE AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEGWICK CMS', '33 S 6TH ST', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GOUDY CONSTRUCTION CO', '10777 MAIN', 'SEATTLE', 'WA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ADI', '3060 PRAIRIE VALLEY CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HEBISEN', '5531 NW 29TH CT', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'CONNIE', '', '', 'TAYLOR', '', 'YUCAIAP', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'GREEN COVE RD', 'HUNTSVILLE', 'AL', '35803', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RAMIREZ', 'W GROVE ST', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GENE FREEMAN', '2616  RIDGEVILLE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALLGOOD', '1624 LAS PALMAS DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1285 6TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '740 MACON ST', 'WARNER ROBINS', 'GA', '31098', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'WILSON', '3069 JOHNSTOWN RD', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'SOUTH MAIN ST', 'PALMER', 'MA', '1069', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '409 LAKE VISTA', 'COCKEYSVILLE', 'MD', '21030', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KENNARD', '117 N MAIN ST', '', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { 'ED', '', '', 'KOESTER', 'WASHINGTON', 'CEDARBURG', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GARMERS', '12 27TH AVE NE', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BAREFOOT GENERAL STORE', '4708 HWY 17 S', '', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { 'KRISTEN', '', '', 'GLASSCOCK', 'GRANT', '', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CENTENE CORP', '', 'ST LOUIS', 'MO', '63105', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'G_L OUTDOOR POWER EQUIPMENT', '', 'VERMILION', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HERNANDO COUNTY CLERK OF COURT', 'JEFFERSON', 'BROOKSVILLE', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RUSSELL', '', '', '', '27604', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JUST 2 TEASE', '835 NE GREEN OAKS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MACKENZIE', '', 'SAINT CLAIR SHORES', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'BEN', '', '', 'WILLS', '2030 LONDON AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'S', '', '', 'GIFFORD', '25 MAIN ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WOLFF SHOE COMPANY', '1705  LARKIN WILLIAMS RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LEAR CORP', '850 INDUSTRIAL CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN REED', '', '', 'RAYHER', '490  POST ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARCIA', '', '', 'LEACH', '34250 N 60TH ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'MILES', '', 'MCREA', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1770 E BUENA VISTA', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'SEAN', '', '', 'HIGGINS', 'FAIRVIEW ROAD', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EDWARD JONES', '', 'CHARLOTTE', 'NC', '28226', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LARSON', '16630 N 7TH ST', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'DEAN', '', '', 'GRAHAM', 'GRANT', 'MILWAUKEE', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '555 JOHN MUIR', 'SAN FRANCISCO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'SHAW', '2216 CASMORE', '', 'VA', '24523', '', Constants.TAG_ENTITY_IND }
  , { 'PAUL', '', '', 'ANDERSON', 'MAPLE DR S', 'CAMBRIDGE', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '4954 FIELD ST', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'PAT', '', '', 'RUOSS', 'CONOCOHEAGUE RD', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1524 W BRADLEY', 'PEORIA', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '809 W UNION ST', 'MORGANTON', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TUCKER', '941 BUCKHORN', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRIAD', '', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'COSLO MANUFACTURING', 'SPRING GROVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JERRY', '', '', 'JOHNSON', '2097', 'CHARLESTON', 'SC', '29414', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'POYOTTE', '', 'GREENBELT', 'MD', '20770', '', Constants.TAG_ENTITY_IND }
  , { 'ROGER', '', '', 'ROSE', '', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '12506 LAKE UNDERHILL', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '200 N BAYSHORE DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'PETER', '', '', 'LEWIS', '901 MAIN ST', 'BUNOLA', 'PA', '15020', '', Constants.TAG_ENTITY_IND }
  , { 'AUDREY', '', '', 'CREWELL', '24031 BARNET', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '4848 N CENTRAL', 'CHICAGO', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEPTIC TANK SYSTEMS', '12TH', '', 'MI', '49408', '', Constants.TAG_ENTITY_IND }
  , { 'MIKE', '', '', 'KIRSCHNER', '8918 KENNETH CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KELLYS', 'PUTNAM ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '7825 FAY AVE STE 200', 'LA JOLLA', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BEARS GRAPHIC & SCREENING', '7307  GEORGE WASHINGTON MEM HWY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JENNIFER', '', '', 'MURRAY', '4115 PINCAY OAKS LANE', '', 'CT', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARY', '', '', 'LAKE', '23660 PRESCOTT', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3 WASHINGTON CIR', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { 'NOREEN', '', '', 'MILES', '5970 N COUNTY RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BATHERS', '1118 E MAIN ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ALAN', '', '', 'STOCK', '1631 ELMHURST RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5399 PLAYA VISTA', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARLIN', '1010 E ST CLAIR ST', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THOMAS LEE', '1610  KELLOGG DR', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '. NICOLE HAWKINS', '11052  SANTE FE ST N', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAY', '', '', 'HARDEE', '342 LOGANVILLE HWY', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GBX', 'PO BOX 936174', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARGARET', '', '', 'BECKER', '52ND AVE N', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'ELI', '', '', 'BORNTRAGER', '3043  205TH', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'CURRY', '226 BROGILEAU AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BADGER', 'WOODLANDS ACRES', '', 'ME', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BORDERS BOOKS', '1937  MACARTHUR RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TO A TEE', '7125 GIRLS SCHOOL AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'M TRACK MCKENNA SCHOOL', 'SPRUCE ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AMERICAN', '6223  HIGWAY 90', 'MILTON', 'FL', '32170', '', Constants.TAG_ENTITY_IND }
  , { 'CONSTANCE', '', '', 'LEITNER', 'DOUGLAS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MONICA', '', '', 'FLORES', '13200 NORTH', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'NOELLA', '', '', 'YOUNG', '', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'JASON', '', '', 'WRIGHT', 'JEFFERSON ST', 'BANCROFT', 'WV', '25011', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SANDRA CLARK', 'JACKSON ST', 'SAN JOSE', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'STEPHAN', '', '', 'JOHNSON', '', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'STROMINGER', 'LEXINGTON', '', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STOP & SHOP', 'BALLTOWN RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'DORIS', '', '', 'PRINDLE', '398 PRICHARD ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PARADIES', '', '', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'WILCOX', '350 NORTH HACIENDA BLVD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HIPPIE CHICK', '6002 SLIDE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BURY', 'BROADWAY', '', 'NY', '12865', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GORDON', '', '', 'NY', '11937', '', Constants.TAG_ENTITY_IND }
  , { 'LOUIS', '', '', 'HUGHES', 'PO BOX 393', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HMX', '', '', 'IL', '60611', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IRS', '', 'WATERLOO', 'IA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'INN', 'MAIN ST', 'SALADO', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JULIE QUIJANO', 'PO BOX 26665', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SMITH', '', 'E FREETOWN', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CLARK', 'BAYVIEW AVE', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SAUCIER', '1551 COPICUT RD', '', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BRACY', 'TREESONG RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARSIA', '', '', 'HILL', '', '', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1239 BROADWAY', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'CAROL', '', '', 'SMITH', '105 WEST ST', '', 'DE', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'HARRIS', '', 'WASHINGTON', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { 'WILLIAM', '', '', 'COOK', '230 BOWMANS BOTTOM', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'DENA', '', '', 'LORD', '333 W PERSHING RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'TODD', '', '', 'HORTON', '52ND', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'SCOTT', '', '', 'BENSON', 'KIVA', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KOHLS', '', '44512', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HOMETOWN HEALTH CARE', '1681 WOODBRIDGE PARK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GLOBAL BOATING US', '437  J ST    STE 202', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARK', '', '', 'RESMESSEN', '4TH ST', 'WEST DES MOINES', 'IA', '50265', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'C', '6914 CLYATT STONE RD', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'BILL', '', '', 'CATTS', '15 SOUTH MILLER', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'PAUL', '', '', 'WHITE', '63392 E OAK LANE', '', 'OK', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAMES', '', '', 'JOHNSON', '', 'BIRMINGHAM', 'AL', '35209', '', Constants.TAG_ENTITY_IND }
  , { 'STEPHANIE', '', '', 'EVANS', '14408 PIPER GLEN', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '320 W STATE ROUTE 14', '', 'OH', '44408', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1190 NW 95TH ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GEORGIANNA HUNTER', 'E 42ND ST', 'BROOKLYN', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'YU', '', '', 'HAO', 'SOLANO PARK CIR    APT 4324', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARIE', '', '', 'ROSE', '321 DANIEL DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BETTY', '', '', 'PHILLIPS', 'CHERRY FORK RD', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RICELAND', '918 NEW MADRID', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'PAUL', '', '', 'ZIMMERMAN', 'MAIN ST', 'BELLEVILLE', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { 'RUSSELL', '', '', 'SEARS', '11 CONCORD COMMONS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ANDRUS', '3753', 'LANCASTER', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JACKSON', '606 RUTH ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'DAVID', '', '', 'COX', '4624 WEAKLY HOLLOW RD', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '555 BROADWAY', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'POWELL', '2604 THOMSON TOWN RD', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SMITH', '', 'TOBYHANNA', 'PA', '11692', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THOMPSON CONTRACTING', '101  PETFINDER LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5757 W CENTURY BLVD', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'WILLIAM', '', '', 'BENNETT', '46 VINE ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LANG', '8119 TOWNLEY ROAD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '920 N 28TH ST', 'MILWAUKEE', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'L', '2557 WALNUT PIKE DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WILLIAM ANDERSON', 'WINDSOR GREEN', '', 'SC', '29579', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IRS', '1000 SOUTH PINE ISLAND RD', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PURVEY', '1ST', 'GAINESVILLE', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'XM SONIC THEATER', '', 'WASHINGTON', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { 'AUDREY', '', '', 'CREWELL', 'W BARNET', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ANGELA', '', '', 'PERRY', 'KING ARTHUR COURT', 'INDIANAPOLIS', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1101 JUNIPER ST', 'ATLANTA', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KMART', 'PROSPECT AVE', 'WEST ORANGE', 'NJ', '7052', '', Constants.TAG_ENTITY_IND }
  , { 'DANNY', '', '', 'MAYES', 'UPPER OAKWOOD', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1401 AVOCADO AVE', 'REDLANDS', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'SARA', '', '', 'HINCKLEY', '38600  ZIP INDUSTRIAL BLVD     B', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JASON', '', '', 'COLLINS', '921 VIEWMONT DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOE', '', '', 'DUNN', '113 OMER ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARTIN', '', '', 'FAIRFAX', 'BROADWAY', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HELEN SUMMERS', '1300  PARK WEST BLVD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JENNIFER', '', '', 'JONES', '712 CEDAR CT', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1215 5TH AVENUE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LUDWIG', '', '', '', '53081', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '20700 AVALON', 'CARSON', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SAC', '', 'CORPUS CHRISTI', 'TX', '78416', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WALONICK', '1200 1ST ST', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHELLE', '', '', 'PAINTER', '24081 S MOUNTAIN HOUSE', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'THERESA', '', '', 'BETIL', 'HIGHLAND', 'SOMERVILLE', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BIRDS EYE AUTO', 'N WALNUT AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROTH', '703 THOMPSON FALLS', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '208 E 51ST ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'APPERSON', '16838 ROYAL CREST DR', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AT&T', '75  MIDDLESEX TPKE    STE 1050A', '', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROCK', '743 WOODFORD WAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NEW BALTIMORE REFORMED CHURCH', 'WASHINGTON AVE', 'NEW BALTIMORE', 'NY', '12124', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'US POST OFFICE', '225  MICHIGAN', 'GRAND RAPIDS', 'MI', '49503', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOL', '1947 507TH', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAMES', '', '', 'GRIFFIN', '3709  PICKFORD AVE', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WALGREEN', '', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'BROWER', '', '', 'MCKENZIE', 'OAK BRIDGE', 'HERNANDO', 'MS', '', '', Constants.TAG_ENTITY_IND }
  , { 'PAM', '', '', 'WOLF', '805 LIBERTY CREEK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HAIR BY DAMIAN', '5713 CENTRE AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ARBYS', '165 STEPHENS WAY', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BERROLA', 'PONTIAC AVE', '', 'RI', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICKEY', '', '', 'SMITH', '1056 EMILY RD', '', 'CT', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CAO', '', 'RICHARDSON', 'TX', '75080', '', Constants.TAG_ENTITY_IND }
  , { 'J', '', '', 'ONEIL', 'HILLENGLADE', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'T MOBILE', 'STE 417', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A', 'RICHLAND', '', 'IN', '46221', '', Constants.TAG_ENTITY_IND }
  , { 'POLLY', '', '', 'GREEN', '2530 TUSCARAWAS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'TOM', '', '', 'BERG', '2902', '', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { 'BARRY', '', '', 'HIRST', '14403 SPRING MOUNTAIN DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHARLOTTE', '', '', 'SMITH', '8605 SCENIC HOLLOW', '', 'MS', '', '', Constants.TAG_ENTITY_IND }
  , { 'L', '', '', 'TADD', '613 BELLAIRE DRIVE', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WAYNE WRIGHT LLP', '10801 GATEWAY W', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ELIZABETH', '', '', 'BURKE', '', 'AUSTIN', 'TX', '78705', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FULON', '5045 STATE ROUTE 73', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SENCO', '', 'CINCINNATI', 'OH', '45244', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROCOURT', '', '', '', '33176', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LAIL', '2603 ICARD RIDGE', 'TAYLORSVILLE', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'DATHAN', '', '', 'JONES', '1 COMMUNITY PL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRACY', '322 CLEVELAND ROAD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'PINE ST', 'RENSSELAER', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'JESSICA', '', '', 'REYNA', '501 E SAM HOUSTON', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BROMBERG', '2000 TOWERSIDE TER', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'INSTRUMENTATION', '8502 112TH AVE NW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MCPHILLIPS', '351 BREAKER ST', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DEVOS & CO', '', '', 'NJ', '7901', '', Constants.TAG_ENTITY_IND }
  , { 'MARCIA', '', '', 'LEACH', '34250 N 60TH', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MD ANDERSON CANCER CENTER', '', 'BASTROP', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'MIKE', '', '', 'SCIULLO', '', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARY OWENS', '25670 N SHORE PL', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { 'BECKY', '', '', 'SMITH', '', 'WAMSUTTER', 'WY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '140 BAY STREET', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DELLY', '', '', '', '48302', '', Constants.TAG_ENTITY_IND }
  , { 'CHRIS', '', '', 'NELSON', '809 W PENNSYLVANNIA AVE', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'PATRICK', '', '', 'FELDPAUSH', 'GRAND RIVER', 'EAGEL', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '590 MALABAR', 'PALM BAY', 'FL', '32909', '', Constants.TAG_ENTITY_IND }
  , { 'MARIA', '', '', 'HILL', '15TH ST', '', 'DC', '20005', '', Constants.TAG_ENTITY_IND }
  , { 'BARBARA', '', '', 'HUGHES', 'HAMPTON', 'GARDNERVILLE', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FRENCH', 'MEADOWBROOK', 'MARTIN', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SGT CRISTIAN CRUZ', '14555  SCHOOL ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'K O N E', '', 'NEWARK', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DEBEVOISE AND PLIMPTON', '919  3RD AVE', 'NEW YORK', 'NY', '10016', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STATIC TECH', '138 WEYMOUTH ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'RONNIE', '', '', 'MULLINS', '27468  WORLD CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'DESIREE', '', '', 'ROGERS', '3303 W CREST ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '510 HIGHLAND AVE', '', '', '48381', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BELL', '3002  PIONER WAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NELSON', '905 BEACON HIL RD', 'NORFOLK', 'VA', '23502', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'L', '8119 TOWNLEY ROAD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'USPS', '17345 PACIFIC', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JONES', '3600  EVERGREEN', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARIA VARGAS', '8944 S ROBERTS RD', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { 'SUSAN', '', '', 'JOHNSON', '207', 'FAIRFIELD', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BEATTY AND PETERSEN', '107 S 1ST', '', 'IA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MIKE', '', '', 'HANLEY', 'NE 28TH ST', 'VANCOUVER', 'WA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THE ONE BOGY', '8TH', 'LONG BEACH', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AMEIRCAN TIRE', '311 E STATE RTE 176', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'TOM', '', '', 'WILLIAMS', '4900  FROLICH LN', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'SMITH', '280 RECTOR PLACE', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GAMET', '2840 N MILWAUKEE', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEARS', '1140  SHAW AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STOUT', '401 SHORELINE DR #314', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { 'BARBRETTA', '', '', 'REAVES', '115 MACEW LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GENERAL MILLS', '2423 ELLIS ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'L E MYERS CO', 'BRANDY RD', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STEPHANIE TURNER', '202  MARCH PARK BLVD SE    B104', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3000 N CONGRESS AVE', 'BONTON BEACH', 'FL', '33426', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LEIGHANN', 'TREESONG RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '417 5TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FEMA', '', 'BOSTON', 'MA', '2109', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'SHAG BARK TRL', 'GAINESVILLE', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'EAGLE BEND', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BREITZER', 'OTTAWA', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRENDY PHONES', 'LAFAYETTE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ZACHARY', '', '', 'WEEDEN', '2 COLLEGE HILL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RHONEY', '', 'SPARTANBURG', 'SC', '29301', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2300 HOLCOMB BRIDGE RD', 'ROSWELL', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JULIA', '', '', 'MORRIS', 'PINE BLVD', 'NASHVILLE', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KNIGHT', '1039 RED OAK', 'OXFORD', 'AL', '36203', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DEMAIO', '', '', 'FL', '33071', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'DOUGLAS ST', 'BOSTON', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEARS', '', 'LOUISVILLE', 'KY', '40216', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARYLAND FRAUD', '5115 PISTOL RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARCIA', '', '', 'LEACH', '34250 N 60TH', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'A', '', '', 'MARTIN', '111 OBRIAN WAY', 'COLUMBIA', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AAA  AUTO CLUB SOUTH', '601 E ATLANTIC BLVD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'M TRACK MCKENNA SCHOOL', 'SPRUCE ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WORLDUNIMAX LOGISTICS', 'MAIN', 'CARSON', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TOP GRILL', '1176 MCCORMICK AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STOTT', 'MAIN ST', 'ELROY', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '7000 N 16TH ST', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHARLIE', '', '', 'JONES', '125 WAYNE BLACK DR', '', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'SW 112TH ST', '', 'OR', '97062', '', Constants.TAG_ENTITY_IND }
  , { 'THOMAS', '', '', 'JACKSON', '5540 UNIVERSITY POINTE', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '225 6TH ST', 'SANTA MONICA', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAMES', '', '', 'WALSH', '23030  WINDING BROOK WAY', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { 'KRISTINA', '', '', 'GORDAN', '5037 MIRANDA', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THE TOWN BARBER', 'MAIN', 'DAGSBORO', 'DE', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'OTTER CREEK RD', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'OTTER CREEK RD', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { 'SUSAN', '', '', 'WOOD', '8335', '', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FOSTER', '2971 PAR CIR', '', 'FL', '33446', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BURCHILL', '', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BED BATH & BEYOND #0279', '2838 N BROADWAY     STE 1', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5032 FORBES AVE', 'PITTSBURGH', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EYE MASTER', '', 'LUBBOCK', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LINDA', '', '', 'DOZIER', '', 'LUBBOCK', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'JAMES', '', '', 'WILSON', '1901 CREEK RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HOUSING AUTHORITY', '10TH AVE N', '', 'SC', '29577', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RUANE', '', '', '', '80134', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '10790 WILSHIRE', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'MATT', '', '', 'POORE', 'MAGNOLIA', '', 'CA', '94939', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PIZZA HUT', '8757 GRISSOM', 'SAN ANTONIO', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5025 THACHER RD', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'INTERNAL  REVENUE SERVICE', '130 S ELMWOOD AVE    RM 109', 'ANDOVER', 'MA', '18104544', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BLEEKER', '509 WATCHUNG AVE', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALSTON & BIRD', '1201 W PEACHTREE ST NE', 'ATLANTA', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '25TH AVE', 'SAN FRANCISCO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'STEVE', '', '', 'JONES', '738 ARBOR CIRCLE DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LAURA', '', '', 'SERBIN', 'WILSON', '', 'AZ', '85338', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GARNER METAL', 'S MAIN ST', 'MONROE', 'OH', '45050', '', Constants.TAG_ENTITY_IND }
  , { 'SCOTT', '', '', 'GARDNER', 'BROADWAY RD', '', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { 'PAMELA', '', '', 'WOLF', '805 LIBERTY CREEK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A & M GREEN POWER', '', 'RED OAK', 'IA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'B&L', '1400 N GOODMAN ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '12760 HIGH BLUFF DR', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'MAZZEI', '16 W 751 56TH ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GONZALEZ', '', 'ROGERS', 'AR', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'DANIEL ELLIS', 'CHARLESTON', 'SC', '29412', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1010 NORTHERN BLVD  .', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'SETH', '', '', 'WILLIAMS', '', 'MARTINEZ', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'BROKS', '', '', 'WILLIAMS', '', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LW SUPPLY', 'HICKORY FLAT', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GAIL GISCLAIR', 'E MAIN ST', 'GALLIANO', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOLLAR GENERAL', '', 'WARREN', 'OH', '44511', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CAMPBELL', '1037 ELMWOOD DR', '', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '821 MAIN', '', 'TX', '78501', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KEN MAYO', '247  FULTONS RUN RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KNOTEK', 'PO BOX 1122', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARIA', '', '', 'ROSR', '321 DANIAL DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BURLINGTON COAT', 'S WANAMAKET RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'J AND L INDUSTRIAL SUPPLY', 'PACIFIC AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FURNITURE 4 LESS', '124 W. 4TH', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MORTON', '337 CROSBY RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LINDS', '', '', 'DREWS', 'COLLEGE COURT', 'COLLEGE STATION', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DUNN', '113 HOMER ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'FREULER DR', 'AYDEN', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'HARRIS BRANCH', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HOTEL', 'INDIAN SCHOOL RD', '', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CLARK', '22724 BAYVIEW AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LEVINGTON & ASSOC', '1418 BEECH AVE', 'MCALLEN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FISHER AND SAULS', '100 2ND AVE', 'SAINT PETERSBURG', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '8201 S TAMIAMI', 'SARASOTA', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROBINSON', '8631 PREAKNESS', '', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3001 S HANOVER ST', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'UNG', '', 'RIVERSIDE', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1211 CONNECTICUT AVE', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HAWKINS', '5101 SPAUDING', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PROVIDENCE O CHRISTMAS TREES', '4831  35TH AVE SW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GOODWILL', 'PINE', '', 'PA', '16743', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NORRIS', '6909 67TH AVE N', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3771 S MCCLINTOCK', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HISLOP', 'P O BOX 478', 'PORTSMOUTH', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '219 N MAPLE ST', 'ENFIELD', 'CT', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3880  WOODMERE PK BLVD', 'ENGLEWOOD', 'FL', '34293', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BOSTON', '190 DOUGLAS', '', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KEVIN J KIRKPATRICK', '30201  RONDAVO RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CLARK CINDY', 'BAYVIEW AVE', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3900 N CHARLES ST', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3131 E CAMELBACK RD', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WELLS FARGO BANK', '', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STEVENS', 'W. SAINT LAWRENCE', 'BELOIT', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HANCOCK BANK', 'MAIN', 'MADISONVILLE', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DARLING', 'HAYES ST', '', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'SMITH', 'ROUTE 380', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BENITTA ANDERSON', 'LASSEN', '', 'CA', '91325', '', Constants.TAG_ENTITY_IND }
  , { 'DEREK', '', '', '', 'RIDGE RD', 'ELVERSON', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'MAIN', 'WAKESHA', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALSTON & BIRD', '1201 W PEACHTREE ST NE', 'ATLANTA', 'GA', '30307', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MONRO MFFLR', 'PARK AVE W', 'MANSFIELD', 'OH', '44906', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GWU', '', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BARTON', '', 'EVANSVILLE', 'IN', '47711', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'POWELL', '2604 THOMPSON TOWN RD', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'NANCY', '', '', 'RABUL', '15419 GREAT GLEN LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HILL', '132 COMMERICAL', 'BELLEVILLE', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PUROCLEAN   TRENARY', '2419  COUNTRY CLUB ROAD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'ROYAL HARVEST WAY', 'SALT LAKE CITY', 'UT', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DANNY', '3776 GENELEVA', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SAM BURRS', '1078  MALLARD LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'PAUL', '', '', 'GATTO', '', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HERNANDEZ', '', '', '', '33314', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'M R I INC', '', 'SAN ANTONIO', 'TX', '78248', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SAWYERS MOTORCYCLES', '10995 OAK RIDGE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROY', '', '', 'MINAGAWA', '58 WOODSWAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HOME DEPOT', 'RIDGE BLUFF', 'SAN ANTONIO', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '26300 FORD RD', 'DEARBORN HEIGHTS', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '11845 W OLYMPIC', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1111 BRAND', 'GLENDALE', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JASON', '', '', 'COLLINS', '921 VIEWMONT DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TOMPKINS', '', '', 'DC', '20004', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MORGAN STANLEY SMITH BARNEY', '3825  LYNNHAVEN RD    STE 6', 'WALDORF', 'MD', '20604', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BAILEY', '', 'CASTLE ROCK', 'CO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'YAVAPAI TV SERVICE', 'BROADWAY', '', 'AZ', '85362', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THE INN AT SALADO', 'NORTH MAIN ST', 'SALADO', 'TX', '76571', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MERIDIAN INVESTIGATIVE GROUP', 'CENTRAL', 'ST PETE', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'JIMMY', '', '', 'WELBORN', '', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOSH H', '', '', 'JACOBS', '1615 W 10TH', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARK', '', '', 'CLARE', '1700 WOODLANDS', '', 'OH', '43537', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AMERICAN BRIDGE CO.', '1  RANDALLS ISLAND PARK', 'NY. NY', 'NY', '10035', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '730 6TH AVE NE', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SUBWAY', '225 NE 138TH AVE', 'VANCOUVER', 'WA', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARILYN', '', '', 'CHILDUSE', 'PENNSYLVANIA', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JONN DEERE', 'BROADWAY', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'GOVERNORS', '', 'SC', '29455', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GANZA', '1150', '', 'DC', '20024', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DIRT S', '444  OLD NEIGHBORHOOD RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CACI', '', 'DAYTON', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'C', '6914 CLYATT STONE RD', 'ALAPAHA', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LOWES', '', 'MOBERLY', 'MO', '65270', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DONOFRIO', '320199  PO BOX', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'BILL', '', '', 'KOURI', '3333 BEDISON ST', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'H', '', '', 'OLF', '', 'SEATTLE', 'WA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WITHERS', '120 PENNOCK TRACE', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RIANG', '', '', 'RI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WEST ADAMS PREPARATORY HIGH SCHOOL', 'WASHINGTON BL', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'GENNELL', '', '', 'MARX', '30370 ST DAVIDS DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LG &E', '', 'LOUISVILLE', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A', '15  BICENTENNIAL CIR', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'C A BEAN', '', '', 'MD', '20659', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'HINKLE', 'COUNTY LINE RD', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3975 N NELLIS', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2678 MT MORIAH TERRACE', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JONN DEERE', 'BROADWAY', 'STOCKTON', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HERBERT', '', 'BOWIE', 'MD', '20716', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WILSON', '11  FRANKLIN LOOP SE', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ANN KENNEDY', '10 KNOLLCREST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'XAVIER', '', '', 'BELL', '3002  PIONER WAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'STEVE', '', '', 'WESLEY', '2568  ORCHARD CT', '', '', '97980', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2 N RIVERSIDE PLZ', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CROKER', '6490 INTERSTATE DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'LEXINGTON RIDGE DR', 'LEXINGTON', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JERRY', '', '', 'DOLAN', '285 KINGMAN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '112 N MAIN', '', 'IA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TAYLOR CO BOARD OF COMMSIONERS', '', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1000 FULTON PKWY', 'EVANSVILLE', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CLARK', 'LOMA VISTA', 'BILLINGS', 'MT', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WAGNER MOTORMART', '', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'COBB', '5302 CHERRIER PL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEARS', '7300 BUSTLETON AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LIN', '', '', 'KARMON', '2643', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'ALLEN', '', '', 'DIAZ', '', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1099 14TH', '', 'DC', '20570', '', Constants.TAG_ENTITY_IND }
  , { 'KEN', '', '', 'LEE', '1230 OAK RD', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { 'KATHY', '', '', 'HELMS', '1814 AL HWY 125', '', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WALMART STORE #1514', '2201 MICHIGAN AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BETTY', '', '', 'PERKEY', '994 CR 5250', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOE', '55  BLACKBERRY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KNOX INSPECTION', '1410 S PARISH DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LINDA', '', '', 'MAY', '100 E 7TH', ' #301', 'KANSAS CITY', 'MO', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EYE MASTER', 'PO BOX 68471', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SIGMA', '225 E HOLLY', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FERNANDO GOMEZ', 'NW 37TH ST', 'DORAL', 'FL', '33166', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WEIR', '', 'HAMPTON', 'VA', '23668', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '7801 NW 37TH ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '11430 N KENDALL DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '60 EDGEWATER DR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GARCIA MIDDLE SCHOOL', '', 'MISSOURI CITY', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '100 SE 3RD AVE', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BARNES NOBLE', '2211', 'PHOENIX', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KATE ZIBELL', 'MAPLE ST', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'DON', '', '', 'MURRAY', '3320 WHY 80 W', 'LABELLE', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROGERS TAYLOR', '24906 NORTH HAMPTON ST', 'SPRING', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'JADE', '', '', 'THOMAS', '334 ARCHDALE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SCOTT', '', '', '', '64081', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'INTERNAL REVENUE SERVICE', '', 'KANSAS CITY', 'MO', '63197', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RAYFORD', 'MAIN', 'HESPERIA', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'KIM', '', '', 'HO', '2ND ST', '', 'LA', '70420', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ENDO PHARMA', '100  ENDO WAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RETAIL', 'SHANDS PIER RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'DRESBACK', '', '', 'WILLIAM', '1840 LAUREL LANE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GAUDET', '4301 LEBANON RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CITI CARDS', '21ST ST', '', 'IA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1902 AGUSTA', 'HOUSTON', 'TX', '77040', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TANNEHILL', '75990 BRANDT PLACE', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'REED', '5121 SWEET BAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JP MORGAN CHASE BANK', 'MAIN', 'BEXLEY', 'OH', '43209', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '98 SAN JACINTO', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1215 5TH AVENUE', 'NEW YORK', 'NY', '10029', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RICHARD BEHRENS ESQ', '10 BIRD WALK TOWNE SQUARE', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FRANKLIN COUNTY EXTENSION OFFICE', 'WALNUT ST', 'MEADVILLE', 'MS', '396530368', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HAIDEE BRYAN', '2558 E 219', 'LONG BEACH', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'J', '331 HILTON TERRACE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A BEAUTIFUL SMILE', '', 'SPRINGFIELD', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { 'JACKIE', '', '', 'YOUNG', '', '', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HTE', '', 'HUNTINGTON BEACH', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1255 E CITRUS', 'REDLANDS', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LOWES', '3460 JEFFERSON PK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'STEVEN', '', '', 'WILSON', '1825  OAK BROOK DR', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'CAROL', '', '', 'SCOTT', '68 GRANDVIEW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '146  CENTRAL  PARK  WEST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '150 2ND AVE N', 'ST PETERSBURG', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AZ OFFICE TECH', '100', 'PHOENIX', 'AZ', '85040', '', Constants.TAG_ENTITY_IND }
  , { 'HENRY', '', '', 'SCHEIN', '27468  WORLD CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FERRADO', '4721', 'CAPE CORAL', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'BOB', '', '', 'BROOKS', '9443 MISSOURI POINT RD NW', '', 'WA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRIPLETT', '2557 WALNUT PIKE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CTA', '', '', 'MT', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'WRIGHT', '7176', '', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IRS', '201  PENN ST', 'BUFFALO', 'NY', '14202', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HOMELAND VINYL PRODUCTS', '3300 PINSON VALLEY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BRIAN', '', '', 'ADLER', 'PINE ST', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'LARRY', '', '', '', 'BAYOU', 'DONALDSONVILLE', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '20235 N CAVE CREEK RD', '', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HBI', 'HIGHLAND AVE E', '', 'MN', '55119', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KESSELL', '635 HI VIEW', '', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LENDER PROCESSING SERVICES', '601  RIVERSIDE AVE', 'JACKSONVILLE', 'FL', '32080', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'REED', '5121 SWEET BAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'TIFFANY', '', '', 'REED', '5121 SWEET BAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BRINKMAN', '1106 FRANKLIN CT', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CIGNA', '6600 E CAMPUS CIR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TAKEDA', '6333 N STATE HEY 161', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'KARLA', '', '', 'HARRIS', 'CHERRY', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WRIGHT', '2141 COLLETTE LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '32 BROADWAY', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '201 CENTRAL AVE', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CYCLERY', '3308 W 44TH', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NORRIS', 'ARBOR WAY', 'CANTON', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FLUIDICS INC.', '7-  GARFIELD RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AMASH', 'DEVONWOOD', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DENNIGER', '1558 PATE RD', 'WHITESBURG', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SIERRA VISTA MALL', '1140  SHAW AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RED LOBSTER', 'E 23RD ST', '', 'FL', '32405', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RIVER VALLEY BANK', '3210 E MAIN', 'MERRILL', 'WI', '54442', '', Constants.TAG_ENTITY_IND }
  , { 'ROB', '', '', 'REA', '250  M ST EXT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CITI TREND #319', 'LINCOLN HWY', 'MATTESON', 'IL', '60443', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BEATTY', 'AZALEA', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2950 SW 16TH AVE', 'MIRAMAR', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DAWN MEYER', 'E 16TH', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KROGER', '172 W LOGAN ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5757 WILSHIRE', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '101 CLARK ST', 'BROOKLYN', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARUIA', '', 'HUNTINGTON BEACH', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '11545 W BERNARDO CT', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BROWN', '1214 PLEASANT', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MALYS', '', 'MUNCIE', 'IN', '47303', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DICK', 'MAIN', 'CLINTON', 'ME', '4927', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BURLINGTON COAT', 'S WANAMAKET RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'PAMELA', '', '', 'WOLF', '805 LIBERTY CREEK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SMDC', '4505 W SUPERIOR ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EBELTIFTKRISTIN', '3751 HOWARD HUGHES', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ATT', '15240 MAIN ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '475 RIVERSIDE BLVD', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EATON CORP', 'JERONIMO', 'IRVINE', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IKON', '', 'MACON', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'AT&T', '', '', 'TN', '37201', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BENNETT', '', 'MOBILE', 'AL', '36521', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GIGLIA', '', '', '', '45220', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KAWNEER CO', '600 KAWNEER DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JEFF', '', '', 'GETZ', '', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'METRON', '44TH AVE', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'WILLIAMS', '', '', 'BRADLEY', '840 MCTOWLEY', 'LOUISVILLE', 'KY', '40219', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1130 PARK AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GOTT', '', '', 'CO', '80134', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ILLINOIS ST. ANDREW SOC.', '28TH ST', 'NORTH RIVERSIDE', 'IL', '60546', '', Constants.TAG_ENTITY_IND }
  , { 'MIKE', '', '', 'MORRIS', '5TH & OAK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NATGUN', 'VALLEY VIEW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JP MORGAN CHASE', '14202 FM 2920', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1959 NE PACIFIC', 'SEATTLE', 'WA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PETERSON', '4986', 'WILLMAR', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HSI', '1820 OLD FIRE TOWER RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JORGE', '', '', 'GARCIA', '5621 NW 2ND TER', 'MIAMI', 'FL', '33166', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'GUILLORY', '', 'HOUSTON', 'TX', '77096', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LIFEWAY CHRISTIAN', '', '', 'WA', '98188', '', Constants.TAG_ENTITY_IND }
  , { 'TIMOTHY', '', '', 'PETERS', 'VIA BEGUINE', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'ESTELLA', '', '', 'TAYLOR', 'PALM DRIVE', 'SATELLITE BEACH', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '201 N CENTRAL AVE', 'PHOENIX', 'AZ', '85001', '', Constants.TAG_ENTITY_IND }
  , { 'VICTOR', '', '', 'HAUGHRON', '1071 N WATERVILLE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1050 CONN AVE NW', '', 'DC', '20030', '', Constants.TAG_ENTITY_IND }
  , { 'MATT', '', '', 'WOLFF', '88 STEELE ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HUDSON NEWS', '38600  ZIP INDUSTRIAL BLVD     B', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '4660 LA JOLLA VILLAGE DR', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5052', 'LINE LEXINGTON', 'PA', '18932', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '7171 FOREST LN', 'DALLAS', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BSH', '', 'COLUMBUS', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'TAKAO', '', '', 'OHNUMA', '5TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'TIFFANY', '', '', 'REED', '5121 SWEET BAY ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LAURA', '', '', 'ADAMS', '878  COLD SPRINGS RD', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ABC', 'TYCO ROAD', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FRAME GUILD', '1137 PENN AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BROKS', '', '', 'WILLIAMS', '844', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '8000 NW 31ST ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'KEN', '', '', 'WINTERS', '5 CHAPEL LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CASA DE BENAVIDEZ', '4TH', 'ALBUQUERQUE', 'NM', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '151 NORTH DELAWARE ST', 'INDIANAPOLIS', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BUDICH', '', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1900 M ST', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'REGALIA', '', '', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DURA COOL', '4944 GLEN LANE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'TRACEY', '', '', 'BAIRD', '', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TOYS R US', '1200 LANCASTER DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3401 DALE RD', 'MODESTO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SMITH', '', 'MCCONNELL AFB', 'KS', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHEAL', '', '', 'HORNE', '206 SE JOHNS ST', 'LAKE CITY', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'HONG', '', '', 'ZHANG', '', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SPAGNOLIA', '10 POINT RICH DR', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRACY MOTOR', '322 CLEVELAND', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MASTERCARD', '2200  MASTERCARD BLVD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'WILLIAM', '', '', 'WARD', '940 N 2410 E', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LAND N SEA', '', 'KANSAS CITY', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '217 E 96 TH ST', 'NEW YORK', 'NY', '10128', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'COLE', '3126 N RIVERSIDE DR', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'B', '1706  MONTE BELL CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'TREVA', '', '', 'BROWN', 'BLANCHE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MOORE', '37 JAQUITH RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARY', '', '', 'DEARMAN', '65  2ND AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'KATE', '', '', 'GORDON', '4384', 'BIRMINGHAM', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { 'PAMELA', '', '', 'JONES', 'PO BOX 341', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WINDRUNNER', '797 LANCASTER AVE  SUITE 14', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'KIM', '', '', 'WINIGER', 'LAKE', 'RACINE', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARK', '', '', 'DIAS', '', 'FAIRFIELD', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JADE', '', '', 'THOMAS', '334 ARCHDALE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KAWNEER CO', '600 KAWNEER DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '11000 PLEASANT VALLEY RD', 'CLEVELAND', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { 'SARAH', '', '', 'MILLER', '110 5TH AVER', 'NEW YORK CITY', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NYSDC', '101 MAIN ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JENNIFER', '', '', 'HILL', '1350 ROOSEVELT PARK BLDVD', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GESA', '', '', 'WA', '99352', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3 WASHINGTON CIRCLE', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LIU', '308', 'MALDEN', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JUDY', '', '', 'MARTIN', 'MAIN STREET', 'LISBON', 'NY', '13658', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DAVIS', '167 MAIN', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ATLANTIC FIRE DEPARTMENT', '675  PONCE DE LEON', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'PAM', '', '', 'WOLF', '805 LIBERTY CREEK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BETH', '', '', 'HALE', '304 W GARDENIA DR', '', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { 'ADELIA', '', '', 'LOPEZ', 'J M FM 476', 'POTEET', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'RON', '', '', 'PACKARD', 'KINNEAR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'VOGEL', 'N6W31449', '', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CITI TREND', 'LINCOLN HWY', 'MATTESON', 'IL', '60443', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOLLAR GENERAL', '', '', 'FL', '33980', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CLIFFORD KELLY', '133 W DAVIS ST', '', 'VA', '22701', '', Constants.TAG_ENTITY_IND }
  , { 'REBECCA', '', '', 'MILLER', '6766 COUNTY ROAD 18', 'LOVELAND', 'CO', '80537', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PAT HAGGETT', '1800  ST LUCIE BLVD', 'STUART', 'FL', '34996', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '4300 GOODELLOW', 'ST LOUIS', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { 'YVETTE', '', '', 'WILLIAMS', '844', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PRISILLAS', '1251 MAIN ST', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '201 S PROSPECT', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1050 E PIEDMONT RD', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'DEMBA', '', '', 'DIALLO', '968 NORLAKE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '8201 S TAMIAMI', 'SARASOTA', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'G R AUTO & TRUCK REPAIR', '', 'WHITE PLAINS', 'NY', '10607', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3801 NEBRASKA AVE', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOANNE', '', '', 'CURRO', '1841 SOUTHFORK PL', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MAILYS', '', 'MUNCIE', 'IN', '47303', '', Constants.TAG_ENTITY_IND }
  , { 'DOUG', '', '', 'SYMONS', 'MAIN STREET', 'LISBON', 'NY', '13658', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WARREN', '7813 SW 77 CT', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'REINER', '7 RUSSELL', '', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HAMMER', '6107 W AIRPORT BLVD', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { 'JIM', '', '', 'FINK', 'WASHINGTON', 'CASPER', 'WY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'THE LAURELS', 'ENFIELD', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THOMPSON', '210 NE 10TH AV', 'JOLIET', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARTHA MORSE', '915  WAVERLY RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'G AND R ENTERPRISES', 'WEST MAIN ST', 'HOPKINTON', 'MA', '1748', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BUTTERWORTH', '1500 WEST BROOK CT', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RIVERA', '173 E 120TH ST', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '745 5TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ADAMIAN', '601 E ATLANTIC BLVD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BEVERLY', '', '', 'TRUCSHEITT', 'MEADOW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'LARRY', '', '', 'LEWIS', 'PARK HILL', 'COLLIERVILLE', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'VENTRA', 'BRETON RD', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'USPS', '17875 NW 57TH ST', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '25900 NORTHWESTERN HWY', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HOWARD', '', 'LAUREL', 'MS', '', '', Constants.TAG_ENTITY_IND }
  , { 'RICK', '', '', 'LEWIS', '5956 SMITH HILL RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STEVE & STACY', '130 VIRGINIA ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BAKER', '4665 PARKHILL', 'LITTLEROCK', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IRVING', '1150', '', 'DC', '20024', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'M', '', '', 'JOHNSON', '', 'ROSEVILLE', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BRANDY RUSSELL', '9431 SILVER MAPLES', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CONLEY', '', 'ASTORIA', 'NY', '11106', '', Constants.TAG_ENTITY_IND }
  , { 'KEVIN', '', '', 'ELLIOTT', 'GROUND PLUM CIR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALBERTSONS', 'TAYLOR', 'SHERMAN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'R 1 BOX 212 A', 'WAYNETOWN', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CARISSA ROSE', 'BROAD', 'BLOOMFIELD', 'NJ', '7003', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ARMED FORCES RESERVE CENTER', 'GRAND AVE', 'PINELLAS PARK', 'FL', '33782', '', Constants.TAG_ENTITY_IND }
  , { 'JUAN', '', '', 'LEBRON', '3418 HUMMUCK DR APT 106', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HYATT', '', 'LOS ANGELES', 'CA', '90067', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'SANDERS', 'PO BOX 442', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1200 BINZ', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'BROKS', '', '', 'WILLIAMS', 'KING ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5453 DELMAR', 'ST LOUIS', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'COLE', '', '', '', '22191', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PEAK', '', 'ALEXANDRIA', 'VA', '22301', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5150 OAK RIDGE', 'PAHRUMP', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHRISTOHER', '', '', 'LAMPE', '106 TUSCANY LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'KATHY', '', '', 'MULLER', '', '', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'US BANK', '', 'FAIRFIELD', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'TRACEY', '', '', 'JENKINS', '', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { 'ANTHONY', '', '', 'SMITH', '2125 AIRPORT', '', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3 WASHINGTON CIRCLE', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SOUTHEAST BANK AND TRUST', 'CONGRESS PARKWAY', '', 'TN', '37303', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KIRSCHNER', '', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'C', '6914 CLYATT STONE RD', '', 'GA', '31632', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BOYS AND GIRLS', '1806 N FLAMINGO RD     450', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARYLIN', '', '', 'ADAMS', 'EVERGREEN', 'SHERIDAN', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERTS', '', '', 'ANDREAS', '709 COUNTRY LANE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STATER BROS', 'DE BERRY', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '6909 N LOOP 1604 E', 'SAN ANTONIO', 'TX', '78241', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROGOWSKI', '', '', 'CT', '', '', Constants.TAG_ENTITY_IND }
  , { 'LLOYE', '', '', 'KLUG', '1ST AVE W', 'UPSALA', 'MN', '56384', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PIERCE', '4188 ANDERTON', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CLARK', 'BAYVIEW AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CROZIER', '', 'CHEYENNE', 'WY', '', '', Constants.TAG_ENTITY_IND }
  , { 'DAVE', '', '', 'MCDANIAL', 'BROOKSIDE DR', 'GRIMES', 'IA', '50111', '', Constants.TAG_ENTITY_IND }
  , { 'LINDA', '', '', 'JONES', '130 HUNTIINGTON SHORES', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'YVETTE', '', '', 'WILLIAMS', 'KING ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'P F CHANGS', '10 PROVIDENCE TOWN CENTER', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MACK', '55 S FAYETTE ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SQUARE D', '', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '507 E MICHIGAN ST', 'MILWAUKEE', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CSI', '', 'ST CLOUD', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '6550 FANNIN', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'GAIL', '', '', 'TYLER', '289 FLOWER COURT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TAYLOR', '1503 EVANGELINA', '', 'FL', '34266', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '760 HARBOR BEND', 'MEMPHIS', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'STROMINGER MD', 'LEXINGTON ST', '', 'MA', '21282513', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TOYS R US', '1200 LANCASTER DR NE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LAFORCE && STEVENS', '132 W 31ST ST', 'NEW YORK CITY', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROADWAY', '', 'RIALTO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EQUITY', '8055 E TUFTS', '', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'VASSOLO', '', 'SAINT LOUIS', 'MO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LOWES', '', 'MOBERLY', 'MO', '65270', '', Constants.TAG_ENTITY_IND }
  , { 'SAIKIA', '', '', 'SMITH', '9053 KEIR ST', '', 'CA', '92116', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ACME', '', 'CONCORD', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RENEBERG', 'ROBERT', '19524  SANDCASTLE LN', '', 'CA', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SURE CROP CHEMICAL', 'MAIN ST', 'MELBETA', 'NE', '69355', '', Constants.TAG_ENTITY_IND }
  , { 'JACKIE', '', '', 'WILLIAMS', '150 KETTLETON', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CHF RECORDS', '700 KANSAS', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '15950 US HIGHWAY 441', 'MOUNT DORA', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PETERSON', '882 S COUNTRY MANOR', 'ALPINE', 'UT', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '7345 E ACOMA DR', '', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { 'MIKE', '', '', 'SCHOLL', '625 W LIBERTY', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { 'BROKS', '', '', 'WILLIAMS', 'KING ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WASHINGTON', '', 'LEESBURG', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'R E MICHEL', '680 CAROLINA RD', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { 'REBECCA', '', '', 'HUNTON', 'CENTRAL', 'MELBOURNE', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LEISER', '10500 ROCKVILLE', 'ROCKVILLE', 'MD', '20814', '', Constants.TAG_ENTITY_IND }
  , { 'ELISE', '', '', 'FOLK', '261 CEDARHURST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FETTY & DONALLY', '1225 I ST NW', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DIAZ', 'E 53RD ST', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'MAIN ST', '', 'NY', '11975', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '276 5TH AVE', 'NEW YORK CITY', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'SANDRA', '', '', 'SNYDER', 'ROSEDALE AVE', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BRW AND ASSOCIATES', 'FM 78', 'SAN ANTONIO', 'TX', '78244', '', Constants.TAG_ENTITY_IND }
  , { 'ASHLEY', '', '', 'TAYLOR', '4594 TERRACE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DUNN', '113 HOMER ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MORGAN', '', '', 'FRIES', '2283 MOSS SIDE COURT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MELISSA', '', '', 'MACE', '12008 BROWN RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KROGER', '172 W LOGAN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CHASE BANK', 'MAIN', 'BEXLEY', 'OH', '43209', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'STATER BROS', 'DEBERRY', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'WAYNE', '', '', 'SCHMITZ', '9110 COUNTY HIGHWAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KEVIN FOUTZ', 'COLCHESTER DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NORTH AUSTIN MED CENTER', '12221 MOPAC', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'DRY MONIA', 'NEW BERN', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'ANNIE', '', '', 'GUILLORY', '8TH ST', 'FGENTON', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MACK', '55 S FAYETTE ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '11767 S DIXIE HWY', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOLLAR GENERAL', '', 'CRYSTAL RIVER', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DR LYNN WILSON', '1536 W 25', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KOHLS', '', 'MENTOR', 'OH', '44060', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'FORESTWOOD CIR', '', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARCUS', '', '', 'WARE', '859 CONVENTION CENTER BLVD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CURRIE', '477 E MORY OAKS DR', 'BRYAN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CROY', 'E WILLIAMS RD', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'USAID', '', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { 'DAVID', '', '', 'REED', '12067 7TH AVENUE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EMPIRE STATE ADMISSIONS', '2  UNION AVE', '', '', '11286', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'T MOBILE #9868', '', 'DALLAS', 'TX', '75218', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EWCO', '', '', '', '97230', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'T', '2557 WALNUT PIKE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'AUSTIN', '', '', 'POWELL', '', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'WILLIAM', '', '', 'HEALY', '', 'LOUISVILLE', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3900 LAS VEGAS', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CARLOS ARANGO', '3713 NW 17TH ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1700 WOODBURY', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MAUREEN SIMPSON', '550 NORTH FLOWER ORD', 'COSTA MESA', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARRIOTT', '', 'SPRING', 'TX', '77380', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JIM KAMMERDIEMER', 'MAIN ST', '', 'PA', '16346', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GA MILLER LUMBER CO', '', 'WILLIAMSPORT', 'MD', '21795', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SAWYERS MOTORCYCLES', '10995 OAKRIDGE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '55 5TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'PAUL', '', '', 'ZIMMERMAN', 'MAIN ST', 'BELLEVILLE', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1660 PEACHTREE ST', 'ATLANTA', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SIMMONS', '5924 OWL NEST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MATILDE', '', '', 'LUNA', 'SUNSET', 'BRONX', 'NY', '10465', '', Constants.TAG_ENTITY_IND }
  , { 'BRADLEY', '', '', 'JOHNSON', '5738 SUMMERSTON', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ALLISON', '', '', 'STRAIN', 'RT 1', 'GREENFIELD', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1133 5TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'YMCA', '3030 N 3RD ST', '', 'AZ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MOORE', '37 JAQUITH RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '837 5 AVE S', 'NAPLES', 'FL', '34102', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOLLAR TREE', '7610 S ALAMEDA ST', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'BARBARA', '', '', 'WILKIE', '1244 EVANSBURG RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'AUDREY', '', '', 'CREWELL', '24031 HIGHWAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROLANDO', '', '', 'GOMEZ', '5629 CHILDER ST', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '445 S FIGUEROA', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '7 LINCOLN SQUARE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { 'TRACY', '', '', 'MOORE', '1003 SHA NELLE', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'DALE', '', '', 'SEWELL', '3460 JEFFERSON PK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3 WASHINGTON', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { 'BEN', '', '', 'WILLS', '2030 LONDON AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'GRIFFITH', '700 VERDUN', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ZEIH', '4145 NE CHAPEL MANOR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JIM', '', '', 'DALY', '7321 ARBUTUS DR', '', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BARD', '', 'COVINGTON', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PROJECT TELEPHONE   WORDEN', 'MAIN ST', 'WORDEN', 'MT', '59088', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ATT', 'MAIN ST 2ND FLOOR', 'LOUISVILLE', 'KY', '40212', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARY OWENS', '25670 N SHORE PL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOLTON BEARS', '6479  MADISEN LN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MILLSAP', '208 FRANKLIN', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'RICK', '', '', 'HENDRICK', '1255 FRANKLIN ALEXANDER', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '21500 NORTHWESTERN HWY', 'SOUTHFIELD', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'CAMERON', '', '', 'TAYLOR', '6394 BERCHVIEW DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'INDIAN LAND ELEMENTARY', '4137 DOBY BRIDGE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CAAF', '', 'LOS ANGELES', 'CA', '90045', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'D&D', '', 'KINGSPORT', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HULL', '', 'GREENFIELD', 'OH', '45123', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SHEAD', '', 'TULSA', 'OK', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BRIAN SHEPHERD', '8937 CRESCENT LODGE DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RORY SIGGINS', '553  OLD STILL RD', 'WAKE FOREST', 'NC', '27587', '', Constants.TAG_ENTITY_IND }
  , { 'BRAD', '', '', 'JOHNSON', 'SUMMERSTON', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CIRIGNANO', '5 BIRCH RD', '', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRIAD', '', 'AUSTIN', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LANG', '8119 TOWNLEY ROAD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JEAN WILLIE', '12053 HWY 1078', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROMERO', '7563 COYARE RUN W', '', 'FL', '33433', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KNAPP LOGISTICS AUTOMATION', '2124 BARRETT PARK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '18851 NW 29TH AVE', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TAYLOR', '26825', 'ATHENS', 'AL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'POLICE', '', 'MONROE', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WINDFOHR DESIGN', '3310 WEST MAIN', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'SAM', '', '', 'BROWN', '664 LINCOLN', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'COBB', '5302 CHERRIER PL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ADVANCE AUTO', 'UNION', 'BUFFALO', 'NY', '14225', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3335 S A ST', 'OXNARD', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TRATTORIA', '135 WEST THIRD ST', 'NEW YORK', 'NY', '10004', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'G', '201 MAPLEBROOK DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CALICO', '1041 KENOSHA', '', 'OK', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'Z WEST INSURANCE GROUP INC', '71222 S GRIFFITH PLACE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'REDLINE PREFORMANCE PRODUCTS', '50TH ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ROBERT MORREALE', '6734 GREGORY CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NOBLES TIRE', 'PARK AVE', 'HOUMA', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARY', '', '', 'WILSON', '1365 FREEWAY BLVD', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PANERA BREAD', '541 VISTA AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MOULDER', '1451 SLATE MINEN DR', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SMOOTHIE KING', 'FEDERAL HWY', 'HOLLYWOOD', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SOLOMON', '7110', 'BETHESDA', 'MD', '20817', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JACKSON', '606 RUTH ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MFI', 'MAIN ST', 'HAVELOCK', 'NC', '28532', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2924', '', 'NY', '11959', '', Constants.TAG_ENTITY_IND }
  , { 'LUIS', '', '', 'VALOY', '305 MAIN ST', 'HAZLETON', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARLENE REALI', '615 E RIVER RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PARK', '84631 LIVE OAK', 'FORT HOOD', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WILLIAMS', '240 MOTOR', 'HOWELL', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CARLSON', '1991 E JOPPA RD', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PALMETTO GENERAL HOSPITAL', '2001 W 68TH ST', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'RIVER AVE N', 'INDIANAPOLIS', 'IN', '462110001', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ERIC', '', '', 'SUTTON', '14744 TWIN BAYS RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'D', '', '', 'BRUMFIELD', '5450 PRAIRIE STONE PWK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOL', '1947 507TH', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BRIAN', '', '', 'HODGSON', 'MAIN', 'FREDONIA', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SPAGNOLIA', '10 PT RICH', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '520 8TH AVE', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MCDONALDS', '', 'LUBBOCK', 'TX', '79416', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A PEAK', '', 'OKLAHOMA CITY', 'OK', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '511 SE 3RD ST', 'OCALA', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RANDALL CLEARY', '4550 POST OAK PLACE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'GARY', '', '', 'CRUCE', '', '', 'KY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '100 SE 2 ST', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'JULIE', '', '', 'ANDERSON', '52', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CARQUEST AUTO PARTS', '', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PAMELA AND ROSE', '100 MAIN ST', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'JOHN YOUNG PARKWAY', 'ORLANDO', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PORTILLO', '7720', 'HOLLYWOOD', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KELLYS', 'PUTNAM ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'WILLIAM', '', '', 'JUSTICE', '', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { 'DIANE', '', '', 'BROWN', '400 ATRIUM DR', '', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WALTER', '1040 S PARKWAY FRONTAGE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1111 HOWE AVE', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'CASTILE CT', 'WOODBRIDGE', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { 'C', '', '', 'STRICKLAND', '1978 HAMS', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DICKS', 'MAIN', 'CLINTON', 'ME', '4927', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HAMMER', '6107 W AIRPORT', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ALTOBELL', '13065 CAMINITO CARMEL LAND', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'FORD', '382 FORD', '', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NANCY DERIAN', '', 'LOS ANGELES', 'CA', '90024', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'EMILS JEWELY', 'PARK AVE', '', 'NY', '13903', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'RODGERS', '2121 US HWY 441', 'DUBLIN', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BRINKMAN', '1106  FRANKLIN CT', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KROGERS', '2010 STERLING RUN BLVD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MILLER', '', '', 'MO', '64050', '', Constants.TAG_ENTITY_IND }
  , { 'JACKIE', '', '', 'WILLIAMS', '150 KETTLETON', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'HERMAN', '', '', 'MEDINA', '22  RANGER RDG', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARLENE REALI', '615 E MAIN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'RONA', '', '', 'DOVE', 'HICKORY KNOLL', 'SANDY SPRING', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HENDRICK', '1255 FRANKLIN ALEXANDER', '', 'LA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5925 KIRBY', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'JEFF', '', '', 'KING', 'POINT WHITE DR', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DEMBA  DIALLO', '968 NORLAKE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'MARIE', '', '', 'ROSE', '321 DANIEL DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1300 CLAY ST', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HUNG K TRAN', 'APT 218', 'WESTMINSTER', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'KEN', '', '', 'MAYO', '247 FULTON RUN RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JULIE', '', '', 'FISK', 'WASHINGTON AVE', 'NEW BALTIMORE', 'NY', '12124', '', Constants.TAG_ENTITY_IND }
  , { 'LARRY', '', '', 'BELL', '4401 WHEELER ST', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'LINDA', '', '', 'DREWS', '2605 COLLEGE COURT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'C', '6914', 'ALAPAHA', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'LAUREN', '', '', 'WRIGHT', 'NW 8TH CT', 'ANKENY', 'IA', '50023', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CLARK', 'PO BOX 5039', 'FORT HOOD', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FAMILY DOLLAR', 'HIGH', 'HAMILTON', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CHAPMAN', '2100 TORENCE CHAPEL ROAD', 'CORNELIUS', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GONZALEZ', 'FRANKLIN SQ', 'RANDOLPH', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'COSLO', 'SPRING GROVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JACKIE', '', '', 'WILLIAMS', '150 KETTLETON', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'TEXAS BURGER', '', 'MIDLAND', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CHESTER', '5126 149TH AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GALLET & ASSOCIATES  CUL', '1716  2ND AVE NW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'S GINNYS', '', 'MIAMI', 'FL', '33156', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KINNEY', '', 'MERIDIAN', 'ID', '', '', Constants.TAG_ENTITY_IND }
  , { 'PATRICIA', '', '', 'DISE', '969 BRIDGE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WOODWARD GOVERNOR', '', 'LOVELAND', 'CO', '80538', '', Constants.TAG_ENTITY_IND }
  , { 'KATIE', '', '', 'BRANNAN', '425 S 5TH', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOSHUA', '', '', 'DAVID', 'FAIRVIEW', 'ROANOKE', 'VA', '24011', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '255 ALHMABRA CIR', 'MIAMI', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'DAVID', '', '', 'SAWYER', '12 OAKS', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '901 LEOPARD', 'CORPUS CHRISTI', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'ROMANO', '350 WILBUR HENRY', '', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KEN MAYO', '247  FULTONS RUN RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SMITH', '201 NORTH HOSKINS ROAD', 'CHARLOTTE', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PROVIDENCE GATEWAY', '', '', 'RI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MIKE CHAT', 'VALLEY', '', 'CA', '91607', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BABLITZ', '438 NORRISSVILLE RD APT 3D', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'DON', '', '', 'VICTORS', '4TH', 'PASCO', 'WA', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHUCK', '', '', 'HAMMETT', '627 GILLETTE DRIVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '317 MADISON AVE', 'NEW YORK', 'NY', '10017', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LISA LANDIS', '100 S LOGAN', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DEPAUL FAMILY SERVICES', 'WATERLICK RD', 'LYNCHBURG', 'VA', '24502', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'MELROSE', 'IRVINGTON', 'NJ', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NATGUN', '29 VALLEY VIEW', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'OBERMAYER', '12 SHERATON DR', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MCKESSON', 'COMMERCE BLVD', '', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MR CLYDE HODGES', 'PO BOX 802172', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CHRISTINA NAVA', '', 'LONG BEACH', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'CHRIS', '', '', 'EDEN', '', 'CHICAGO', 'IL', '60661', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '250 S STAGECOACH TRAIL', 'SAN MARCO', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'MCLEAN', 'FOOTHILL BLVD', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOHN', '', '', 'BINU', '', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '447 IRVING AVE', 'WILLOUGHBY', 'OH', '44094', '', Constants.TAG_ENTITY_IND }
  , { 'ERIC', '', '', 'SUTTON', '14744 TWIN BAYS RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'A', '', '', 'CAIRO', '507 MYRTLE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LOCKHEED', '1040 S PARKWAY FRONTAGE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DONATOS', 'HIGH', 'HAMILTON', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JANE JOHNSTON', '778  UNION RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HALL', '', '', '', '32963', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KELLOG BROWN & ROOT', '601  JEFFERSON ST', 'HOUSTON', 'TX', '77001', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NATIONAL PARK INN', '5945 CORN HUSTER DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BROWN', '3810 GWYNN OAK AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SUTHERLAND', '5001 143RD', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'G E MONEY', '', 'INDEPENDENCE', 'MO', '64050', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CAPRI POOLS', '1287 G A R DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ERIN WAGNER', '520  MAIN ST', 'GRAPEVINE', 'TX', '76051', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '9130 LEESWOOD RD', '', 'MD', '21014', '', Constants.TAG_ENTITY_IND }
  , { 'MARY', '', '', 'CLARK', '98 GAWOM DR', '', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { 'MICHELE', '', '', 'ALEXANDER', '1307 COZBY', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GAN', '', 'MATTHEWS', 'NC', '', '', Constants.TAG_ENTITY_IND }
  , { 'D', '', '', 'POLL', '', 'MARBLE', 'CO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '200 CONSTITUTION', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SODEXO', '', 'AUGUSTA', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WILLIAMS', '', '', '', '33619', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LEINHARDT', '', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '303 PEACHTREE CENTER AVE', 'ATLANTA', 'GA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARCY CASINO IN DELAWARE PARK', 'LINCOLN PKWY', 'BUFFALO', 'NY', '14201', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MADISON BANK OF MARYLAND', '6800  HARFORD RD', 'BALTIMORE', 'MD', '21221', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5757 WILSHIRE', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FALCONE', 'E 22ND ST', 'BROOKLYN', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'QUARLES', '', 'LAS VEGAS', 'NV', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '5601 N SHERIDAN', 'CHICAGO', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ST CLAIR', '2522 SUMMIT', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'RIVERA', '10 BROAD ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'RICHARD', '', '', 'NYLEN', 'PO BOX 46043', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '311 MAIN ST', '', 'NY', '12839', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MASTER CHEMICAL', '1056 CHURCHILL CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'DANIEL E', '', '', 'AMES', '4953 MARY LOUISE CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '19925 GULF BLVD', 'INDIAN SHORES', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MD ANDERSON CANCER CENTER', '', 'BASTROP', 'TX', '78602', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KANE', '40 W GATE PARKWAY UNIT L', '', '', '28806', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JENKINS', '9040 HUDSON RD STE 203', '', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '11160 VIERS MILL', 'WHEATON', 'MD', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '4140 SW 28TH WAY', 'FT LAUDERDALE', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { 'KIMBERLY', '', '', 'JONES', '', 'LAKE VIEW', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'LABLEURT', 'S MAIN ST', '', 'OH', '44262', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ZHANG JINGSHU', '912 RIVER AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'N COUNTY CENTER', 'RTE 22', '', 'NY', '1', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', 'FIELD ST', 'SAN DIEGO', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'OCONNOR', '', 'CINCINNATI', 'OH', '45246', '', Constants.TAG_ENTITY_IND }
  , { 'DANIEL', '', '', 'SALAZAR', '7TH', 'CAPE CORAL', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DC MARTIN', '36TH', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A', '6107 W AIRPORT', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ASHLEY TAYLOR', '4594 TERRACE', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BETTY', '', '', 'PERKEY', '994 CR 5250', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'RUTH ANN', '', '', 'REGAN', 'HIGHLAND ST', 'MARLBORO', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '44505 FORD', 'CANTON', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'LORI', '', '', 'WILLIAMS', '2323 NW GRAND', '', 'OK', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CO', '500 NW 12TH AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'WILLIAM', '', '', 'BENNETT', '46 VINE ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'NANACY', '', '', 'CHAPPLE', '7TH', '', 'PA', '15010', '', Constants.TAG_ENTITY_IND }
  , { 'MICHAEL', '', '', 'THOMSON', '34 ROBIN HOOD RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FIRST BAPTIST CHURCH', '2517 N 107TH AVE', '', 'AZ', '85323', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DURA KOOL', '', '', 'IL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DRESSEL', '1025 CREEK COURT', '', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { 'A', '', '', 'MARTIN', '111 OBRIAN WAY', 'COLUMBIA', 'SC', '', '', Constants.TAG_ENTITY_IND }
  , { 'KELLY', '', '', 'CURELL', '232 MOUNT TOM RD', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { 'YVETTE', '', '', 'WILLIAMS', '', '', 'PA', '', '', Constants.TAG_ENTITY_IND }
  , { 'JEFFREY S', '', '', 'ASHER', '1203 CHRISTINA CT', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'ROBERT', '', '', 'ELLIOT', 'BROADWAY STREET', 'SPRINGFIELD', 'VA', '22134', '', Constants.TAG_ENTITY_IND }
  , { 'CHRIS', '', '', 'NELSON', '809 W PENNSYLVANNIA AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THE PANTRY', '', 'SHREVEPORT', 'LA', '71107', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JOSEPH PIETROCINI', '2364 BECKETT CIR', '', 'OH', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '2001 NW 31ST AVE', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'NOVACK', 'SW PALATINE HILL RD', '', 'OR', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BIRDS EYE AUTO', 'N WALNUT AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'NATASHA', '', '', 'ROBINSON', 'NORTH AVE', 'FT PIERCE', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'HUBBARD HALL', 'MAIN ST', 'CAMBRIDGE', 'NY', '12816', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GREEN', '317 CENTRAL AVE', 'INDIANAPOLIS', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { 'NOREEN', '', '', 'MILES', '5970 N COUNTY RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '3  TIMES SQ', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BRENDA  ROSS MS', '325  MARKET ST', '', 'TN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1133 BROADWAY', 'NEW YORK', 'NY', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '800 CYPRESS GROVE', '', 'FL', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'IRS', '8101 TOM MARTIN DR', 'ADAMSVILLE', 'AL', '35005', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'THE JUDY COMPANY', '5 & OAKE ST', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'KLEINBERG ELECTRIC INC', '/E  15TH ST', 'BROOKLYN', 'NY', '11229', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1555 N VINE ST', 'LOS ANGELES', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PIERCE', '4188 ANDERTON', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GOLDEN OAK', 'PO BOX 4277', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '955 PRATT AVE', 'ELF GROVE VILLAGE', '', '60006', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'POWELL', '925 DIXIE DR', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'JOANNA', '', '', 'KLEIN', '9625 HAWLEY DR', '', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'JOHNSTON MURPHY', '145 BROADWAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1160 CAMINO CRUZ BLANCA', 'SANTA FE', 'NM', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WIENS', 'ADAMS MILL RD', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEALING', '', 'HOUSTON', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '76 MAIN ST', 'NORTH READING', 'MA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'WALGREENS', 'MAIN ST', 'PROVIDNECE', 'RI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'FSI', '', 'ST CLOUD', 'MN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BENNINGHOFF', '4226 N 22ND', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'SEARS', '1140  SHAW AVE', 'CLOVIS', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'GENE FREEMAN', '2616  RIDGEVILLE RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'MARY OWENS', '25670 N SHORE PL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '1100 NEW YORK AVE', '', 'DC', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'PAYNE', '2119 RIVER ROCK', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BELL', '3002  PIONER WAY', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '10300 EATON PLACE', '', 'VA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOMINOS', '956  CHERRY ST', '', 'CO', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'DOLLAR GENERAL', '', 'SMITHVILLE', 'TX', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'A', '267 S RICHLAND ST', '', 'IN', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'C A SIMON', '', '', 'PA', '15236', '', Constants.TAG_ENTITY_IND }
  , { 'JIM', '', '', 'ZUNDEL', '71222 S GRIFFITH PL', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BURGER', '', 'VENTURA', 'CA', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CARPENTER', '6830 STATE ST', '', 'MI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'CLARK CINDY', '22724 BAYVIEW AVE', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'BRACY', 'TREESONG RD', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', 'ST MARTIN', '8TH', 'CLINTONVILLE', 'WI', '', '', Constants.TAG_ENTITY_IND }
  , { '', '', '', '', '', '', '', '', '', Constants.TAG_ENTITY_IND }
  , { 'BEVERLY', '', '', 'TRUCSHEITT', 'MEADOW', '', '', '80439', '', Constants.TAG_ENTITY_IND }
  ], UPS_Testing.layout_TestCase);
