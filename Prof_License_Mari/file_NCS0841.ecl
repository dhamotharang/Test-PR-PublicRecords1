//Raw professional license file from the source NCS0841
//Convert from xls file to tab delimited txt file and name NCAppraisal.txt

export file_NCS0841 := dataset('~thor_data400::in::proflic_mari::ncs0841::using::rle_license',Prof_License_Mari.layout_NCS0841.src,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\r\n')));