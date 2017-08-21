import _control,civil_court;

file_in_all := dataset('~thor::base::demo_data_file_civil_matters_prodcopy',civil_court.Layout_Roxie_Matter,flat);

file_in := file_in_all(case_title='' and state_origin='MI');

file_in reformat(file_in l) := transform
self.case_number := 'X'+stringlib.stringfindreplace(l.case_number[2..],'1','2');
self.filing_date := fn_scramblepii('DOB',l.filing_date);
self.judgmt_date := fn_scramblepii('DOB',l.judgmt_date);
self.judgmt_disposition_date := fn_scramblepii('DOB',l.judgmt_disposition_date);
self.disposition_date := fn_scramblepii('DOB',l.disposition_date);
self.case_title:= '';
self.suit_amount := if(l.suit_amount<>'','10000.00','');
self.award_amount := if(l.award_amount<>'','7500.00','');
self := l;
end;

export scramble_civil_matters := dedup(sort(project(file_in,reformat(left)),record),all);


