import liensv2,doxie_cbrs,LiensV2_Services,codes;

inrec := recordof(LiensV2_Services.liens_raw.moxie_view.by_rmsid(dataset([],liensv2_services.layout_rmsid),''));

export Fn_LienBackwards(
	dataset(inrec) lie) :=
FUNCTION


rec := doxie.layout_LienBackwards;

//****** DEBTOR
deb := lie(name_type = 'D');


//***** FIND PLAINTIFF
cred_rec := {lie.tmsid, lie.rmsid, lie.orig_name, lie.title, lie.fname, lie.mname, lie.lname, lie.name_suffix, lie.cname, lie.name_score};
cred := dedup(project(lie(name_type = 'C'), cred_rec), all);


fixz(string s) := if((integer8)s = 0, '', s);

rec tra(lie l, cred r) := transform
	self.did 							:= fixz(l.did);
	self.bdid 						:= fixz(l.bdid);
	self.courtid					:= l.filing_jurisdiction;
	self.court_desc 			:= l.agency;
	self.filingtype_desc 	:= l.filing_type_desc;
	self.filing_state 		:= l.filing_state;
	self.casenumber 			:= if(l.case_number <> '', l.case_number, l.filing_number);
	self.book 						:= l.filing_book;
	self.page 						:= l.filing_page;
	self.filing_date 			:= l.orig_filing_date;
	self.release_date 		:= l.release_date;
	self.amount 					:= l.amount;
	self.othercase 				:= l.irs_serial_number;
	self.unlawdetyn				:= l.eviction;
	self.origcase         := l.orig_filing_number;
	self.rmsid						:= l.rmsid;
	
	self.orig_ssn 				:= l.ssn;
	self.defname 					:= l.orig_name;
	self.generation				:= l.orig_suffix;

	self.def_title        := l.title;
	self.def_fname        := l.fname;
	self.def_mname        := l.mname;
	self.def_lname        := l.lname;
	self.def_name_suffix  := l.name_suffix;
	self.def_company			:= l.cname;
	self.def_name_score		:= l.name_score;
	
	// *** from rhs ***
	self.plaintiff      		:= r.orig_name;
	self.plain_title 				:= r.title;
	self.plain_fname 				:= r.fname;
	self.plain_mname 				:= r.mname;
	self.plain_lname 				:= r.lname;
	self.plain_name_suffix  := r.name_suffix;
	self.plain_company 			:= r.cname;
	self.plain_name_score		:= r.name_score;
	
	self.prim_range				:= l.prim_range;
	self.predir						:= l.predir;
	self.prim_name 				:= l.prim_name;
	self.suffix        		:= l.addr_suffix;
	self.postdir          := l.postdir;
	self.unit_desig       := l.unit_desig;
	self.sec_range        := l.sec_range;
	self.p_city_name      := l.p_city_name;
	self.v_city_name      := l.v_city_name;
	self.state            := l.st;
	self.zip              := l.zip;
	self.zip4             := l.zip4;
	
	self.address					:= l.orig_address1;
	self.orig_city				:= l.orig_city;
	self.orig_state				:= l.orig_state;
	self.orig_zip					:= l.orig_zip5;
	
	self.cart							:= l.cart;
	self.cr_sort_sz				:= l.cr_sort_sz;
	self.lot							:= l.lot;
	self.lot_order 				:= l.lot_order;
	self.dbpc							:= l.dbpc;
	self.chk_digit				:= l.chk_digit;
	self.rec_type					:= l.rec_type;
	self.county						:= l.county;
	self.geo_lat					:= l.geo_lat;
	self.geo_long					:= l.geo_long;
	self.msa							:= l.msa;
	self.geo_blk					:= l.geo_blk;
	self.geo_match				:= l.geo_match;
	self.err_stat					:= l.err_stat;
	
	self.state_mapped 		:= codes.general.state_long(l.st);
	
	self := [];
end;

j := join(deb, cred, 
		  left.tmsid = right.tmsid and
		  left.rmsid = right.rmsid,
		  tra(left, right),
		  left outer);
// output(deb, named('deb'));
// output(cred, named('cred'));
return sort(j, record);

END;