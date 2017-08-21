// Defines file names used by "this" workunit
EXPORT IUpdateJobFileNames := INTERFACE
  export string wuid; // not restricted to string16 WUID, any descriptor can be used
  export string customer_dir;
  export string source;
  export string file_descriptor;

  export string source_lz;   // name of the source file as in landing zone
  // export string targetFileName;
  export string source_thor; // name of the source file as in THOR
  export string verified;

  export string archive_ver;
  export string archive_qa;
  export string archive_file;

  export string raw_ver;
  export string raw_qa;
  export string raw_file;

  export string submonitor_ver;
  export string submonitor_qa;
  export string submonitor_file;

  export string sth_address_ver := '';
  export string sth_address_qa := '';
  export string sth_address_file := '';

  export string sth_phone_ver := '';
  export string sth_phone_qa := '';
  export string sth_phone_file := '';

  export string sth_prop_ver := '';
  export string sth_prop_qa := '';
  export string sth_prop_file := '';

  export string sth_paw_ver := '';
  export string sth_paw_qa := '';
  export string sth_paw_file := '';

  export string report_ver;
  export string report_qa;
  export string report_file;
  export string report_despray := '';
END;
