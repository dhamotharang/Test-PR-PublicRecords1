//Raw professional license files from DE S0846

export file_DES0846   := dataset('~thor400_88::in::prolic::des0846::appraiser.txt',Prof_License_Mari.layout_DES0846,csv(SEPARATOR('\t'),heading(1)))
													+dataset('~thor400_88::in::prolic::des0846::real_estate.txt',Prof_License_Mari.layout_DES0846,csv(SEPARATOR('\t'),heading(1)));

