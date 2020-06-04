/*2017-02-28T08:31:04Z (Wendy Ma)
DF-18485
*/
import gong, header, Gong_Neustar;
//we'll pull the best phone (by date) from the DIDed gong file.
//we will then join the watchdog.joined file back to the gong afterward to pick up a few more
//--by lname/address
export BestPhone(string build_type = '') := function
//CCPA-22 - use the updated file definition from Gong_Neustar
f := Gong_Neustar.File_Gong_DID(phone10<>'' and did!=0);

gng_rec := record
  unsigned6 did := 0;
  string11 filedate := '';
  string10 phone10;
  string1  marketing_flag := '';
 END;

gng_rec slim_f(f l) := transform
 
 self.marketing_flag := L.cr_sort_sz;
 self := l;
end;

//Slim Gong with DID
f_slim := project(f,slim_f(left));

f_dis := distribute(f_slim,hash(did));

//Dedup taking the best phone per did
f_dup := dedup(sort(f_dis,did,-filedate,-phone10,local),did,local);

//Get header.BestPhone for DIDs not in f_dup
header_bestphone := header.bestphone(build_type);
gng_rec findPhone(header_bestphone L, gng_rec R) := transform
 self.phone10 := (string)l.phone;
 self := l;
end;

dis_phone := distribute(header_bestphone(quality>2),hash(did));

//Needed for temp fix -- remove dups from header.bestphone
//dup_head := dedup(sort(dis_phone,did,-phone,local),did,local);

//Join left only
more_phone := join(dis_phone,f_dup,left.did=right.did,findPhone(left,right),left only, local);

both_phones := distribute(f_dup + more_phone,hash(did));

BestPhone_out := both_phones((integer)phone10>1000000000) : persist('persist::Watchdog_BestPhone');

return BestPhone_out;

end;