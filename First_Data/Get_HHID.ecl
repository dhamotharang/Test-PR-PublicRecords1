
infutor_census_did    := sort(distribute(first_data.Get_Census(did<>0),hash(did,addr_id)),did,addr_id,local);

hhid_distributed_on_did_addrid := distribute(first_data.Redefine_HHID,hash(did,addr_id));

first_data.layout_fatrec t_get_hhid(first_data.layout_fatrec l, first_data.Layout_Redefine_HHID r) := transform
 self.hhid := r.hhid;
 self      := l;
end;

infutor_hhid := join(infutor_census_did,hhid_distributed_on_did_addrid,
                     (left.addr_id=right.addr_id and left.did=right.did),
			         t_get_hhid(left,right),
			         left outer,local,keep(1)
			        );

export Get_HHID := distribute(infutor_hhid,hash(did));