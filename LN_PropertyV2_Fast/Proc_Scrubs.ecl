import Scrubs_LN_PropertyV2_Assessor,ut;
EXPORT Proc_Scrubs (string source = '', string file_type = 'A', string version) :=  function
file_t := if(file_type = 'A', 'Assessment', 'DeedMortgage');
scrub := if(file_type = 'A', LN_PropertyV2_Fast.fn_scrubs_assessor(source, version),  LN_PropertyV2_Fast.fn_scrubs_Deed(source, version));
//scrub := LN_PropertyV2_Fast.fn_scrubs_assessor(source);

output(file_t);
return scrub;
end;