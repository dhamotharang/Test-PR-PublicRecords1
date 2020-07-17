import ut,iesp, std;

export Constants := MODULE
    export unsigned2 get_min(unsigned c1, unsigned c2_in):=function
      c2:=if(c2_in=0,c1,c2_in);
      return if(c1<c2,c1,c2);
    end;
    shared unsigned2 in_MaxProperties := iesp.Constants.AR.MaxProperties : STORED('MaxProperties');
    shared unsigned2 in_MaxDLs := iesp.Constants.AR.MaxDLs : STORED('MaxDriversLicenses');
    shared unsigned2 in_MaxVehicles := iesp.Constants.AR.MaxVehicles : STORED('MaxMotorVehicles');
    shared unsigned2 in_MaxBusiness := iesp.Constants.AR.MaxBusiness : STORED('MaxBusinesses');
    shared unsigned2 in_MaxNeighbors := iesp.Constants.AR.MaxNeighbors : STORED('MaxNeighbors');
    shared unsigned2 in_MaxBankruptcies := iesp.Constants.AR.MaxBankruptcies : STORED('MaxBankruptcies');
    shared unsigned2 in_MaxPhonesRes := iesp.Constants.AR.MaxPhonesRes : STORED('MaxResidentialPhones');
    shared unsigned2 in_MaxPhonesBus := iesp.Constants.AR.MaxPhonesBus : STORED('MaxBusinessPhones');
    shared unsigned2 in_MaxResidents := iesp.Constants.AR.MaxResidents : STORED('MaxResidents');
    shared unsigned2 in_MaxLiens := iesp.Constants.AR.MaxLiens : STORED('MaxLiens');
    shared unsigned2 in_MaxCriminalRecords := iesp.Constants.AR.MaxCriminals : STORED('MaxCriminalRecords');
    shared unsigned2 in_MaxSexualOffenses := iesp.Constants.AR.MaxSexOffenders : STORED('MaxSexualOffenses');
    shared unsigned2 in_MaxHuntingandFishing:= iesp.Constants.AR.MaxHuntingandFishing : STORED('MaxHuntingAndFishingLicenses');
    shared unsigned2 in_MaxWeaponPermits := iesp.Constants.AR.MaxConcealedWeapons : STORED('MaxWeaponPermits');
    shared unsigned2 in_MaxRelatives := iesp.Constants.AR.MaxRelatives : STORED('MaxRelatives');
    shared unsigned2 in_MaxAssociates := iesp.Constants.AR.MaxAssociates : STORED('MaxAssociates');
    shared unsigned2 in_MaxOwners := iesp.Constants.AR.MaxOwners : STORED('MaxOwners');
  
    export unsigned2 MaxProperties := get_min(iesp.Constants.AR.MaxProperties ,in_MaxProperties);
    export unsigned2 MaxDLs := get_min(iesp.Constants.AR.MaxDLs ,in_MaxDLs);
    export unsigned2 MaxVehicles := get_min(iesp.Constants.AR.MaxVehicles ,in_MaxVehicles);
    export unsigned2 MaxBusiness := get_min(iesp.Constants.AR.MaxBusiness ,in_MaxBusiness);
    export unsigned2 MaxNeighbors := get_min(iesp.Constants.AR.MaxNeighbors ,in_MaxNeighbors);
    export unsigned2 MaxBankruptcies := get_min(iesp.Constants.AR.MaxBankruptcies ,in_MaxBankruptcies);
    export unsigned2 MaxPhonesRes := get_min(iesp.Constants.AR.MaxPhonesRes ,in_MaxPhonesRes);
    export unsigned2 MaxPhonesBus := get_min(iesp.Constants.AR.MaxPhonesBus ,in_MaxPhonesBus);
    export unsigned2 MaxResidents := get_min(iesp.Constants.AR.MaxResidents ,in_MaxResidents);
    export unsigned2 MaxLiens := get_min(iesp.Constants.AR.MaxLiens ,in_MaxLiens);
    export unsigned1 MaxRelatives := get_min(iesp.Constants.AR.MaxRelatives ,in_MaxRelatives);
    export unsigned1 MaxAssociates := get_min(iesp.Constants.AR.MaxAssociates ,in_MaxAssociates);
    export unsigned1 MaxOwners := get_min(iesp.Constants.AR.MaxOwners ,in_MaxOwners);
    export unsigned2 MaxCriminalRecords :=get_min(iesp.Constants.AR.MaxCriminals ,in_MaxCriminalRecords);
    export unsigned2 MaxSexualOffenses :=get_min(iesp.Constants.AR.MaxSexOffenders ,in_MaxSexualOffenses);
    export unsigned2 MaxHuntingandFishing := get_min(iesp.Constants.AR.MaxHuntingandFishing ,in_MaxHuntingandFishing);
    export unsigned2 MaxWeaponPermits := get_min(iesp.Constants.AR.MaxConcealedWeapons ,in_MaxWeaponPermits);
    
    export unsigned2 MaxRestrictions := iesp.Constants.AR.MaxRestrictions;
    export unsigned2 MaxEndorsements := iesp.Constants.AR.MaxEndorsements;
    export unsigned1 MaxProximity := 15;
    export unsigned1 MaxCountHRI := iesp.Constants.MaxCountHRI;
    export unsigned1 NPA := 4;
    export unsigned1 Neighbors_Per_NA := 4;
    export unsigned1 NeighborRecency := 4;

    export string msg (unsigned cnt, string sdataset) := FUNCTION
      return 'Maximum ' + cnt + ' ' + sdataset + ' returned.';
    end;
  
    shared unsigned TODAY_YYYYMM := (INTEGER)Std.Date.Today() DIV 100;
    shared unsigned ONE_YEAR := 100;
    export THRESHOLD_DATE_FOR_CURRENT_RESIDENCY := (TODAY_YYYYMM - ONE_YEAR);
    export THRESHOLD_DATE_FOR_CURRENT_BUSINESS := (TODAY_YYYYMM - ONE_YEAR);
    export DAYS_IN_YEAR := 365;
    
  EXPORT Clean_Street_Direction(string s) := FUNCTION
    Street_Direction_USPS := ['N','E','S','W','NE','SE','NW','SW'];
    
    Cleaned_Street_Direction := (string2) MAP(
      s IN Street_Direction_USPS => s,
      s IN ['NORTH'] => 'N',
      s IN ['EAST'] => 'E',
      s IN ['SOUTH'] => 'S',
      s IN ['WEST'] => 'W',
      s IN ['NORTHEAST'] => 'NE',
      s IN ['SOUTHEAST'] => 'SE',
      s IN ['NORTHWEST'] => 'NW',
      s IN ['SOUTHWEST'] => 'SW',
      s);
                                             
    RETURN Cleaned_Street_Direction;
  END;
                           
  EXPORT Clean_Street_Suffix(string s) := FUNCTION
    Street_Suffix_USPS := ['ALY','ANX','ARC','AVE','BYU','BCH','BND','BLF','BLFS','BTM','BLVD',
                           'BR','BRG','BRK','BRKS','BG','BGS','BYP','CP','CYN','CPE','CSWY','CTR',
                           'CTRS','CIR','CIRS','CLF','CLFS','CLB','CMN','CMNS','COR','CORS','CRSE',
                           'CT','CTS','CV','CVS','CRK','CRES','CRST','XING','XRD','XRDS','CURV',
                           'DL','DM','DV','DR','DRS','EST','ESTS','EXPY','EXT','EXTS','FALL','FLS',
                           'FRY','FLD','FLDS','FLT','FLTS','FRD','FRDS','FRST','FRG','FRGS','FRK',
                           'FRKS','FT','FWY','GDN','GDNS','GTWY','GLN','GLNS','GRN','GRNS','GRV',
                           'GRVS','HBR','HBRS','HVN','HTS','HWY','HL','HLS','HOLW','INLT','IS',
                           'ISS','ISLE','JCT','JCTS','KY','KYS','KNL','KNLS','LK','LKS','LAND',
                           'LNDG','LN','LGT','LGTS','LF','LCK','LCKS','LDG','LOOP','MALL','MNR',
                           'MNRS','MDW','MDWS','MEWS','ML','MLS','MSN','MTWY','MT','MTN','MTNS',
                           'NCK','ORCH','OVAL','OPAS','PARK','PKWY','PASS','PSGE','PATH','PIKE',
                           'PNE','PNES','PL','PLN','PLNS','PLZ','PT','PTS','PRT','PRTS','PR','RADL',
                           'RAMP','RNCH','RPD','RPDS','RST','RDG','RDGS','RIV','RD','RDS','RTE','ROW',
                           'RUE','RUN','SHL','SHLS','SHR','SHRS','SKWY','SPG','SPGS','SPUR','SQ','SQS',
                           'STA','STRA','STRM','ST','STS','SMT','TER','TRWY','TRCE','TRAK','TRFY',
                           'TRL','TRLR','TUNL','TPKE','UPAS','UN','UNS','VLY','VLYS','VIA','VW','VWS',
                           'VLG','VLGS','VL','VIS','WALK','WALL','WAY','WAYS','WL','WLS'];
                           
    Cleaned_Street_Suffix := (string4) MAP(
      s IN Street_Suffix_USPS => s,
      s IN ['ALLEE','ALLEY','ALLY'] => 'ALY',
      s IN ['ANEX','ANNEX','ANNX'] => 'ANX',
      s IN ['ARCADE'] => 'ARC',
      s IN ['AV','AVEN','AVENU','AVENUE','AVN','AVNUE','AVENIDA'] => 'AVE', // AVENIDA is Spanish for AVENUE
      s IN ['BAYOO','BAYOU'] => 'BYU',
      s IN ['BEACH'] => 'BCH',
      s IN ['BEND'] => 'BND',
      s IN ['BLUF','BLUFF'] => 'BLF',
      s IN ['BLUFFS'] => 'BLFS',
      s IN ['BOT','BOTTOM'] => 'BTM',
      s IN ['BOUL','BOULEVARD','BOULV'] => 'BLVD',
      s IN ['BRNCH','BRANCH'] => 'BR',
      s IN ['BRDGE','BRIDGE'] => 'BRG',
      s IN ['BROOK'] => 'BRK',
      s IN ['BROOKS'] => 'BRKS',
      s IN ['BURG'] => 'BG',
      s IN ['BURGS'] => 'BGS',
      s IN ['BYPA','BYPAS','BYPASS','BYPS'] => 'BYP',
      s IN ['CALLE'] => 'CLL', // CALLE is Spanish for STREET
      s IN ['CAMINITO'] => 'CMT', // CAMINITO is Spanish for LITTLE ROAD
      s IN ['CAMINO'] => 'CAM', // CAMINO is Spanish for ROAD
      s IN ['CAMP','CMP'] => 'CP',
      s IN ['CANYN','CANYON','CNYN'] => 'CYN',
      s IN ['CAPE'] => 'CPE',
      s IN ['CAUSEWAY','CAUSWAY'] => 'CSWY',
      s IN ['CEN','CENT','CENTER','CENTR','CENTRE','CNTER','CNTR'] => 'CTR',
      s IN ['CENTERS'] => 'CTRS',
      s IN ['CERRADA'] => 'CER', // CERRADA is Spanish for CLOSED
      s IN ['CIRC','CIRCL','CIRCLE','CRCL','CRCLE', 'CIRCULO'] => 'CIR', // CIRCULO is Spanish for CIRCLE
      s IN ['CIRCLES'] => 'CIRS',
      s IN ['CLIFF'] => 'CLF',
      s IN ['CLIFFS'] => 'CLFS',
      s IN ['CLUB'] => 'CLB',
      s IN ['COMMON'] => 'CMN',
      s IN ['COMMONS'] => 'CMNS',
      s IN ['CORNER'] => 'COR',
      s IN ['CORNERS'] => 'CORS',
      s IN ['COURSE'] => 'CRSE',
      s IN ['COURT'] => 'CT',
      s IN ['COURTS'] => 'CTS',
      s IN ['COVE'] => 'CV',
      s IN ['COVES'] => 'CVS',
      s IN ['CREEK'] => 'CRK',
      s IN ['CRESCENT','CRSENT','CRSNT'] => 'CRES',
      s IN ['CREST'] => 'CRST',
      s IN ['CROSSING','CRSSNG'] => 'XING',
      s IN ['CROSSROAD'] => 'XRD',
      s IN ['CROSSROADS'] => 'XRDS',
      s IN ['CURVE'] => 'CURV',
      s IN ['DALE'] => 'DL',
      s IN ['DAM'] => 'DM',
      s IN ['DIV','DIVIDE','DVD'] => 'DV',
      s IN ['DRIV','DRIVE','DRV'] => 'DR',
      s IN ['DRIVES'] => 'DRS',
      s IN ['ENTRADA'] => 'ENT', // ENTRADA is Spanish for ENTRANCE
      s IN ['ESTATE'] => 'EST',
      s IN ['ESTATES'] => 'ESTS',
      s IN ['EXP','EXPR','EXPRESS','EXPRESSWAY','EXPW'] => 'EXPY',
      s IN ['EXTENSION','EXTN','EXTNSN'] => 'EXT',
      s IN ['EXTENSIONS'] => 'EXTS',
      // => 'FALL' - Already Clean
      s IN ['FALLS'] => 'FLS',
      s IN ['FERRY','FRRY'] => 'FRY',
      s IN ['FIELD'] => 'FLD',
      s IN ['FIELDS'] => 'FLDS',
      s IN ['FLAT'] => 'FLT',
      s IN ['FLATS'] => 'FLTS',
      s IN ['FORD'] => 'FRD',
      s IN ['FORDS'] => 'FRDS',
      s IN ['FOREST','FORESTS'] => 'FRST',
      s IN ['FORG','FORGE'] => 'FRG',
      s IN ['FORGES'] => 'FRGS',
      s IN ['FORK'] => 'FRK',
      s IN ['FORKS'] => 'FRKS',
      s IN ['FORT','FRT'] => 'FT',
      s IN ['FREEWAY','FREEWY','FRWAY','FRWY'] => 'FWY',
      s IN ['GARDEN','GARDN','GRDEN','GRDN'] => 'GDN',
      s IN ['GARDENS','GRDNS'] => 'GDNS',
      s IN ['GATEWAY','GATEWY','GATWAY','GTWAY'] => 'GTWY',
      s IN ['GLEN'] => 'GLN',
      s IN ['GLENS'] => 'GLNS',
      s IN ['GREEN'] => 'GRN',
      s IN ['GREENS'] => 'GRNS',
      s IN ['GROV','GROVE'] => 'GRV',
      s IN ['GROVES'] => 'GRVS',
      s IN ['HARB','HARBOR','HARBR','HRBOR'] => 'HBR',
      s IN ['HARBORS'] => 'HBRS',
      s IN ['HAVEN'] => 'HVN',
      s IN ['HEIGHTS','HT'] => 'HTS',
      s IN ['HIGHWAY','HIGHWY','HIWAY','HIWY','HWAY'] => 'HWY',
      s IN ['HILL'] => 'HL',
      s IN ['HILLS'] => 'HLS',
      s IN ['HLLW','HOLLOW','HOLLOWS','HOLWS'] => 'HOLW',
      s IN ['INLET'] => 'INLT',
      s IN ['ISLAND','ISLND'] => 'IS',
      s IN ['ISLANDS','ISLNDS'] => 'ISS',
      s IN ['ISLES'] => 'ISLE',
      s IN ['JCTION','JCTN','JUNCTION','JUNCTN','JUNCTION'] => 'JCT',
      s IN ['JCTNS','JUNCTIONS'] => 'JCTS',
      s IN ['KEY'] => 'KY',
      s IN ['KEYS'] => 'KYS',
      s IN ['KNOL','KNOLL'] => 'KNL',
      s IN ['KNOLLS'] => 'KNLS',
      s IN ['LAKE'] => 'LK',
      s IN ['LAKES'] => 'LKS',
      // => 'LAND' - Already Clean
      s IN ['LANDING','LNDNG'] => 'LNDG',
      s IN ['LANE'] => 'LN',
      s IN ['LIGHT'] => 'LGT',
      s IN ['LIGHTS'] => 'LGTS',
      s IN ['LOAF'] => 'LF',
      s IN ['LOCK'] => 'LCK',
      s IN ['LOCKS'] => 'LCKS',
      s IN ['LDGE','LODG','LODGE'] => 'LDG',
      s IN ['LOOPS'] => 'LOOP',
      // => 'MALL' - Already Clean
      s IN ['MANOR'] => 'MNR',
      s IN ['MANORS'] => 'MNRS',
      s IN ['MEADOW','MDW'] => 'MDW',
      s IN ['MEADOWS','MEDOWS'] => 'MDWS',
      // => 'MEWS' - Already Clean
      s IN ['MILL'] => 'ML',
      s IN ['MILLS'] => 'MLS',
      s IN ['MISSION','MISSN','MSSN'] => 'MSN',
      s IN ['MOTORWAY'] => 'MTWY',
      s IN ['MNT','MOUNT'] => 'MT',
      s IN ['MNTAIN','MNTN','MOUNTAIN','MOUNTIN','MTIN'] => 'MTN',
      s IN ['MNTNS','MOUNTAINS'] => 'MTNS',
      s IN ['NECK'] => 'NCK',
      s IN ['ORCHARD','ORCHRD'] => 'ORCH',
      s IN ['OVL'] => 'OVAL',
      s IN ['OVERPASS'] => 'OPAS',
      // => 'PASS' - Already Clean
      s IN ['PRK','PARKS'] => 'PARK',
      s IN ['PARKWAY','PARKWY','PKWAY','PKY','PARKWAYS','PKWYS'] => 'PKWY',
      s IN ['PASEO'] => 'PSO', // PASEO is Spanish for PATH
      s IN ['PASSAGE'] => 'PSGE',
      s IN ['PATHS'] => 'PATH',
      s IN ['PIKES'] => 'PIKE',
      s IN ['PINE'] => 'PNE',
      s IN ['PINES'] => 'PNES',
      s IN ['PLACE'] => 'PL',
      s IN ['PLACITA'] => 'PLA', // PLACITA is Spanish for LITTLE PLAZA
      s IN ['PLAIN'] => 'PLN',
      s IN ['PLAINS'] => 'PLNS',
      s IN ['PLAZA','PLZA'] => 'PLZ',
      s IN ['POINT'] => 'PT',
      s IN ['POINTS'] => 'PTS',
      s IN ['PORT'] => 'PRT',
      s IN ['PORTS'] => 'PRTS',
      s IN ['PRAIRIE','PRR'] => 'PR',
      s IN ['RAD','RADIAL','RADIEL'] => 'RADL',
      // => 'RAMP' - Already Clean
      s IN ['RANCH','RANCHES','RNCHS'] => 'RNCH',
      s IN ['RANCHO'] => 'RCH', // RANCHO is Spanish for RANCH
      s IN ['RAPID'] => 'RPD',
      s IN ['RAPIDS'] => 'RPDS',
      s IN ['REST'] => 'RST',
      s IN ['RDGE','RIDGE'] => 'RDG',
      s IN ['RIDGES'] => 'RDGS',
      s IN ['RIVER','RVR','RIVR'] => 'RIV',
      s IN ['ROAD'] => 'RD',
      s IN ['ROADS'] => 'RDS',
      s IN ['ROUTE'] => 'RTE',
      // => 'ROW' - Already Clean
      // => 'RUE' - Already Clean
      // => 'RUN' - Already Clean
      s IN ['SHOAL'] => 'SHL',
      s IN ['SHOALS'] => 'SHLS',
      s IN ['SHOAR','SHORE'] => 'SHR',
      s IN ['SHOARS','SHORES'] => 'SHRS',
      s IN ['SKYWAY'] => 'SKWY',
      s IN ['SPNG','SPRING','SPRNG'] => 'SPG',
      s IN ['SPNGS','SPRINGS','SPRNGS'] => 'SPGS',
      s IN ['SPURS'] => 'SPUR',
      s IN ['SQR','SQRE','SQU','SQUARE'] => 'SQ',
      s IN ['SQRS','SQUARES'] => 'SQS',
      s IN ['STATION','STATN','STN'] => 'STA',
      s IN ['STRAV','STRAVEN','STRAVENUE','STRAVN','STRVN','STRVNUE'] => 'STRA',
      s IN ['STREAM','STREME'] => 'STRM',
      s IN ['STREET','STRT','STR'] => 'ST',
      s IN ['STREETS'] => 'STS',
      s IN ['SUMIT','SUMITT','SUMMIT'] => 'SMT',
      s IN ['TERR','TERRACE'] => 'TER',
      s IN ['THROUGHWAY'] => 'TRWY',
      s IN ['TRACE','TRACES'] => 'TRCE',
      s IN ['TRACK','TRACKS','TRK','TRKS'] => 'TRAK',
      s IN ['TRAFFICWAY'] => 'TRFY',
      s IN ['TRAIL','TRAILS','TRLS'] => 'TRL',
      s IN ['TRAILER','TRLRS','TRAILERS'] => 'TRLR',
      s IN ['TUNEL','TUNLS','TUNNEL','TUNNELS','TUNNL'] => 'TUNL',
      s IN ['TRNPK','TURNPIKE','TURNPK'] => 'TPKE',
      s IN ['UNDERPASS'] => 'UPAS',
      s IN ['UNION'] => 'UN',
      s IN ['UNIONS'] => 'UNS',
      s IN ['VALLEY','VALLY','VLLY'] => 'VLY',
      s IN ['VALLEYS'] => 'VLYS',
      s IN ['VEREDA'] => 'VER', // VEREDA is Spanish for SMALL PATH
      s IN ['VDCT','VIADCT','VIADUCT'] => 'VIA',
      s IN ['VIEW'] => 'VW',
      s IN ['VIEWS'] => 'VWS',
      s IN ['VILL','VILLAG','VILLAGE','VLLG','VILLIAGE'] => 'VLG',
      s IN ['VILLAGES'] => 'VLGS',
      s IN ['VILLE'] => 'VL',
      s IN ['VIST','VISTA','VST','VSTA'] => 'VIS', // VISTA is also Spanish for VIEW
      s IN ['WALKS'] => 'WALK',
      // => 'WALL' - Already Clean
      s IN ['WY'] => 'WAY',
      // => 'WAYS' - Already Clean
      s IN ['WELL'] => 'WL',
      s IN ['WELLS'] => 'WLS',
      s);
    
    RETURN Cleaned_Street_Suffix;
  END;
END;
