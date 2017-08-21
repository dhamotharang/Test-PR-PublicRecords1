Layout_Eq_Employer_New :=
record
	unsigned6 DID 								:= 0;
	unsigned1 DID_score						:= 0;
	unsigned3 dt_first_seen				:= 0;
	unsigned3 dt_last_seen				:= 0;
	qstring15 orig_fname							;
	qstring15	orig_minitial						;
	qstring25	orig_lname							;
	string2		orig_name_suffix				;
	qstring57	orig_address						;
	qstring20	orig_city								;
	string2		orig_state							;
	qstring5	orig_zip								;
	qstring8	dob											;
	qstring9	ssn											;
	qstring10	phone										;
	qstring35 occupation_employer			;
	qstring35 occupation_position			;
  string1		employer_type						;
	qstring5	title								:= '';
	qstring20	fname								:= '';
	qstring20	mname								:= '';
	qstring20	lname								:= '';
	qstring5	name_suffix					:= ''; 
	qstring10	prim_range					:= '';
	string2		predir							:= '';
	qstring28	prim_name						:= '';
	qstring4	suffix							:= '';
	string2		postdir							:= '';
	qstring10	unit_desig					:= '';
	qstring8  sec_range						:= '';
	qstring25 city								:= '';
	string2   st									:= '';
	qstring5  zip									:= '';
	qstring4  zip4								:= '';
end;

eqfile	:= dataset('~thor_data400::base::eq_employer_200009',header.Layout_Eq_Employer,flat);
bst_hdr	:= Watchdog.File_Best_nonglb;


Layout_Eq_Employer_New tJoin2Watchdog(header.Layout_Eq_Employer l, bst_hdr r) :=
transform

	self.DID															:= l.did	;
	self.DID_score												:= 0			;
	self.dt_first_seen										:= l.dt_first_seen;
	self.dt_last_seen											:= l.dt_last_seen;
	self.orig_fname												:= l.fname;
	self.orig_minitial										:= r.mname;
	self.orig_lname												:= r.lname;
	self.orig_name_suffix									:= r.name_suffix;
	self.orig_address											:= Address.Addr1FromComponents(
																							r.prim_range,r.predir,r.prim_name,
																							r.suffix,r.postdir,r.unit_desig,r.sec_range);
	self.orig_city												:= r.city_name;
	self.orig_state												:= r.st;
	self.orig_zip													:= l.zip;
	self.dob															:= (qstring8)r.dob;	//need from header
	self.ssn															:= r.ssn;	//need from header
	self.phone														:= (qstring10)r.phone;
	self.occupation_employer							:= l.occupation_employer;
	self.occupation_position							:= l.occupation_position;
	self.employer_type										:= l.employer_type;		//need from eq employer file
	self.title 														:= r.title;
	self.fname 														:= r.fname;
	self.mname 														:= r.mname;
	self.lname 														:= r.lname;
	self.name_suffix 											:= r.name_suffix;
	self.prim_range 											:= r.prim_range;
	self.predir 													:= r.predir;
	self.prim_name 												:= r.prim_name;
	self.suffix 													:= r.suffix;
	self.postdir 													:= r.postdir;
	self.unit_desig 											:= r.unit_desig;
	self.sec_range												:= r.sec_range;
	self.city															:= r.city_name;
	self.st																:= r.st;
	self.zip															:= r.zip;
	self.zip4															:= r.zip4;

end;

dJoin2Watchdog := join(
											 distribute(eqfile						, hash(did	))
											,bst_hdr
											,			left.did		= right.did
												and left.fname	= right.fname
											,tJoin2Watchdog(left,right)
//											,left outer
											,keep(1)
											,local
										);

//////////////////////////////////////
// -- Get rest from business contacts
//////////////////////////////////////

bceq := business_header.Files().Base.Business_Contacts_Plus.qa(source='QQ') 
				+ dataset(ut.foreign_dataland + '~thor_data400::base::business_header::20060606::contacts',business_header.Layout_Business_Contact_Full,flat)(source='QQ')
				+ dataset('~thor_data400::base::business_header::20070824b::contacts',business_header.Layout_Business_Contact_Full,flat)(source='QQ')
				+ dataset('~thor_data400::base::business_header::20071206b::contacts',business_header.Layout_Business_Contact_Full,flat)(source='QQ')
				+ dataset('~thor_data400::base::business_header::20080114b::contacts',business_header.Layout_Business_Contact_Full,flat)(source='QQ')
				;

Layout_Eq_Employer_New tJoinBc2Watchdog(business_header.Layout_Business_Contact_Full l, bst_hdr r) :=
transform

	self.DID															:= l.did	;
	self.DID_score												:= 0			;
	self.dt_first_seen										:= (unsigned3)((l.dt_first_seen - 1) / 100);
	self.dt_last_seen											:= (unsigned3)((l.dt_last_seen - 1) / 100);
	self.orig_fname												:= l.fname;
	self.orig_minitial										:= l.mname;
	self.orig_lname												:= l.lname;
	self.orig_name_suffix									:= l.name_suffix;
	self.orig_address											:= Address.Addr1FromComponents(
																							l.prim_range,l.predir,l.prim_name,
																							l.addr_suffix,l.postdir,l.unit_desig,l.sec_range);
	self.orig_city												:= l.city;
	self.orig_state												:= l.state;
	self.orig_zip													:= (qstring5)l.zip;
	self.dob															:= (qstring8)r.dob;	//need from header
	self.ssn															:= r.ssn;	//need from header
	self.phone														:= (qstring10)l.phone;
	self.occupation_employer							:= l.company_name;
	self.occupation_position							:= l.company_title;
	self.employer_type										:= if(l.record_type = 'C', 'C', 'F');		//need from eq employer file
	self.title 														:= l.title;
	self.fname 														:= l.fname;
	self.mname 														:= l.mname;
	self.lname 														:= l.lname;
	self.name_suffix 											:= l.name_suffix;
	self.prim_range 											:= l.prim_range;
	self.predir 													:= l.predir;
	self.prim_name 												:= l.prim_name;
	self.suffix 													:= l.addr_suffix;
	self.postdir 													:= l.postdir;
	self.unit_desig 											:= l.unit_desig;
	self.sec_range												:= l.sec_range;
	self.city															:= l.city;
	self.st																:= l.state;
	self.zip															:= (qstring5)l.zip;
	self.zip4															:= (qstring4)l.zip4;

end;


dJoinBC2Watchdog := join(
											 distribute(bceq						, hash(did	))
											,bst_hdr
											,			left.did		= right.did
												and left.fname	= right.fname
											,tJoinBc2Watchdog(left,right)
											,left outer
											,keep(1)
											,local
										);

full_file := dedup(sort(dJoin2Watchdog + dJoinBC2Watchdog	,did, fname, lname,employer_type,occupation_employer,occupation_position,zip,prim_range,prim_name,ssn,phone,dob,local)
																													,did, fname, lname,employer_type,occupation_employer,occupation_position,zip,prim_range,prim_name,ssn,phone,dob,local); 

versioncontrol.macBuildNewLogicalFile('~thor_data400::base::eq_norm_redid_200803'
								,full_file 
								,eq_employer_output
								,
								,
								,true
);


eq_employer_output