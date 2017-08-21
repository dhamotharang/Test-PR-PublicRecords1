import ut;
#workunit ('name', 'Emerges Rollback Base Files');


ut.mac_SF_Move('base::emerges_hunt_vote_ccw','R',a,2,true)
ut.mac_SF_Move('base::emerges_hunt','R',b,2,true)
ut.mac_SF_Move('base::emerges_voters','R',c,2,true)
ut.mac_SF_Move('base::emerges_ccw','R',d,2,true)

sequential(a,b,c,d);