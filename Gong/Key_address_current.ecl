//gong key based on some address fields
import doxie, gong, ut;

g := Gong.File_Gong_Full_Prepped_For_Keys(trim(prim_name)<>'', trim(z5)<>'');

lraw := Gong.Layout_bscurrent_raw;

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
  lraw.dual_name_flag;

end;

rec_address addcn(g l) := transform
	self.date_first_seen := L.filedate[1..8];
	self.fname := L.name_first;
	self.mname := L.name_middle;
	self.lname := L.name_last;
  Self.listing_type := if (L.listing_type_bus='B', Gong.Constants.PTYPE.BUSINESS, 0) +
                       if (L.listing_type_res='R', Gong.Constants.PTYPE.RESIDENTIAL, 0) +
                       if (L.listing_type_gov='G', Gong.Constants.PTYPE.GOVERNMENT, 0);
	self := l;
end;

wcn := dedup (sort (project (g, addcn(left)), record), record); //"record" is temporarily here, I hope.

// original Key_address:
//   keyed fields: {prim_name, z5, prim_range, sec_range, predir, suffix}
//   payload: {phone10, listed_name, fname, mname, lname, name_suffix, dual_name_flag, 
//             date_first_seen, listing_type_bus, listing_type_res, listing_type_gov}

// TODO: decide on whether to include 'st' similar to "historical key"
// export Key_address_current := index (wcn,
//DF26180 - Add global_sid and record_sid to this key
export Key_address_current := index (Gong.File_Address_Current,
  {prim_name, st, z5, prim_range, sec_range, predir, suffix}, 
  {phone10, listed_name, fname, mname, lname, name_suffix, dual_name_flag, 
	 date_first_seen, listing_type, publish_code, omit_phone,did,global_sid,record_sid},
  '~thor_data400::key::gong_address_current_' + doxie.Version_SuperKey );
