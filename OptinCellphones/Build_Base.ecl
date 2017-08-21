import  address, ut, header_slimsort, did_add, didville,watchdog;
norm_addr	:=Clean_Addresses; 

//-----------------------------------------------------------------
//join Clean Names to normalized data
//-----------------------------------------------------------------
Layouts.Layout_Out t_parse_get_name (norm_addr le) := TRANSFORM
	SELF.title       	:= le.Clean_Name[ 1.. 5];
	SELF.fname       	:= le.Clean_Name[ 6..25];
	SELF.mname       	:= if(trim(le.Clean_Name[26..45],all) = 'NULL', '',le.Clean_Name[26..45]) ;
	SELF.lname       	:= le.Clean_Name[46..65];
	SELF.name_suffix 	:= le.Clean_Name[66..70];
	SELF.name_score  	:= le.Clean_Name[71..73];
	// SELF.date_first_seen:= (unsigned)le.Orig_Address_Start_date;
	SELF				:= le;
	SELF				:= [];
END;

proj_norm_addr := project(norm_addr,t_parse_get_name(left));					
					
invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];

Layouts.Layout_Out t_validate (proj_norm_addr  le) := TRANSFORM
	valid_date := if(le.orig_date[5..5] = '-',le.orig_date[1..4]+le.orig_date[6..7]+le.orig_date[9..10],le.orig_date[7..10]+le.orig_date[1..2]+le.orig_date[4..5]);
	
//----------------------------------------------------------------
//---VERY IMPORTANT: Setting first/last date seen and current record flag
//----------------------------------------------------------------

	SELF.date_first_seen			:=(unsigned)valid_date;
	SELF.date_last_seen				:=(unsigned)valid_date;
	SELF.date_vendor_first_reported	:=(unsigned)version;
	SELF.date_vendor_last_reported	:=(unsigned)version;
	SELF.current_rec_flag			:=1;//only one address per record, all addresses are expected to be current
	SELF							:=le;
END;

field_validation := project(distribute(proj_norm_addr, hash(Orig_Address, Orig_City, Orig_State, Orig_Zip5, Orig_Zip4)), 
										t_validate(left)): persist('~thor_data400::persist::optin_build::build_base::clean_normalized');
										
//-----------------------------------------------------------------										
//Delete records with Name score <= 50 or invalid state
//-----------------------------------------------------------------
valid_st := ['AA','AE','AK','AL','AP','AR','AS','AZ','CA','CO','CT','DC','DE','FL','FM','GA',
'GU','HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','PR','PW','RI',
'SC','SD','TN','TX','UT','VA','VI','VT','WA','WI','WV','WY', ''];


optin_clean_update :=field_validation (st in valid_st);
							
//-----------------------------------------------------------------
//Apply update to current base file
//-----------------------------------------------------------------

cur_base_d		:=distribute(Files.File_Base, hash(orig_fname,orig_lname));

cln_upd_d	:=distribute(optin_clean_update, hash(orig_fname,orig_lname));
cln_upd_srt	:=sort(cln_upd_d,orig_fname,orig_lname, local);
cur_update_d :=dedup(cln_upd_srt,Orig_fname,Orig_lname,Orig_Address,Orig_City,Orig_State,
										Orig_Zip5,Orig_Zip4,Orig_Phone, local);

Layouts.Layout_Out t_apply_updates (cur_base_d le, cur_update_d ri) := transform					
	SELF.current_rec_flag	:= if(
									le.Orig_fname=ri.Orig_fname and
									le.Orig_lname=ri.Orig_lname and
									le.Orig_Address = ri.Orig_Address and
									le.Orig_City = ri.Orig_City and
									le.Orig_State = ri.Orig_State and
									le.Orig_Zip5 = ri.Orig_Zip5 and
									le.Orig_Zip4 = ri.Orig_Zip4 and
									le.Orig_Phone = ri.Orig_Phone and
									le.current_rec_flag = 1, 0, le.current_rec_flag);
	SELF 					:= le;
end;

apply_updates := join(cur_base_d,
					  cur_update_d,
									left.Orig_fname=right.Orig_fname and
									left.Orig_lname=right.Orig_lname and
									left.Orig_Address = right.Orig_Address and
									left.Orig_City = right.Orig_City and
									left.Orig_State = right.Orig_State and
									left.Orig_Zip5 = right.Orig_Zip5 and
									left.Orig_Zip4 = right.Orig_Zip4 and
									left.Orig_Phone = right.Orig_Phone,
					  t_apply_updates(left, right),
					  left outer,
					  local);

base_and_update := if(FileServices.GetSuperFileSubCount(Superfile_List.Base_File) = 0, 
					  optin_clean_update,  
					  optin_clean_update + apply_updates);

matchset := ['A','Z','P'];

did_add.MAC_Match_Flex
	(base_and_update,
	 matchset,
	 SSN,
	 Date_of_Birth,
	 fname, mname,
	 lname,
	 name_suffix,
	 prim_range,
	 prim_name,
	 sec_range,
	 zip,
	 st,
	 Orig_phone,
	 DID,
	 Layouts.Layout_Out,
	 true,
	 DID_Score_field,
	 75,
	 d_did)

//-----------------------------------------------------------------
//Rollup to eliminate duplications
//-----------------------------------------------------------------

build_optin_base_d := distribute(d_did, hash(did, Orig_fname, Orig_lname )); 

build_optin_base_s := sort(build_optin_base_d, 
					did,
					Orig_fname,
					Orig_lname,
					Orig_Address,
					Orig_City,
					Orig_State,
					Orig_Zip5,
					Orig_Phone,
					provider,
					local);

Layouts.Layout_Out t_rollup (build_optin_base_s  le, build_optin_base_s ri) := transform
 // SELF.AddressSeq				 := ut.max2(le.AddressSeq, ri.AddressSeq);
  
 // SELF.NameType				 := if(le.NameType[..1] < ri.NameType[..1], le.NameType, ri.NameType);
 SELF.date_first_seen 			 := if(le.date_first_seen=0 or ri.date_first_seen=0,
										ut.max2(le.date_first_seen, ri.date_first_seen),
										ut.min2(le.date_first_seen, ri.date_first_seen));
 SELF.date_last_seen 			 := ut.max2(le.date_last_seen, ri.date_last_seen);
 SELF.date_vendor_first_reported := ut.min2(le.date_vendor_first_reported, ri.date_vendor_first_reported);
 SELF.date_vendor_last_reported  := ut.max2(le.date_vendor_last_reported, ri.date_vendor_last_reported);
 SELF.current_rec_flag		     := ut.max2(le.current_rec_flag, ri.current_rec_flag);
 self.provider 					 := if(trim(le.provider) <> trim(ri.provider) and length(trim(le.provider)) = 2 and length(trim(ri.provider)) = 2, 'P1P2', trim(ri.provider)); 
 self.zip4						 := if(le.zip4 = '',ri.zip4,le.zip4);
 self.email						 := if(le.email = '',ri.email,le.email);
 self.ipaddress					 := if(le.ipaddress = '',ri.ipaddress,le.ipaddress);
 self.status					 := if(le.status = '',ri.status,le.status);
 self.recordnum					 := if(le.recordnum = '',ri.recordnum,le.recordnum);
 self := le;
end;

optin_build_base := rollup(build_optin_base_s,
					t_rollup(left, right),
					did,
					Orig_fname,
					Orig_lname,
					Orig_Address,
					Orig_City,
					Orig_State,
					Orig_Zip5,
					Orig_Phone,
					local);

export Build_Base := optin_build_base;