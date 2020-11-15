IMPORT doxie, dx_fcra_opt_out;

f_optout := fcra_opt_out.file_infile_appended;
ds := PROJECT(f_optout((unsigned) ssn<>0),TRANSFORM(dx_fcra_opt_out.layouts.i_ssn,SELF.l_ssn:=(unsigned6)LEFT.ssn,SELF:=LEFT));

EXPORT data_key_ssn := DEDUP(SORT(DISTRIBUTE(ds),RECORD,LOCAL),RECORD,LOCAL);