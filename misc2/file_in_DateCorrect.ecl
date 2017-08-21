import header_services;

in_layout := record
	String32 hval;
  String2 state;
  String8 startDate;
  String8 endDate;
	String1 nl;
end;

header_services.Supplemental_Data.mac_verify('ssi2_sup.txt',in_layout,attr);
in := attr();
export file_in_DateCorrect := dedup(sort(in,hval,-endDate),hval);