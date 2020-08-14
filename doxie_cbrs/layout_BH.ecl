// This is a copy of Business Header File Internal Layout - with strings for phone, fein, zips
EXPORT layout_BH := RECORD
  UNSIGNED6 rcid := 0;
  UNSIGNED6 bdid := 0; // Seisint Business Identifier
  STRING2 source; // Source file type
  QSTRING34 source_group := ''; // Source group identifier for merging of records only within source AND GROUP
  STRING3 pflag := ''; // Internal processing flags
  UNSIGNED6 group1_id := 0; // Group identifier (temporary) for matching groups of records pre-linked
  QSTRING34 vendor_id := ''; // Vendor key
  UNSIGNED4 dt_first_seen; // Date record first seen at Seisint
  UNSIGNED4 dt_last_seen; // Date record last (most recently seen) at Seisint
  UNSIGNED4 dt_vendor_first_reported;
  UNSIGNED4 dt_vendor_last_reported;
  QSTRING120 company_name;
  QSTRING10 prim_range;
  STRING2 predir;
  QSTRING28 prim_name;
  QSTRING4 addr_suffix;
  STRING2 postdir;
  QSTRING5 unit_desig;
  QSTRING8 sec_range;
  QSTRING25 city;
  STRING2 state;
  STRING5 zip := '';
  STRING4 zip4 := '';
  STRING3 county;
  STRING4 msa;
  QSTRING10 geo_lat;
  QSTRING11 geo_long;
  STRING15 phone := '';
  UNSIGNED2 phone_score := 0; // Score captioned listings for display ranking
  STRING32 fein := ''; // Federal Tax ID
  BOOLEAN current; // Current/Historical indicator
  BOOLEAN dppa := FALSE; // DPPA restricted record (Vehicles and Watercraft)
  END;
