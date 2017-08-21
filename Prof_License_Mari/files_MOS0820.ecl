//Raw professional license files from the source MOS0820

export files_MOS0820 := MODULE

	/*export RealEstate	:= dataset('~thor_data400::in::prolic::MOS0820::bra.txt',Prof_License_Mari.layout_MOS0820.RealEstate,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::bro.txt',Prof_License_Mari.layout_MOS0820.RealEstate,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::brp.txt',Prof_License_Mari.layout_MOS0820.RealEstate,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::brs.txt',Prof_License_Mari.layout_MOS0820.RealEstate,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::pcb.txt',Prof_License_Mari.layout_MOS0820.RealEstate,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::pcs.txt',Prof_License_Mari.layout_MOS0820.RealEstate,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::rea.txt',Prof_License_Mari.layout_MOS0820.RealEstate,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::rec.txt',Prof_License_Mari.layout_MOS0820.RealEstate,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::rpf.txt',Prof_License_Mari.layout_MOS0820.RealEstate,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::sal.txt',Prof_License_Mari.layout_MOS0820.RealEstate,csv(SEPARATOR('\t'),heading(1)));*/
	EXPORT RealEstate 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'bra', 
																	 Prof_License_Mari.layout_MOS0820.RealEstate,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'bro', 
																	 Prof_License_Mari.layout_MOS0820.RealEstate,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'brp', 
																	 Prof_License_Mari.layout_MOS0820.RealEstate,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'brs', 
																	 Prof_License_Mari.layout_MOS0820.RealEstate,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'pcb', 
																	 Prof_License_Mari.layout_MOS0820.RealEstate,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'pcs', 
																	 Prof_License_Mari.layout_MOS0820.RealEstate,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'rea', 
																	 Prof_License_Mari.layout_MOS0820.RealEstate,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'rec', 
																	 Prof_License_Mari.layout_MOS0820.RealEstate,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'rpf', 
																	 Prof_License_Mari.layout_MOS0820.RealEstate,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'sal', 
																	 Prof_License_Mari.layout_MOS0820.RealEstate,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
													 


	/*export Appraiser	:= dataset('~thor_data400::in::prolic::MOS0820::brk.txt',Prof_License_Mari.layout_MOS0820.Appraiser,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::ias.txt',Prof_License_Mari.layout_MOS0820.Appraiser,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::inb.txt',Prof_License_Mari.layout_MOS0820.Appraiser,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::rap.txt',Prof_License_Mari.layout_MOS0820.Appraiser,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::rsl.txt',Prof_License_Mari.layout_MOS0820.Appraiser,csv(SEPARATOR('\t'),heading(1)))
												+dataset('~thor_data400::in::prolic::MOS0820::scg.txt',Prof_License_Mari.layout_MOS0820.Appraiser,csv(SEPARATOR('\t'),heading(1)));
	*/											
	EXPORT Appraiser	 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'brk', 
																	 Prof_License_Mari.layout_MOS0820.Appraiser,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'ias', 
																	 Prof_License_Mari.layout_MOS0820.Appraiser,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'inb', 
																	 Prof_License_Mari.layout_MOS0820.Appraiser,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'rap', 
																	 Prof_License_Mari.layout_MOS0820.Appraiser,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'rsl', 
																	 Prof_License_Mari.layout_MOS0820.Appraiser,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))) +
													 dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820' + '::' + 'using' + '::' + 'scg', 
																	 Prof_License_Mari.layout_MOS0820.Appraiser,
																	 CSV(SEPARATOR('\t'),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;