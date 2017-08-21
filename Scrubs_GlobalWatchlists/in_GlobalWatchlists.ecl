import Data_Services, STD, GlobalWatchlists;

base_file := dataset('~thor_data400::base::globalwatchlists', GlobalWatchlists.Layout_GlobalWatchLists, thor);
convert_file := project(base_file, transform(Scrubs_GlobalWatchlists.Layout_GlobalWatchlists, 
																						 self.src_key := std.str.filterout(left.pty_key[1..5], '0123456789-');
																						 self := left;
																						 ));


EXPORT In_GlobalWatchlists := convert_file;