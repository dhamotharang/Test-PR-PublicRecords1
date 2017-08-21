import address, lib_stringlib, did_add, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville;
//***************************Conver input to Ascii
ExperianWP_in := project(ascii(Files.File_Source_In), transform(Layouts.Layout_In, self := left)) : persist('~thor_data400::persist::ExperianWP_ascii');

//****************************Normalize Occupants
Layouts.Layout_name_norm t_norm_name (ExperianWP_in le, integer counter_):= transform
	 string full_name1 := StringLib.StringCleanSpaces(if(trim(le.Primary_Occupant_First_Name + le.Primary_Occupant_Middle_Initial, all) <> '', le.Surname +', '+ le.Primary_Occupant_First_Name +' '+ le.Primary_Occupant_Middle_Initial, ''));
	 string full_name2 := StringLib.StringCleanSpaces(if(trim(le.Secondary_Occupant_First_Name + le.Secondary_Occupant_Middle_Initial, all) <> '',le.Surname +', '+ le.Secondary_Occupant_First_Name +' '+ le.Secondary_Occupant_Middle_Initial, ''));
	 string full_name3 := StringLib.StringCleanSpaces(if(trim(le.Third_Occupant_First_Name + le.Third_Occupant_Middle_Initial, all) <> '',le.Surname +', '+ le.Third_Occupant_First_Name +' '+ le.Third_Occupant_Middle_Initial, ''));
	 string full_name4 := StringLib.StringCleanSpaces(if(trim(le.Fourth_Occupant_First_Name + le.Fourth_Occupant_Middle_Initial, all) <> '',le.Surname +', '+ le.Fourth_Occupant_First_Name +' '+ le.Fourth_Occupant_Middle_Initial, ''));
	 string full_name5 := StringLib.StringCleanSpaces(if(trim(le.Fifth_Occupant_First_Name + le.Fifth_Occupant_Middle_Initial, all) <> '',le.Surname +', '+ le.Fifth_Occupant_First_Name +' '+ le.Fifth_Occupant_Middle_Initial, ''));

	 self.Occupant_Number := counter_;
	 self.Norm_Occupant_Type 			:= choose(counter_, le.Primary_Occupant_Type,  le.Secondary_Occupant_Type, le.Third_Occupant_Type, le.Fourth_Occupant_Type, le.Fifth_Occupant_Type );
	 self.Norm_Occupant_Name   			:= choose(counter_, full_name1, full_name2, full_name3, full_name4, full_name5);
	 self.Norm_Occupant_Title           := choose(counter_, le.Primary_Occupant_Title, le.Secondary_Occupant_Title, le.Third_Occupant_Title, le.Fourth_Occupant_Title, le.Fifth_Occupant_Title);
	 self.Norm_Occupant_Date_of_Birth 	:= choose(counter_,le.Primary_Occupant_Date_of_Birth, le.Secondary_Occupant_Date_of_Birth, le.Third_Occupant_Date_of_Birth, le.Fourth_Occupant_Date_of_Birth, le.Fifth_Occupant_Date_of_Birth);
	 self.Norm_Occupant_Sex 			:= choose(counter_, le.Primary_Occupant_Sex, le.Secondary_Occupant_Sex, le.Third_Occupant_Sex, le.Fourth_Occupant_Sex, le.Fifth_Occupant_Sex) ;
	 self.Norm_DOB_Indicator 			:= choose(counter_,le.DOB1_Indicator, le.DOB2_Indicator, le.DOB3_Indicator, le.DOB4_Indicator, le.DOB5_Indicator)  ;
	 self := le;
end;

norm_names := normalize(ExperianWP_in, 5, t_norm_name(left, counter));

//****************************Clean Names

norm_names_slim 	 := project(norm_names (Norm_Occupant_Name <> ''), transform(Layouts.layout_name, self := left));
norm_names_slim_d 	 := distribute(norm_names_slim, hash(Norm_Occupant_Name));
norm_names_slim_s 	 := sort(norm_names_slim_d, Norm_Occupant_Name, local );
norm_names_slim_dedp := dedup(norm_names_slim_s, Norm_Occupant_Name, local );

Layouts.Layout_name_clean t_clean_names(norm_names_slim_dedp le) := transform
	self.Clean_name := address.CleanPersonFML73(le.Norm_Occupant_Name);
    self := le;
end;

clean_names := project(norm_names_slim_dedp, t_clean_names(left));

//****************************Append Clean Name
norm_names_d := distribute(norm_names (Norm_Occupant_Name <> ''), hash(Norm_Occupant_Name));
norm_names_s := sort(norm_names_d ,Norm_Occupant_Name, local);


Layouts.Layout_name_norm_clean_name t_append_clean_name(norm_names_s le, clean_names ri) := transform
	self.Clean_name := ri.Clean_name;
	self := le;
end;

norm_with_clean_names := join(norm_names_s, clean_names, 
								left.Norm_Occupant_Name = right.Norm_Occupant_Name,
								t_append_clean_name(left, right), left outer,local) : persist('~thor_data400::persist::ExperianWP_norm_cleannames');


//****************************Clean Addresses
addresses_for_cleaning 		:= norm_with_clean_names(trim(House + Street_Direction_Prefix	+ Street + Street_Suffix + Street_Direction_Post + PO_Box + Unit_Designator + Unit + Zip_Code + Zip_4 + City_Standardized + City_Alternate_Name, all) <> '');
addresses_for_cleaning_t 	:= project(addresses_for_cleaning, transform(Layouts.Layout_address, self := left));
addresses_for_cleaning_d 	:= distribute(addresses_for_cleaning_t, hash(House , Street_Direction_Prefix	,Street ,Street_Suffix ,Street_Direction_Post, PO_Box , Unit_Designator , Unit , Zip_Code , Zip_4 , City_Standardized , City_Alternate_Name, State_Code));
addresses_for_cleaning_s 	:= sort(addresses_for_cleaning_d, House , Street_Direction_Prefix	,Street ,Street_Suffix ,Street_Direction_Post, PO_Box , Unit_Designator , Unit , Zip_Code , Zip_4 , City_Standardized , City_Alternate_Name, State_Code, local);
addresses_for_cleaning_dedp := dedup(addresses_for_cleaning_s , House , Street_Direction_Prefix	,Street ,Street_Suffix ,Street_Direction_Post, PO_Box , Unit_Designator , Unit , Zip_Code , Zip_4 , City_Standardized , City_Alternate_Name, State_Code,local);

Layouts.Layout_address_clean t_clean_addr (addresses_for_cleaning_dedp le) := transform
	string address1 := stringlib.StringCleanSpaces(le.House + ' ' + le.Street_Direction_Prefix + ' ' + le.Street + ' ' + le.Street_Suffix + ' ' + le.Street_Direction_Post + ' ' + le.PO_Box + ' ' + le.Unit_Designator + ' ' + le.Unit);
    string address2 := stringlib.StringCleanSpaces(if(trim(le.City_Standardized,all) <> '', le.City_Standardized, le.City_Alternate_Name) + ' ' +  le.State_Code + ' ' + le.Zip_Code + le.Zip_4 );
	self.clean_addr := address.CleanAddress182(address1, address2);
	self := le;
end;

clean_addr := project(addresses_for_cleaning_dedp, t_clean_addr (left)) : persist('~thor_data400::persist::ExperianWP_clean_addresses');
//****************************Append Clean Addresses
norm_d := distribute(norm_with_clean_names, hash(House , Street_Direction_Prefix	,Street ,Street_Suffix ,Street_Direction_Post, PO_Box , Unit_Designator , Unit , Zip_Code , Zip_4 , City_Standardized , City_Alternate_Name, State_Code));
norm_s := sort(norm_d, House , Street_Direction_Prefix	,Street ,Street_Suffix ,Street_Direction_Post, PO_Box , Unit_Designator , Unit , Zip_Code , Zip_4 , City_Standardized , City_Alternate_Name, State_Code, local);

Layouts.Layout_Base t_append_clean_add(norm_s le, clean_addr ri) := transform
	self.title       						:= le.clean_name[ 	1	..	 5];
	self.fname       						:= le.clean_name[ 	6	..	25];
	self.mname       						:= le.clean_name[	26	..	45];
	self.lname       						:= le.clean_name[	46	..	65];
	self.name_suffix 						:= le.clean_name[	66	..	70];
	SELF.name_score  						:= le.clean_name[	71	..	73];
	self.prim_range							:= ri.clean_addr[	1	..	10	];
	self.predir								:= ri.clean_addr[	11	..	12	];
	self.prim_name							:= ri.clean_addr[	13	..	40	];
	self.addr_suffix						:= ri.clean_addr[	41	..	44	];
	self.postdir							:= ri.clean_addr[	45	..	46	];
	self.unit_desig							:= ri.clean_addr[	47	..	56	];
	self.sec_range							:= ri.clean_addr[	57	..	64	];
	self.p_city_name						:= ri.clean_addr[	65	..	89	];
	self.v_city_name						:= ri.clean_addr[	90	..	114	];
	self.st									:= ri.clean_addr[	115	..	116	];
	self.zip								:= ri.clean_addr[	117	..	121	];
	self.zip4								:= ri.clean_addr[	122	..	125	];
	self.cart								:= ri.clean_addr[	126	..	129	];
	self.cr_sort_sz							:= ri.clean_addr[	130	..	130	];
	self.lot								:= ri.clean_addr[	131	..	134	];
	self.lot_order							:= ri.clean_addr[	135	..	135	];
	self.dbpc								:= ri.clean_addr[	136	..	137	];
	self.chk_digit							:= ri.clean_addr[	138	..	138	];
	self.rec_type							:= ri.clean_addr[	139	..	140	];
	self.county								:= ri.clean_addr[	141	..	145	];
	self.geo_lat							:= ri.clean_addr[	146	..	155	];
	self.geo_long							:= ri.clean_addr[	156	..	166	];
	self.msa								:= ri.clean_addr[	167	..	170	];
	self.geo_blk							:= ri.clean_addr[	171	..	177	];
	self.geo_match							:= ri.clean_addr[	178	..	178	];
	self.err_stat							:= ri.clean_addr[	179	..	182	];
	self.clean_dob 							:= ut.Date_YYYYDayOfYr((integer2)le.Norm_Occupant_Date_of_Birth[1..4], (integer2)le.Norm_Occupant_Date_of_Birth[5..7]), ;

		
	phone_num := stringlib.stringfindreplace(le.Phone_Area_Code + le.Phone_Number,' ','0');
	self.clean_phone						:= if(stringlib.stringfindreplace(phone_num,'0','')='','',phone_num);
	self.date_first_seen 					:= ut.Date_YYYYDayOfYr((integer2)le.Date_of_Knowledge[1..4], (integer2)le.Date_of_Knowledge[5..7]);
	self.date_last_seen						:= ut.Date_YYYYDayOfYr((integer2)le.Verified_Date[1..4], (integer2)le.Verified_Date[5..7]);
	self.date_vendor_first_reported 		:= version;
	self.date_vendor_last_reported 			:= version;
	self.latest_file_flag                   := 'Y';
	self := le;
end;

base_predid := join(norm_s, clean_addr,
						left.House = right.House and
						left.Street_Direction_Prefix = right.Street_Direction_Prefix and
						left.Street = right.Street and
						left.Street_Suffix = right.Street_Suffix and
						left.Street_Direction_Post = right.Street_Direction_Post and
						left.PO_Box = right.PO_Box and
						left.Unit_Designator = right.Unit_Designator and
						left.Unit = right.Unit and
						left.Zip_Code = right.Zip_Code and
						left.Zip_4 = right.Zip_4 and
						left.City_Standardized = right.City_Standardized and 
						left.City_Alternate_Name = right.City_Alternate_Name and 
						left.State_Code = right.State_Code,
						t_append_clean_add(left, right), left outer, local) : persist('~thor_data400::persist::ExperianWP_PreDid');
	
//****************************Did

ExperianWP_history 		 :=  Files.File_Base;
ExperianWP_history_reset := project(ExperianWP_history, transform(Layouts.Layout_Base, self.latest_file_flag := 'N', self := left));

base_predid_all := if(FileServices.GetSuperFileSubCount(Superfile_List.Base_File) = 0, base_predid,  base_predid + ExperianWP_history_reset);

matchset := ['A', 'D', 'P', 'Z'];

		DID_Add.MAC_Match_Flex(
			 base_predid_all						// Input Dataset
			,matchset	             				// Did_Matchset  what fields to match on
			,''                						// ssn
			,clean_dob                 				// dob
			,fname									// fname
			,mname			     					// mname
			,lname			     					// lname
			,name_suffix     						// name_suffix
			,prim_range	          					// prim_range
			,prim_name	          					// prim_name
			,sec_range	          					// sec_range
			,zip				          			// zip5
			,st			          					// state
			,clean_phone			          		// phone10
			,did                      				// Did
			,Layouts.Layout_Base					// output layout
			,TRUE                     				// Does output record have the score
			,did_score                				// did score field
			,75                       				// score threshold
			,dDidOut								// output dataset			
		);  

//****************************Rollup and keep most recent unique records


dDidOut_d := distribute(dDidOut, hash(did, prim_range,prim_name,sec_range, zip, st, fname, mname, lname)) : persist('~thor_data400::persist::ExperianWP_PostDid');;

dDidOut_s := sort(dDidOut_d, 
					did 	,
					prim_range	,
					prim_name	,
					sec_range 	,
					zip 	,
					st 	,
					fname 	,
					mname 	,
					lname	,
					State_Code	,
					Record_Type	,
					House	,
					Street_Direction_Prefix	,
					Street	,
					Street_Suffix	,
					Street_Direction_Post	,
					Zip_Code	,
					PO_Box	,
					Unit_Designator	,
					Unit	,
					City_Standardized	,
					City_Alternate_Name	,
					Zip_4	,
					Phone_Number	,
					Phone_Area_Code	,
					Phone_Listing	,
					Surname	,
					Primary_Occupant_Type	,
					Primary_Occupant_First_Name	,
					Primary_Occupant_Middle_Initial	,
					Primary_Occupant_Date_of_Birth	,
					Primary_Occupant_Sex	,
					Secondary_Occupant_Type	,
					Secondary_Occupant_First_Name	,
					Secondary_Occupant_Middle_Initial	,
					Secondary_Occupant_Date_of_Birth	,
					Secondary_Occupant_Sex	,
					Third_Occupant_Type	,
					Third_Occupant_First_Name	,
					Third_Occupant_Middle_Initial	,
					Third_Occupant_Date_of_Birth	,
					Third_Occupant_Sex	,
					Fourth_Occupant_Type	,
					Fourth_Occupant_First_Name	,
					Fourth_Occupant_Middle_Initial	,
					Fourth_Occupant_Date_of_Birth	,
					Fourth_Occupant_Sex	,
					Fifth_Occupant_Type	,
					Fifth_Occupant_First_Name	,
					Fifth_Occupant_Middle_Initial	,
					Fifth_Occupant_Date_of_Birth	,
					Fifth_Occupant_Sex	,
					FillerDwelling_Size_Code	,
					FillerHomeowner_Probability	,
					FillerMedian_Home_Value	,
					AddDelete_Indicator	,
					MM_Reference_Sequence_Number	,
					DOB1_Indicator	,
					DOB2_Indicator	,
					DOB3_Indicator	,
					DOB4_Indicator	,
					DOB5_Indicator	,
					Norm_Occupant_Type	,
					Norm_Occupant_Name	,
					Norm_Occupant_Date_of_Birth	,
					Norm_Occupant_Sex	,
					Norm_DOB_Indicator	,
					clean_DOB	,
					clean_phone	,
					title	,
					name_suffix	,
					name_score	,
					predir	,
					addr_suffix	,
					postdir	,
					unit_desig	,
					p_city_name	,
					v_city_name	,
					zip4	,
					cart	,
					cr_sort_sz	,
					lot	,
					lot_order	,
					dbpc	,
					chk_digit	,
					rec_type	,
					county	,
					geo_lat	,
					geo_long	,
					msa	,
					geo_blk	,
					geo_match	,
					err_stat	,
					-latest_file_flag,
					-Date_of_Knowledge,
					-date_last_seen,
				  local
);


Layouts.Layout_Base t_rollup (dDidOut_s  le, dDidOut_s  ri) := transform
 self.Batch_Creation_Date 		 := (string8) ut.max2((unsigned)le.Batch_Creation_Date, (unsigned)ri.Batch_Creation_Date);
 self.Batch_Creation_Time 		 := if(le.Batch_Creation_Date > ri.Batch_Creation_Date, le.Batch_Creation_Time ,ri.Batch_Creation_Time);
 self.Verified_Date 			 := (string8) ut.max2((unsigned)le.Verified_Date, (unsigned)ri.Verified_Date);
 self.Date_of_Knowledge 		 := (string8) ut.max2((unsigned)le.Date_of_Knowledge, (unsigned)ri.Date_of_Knowledge);
 self.Primary_Occupant_Title     := if(le.Primary_Occupant_Title <> '', le.Primary_Occupant_Title, ri.Primary_Occupant_Title ); 
 self.Secondary_Occupant_Title   := if(le.Secondary_Occupant_Title <> '', le.Secondary_Occupant_Title, ri.Secondary_Occupant_Title ); 
 self.Third_Occupant_Title     	 := if(le.Third_Occupant_Title <> '', le.Third_Occupant_Title, ri.Third_Occupant_Title ); 
 self.Fourth_Occupant_Title      := if(le.Fourth_Occupant_Title <> '', le.Fourth_Occupant_Title, ri.Fourth_Occupant_Title ); 
 self.Fifth_Occupant_Title       := if(le.Fifth_Occupant_Title <> '', le.Fifth_Occupant_Title, ri.Fifth_Occupant_Title ); 
 self.Occupant_Number	         := ut.min2((unsigned)le.Occupant_Number, (unsigned)ri.Occupant_Number);
 self.Norm_Occupant_Title        := if(le.Norm_Occupant_Title <> '', le.Norm_Occupant_Title, ri.Norm_Occupant_Title ); 
 self.date_first_seen 			 := (string8) ut.min2((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
 self.date_last_seen 			 :=  (string8)ut.max2((unsigned)le.date_last_seen, (unsigned)ri.date_last_seen);
 self.date_vendor_first_reported := (string8)ut.min2((unsigned)le.date_vendor_first_reported, (unsigned)ri.date_vendor_first_reported);
 self.date_vendor_last_reported  := (string8) ut.max2((unsigned)le.date_vendor_last_reported, (unsigned)ri.date_vendor_last_reported);
 self := le;
  
end;

ExperianWP_base := rollup(dDidOut_s , 
					t_rollup(left, right), 
					record,
					except Batch_Creation_Date,
					Batch_Creation_Time,
					Verified_Date,
					Date_of_Knowledge,
					Primary_Occupant_Title,
					Secondary_Occupant_Title,
					Third_Occupant_Title,
					Fourth_Occupant_Title,
					Fifth_Occupant_Title,
					Occupant_Number,
					Norm_Occupant_Title,
					date_first_seen,
					date_last_seen,
					date_vendor_first_reported,
					date_vendor_last_reported,
					latest_file_flag,
					local);

export Build_Base := ExperianWP_base;