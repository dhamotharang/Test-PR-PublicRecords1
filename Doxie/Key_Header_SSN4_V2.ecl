import header, doxie, ut, Data_Services;

t := header.Prepped_For_Keys;

layout_ssn_last4 := record  
		string4 ssn4;
		STRING6 dph_lname;
		STRING20 lname;
		STRING20 pfname;
		STRING20 fname;
		unsigned6 did;
end;  

layout_ssn_last4 get_ssn_last4(t l) := transform
	self.ssn4 := INTFORMAT((INTEGER)L.ssn % 10000, 4, 1);
	self := l;			 
end;

ssn4_recs := project(t, get_ssn_last4(left));
ssn4_dep := dedup(sort(ssn4_recs((unsigned)ssn4<>0, lname<>''), record),record);

export Key_Header_SSN4_V2 := INDEX(ssn4_dep, {ssn4_dep}, 
                                Data_Services.Data_location.Prefix('person_header') + 'thor_data400::key::header.ssn4_v2.did_' + doxie.Version_SuperKey);
