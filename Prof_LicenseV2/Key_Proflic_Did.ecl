import doxie, FCRA, Data_Services, vault, _control;


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_proflic_did (boolean IsFCRA = false) := vault.prof_licenseV2.Key_Proflic_Did (isFCRA);

#ELSE
export key_proflic_did (boolean IsFCRA = false) := function
  df := Prof_LicenseV2.File_Proflic_Base_Keybuild((unsigned)did != 0 and vendor<>'INFUTOR');

  Layout_out := record
    unsigned6 did;
    Prof_LicenseV2.Layouts_ProfLic.Layout_Base and not [did];  
  end;

  Layout_out trfProject(df l) := transform
    self.did := (unsigned6) l.did;
    self     := l;
  end;

  out_df := project(df (~IsFCRA or orbit_source not in FCRA.compliance.proflicenses.restricted_sources), trfProject(left));

  file_name := if (IsFCRA, 
                   // instead of Data_Services.Data_location.Prefix()+'thor_data400::key::fcra::prolicense_did_' + doxie.Version_SuperKey)
                   Data_Services.Data_location.Prefix()+'thor_data400::key::ProlicV2::fcra::' + doxie.Version_SuperKey + '::prolicense_did',
                   Data_Services.Data_location.Prefix()+'thor_data400::key::ProlicV2::'+ doxie.Version_SuperKey +'::prolicense_did');

  return index (out_df, {did}, {out_df}, file_name);
end;


#END;


