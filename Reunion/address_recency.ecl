import std, header, infutor;

lay := recordof(infutor.infutor_header);

export address_recency(dataset(lay) hdr0,
                       integer threshold_) := 
module

hdr := distribute(hdr0,hash(prim_range,prim_name,sec_range,zip));

rec := record
 hdr.prim_range;
 hdr.prim_name;
 hdr.sec_range;
 hdr.zip;
 unsigned3 max_dt_last_seen := max(group, hdr.dt_last_seen);
end;

export all_addresses := table(hdr,rec,prim_range,prim_name,sec_range,zip,local);

unsigned3 getdate_yyyymm 	:= (integer)((STRING8)Std.Date.Today())[1..6];

integer fn_nbr_of_months(unsigned3 pInput) := 
  ((unsigned2)(((string)pInput)[1..4])*12) + ((unsigned2)(((string)pInput)[5..6]));

  
//Only keep addresses that have either: 1) no date history at all or 2) been seen within the last threshold_ months
keep_recent 	:= all_addresses(
                max_dt_last_seen=0
				or
                fn_nbr_of_months(max_dt_last_seen)>=(fn_nbr_of_months(getdate_yyyymm)-threshold_)
			   );

export recent_addresses := keep_recent;

end;