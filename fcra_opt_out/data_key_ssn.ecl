IMPORT doxie, dx_fcra_opt_out, Std;
EXPORT data_key_ssn(STRING filedate = (STRING)Std.Date.Today(), BOOLEAN isDeltaBuild = FALSE) := FUNCTION

    // DF-28230 add delta build functionality
    ds_full     := PROJECT(fcra_opt_out.file_infile_appended((unsigned) ssn<>0),TRANSFORM(dx_fcra_opt_out.layouts.i_ssn,SELF.l_ssn:=(unsigned6)LEFT.ssn,SELF:=LEFT));
    ds_prev     := PROJECT(FCRA_OPT_OUT.file_base_previous((unsigned) ssn<>0),TRANSFORM(dx_fcra_opt_out.layouts.i_ssn,SELF.l_ssn:=(unsigned6)LEFT.ssn,SELF:=LEFT));
    ds_delta    := PROJECT(fcra_opt_out.file_infile_delta(filedate)((unsigned) ssn<>0),TRANSFORM(dx_fcra_opt_out.layouts.i_ssn,SELF.l_ssn:=(unsigned6)LEFT.ssn,SELF:=LEFT));
    ds_new      := JOIN(DISTRIBUTE(ds_prev,l_ssn),DISTRIBUTE(ds_delta,l_ssn),LEFT=RIGHT,RIGHT ONLY,LOCAL);
    ds          := DEDUP(SORT(DISTRIBUTE(IF(isDeltaBuild,ds_new,ds_full)),RECORD,LOCAL),RECORD,LOCAL);
    RETURN ds;   

END;