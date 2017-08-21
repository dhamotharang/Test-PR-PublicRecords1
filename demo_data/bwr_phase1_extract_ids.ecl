import ut,doxie_files,header,business_header;
//
// need more bankruptcy.
//
wuid := '20081103';
//
my_file_lookups := demo_data.base_files.file_lookups;
my_death 		:= demo_data.base_files.file_did_death_masterv2;
//
my_bus_header	:= demo_data.base_files.File_Business_Header_base;
my_bus_contacts	:= demo_data.base_files.File_Business_Contacts_plus;
//
my_relatives	:= demo_data.base_files.File_Relatives;
//
// get primary set of dids
// *** should get more selected records to assure all scenarios.
// 
did_dummy		:= my_file_lookups(did>999999000000);
did_random 		:= enth(my_file_lookups,50);
did_sex  		:= enth(my_file_lookups(sex_cnt<>0),5);
did_crim 		:= enth(my_file_lookups(crim_cnt<>0),5);
did_ccw  		:= enth(my_file_lookups(ccw_cnt<>0),5);
did_head  		:= enth(my_file_lookups(head_cnt<>0),15);
did_veh  		:= enth(my_file_lookups(veh_cnt<>0),15);
did_dl	  		:= enth(my_file_lookups(dl_cnt<>0),15);
did_rel	  		:= enth(my_file_lookups(rel_count>5),15);
did_fire		:= enth(my_file_lookups(fire_count<>0),5);
did_faa			:= enth(my_file_lookups(faa_count<>0),5);
did_vess		:= enth(my_file_lookups(vess_count<>0),50);
did_prof		:= enth(my_file_lookups(prof_count<>0),50);
did_bus			:= enth(my_file_lookups(bus_count<>0),25);
did_prop		:= enth(my_file_lookups(prop_count<>0),15);
did_bk			:= enth(my_file_lookups(bk_count<>0),5);
did_prop_asses	:= enth(my_file_lookups(prop_asses_count<>0),15);
did_prop_deeds	:= enth(my_file_lookups(prop_deeds_count<>0),15);
did_paw			:= enth(my_file_lookups(paw_count<>0),15);
did_bc			:= enth(my_file_lookups(bc_count<>0),10);
//
did_death		:= enth(my_death,10);
//
did_p1 := 	dedup(sort(table(did_dummy+
								did_random+
								did_sex+
								did_crim+
								did_ccw+
								did_head+
								did_veh+
								did_dl+
								did_rel+
								did_fire+
								did_faa+
								did_vess+
								did_prof+
								did_bus+
								did_prof+
								did_bk+
								did_prop_asses+
								did_prop_deeds+
								did_paw+
								did_bc,{did})+
								table(did_death,{(unsigned6) did}),did),did);
//
// get businesses for did_p1 people
//
bdid_layout := record
unsigned6 bdid;
end;
bdid_layout to_bdid(my_bus_contacts l, did_p1 r) := transform
self.bdid:= l.bdid;
end;
bdid_did_p1 := join(my_bus_contacts(did<>0),did_p1(did<>0),left.did=right.did,to_bdid(left,right),lookup);
//
// get primary set of businesses 
// *** should get more selected records to assure all scenarios.
//
bdid_random := table(enth(my_bus_header,5),{bdid});
//
// add in business for bdid_p1 people
//
bdid_p1 := dedup(sort(bdid_did_p1+bdid_random,bdid),bdid);
//
// get all people for all businesses
//
did_layout := record
unsigned6 did;
end;
did_layout to_did(my_bus_contacts l, bdid_p1 r) := transform
self.did:= l.did;
end;
did_bdid_p1 := enth(join(my_bus_contacts(bdid<>0),bdid_p1(bdid<>0),left.bdid=right.bdid,to_did(left,right),lookup),200);
//			
// get relatives for all people (1 degree)
//
did_p2 := did_p1+did_bdid_p1;
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
all_bdids	:= dedup(sort(bdid_p1,bdid),bdid);
//
output(all_dids ,,'~thor_200::base::demo_data_dids_'+wuid,overwrite);
output(all_bdids,,'~thor_200::base::demo_data_bdids_'+wuid,overwrite);
//
