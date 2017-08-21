
allrecs := FLAccidents.ntlc_ss_Keybuild(vin+driver_license_nbr+tag_nbr+lname <>'');

crash_accnbr_base := allrecs
						((accident_nbr<>'' and accident_nbr<>'0000000000'));
											 
dst_accnbr_base := distribute(crash_accnbr_base, hash(accident_nbr));
srt_accnbr_base := sort(dst_accnbr_base, except did, except b_did, local);
dep_accnbr_base := dedup(srt_accnbr_base, except did, except b_did, local);

key_ntlcrash_accnbr_current := index(dep_accnbr_base
                                  ,{unsigned6 l_accnbr := (integer)accident_nbr}
								   ,{vehicle_incident_id,vehicle_status,dt_first_seen,dt_last_seen,accident_date,did,title,fname,mname,lname,name_suffix,b_did,cname
								   ,prim_range,predir,prim_name,addr_suffix,postdir
								   ,unit_desig,sec_range,v_city_name,st,zip,zip4
								   ,record_type,report_code,report_code_desc,report_category,vin,driver_license_nbr,dlnbr_st,tag_nbr,tagnbr_st,inquiry_mname,
										inquiry_zip5,inquiry_zip4,pdf_image_hash,tif_image_hash}
							      ,'~thor_data400::key::ntlcrash_accnbr_qa');
										

key_ntlcrash_accnbr_father := index(dep_accnbr_base
                                  ,{unsigned6 l_accnbr := (integer)accident_nbr}
								   ,{vehicle_incident_id,vehicle_status,dt_first_seen,dt_last_seen,accident_date,did,title,fname,mname,lname,name_suffix,b_did,cname
								   ,prim_range,predir,prim_name,addr_suffix,postdir
								   ,unit_desig,sec_range,v_city_name,st,zip,zip4
								   ,record_type,report_code,report_code_desc,report_category,vin,driver_license_nbr,dlnbr_st,tag_nbr,tagnbr_st,inquiry_mname,
										inquiry_zip5,inquiry_zip4,pdf_image_hash,tif_image_hash}
							      ,'~thor_data400::key::ntlcrash_accnbr_father');
	
rec := record
unsigned6 l_accnbr;
allrecs;
end;

dist := distribute(	key_ntlcrash_accnbr_current(vin <> ''),HASH(vin));
dist1 := distribute(	key_ntlcrash_accnbr_father(vin <> ''),HASH(vin));									
rec tjoin(dist l ,dist1 r) := transform
self.accident_nbr := (string) l.l_accnbr;
self := l;
end;

join1 := join(dist,dist1,LEFT.vin=	RIGHT.vin,tjoin(LEFT,RIGHT),LEFT ONLY,local);

										
export Sample_Ntl_data := output(topn(sort(join1(vehicle_status in ['V'] or vin <> '')   ,accident_date) ,500,-accident_date),named('SampleNewRecordswithvalidvin'));