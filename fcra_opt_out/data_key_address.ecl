IMPORT doxie, dx_fcra_opt_out, Std;
EXPORT data_key_address(STRING filedate = (STRING)Std.Date.Today(), BOOLEAN isDeltaBuild = FALSE) := FUNCTION

    // DF-28230 add delta build functionality
    ds_full     := PROJECT(fcra_opt_out.file_infile_appended(z5<>'' and prim_range <> '' and prim_name <> ''),TRANSFORM(dx_fcra_opt_out.layouts.i_address,SELF:=LEFT));
    ds_prev     := PROJECT(FCRA_OPT_OUT.file_base_previous(z5<>'' and prim_range <> '' and prim_name <> ''),TRANSFORM(dx_fcra_opt_out.layouts.i_address,SELF:=LEFT));
    ds_delta    := PROJECT(fcra_opt_out.file_infile_delta(filedate)(z5<>'' and prim_range <> '' and prim_name <> ''),TRANSFORM(dx_fcra_opt_out.layouts.i_address,SELF:=LEFT));
    ds_new      := JOIN(DISTRIBUTE(ds_prev,HASH(z5,prim_range,prim_name)),DISTRIBUTE(ds_delta,HASH(z5,prim_range,prim_name)),LEFT=RIGHT,RIGHT ONLY,LOCAL);
    ds          := DEDUP(SORT(DISTRIBUTE(IF(isDeltaBuild,ds_new,ds_full)),RECORD,LOCAL),RECORD,LOCAL);
    RETURN ds;   

END;