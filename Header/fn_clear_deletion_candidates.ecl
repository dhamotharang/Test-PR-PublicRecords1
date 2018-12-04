import ut,mdr;
EXPORT fn_clear_deletion_candidates(dataset(header.layout_header) in_head,string versionBuild) := function

//remove death records that have been purged from Death Master since the last Header
head := header.fn_remove_deaths_not_in_death_master(in_head);

//i wanted to move this ahead of the 'repeated value' check so that ZZZZZZZZZZ (10 Z's) 
//would be removed rather than just truncate to ZZZZZ (5 Z's)
remove_junk_names := header.fn_junk_names(head);

//created just so we have a single point of reference for straightening-up
header.layout_header more_cleanup(header.layout_header le) := transform

  self.ssn   := if(le.ssn in ut.set_badssn,'',le.ssn);
  self.phone := header.fn_blank_bogus_phones(le.phone);
  
  self.title     := '';
  self.fname     := if(header.mod_value_is_repeated(le.fname).is_repeated,    header.mod_value_is_repeated(le.fname).fixed,    le.fname);
  self.mname     := if(header.mod_value_is_repeated(le.mname).is_repeated,    header.mod_value_is_repeated(le.mname).fixed,    le.mname);
  self.lname     := if(header.mod_value_is_repeated(le.lname).is_repeated,    header.mod_value_is_repeated(le.lname).fixed,    le.lname);
  self.prim_name := if(header.mod_value_is_repeated(le.prim_name).is_repeated,header.mod_value_is_repeated(le.prim_name).fixed,le.prim_name);
  self.name_suffix := fn_cleanup_name_suffix(le.name_suffix);
  self := le;

end;

noJunk := project(remove_junk_names,more_cleanup(left));

//****** Remove some known bad names  city_name='OZ' and st
isjunky := header.BogusNames(noJunk.FNAME, noJunk.MNAME, noJunk.LNAME) or header.BogusCities(noJunk.city_name, noJunk.st);
kill_junk := noJunk(not isjunky);
///////////////////////////////////////////////////////////////
remove_EN_deletes0 := Header.Fn_Remove_EN_deletes(kill_junk):independent; 

// Removes addresses where the SSN appears in the address (dataland W20170403-134317)
noSnnAddresses   := remove_EN_deletes0( NOT (
                                                trim(ssn)<>'' 
                                                AND trim(prim_range)[1..3]=ssn[1..3]
                                                AND regexfind(ssn[6..],prim_name)
                                ));
noComp0   := fn_remove_companies(project(noSnnAddresses,header.layout_header));

//this filter is applied because of mac_flipnames rule 2; this can result in records with no last_name W20100505-090313
noComp   := noComp0	(
													fname<>''
											and lname<>''
											and ~regexfind('^dickless$|^dickles$',trim(fname),nocase)
											and ~regexfind('^dickless$|^dickles$',trim(mname),nocase)
											and ~regexfind('^dickless$|^dickles$',trim(lname),nocase)
										);

noOldUtil:=noComp(~header.IsOldUtil(versionBuild,,,,7));
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// again, at this point there should be absolutely no duplicates
// within or across clusters - if there are, we have a problem
Header.Mac_dedup_header(noOldUtil, deletesDone, '_hj');

// blank out PII while preserving did/rid/flags for records purged thus far
AllClear:=join(in_head,deletesDone
							,left.rid=right.rid
							,transform({in_head}
								,self.did:=left.did
								,self.rid:=left.rid
								,self.src:=left.src
								,self.pflag1:=left.pflag1
								,self.pflag2:=left.pflag2
								,self.pflag3:=left.pflag3
								,self.jflag1:=left.jflag1
								,self.jflag2:=left.jflag2
								,self.jflag3:=left.jflag3
								,self:=right
							)
							,left outer
							,hash);

return AllClear;

end;