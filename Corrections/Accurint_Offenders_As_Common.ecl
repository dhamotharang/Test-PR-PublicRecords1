import crim_common;

df := dataset(Crim_Common.Name_Moxie_Crim_Offender2_Dev+'_new',
			{crim_common.Layout_Moxie_Crim_Offender2.new,unsigned8 __fpos {virtual(fileposition)}},flat,unsorted);
			
layout_offender_common into(df L) := transform
	self.orig_state := L.state_origin;
	self.ssn := L.orig_ssn;
	self.ssn_appended := L.ssn;
	self.case_date := L.case_filing_dt;
	self.case_num := L.case_number;
	self.st := L.state;
	self := L;
end;

export Accurint_Offenders_As_Common := project(df,into(LEFT));