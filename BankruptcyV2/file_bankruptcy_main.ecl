//test
import ut;
export file_bankruptcy_main := dataset('~thor_data400::base::bankruptcy::main',bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing ,flat)(court_code+case_number not in bankruptcyv2.Suppress.court_code_caseno);