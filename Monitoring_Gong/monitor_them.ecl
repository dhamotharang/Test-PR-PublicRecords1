//this program calculates the connects and disconnects of phone records by different fields, for different vendor
import gong_v2, monitoring, ut;

//get the current gong records which has a phone number
f_gong_current := dataset(ut.foreign_prod + 'thor_200::base::gongv2_master',
                          gong_v2.layout_gongMasterAid,thor)(current_record_flag='Y', phone10<>'');

f_gong_current_slim := project(f_gong_current, monitoring_gong.layout_gong_slim);

//moving around the stored & newly created files 
create_gong_hist := sequential(output(f_gong_current_slim,,'~thor_data400::base::monitoring::gong_current' + thorlib.wuid()),
					                            fileservices.ClearSuperFile('~thor_data400::base::monitoring::gong_current_lastweek', true),
									      							fileServices.AddSuperFile('~thor_data400::base::monitoring::gong_current_lastweek', 
											                                          '~thor_data400::base::monitoring::gong_current_thisweek',, true),
														      		fileservices.ClearSuperFile('~thor_data400::base::monitoring::gong_current_thisweek'),													
							                        fileservices.AddSuperFile('~thor_data400::base::monitoring::gong_current_thisweek',
							                                                  '~thor_data400::base::monitoring::gong_current' + thorlib.wuid()));

//access the current & historical gong records
f_gong_last_week := monitoring_gong.file_gong_current_lastweek;
f_gong_this_week := monitoring_gong.file_gong_current_thisweek;

//count by phone
layout_diff_by_phone := record
   string vendor := '';
	 string10 phone10 := '';
	 string1 conn_disc_flag := '';
end;

f_phone_last_week_dst :=  distribute(project(f_gong_last_week, transform(layout_diff_by_phone, self := left, self:=[])),
                                 hash(vendor, phone10));
f_phone_last_week_dep := dedup(sort(f_phone_last_week_dst,record,local),record,local);																 

f_phone_this_week_dst :=  distribute(project(f_gong_this_week, transform(layout_diff_by_phone, self := left, self:=[])),
                                 hash(vendor, phone10));																 
f_phone_this_week_dep := dedup(sort(f_phone_this_week_dst,record,local),record,local);		

layout_diff_by_phone get_diff_by_phone(f_phone_this_week_dep l, f_phone_last_week_dep r) := transform
	self.phone10 := map(l.phone10='' and r.phone10<>'' => r.phone10,
										  l.phone10<>'' and r.phone10='' => l.phone10,
											'');
  self.vendor := map(l.phone10='' and r.phone10<>'' => r.vendor,
							 		   l.phone10<>'' and r.phone10='' => l.vendor,
										 '');
	self.conn_disc_flag := map(l.phone10='' and r.phone10<>'' => 'D',
							 		          l.phone10<>'' and r.phone10='' => 'C',
										        '');									 
	
end;
														
f_gong_diff_by_phone := join(f_phone_this_week_dep, f_phone_last_week_dep, 
                             left.vendor = right.vendor and
                             left.phone10 = right.phone10, 
														 get_diff_by_phone(left, right),local, full outer) : persist('per_f_gong_diff_by_phone');
											
gong_conn_by_phone_tbl := table(f_gong_diff_by_phone(conn_disc_flag='C'), {vendor, phone_conn_cnt := count(group)}, vendor);
gong_disc_by_phone_tbl := table(f_gong_diff_by_phone(conn_disc_flag='D'), {vendor, phone_disc_cnt := count(group)}, vendor);											

//count by phone & name
layout_diff_by_phone_name := record
   string vendor := '';
	 string10 phone10 := '';
	 string120 company_name:='';
	 string1 conn_disc_flag := '';
end;

f_phone_name_last_week_dst :=  distribute(project(f_gong_last_week(company_name<>''), transform(layout_diff_by_phone_name, self := left, self:=[])),
                                          hash(vendor, phone10, company_name));
f_phone_name_last_week_dep := dedup(sort(f_phone_name_last_week_dst,record,local),record,local);																 

f_phone_name_this_week_dst :=  distribute(project(f_gong_this_week(company_name<>''), transform(layout_diff_by_phone_name, self := left, self:=[])),
                                          hash(vendor, phone10, company_name));																 
f_phone_name_this_week_dep := dedup(sort(f_phone_name_this_week_dst,record,local),record,local);	

layout_diff_by_phone_name get_diff_by_phone_name(f_phone_name_this_week_dep l, f_phone_name_last_week_dep r) := transform
	self.phone10 := map(l.phone10='' and r.phone10<>'' => r.phone10,
										  l.phone10<>'' and r.phone10='' => l.phone10,
											'');
  self.vendor := map(l.phone10='' and r.phone10<>'' => r.vendor,
							 		   l.phone10<>'' and r.phone10='' => l.vendor,
										 '');
	self.company_name := map(l.phone10='' and r.phone10<>'' => r.company_name,
							 		         l.phone10<>'' and r.phone10='' => l.company_name,
										       '');
	self.conn_disc_flag := map(l.phone10='' and r.phone10<>'' => 'D',
							 		          l.phone10<>'' and r.phone10='' => 'C',
										        '');									 
	
end;
														
f_gong_diff_by_phone_name := join(f_phone_name_this_week_dep, 
                                  f_phone_name_last_week_dep, 
                                  left.vendor = right.vendor and
                                  left.phone10 = right.phone10 and
														      left.company_name = right.company_name, 
														      get_diff_by_phone_name(left, right),local, full outer) : persist('per_f_gong_diff_by_phone_name');
											
gong_conn_by_phone_name_tbl := table(f_gong_diff_by_phone_name(conn_disc_flag='C'), {vendor, phone_name_conn_cnt := count(group)}, vendor);
gong_disc_by_phone_name_tbl := table(f_gong_diff_by_phone_name(conn_disc_flag='D'), {vendor, phone_name_disc_cnt := count(group)}, vendor);											

//count by phone & address
layout_diff_by_phone_addr := record
   string vendor := '';
	 string10 phone10 := '';
	 string10 prim_range:='';
   string28 prim_name:='';
   string5 z5:='';
	 string1 conn_disc_flag := '';
end;

f_phone_addr_last_week_dst :=  distribute(project(f_gong_last_week(prim_name<>''), transform(layout_diff_by_phone_addr, self := left, self:=[])),
                                             hash(vendor, phone10, z5, prim_name, prim_range));
f_phone_addr_last_week_dep := dedup(sort(f_phone_addr_last_week_dst,record,local),record,local);																 

f_phone_addr_this_week_dst :=  distribute(project(f_gong_this_week(prim_name<>''), transform(layout_diff_by_phone_addr, self := left, self:=[])),
                                             hash(vendor, phone10, z5, prim_name, prim_range));																 
f_phone_addr_this_week_dep := dedup(sort(f_phone_addr_this_week_dst,record,local),record,local);	

layout_diff_by_phone_addr get_diff_by_phone_addr(f_phone_addr_this_week_dep l, f_phone_addr_last_week_dep r) := transform
	self.phone10 := map(l.phone10='' and r.phone10<>'' => r.phone10,
										  l.phone10<>'' and r.phone10='' => l.phone10,
											'');
  self.vendor := map(l.phone10='' and r.phone10<>'' => r.vendor,
							 		   l.phone10<>'' and r.phone10='' => l.vendor,
										 '');
	self.prim_range := map(l.phone10='' and r.phone10<>'' => r.prim_range,
							 		   l.phone10<>'' and r.phone10='' => l.prim_range,
										 '');
	self.prim_name := map(l.phone10='' and r.phone10<>'' => r.prim_name,
							 		   l.phone10<>'' and r.phone10='' => l.prim_name,
										 '');
	self.z5 := map(l.phone10='' and r.phone10<>'' => r.z5,
							 		   l.phone10<>'' and r.phone10='' => l.z5,
										 '');
	self.conn_disc_flag := map(l.phone10='' and r.phone10<>'' => 'D',
							 		          l.phone10<>'' and r.phone10='' => 'C',
										        '');									 
	
end;
														
f_gong_diff_by_phone_addr := join(f_phone_addr_this_week_dep, 
                                  f_phone_addr_last_week_dep, 
                                  left.vendor = right.vendor and
                                  left.phone10 = right.phone10 and
													    	  left.prim_name = right.prim_name and 
														      left.prim_range = right.prim_range and
																	left.z5 = right.z5, 
														      get_diff_by_phone_addr(left, right),local, full outer) : persist('per_f_gong_diff_by_phone_address');
											
gong_conn_by_phone_addr_tbl := table(f_gong_diff_by_phone_addr(conn_disc_flag='C'), {vendor, phone_addr_conn_cnt := count(group)}, vendor);
gong_disc_by_phone_addr_tbl := table(f_gong_diff_by_phone_addr(conn_disc_flag='D'), {vendor, phone_addr_disc_cnt := count(group)}, vendor);											
					
layout_vendor_disc_cnt := record
	string vendor := '',
	unsigned phone_conn_cnt,
	unsigned phone_disc_cnt,
	unsigned phone_name_conn_cnt,
	unsigned phone_name_disc_cnt,
	unsigned phone_addr_conn_cnt,
	unsigned phone_addr_disc_cnt,
	string8 cal_date,
end;					
					
layout_vendor_disc_cnt get_disc_cnt1(gong_conn_by_phone_tbl l,
                                     gong_conn_by_phone_name_tbl r) := transform
	self.vendor := if(l.vendor<>'', l.vendor, r.vendor);
	self.phone_conn_cnt := if(l.vendor<>'',l.phone_conn_cnt,0);
	self.phone_name_conn_cnt := if(r.vendor<>'', r.phone_name_conn_cnt, 0);
	self := [];
end;					

f_gong_final_1 := join(gong_conn_by_phone_tbl, gong_conn_by_phone_name_tbl,
                       left.vendor = right.vendor, get_disc_cnt1(left, right), full outer);		

layout_vendor_disc_cnt get_disc_cnt2(f_gong_final_1 l,
                                     gong_conn_by_phone_addr_tbl r) := transform
	self.vendor := if(l.vendor<>'', l.vendor, r.vendor);
	self.phone_conn_cnt := if(l.vendor<>'',l.phone_conn_cnt,0);
	self.phone_name_conn_cnt := if(l.vendor<>'', l.phone_name_conn_cnt, 0);
	self.phone_addr_conn_cnt := if(r.vendor<>'', r.phone_addr_conn_cnt, 0);
	self := [];
end;
										
f_gong_final_2 := join(f_gong_final_1, gong_conn_by_phone_addr_tbl,
										   left.vendor = right.vendor, get_disc_cnt2(left, right), full outer);

layout_vendor_disc_cnt get_disc_cnt3(f_gong_final_2 l,
                                     gong_disc_by_phone_tbl r) := transform
	self.vendor := if(l.vendor<>'', l.vendor, r.vendor);
	self.phone_conn_cnt := if(l.vendor<>'',l.phone_conn_cnt,0);
	self.phone_name_conn_cnt := if(l.vendor<>'', l.phone_name_conn_cnt, 0);
	self.phone_addr_conn_cnt := if(l.vendor<>'', l.phone_addr_conn_cnt, 0);
	self.phone_disc_cnt := if(r.vendor<>'',r.phone_disc_cnt,0);
	self := [];
end;

f_gong_final_3 := join(f_gong_final_2, gong_disc_by_phone_tbl,
                       left.vendor = right.vendor, get_disc_cnt3(left, right), full outer);

layout_vendor_disc_cnt get_disc_cnt4(f_gong_final_3 l,
                                     gong_disc_by_phone_name_tbl r) := transform
	self.vendor := if(l.vendor<>'', l.vendor, r.vendor);
	self.phone_conn_cnt := if(l.vendor<>'',l.phone_conn_cnt,0);
	self.phone_name_conn_cnt := if(l.vendor<>'', l.phone_name_conn_cnt, 0);
	self.phone_addr_conn_cnt := if(l.vendor<>'', l.phone_addr_conn_cnt, 0);
	self.phone_disc_cnt := if(l.vendor<>'',l.phone_disc_cnt,0);
	self.phone_name_disc_cnt := if(r.vendor<>'',r.phone_name_disc_cnt,0);
	self := [];
end;
							 
f_gong_final_4 := join(f_gong_final_3,gong_disc_by_phone_name_tbl, 
							   		  left.vendor = right.vendor, get_disc_cnt4(left, right), full outer);					
										

layout_vendor_disc_cnt get_disc_cnt5(f_gong_final_4 l,
                                     gong_disc_by_phone_addr_tbl r) := transform
	self.vendor := if(l.vendor<>'', l.vendor, r.vendor);
	self.phone_conn_cnt := if(l.vendor<>'',l.phone_conn_cnt,0);
	self.phone_name_conn_cnt := if(l.vendor<>'', l.phone_name_conn_cnt, 0);
	self.phone_addr_conn_cnt := if(l.vendor<>'', l.phone_addr_conn_cnt, 0);
	self.phone_disc_cnt := if(l.vendor<>'',l.phone_disc_cnt,0);
	self.phone_name_disc_cnt := if(l.vendor<>'',l.phone_name_disc_cnt,0);
	self.phone_addr_disc_cnt := if(r.vendor<>'',r.phone_addr_disc_cnt,0);
	self.cal_date := ut.GetDate;
end;
							 
f_gong_final_5 := join(f_gong_final_4,gong_disc_by_phone_addr_tbl, 
							   		  left.vendor = right.vendor, get_disc_cnt5(left, right), full outer);
										
create_gong_stats := sequential(output(f_gong_final_5,,'~thor_data400::base::monitoring::gong_diff_stats' + thorlib.wuid()),
					                             fileservices.AddSuperFile('~thor_data400::base::monitoring::gong_diff_stats',
							                                                  '~thor_data400::base::monitoring::gong_diff_stats' + thorlib.wuid()));										
										
export monitor_them := if(ut.Weekday((unsigned)ut.GetDate)='THURSDAY',
                          sequential(create_gong_hist, create_gong_stats),
													output('Gong monitoring not runing today.'));