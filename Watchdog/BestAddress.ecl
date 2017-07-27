/*This gives a best address
If multiple pick those with the most recent date last seen
If multiple then pick the one with a gong record
If multiple (or none) then pick the one with the most recent first reported
*/

import header,mdr, ut, utilfile,address,header_quick, AID;

string20 var1 := '' : stored('watchtype');

f0 := map(	var1='nonglb'			
								=> (file_header_filtered + utilfile.DID_into_header(did>0))(zip4!=''),
						var1='nonutility'
								=> (file_header_filtered) (zip4!=''),
						var1='nonglb_nonutility'
								=> (file_header_filtered) (zip4!=''),
						var1='marketing'
								=> (file_header_filtered) (zip4!=''),
						var1 in ['compid','compid_weekly']
								=> (file_header_filtered + utilfile.DID_into_header(did>0))(zip4!=''),
						var1='glb_nonen'			
								=> (file_header_filtered + utilfile.DID_into_header(did>0)+ header_quick.QH_DID_into_header)(zip4!=''),
						var1='glb_noneq'			
								=> (file_header_filtered + utilfile.DID_into_header(did>0))(zip4!=''),
								
						(file_header_filtered + utilfile.DID_into_header(did>0)+ header_quick.QH_DID_into_header)) (zip4!='');

Header.macGetCleanAddr(f0 , RawAID, true, f);

header.MAC_Best_Address(f, did, 2, en)

flag_rec := record
 en;
 string1 address_flag := '';
 unsigned3 addr_dt_last_seen := 0;
 unsigned3 addr_dt_first_seen := 0;
end;

flag_rec assignedDates(en Le) := transform

//assess a penalty to the vendor date so it doesn't have equal weight to the seen date
//results in approx 700k address changes W20080328-102320

self.dt_last_seen := ((integer)(ut.GetDate[1..6])-if(le.dt_last_seen=0,le.dt_vendor_last_reported-2,le.dt_last_seen))/3;
self.dt_first_seen := if(le.dt_first_seen=0,le.dt_vendor_first_reported-2,le.dt_first_seen);
self.unit_desig := if(le.sec_range='','',le.unit_desig);
self.addr_dt_last_seen := (unsigned3)le.dt_last_seen;
self.addr_dt_first_seen := (unsigned3)le.dt_first_seen;
self := le;
end;

flag_add := project(en,assignedDates(left));

grp := group(flag_add,did,local);

//Determine if the first address is better than the second.
flag_rec aflag(flag_rec le, flag_rec rt) := transform	
self.address_flag := if(le.dt_last_seen != rt.dt_last_seen or
							map(le.tnt='P'=>'2',le.tnt='Y'=>'1','0')!=
								map(rt.tnt='P'=>'2',rt.tnt='Y'=>'1','0') or
							le.dt_first_seen != rt.dt_first_seen,'N','Y');
self := rt;
end;

//take best address if available
compare_add := iterate(grp,aflag(left,right));

tnt_gd := map(compare_add.tnt='Y' => 1,
				compare_add.tnt='P' => 2,0);

srt_h := sort(compare_add,did,dt_last_seen,-tnt_gd,-dt_first_seen,-dt_vendor_first_reported,-address_flag);
dup_h := dedup(srt_h,did); 
export BestAddress := dup_h(address_flag != 'Y') : persist('persist::Watchdog_BestAddress');