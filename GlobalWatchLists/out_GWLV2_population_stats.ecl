import strata;
export out_GWLV2_population_stats(string filedate) := function
fBase_Entity := File_GlobalWatchLists_V4.Base.Entity;
Layout_fBase_Entity_stat :=
record
	unsigned8 CountGroup                                                                  := count(group);
   fBase_Entity.watchlistname ;
	unsigned8 entityid_CountNonBlank                                                       := sum(group, if(fBase_Entity.entityid  <> ''   ,1,0));
	unsigned8 watchlistname_CountNonBlank                                                  := sum(group, if(fBase_Entity.watchlistname  <> ''   ,1,0));
	unsigned8 entitytype_CountNonBlank                                                     := sum(group, if(fBase_Entity.entitytype  <> ''  ,1,0));
	unsigned8 reasonlisted_CountNonBlank                                                    := sum(group, if(fBase_Entity.reasonlisted <> ''  ,1,0));
	unsigned8 firstname_CountNonBlank                                                      := sum(group, if(fBase_Entity.firstname  <> ''   ,1,0));
	unsigned8 middlename_CountNonBlank                                                       := sum(group, if(fBase_Entity.middlename   <> ''   ,1,0));
	unsigned8 lastname_CountNonBlank                                                       := sum(group, if(fBase_Entity.lastname  <> ''  ,1,0));
	unsigned8 fullname_CountNonBlank                                                       := sum(group, if(fBase_Entity.fullname  <> ''  ,1,0));
	unsigned8 watchlistdate_CountNonBlank                                                  := sum(group, if(fBase_Entity.watchlistdate  <> ''  ,1,0));
	unsigned8 datelisted_CountNonBlank                                                     := sum(group, if(fBase_Entity.datelisted  <> ''  ,1,0));
end;
fBase_Entity_stat := sort(table(fBase_Entity, Layout_fBase_Entity_stat,   watchlistname, few),watchlistname);
strata.createXMLStats(fBase_Entity_stat, 'GlobalWatchListsV2', 'Entity', filedate, 'skasavajjala@seisint.com', output_fBase_Entity_stat, 'Base', 'Population');

return output_fBase_Entity_stat;
end;
