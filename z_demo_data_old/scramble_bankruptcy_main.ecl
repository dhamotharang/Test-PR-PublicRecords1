import demo_data;
import bankruptcyv2,_control;

fver := '20081113';

//file_in:= dataset('~thor::base::demo_data_file_bankruptcy_main_prodcopy',bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing ,flat);
file_in:= dataset('~foreign::'+_control.IPAddress.prod_thor_dali+'::'+'thor_200::base::demo_data_file_bankruptcy_main' + fver, bankruptcyv2.layout_bankruptcy_main.layout_bankruptcy_main_filing ,flat);

recordof(file_in) reformat(file_in L):= TRANSFORM
self.date_created := demo_data_scrambler.fn_scramblePII('DOB',l.date_created);
self.date_modified := demo_data_scrambler.fn_scramblePII('DOB',l.date_modified);
self.case_number := demo_data_scrambler.fn_scramblePII('CHARS',l.case_number);
self.orig_case_number := demo_data_scrambler.fn_scramblePII('CHARS',l.orig_case_number);
self.date_filed := demo_data_scrambler.fn_scramblePII('DOB',l.date_filed);
self.orig_filing_date := demo_data_scrambler.fn_scramblePII('DOB',l.orig_filing_date);
//self.assets_no_asset_indicator;
self.meeting_date := demo_data_scrambler.fn_scramblePII('DOB',l.meeting_date);
//self.address_341;
//self.claims_deadline;
//self.complaint_deadline;
self.disposed_date := demo_data_scrambler.fn_scramblePII('DOB',l.disposed_date);
self.judge_name := if(l.judge_name<>'','Honorable John Smith','');
//self.record_type;
self.converted_date := demo_data_scrambler.fn_scramblePII('DOB',l.converted_date);
self.reopen_date := demo_data_scrambler.fn_scramblePII('DOB',l.reopen_date);
self.case_closing_date := demo_data_scrambler.fn_scramblePII('DOB',l.case_closing_date);
self:=l;
END;

scrambled1 := project(file_in,reformat(LEFT));

export scramble_bankruptcy_main := dedup(sort(scrambled1,record),all);


