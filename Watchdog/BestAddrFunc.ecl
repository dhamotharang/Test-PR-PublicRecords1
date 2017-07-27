//========================================================
// Attribute: BestAddrFunc
// Function to get the best address.
//========================================================
/*This gives a best address
If multiple pick those with the most recent date last seen
If multiple then pick the one with a gong record
If multiple (or none) then pick the one with the most recent first reported
*/
import header,mdr, ut, utilfile,address;

export BestAddrFunc(
    dataset(Header.Layout_Header) myDs, //The header should be pre-filtered by myDate.
    unsigned3 myDate = 0, 
    boolean dppa = false, 
    boolean glb = false) := FUNCTION

f := myDs(zip4!='');

header.MAC_Best_Address(f, did, 2, en)

flag_rec := record
 en;
 string1 address_flag := '';
 unsigned3 addr_dt_last_seen := 0;
end;

flag_rec assignedDates(en Le) := transform
dt_last_seen := if(le.dt_last_seen=0,le.dt_vendor_last_reported,le.dt_last_seen);
// account for the fact that experian and equifax update at different times
// if the dt_last_seen is greater than the max_header_build_date passed in, 
// set the dt_last_seen to be the same as the max_last_seen date
self.dt_last_seen := if(dt_last_seen >= myDate, myDate, dt_last_seen);  
self.dt_first_seen := if(le.dt_first_seen=0,le.dt_vendor_first_reported,le.dt_first_seen);
self.unit_desig := if(le.sec_range='','',le.unit_desig);
self.addr_dt_last_seen := (unsigned3)le.dt_last_seen;
self := le;
end;

flag_add := project(en,assignedDates(left));
flag_add10 := sort(flag_add, did);//added to remove warning.
grp := group(flag_add10,did,local);
//grp := group(flag_add,did,local); //orig

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

srt_h := sort(compare_add,did,-dt_last_seen,-tnt_gd,-dt_first_seen,-dt_vendor_first_reported,-address_flag);
dup_h := dedup(srt_h,did); 

return dup_h(address_flag != 'Y');
END;
