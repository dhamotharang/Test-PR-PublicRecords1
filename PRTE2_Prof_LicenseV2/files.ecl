
Import FCRA, PRTE2_Prof_LicenseV2, ut,PRTE_CSV,VersionControl, _Control,Prof_LicenseV2;

EXPORT Files := 	MODULE
					
	EXPORT DS_prolicv2_IN 	:= DATASET('~prte::in::prolicv2',
		     Layouts.Layout_file_prof_license_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
 
  // EXPORT DS_File_prolicv2_Base_ext := DATASET(constants.prolicv2_base, 
	       // Layouts.Layout_file_prof_license_in, FLAT );
				 
	  EXPORT DS_File_prolicv2_Base_ext := DATASET(constants.prolicv2_base, 
	        Layouts.Layout_out, FLAT );			 


  Export DS_File_prolicv2_Base := project(DS_File_prolicv2_Base_ext, 
         transform(Layouts.Layout_Base_With_Tiers, 
				 self.did := (string12)left.did;
				 self.bdid := (string12)left.bdid;
         self := Left;
         self := [];	 
  ));    
	
	 Export DS_File_prolicv2_Base2   := project(DS_File_prolicv2_Base, Layouts.Layout_Base);
		

	  Shared Layouts.Layout_did_out trfProject(DS_File_prolicv2_Base l) := transform
    self.did := (unsigned6) l.did;
    self     := l;
    end;
   
	  Export DS_prolicv2_did := project(DS_File_prolicv2_Base , trfProject(left));
	  
    Export DS_prolicv2 := project(DS_File_prolicv2_Base,Layouts.Layout_Base);
	 
	  Export DS_prolicv2_AID:= project(DS_File_prolicv2_Base,layouts.layout_prolic_out_with_AID);
		

   Export DS_prolicv2_linkid:=project(DS_File_prolicv2_Base,Layouts.LayoutLinkID);

  Layouts.layout_Autokeys trfAutokeys(DS_prolicv2 l,integer C) := transform
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
  self.bdid               := (unsigned6)l.bdid;
  self                    := l;
end;

File_Autokeys := normalize(DS_prolicv2,if(left.source_st=left.st or left.source_st='' or left.st='',1,2),  trfAutokeys(left,counter));

export File_ProfLic_Autokeys := File_Autokeys;

END;