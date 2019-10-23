Layout_raw := record
  string RecordingDate;
  string Grantor;
  string Grantee;
  string DocType;
  string DocNumber;
  string UserDocNumber;
  string NumOfPages;
	string field8;
end;

File_in_riverside := dataset('~thor_200::in::official_records::ca::riverside',Layout_raw,CSV(heading(1),separator(','),Terminator(['\n','\r\n']),QUOTE('"')))(Grantor <> 'ÿÿ' or Grantee <> 'ÿÿ');

Layout_fixed := record
  string18 RecordingDate;
  string80 Grantor;
  string80 Grantee;
  string6 DocType;
  string8 DocNumber;
  string12 UserDocNumber;
  string3 NumOfPages;
end;

Layout_fixed csv2fixed(File_in_riverside l) := transform
self.RecordingDate := trim(l.RecordingDate);
  self.Grantor := trim(l.Grantor);
  self.Grantee := trim(l.Grantee);
  self.DocType := trim(l.DocType);
  self.DocNumber := trim(l.DocNumber);
  self.UserDocNumber := trim(l.UserDocNumber);
  self.NumOfPages := trim(l.NumOfPages);
end;

Map2common := project(File_in_riverside,csv2fixed(LEFT));

export File_In_CA_Riverside := Map2common(Grantor <> '' or Grantee <> '');


