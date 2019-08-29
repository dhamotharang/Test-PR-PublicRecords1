/*
For each of the IDS (Proxid/SeleId/OrgId):
How many IDs total
How many singletons (for a ProxId ? singleton means 1 dot, for SeleId ? singleton means 1 proxid etc)
How many have >1 source (which can be computed at the record level)
How many have a record more recent than 6 months ago
BDID ? compare contrast
How many BDIDs are there
How many BDIDs split across 2 or more proxids, across 2 or more SELEid, 2 or more OrgIds
The other way: How many proxids are split across 2 or more bdids, seleids split across 2 or more bdids, orgids split across 2 or more bdids
General Stats:
How many records of each source are there
*/
#workunit('name','BIPV2 Stats 20130212');
layfull := recordof(BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL);
dbase := project(BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL ,transform({string source,layfull - source} ,self.source := mdr.sourcetools.TranslateSource_aggregate(left.source),self := left));
dbase_slim  := table(dbase,{proxid,dotid,orgid,seleid,ultid,source,dt_last_seen,unsigned6 bdid := company_bdid}) : independent;
dbase_slimbdid := dbase_slim(bdid != 0);
daggDotid   := tools.mac_AggregateFieldsPerID(dbase_slim,dotid  ,,false);
daggProxid  := tools.mac_AggregateFieldsPerID(dbase_slim,proxid ,,false);
daggOrgid   := tools.mac_AggregateFieldsPerID(dbase_slim,orgid  ,,false);
daggSeleid  := tools.mac_AggregateFieldsPerID(dbase_slim,seleid ,,false);
daggUltid   := tools.mac_AggregateFieldsPerID(dbase_slim,ultid  ,,false);
daggBdid    := tools.mac_AggregateFieldsPerID(dbase_slimbdid,bdid   ,,false);
//duniquespersource := strata.macf_uniques(dbase_slim ,'source');
dsourcetable := table(dbase_slim  ,{source,unsigned8 cnt := count(group)},source,few) : independent;
d1sourcedotids  := daggDotid  (count(sources) = 1);
d1sourceproxids := daggProxid (count(sources) = 1);
d1sourceorgids  := daggOrgid  (count(sources) = 1);
d1sourceseleids := daggSeleid (count(sources) = 1);
d1sourceultids  := daggUltid  (count(sources) = 1);
dnorm1sourcedot  := table(normalize(d1sourcedotids  ,left.sources,transform({unsigned dotid ,string source},self.dotid  := left.dotid ,self.source := right.source))  ,{source,unsigned cnt_dotids  := count(group)},source,few);
dnorm1sourceprox := table(normalize(d1sourceproxids ,left.sources,transform({unsigned proxid,string source},self.proxid := left.proxid,self.source := right.source))  ,{source,unsigned cnt_proxids := count(group)},source,few);
dnorm1sourceorg  := table(normalize(d1sourceorgids  ,left.sources,transform({unsigned orgid ,string source},self.orgid  := left.orgid ,self.source := right.source))  ,{source,unsigned cnt_orgids  := count(group)},source,few);
dnorm1sourcesele := table(normalize(d1sourceseleids ,left.sources,transform({unsigned seleid,string source},self.seleid := left.seleid,self.source := right.source))  ,{source,unsigned cnt_seleids := count(group)},source,few);
dnorm1sourceult  := table(normalize(d1sourceultids  ,left.sources,transform({unsigned ultid ,string source},self.ultid  := left.ultid ,self.source := right.source))  ,{source,unsigned cnt_ultids  := count(group)},source,few);
dnormsourcedot  := table(normalize(daggDotid  ,left.sources,transform({unsigned dotid ,string source} ,self.dotid  := left.dotid ,self.source := right.source))  ,{source,unsigned cnt_dotids  := count(group)},source,few);
dnormsourceprox := table(normalize(daggProxid ,left.sources,transform({unsigned proxid,string source} ,self.proxid := left.proxid,self.source := right.source))  ,{source,unsigned cnt_proxids := count(group)},source,few);
dnormsourceorg  := table(normalize(daggOrgid  ,left.sources,transform({unsigned orgid ,string source} ,self.orgid  := left.orgid ,self.source := right.source))  ,{source,unsigned cnt_orgids  := count(group)},source,few);
dnormsourcesele := table(normalize(daggSeleid ,left.sources,transform({unsigned seleid,string source} ,self.seleid := left.seleid,self.source := right.source))  ,{source,unsigned cnt_seleids := count(group)},source,few);
dnormsourceult  := table(normalize(daggUltid  ,left.sources,transform({unsigned ultid ,string source} ,self.ultid  := left.ultid ,self.source := right.source))  ,{source,unsigned cnt_ultids  := count(group)},source,few);
laystats  := {string stat,unsigned8 value};
layrollup := {string source,unsigned cnt,dataset(laystats) dotids,dataset(laystats) proxids,dataset(laystats) orgids,dataset(laystats) seleids,dataset(laystats) ultids};
dconcat := 
  project(dnormsourcedot  ,transform(layrollup,self.dotids  := dataset([{'Count Dotids'  ,left.cnt_dotids },{'Count This source only dotids ',dnorm1sourcedot (source = left.source)[1].cnt_dotids }],laystats),self := left,self := []))
+ project(dnormsourceprox ,transform(layrollup,self.proxids := dataset([{'Count Proxids' ,left.cnt_proxids},{'Count This source only proxids',dnorm1sourceprox(source = left.source)[1].cnt_proxids}],laystats),self := left,self := []))
+ project(dnormsourceorg  ,transform(layrollup ,self.orgids := dataset([{'Count Orgids'  ,left.cnt_orgids },{'Count This source only orgids ',dnorm1sourceorg (source = left.source)[1].cnt_orgids }],laystats),self := left,self := []))
+ project(dnormsourcesele ,transform(layrollup,self.seleids := dataset([{'Count Seleids' ,left.cnt_seleids},{'Count This source only seleids',dnorm1sourcesele(source = left.source)[1].cnt_seleids}],laystats),self := left,self := []))
+ project(dnormsourceult  ,transform(layrollup,self.ultids  := dataset([{'Count Ultids'  ,left.cnt_ultids },{'Count This source only ultids ',dnorm1sourceult (source = left.source)[1].cnt_ultids }],laystats),self := left,self := []))
;
drollupsourcestats := rollup(sort(dconcat,source)  ,source ,transform(recordof(left)
  ,self.dotids  := left.dotids  + right.dotids
  ,self.proxids := left.proxids + right.proxids
  ,self.orgids  := left.orgids  + right.orgids
  ,self.seleids := left.seleids + right.seleids
  ,self.ultids  := left.ultids  + right.ultids
  ,self.cnt := dsourcetable(source = left.source)[1].cnt;
  ,self := left
));
thedate := ut.GetDate;
month := if((unsigned)thedate[5..6] > 6 ,(unsigned)thedate[5..6] - 6    ,12 - (6 - (unsigned)thedate[5..6]));
year  := if((unsigned)thedate[5..6] > 6 ,(unsigned)thedate[1..4]        ,((unsigned)thedate[1..4] - 1)  );
sixmonthsago := intformat(year,4,1) + intformat(month,2,1) + thedate[7..8];
dstats := dataset([
   {'Dotid' ,dataset([
               {'Uniques'                         ,count(daggDotid                                                            )}
              ,{'Singletons'                      ,count(daggDotid(cnt = 1)                                                   )}
              ,{'With > 1 source'                 ,count(daggDotid(count(sources) > 1)                                        )}
              ,{'With Activity in last 6 months'  ,count(daggDotid(max(dt_last_seens,dt_last_seen) > (unsigned)sixmonthsago)  )}
              ,{'Split across > 1 bdids'          ,count(daggDotid(count(bdids) > 1)                                          )}
            ],laystats)
  }
  ,{'Proxid' ,dataset([
               {'Uniques'                         ,count(daggProxid                                                            )}
              ,{'Singletons'                      ,count(daggProxid(cnt = 1)                                                   )}
              ,{'With > 1 source'                 ,count(daggProxid(count(sources) > 1)                                        )}
              ,{'With Activity in last 6 months'  ,count(daggProxid(max(dt_last_seens,dt_last_seen) > (unsigned)sixmonthsago)  )}
              ,{'Split across > 1 bdids'          ,count(daggProxid(count(bdids) > 1)                                          )}
            ],laystats)
  }
  ,{'Orgid' ,dataset([
               {'Uniques'                         ,count(daggOrgid                                                            )}
              ,{'Singletons'                      ,count(daggOrgid(cnt = 1)                                                   )}
              ,{'With > 1 source'                 ,count(daggOrgid(count(sources) > 1)                                        )}
              ,{'With Activity in last 6 months'  ,count(daggOrgid(max(dt_last_seens,dt_last_seen) > (unsigned)sixmonthsago)  )}
              ,{'Split across > 1 bdids'          ,count(daggOrgid(count(bdids) > 1)                                          )}
            ],laystats)
  }
  ,{'Seleid' ,dataset([
               {'Uniques'                         ,count(daggSeleid                                                            )}
              ,{'Singletons'                      ,count(daggSeleid(cnt = 1)                                                   )}
              ,{'With > 1 source'                 ,count(daggSeleid(count(sources) > 1)                                        )}
              ,{'With Activity in last 6 months'  ,count(daggSeleid(max(dt_last_seens,dt_last_seen) > (unsigned)sixmonthsago)  )}
              ,{'Split across > 1 bdids'          ,count(daggSeleid(count(bdids) > 1)                                          )}
            ],laystats)
  }
  ,{'Ultid' ,dataset([
               {'Uniques'                         ,count(daggUltid                                                            )}
              ,{'Singletons'                      ,count(daggUltid(cnt = 1)                                                   )}
              ,{'With > 1 source'                 ,count(daggUltid(count(sources) > 1)                                        )}
              ,{'With Activity in last 6 months'  ,count(daggUltid(max(dt_last_seens,dt_last_seen) > (unsigned)sixmonthsago)  )}
              ,{'Split across > 1 bdids'          ,count(daggUltid(count(bdids) > 1)                                          )}
            ],laystats)
  }
/*  ,{'Bdid' ,dataset([
               {'Uniques'                         ,count(daggBdid                                                             )}
              ,{'Split across > 1 dotids'         ,count(daggBdid(count(dotids ) > 1)                                         )}
              ,{'Split across > 1 proxids'        ,count(daggBdid(count(proxids) > 1)                                         )}
              ,{'Split across > 1 orgids '        ,count(daggBdid(count(orgids ) > 1)                                         )}
              ,{'Split across > 1 seleids'        ,count(daggBdid(count(seleids) > 1)                                         )}
              ,{'Split across > 1 ultids '        ,count(daggBdid(count(ultids ) > 1)                                         )}
            ],laystats)
  }
*/
],{string id,dataset(laystats) stats});
output(dstats       ,named('AllStats'),all);
output(drollupsourcestats  ,named('drollupsourcestats'),all);
