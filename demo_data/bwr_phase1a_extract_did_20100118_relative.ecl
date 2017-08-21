import ut,doxie_files,header,business_header;
//
// relatives may have been missed for 20081113_adds, reread current did set and expand with relatives.
//
wuid := '20100118';
//

did_layout := record
unsigned6 did;
end;
//
my_relatives	:= demo_data.base_files.File_Relatives;
//
	
// get relatives for all people (1 degree)
//
did_p2 := dedup(sort(demo_data.base_files.file_demo_data_dids(did<>0),record),all);
//
did_layout to_relative_person1_did(my_relatives l,did_p2 r) := transform
self.did :=l.person1;
end;
did_layout to_relative_person2_did(my_relatives l,did_p2 r) := transform
self.did :=l.person2;
end;
did_relatives
	:= 	join(my_relatives,did_p2,left.person2=right.did,to_relative_person1_did(left,right),lookup)+
		join(my_relatives,did_p2,left.person1=right.did,to_relative_person2_did(left,right),lookup);
//
// wrap up and output permanent set
//	   
all_dids	:= dedup(sort(did_p2+did_relatives,did),did);
//
output(all_dids(did<>0) ,,'~thor_200::base::demo_data_dids_'+wuid,overwrite);
//
