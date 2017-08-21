EXPORT file_SSN_correction_in := module

rec_20141202 := record
string10 reference_num;
string9 ssn;

end;

correction_20141202 := dataset('~thor_data400::in::eq_util_correctionheaderdailyln_20141202', rec_20141202, csv(heading(1), separator('|'), quote('')), opt);

export raw_20141202 := project(correction_20141202, transform(rec_20141202, self.reference_num
:= if(length(trim(left.reference_num, left,right)) < 10, '0' + trim(left.reference_num,left,right), left.reference_num), self := left));

rec_20160520 := record
string10 reference_num;
string9 ssn;
string2 lf;
end;

export raw_20160520 := dataset('~thor_data400::in::eq_util_SSNupdate_20160520', rec_20160520, flat);

end;

