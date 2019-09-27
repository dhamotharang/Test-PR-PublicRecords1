/*2016-09-22T21:05:18Z (Wendy Ma)
DF-17551 add build_type for FCRA best append
*/
/*This gives a best address
If multiple pick those with the most recent date last seen
If multiple then pick the one with a gong record
If multiple (or none) then pick the one with the most recent first reported
*/

import header,mdr, ut, utilfile,address,header_quick, AID,STD;

export bestaddress(string build_type = '') := function

string20 var1 := '' : stored('watchtype');

header_f   := file_header_filtered;
//Recalculate tnt flag because it may have already changed since gong is build daily
header_ := watchdog.Fn_Reset_Tnt(header_f);

iutilfile :=utilfile.DID_into_header(did>0);
ut.MAC_Sequence_Records(iutilfile, rid, utilfile_rid);
//Calculate tnt flag for utility records
utilfile_ :=  watchdog.Fn_Reset_Tnt(utilfile_rid);

QH       :=header_quick.QH_DID_into_header;
//Calculate tnt flag for quick header records
QH_ := watchdog.Fn_Reset_Tnt(QH);

f := map(	 var1='nonutility'        => header_
					,build_type='fcra_best_append'  => header_
					,var1='nonglb_nonutility' => header_
					,var1='marketing'         => header_
					,var1='nonglb'            => header_ //+ utilfile_ (utility became GLB with bug 118021)
					//Compid version no longer building
					//,var1='compid'            => header_ //+ utilfile_
					//,var1='compid_weekly'     => header_ //+ utilfile_
					,var1='glb_noneq'	        => header_ + utilfile_ + QH_(src not in ['WH', 'QH'])
					,var1='glb_nonen' 	    	=> header_ + utilfile_ + QH_(src <> 'EN')
					,var1='glb_nonen_noneq'  	=> header_ + utilfile_ + QH_(src not in ['EN','WH','QH'])
					,                            header_ + utilfile_ + QH_
					)(zip4!='');

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
GetDate:=(STRING8)Std.Date.Today();
self.dt_last_seen := ((integer)(GetDate[1..6])-if(le.dt_last_seen=0,le.dt_vendor_last_reported-2,le.dt_last_seen))/3;
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
				
po_box := if(compare_add.prim_name[1..7] = 'PO BOX ' or compare_add.prim_name[1..3] in ['RR ', 'HC '],1,2);

srt_h := sort(compare_add,did,dt_last_seen,-tnt_gd,-po_box,-dt_first_seen,-dt_vendor_first_reported,-address_flag);
dup_h := ungroup(dedup(srt_h,did)); 
BestAddress_out := dup_h(address_flag != 'Y') : persist('persist::Watchdog_BestAddress');

return BestAddress_out;

end;