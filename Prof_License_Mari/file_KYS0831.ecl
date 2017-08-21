//Raw Real Estate Commission file from KY S0831



EXPORT file_KYS0831 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'KYS0831' + '::' + 'using' + '::' + 'rel', 
															 Prof_License_Mari.layout_KYS0831.common,
															 CSV(SEPARATOR(','),quote('"')));

// export file_KYS0831 := dataset('~thor400_88::in::prolic::kys0831::real_estate.txt',Prof_License_Mari.layout_KYS0831,flat);
