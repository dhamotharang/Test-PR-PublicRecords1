import Ingenix_NatlProf,Address;

in_file := Ingenix_NatlProf.File_in_ProviderAddress.Allsrc;

file_dist := distribute(in_file, hash(FILETYP, ProviderID, addressID));
file_sort := sort(file_dist,FILETYP, ProviderID,AddressID, Address, Address2, City, State, County, ZIP,ExtZip,-ProcessDate, local);

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderAddress.raw_srctype;
string182 clean_address := '';
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported;    
end;

new_rec  tappending(ingenix_Natlprof.Layout_in_ProviderAddress.raw_srctype L) := Transform

self.dt_first_seen              := '';
self.dt_last_seen               := '';
self.dt_vendor_first_reported   := L.processdate;
self.dt_vendor_last_reported    := L.processdate;
self := L;

end;

TProviderAddress := project(file_sort, tappending(left));

string address_filter(string addressfield) := StringLib.stringfilter(addressfield, '0123456789');

new_rec  rollupXform(new_rec l, new_rec r) := transform
        
self.zip := address_filter(L.zip);
self.extzip := address_filter(L.extzip);
string add1_input := L.address + ' ' + L.address2;
string add2_input := L.city + ' '+ L.state + ' ' + address_filter(L.zip) + address_filter(L.extzip);
self.clean_address := if(l.clean_address <> '', l.clean_address, if(trim(add1_input,all) <> '' or trim(add2_input,all)<>'', 
                                  Address.CleanAddress182(add1_input,add2_input), '') );
self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
self := l;
end;

export File_clean_in_ProviderAddress := rollup(TProviderAddress,rollupXform(LEFT,RIGHT),FILETYP, ProviderID,AddressID, Address, Address2, City, State, County, ZIP,ExtZip, local);
/*
string address_filter(string addressfield) := StringLib.stringfilter(addressfield, '0123456789');

new_rec  tcleaning(rollup_ProviderAddress L) := Transform
                  
self.zip := address_filter(L.zip);
self.extzip := address_filter(L.extzip);
string add1_input := L.address + ' ' + L.address2;
string add2_input := L.city + ' '+ L.state + ' ' + address_filter(L.zip) + address_filter(L.extzip);
self.clean_address := if(trim(add1_input,all)='' or trim(add2_input,all)='','',
					Address.CleanAddress182(add1_input,add2_input));
self := L;
end;

export File_clean_in_ProviderAddress := project(rollup_ProviderAddress, tcleaning(left));*/
