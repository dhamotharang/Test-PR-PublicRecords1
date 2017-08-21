import doxie, FCRA, ut;

export key_proflic_did_Bid (boolean IsFCRA = false) := function
  df := Prof_LicenseV2.File_Proflic_Base_Keybuild((unsigned)did != 0);

  Layout_out := record
    unsigned6 did;
    Prof_LicenseV2.Layouts_ProfLic.Layout_Base and not [did];  
  end;

  Layout_out trfProject(df l) := transform
    self.did 		:= (unsigned6) l.did;
    self.bdid   := (string)l.bid;
		self			  := l;
  end;

  out_df := project(df (~IsFCRA or orbit_source not in FCRA.compliance.proflicenses.restricted_sources), trfProject(left));

  file_name := if (IsFCRA, 
                   '~thor_data400::key::ProlicV2::fcra::' + doxie.Version_SuperKey + '::bid::prolicense_did',
                   '~thor_data400::key::ProlicV2::'+ doxie.Version_SuperKey +'::bid::prolicense_did');

  return index (out_df, {did}, {out_df}, file_name);
end;
