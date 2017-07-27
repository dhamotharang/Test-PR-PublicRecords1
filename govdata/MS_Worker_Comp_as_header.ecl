import header;

df := File_MS_Workers_Comp_In(employer_name!='DELETED');

header.Layout_New_Records into(df L) := transform
	self.did := 0;
	self.rid := 0;
	self.vendor_id := l.mwee_no+l.date_first_seen;
	self.dt_first_seen := (integer)if((integer)l.date_claim_filed<=20,if((integer)l.date_of_injury<=20,'0',l.date_of_injury[1..6]),l.date_claim_filed[1..6]);
	self.dt_last_seen := (integer)if((integer)l.date_claim_filed<=20,if((integer)l.date_of_injury<=20,'0',l.date_of_injury[1..6]),l.date_claim_filed[1..6]);
	self.dt_vendor_first_reported := (integer)if((integer)l.date_claim_filed<=20,if((integer)l.date_of_injury<=20,'0',l.date_of_injury[1..6]),l.date_claim_filed[1..6]);
	self.dt_vendor_last_reported := (integer)if((integer)l.date_claim_filed<=20,if((integer)l.date_of_injury<=20,'0',l.date_of_injury[1..6]),l.date_claim_filed[1..6]);
	self.dt_nonglb_last_seen := (integer)if((integer)l.date_claim_filed<=20,if((integer)l.date_of_injury<=20,'0',l.date_of_injury[1..6]),l.date_claim_filed[1..6]);
	self.rec_type := '2';
	self.src := 'MW';
	self.ssn := l.claimant_ssn;
	self.dob := 0;
    self.title := l.claim_name_prefix;
    self.fname := l.claim_name_first;
	self.mname := l.claim_name_middle;
	self.lname := l.claim_name_last;
	self.name_suffix := l.claim_name_suffix;
	self.prim_range := l.claimant_prim_range;
	self.predir := l.claimant_predir;
	self.prim_name := l.claimant_prim_name;
	self.suffix := L.claimant_addr_suffix;
	self.postdir := l.claimant_postdir;
	self.unit_desig := l.claimant_unit_desig;
	self.sec_range := l.claimant_sec_range;
	self.city_name := L.claimant_v_city_name;
	self.st := l.claimant_st;
	self.zip := l.claimant_zip5;
	self.zip4 := l.claimant_zip4;
	self.county := l.claimant_fipscounty;
	self.cbsa := l.claimant_msa + '0';
	self.geo_blk := l.claimant_geo_blk;
	self.pflag1 := '';
	self.pflag2 := '';
	self.pflag3 := '';
	self.jflag1 := '';
	self.jflag2 := '';
	self.jflag3 := '';
	self.phone := '';
end;


export MS_Worker_Comp_as_header := project(df,into(left))(prim_name!='' and lname!='');