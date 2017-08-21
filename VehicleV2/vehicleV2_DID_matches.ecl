import ut,header,watchdog;
v := vehicleV2.vehicle_as_source(,,true);

src_rec := record
	 header.layout_Source_ID;
	 vehicleV2.layout_vehicle_source;
	end;
	
slim_veh := record
string18  vendor_id;
unsigned6 did;
string9   ssn;
string4   birth_year;
string20  fname;
string20  mname;
string20  lname;
integer4	 total_records;
end;

slim_veh trans(v le) := transform
  self.vendor_id := le.vehicle_key;
  self.did := le.append_did;
  SELF.ssn := '';
  self.birth_year := '';
  self.fname					:= le.Append_Clean_Name.fname;
  self.mname					:= le.Append_Clean_Name.mname;
  self.lname					:= le.Append_Clean_Name.lname;
  self.total_records := 0;
end;

from_vr := project(v,trans(left))(did>0 and vendor_id!='');

//add best ssn and birth year

slim_veh addBest(slim_veh L, watchdog.file_best R) := transform
 self.ssn := r.ssn;
 self.birth_year := (string)(r.dob div 10000);
 self.total_records := r.total_records;
 self := l;
end;

ut.MAC_Remove_Withdups(from_vr,vendor_id,20,nodup)
dis_v_nor := distribute(nodup,hash(did));
dis_best := watchdog.file_best;

add_best := join(dis_v_nor,dis_best,left.did=right.did,addBest(left,right),left outer,local);

dis_v := distribute(add_best,hash(vendor_id));

header.Layout_PairMatch findPairs(slim_veh L, slim_veh R) := transform
  self.new_rid := if(l.did<r.did,l.did,r.did);
  self.old_rid := if(l.did>r.did,l.did,r.did);
  self.pflag := 13;
  end;

did_pairs := join(dis_v,dis_v,left.vendor_id=right.vendor_id and left.fname=right.fname and 
					left.lname=right.lname and left.did!=right.did and ut.NNEQ_SSN(left.ssn,right.ssn) and
					ut.NNEQ_int(left.birth_year,right.birth_year) and 
					(((integer)left.birth_year>0 and (integer)right.birth_year>0) or (left.ssn!='' and right.ssn!='') or right.total_records=1),
					findPairs(left,right),local);

export VehicleV2_DID_matches := dedup(did_pairs,all,local) : persist('persist::vehicleV2_did_match');