import header, doxie, data_services;

t := header.Prepped_For_Keys;

layout_ssn_last4 := record  
  string4 ssn4;
  STRING20 lname;
  STRING20 fname;
  unsigned6 did;
end;  

layout_ssn_last4 get_ssn_last4(t l) := transform
	self.ssn4 := INTFORMAT((INTEGER)L.ssn % 10000, 4, 1);
	self := l;			 
end;

ssn4_recs := project(t, get_ssn_last4(left));
ssn4_dep := dedup(sort(ssn4_recs((unsigned)ssn4<>0, lname<>''), record),record);

export Key_Header_SSN4 := INDEX(ssn4_dep, {ssn4_dep}, 
                                data_services.data_location.prefix() + 'thor_data400::key::header.ssn4.did_' + doxie.Version_SuperKey);
