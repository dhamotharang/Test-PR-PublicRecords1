// common executive contact layouts used in quite a few places
EXPORT layout_contact := MODULE

  EXPORT MAX_TITLE_RECS := 25;
  
  SHARED raw_base_rec := RECORD
    UNSIGNED1 level := 0;
    UNSIGNED6 bdid := 0; // BDID from Business Headers
    UNSIGNED6 did := 0; // DID from Headers
    UNSIGNED1 contact_score := 0;
    QSTRING34 vendor_id := ''; // Vendor key
    UNSIGNED4 dt_first_seen; // From contact info if available
    UNSIGNED4 dt_last_seen; // From contact infor if available
    STRING2 source; // Source file type
    STRING1 record_type; // 'C' = Current, 'H' = Historical
    STRING1 from_hdr := 'N'; // 'Y' if contact is from address match with person headers.
    BOOLEAN glb := FALSE; // GLB restricted record (only possible for contacts pulled from header)
    BOOLEAN dppa := FALSE; // DPPA restricted record (only possible for contacts pulled from header)
    QSTRING35 company_title; // Title of Contact at Company if available
    QSTRING35 company_department := '';
    QSTRING5 title;
    QSTRING20 fname;
    QSTRING20 mname;
    QSTRING20 lname;
    QSTRING5 name_suffix;
    STRING1 name_score;
  END;

  SHARED raw_addr_rec := RECORD
    QSTRING10 prim_range;
    STRING2 predir;
    QSTRING28 prim_name;
    QSTRING4 addr_suffix;
    STRING2 postdir;
    QSTRING5 unit_desig;
    QSTRING8 sec_range;
    QSTRING25 city;
    STRING2 state;
    UNSIGNED3 zip;
    UNSIGNED2 zip4;
    STRING3 county;
    STRING4 msa;
  END;

  SHARED raw_latlong_rec := RECORD
    QSTRING10 geo_lat;
    QSTRING11 geo_long;
  END;

  SHARED raw_company_rec := RECORD
    QSTRING34 company_source_group := ''; // Source group
    QSTRING120 company_name;
    QSTRING10 company_prim_range;
    STRING2 company_predir;
    QSTRING28 company_prim_name;
    QSTRING4 company_addr_suffix;
    STRING2 company_postdir;
    QSTRING5 company_unit_desig;
    QSTRING8 company_sec_range;
    QSTRING25 company_city;
    STRING2 company_state;
    UNSIGNED3 company_zip;
    UNSIGNED2 company_zip4;
    UNSIGNED6 company_phone;
    UNSIGNED4 company_fein := 0;
  END;

  EXPORT raw_rec := RECORD // from Business_Header.Layout_Business_Contact_Full_New
    raw_base_rec;
    raw_addr_rec;
    raw_latlong_rec;
    UNSIGNED6 phone;
    STRING60 email_address;
    STRING9 ssn := '';
    raw_company_rec;
    STRING10 record_type_decoded;
    STRING25 county_decoded;
  END;

  EXPORT standardized_rec := RECORD
    raw_base_rec;
    raw_addr_rec - [zip, zip4, county, msa];
    STRING5 zip := '';
    STRING4 zip4 := '';
    STRING3 county;
    STRING4 msa;
    STRING60 msaDesc := '';
    STRING18 county_name := '';
    raw_latlong_rec;
    STRING15 phone;
    STRING60 email_address;
    STRING9 ssn := '';
    raw_company_rec - [company_zip, company_zip4, company_phone, company_fein];
    STRING5 company_zip := '';
    STRING4 company_zip4 := '';
    STRING32 company_phone := '';
    STRING16 company_fein := '';
    STRING10 record_type_decoded;
    STRING25 county_decoded;
  END;

  EXPORT company_title_rec := RECORD
    standardized_rec.company_title;
    standardized_rec.bdid;
    standardized_rec.company_name;
  END;

  SHARED slim_rec := RECORD
    standardized_rec.bdid;
    standardized_rec.did;
    standardized_rec.dt_last_seen;
    STRING9 ssn;
    standardized_rec.fname;
    standardized_rec.mname;
    standardized_rec.lname;
    standardized_rec.name_suffix;
    standardized_rec.prim_range;
    standardized_rec.predir;
    standardized_rec.prim_name;
    standardized_rec.addr_suffix;
    standardized_rec.postdir;
    standardized_rec.unit_desig;
    standardized_rec.sec_range;
    standardized_rec.city;
    standardized_rec.state;
    STRING5 zip;
    STRING4 zip4;
  END;

  EXPORT slim_rec_with_titles := RECORD
    slim_rec;
    DATASET(company_title_rec) company_titles {MAXCOUNT(MAX_TITLE_RECS)};
  END;

  EXPORT address_rec := RECORD
    UNSIGNED4 address_id := 0;
    raw_rec.prim_range;
    raw_rec.predir;
    raw_rec.prim_name;
    raw_rec.addr_suffix;
    raw_rec.postdir;
    raw_rec.unit_desig;
    raw_rec.sec_range;
    raw_rec.city;
    raw_rec.state;
    raw_rec.zip;
    raw_rec.zip4;
    raw_rec.county;
    raw_rec.msa;
    raw_rec.geo_lat;
    raw_rec.geo_long;
  END;

  // ********************************************************
  // Executives
  // ********************************************************
  
  EXPORT exec_base_rec := RECORD
    raw_base_rec.bdid;
    raw_base_rec.did;
    raw_base_rec.dt_last_seen;
    raw_base_rec.fname;
    raw_base_rec.mname;
    raw_base_rec.lname;
    raw_base_rec.name_suffix;
  END;

  EXPORT exec_with_titles_rec := RECORD
    exec_base_rec;
    DATASET(company_title_rec) company_titles {MAXCOUNT(MAX_TITLE_RECS)};
    UNSIGNED2 title_rank;
  END;

  EXPORT exec_rec := RECORD
    exec_base_rec OR company_title_rec;
  END;

  EXPORT exec_plus_rank_rec := RECORD
    exec_rec;
    UNSIGNED2 title_rank;
  END;
END;
