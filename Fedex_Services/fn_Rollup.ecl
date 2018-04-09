import ut, NID;
rec := fedex_services.Layouts.out;

export fn_Rollup(
	dataset(rec) l):= 
FUNCTION
//if address is associated with both business and residential, return as residential
//add sec_range where we can
//any danger in rolling up the zip4?

IsOneBizAndOnePerson(string lcname,string rcname, string llname, string rlname) := 
	(lcname <> '' and rcname = '' and llname = '' and rlname <> '') or
	(rcname <> '' and lcname = '' and rlname = '' and llname <> '');

c(string l, string r) := if(l <> '', l, r);

s := sort(l, prim_range, prim_name, zip5, lname, NID.PreferredFirstNew(fname), company_name, phone, -dt_last_seen, 
					if(lname = company_name, 1, 0)); //some of the fedex records have lname = cname and i want to handle those below
r := 
	rollup(
		s,
		left.prim_range = right.prim_range and
		left.prim_name = right.prim_name and 
		left.zip5 = right.zip5 and
		not IsOneBizAndOnePerson(left.company_name, right.company_name, left.lname, right.lname) and
		(
			(ut.NameMatch(left.fname,'',left.lname,right.fname,'',right.lname) <= 2 or 
				(ut.NNEQ(NID.PreferredFirstNew(left.fname), NID.PreferredFirstNew(right.fname)) and 
				 ut.NNEQ(left.lname, right.lname))
			)
			OR
			(left.isFedexRecord and right.isFedexRecord and  //this handles a special case where we created two fedex records from one (see phone = 6012639811)
			 left.company_name = right.company_name and
			 right.company_name = right.lname
			)
		)
		and 
		ut.NNEQ(left.company_name, right.company_name) and 
		ut.NNEQ(left.phone, right.phone),  
		transform(
			rec,
			self.sec_range 		:= c(left.sec_range, right.sec_range),
			self.zip4 		 		:= c(left.zip4, right.zip4),
			self.fname 		 		:= c(left.fname, right.fname),		
			self.lname 		 		:= c(left.lname, right.lname),
			self.company_name := c(left.company_name, right.company_name),
			self.phone 		 		:= c(left.phone, right.phone),
			self.address_type := if(right.address_type = fedex_services.Contants.str_Residential, right.address_type, left.address_type),
			self.internal_src := //keep track of all the srcs for a result record
				if(
					right.internal_src <> '' and 
					not stringlib.StringContains(left.internal_src, right.internal_src, false),
					trim(left.internal_src, left, right) + trim(right.internal_src, left, right),
					left.internal_src
				);
			self.dt_last_seen := max(left.dt_last_seen, right.dt_last_seen),
			self.exact_lname_match 		:= left.exact_lname_match 	or right.exact_lname_match;
			self.leading_lname_match 	:= left.leading_lname_match or right.leading_lname_match;
			self := left
		)
	);
		 

return r;

END;