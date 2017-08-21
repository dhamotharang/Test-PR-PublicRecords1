//  Cleaning function. 

all_zero_or_nine(string intext) := function

 string intext_0         := trim(stringlib.stringfilter(intext,'0'));
 string intext_9         := trim(stringlib.stringfilter(intext,'9'));

 integer length_intext   := length(trim(intext));
 integer length_intext_0 := length(trim(intext_0));
 integer length_intext_9 := length(trim(intext_9));

 out_string := if(length_intext=length_intext_0 or length_intext=length_intext_9,'',intext);

return out_string;

end;

export fn_patch_main_file(dataset(recordof(watercraft.Layout_Watercraft_Main_Base)) in_wc) :=
function

recordof(in_wc) t_patch(recordof(in_wc) le) := transform

 self.watercraft_key   := stringlib.stringtouppercase(le.watercraft_key);
 self.hull_number      := stringlib.stringtouppercase(le.hull_number);
 self.watercraft_name  := stringlib.stringtouppercase(le.watercraft_name);

 self.model_year       := all_zero_or_nine(le.model_year);
 self.use_description  := trim(regexreplace('[,-]',le.use_description,' '),left,right);
 
 self.title_number     := all_zero_or_nine(le.title_number);
 self.title_issue_date := all_zero_or_nine(le.title_issue_date);
 
 self                  := le ; 

end ; 
			
p_patch	:=	project(in_wc,t_patch(left)); 

return p_patch;

end;