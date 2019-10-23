/*2014-07-11T17:04:29Z (Steven Stockton)
Add id_cnt to make sure make sure we don't suppress out all records fro a given address.
*/
import idl_header, address, ut;
export addr_hier_validities(dataset(idl_header.Layout_Header_address) hdr) := module

shared hdr_no_zip4 := join(hdr(address_group_id > 0 and zip4 <> ''), hdr(address_group_id > 0 and zip4 = ''), left.did = right.did and left.address_group_id = right.address_group_id,transform(idl_header.Layout_Header_address,self.addr_ind := '';self.best_addr_ind:='';self:=right),right only,local);
dids_no_zip4 := table(distribute(hdr_no_zip4,hash(did)),{hdr_no_zip4.did,hdr_no_zip4.address_group_id},did,address_group_id,local);

shared hdr_zip4 := join(distribute(hdr,hash(did)), dids_no_zip4, left.did = right.did and left.address_group_id = right.address_group_id,transform(left),left only,local);
//old address hierarchy
shared disthdr     := distribute(hdr,hash(did));
hdr_sort    := sort(hdr_zip4,did,(integer) address_group_id, -dt_last_seen, -dt_first_seen, local);

rec := record
  hdr_sort;
	unsigned6 id_cnt;
end;
hdr_ranges0 := project(hdr_sort,transform(rec,self.id_cnt:=1,self:=left));
hdr_ranges1 := rollup(hdr_ranges0(address_group_id > 0 and dt_first_seen > 0 and dt_last_seen > 0),
                      left.did = right.did and 
						  			  left.address_group_id = right.address_group_id and
										  ut.date_overlap(left.dt_first_seen,left.dt_last_seen,right.dt_first_seen,right.dt_last_seen) > 0,                      
											transform(rec,
                                self.dt_last_seen  := max(left.dt_last_seen,right.dt_last_seen);
													      self.dt_first_seen := min(left.dt_first_seen,right.dt_first_seen);
																self.id_cnt := left.id_cnt + right.id_cnt;
												        self := right,
																self := left),local);
// output(hdr_ranges1,named('hdr_ranges1'),extend); 
hdr_ranges2  := rollup(hdr_ranges1,
                       left.did = right.did and 
						  			   left.address_group_id = right.address_group_id and
										  (ut.DaysApart((string) left.dt_first_seen,(string) right.dt_last_seen) <= constants.Addrgap OR
											 right.dt_last_seen < insuranceheader_address.constants.Year2000),                      
										 	 transform(rec,
                                 self.dt_last_seen  := max(left.dt_last_seen,right.dt_last_seen),
                                 self.dt_first_seen := min(left.dt_first_seen,right.dt_first_seen),
																 self.id_cnt := left.id_cnt + right.id_cnt;
																 self := right,
                                 self := left),
											 local);
// output(hdr_ranges2,named('hdr_ranges2'),extend); 
hdr_ranges3 := iterate(project(hdr_ranges2,transform(layout_addr.addrsegrec,self.id:=[],self.segment:=[],self:=left)),
                       transform(layout_addr.addrsegrec,
											           self.segment := IF(left.did = right.did and left.address_group_id = right.address_group_id,
																                    IF(left.segment = 0, 1, left.segment + 1),
																										0),
																 self.id      := IF(left.did = right.did and left.address_group_id = right.address_group_id and 
																                    left.id=0,1,left.id + 1);
                                 self := right),local);
// output(hdr_ranges3,named('hdr_ranges3'),extend); 
shared addr_segments := join(hdr_zip4(address_group_id > 0 and dt_first_seen > 0 and dt_last_seen > 0),hdr_ranges3,
                             left.did = right.did and
													   left.address_group_id = right.address_group_id and
													   ut.date_overlap(left.dt_first_seen,left.dt_last_seen,right.dt_first_seen,right.dt_last_seen) >= -constants.Addrgap,
                             transform(recordof(right),
                                       self.segment := right.segment,
																			 self.id      := right.id,
																			 self.id_cnt  := right.id_cnt,
													             self := left),
													   left outer, local);
// output(addr_segments,named('addr_segments'),extend);														 
//Add on zero records
shared unique_segments := dedup(sort(addr_segments,did,address_group_id,dt_last_seen,local),did,address_group_id,local); 
// output(unique_segments,named('unique_segments'),extend);
shared add_zeroes      := join(hdr_zip4(dt_first_seen = 0 OR dt_last_seen = 0),unique_segments,
                               left.did = right.did and
															 left.address_group_id = right.address_group_id,
															 transform(recordof(right),
															           self.segment := right.segment,
																				 self.id      := right.id,
																				 self.id_cnt  := right.id_cnt,
																				 self := left),left outer,local);
shared id_zeroes := iterate(add_zeroes,
                            transform(recordof(left),
                                     c := 10000 + counter;
														         self.id := IF(right.id=0,
																		               IF(left.address_group_id = right.address_group_id,
																									    left.id,c),right.id),
																		 self := right,
																		 self := left), local);
// output(add_zeroes,named('add_zeroes'),extend);
addr_all := addr_segments + id_zeroes;
 
idl_Header.mac_best_address_v1(addr_all, did, 90, old);
//output(old,named('old'),extend);
  
old_addr_flags := join(addr_all, old(rec_type != '*'), left.did = right.did and left.id = right.id, 
										transform(recordof(left),
										          self.addr_ind := right.rec_type,
															self.addressstatus := '',
															self.addresstype := '',
															self := left,
															self := []), left outer, local);
// output(old_addr_flags,named('old_addr_flags'),extend);															
shared addr_raw := dedup(sort(old_addr_flags,did,rid,addr_ind,local),did,rid,local);
// output(addr_raw,named('addr_raw'),extend);
										
//new address hierarchy
shared hdr_clean   := fn_address_hier(addr_raw).NewFullHdr;
// output(hdr_clean,named('hdr_clean'),extend);
                              
export hdr_filter := hdr_clean((address.AddressQuality(prim_range,prim_name,addr_suffix,sec_range,city,zip,zip4)=0 OR
                               (address.AddressQuality(prim_range,prim_name,addr_suffix,sec_range,city,zip,zip4)=5 AND zip4<>'')) AND
                              (addresstype       IN ['BUS','SEA','SEC'] OR 
                               addressstatus NOT IN ['OSR','OSS','OSD','IC1','IC2','OHD'] OR 
														 (addressstatus IN ['OSR','OSS','IC2','OHD'] and id_cnt=1)));  //Filter out address noise

hdr_ic2s := dedup(sort(hdr_clean((address.AddressQuality(prim_range,prim_name,addr_suffix,sec_range,city,zip,zip4)=0 OR
                                  address.AddressQuality(prim_range,prim_name,addr_suffix,sec_range,city,zip,zip4)=5 AND zip4<>'') AND  
                                 addressstatus = 'IC2'),did,id,addressstatus,local),did,id,local);
hdr_wic2 := join(hdr_filter,hdr_ic2s,
                 left.did = right.did and
								 left.id = right.id,
								 transform(recordof(left),
								           self := right), right only, local) + hdr_filter;
// output(hdr_wic2,named('hdr_wic2'),extend);

idl_Header.mac_best_address_v1(hdr_wic2, did, 90, new); //filtered clean addr hierarchy
// output(new,named('new'),extend);
					 
new_addr_flags := join(hdr_clean, distribute(new(rec_type != '*'),hash(did)), left.did = right.did and left.id = right.id, 
										transform(idl_header.Layout_Header_address, 
										          self.addr_ind := IF(left.addressstatus IN ['OSD','IC1','OSS','OSR','OHD'] and left.sec_range <> right.sec_range,'',right.rec_type), 
                              self.best_addr_ind := IF(left.rid = right.rid,'B','');															
															self := left, 
															self := []), left outer, local);
// output(new_addr_flags,named('new_addr_flags'),extend);

addr_dedup  := dedup(sort(new_addr_flags,did,rid,addr_ind,local),did,rid,local) + hdr(address_group_id = 0) + hdr_no_zip4;

// output(addr_dedup,named('addr_dedup'),extend);
addr_sort   := sort(addr_dedup(addr_ind = '' AND addressstatus IN ['OSD','OSS','IC1','OHD','OSR']),did,rid,local);
// output(addr_sort,named('addr_sort'),extend);
addr_drops  := join(addr_raw,addr_sort,
                   left.did = right.did and
									 left.rid = right.rid,
									 transform(layout_addr.newaddrindrec,
									           self.new_addr_ind := [],
														 self := left),
									 local);
// output(addr_drops,named('addr_drops'),extend);
addr_drops_numbered := iterate(sort(addr_drops,did,(integer) addr_ind,-best_addr_ind,local),
                               transform(recordof(left),
                               self.new_addr_ind := MAP(right.addr_ind = ''  => 0,
															                          left.did = right.did =>
															                               IF(left.addr_ind = right.addr_ind,
															                                  left.new_addr_ind,
																											          IF(left.new_addr_ind = 99,
																													         99,
																														       IF(left.new_addr_ind = 0,91,left.new_addr_ind + 1))),
															                          91);
                               self := right),local);

// output(addr_drops_numbered,named('addr_drops_numbered'),extend);															 
 merge_addrs := join(addr_dedup,addr_drops_numbered,
                             left.did = right.did and
														 left.rid = right.rid,
                             transform(recordof(left),
                                       maxaddrind    := IF(left.addr_ind='',(string) right.new_addr_ind,
																			                     MAX(left.addr_ind,(string) right.new_addr_ind));													           
																			 self.addr_ind := IF(maxaddrind='0','',maxaddrind),
																			 self := left),
																			 left outer,local);

records_pre := iterate(sort(merge_addrs,did,(integer) addr_ind,-best_addr_ind,local),
                               transform(recordof(left),
                               self.best_addr_ind := IF(left.did = right.did and left.addr_ind = right.addr_ind and
															                          left.best_addr_ind = 'B','',right.best_addr_ind);
															 self := right),local);
															 
maintain_best := JOIN(DEDUP(SORT(disthdr(best_addr_ind = 'B'),did,addr_ind,rid,local),did,addr_ind,local),records_pre(best_addr_ind = 'B'),
														left.did = right.did AND 
														left.addr_ind = right.addr_ind AND 
														left.prim_range = right.prim_range AND 
														left.predir = right.predir AND 
														left.prim_name = right.prim_name AND 
														left.addr_suffix = right.addr_suffix AND 
														left.postdir = right.postdir AND 
														left.unit_desig = right.unit_desig AND 
														left.sec_range = right.sec_range AND 
														left.city = right.city AND 
														left.st = right.st AND 
														left.zip = right.zip AND 
														left.zip4 = right.zip4,
														TRANSFORM({unsigned8 rid},self.rid := IF(left.rid > 0, left.rid,right.rid)),local,right outer);

export records := JOIN(records_pre,maintain_best, 
														left.rid = right.rid,
														TRANSFORM(recordof(left), self.best_addr_ind := IF(right.rid > 0,'B',''),self:=left),hash,left outer);
															 
end;

