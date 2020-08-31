﻿import VotersV2, ut, _Validate, emerges, std;
//DF-27577 Moved DID after AID and Name processes
//DF-27577 Moved Rollup from Updated_Voters to Translate_Voters_Codes

Clean_In_file  := VotersV2.File_Voters_Cleaned_Super;

Layout_outfile := VotersV2.Layouts_Voters.Layout_Voters_Common_new;

// stored values to override the year low & high range from default value to 1900 & current year.
#stored('_Validate_Year_Range_Low',  '1900');
year_high := ((STRING8)Std.Date.Today())[1..4];
#stored('_Validate_Year_Range_High', year_high);

// function to fix the invalid date value and returns to ccyymmdd format.
string8 fixdate(string indate) := function
    outdate := _Validate.date.fCorrectedDateString(trim(indate,left,right));
	return(if((integer)trim(outdate,left,right) = 0, '', outdate));
end;

//bug 29750 - Modified the code to blank all the regdate's that are 19000101.
// bug 68322 - Modified the code to blank all dob that are 19010101.
Layout_outfile FixDates(Clean_In_file l) := transform
  self.dob          := if (ut.Age((integer)fixdate(l.dob))< 18, // bug 167807
	                         '',
													 if(l.dob = '19010101', '', fixdate(l.dob)));  // bug 68322
	self.regdate      := if (fixdate(l.regdate) = '19000101', '', fixdate(l.regdate)); 
	self.LastDateVote := fixdate(l.LastDateVote);
	self              := l;
end;

Clean_file := project(Clean_In_file, FixDates(left));

emerges.MAC_eMerge_Date_Patch(clean_file,regdate,lastdatevote,regdate,regdate,date_fix);//Extra regdate's don't matter because Voters doesn't use them	

export Updated_Voters := date_fix
//uncomment for tesing
 // : persist(VotersV2.Cluster + 'persist::Updated_Voters', SINGLE)
 ;

