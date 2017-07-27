import header,ut;
sch_file := Bankrupt.File_BK_search(debtor_lname!='' and prim_name!='');
main_file := bankrupt.File_BK_Main;

h := header.Layout_Header;

h trans(sch_file le, main_file rt) := transform
  self.did := 0;
  self.rid := 0;
  self.src := 'BA';
  self.dt_first_seen := ut.mob(ut.min2((integer)rt.orig_filing_date, (integer)rt.date_filed));
  self.dt_last_seen := ut.mob(
  ut.max2(
  ut.max2((integer)rt.disposed_date, (integer) rt.reopen_date),
  ut.max2((integer)rt.converted_date, (integer)rt.date_filed)
  ));
  self.dt_vendor_last_reported := self.dt_last_seen;
  self.dt_vendor_first_reported := self.dt_first_seen;
  self.dt_nonglb_last_seen  := self.dt_last_seen;
  self.rec_type := '1';
  self.vendor_id := le.court_code+le.case_number+le.seq_number[6..10];
  self.dob := 0;
  self.ssn := if ((integer)le.orig_ssn=0,'',le.orig_ssn);
  self.city_name := le.v_city_name;
  self.phone := '';
  self.title := le.debtor_title;
  self.fname := le.debtor_fname;
  self.mname := le.debtor_mname;
  self.lname := le.debtor_lname;
  self.name_suffix := le.debtor_name_suffix;
  self.zip := le.z5;
  self.county := le.county[3..5];
  self.cbsa := if(le.msa!='',le.msa+'0','');
  self := le;
  end;

from_ba := join(sch_file,main_file,left.court_code=right.court_code and
									left.case_number=right.case_number and
									left.seq_number=right.seq_number,trans(left,right),hash);

ded := from_ba(prim_name <> '', 
				lname <> '',
				length(trim(fname)) > 1,
				length(trim(mname)) = length(stringlib.StringFilterOut(mname, ' ')));

export CleanAsHeader := dedup(ded, fname, mname, lname, ssn, dob, dt_first_seen, dt_last_seen,
							  dt_vendor_last_reported,	dt_vendor_first_reported, prim_range,
							  prim_name, sec_range, zip, all);