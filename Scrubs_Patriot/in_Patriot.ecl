IMPORT Data_Services, STD, Patriot;

base_file := Patriot.File_Patriot;
convert_file := PROJECT(base_file, TRANSFORM(Scrubs_Patriot.Layout_Patriot, 
																						 self.src_key := std.str.filterout(left.pty_key[1..5], '0123456789-');
																						 self := left;
																						 ));


EXPORT In_Patriot := convert_file;