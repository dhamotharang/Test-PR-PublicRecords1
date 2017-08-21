import address,header;
export fn_post_BasicMatch_deletes(dataset(header.layout_header) infile) := function

//remove death records that have been purged from Death Master since the last Header
noDeath     := header.fn_remove_deaths_not_in_death_master(infile);
noJunk      := header.fn_junk_names(noDeath);
enPurged    := Header.Fn_Remove_EN_deletes(noJunk); 
NoCompanies := header.fn_remove_companies(enPurged); 

return NoCompanies;

end;;
