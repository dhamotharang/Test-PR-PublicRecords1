import Email_Data;
/*

allowed sources:

Alloy
Thrive Pay Day
iBehavior
Infutor
*/

sources := ['AO','T$','IB','!I'];

EXPORT Email_merge(dataset(layout_2015) ds) := function

	email := DEDUP(SORT(DISTRIBUTE(Email_Data.File_Email_Base(did<>0,email_src in sources), did), did, -date_last_seen, LOCAL), did, LOCAL)
									: PERSIST('~thor::census_rfp::email_data');
	
	src := DISTRIBUTE(ds, LexId);
	
	j := JOIN(src, email, left.LexId=right.did, TRANSFORM(layout_2015,
							self.email_address := right.clean_email;
							self.email_address_activity_date := right.date_last_seen;
							self := left;), LEFT OUTER, KEEP(1), LOCAL);
	
	return j;
END;