import header, ut;

#workunit('name', 'Matrix DL Build ' + Matrix_DL.Version_Development);

if(ut.DaysApart(ut.GetDate, Matrix_DL.Version_Development) >= 10,
	fail('Please check Matrix_DL.Version_Development.')
  );

lDL_Patched := Matrix_DL.DLs_With_DIDs;

//dl_patched := Drivers.DL;
d := lDL_Patched;

//** general check
output(choosen(d(dt_first_seen > dt_last_seen), 1000));
count(d(dt_first_seen > dt_last_seen)); //should be zero

stat_rec := record
  d.orig_state;
  counted := count(group);
  pcnt_did := AVE(GROUP,IF(d.did=0,0,100));
  pcnt_preglb := AVE(GROUP,IF(d.preglb_did=0,0,100));
  pcnt_ssn := AVE(GROUP,IF((unsigned8)d.ssn=0,0,100));
  pcnt_historic := AVE(GROUP,IF(d.history='H',100,0));
  pcnt_expired := AVE(GROUP,IF(d.history='E',100,0));
  end;

ta := table(lDL_Patched,stat_rec,d.orig_state);

output(ta);

output(lDL_Patched,,'BASE::Matrix_DL_' + Matrix_DL.Version_Development,overwrite);

string8 fGoodDateToString(integer pDateIn) := if(pDateIn < 190000,'',(string8)pDateIn);

Matrix_DL.Layout_Moxie despray(Matrix_DL.Layout_Common l) := transform
	self.did := if(l.did = 0, '', intformat(l.did,12,1));
	self.preGLB_did := if(l.preGLB_did = 0, '', intformat(l.preGLB_did,12,1));
	self.ssn := if((integer8)l.ssn = 0, '', l.ssn);
    self.dob := fGoodDateToString(l.dob);
    self.orig_expiration_date := fGoodDateToString(l.orig_expiration_date);
    //self.expiration_date := fGoodDateToString(l.expiration_date);
    self.lic_issue_date := fGoodDateToString(l.lic_issue_date);
    //self.active_date := (string8)l.active_date;
    //self.inactive_date := (string8)l.inactive_date;
    self.dl_orig_issue_date := fGoodDateToString(l.orig_issue_date);
    self.status := IF( l.history='','A','I' );
	self := l;
end;

//  Making sure that the "NON" records from Wisconsin don't get in.  These are the
//  records that are added to Wisconsin's file for traffic convictions for people
//  who do not have Wisconsin DLs.
outfile := project(lDL_Patched,despray(left));

dodgy_states := [''];

output(outfile(orig_state IN dodgy_states),,'OUT::Matrix_DL_Dev',overwrite);
output(outfile(~orig_state IN dodgy_states),,'OUT::Matrix_DL_Moxie',overwrite);