import address;
export fn_post_BasicMatch_deletes(dataset(layout_header) infile) := function

//remove death records that have been purged from Death Master since the last Header
noDeath     := header.fn_remove_deaths_not_in_death_master(infile);

//i wanted to move this ahead of the 'repeated value' check so that ZZZZZZZZZZ (10 Z's) 
//would be removed rather than just truncate to ZZZZZ (5 Z's)
noJunk      := header.fn_junk_names(nodeath);

enPurged    := Header.Fn_Remove_EN_deletes(nojunk); 

return fn_remove_companies(enPurged);

end;;
