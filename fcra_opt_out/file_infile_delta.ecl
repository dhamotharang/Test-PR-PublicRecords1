IMPORT Std;
EXPORT file_infile_delta(STRING filedate = (STRING)Std.Date.Today()) := DATASET($.FileNames(filedate).Base.Delta.new,$.layout_infile_appended,THOR);