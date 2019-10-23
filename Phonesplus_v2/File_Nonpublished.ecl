//***************Generates a file with non-pub records from Gong and Targus
//Non-published records in current gong
import /*Gong, gong_v2,*/ Targus,Gong_Neustar;

temp_np_layout := record
	unsigned3  	DateFirstSeen;
	unsigned3	DateLastSeen;
	unsigned6	did;
	string10 	prim_range; 
	string2 	predir; 
	string28 	prim_name; 
	string4 	suffix; 
	string2 	postdir; 
	string10 	unit_desig; 
	string8 	sec_range; 
	string25 	city_name; 
	string2     st;
	string5     zip5;
	string20 	fname; 
	string20    lname;
	string1     publish_code;
	string10	phone := '';
	string2		FileID;
end;

//-----------------------Non-published records in current gong-----------------------------
//Non-published records in current gong
gong_nonpublished 			:= project(Gong_Neustar.File_History(publish_code = 'N' and current_record_flag = 'Y'),	
							   transform(temp_np_layout, 
														self.lname 			:= left.name_last, 
														self.fname 			:= left.name_first, 												
														self.DateFirstSeen  := (unsigned)left.dt_first_seen[1..6],
														self.DateLastSeen 	:= (unsigned)left.dt_last_seen[1..6],
														self.city_name	 	:= left.v_city_name;
														self.zip5		  	:= left.z5;
														self.FileID			:= 'GC',
														self:= left)); 
														
//VC - As per Charles S the following serves no purpose. File_GongMaster is not updating.DF-23004
//Non-published current, but deleted due to vendor implementing new Non-published policy
// gong_nonpublished_del 		:= project(Gong_v2.File_GongMaster(publish_code = 'N' and vendor + '_' + deletion_date[..8] in ['0x8c_20090421']),	
							   // transform(temp_np_layout, 
														// self.lname 			:= left.name_last, 
														// self.fname 			:= left.name_first, 												
														// self.DateFirstSeen  := (unsigned)left.dt_first_seen[1..6],
														// self.DateLastSeen 	:= (unsigned)left.dt_last_seen[1..6],
														// self.city_name	 	:= left.v_city_name;
														// self.zip5		  	:= left.z5;
														// self.FileID         := 'GH',
														// self:= left)); 

//-----------------------Non-published records in targus------------------------------------
targus_nonpublished			:=  project(Targus.File_consumer_base(stringlib.stringfind(phone_number, 'X', 1) > 0),
								transform(temp_np_layout, 
														self.DateFirstSeen  := if((unsigned3)left.dt_first_seen[1..6] > 0, (unsigned3)left.dt_first_seen[1..6],(unsigned3)left.dt_last_seen[1..6]);
														self.DateLastSeen 	:= if((unsigned3)left.dt_last_seen[1..6] > 0, (unsigned3)left.dt_last_seen[1..6],(unsigned3)left.dt_first_seen[1..6]);
													    self.publish_code 	:= 'N', 
														self.phone 			:= left.phone_number;
														self.zip5		  	:= left.zip;
														self.FileID			:= 'TA',
														self:= left)); 

//---------------------All Non-publsied records--------------------------------------------

gong_nonpublished_d 	  := distribute(gong_nonpublished , hash(did,lname, prim_range, prim_name, sec_range, zip5));
gong_nonpublished_s 	  := sort(gong_nonpublished_d,did, lname, prim_range, prim_name, sec_range, zip5,-FileID, local); 
gong_nonpublished_dedp    := dedup(gong_nonpublished_s,did, lname, prim_range, prim_name, sec_range, zip5, local); 

targus_nonpublished_d 	  := distribute(targus_nonpublished, hash(did,lname, prim_range, prim_name, sec_range, zip5));
targus_nonpublished_s 	  := sort(targus_nonpublished,did, lname, prim_range, prim_name, sec_range, zip5, -phone, local); 
targus_nonpublished_dedp  := dedup(targus_nonpublished,did, lname, prim_range, prim_name, sec_range, zip5, local); 

//----------------------Append PhoneF7 from Targus nonpub for record that match gong nonpub by name and address
gong_with_phoneF7 := join(gong_nonpublished_dedp, 
						  targus_nonpublished_dedp,
						  left.lname = right.lname and
						  left.prim_range = right.prim_range and
						  left.prim_name = right.prim_name and
						  left.sec_range = right.sec_range and
						  left.zip5 = right.zip5,
				          transform(temp_np_layout,
						  self.phone :=  if(left.lname = right.lname, right.phone, left.phone),
						  self := left),
						  left outer,
						  local);

//-----------------------Find Targus nonpub where name and address is not in gong nonpub

exclusive_targuswp := join(gong_nonpublished_dedp, 
						  targus_nonpublished_dedp,
						  left.lname = right.lname and
						  left.prim_range = right.prim_range and
						  left.prim_name = right.prim_name and
						  left.sec_range = right.sec_range and
						  left.zip5 = right.zip5,
				          transform(temp_np_layout,
						  self 	   :=  right),
						  right only,
						  local);

export File_Nonpublished :=   gong_with_phoneF7 +  exclusive_targuswp
							  : persist('~thor400_30::persist::file_nonpublished');