IMPORT doxie, dx_fcra_opt_out;

f_optout := fcra_opt_out.file_infile_appended;
ds := PROJECT(f_optout(did<>0),TRANSFORM(dx_fcra_opt_out.layouts.i_did,SELF.l_did:=LEFT.did,SELF:=LEFT));

EXPORT data_key_did := DEDUP(SORT(DISTRIBUTE(ds),RECORD,LOCAL),RECORD,LOCAL);