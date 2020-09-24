// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.6';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'WhoIs';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := 'RCID'; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := '';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'WhoIs';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:RCID';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,did,did_score,process_date,date_first_seen,date_last_seen,date_vendor_first_reported,date_vendor_last_reported,clean_cname,current_rec,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight,clean_title,clean_fname,clean_mname,clean_lname,clean_name_suffix,clean_name_score,rawaid,append_prep_address_situs,append_prep_address_last_situs,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,county,geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,emailtype,rawtext,email,name,organization,street1,street2,street3,street4,city,state,postalcode,country,fax,faxext,phone,phoneext,domainname,registrarname,contactemail,whoisserver,nameservers,createddate,updateddate,expiresdate,standardregcreateddate,standardregupdateddate,standardregexpiresdate,status,audit_auditupdateddate,registrant_rawtext,registrant_email,registrant_name,registrant_organization,registrant_street1,registrant_street2,registrant_street3,registrant_street4,registrant_city,registrant_state,registrant_postalcode,registrant_country,registrant_fax,registrant_faxext,registrant_phone,registrant_phoneext,administrativecontact_rawtext,administrativecontact_email,administrativecontact_name,administrativecontact_organization,administrativecontact_street1,administrativecontact_street2,administrativecontact_street3,administrativecontact_street4,administrativecontact_city,administrativecontact_state,administrativecontact_postalcode,administrativecontact_country,administrativecontact_fax,administrativecontact_faxext,administrativecontact_phone,administrativecontact_phoneext,billingcontact_rawtext,billingcontact_email,billingcontact_name,billingcontact_organization,billingcontact_street1,billingcontact_street2,billingcontact_street3,billingcontact_street4,billingcontact_city,billingcontact_state,billingcontact_postalcode,billingcontact_country,billingcontact_fax,billingcontact_faxext,billingcontact_phone,billingcontact_phoneext,technicalcontact_rawtext,technicalcontact_email,technicalcontact_name,technicalcontact_organization,technicalcontact_street1,technicalcontact_street2,technicalcontact_street3,technicalcontact_street4,technicalcontact_city,technicalcontact_state,technicalcontact_postalcode,technicalcontact_country,technicalcontact_fax,technicalcontact_faxext,technicalcontact_phone,technicalcontact_phoneext,zonecontact_rawtext,zonecontact_email,zonecontact_name,zonecontact_organization,zonecontact_street1,zonecontact_street2,zonecontact_street3,zonecontact_street4,zonecontact_city,zonecontact_state,zonecontact_postalcode,zonecontact_country,zonecontact_fax,zonecontact_faxext,zonecontact_phone,zonecontact_phoneext';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := FALSE;
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
    + 'MODULE:WhoIs\n'
    + 'FILENAME:WhoIs\n'
    + '\n'
    + 'RIDFIELD:RCID:GENERATE\n'
    + 'INGESTFILE:WhoIs_update:NAMED(WhoIs.prep_ingest)\n'
    + '\n'
    + 'FIELD:did:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:did_score:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:process_date:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:date_first_seen:TYPE(STRING8):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_last_seen:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:date_vendor_first_reported:TYPE(STRING8):RECORDDATE(FIRST):0,0\n'
    + 'FIELD:date_vendor_last_reported:TYPE(STRING8):RECORDDATE(LAST):0,0\n'
    + 'FIELD:clean_cname:DERIVED:TYPE(STRING50):0,0\n'
    + 'FIELD:current_rec:DERIVED:TYPE(BOOLEAN):0,0\n'
    + 'FIELD:dotid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:dotscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:dotweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:empscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:empweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:powscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:powweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:proxscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:proxweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:selescore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:seleweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:orgscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:orgweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultid:DERIVED:TYPE(UNSIGNED6):0,0\n'
    + 'FIELD:ultscore:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:ultweight:DERIVED:TYPE(UNSIGNED2):0,0\n'
    + 'FIELD:clean_title:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_fname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_mname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_lname:DERIVED:TYPE(STRING20):0,0\n'
    + 'FIELD:clean_name_suffix:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:clean_name_score:DERIVED:TYPE(STRING3):0,0\n'
    + 'FIELD:rawaid:DERIVED:TYPE(UNSIGNED8):0,0\n'
    + 'FIELD:append_prep_address_situs:DERIVED:TYPE(STRING77):0,0\n'
    + 'FIELD:append_prep_address_last_situs:DERIVED:TYPE(STRING54):0,0\n'
    + 'FIELD:prim_range:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:prim_name:DERIVED:TYPE(STRING28):0,0\n'
    + 'FIELD:addr_suffix:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:unit_desig:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:DERIVED:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:v_city_name:DERIVED:TYPE(STRING25):0,0\n'
    + 'FIELD:st:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:zip:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:zip4:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:cart:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:cr_sort_sz:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:lot:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:lot_order:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:dbpc:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:chk_digit:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:rec_type:DERIVED:TYPE(STRING2):0,0\n'
    + 'FIELD:county:DERIVED:TYPE(STRING5):0,0\n'
    + 'FIELD:geo_lat:DERIVED:TYPE(STRING10):0,0\n'
    + 'FIELD:geo_long:DERIVED:TYPE(STRING11):0,0\n'
    + 'FIELD:msa:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:geo_blk:DERIVED:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:DERIVED:TYPE(STRING1):0,0\n'
    + 'FIELD:err_stat:DERIVED:TYPE(STRING4):0,0\n'
    + 'FIELD:emailtype:TYPE(STRING100):0,0\n'
    + 'FIELD:rawtext:TYPE(STRING100):0,0\n'
    + 'FIELD:email:TYPE(STRING80):0,0\n'
    + 'FIELD:name:TYPE(STRING100):0,0\n'
    + 'FIELD:organization:TYPE(STRING100):0,0\n'
    + 'FIELD:street1:TYPE(STRING100):0,0\n'
    + 'FIELD:street2:TYPE(STRING100):0,0\n'
    + 'FIELD:street3:TYPE(STRING100):0,0\n'
    + 'FIELD:street4:TYPE(STRING100):0,0\n'
    + 'FIELD:city:TYPE(STRING25):0,0\n'
    + 'FIELD:state:TYPE(STRING10):0,0\n'
    + 'FIELD:postalcode:TYPE(STRING20):0,0\n'
    + 'FIELD:country:TYPE(STRING20):0,0\n'
    + 'FIELD:fax:TYPE(STRING15):0,0\n'
    + 'FIELD:faxext:TYPE(STRING15):0,0\n'
    + 'FIELD:phone:TYPE(STRING15):0,0\n'
    + 'FIELD:phoneext:TYPE(STRING15):0,0\n'
    + 'FIELD:domainname:TYPE(STRING100):0,0\n'
    + 'FIELD:registrarname:TYPE(STRING100):0,0\n'
    + 'FIELD:contactemail:TYPE(STRING80):0,0\n'
    + 'FIELD:whoisserver:TYPE(STRING50):0,0\n'
    + 'FIELD:nameservers:TYPE(STRING50):0,0\n'
    + 'FIELD:createddate:TYPE(STRING50):0,0\n'
    + 'FIELD:updateddate:TYPE(STRING50):0,0\n'
    + 'FIELD:expiresdate:TYPE(STRING50):0,0\n'
    + 'FIELD:standardregcreateddate:TYPE(STRING10):0,0\n'
    + 'FIELD:standardregupdateddate:TYPE(STRING10):0,0\n'
    + 'FIELD:standardregexpiresdate:TYPE(STRING10):0,0\n'
    + 'FIELD:status:TYPE(STRING50):0,0\n'
    + 'FIELD:audit_auditupdateddate:TYPE(STRING10):0,0\n'
    + 'FIELD:registrant_rawtext:TYPE(STRING100):0,0\n'
    + 'FIELD:registrant_email:TYPE(STRING80):0,0\n'
    + 'FIELD:registrant_name:TYPE(STRING50):0,0\n'
    + 'FIELD:registrant_organization:TYPE(STRING50):0,0\n'
    + 'FIELD:registrant_street1:TYPE(STRING100):0,0\n'
    + 'FIELD:registrant_street2:TYPE(STRING100):0,0\n'
    + 'FIELD:registrant_street3:TYPE(STRING100):0,0\n'
    + 'FIELD:registrant_street4:TYPE(STRING100):0,0\n'
    + 'FIELD:registrant_city:TYPE(STRING25):0,0\n'
    + 'FIELD:registrant_state:TYPE(STRING10):0,0\n'
    + 'FIELD:registrant_postalcode:TYPE(STRING20):0,0\n'
    + 'FIELD:registrant_country:TYPE(STRING20):0,0\n'
    + 'FIELD:registrant_fax:TYPE(STRING15):0,0\n'
    + 'FIELD:registrant_faxext:TYPE(STRING15):0,0\n'
    + 'FIELD:registrant_phone:TYPE(STRING15):0,0\n'
    + 'FIELD:registrant_phoneext:TYPE(STRING15):0,0\n'
    + 'FIELD:administrativecontact_rawtext:TYPE(STRING100):0,0\n'
    + 'FIELD:administrativecontact_email:TYPE(STRING80):0,0\n'
    + 'FIELD:administrativecontact_name:TYPE(STRING50):0,0\n'
    + 'FIELD:administrativecontact_organization:TYPE(STRING50):0,0\n'
    + 'FIELD:administrativecontact_street1:TYPE(STRING100):0,0\n'
    + 'FIELD:administrativecontact_street2:TYPE(STRING100):0,0\n'
    + 'FIELD:administrativecontact_street3:TYPE(STRING100):0,0\n'
    + 'FIELD:administrativecontact_street4:TYPE(STRING100):0,0\n'
    + 'FIELD:administrativecontact_city:TYPE(STRING25):0,0\n'
    + 'FIELD:administrativecontact_state:TYPE(STRING10):0,0\n'
    + 'FIELD:administrativecontact_postalcode:TYPE(STRING20):0,0\n'
    + 'FIELD:administrativecontact_country:TYPE(STRING20):0,0\n'
    + 'FIELD:administrativecontact_fax:TYPE(STRING15):0,0\n'
    + 'FIELD:administrativecontact_faxext:TYPE(STRING15):0,0\n'
    + 'FIELD:administrativecontact_phone:TYPE(STRING15):0,0\n'
    + 'FIELD:administrativecontact_phoneext:TYPE(STRING15):0,0\n'
    + 'FIELD:billingcontact_rawtext:TYPE(STRING100):0,0\n'
    + 'FIELD:billingcontact_email:TYPE(STRING80):0,0\n'
    + 'FIELD:billingcontact_name:TYPE(STRING50):0,0\n'
    + 'FIELD:billingcontact_organization:TYPE(STRING50):0,0\n'
    + 'FIELD:billingcontact_street1:TYPE(STRING100):0,0\n'
    + 'FIELD:billingcontact_street2:TYPE(STRING100):0,0\n'
    + 'FIELD:billingcontact_street3:TYPE(STRING100):0,0\n'
    + 'FIELD:billingcontact_street4:TYPE(STRING100):0,0\n'
    + 'FIELD:billingcontact_city:TYPE(STRING25):0,0\n'
    + 'FIELD:billingcontact_state:TYPE(STRING10):0,0\n'
    + 'FIELD:billingcontact_postalcode:TYPE(STRING20):0,0\n'
    + 'FIELD:billingcontact_country:TYPE(STRING20):0,0\n'
    + 'FIELD:billingcontact_fax:TYPE(STRING15):0,0\n'
    + 'FIELD:billingcontact_faxext:TYPE(STRING15):0,0\n'
    + 'FIELD:billingcontact_phone:TYPE(STRING15):0,0\n'
    + 'FIELD:billingcontact_phoneext:TYPE(STRING15):0,0\n'
    + 'FIELD:technicalcontact_rawtext:TYPE(STRING100):0,0\n'
    + 'FIELD:technicalcontact_email:TYPE(STRING80):0,0\n'
    + 'FIELD:technicalcontact_name:TYPE(STRING50):0,0\n'
    + 'FIELD:technicalcontact_organization:TYPE(STRING50):0,0\n'
    + 'FIELD:technicalcontact_street1:TYPE(STRING100):0,0\n'
    + 'FIELD:technicalcontact_street2:TYPE(STRING100):0,0\n'
    + 'FIELD:technicalcontact_street3:TYPE(STRING100):0,0\n'
    + 'FIELD:technicalcontact_street4:TYPE(STRING100):0,0\n'
    + 'FIELD:technicalcontact_city:TYPE(STRING25):0,0\n'
    + 'FIELD:technicalcontact_state:TYPE(STRING10):0,0\n'
    + 'FIELD:technicalcontact_postalcode:TYPE(STRING20):0,0\n'
    + 'FIELD:technicalcontact_country:TYPE(STRING20):0,0\n'
    + 'FIELD:technicalcontact_fax:TYPE(STRING15):0,0\n'
    + 'FIELD:technicalcontact_faxext:TYPE(STRING15):0,0\n'
    + 'FIELD:technicalcontact_phone:TYPE(STRING15):0,0\n'
    + 'FIELD:technicalcontact_phoneext:TYPE(STRING15):0,0\n'
    + 'FIELD:zonecontact_rawtext:TYPE(STRING100):0,0\n'
    + 'FIELD:zonecontact_email:TYPE(STRING80):0,0\n'
    + 'FIELD:zonecontact_name:TYPE(STRING50):0,0\n'
    + 'FIELD:zonecontact_organization:TYPE(STRING50):0,0\n'
    + 'FIELD:zonecontact_street1:TYPE(STRING100):0,0\n'
    + 'FIELD:zonecontact_street2:TYPE(STRING100):0,0\n'
    + 'FIELD:zonecontact_street3:TYPE(STRING100):0,0\n'
    + 'FIELD:zonecontact_street4:TYPE(STRING100):0,0\n'
    + 'FIELD:zonecontact_city:TYPE(STRING25):0,0\n'
    + 'FIELD:zonecontact_state:TYPE(STRING10):0,0\n'
    + 'FIELD:zonecontact_postalcode:TYPE(STRING20):0,0\n'
    + 'FIELD:zonecontact_country:TYPE(STRING20):0,0\n'
    + 'FIELD:zonecontact_fax:TYPE(STRING15):0,0\n'
    + 'FIELD:zonecontact_faxext:TYPE(STRING15):0,0\n'
    + 'FIELD:zonecontact_phone:TYPE(STRING15):0,0\n'
    + 'FIELD:zonecontact_phoneext:TYPE(STRING15):0,0\n'
    + '\n'
    + '// CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '// RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '// SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '// LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

