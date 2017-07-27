import header, ut;

/* Note: This contains temporary fix for ID dl_number.  We will want to do something
		 with DID ASAP.  Associated temp fix in ID_as_DL.

	NOTE:  This also contains a temporary fix for MICHIGAN to set all history
			field values to "U"

*/

#workunit('name', 'DL Build ' + Drivers.Version_Development);

if(ut.DaysApart(ut.GetDate, Drivers.Version_Development) >= 10, fail('Please check Drivers.Version_Development.'));


dl_patched := Drivers.DL;
d := dl_patched;

//** general check
output(choosen(d(dt_first_seen > dt_last_seen), 1000));
count(d(dt_first_seen > dt_last_seen)); //should be zero

stat_rec := record
  d.source_code;
  d.orig_state;
  counted := count(group);
  pcnt_did := AVE(GROUP,IF(d.did=0,0,100));
  pcnt_preglb := AVE(GROUP,IF(d.preglb_did=0,0,100));
  pcnt_ssn := AVE(GROUP,IF((unsigned8)d.ssn=0,0,100));
  pcnt_historic := AVE(GROUP,IF(d.history='H',100,0));
  pcnt_expired := AVE(GROUP,IF(d.history='E',100,0));
  end;

ta := table(dl_patched,stat_rec,d.source_code,d.orig_state);

output(ta);

output(dl_patched,,'BASE::FLDL_DID' + Drivers.Version_Development,overwrite);

Drivers.Layout_DL_ToMike despray(drivers.Layout_DL l) := transform
	self.did := if(l.did = 0, '', intformat(l.did,12,1));
	self.preGLB_did := if(l.preGLB_did = 0, '', intformat(l.preGLB_did,12,1));
    self.dob := (string8)l.dob;
    self.orig_expiration_date := if(l.orig_expiration_date<>0,
									(string8)l.orig_expiration_date,
									''
								   );
    //self.expiration_date := (string8)l.expiration_date;
    self.lic_issue_date := (string8)l.lic_issue_date;
    //self.active_date := (string8)l.active_date;
    //self.inactive_date := (string8)l.inactive_date;
    self.dl_orig_issue_date := (string8)l.orig_issue_date;
    self.status := IF( l.history='','A','I' );
	//IDAHO patch
	self.dl_number := if(l.dl_number[1..5]='LNID:','',l.dl_number);
	self.height := if((integer2)l.height = 0,'',l.height);
	self.weight := if((integer2)l.weight = 0,'',l.weight);
	//MICHIGAN patch
	self.history := if(l.orig_state='MI','U',l.History);
	self := l;
end;

//  Making sure that the "NON" records from Wisconsin don't get in.  These are the
//  records that are added to Wisconsin's file for traffic convictions for people
//  who do not have Wisconsin DLs.
outfile := project(dl_patched(~(orig_state='WI' and license_type='NON')), despray(left));

dodgy_states := [''];

output(outfile(orig_state IN dodgy_states),,'OUT::DL_ToDev',overwrite);
output(outfile(~orig_state IN dodgy_states),,'OUT::DL_ToMike',overwrite);