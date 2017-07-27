import header_services;

in_layout := record
	String32 hval;
  String2 state;
  String6 startDate;
  String6 endDate;
	String1 nl;
end;

header_services.Supplemental_Data.mac_verify('ssi_sup.txt',in_layout,attr);
in := attr();
export file_in_misc2b := in;

// export file_in_misc2b := dataset([],in_layout);
