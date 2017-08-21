//this program should run on 400way since it's not allow to bdid records on < 400
import address, lssi, did_add, business_header_ss, business_header, header, ut, header_slimsort, didville;

#stored('did_add_force','thor');

lssi_base := lssi.file_hhid_did_lssi;
res_lssi := lssi_base(split = '1');

new_hhid_rec := record
	lssi.layout_hhid_did_lssi;
     unsigned8 new_hhid := 0;
	unsigned8 __filepos {virtual(fileposition)};
end;

new_hhid_rec pre_hhid(res_lssi l) := transform	
	self := l;
end;

res_lssi_ready := project(res_lssi, pre_hhid(left));
res_lssi_dist := distribute(res_lssi_ready, hash(lname,prim_name));

didville.MAC_HHID_Append_By_Address(
	res_lssi_dist, res_hhid_out, new_hhid, lname,
	prim_range, prim_name, sec_range, st, zipcode)

lssi_new_id_rec := record
     lssi.layout_hhid_did_lssi;
     unsigned8 new_hhid := 0;
	unsigned6 new_did := 0; 
     unsigned1 new_did_score := 0;
     unsigned6 new_b_did := 0;
	unsigned1 new_b_did_score := 0;
end;

res_matchset := ['A', 'P', 'Z'];

did_add.MAC_Match_Flex(res_hhid_out,res_matchset,
                       foo,foo,fname,mname,lname,name_suffix,
				   prim_range,prim_name,sec_range,zipcode,st,clean_phone,
				   new_did,lssi_new_id_rec,true,new_did_score,75,final_res_lssi);

bus_lssi := lssi_base(split<>'1');
bus_lssi_ready := distribute(bus_lssi,hash(prim_name, clean_phone));

bus_matchset := ['A', 'P'];

business_header_ss.MAC_Add_BDID_Flex(bus_lssi_ready, bus_matchset,
                                     clean_compname,
				                 prim_range, prim_name, zipcode, 
						       sec_range, st, 
						       clean_phone, foo,
				                 new_b_did, 
						       lssi_new_id_rec, 
						       true, new_b_did_score, 
						       bus_lssi_out);
								
lssi_new_id_rec get_new_bdid(bus_lssi_out l) := transform
	self.new_b_did := if(l.new_b_did_score >= 75, l.new_b_did, 0);
	self.new_b_did_score := if(l.new_b_did_score >= 75, l.new_b_did_score, 0);
	self := l;
end;							  

final_bus_lssi := project(bus_lssi_out, get_new_bdid(left));

final_lssi := final_res_lssi + final_bus_lssi;

lssi.layout_hhid_did_lssi get_final(final_lssi l) := transform
	self.hhid := map(l.new_hhid <> 0 => l.new_hhid,
                      l.hhid <> 0 => l.hhid, 
                      0);
	self.did := if(l.new_did_score > l.did_score, l.new_did, l.did);
	self.did_score := if(l.new_did_score > l.did_score, 
                          l.new_did_score, 
                          l.did_score);
	self.b_did := if(l.new_b_did_score > l.b_did_score, 
                      l.new_b_did,
                      l.b_did);
	self.b_did_score := if(l.new_b_did_score > l.b_did_score, 
                            l.new_b_did_score,
                            l.b_did_score);
	self := l;
end;

lssi_main_file := project(final_lssi, get_final(left));
ut.mac_sf_buildprocess(lssi_main_file,'~thor400_92::base::lssi_main',build_full)

export bwr_better_id_full := sequential(build_full, lssi.Proc_Build_LSSI_Full_Keys);