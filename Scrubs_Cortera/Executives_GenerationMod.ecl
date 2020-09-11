// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT Executives_GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.11';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Cortera';
  EXPORT spc_NAMESCOPE := 'Executives';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Cortera';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,link_id,name,alternate_business_name,address,address2,city,state,country,postalcode,phone,fax,latitude,longitude,url,fein,position_type,ultimate_linkid,ultimate_name,loc_date_last_seen,primary_sic,sic_desc,primary_naics,naics_desc,segment_id,segment_desc,year_start,ownership,total_employees,employee_range,total_sales,sales_range,executive_name1,title1,executive_name2,title2,executive_name3,title3,executive_name4,title4,executive_name5,title5,executive_name6,title6,executive_name7,title7,executive_name8,title8,executive_name9,title9,executive_name10,title10,status,is_closed,closed_date,processdate,version,persistent_record_id,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,prim_name,p_city_name,v_city_name,executive_name,executive_title';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Cortera\n'
    + 'FILENAME:Cortera\n'
    + 'NAMESCOPE:Executives\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + 'FIELDTYPE:Alpha:CUSTOM(Scrubs.functions.fn_ASCII_printable>0)\n'
    + 'FIELDTYPE:CorpHierarchy:ENUM(S|B|H| )\n'
    + 'FIELDTYPE:Country:CUSTOM(Scrubs.functions.fn_Alpha_optional>0,2)\n'
    + 'FIELDTYPE:Feintype:ALLOW(0123456789):LENGTHS(0,9)\n'
    + 'FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.functions.fn_valid_date>0)\n'
    + 'FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.functions.fn_valid_date>0,\'future\')\n'
    + 'FIELDTYPE:Invalid_LatLong:CUSTOM(Scrubs.functions.fn_geo_coord>0)\n'
    + 'FIELDTYPE:Invalid_Naics:CUSTOM(Scrubs.fn_valid_NAICSCode > 0)\n'
    + 'FIELDTYPE:Invalid_Phone:CUSTOM(Scrubs.functions.fn_verify_optional_phone>0)\n'
    + 'FIELDTYPE:Invalid_Sic:CUSTOM(Scrubs.fn_valid_SicCode> 0)\n'
    + 'FIELDTYPE:Invalid_St:CUSTOM(Scrubs.functions.fn_valid_StateAbbrev>0)\n'
    + 'FIELDTYPE:Numeric:CUSTOM(Scrubs.functions.fn_numeric>0)\n'
    + 'FIELDTYPE:Numeric_Optional:ALLOW(0123456789)\n'
    + 'FIELDTYPE:OwnershipTypes:ENUM(P|V| )\n'
    + 'FIELDTYPE:StatusTypes:ENUM(A|D| )\n'
    + 'FIELDTYPE:YesNo:ENUM(Y|N| )\n'
    + '\n'
    + 'FIELD:link_id:LIKE(Numeric):0,0\n'
    + 'FIELD:name:0,0\n'
    + 'FIELD:alternate_business_name:0,0\n'
    + 'FIELD:address:0,0\n'
    + 'FIELD:address2:0,0\n'
    + 'FIELD:city:0,0\n'
    + 'FIELD:state:LIKE(Invalid_St):0,0\n'
    + 'FIELD:country:LIKE(Country):0,0\n'
    + 'FIELD:postalcode:LIKE(Numeric_Optional):0,0\n'
    + 'FIELD:phone:LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:fax:LIKE(Invalid_Phone):0,0\n'
    + 'FIELD:latitude:LIKE(Invalid_LatLong):0,0\n'
    + 'FIELD:longitude:LIKE(Invalid_LatLong):0,0\n'
    + 'FIELD:url:0,0\n'
    + 'FIELD:fein:LIKE(Feintype):0,0\n'
    + 'FIELD:position_type:LIKE(CorpHierarchy):0,0\n'
    + 'FIELD:ultimate_linkid:LIKE(Numeric_Optional):0,0\n'
    + 'FIELD:ultimate_name:0,0\n'
    + 'FIELD:loc_date_last_seen:LIKE(Invalid_Future_Date):0,0\n'
    + 'FIELD:primary_sic:LIKE(Invalid_Sic):0,0\n'
    + 'FIELD:sic_desc:0,0\n'
    + 'FIELD:primary_naics:LIKE(Invalid_Naics):0,0\n'
    + 'FIELD:naics_desc:0,0\n'
    + 'FIELD:segment_id:0,0\n'
    + 'FIELD:segment_desc:0,0\n'
    + 'FIELD:year_start:0,0\n'
    + 'FIELD:ownership:LIKE(OwnershipTypes):0,0\n'
    + 'FIELD:total_employees:0,0\n'
    + 'FIELD:employee_range:0,0\n'
    + 'FIELD:total_sales:0,0\n'
    + 'FIELD:sales_range:0,0\n'
    + 'FIELD:executive_name1:LIKE(Alpha):0,0\n'
    + 'FIELD:title1:LIKE(Alpha):0,0\n'
    + 'FIELD:executive_name2:LIKE(Alpha):0,0\n'
    + 'FIELD:title2:LIKE(Alpha):0,0\n'
    + 'FIELD:executive_name3:LIKE(Alpha):0,0\n'
    + 'FIELD:title3:LIKE(Alpha):0,0\n'
    + 'FIELD:executive_name4:LIKE(Alpha):0,0\n'
    + 'FIELD:title4:LIKE(Alpha):0,0\n'
    + 'FIELD:executive_name5:LIKE(Alpha):0,0\n'
    + 'FIELD:title5:LIKE(Alpha):0,0\n'
    + 'FIELD:executive_name6:LIKE(Alpha):0,0\n'
    + 'FIELD:title6:LIKE(Alpha):0,0\n'
    + 'FIELD:executive_name7:LIKE(Alpha):0,0\n'
    + 'FIELD:title7:LIKE(Alpha):0,0\n'
    + 'FIELD:executive_name8:LIKE(Alpha):0,0\n'
    + 'FIELD:title8:LIKE(Alpha):0,0\n'
    + 'FIELD:executive_name9:LIKE(Alpha):0,0\n'
    + 'FIELD:title9:LIKE(Alpha):0,0\n'
    + 'FIELD:executive_name10:LIKE(Alpha):0,0\n'
    + 'FIELD:title10:LIKE(Alpha):0,0\n'
    + 'FIELD:status:LIKE(StatusTypes):0,0\n'
    + 'FIELD:is_closed:LIKE(YesNo):0,0\n'
    + 'FIELD:closed_date:0,0\n'
    + 'FIELD:processdate:LIKE(Invalid_Date):0,0\n'
    + 'FIELD:version:LIKE(Invalid_Date):0,0\n'
    + 'FIELD:persistent_record_id:LIKE(Numeric):0,0\n'
    + 'FIELD:dt_first_seen:LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_last_seen:LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_vendor_first_reported:LIKE(Invalid_Date):0,0\n'
    + 'FIELD:dt_vendor_last_reported:LIKE(Invalid_Date):0,0\n'
    + 'FIELD:prim_name:LIKE(Alpha):0,0\n'
    + 'FIELD:p_city_name:LIKE(Alpha):0,0\n'
    + 'FIELD:v_city_name:LIKE(Alpha):0,0\n'
    + 'FIELD:executive_name:LIKE(Alpha):0,0\n'
    + 'FIELD:executive_title:LIKE(Alpha):0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

