import Prof_License;

base := Prof_LicenseV2.File_Proflic_Base_Keybuild;


Layout_Autokeys := Prof_licenseV2.Layouts_ProfLic.Layout_Autokeys;

Layout_Autokeys trfAutokeys(base l,integer C) := transform
  self.name.lname         := l.lname;
  self.name.fname         := l.fname;
  self.name.mname         := l.mname;
  self.name.title         := l.title;
  self.name.name_suffix   := l.name_suffix;
  self.name.name_score    := l.pl_score_in;
  self.addr.prim_range    := l.prim_range;
  self.addr.predir        := l.predir;
  self.addr.prim_name     := l.prim_name;
  self.addr.addr_suffix   := l.suffix;
  self.addr.postdir       := l.postdir;
  self.addr.unit_desig    := l.unit_desig;
  self.addr.sec_range     := l.sec_range;
  self.addr.p_city_name   := l.p_city_name;
  self.addr.v_city_name   := l.v_city_name;
  self.addr.st            := if(C=1 and l.st<>'', l.st,l.source_st);
  self.addr.zip5          := l.zip;
  self.addr.zip4          := l.zip4;
  self.addr.fips_state    := l.ace_fips_st;
  self.addr.fips_county   := l.county;
  self.addr.addr_rec_type := l.record_type;
  self.cname              := l.company_name;
  self.did                := (unsigned6)l.did;
  self.bdid               := l.bid;
  self                    := l;
end;

File_Autokeys := normalize(base,if(left.source_st=left.st or left.source_st='' or left.st='',1,2),  trfAutokeys(left,counter));


export File_ProfLic_Bid_Autokeys := File_Autokeys;
