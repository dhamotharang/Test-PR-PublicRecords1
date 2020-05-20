import  ut, did_add, experianirsg_build;
norm_addr	:=ExperianIRSG_Build.Clean_Addresses;

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
	SELF.date_first_seen:= (unsigned)le.Orig_Address_Start_date;
	SELF				:= le;
	SELF				:= [];
END;

proj_norm_addr := project(norm_addr,t_parse_get_name(left));

invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];

Layouts.Layout_Out t_validate (proj_norm_addr  le) := TRANSFORM
	valid_dob   			:=if((unsigned)le.Orig_Date_of_Birth between 18000101 and (unsigned) ut.GetDate, le.Orig_Date_of_Birth, '');

	SELF.Date_of_Birth		:=valid_dob;
	SELF.prim_name   		:=if(trim(le.prim_name) in invalid_prim_name,'',le.prim_name);
	SELF.zip         		:=if(le.zip='00000','',le.zip);
	SELF.zip4       	 	:=if(le.zip4='0000','',le.zip4);

//----------------------------------------------------------------
//---VERY IMPORTANT: Setting first/last date seen and current record flag
//----------------------------------------------------------------

	valid_Address_Create_Date		:=if((unsigned)le.date_first_seen between 18000101 and (unsigned) ut.GetDate, (unsigned) le.date_first_seen, 0);
	valid_Address_Date				:=if((unsigned)le.Orig_Address_date between 18000101 and (unsigned) ut.GetDate, (unsigned) le.Orig_Address_date, 0);

	SELF.date_first_seen			:=(unsigned)valid_Address_Create_Date;
	SELF.date_last_seen				:=(unsigned)valid_Address_Date;
	SELF.date_vendor_first_reported	:=(unsigned)version;
	SELF.date_vendor_last_reported	:=(unsigned)version;
	SELF.current_rec_flag			:=1;//only one address per record, all addresses are expected to be current
	SELF							:=le;
END;

field_validation := project(distribute(proj_norm_addr, hash(Orig_Prim_Range, Orig_Predir, Orig_Prim_Name, Orig_Addr_Suffix, Orig_Postdir, Orig_Unit_Desig, Orig_Sec_Range, Orig_City, Orig_State, Orig_ZipCode)),
										t_validate(left)): persist('~thor_data400::persist::experianirsg_build::build_base::clean_normalized');

//-----------------------------------------------------------------
//Delete records with Name score <= 50 or invalid state
//-----------------------------------------------------------------
valid_st := ['AA','AE','AK','AL','AP','AR','AS','AZ','CA','CO','CT','DC','DE','FL','FM','GA',
'GU','HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','PR','PW','RI',
'SC','SD','TN','TX','UT','VA','VI','VT','WA','WI','WV','WY', ''];

Bad_Names50_CurrentNmAddr 	:= field_validation(current_rec_flag = 1 and ((unsigned)name_score <= 50 or st not in valid_st));
Bad_Names50_CurrentNmAddr_d := distribute(Bad_Names50_CurrentNmAddr, hash(orig_fname,orig_lname,orig_mname,orig_suffix));
experian_d					:= distribute(field_validation, hash(orig_fname,orig_lname,orig_mname,orig_suffix));

Layouts.Layout_Out t_delete_bad_names(experian_d le, Bad_Names50_CurrentNmAddr_d ri) := transform
	SELF :=le;
end;

delete_bad_names :=join(experian_d, Bad_Names50_CurrentNmAddr_d,
							left.orig_fname = right.orig_fname and
							left.orig_lname = right.orig_lname and
							left.orig_suffix = right.orig_suffix and
							left.Orig_Prim_Range = 	right.Orig_Prim_Range and
							left.Orig_Predir = right.Orig_Predir and
							left.Orig_Prim_Name = right.Orig_Prim_Name and
							left.Orig_Addr_Suffix = right.Orig_Addr_Suffix and
							left.Orig_Postdir = right.Orig_Postdir and
							left.Orig_Unit_Desig = right.Orig_Unit_Desig and
							left.Orig_Sec_Range = right.Orig_Sec_Range and
							left.Orig_City = right.Orig_City and
							left.Orig_State = right.Orig_State and
							left.Orig_ZipCode = right.Orig_ZipCode and
							left.Orig_ZipCode4 = right.Orig_ZipCode4 and
							left.Orig_Phone_Num = right.Orig_Phone_Num,
						 t_delete_bad_names(left, right),
						 left only,
						 local);
experian_clean_update :=delete_bad_names ((unsigned)name_score > 50 and st in valid_st);

//-----------------------------------------------------------------
//Apply update to current base file
//-----------------------------------------------------------------

cur_base_d		:=distribute(Files.Base_File_Out, hash(orig_fname,orig_lname,orig_mname,orig_suffix));

exp_cln_upd_d	:=distribute(experian_clean_update, hash(orig_fname,orig_lname,orig_mname,orig_suffix));
exp_cln_upd_srt	:=sort(exp_cln_upd_d,orig_fname,orig_lname,orig_mname,orig_suffix, local);
cur_update_d	:=dedup(exp_cln_upd_srt,Orig_PID,Orig_fname,Orig_mname,Orig_lname,Orig_suffix,Orig_Title,
										Orig_Type,Orig_Title_of_Respect,Orig_Gender,Orig_Date_of_Birth,
										Orig_SSN,Orig_Prim_Range,Orig_Predir,Orig_Prim_Name,Orig_Addr_Suffix,
										Orig_Postdir,Orig_Unit_Desig,Orig_Sec_Range,Orig_City,Orig_State,
										Orig_ZipCode,Orig_ZipCode4,Orig_Phone_Num, local);

Layouts.Layout_Out t_apply_updates (cur_base_d le, cur_update_d ri) := transform

	SELF.current_rec_flag	:= if(
									le.Orig_fname=ri.Orig_fname and
									le.Orig_mname=ri.Orig_mname and
									le.Orig_lname=ri.Orig_lname and
									le.Orig_suffix=ri.Orig_suffix and
									le.Orig_Title=ri.Orig_Title and
									le.Orig_PID=ri.Orig_PID and
									le.Orig_Type=ri.Orig_Type and
									le.Orig_Title_of_Respect=ri.Orig_Title_of_Respect and
									le.Orig_Gender=ri.Orig_Gender and
									le.Orig_Date_of_Birth=ri.Orig_Date_of_Birth and
									le.Orig_SSN=ri.Orig_SSN and
									le.Orig_Prim_Range = 	ri.Orig_Prim_Range and
									le.Orig_Predir = ri.Orig_Predir and
									le.Orig_Prim_Name = ri.Orig_Prim_Name and
									le.Orig_Addr_Suffix = ri.Orig_Addr_Suffix and
									le.Orig_Postdir = ri.Orig_Postdir and
									le.Orig_Unit_Desig = ri.Orig_Unit_Desig and
									le.Orig_Sec_Range = ri.Orig_Sec_Range and
									le.Orig_City = ri.Orig_City and
									le.Orig_State = ri.Orig_State and
									le.Orig_ZipCode = ri.Orig_ZipCode and
									le.Orig_ZipCode4 = ri.Orig_ZipCode4 and
									le.Orig_Phone_Num = ri.Orig_Phone_Num and
									le.current_rec_flag = 1, 0, le.current_rec_flag);
	SELF.Orig_PID			:= MAX(le.orig_PID,ri.orig_PID);
	SELF 					:= le;
end;

apply_updates := join(cur_base_d,
					  cur_update_d,
									left.Orig_fname=right.Orig_fname and
									left.Orig_mname=right.Orig_mname and
									left.Orig_lname=right.Orig_lname and
									left.Orig_suffix=right.Orig_suffix and
									left.Orig_Title=right.Orig_Title and
									left.Orig_PID=right.Orig_PID and
									left.Orig_Type=right.Orig_Type and
									left.Orig_Title_of_Respect=right.Orig_Title_of_Respect and
									left.Orig_Gender=right.Orig_Gender and
									left.Orig_Date_of_Birth=right.Orig_Date_of_Birth and
									left.Orig_SSN=right.Orig_SSN and
									left.Orig_Prim_Range = 	right.Orig_Prim_Range and
									left.Orig_Predir = right.Orig_Predir and
									left.Orig_Prim_Name = right.Orig_Prim_Name and
									left.Orig_Addr_Suffix = right.Orig_Addr_Suffix and
									left.Orig_Postdir = right.Orig_Postdir and
									left.Orig_Unit_Desig = right.Orig_Unit_Desig and
									left.Orig_Sec_Range = right.Orig_Sec_Range and
									left.Orig_City = right.Orig_City and
									left.Orig_State = right.Orig_State and
									left.Orig_ZipCode = right.Orig_ZipCode and
									left.Orig_ZipCode4 = right.Orig_ZipCode4 and
									left.Orig_Phone_Num = right.Orig_Phone_Num,
					  t_apply_updates(left, right),
					  left outer,
					  local);

base_and_update := if(FileServices.GetSuperFileSubCount(Superfile_List.IRSG_Base_File) = 0,
					  experian_clean_update,
					  experian_clean_update + apply_updates);

matchset := ['A','Z','D','P'];

did_add.MAC_Match_Flex
	(base_and_update ,
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
	 Orig_phone_Num,
	 DID,
	 Layouts.Layout_Out,
	 true,
	 DID_Score_field,
	 75,
	 d_did)

//-----------------------------------------------------------------
//Rollup to eliminate duplications
//-----------------------------------------------------------------

build_experian_base_d := distribute(d_did, hash(did, Orig_PID, Orig_fname, Orig_lname, Orig_mname ));

build_experian_base_s := sort(build_experian_base_d,
					did,
					Orig_PID,
					Orig_fname,
					Orig_mname,
					Orig_lname,
					Orig_suffix,
					Orig_Title,
					Orig_Type,
					Orig_Title_of_Respect,
					Orig_Gender,
					Orig_Date_of_Birth,
					Orig_SSN,
					Orig_Prim_Range,
					Orig_Predir,
					Orig_Prim_Name,
					Orig_Addr_Suffix,
					Orig_Postdir,
					Orig_Unit_Desig,
					Orig_Sec_Range,
					Orig_City,
					Orig_State,
					Orig_ZipCode,
					Orig_ZipCode4,
					Orig_Phone_Num,
					local);

Layouts.Layout_Out t_rollup (build_experian_base_s  le, build_experian_base_s ri) := transform
 SELF.AddressSeq				 := ut.max2(le.AddressSeq, ri.AddressSeq);
 SELF.Orig_Address_Start_date  	 := if((unsigned)le.Orig_Address_Start_date=0 or (unsigned)ri.Orig_Address_Start_date=0,
										(string)ut.max2((unsigned)le.Orig_Address_Start_date, (unsigned)ri.Orig_Address_Start_date),
										(string)ut.min2((unsigned)le.Orig_Address_Start_date, (unsigned)ri.Orig_Address_Start_date));
 SELF.Orig_Address_date			 := (string)ut.max2((unsigned)le.Orig_Address_date, (unsigned)ri.Orig_Address_date);
 SELF.NameType					 := if(le.NameType[..1] < ri.NameType[..1], le.NameType, ri.NameType);
 SELF.date_first_seen 			 := if(le.date_first_seen=0 or ri.date_first_seen=0,
										ut.max2(le.date_first_seen, ri.date_first_seen),
										ut.min2(le.date_first_seen, ri.date_first_seen));
 SELF.date_last_seen 			 := ut.max2(le.date_last_seen, ri.date_last_seen);
 SELF.date_vendor_first_reported := ut.min2(le.date_vendor_first_reported, ri.date_vendor_first_reported);
 SELF.date_vendor_last_reported  := ut.max2(le.date_vendor_last_reported, ri.date_vendor_last_reported);
 SELF.current_rec_flag		     := ut.max2(le.current_rec_flag, ri.current_rec_flag);
 // SELF.Date_of_Birth				 := (string)ut.min2((unsigned)le.Date_of_Birth,(unsigned)ri.Date_of_Birth);
 self := le;
end;

experianirsg_build_base := rollup(build_experian_base_s,
					t_rollup(left, right),
					did,
					Orig_PID,
					Orig_fname,
					Orig_mname,
					Orig_lname,
					Orig_suffix,
					Orig_Title,
					Orig_Type,
					Orig_Title_of_Respect,
					Orig_Gender,
					Orig_Date_of_Birth,
					Orig_SSN,
					Orig_Prim_Range,
					Orig_Predir,
					Orig_Prim_Name,
					Orig_Addr_Suffix,
					Orig_Postdir,
					Orig_Unit_Desig,
					Orig_Sec_Range,
					Orig_City,
					Orig_State,
					Orig_ZipCode,
					Orig_ZipCode4,
					Orig_Phone_Num,
					local);

//-----------------------------------------------------------------
//Append Delete File
//-----------------------------------------------------------------
Experian_base_d     := distribute(experianirsg_build_base,  hash(orig_fname,orig_lname,orig_mname,orig_suffix));

export Build_Base := Experian_base_d;
