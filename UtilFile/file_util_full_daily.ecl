import utilfile;
export file_util_full_daily := dataset('~thor_data400::in::utility::full_daily', utilfile.layout_util.base, flat)(record_date >= StartDate);