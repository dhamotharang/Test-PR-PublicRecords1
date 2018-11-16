Import Data_Services, doxie, FCRA, ut,misc;

export key_proflic_did (boolean IsFCRA = false) := function
  // Found out from Danny Bello that the exclusion of INFUTOR only happens when it's FCRA data
  df := IF(~IsFCRA,
	         Prof_LicenseV2.File_Proflic_Base_Keybuild((unsigned)did != 0),
					 Prof_LicenseV2.File_Proflic_Base_Keybuild((unsigned)did != 0 AND vendor <> 'INFUTOR'));

  Layout_out := record
    unsigned6 did;
    Prof_LicenseV2.Layouts_ProfLic.Layout_Base and not [did];  
  end;

  Layout_out trfProject(df l) := transform
    self.did := (unsigned6) l.did;
    self     := l;
  end;

  nFCRA_out_df := project(df (~IsFCRA or orbit_source not in FCRA.compliance.proflicenses.restricted_sources), trfProject(left));

	// For FCRA, only allow sources that have info in vendor source info key
	allSources   := table(misc.Key_VendorSrc().Vendor_Source,{source_code},source_code,merge,few);
	FCRA_out_df  := join(nFCRA_out_df,allSources,left.vendor=right.source_code,transform(left),lookup);
	out_df       := if(IsFCRA, FCRA_out_df, nFCRA_out_df);

  file_name := if (IsFCRA, 
                   Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::ProlicV2::fcra::' + doxie.Version_SuperKey + '::prolicense_did',
                   Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::ProlicV2::'+ doxie.Version_SuperKey +'::prolicense_did');

  return index (out_df, {did}, {out_df}, file_name);
end;
