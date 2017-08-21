IMPORT SANCTN, Address;

export proc_build_SANCTN_base(string filedate) := function

/////////////////////////////////////////////////////////////////////////////////
// -- Build Party Parent/Child Datset
/////////////////////////////////////////////////////////////////////////////////

//party := distribute(SANCTN.clean_party,hash(batch_number,incident_number));  (getting a wierd "way error")
//incident := distribute(SANCTN.clean_incident,hash(batch_number,incident_number));
//removed reclean of the party file as it is full file replacement
j_party_toclean := SANCTN.file_out_party_cleaned;
   
party := distribute(j_party_toclean,hash(batch_number,incident_number,party_number));

SANCTN.layout_SANCTN_base.layout_SANCTN_partyfull t_parent(party L) := transform

self.pty_detail := row(L,SANCTN.layout_SANCTN_base.layout_partyv);
self := L;

end;

p_party := project(party, t_parent(left));


SANCTN.layout_SANCTN_base.layout_SANCTN_partyfull  t_child(p_party L, p_party R) := transform

self.pty_detail   := L.pty_detail + row({r.pty_detail[1].order_number, r.pty_detail[1].party_text},SANCTN.layout_SANCTN_base.layout_partyv);

self := L;
end;

party_out := rollup(sort(p_party,record),t_child(left,right),batch_number,incident_number,party_number,local);	

/////////////////////////////////////////////////////////////////////////////////
// -- Build Incident Parent/Child Datset
/////////////////////////////////////////////////////////////////////////////////

incident := distribute(SANCTN.file_out_incident_cleaned,hash(batch_number,incident_number));

SANCTN.layout_SANCTN_base.layout_SANCTN_incidentfull t_incparent(incident L) := transform

self.inc_detail := row(L,SANCTN.layout_SANCTN_base.layout_incidentv);
self := L;

end;

p_incident:= project(incident, t_incparent(left));


SANCTN.layout_SANCTN_base.layout_SANCTN_incidentfull  t_incchild(p_incident L, p_incident R) := transform

self.inc_detail   := L.inc_detail + row({r.inc_detail[1].order_number, r.inc_detail[1].incident_text},SANCTN.layout_SANCTN_base.layout_incidentv);
self := L;
end;

incident_out := rollup(sort(p_incident,record),t_incchild(left,right),batch_number,incident_number,local); 

a := output(party_out,,'~thor_data400::base::SANCTN::party_' +filedate,overwrite);
b := output(incident_out,,'~thor_data400::base::SANCTN::incident_' + filedate,overwrite);
  
return 
parallel(a,b);

end;





