/*					Relatives_By_Vehicle
==============================================================	
PURPOSE: Generate did pairs on the same vehicle registration or ownership.
	
NOTES:	Does not do ut.MAC_Remove_Withdups, since they should qualify 
	for associate.
*/

import VehicleV2, vehlic, header;

veh_party := vehiclev2.file_vehicleV2_party;

//Slim down.

RecSlim := RECORD
    Veh_party.vehicle_key;
	veh_party.iteration_key;
	veh_party.sequence_key;
	Veh_party.append_did;
	Veh_party.Append_Clean_Name.lname;
	
END;

VehSlim:=table(Veh_party(append_did > 0), RecSlim);

vehSlim_dist := distribute(VehSlim, hash(vehicle_key, iteration_key, sequence_key));

//make same_lname with different DID and make person1 the bigger did

Layout_Relatives_v2.temp tjoin(VehSlim L, VehSlim R) := TRANSFORM
  self.person1 := if(L.append_did > R.append_did, L.append_did, R.append_did);
  self.person2 := if(R.append_did > L.append_did, L.append_did, R.append_did);
  self.prim_range := -6; //marker for vehicle. For roll-up in Relatives.
  self.zip := -6;
  self.same_lname := L.lname = R.lname;
  self.recent_cohabit := 0;
  self.number_cohabits := 3;
  self.vehicle_key := l.vehicle_key; 
  self.iteration_key := l.iteration_key; 
  self.sequence_key := l.sequence_key; 
END;

relVeh := join(vehslim_dist, vehslim_dist, left.vehicle_key = right.vehicle_key and
               left.iteration_key = right.iteration_key and left.sequence_key = right.sequence_key
			   and left.append_did <> right.append_did, tjoin(left, right), local);


//Dedup. Prefer the record with non-zero same_lname. 
relVehD := distribute(relVeh, hash(person1));
relVehS := dedup(sort(relVehD, person1, person2, -((integer1)same_lname), local),person1,person2,vehicle_key,iteration_key,sequence_key,local);
export Relatives_By_VehicleV2 := dedup(
	relVehS, person1, person2, keep 5, local)
	: PERSIST('PERSIST::Relatives_VehicleV2');

