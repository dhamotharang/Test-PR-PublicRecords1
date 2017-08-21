// MARI - File Arizona Board of Appraisers - AZS0808
EXPORT file_AZS0808   := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'AZS0808' + '::' + 'using' + '::' + 'apr', 
                                 Prof_License_Mari.layout_AZS0808,
																 CSV(SEPARATOR(','),HEADING(1),QUOTE('"')));
																 
//export file_AZS0808 := dataset('~thor_data400::in::prolic::AZS0808::appraiser.txt',Prof_License_Mari.layout_AZS0808,csv(SEPARATOR('\t'),heading(1)));