import header, doxie, ut, dx_Header;

t := header.Prepped_For_Keys;

layout_ssn_last5 := record  
  string5 ssn5;
  STRING20 lname;
  STRING20 fname;
  unsigned6 did;
end;  

layout_ssn_last5 get_ssn_last5(t l) := transform
	self.ssn5 := if(length(trim(l.ssn))=9, l.ssn[1..5],'');
	self := l;			 
end;

ssn5_recs := project(t, get_ssn_last5(left));
ssn5_dep := dedup(sort(ssn5_recs((unsigned)ssn5<>0, lname<>''), record),record);

export data_key_SSN5 := PROJECT (ssn5_dep, dx_Header.layouts.i_ssn5);
//export Key_Header_SSN5 := INDEX(ssn5_dep, {ssn5_dep}, 
//                                ut.Data_Location.Person_header+'thor_data400::key::header.ssn5.did_' + doxie.Version_SuperKey);