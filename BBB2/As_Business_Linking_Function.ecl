import ut;
/////////////////////////////////////////////////////////////////////////////////////////
// -- As_Business_Linking_Function
// -- Parameters:
// -- 	blnk_data:		input dataset for business linking already mapped into the 
// --					layout_business_linking layout
// -- 	use_filter:		filter created for the LN property file to remove the many
// --					non businesses(family, trusts, estates, wills, etc)
// -- 	fix_company_nam:	Fixes records with DBA and/or Lessor/Lessee in the name
// -- 	rollup_group1_id:	This rolls up the records across group1_id.  It only needs
// --					to be run on incoming datasets that have been normalized
/////////////////////////////////////////////////////////////////////////////////////////
export As_Business_Linking_Function(
       dataset(business_header.Layout_Business_Linking.Company_) blnk_data, 
	  boolean use_filter = true, 
	  boolean fix_company_name = true,
	  boolean rollup_group1_id = true
	  ) := FUNCTION

numset := ['0','1','2','3','4','5','6','7','8','9'];
bh_layout := business_header.Layout_Business_Linking.Company_;

/////////////////////////////////////////////////////////////////////////////////////////
// -- RemoveEnd Function
// -- Code to remove garbage from end of line
/////////////////////////////////////////////////////////////////////////////////////////
string RemoveEnd(string s) := 
function
	string rs := trim(Stringlib.StringReverse(s));
	string lw := Stringlib.StringReverse(trim(rs[1..(Stringlib.StringFind(rs, ' ', 1) - 1)]));
	string ts := trim(Stringlib.StringReverse(trim(rs[(Stringlib.StringFind(rs, ' ', 1)+1)..])));

	string res2 := if(((lw[1] = '(' and lw[length(trim(lw))] = ')') or
                  (lw[1] in numset and lw[length(trim(lw))] in numset) or
		Stringlib.StringFilterOut(lw, '0123456789!@#$%^&*()_-=+{}|<>?,.') = '') and lw[1] <> '#', 
                 ts, s);
	string res := if(stringlib.stringfind(res2, '#',1) != 0, res2, regexreplace('[0-9 !@#$%^&*()_=+{}|<>?,.-]+$',res2,''));
     
	return res;
END;

alphaset := ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q',
			 'R','S','T','U','V','W','X','Y','Z'];

/////////////////////////////////////////////////////////////////////////////////////////
// -- fixlessor Function
// -- Take out LESSEE, LESSOR, LSE, LSR from the string
/////////////////////////////////////////////////////////////////////////////////////////
string fixlessor(string s) := 
function

	integer slength := length(s);
	/////////////////////////////////////////////////////////////////////////////////////////
	// -- Find strings 'LSR', 'LESSOR', 'LSE', 'LESSEE' in string
	// -- and make sure they are not part of a larger word
	/////////////////////////////////////////////////////////////////////////////////////////
	integer lsrmatchindex := stringlib.stringfind(s,'LSR',1);
	boolean lsrbyitself   := map(lsrmatchindex > 1 and lsrmatchindex < slength and s[lsrmatchindex - 1] not in alphaset and s[lsrmatchindex + 3] not in alphaset => true,
		lsrmatchindex = 1 and s[lsrmatchindex + 3] not in alphaset => true, false);
		
	integer lessormatchindex := stringlib.stringfind(s,'LESSOR',1);
	boolean lessorbyitself   := map(lessormatchindex > 1  and lessormatchindex < slength and s[lessormatchindex - 1] not in alphaset and s[lessormatchindex + 6] not in alphaset => true,
		lessormatchindex = 1 and s[lessormatchindex + 6] not in alphaset => true, false);

	integer lsematchindex := stringlib.stringfind(s,'LSE',1);
	boolean lsebyitself   := map(lsematchindex > 1 and lsematchindex < slength and s[lsematchindex - 1] not in alphaset and s[lsematchindex + 3] not in alphaset => true,
		lsematchindex = 1 and s[lsematchindex + 3] not in alphaset => true, false);
		
	integer lesseematchindex := stringlib.stringfind(s,'LESSEE',1);
	boolean lessebyitself   	:= map(lesseematchindex > 1 and lesseematchindex < slength and s[lesseematchindex - 1] not in alphaset and s[lesseematchindex + 6] not in alphaset => true,
		lesseematchindex = 1 and s[lesseematchindex + 6] not in alphaset => true, false);

	/////////////////////////////////////////////////////////////////////////////////////////
	// -- If both LSE, LSR or LESSOR, LESSEE are in the string, blank it out(needs improvement)
	// -- else, remove the LSE, LSR or LESSOR, LESSEE from the string
	/////////////////////////////////////////////////////////////////////////////////////////
	string res := map(lsrmatchindex = 0 and lessormatchindex = 0 and lsematchindex = 0 and lesseematchindex = 0 => s,
		lsrmatchindex > 0 and lsrbyitself and lsematchindex > 0 and lsebyitself => '',
		lessormatchindex > 0 and lessorbyitself and lesseematchindex > 0 and lessebyitself => '',

		lsrmatchindex > 0 and lsrbyitself       => if(lsrmatchindex = 1, 	s[5.. ], s[1..(lsrmatchindex - 1)]),
		lessormatchindex > 0 and lessorbyitself => if(lessormatchindex = 1, s[8.. ], s[1..(lessormatchindex - 1)]),
		lsematchindex > 0 and lsebyitself       => if(lsematchindex = 1, 	s[5.. ], s[1..(lsematchindex - 1)]),
		lesseematchindex > 0 and lessebyitself  => if(lesseematchindex = 1, s[8.. ], s[1..(lesseematchindex - 1)]), s);

	return res;
end;

/////////////////////////////////////////////////////////////////////////////////////////
// -- fixdba Function
// -- Remove DBA from the string
/////////////////////////////////////////////////////////////////////////////////////////
string fixdba(string s) := 
function
	integer dbamatchindex 	:= stringlib.stringfind(s,'DBA',1);
	boolean dbabyitself   	:= map(dbamatchindex > 1 and s[dbamatchindex - 1] not in alphaset and s[dbamatchindex + 3] not in alphaset => true,
		dbamatchindex = 1 and s[dbamatchindex + 3] not in alphaset => true, false);
	string  res 			:= map(dbamatchindex = 0 => s,
		dbamatchindex > 0 and dbabyitself => if(dbamatchindex = 1, 	s[5.. ], s[1..(dbamatchindex - 1)]), s);
	
	return res;
end;

/////////////////////////////////////////////////////////////////////////////////////////
// -- Company Name filter to filter out most non-businesses
// -- TRUSTS, FAMILY, WILL OF, etc.
// -- name length > 5, zip and prim_name populated, 
/////////////////////////////////////////////////////////////////////////////////////////
dbhAsBusHdrCompanies		:=	if(use_filter, blnk_data(
								Datalib.CompanyClean(company_name)[41..120] <> '',
								length(trim(company_name)) >= 5,
								~((integer)zip = 0 and prim_name = ''),
								stringlib.stringfind(company_name,'00000',1) = 0,
								stringlib.stringfilterout(company_name,'1234567890-') 	!= '',
								stringlib.stringfilterout(company_name,'1234567890- ') != 'TU',
								(stringlib.stringfind(company_name,'TRUST',		 1) =  0 or
								 stringlib.stringfind(company_name,'BANK',		 1) != 0),
								stringlib.stringfind(company_name,'FAMILY',		 1) =  0,
								stringlib.stringfind(company_name,' TSTEE',		 1) =  0,
								stringlib.stringfind(company_name,'ESTATE OF',	 1) =  0,
								stringlib.stringfind(company_name,'WILL OF',		 1) =  0,
								stringlib.stringfind(company_name,'UNKNOWN SPOUSE',1) =  0,
								stringlib.stringfind(company_name,'NOT AVAILABLE', 1) =  0),
							blnk_data);
								
								
								
bh_layout fixcompanyname(bh_layout L) := 
transform
	self.company_name 	:= if(stringlib.stringfind(L.company_name,'%',1) > 0, 
						fixdba(fixlessor(removeend(l.company_name[1..(stringlib.stringfind(l.company_name,'%',1) - 1)]))),
						fixdba(fixlessor(removeend(l.company_name))));
	self 			:= L;
end;


dbhAsBusHdrCompanies_fixed := if(fix_company_name,
                                 project(dbhAsBusHdrCompanies, fixcompanyname(left)),
						   dbhAsBusHdrCompanies);
								
dbhAsBusHdrCompaniesDedup  := dedup(dbhAsBusHdrCompanies_fixed(company_name != ''),company_name,vendor_id,prim_name,prim_range,all);	// we don't really have to dedup as the RIDing technology does that


//////////////////////////////////////////////////////////////////////////////////////////
// -- Rollup on group1_id
// -- This needs to only be performed if the incoming dataset was normalized
//////////////////////////////////////////////////////////////////////////////////////////
from_bh_norm_dist := distribute(dbhAsBusHdrCompaniesDedup, hash(group1_id, ut.CleanCompany(company_name)));
from_bh_norm_sort := sort(from_bh_norm_dist, group1_id, ut.CleanCompany(company_name),  -zip, -state, -city, local);

bh_layout RollupbhNorm(bh_layout l, bh_layout r) := 
transform
	self := l;
end;

from_bh_norm_rollup := rollup(from_bh_norm_sort,
                              left.group1_id = right.group1_id and
						ut.CleanCompany(left.company_name) = ut.CleanCompany(right.company_name) and
						((left.zip 		= right.zip 		and
						  left.prim_name 	= right.prim_name 	and
						  left.prim_range 	= right.prim_range 	and
						  left.city 		= right.city 		and
						  left.state 		= right.state)
							  or
						  (right.zip 		= 0  and
						   right.prim_name 	= '' and
						   right.prim_range = '' and
					        right.city 		= '' and
						   right.state 	= '')
						),
							  RollupbhNorm(left, right),
							  local);

// Calculate stat to determine count by group_id
Layout_Group_List := 
record
	from_bh_norm_rollup.group1_id;
end;

bh_group_list := table(from_bh_norm_rollup, Layout_Group_List);

Layout_Group_Stat := 
record
	bh_group_list.group1_id;
	cnt := count(group);
end;

bh_group_stat := table(bh_group_list, Layout_Group_Stat, group1_id);

// Clean single group ids and format
bh_layout FormatToBHF(bh_layout L, Layout_Group_Stat R) := 
transform
	self.group1_id := R.group1_id;
	self 		:= L;
END;

bh_group_clean := join(from_bh_norm_rollup,
                         bh_group_stat(cnt > 1),
                         left.group1_id = right.group1_id,
                         FormatToBHF(left, right),
                         left outer,
                         lookup);
					
roll_ready := if(rollup_group1_id,bh_group_clean,dbhAsBusHdrCompaniesDedup);					

//////////////////////////////////////////////////////////////////////////////////////////
// -- Final Rollup
//////////////////////////////////////////////////////////////////////////////////////////
bh_layout Rollupbh(bh_layout L, bh_layout R) := 
transform
	self.dt_first_seen 			:= 
            ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
		    ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	self.dt_last_seen 			:= ut.LatestDate(L.dt_last_seen,				R.dt_last_seen);
	self.dt_vendor_last_reported	:= ut.LatestDate(L.dt_vendor_last_reported, 		R.dt_vendor_last_reported);
	self.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, 	R.dt_vendor_first_reported);
	self.company_name 			:= if(L.company_name = '', 	R.company_name, L.company_name);
	self.group1_id 			:= if(L.group1_id = 0, 		R.group1_id, L.group1_id);
	self.vendor_id 			:= if((L.group1_id = 0 and R.group1_id <> 0) or
								L.vendor_id = '', 		R.vendor_id, 	L.vendor_id);
	self.source_group 			:= if((L.group1_id = 0 and R.group1_id <> 0) or
								L.source_group = '', 	R.source_group,L.source_group);
	self.phone 				:= if(L.phone = 0, 	R.phone, 		L.phone);
	self.phone_score 			:= if(L.phone = 0, 	R.phone_score, L.phone_score);
	self.fein 				:= if(L.fein  = 0, 	R.fein, 		L.fein);
	self.prim_range 			:= if(l.prim_range = '' 	and l.zip4 = 0, r.prim_range, l.prim_range);
	self.predir 				:= if(l.predir = '' 	and l.zip4 = 0, r.predir, 	l.predir);
	self.prim_name 			:= if(l.prim_name = '' 	and l.zip4 = 0, r.prim_name, 	l.prim_name);
	self.addr_suffix 			:= if(l.addr_suffix = '' and l.zip4 = 0, r.addr_suffix,l.addr_suffix);
	self.postdir 				:= if(l.postdir = '' 	and l.zip4 = 0, r.postdir, 	l.postdir);
	self.unit_desig 			:= if(l.unit_desig = ''	and l.zip4 = 0, r.unit_desig, l.unit_desig);
	self.sec_range 			:= if(l.sec_range = '' 	and l.zip4 = 0, r.sec_range, 	l.sec_range);
	self.city 				:= if(l.city = '' 		and l.zip4 = 0, r.city, 		l.city);
	self.state 				:= if(l.state = '' 		and l.zip4 = 0, r.state, 	l.state);
	self.zip 					:= if(l.zip = 0 		and l.zip4 = 0, r.zip, 		l.zip);
	self.zip4 				:= if(l.zip4 = 0, 					 r.zip4, 		l.zip4);
	self.county 				:= if(l.county = '' 	and l.zip4 = 0, r.county, 	l.county);
	self.msa 					:= if(l.msa = '' 		and l.zip4 = 0, r.msa, 		l.msa);
	self.geo_lat 				:= if(l.geo_lat = '' 	and l.zip4 = 0, r.geo_lat, 	l.geo_lat);
	self.geo_long 				:= if(l.geo_long = '' 	and l.zip4 = 0, r.geo_long, 	l.geo_long);
	self := L;
END;

bh_clean_dist := distribute(roll_ready,
                    hash(zip, trim(prim_name), trim(prim_range), trim(source_group), trim(company_name)));
bh_clean_sort := sort(bh_clean_dist, zip, prim_range, prim_name, source_group, company_name,
                    if(sec_range <> '', 0, 1), sec_range,
                    if(phone <> 0, 	0, 1), phone,
                    if(fein <> 0, 		0, 1), fein,
                    dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, local);
bh_clean_rollup := rollup(bh_clean_sort,
					left.zip 			= right.zip 			and
					left.prim_name 	= right.prim_name 		and
					left.prim_range 	= right.prim_range 		and
					left.source_group 	= right.source_group 	and
			          left.company_name 	= right.company_name 	and
			          (right.sec_range = '' 	or left.sec_range 	= right.sec_range) 	and
					(right.phone = 0 		or left.phone 		= right.phone) 	and
			          (right.fein = 0 		or left.fein 		= right.fein),
                    Rollupbh(left, right),
                    local);
					
return bh_clean_rollup;
end;