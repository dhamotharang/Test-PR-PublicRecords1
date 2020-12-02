// DF-28230: This is the delta rid for thor_data400::base::fcra::qa::optout_weekly / 
//                                     thor_data400::base::fcra::qa::optout_weeklyoptout_monthly
IMPORT dx_common;

f_base  := DATASET([],$.layout_infile_appended);

EXPORT data_key_delta_rid := PROJECT(f_base, TRANSFORM(dx_common.layout_ridkey, SELF := LEFT));
