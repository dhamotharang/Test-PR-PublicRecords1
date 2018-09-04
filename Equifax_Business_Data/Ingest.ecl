IMPORT SALT37,Equifax_Business_Data;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Equifax_Business_Data.Layouts.Base) Delta = DATASET([],Equifax_Business_Data.Layouts.Base) //default empty file
, DATASET(Equifax_Business_Data.Layouts.Base) dsBase 
, DATASET(Equifax_Business_Data.Layouts.Base) infile 
) := MODULE

 SHARED NullFile := DATASET([],Equifax_Business_Data.Layouts.Base); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  In_Src_Cnt_Rec := RECORD
    FilesToIngest.source;
    UNSIGNED Cnt := COUNT(GROUP);
  END;
  EXPORT InputSourceCounts := TABLE(FilesToIngest,In_Src_Cnt_Rec,source,FEW);
  SHARED S0 := OUTPUT(InputSourceCounts,ALL,NAMED('InputSourceCounts'));
// Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layout_Base;
    BOOLEAN seleidChange := FALSE;
    BOOLEAN hardDeleteAdded := FALSE;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.dt_effective_first := MAP ( le.__Tpe = 0 OR (unsigned)le.dt_effective_first = 0 => ri.dt_effective_first,
                     ri.__Tpe = 0 OR (unsigned)ri.dt_effective_first = 0 => le.dt_effective_first,
                     (unsigned)le.dt_effective_first < (unsigned)ri.dt_effective_first => le.dt_effective_first, // Want the lowest non-zero value
                     ri.dt_effective_first);
    SELF.dt_effective_last := MAP ( le.__Tpe = 0 => ri.dt_effective_last,
                     ri.__Tpe = 0 => le.dt_effective_last,
                     (unsigned)le.dt_effective_last < (unsigned)ri.dt_effective_last => ri.dt_effective_last, // Want the highest value
                     le.dt_effective_last);
    SELF.process_date := ri.process_date; // Derived(NEW)
    SELF.dotid := ri.dotid; // Derived(NEW)
    SELF.dotscore := ri.dotscore; // Derived(NEW)
    SELF.dotweight := ri.dotweight; // Derived(NEW)
    SELF.empid := ri.empid; // Derived(NEW)
    SELF.empscore := ri.empscore; // Derived(NEW)
    SELF.empweight := ri.empweight; // Derived(NEW)
    SELF.powid := ri.powid; // Derived(NEW)
    SELF.powscore := ri.powscore; // Derived(NEW)
    SELF.powweight := ri.powweight; // Derived(NEW)
    SELF.proxid := ri.proxid; // Derived(NEW)
    SELF.proxscore := ri.proxscore; // Derived(NEW)
    SELF.proxweight := ri.proxweight; // Derived(NEW)
    SELF.selescore := ri.selescore; // Derived(NEW)
    SELF.seleweight := ri.seleweight; // Derived(NEW)
    SELF.orgid := ri.orgid; // Derived(NEW)
    SELF.orgscore := ri.orgscore; // Derived(NEW)
    SELF.orgweight := ri.orgweight; // Derived(NEW)
    SELF.ultid := ri.ultid; // Derived(NEW)
    SELF.ultscore := ri.ultscore; // Derived(NEW)
    SELF.ultweight := ri.ultweight; // Derived(NEW)
    SELF.dt_first_seen := ri.dt_first_seen; // Derived(NEW)
    SELF.dt_last_seen := ri.dt_last_seen; // Derived(NEW)
    SELF.dt_vendor_first_reported := ri.dt_vendor_first_reported; // Derived(NEW)
    SELF.dt_vendor_last_reported := ri.dt_vendor_last_reported; // Derived(NEW)
    SELF.record_type := ri.record_type; // Derived(NEW)
    SELF.clean_company_name := ri.clean_company_name; // Derived(NEW)
    SELF.clean_phone := ri.clean_phone; // Derived(NEW)
    SELF.clean_secondary_phone := ri.clean_secondary_phone; // Derived(NEW)
    SELF.prim_range := ri.prim_range; // Derived(NEW)
    SELF.predir := ri.predir; // Derived(NEW)
    SELF.prim_name := ri.prim_name; // Derived(NEW)
    SELF.addr_suffix := ri.addr_suffix; // Derived(NEW)
    SELF.postdir := ri.postdir; // Derived(NEW)
    SELF.unit_desig := ri.unit_desig; // Derived(NEW)
    SELF.sec_range := ri.sec_range; // Derived(NEW)
    SELF.p_city_name := ri.p_city_name; // Derived(NEW)
    SELF.v_city_name := ri.v_city_name; // Derived(NEW)
    SELF.st := ri.st; // Derived(NEW)
    SELF.cart := ri.cart; // Derived(NEW)
    SELF.cr_sort_sz := ri.cr_sort_sz; // Derived(NEW)
    SELF.hardDeleteAdded := le.dt_effective_last = 0 AND ri.dt_effective_last > 0 AND le.__Tpe <> RecordType.New AND ri.__Tpe = RecordType.New;
    SELF.seleidChange := ~SELF.hardDeleteAdded AND incremental AND le.seleid > 0 AND ri.seleid > 0 AND le.seleid <> ri.seleid AND le.__Tpe <> RecordType.New AND ri.__Tpe = RecordType.New;
    SELF.seleid := MAP(~incremental OR SELF.hardDeleteAdded => le.seleid,
                   SELF.seleidChange => ri.seleid,
                   ri.seleid > 0 => ri.seleid,
                   le.seleid);
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.dt_effective_first <> le.dt_effective_first OR SELF.dt_effective_last <> le.dt_effective_last => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := IF(__Tpe0 <> RecordType.New AND (SELF.hardDeleteAdded OR SELF.seleidChange), RecordType.Updated, __Tpe0);
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  GroupIngest0 := GROUP( FilesToIngest0,EFX_ID
             ,EFX_NAME,EFX_LEGAL_NAME,EFX_ADDRESS,EFX_CITY,EFX_STATE,EFX_STATEC,EFX_ZIPCODE,EFX_ZIP4,EFX_LAT,EFX_LON
             ,EFX_GEOPREC,EFX_REGION,EFX_CTRYISOCD,EFX_CTRYNUM,EFX_CTRYNAME,EFX_COUNTYNM,EFX_COUNTY,EFX_CMSA,EFX_CMSADESC,EFX_SOHO
             ,EFX_BIZ,EFX_RES,EFX_CMRA,EFX_CONGRESS,EFX_SECADR,EFX_SECCTY,EFX_SECSTAT,EFX_STATEC2,EFX_SECZIP,EFX_SECZIP4
             ,EFX_SECLAT,EFX_SECLON,EFX_SECGEOPREC,EFX_SECREGION,EFX_SECCTRYISOCD,EFX_SECCTRYNUM,EFX_SECCTRYNAME,EFX_CTRYTELCD,EFX_PHONE,EFX_FAXPHONE
             ,EFX_BUSSTAT,EFX_BUSSTATCD,EFX_WEB,EFX_YREST,EFX_CORPEMPCNT,EFX_LOCEMPCNT,EFX_CORPEMPCD,EFX_LOCEMPCD,EFX_CORPAMOUNT,EFX_CORPAMOUNTCD
             ,EFX_CORPAMOUNTTP,EFX_CORPAMOUNTPREC,EFX_LOCAMOUNT,EFX_LOCAMOUNTCD,EFX_LOCAMOUNTTP,EFX_LOCAMOUNTPREC,EFX_PUBLIC,EFX_STKEXC,EFX_TCKSYM,EFX_PRIMSIC
             ,EFX_SECSIC1,EFX_SECSIC2,EFX_SECSIC3,EFX_SECSIC4,EFX_PRIMSICDESC,EFX_SECSICDESC1,EFX_SECSICDESC2,EFX_SECSICDESC3,EFX_SECSICDESC4,EFX_PRIMNAICSCODE
             ,EFX_SECNAICS1,EFX_SECNAICS2,EFX_SECNAICS3,EFX_SECNAICS4,EFX_PRIMNAICSDESC,EFX_SECNAICSDESC1,EFX_SECNAICSDESC2,EFX_SECNAICSDESC3,EFX_SECNAICSDESC4,EFX_DEAD
             ,EFX_DEADDT,EFX_MRKT_TELEVER,EFX_MRKT_TELESCORE,EFX_MRKT_TOTALSCORE,EFX_MRKT_TOTALIND,EFX_MRKT_VACANT,EFX_MRKT_SEASONAL,EFX_MBE,EFX_WBE,EFX_MWBE
             ,EFX_SDB,EFX_HUBZONE,EFX_DBE,EFX_VET,EFX_DVET,EFX_8a,EFX_8aEXPDT,EFX_DIS,EFX_SBE,EFX_BUSSIZE
             ,EFX_LBE,EFX_GOV,EFX_FGOV,EFX_GOV1057,EFX_NONPROFIT,EFX_MERCTYPE,EFX_HBCU,EFX_GAYLESBIAN,EFX_WSBE,EFX_VSBE
             ,EFX_DVSBE,EFX_MWBESTATUS,EFX_NMSDC,EFX_WBENC,EFX_CA_PUC,EFX_TX_HUB,EFX_TX_HUBCERTNUM,EFX_GSAX,EFX_CALTRANS,EFX_EDU
             ,EFX_MI,EFX_ANC,AT_CERT1,AT_CERT2,AT_CERT3,AT_CERT4,AT_CERT5,AT_CERT6,AT_CERT7,AT_CERT8
             ,AT_CERT9,AT_CERT10,AT_CERTDESC1,AT_CERTDESC2,AT_CERTDESC3,AT_CERTDESC4,AT_CERTDESC5,AT_CERTDESC6,AT_CERTDESC7,AT_CERTDESC8
             ,AT_CERTDESC9,AT_CERTDESC10,AT_CERTSRC1,AT_CERTSRC2,AT_CERTSRC3,AT_CERTSRC4,AT_CERTSRC5,AT_CERTSRC6,AT_CERTSRC7,AT_CERTSRC8
             ,AT_CERTSRC9,AT_CERTSRC10,AT_CERTLEV1,AT_CERTLEV2,AT_CERTLEV3,AT_CERTLEV4,AT_CERTLEV5,AT_CERTLEV6,AT_CERTLEV7,AT_CERTLEV8
             ,AT_CERTLEV9,AT_CERTLEV10,AT_CERTNUM1,AT_CERTNUM2,AT_CERTNUM3,AT_CERTNUM4,AT_CERTNUM5,AT_CERTNUM6,AT_CERTNUM7,AT_CERTNUM8
             ,AT_CERTNUM9,AT_CERTNUM10,AT_CERTEXP1,AT_CERTEXP2,AT_CERTEXP3,AT_CERTEXP4,AT_CERTEXP5,AT_CERTEXP6,AT_CERTEXP7,AT_CERTEXP8
             ,AT_CERTEXP9,AT_CERTEXP10,EFX_EXTRACT_DATE,EFX_MERCHANT_ID,EFX_PROJECT_ID,EFX_FOREIGN,Record_Update_Refresh_Date,EFX_DATE_CREATED,normCompany_Name,normCompany_Type
             ,Norm_Geo_Precision,Exploded_Desc_Corporate_Amount_Precision,Exploded_Desc_Location_Amount_Precision,Exploded_Desc_Public_Co_Indicator,Exploded_Desc_Stock_Exchange,Exploded_Desc_Telemarketablity_Score,Exploded_Desc_Telemarketablity_Total_Indicator,Exploded_Desc_Telemarketablity_Total_Score,Exploded_Desc_Government1057_Entity,Exploded_Desc_Merchant_Type
             ,Exploded_Desc_Busstatcd,Exploded_Desc_CMSA,Exploded_Desc_Corpamountcd,Exploded_Desc_Corpamountprec,Exploded_Desc_Corpamounttp,Exploded_Desc_Corpempcd,Exploded_Desc_Ctrytelcd,NormAddress_Type,Norm_Address,Norm_City
             ,Norm_State,Norm_StateC2,Norm_Zip,Norm_Zip4,Norm_Lat,Norm_Lon,Norm_Geoprec,Norm_Region,Norm_Ctryisocd,Norm_Ctrynum
             ,Norm_Ctryname,ALL);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP( SORT( GroupIngest0,__Tpe,rcid,seleid),TRUE,MergeData(LEFT,RIGHT)));
  // Existing Base: combine delta with base file
  GroupBase0 := GROUP( SALT37.MAC_DatasetAsOf(Base0+Delta0,rcid,seleid,,dt_effective_first,dt_effective_last,,'YYYYMMDD',TRUE),EFX_ID
             ,EFX_NAME,EFX_LEGAL_NAME,EFX_ADDRESS,EFX_CITY,EFX_STATE,EFX_STATEC,EFX_ZIPCODE,EFX_ZIP4,EFX_LAT,EFX_LON
             ,EFX_GEOPREC,EFX_REGION,EFX_CTRYISOCD,EFX_CTRYNUM,EFX_CTRYNAME,EFX_COUNTYNM,EFX_COUNTY,EFX_CMSA,EFX_CMSADESC,EFX_SOHO
             ,EFX_BIZ,EFX_RES,EFX_CMRA,EFX_CONGRESS,EFX_SECADR,EFX_SECCTY,EFX_SECSTAT,EFX_STATEC2,EFX_SECZIP,EFX_SECZIP4
             ,EFX_SECLAT,EFX_SECLON,EFX_SECGEOPREC,EFX_SECREGION,EFX_SECCTRYISOCD,EFX_SECCTRYNUM,EFX_SECCTRYNAME,EFX_CTRYTELCD,EFX_PHONE,EFX_FAXPHONE
             ,EFX_BUSSTAT,EFX_BUSSTATCD,EFX_WEB,EFX_YREST,EFX_CORPEMPCNT,EFX_LOCEMPCNT,EFX_CORPEMPCD,EFX_LOCEMPCD,EFX_CORPAMOUNT,EFX_CORPAMOUNTCD
             ,EFX_CORPAMOUNTTP,EFX_CORPAMOUNTPREC,EFX_LOCAMOUNT,EFX_LOCAMOUNTCD,EFX_LOCAMOUNTTP,EFX_LOCAMOUNTPREC,EFX_PUBLIC,EFX_STKEXC,EFX_TCKSYM,EFX_PRIMSIC
             ,EFX_SECSIC1,EFX_SECSIC2,EFX_SECSIC3,EFX_SECSIC4,EFX_PRIMSICDESC,EFX_SECSICDESC1,EFX_SECSICDESC2,EFX_SECSICDESC3,EFX_SECSICDESC4,EFX_PRIMNAICSCODE
             ,EFX_SECNAICS1,EFX_SECNAICS2,EFX_SECNAICS3,EFX_SECNAICS4,EFX_PRIMNAICSDESC,EFX_SECNAICSDESC1,EFX_SECNAICSDESC2,EFX_SECNAICSDESC3,EFX_SECNAICSDESC4,EFX_DEAD
             ,EFX_DEADDT,EFX_MRKT_TELEVER,EFX_MRKT_TELESCORE,EFX_MRKT_TOTALSCORE,EFX_MRKT_TOTALIND,EFX_MRKT_VACANT,EFX_MRKT_SEASONAL,EFX_MBE,EFX_WBE,EFX_MWBE
             ,EFX_SDB,EFX_HUBZONE,EFX_DBE,EFX_VET,EFX_DVET,EFX_8a,EFX_8aEXPDT,EFX_DIS,EFX_SBE,EFX_BUSSIZE
             ,EFX_LBE,EFX_GOV,EFX_FGOV,EFX_GOV1057,EFX_NONPROFIT,EFX_MERCTYPE,EFX_HBCU,EFX_GAYLESBIAN,EFX_WSBE,EFX_VSBE
             ,EFX_DVSBE,EFX_MWBESTATUS,EFX_NMSDC,EFX_WBENC,EFX_CA_PUC,EFX_TX_HUB,EFX_TX_HUBCERTNUM,EFX_GSAX,EFX_CALTRANS,EFX_EDU
             ,EFX_MI,EFX_ANC,AT_CERT1,AT_CERT2,AT_CERT3,AT_CERT4,AT_CERT5,AT_CERT6,AT_CERT7,AT_CERT8
             ,AT_CERT9,AT_CERT10,AT_CERTDESC1,AT_CERTDESC2,AT_CERTDESC3,AT_CERTDESC4,AT_CERTDESC5,AT_CERTDESC6,AT_CERTDESC7,AT_CERTDESC8
             ,AT_CERTDESC9,AT_CERTDESC10,AT_CERTSRC1,AT_CERTSRC2,AT_CERTSRC3,AT_CERTSRC4,AT_CERTSRC5,AT_CERTSRC6,AT_CERTSRC7,AT_CERTSRC8
             ,AT_CERTSRC9,AT_CERTSRC10,AT_CERTLEV1,AT_CERTLEV2,AT_CERTLEV3,AT_CERTLEV4,AT_CERTLEV5,AT_CERTLEV6,AT_CERTLEV7,AT_CERTLEV8
             ,AT_CERTLEV9,AT_CERTLEV10,AT_CERTNUM1,AT_CERTNUM2,AT_CERTNUM3,AT_CERTNUM4,AT_CERTNUM5,AT_CERTNUM6,AT_CERTNUM7,AT_CERTNUM8
             ,AT_CERTNUM9,AT_CERTNUM10,AT_CERTEXP1,AT_CERTEXP2,AT_CERTEXP3,AT_CERTEXP4,AT_CERTEXP5,AT_CERTEXP6,AT_CERTEXP7,AT_CERTEXP8
             ,AT_CERTEXP9,AT_CERTEXP10,EFX_EXTRACT_DATE,EFX_MERCHANT_ID,EFX_PROJECT_ID,EFX_FOREIGN,Record_Update_Refresh_Date,EFX_DATE_CREATED,normCompany_Name,normCompany_Type
             ,Norm_Geo_Precision,Exploded_Desc_Corporate_Amount_Precision,Exploded_Desc_Location_Amount_Precision,Exploded_Desc_Public_Co_Indicator,Exploded_Desc_Stock_Exchange,Exploded_Desc_Telemarketablity_Score,Exploded_Desc_Telemarketablity_Total_Indicator,Exploded_Desc_Telemarketablity_Total_Score,Exploded_Desc_Government1057_Entity,Exploded_Desc_Merchant_Type
             ,Exploded_Desc_Busstatcd,Exploded_Desc_CMSA,Exploded_Desc_Corpamountcd,Exploded_Desc_Corpamountprec,Exploded_Desc_Corpamounttp,Exploded_Desc_Corpempcd,Exploded_Desc_Ctrytelcd,NormAddress_Type,Norm_Address,Norm_City
             ,Norm_State,Norm_StateC2,Norm_Zip,Norm_Zip4,Norm_Lat,Norm_Lon,Norm_Geoprec,Norm_Region,Norm_Ctryisocd,Norm_Ctrynum
             ,Norm_Ctryname,ALL);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP( SORT( GroupBase0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
 
  Group0 := GROUP( AllBaseRecs0+AllIngestRecs0,EFX_ID
             ,EFX_NAME,EFX_LEGAL_NAME,EFX_ADDRESS,EFX_CITY,EFX_STATE,EFX_STATEC,EFX_ZIPCODE,EFX_ZIP4,EFX_LAT,EFX_LON
             ,EFX_GEOPREC,EFX_REGION,EFX_CTRYISOCD,EFX_CTRYNUM,EFX_CTRYNAME,EFX_COUNTYNM,EFX_COUNTY,EFX_CMSA,EFX_CMSADESC,EFX_SOHO
             ,EFX_BIZ,EFX_RES,EFX_CMRA,EFX_CONGRESS,EFX_SECADR,EFX_SECCTY,EFX_SECSTAT,EFX_STATEC2,EFX_SECZIP,EFX_SECZIP4
             ,EFX_SECLAT,EFX_SECLON,EFX_SECGEOPREC,EFX_SECREGION,EFX_SECCTRYISOCD,EFX_SECCTRYNUM,EFX_SECCTRYNAME,EFX_CTRYTELCD,EFX_PHONE,EFX_FAXPHONE
             ,EFX_BUSSTAT,EFX_BUSSTATCD,EFX_WEB,EFX_YREST,EFX_CORPEMPCNT,EFX_LOCEMPCNT,EFX_CORPEMPCD,EFX_LOCEMPCD,EFX_CORPAMOUNT,EFX_CORPAMOUNTCD
             ,EFX_CORPAMOUNTTP,EFX_CORPAMOUNTPREC,EFX_LOCAMOUNT,EFX_LOCAMOUNTCD,EFX_LOCAMOUNTTP,EFX_LOCAMOUNTPREC,EFX_PUBLIC,EFX_STKEXC,EFX_TCKSYM,EFX_PRIMSIC
             ,EFX_SECSIC1,EFX_SECSIC2,EFX_SECSIC3,EFX_SECSIC4,EFX_PRIMSICDESC,EFX_SECSICDESC1,EFX_SECSICDESC2,EFX_SECSICDESC3,EFX_SECSICDESC4,EFX_PRIMNAICSCODE
             ,EFX_SECNAICS1,EFX_SECNAICS2,EFX_SECNAICS3,EFX_SECNAICS4,EFX_PRIMNAICSDESC,EFX_SECNAICSDESC1,EFX_SECNAICSDESC2,EFX_SECNAICSDESC3,EFX_SECNAICSDESC4,EFX_DEAD
             ,EFX_DEADDT,EFX_MRKT_TELEVER,EFX_MRKT_TELESCORE,EFX_MRKT_TOTALSCORE,EFX_MRKT_TOTALIND,EFX_MRKT_VACANT,EFX_MRKT_SEASONAL,EFX_MBE,EFX_WBE,EFX_MWBE
             ,EFX_SDB,EFX_HUBZONE,EFX_DBE,EFX_VET,EFX_DVET,EFX_8a,EFX_8aEXPDT,EFX_DIS,EFX_SBE,EFX_BUSSIZE
             ,EFX_LBE,EFX_GOV,EFX_FGOV,EFX_GOV1057,EFX_NONPROFIT,EFX_MERCTYPE,EFX_HBCU,EFX_GAYLESBIAN,EFX_WSBE,EFX_VSBE
             ,EFX_DVSBE,EFX_MWBESTATUS,EFX_NMSDC,EFX_WBENC,EFX_CA_PUC,EFX_TX_HUB,EFX_TX_HUBCERTNUM,EFX_GSAX,EFX_CALTRANS,EFX_EDU
             ,EFX_MI,EFX_ANC,AT_CERT1,AT_CERT2,AT_CERT3,AT_CERT4,AT_CERT5,AT_CERT6,AT_CERT7,AT_CERT8
             ,AT_CERT9,AT_CERT10,AT_CERTDESC1,AT_CERTDESC2,AT_CERTDESC3,AT_CERTDESC4,AT_CERTDESC5,AT_CERTDESC6,AT_CERTDESC7,AT_CERTDESC8
             ,AT_CERTDESC9,AT_CERTDESC10,AT_CERTSRC1,AT_CERTSRC2,AT_CERTSRC3,AT_CERTSRC4,AT_CERTSRC5,AT_CERTSRC6,AT_CERTSRC7,AT_CERTSRC8
             ,AT_CERTSRC9,AT_CERTSRC10,AT_CERTLEV1,AT_CERTLEV2,AT_CERTLEV3,AT_CERTLEV4,AT_CERTLEV5,AT_CERTLEV6,AT_CERTLEV7,AT_CERTLEV8
             ,AT_CERTLEV9,AT_CERTLEV10,AT_CERTNUM1,AT_CERTNUM2,AT_CERTNUM3,AT_CERTNUM4,AT_CERTNUM5,AT_CERTNUM6,AT_CERTNUM7,AT_CERTNUM8
             ,AT_CERTNUM9,AT_CERTNUM10,AT_CERTEXP1,AT_CERTEXP2,AT_CERTEXP3,AT_CERTEXP4,AT_CERTEXP5,AT_CERTEXP6,AT_CERTEXP7,AT_CERTEXP8
             ,AT_CERTEXP9,AT_CERTEXP10,EFX_EXTRACT_DATE,EFX_MERCHANT_ID,EFX_PROJECT_ID,EFX_FOREIGN,Record_Update_Refresh_Date,EFX_DATE_CREATED,normCompany_Name,normCompany_Type
             ,Norm_Geo_Precision,Exploded_Desc_Corporate_Amount_Precision,Exploded_Desc_Location_Amount_Precision,Exploded_Desc_Public_Co_Indicator,Exploded_Desc_Stock_Exchange,Exploded_Desc_Telemarketablity_Score,Exploded_Desc_Telemarketablity_Total_Indicator,Exploded_Desc_Telemarketablity_Total_Score,Exploded_Desc_Government1057_Entity,Exploded_Desc_Merchant_Type
             ,Exploded_Desc_Busstatcd,Exploded_Desc_CMSA,Exploded_Desc_Corpamountcd,Exploded_Desc_Corpamountprec,Exploded_Desc_Corpamounttp,Exploded_Desc_Corpempcd,Exploded_Desc_Ctrytelcd,NormAddress_Type,Norm_Address,Norm_City
             ,Norm_State,Norm_StateC2,Norm_Zip,Norm_Zip4,Norm_Lat,Norm_Lon,Norm_Geoprec,Norm_Region,Norm_Ctryisocd,Norm_Ctrynum
             ,Norm_Ctryname,ALL);
  SHARED AllRecs0 := UNGROUP(ROLLUP( SORT( Group0,__Tpe,rcid),TRUE,MergeData(LEFT,RIGHT)));
// seleid changed records
  seleidChangeNewRecs  := AllRecs0(seleidChange);
  seleidChangePrevRecs := JOIN(AllBaseRecs0, seleidChangeNewRecs, LEFT.rcid = RIGHT.rcid, TRANSFORM(LEFT), HASH);
  seleidChangeAll0     := SALT37.MAC_PoisonRecords(seleidChangePrevRecs, seleidChangeNewRecs, 'seleid,rcid', dt_effective_first, dt_effective_last, 'YYYYMMDD');
  SHARED seleidChangeAll      := PROJECT(seleidChangeAll0, TRANSFORM(RECORDOF(LEFT), SELF.__Tpe := RecordType.Updated, SELF := LEFT));
  // Hard delete records (other than from seleid change)
  SHARED HardDeleteRecs := AllRecs0(__Tpe=RecordType.Updated AND hardDeleteAdded);
//Now need to update 'rid' numbers on new records
//Base upon SALT37.utMac_Sequence_Records
// Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,rcid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.rcid := IF ( le.rcid=0, PrevBase+1+thorlib.node(), le.rcid+thorlib.nodes() );
    SELF.seleid := SELF.rcid; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NR1 := ITERATE(NR(rcid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(rcid<>0) : PERSIST('~temp::seleid::Equifax_Business_Data::Ingest_Cache',EXPIRE(Equifax_Business_Data.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT37.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  UpdateStats_HardDelete := TABLE(HardDeleteRecs, {__Tpe,SALT37.StrType INGESTSTATUS:='HardDeleteOnly',UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW);
  UpdateStats_seleidChanges := TABLE(seleidChangeAll, {__Tpe,SALT37.StrType INGESTSTATUS:='HardDeleteEntityChange',UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New) & UpdateStats_HardDelete & UpdateStats_seleidChanges, __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S1 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
  SHARED UpdateStatsSrcFull := SORT(TABLE(AllRecs, {source,__Tpe,SALT37.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, source,__Tpe, FEW),source,__Tpe, FEW);
  UpdateStatsSrc_HardDelete := TABLE(HardDeleteRecs, {source,__Tpe,SALT37.StrType INGESTSTATUS:='HardDeleteOnly',UNSIGNED Cnt:=COUNT(GROUP)}, source,__Tpe, FEW);
  UpdateStatsSrc_seleidChanges := TABLE(seleidChangeAll, {source,__Tpe,SALT37.StrType INGESTSTATUS:='HardDeleteEntityChange',UNSIGNED Cnt:=COUNT(GROUP)}, source,__Tpe, FEW);
  SHARED UpdateStatsSrcInc := SORT(UpdateStatsSrcFull(__Tpe = RecordType.New) & UpdateStatsSrc_HardDelete & UpdateStatsSrc_seleidChanges, source,__Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStatsSrc := IF(incremental, UpdateStatsSrcInc, UpdateStatsSrcFull);
  SHARED S2 := OUTPUT(UpdateStatsSrc, {{UpdateStatsSrc} AND NOT __Tpe}, ALL, NAMED('UpdateStatsSrc'));
 
  SHARED l_roll := RECORD
    UpdateStatsSrc.source;
    unsigned cnt_Old;
    unsigned cnt_Unchanged;
    unsigned cnt_Updated;
    unsigned cnt_New;
    unsigned pct_tot_Old;
    unsigned pct_tot_Unchanged;
    unsigned pct_tot_Updated;
    unsigned pct_tot_New;
    unsigned pct_ingest_Unchanged;
    unsigned pct_ingest_Updated;
    unsigned pct_ingest_New;
  END;
  SHARED l_roll toRoll(UpdateStatsSrc L) := TRANSFORM
    SELF.cnt_Old := IF(L.__Tpe=RecordType.Old, L.Cnt, 0);
    SELF.cnt_Unchanged := IF(L.__Tpe=RecordType.Unchanged, L.Cnt, 0);
    SELF.cnt_Updated := IF(L.__Tpe=RecordType.Updated, L.Cnt, 0);
    SELF.cnt_New := IF(L.__Tpe=RecordType.New, L.Cnt, 0);
    SELF := L;
    SELF := [];
  END;
  SHARED l_roll doRoll(l_roll L, l_roll R) := TRANSFORM
    SELF.cnt_Old := IF(L.cnt_Old<>0, L.cnt_Old, R.cnt_Old);
    SELF.cnt_Unchanged := IF(L.cnt_Unchanged<>0, L.cnt_Unchanged, R.cnt_Unchanged);
    SELF.cnt_Updated := IF(L.cnt_Updated<>0, L.cnt_Updated, R.cnt_Updated);
    SELF.cnt_New := IF(L.cnt_New<>0, L.cnt_New, R.cnt_New);
    SELF := L;
  END;
  SHARED l_roll toPct(l_roll L) := TRANSFORM
    cnt_tot := L.cnt_old + L.cnt_unchanged + L.cnt_updated + L.cnt_new;
    cnt_ingest := L.cnt_unchanged + L.cnt_updated + L.cnt_new;
    SELF.pct_tot_Old := 100.0 * L.cnt_Old / cnt_tot;
    SELF.pct_tot_Unchanged := 100.0 * L.cnt_Unchanged / cnt_tot;
    SELF.pct_tot_Updated := 100.0 * L.cnt_Updated / cnt_tot;
    SELF.pct_tot_New := 100.0 * L.cnt_New / cnt_tot;
    SELF.pct_ingest_Unchanged := 100.0 * L.cnt_Unchanged / cnt_ingest;
    SELF.pct_ingest_Updated := 100.0 * L.cnt_Updated / cnt_ingest;
    SELF.pct_ingest_New := 100.0 * L.cnt_New / cnt_ingest;
    SELF := L;
  END;
  SHARED UpdateStatsXtab := PROJECT(ROLLUP(PROJECT(SORT(UpdateStatsSrc,source),toRoll(LEFT)),doRoll(LEFT,RIGHT),source),toPct(LEFT));
  SHARED S3 := IF(~incremental, OUTPUT(UpdateStatsXtab,ALL,NAMED('UpdateStatsXtab')));
 
  SHARED NoFlagsRec := WithRT -[hardDeleteAdded, seleidChange];
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_Base);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_Base);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_Base);
  EXPORT UpdatedRecords_HardDeleteOnly := PROJECT(HardDeleteRecs, NoFlagsRec);
  EXPORT UpdatedRecords_HardDeleteOnly_NoTag := PROJECT(UpdatedRecords_HardDeleteOnly,Layout_Base);
  EXPORT UpdatedRecords_HardDeleteEntityChange := IF(incremental, PROJECT(seleidChangeAll, NoFlagsRec), emptyDS); // no poison pills in full build
  EXPORT UpdatedRecords_HardDeleteEntityChange_NoTag := PROJECT(UpdatedRecords_HardDeleteEntityChange,Layout_Base);
  EXPORT AllRecords := IF(incremental, NewRecords & UpdatedRecords_HardDeleteOnly & UpdatedRecords_HardDeleteEntityChange, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_Base); // Records in 'pure' format
 
  // Compute field level differences
  IOR := JOIN(OldRecords,InputSourceCounts,left.source=right.source,TRANSFORM(LEFT),LOOKUP); // Only send in old records from sources in this ingest
  Fields.MAC_CountDifferencesByPivot(NewRecords,IOR,((SALT37.StrType)source+'|'+(SALT37.StrType)efx_id),BadPivs,DC)
  EXPORT FieldChangeStats := DC;
  SHARED S4 := OUTPUT(FieldChangeStats,ALL,NAMED('FieldChangeStats'));
 
  EXPORT DoStats := PARALLEL(S0,S1,S2,S3,S4);
 
END;
