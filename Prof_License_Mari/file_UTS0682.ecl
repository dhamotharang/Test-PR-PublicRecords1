// UTS0682 / Utah Department of Financial Institutions / Mortgage Lenders //

export file_UTS0682 := dataset('~thor_data400::in::proflic_mari::uts0682::using::mtg_license',Prof_License_Mari.layout_UTS0682.common,csv(SEPARATOR(','),quote('"'),TERMINATOR('\n')));