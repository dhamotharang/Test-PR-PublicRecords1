import ut;
#workunit ('name', 'Corp Rollback Base Files');


ut.mac_SF_Move('base::corp_base','R',a,2,true)
ut.mac_SF_Move('base::corp_supp_base','R',b,2,true)
ut.mac_SF_Move('base::corp_cont_base','R',c,2,true)
ut.mac_SF_Move('base::corp_event_base','R',d,2,true)

sequential(a,b,c,d);