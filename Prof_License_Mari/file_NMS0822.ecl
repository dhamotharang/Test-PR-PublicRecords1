// NMS0822 / New Mexico Real Estate Commission / Real Estate /
//NMS0822 has 2 input files now. This file is replaced by files_NMS0822. 3/26/13 Cathy Tio
export file_NMS0822 := dataset('~thor_data400::in::prolic::NMS0822::companies.txt',Prof_License_Mari.layout_NMS0822.LAYOUT_COMPANY,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)));