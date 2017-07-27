import ut, fbi_ucr;

file_offenses_city := dataset('~thor_data400::in::fbi::ucr_by_city', fbi_ucr.layouts.layout_offenses_city, csv(heading(1)));

export file_CIUS_city := file_offenses_city;
