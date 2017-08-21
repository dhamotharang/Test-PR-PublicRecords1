
// Swiped from Gong.Key_address_current

// gong key based on some address fields
import doxie, gong_Neustar, Data_Services, Gong;

//g := Gong_Neustar.File_Gong_Full_Prepped_For_Keys(trim(prim_name)<>'', trim(z5)<>'');
g := Gong_Neustar.File_History_Full_Prepped_for_Keys(current_record_flag<>'Y',trim(prim_name)<>'', trim(z5)<>'');

lraw := Gong_Neustar.Layout_bscurrent_raw;

// TODO: if "history" key will ever be adjusted, then it'd make sense to publish this layout
rec_address := record
  unsigned1 listing_type; //? or better phone_type?
  lraw.publish_code;

  lraw.phone10;
  lraw.prim_range;
  lraw.predir;
  lraw.prim_name;
  lraw.suffix;
  lraw.sec_range;
  lraw.st;
  lraw.z5;

  //TODO: use same names in both history and current keys
  // (have to choose between "first_name" and "fname", etc. "Standard" use 'fname')
  typeof (lraw.name_first) fname; 
  typeof (lraw.name_middle) mname;
  typeof (lraw.name_last) lname;
  lraw.omit_phone;
  lraw.name_suffix;
  lraw.listed_name;
  string8 date_first_seen;// := lraw.filedate[1..8];
   string8 date_last_seen;// := lraw.filedate[1..8];
 lraw.dual_name_flag;
 boolean	connected;
end;

rec_address addcn(g l) := transform
	self.date_first_seen := L.dt_first_seen;
	self.date_last_seen := L.dt_last_seen;
	self.connected := L.current_record_flag = 'Y';
	self.fname := L.name_first;
	self.mname := L.name_middle;
	self.lname := L.name_last;
  Self.listing_type := if (L.listing_type_bus='B', Gong.Constants.PTYPE.BUSINESS, 0) +
                       if (L.listing_type_res='R', Gong.Constants.PTYPE.RESIDENTIAL, 0) +
                       if (L.listing_type_gov='G', Gong.Constants.PTYPE.GOVERNMENT, 0);
	self := l;
end;

EXPORT gong_by_address_historical := dedup (sort (project (g, addcn(left)), record), record) //"record" is temporarily here, I hope. 
           : PERSIST('gong_by_address_historical');
