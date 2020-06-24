import AutoStandardI, doxie, ut;

rec := doxie.Layout_Comp_Addresses;

export fn_addLVV(
	dataset(rec) ca) := 
MODULE

/*
THE ACCURINT (LEGACY) DEFINITION OF VERIFIED IS (updated by lee l. via bug 41062)

1) locate header records for the subject

2) for header records which contain a phone number, assign a
verified/not-verified tag

2a) If the header date_last_seen is more than (>=) 60 months old, the
number is "not verified"

2b) If the header date_last_seen is less than 60 months old, use the
phone number, and do a lookup in gong.   If there is a match on last
name, then set the verified tag.

THIS LOOKS FOR THOSE SITUATIONS, AND SETS TNT AND LISTED PHONE SUCH THAT ESP WILL MARK THE ADDRESS AS VERIFIED.
SEE ADDRESS.isVerified FOR ESP LOGIC
*/

global_mod := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);

var_string := dedup(ca,prim_range,prim_name,zip,sec_range,predir,all);

outf := doxie.layout_AppendGongByAddr_input;

outf fixComp(var_string L) := transform 
  self.listing_name := '';
  self.phone := '';
	self.timezone := '';
  self := l;
end;

a := project(var_string,fixComp(left));

p := doxie.fn_AppendGongByAddr(a,mod_access);

j := 
	join(
		ca, 
		p,
		(left.dt_last_seen = 0 or ut.age(left.dt_last_seen * 100) < 5) and //2a - not positive about the zero here, but want to be conservative to start
		left.prim_name = right.prim_name and
		left.prim_range = right.prim_range and
		left.zip = right.zip and
		ut.NNEQ(left.sec_range, right.sec_range) and
		(ut.StringSimilar100(left.lname, right.lname) <= 30 or
     ut.isNamePart (right.lname, trim (left.lname), true) or
		 ( right.lname = '' and length(trim(left.lname)) > 1 and
       ut.isNamePart (right.listing_name, trim (left.lname), true)
	   )
		),
		transform(
			rec,
			self.tnt := if(right.zip <> '', 'V', 'H'),  //V triggers a verified address, but tnt is not exposed past ESP
			self.listed_phone := right.phone,										
			self := left
		),
		left outer
	);
	
//dedup from join (choosing best by join criteria above)
d := dedup(sort(j, address_seq_no, if(tnt = 'V', 0, 1)), address_seq_no);

//group by did and sort the best address to the top within each one
g := group(d, did);
s := sort(g, if(tnt = 'V', 0, 1), address_seq_no);
shared u := ungroup(s);


// output(ca, named('ca'));
// output(p, named('pp'));
// output(j, named('jj'));
// output(u, named('uu'));

export records_wListedPhone := u;
export records := project(u, transform(rec, self.listed_phone := '', self := left));//this triggers a verified address, and is currently not used elsewhere in comp report


// return u;

END;