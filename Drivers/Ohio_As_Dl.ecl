import ut,lib_stringlib;
o := Drivers.File_Ohio_Raw;
u := File_Ohio_Update;

string lFixNameCharacters(string pOrigName)
  := if(lib_stringlib.stringlib.stringfind(pOrigName,'*',1) <> 0,
        lib_stringlib.stringlib.stringfindreplace(
	      lib_stringlib.stringlib.stringfindreplace(
            lib_stringlib.stringlib.stringfindreplace(pOrigName,'%',' '),
            ',',' '),
           '*',', ')
		 ,pOrigName
		);

string f2CharCodeAndComma(string pRestrictionCode) :=  // process each two-character restriction code
                         if(trim(pRestrictionCode,right)<>'',
							',' + trim(pRestrictionCode,right),
							''
						   );
 
Layout_Dl intof(o le) := transform
  self.dt_first_seen := (unsigned8)le.process_date div 100;
  self.dt_last_seen := (unsigned8)le.process_date div 100;
  self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
  self.dt_vendor_last_reported := (unsigned8)le.process_date div 100;
  self.orig_state := 'OH';

  self.dl_key_number := le.dbkoln;
  self.dl_number := le.dvnlic;
  self.name := lFixNameCharacters(le.pimnam);
  self.addr1 := le.pigstr;
  self.city := le.pigcty;
  self.state := le.pigsta;
  self.zip  := le.pigzip[1..5];
  self.dob := (unsigned8)le.pidd01;
  self.dod := le.piddod;
  self.ssn := le.pinss4;
  self.sex_flag := le.picsex;
  self.hair_color := le.pichcl;
  self.eye_color := le.picecl;
  self.weight := le.piqwgt;
  self.height := le.pinhft+le.pinhin;
  self.attention_flag := le.pifdon;
  self.license_type := le.DVCCLS;
  self.restrictions := le.dvcgrs;
  self.restrictions_delimited := if(transfer(le.dvcgrs[1],integer1) != 0, trim(le.dvcgrs[1..2],right) +
									 f2CharCodeAndComma(le.dvcgrs[3..4]) + 
									 f2CharCodeAndComma(le.dvcgrs[5..6]) + 
									 f2CharCodeAndComma(le.dvcgrs[7..8]) + 
									 f2CharCodeAndComma(le.dvcgrs[9..10]) + 
									 f2CharCodeAndComma(le.dvcgrs[11..12]) + 
									 f2CharCodeAndComma(le.dvcgrs[13..14]) + 
									 f2CharCodeAndComma(le.dvcgrs[15..16]) + 
									 f2CharCodeAndComma(le.dvcgrs[17..18]) + 
									 f2CharCodeAndComma(le.dvcgrs[19..20]) + 
									 f2CharCodeAndComma(le.dvcgrs[21..22]) + 
									 f2CharCodeAndComma(le.dvcgrs[23..24]) + 
									 f2CharCodeAndComma(le.dvcgrs[25..26]) +
									 f2CharCodeAndComma(le.dvcgrs[27..28]) +
									 f2CharCodeAndComma(le.dvcgrs[29..30]), '');
  self.lic_endorsement := le.dvcgen;
  self.driver_edu_code := le.dvcded;
  self.orig_expiration_date := (unsigned8)le.dvdexp;
  self.lic_issue_date := (unsigned8)le.dvddOI;
  self.privacy_flag := le.dvflsd;
  self.dup_lic_count := le.dvqdup;
  self.rcd_stat_flag := le.dvfrcs;
  self.issuance := le.dvctyp;
  self.address_change := le.pidaup;
// clean fields
  self.st := le.state;
  self.zip5 := le.zip;
  self.zip4 := le.zip4;
  self := le;
  end;

export Ohio_As_Dl := project(o+u,intof(left));