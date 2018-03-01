EXPORT mac_contacts
(infile, outf_clean, outf_dirty, 
  infile_field_DID = 'contact_did', infile_field_SSN = 'contact_ssn', infile_field_fname = 'contact_name.fname', infile_field_lname = 'contact_name.lname',
	infile_field_cname = 'company_name', infile_field_fein = 'company_fein'
) :=
MACRO

import ut, BIPV2_Suppression, Suppress, AutoStandardI;


apptype := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
Suppress.MAC_Suppress(infile,suppressed1,						/*inApplicationType:=*/apptype,Suppress.Constants.LinkTypes.SSN,infile_field_SSN,,,/*batch:=*/false);
Suppress.MAC_Suppress(suppressed1,suppressed2,			/*inApplicationType:=*/apptype,Suppress.Constants.LinkTypes.DID,infile_field_DID,,,/*batch:=*/false);

c := BIPV2_Suppression.ds_contacts;
rsamp := recordof(infile);

temprec := record
	rsamp;
	boolean dirty;
end;

ccname(string s) := stringlib.stringfilter(s, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' + '&#$@ 1234567890')[1..10];//filter out all but these for the match

j :=
join(
	suppressed2,
	c(person.lname <> ''),
	left.infile_field_lname = right.person.lname AND //need some kind of hard match to avoid costly ALL join
	//check match against contact	
	(
	 (left.infile_field_DID  > 0  and left.infile_field_DID = right.person.DID) or 
	 (left.infile_field_SSN <> '' and left.infile_field_SSN = right.person.ssn) or 
	 (left.infile_field_fname <> '' and left.infile_field_fname = right.person.fname)
	)
	AND
	//check match against biz
	(
	 (left.ultid > 0 and left.ultid = right.biz.id) or
	 (left.infile_field_cname <> '' and ut.WithinEditN( ccname(left.infile_field_cname), ccname(right.biz.company_name), 1)) or
	 (left.infile_field_fein <> '' and left.infile_field_fein = right.biz.fein) or
	 right.biz.suppressAtAnyCompany
	)
	
	//need to account for permissions?  show info if user is LE, for example?  TODO
	
	,transform(
		temprec,
		self.dirty := right.bug_num > 0,
		self := left
	),
	left outer,
	lookup
);

outf_clean := project(j(~dirty), rsamp);
outf_dirty := project(j( dirty), rsamp);

/*
dirty := 
//biz here
samp.ultid in set(c, biz.id)	//more logic here.  this is simplified version
//and contact here
and
samp.infile_field_fname in set(c, person.fname) //ditto

//and account for permissions?  if law enforcement, for example, seems we should show everything
;

outf_clean := samp(not dirty);
outf_dirty := samp(dirty);
*/

ENDMACRO;