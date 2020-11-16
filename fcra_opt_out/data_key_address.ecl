import doxie, dx_fcra_opt_out;

f_optout := fcra_opt_out.file_infile_appended;

ds := PROJECT(f_optout(z5<>'' and prim_range <> '' and prim_name <> ''),
              TRANSFORM(dx_fcra_opt_out.layouts.i_address,SELF:=LEFT));

EXPORT data_key_address := DEDUP(SORT(DISTRIBUTE(ds),RECORD,LOCAL),RECORD,LOCAL);