//gong key based on some address fields
import doxie, gong, Data_Services, header_services;

g := Gong.File_Gong_Full_Prepped_For_Keys(trim(prim_name)<>'', trim(z5)<>'');

//CCPA-22 
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
	UNSIGNED6 DID:=0;
	UNSIGNED4 global_sid:=0;
	UNSIGNED8 record_sid:=0;
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

/////////////////////////////////////////////////////////////

layout_gong_inj := RECORD
 gong.Layout_history ;
 string2 eor ;
END;

header_services.Supplemental_Data.mac_verify('file_gong_inj.txt', layout_gong_inj , attr);

Base_File_Append_In := attr();

g  xTo_bscurrent_raw (Base_File_Append_In L ):= TRANSFORM

	SELF := L ;
 
END ;

File_Append_In:= project(Base_File_Append_In, xTo_bscurrent_raw(left)); // in gong.Layout_bscurrent_raw format

all_in := g + File_Append_In ;

////////////////////////////////////////////////////



wcn := dedup (sort (project (all_in, addcn(left)), record), record) : persist('~thor_data400::persist::gong::address_current'); //"record" is temporarily here, I hope.



export File_Address_Current := wcn;