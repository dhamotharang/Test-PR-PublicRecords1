import data_services, Scrubs_GlobalWatchlists,std,GlobalWatchlists;

base_file := dataset(data_services.foreign_prod + 'thor_data400::base::globalwatchlists', GlobalWatchlists.Layout_GlobalWatchLists, thor);
convert_file := project(base_file, transform(Scrubs_GlobalWatchlists.Layout_GlobalWatchlists, 
																						 self.src_key := std.str.filterout(left.pty_key[1..5], '0123456789-');
																						 self := left;
																						 ));


EXPORT File_GlobalWatchListsScrubs := convert_file;