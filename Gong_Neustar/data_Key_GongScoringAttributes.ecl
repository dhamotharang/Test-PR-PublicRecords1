IMPORT $, dx_Gong;

file := $.fn_phone_scoring_attributes($.File_Master(current_record_flag = 'Y'));

EXPORT data_key_GongScoringAttributes := PROJECT(file, dx_Gong.layouts.i_scoring_attributes);
