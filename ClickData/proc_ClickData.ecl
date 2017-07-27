import address, doxie, gong, doxie_files, didville, header, ut, did_add, header_slimsort, watchdog;

export proc_clickdata(boolean Append_Bests) := function


df := clickdata.File_ClickData_In;

cleanrec := record
	df;
	unsigned4	seq 		 := 0;
	string73	clean_name := '';
	string50	addr2_expr := '';
end;

df2 := table(df,cleanrec);

ut.MAC_Sequence_Records(df2,seq,df3);

cleanrec into_clean1(df3 L) := transform
	self.clean_name := addrcleanlib.cleanperson73(L.full_name);
	self.addr2_expr := address.Addr2FromComponents(L.city,L.state,L.zip);
	self 		 := L;
end;

dfclean1 := project(df3,into_clean1(LEFT)) : persist('~thor_data400::persist::clickdata_clean_names');

address.MAC_Address_Clean(dfclean1,addr1,addr2_expr,true,dfclean)


didville.Layout_Did_OutBatch into_dib(dfclean L) := transform
	self.prim_range 	:= l.clean[1..10];
	self.Predir 		:= l.clean[11..12];
	self.prim_name 	:= l.clean[13..40];
	self.addr_Suffix 	:= l.clean[41..44];
	self.Postdir 		:= l.clean[45..46];
	self.unit_desig 	:= l.clean[47..56];
	self.Sec_Range 	:= l.clean[57..64];
	self.p_City_name 	:= l.clean[90..114];
	self.St 			:= l.clean[115..116];
	self.Z5 			:= l.clean[117..121];
	self.Zip4 		:= l.clean[122..125];
	self.title 		:= l.clean_name[1..5];
	self.fname 		:= l.clean_name[6..25];
	self.mname 		:= l.clean_name[26..45];
	self.lname 		:= l.clean_name[46..65];
	self.suffix 		:= l.clean_name[66..70];
	self.seq 			:= L.seq;
	self.dob 			:= L.dob;
	self.phone10 		:= L.phone;
	self.ssn 			:= '';
end;

df4 := project(dfclean, into_dib(LEFT)) : persist('~thor_data400::persist::clickdata_all_Clean');

myset := ['A','D','P','G','Z'];

did_add.MAC_Match_Flex(df4,myset,
			ssn,dob,fname,mname,lname,suffix,
			prim_range,prim_name,sec_range,z5,st,phone10,
			did,
			didville.Layout_Did_OutBatch,
			true, score,
			0,
			outf1)

outf1 get_best(outf1 Le, watchdog.File_Best_NonGLB Ri):= transform
	self.verify_best_phone   := did_add.phone_match_score(le.phone10,ri.phone);
	self.verify_best_name    := did_add.name_match_score(le.fname,le.mname,le.lname,ri.fname,ri.mname,ri.lname);
	self.verify_best_address := did_add.Address_Match_Score(le.prim_range,le.prim_name,le.sec_range,le.z5,ri.prim_range,ri.prim_name,ri.sec_range,ri.zip);
	self.best_addr_Date 	:= Ri.addr_dt_last_seen;
	self.best_fname		:= ri.fname;
	self.best_mname		:= ri.mname;
	self.best_lname		:= ri.lname;
	self.best_name_suffix	:= ri.name_suffix;
	self.best_addr1		:= address.Addr1FromComponents(Ri.prim_range, Ri.predir, Ri.prim_name, Ri.suffix, Ri.postdir, Ri.unit_desig, Ri.sec_range);
	self.best_city			:= Ri.city_name;
	self.best_state		:= Ri.st;
	self.best_zip			:= Ri.zip;
	self.best_zip4			:= Ri.zip4;
	self.best_phone		:= '';
	self 				:= Le;
end;

outf2 := join(distribute(outf1(did<>0),hash(did)),watchdog.file_best_NonGLB,
				left.did = right.did,
				get_best(LEFT,RIGHT),local, left outer) + outf1(did=0) : persist('~thor_data400::persist::clickdata_post_did','thor_dell400_2');

temprec := record
	clickdata.Layout_ClickData_Out;
	unsigned4	seq;
	unsigned6	temp_hhid;
	string20	lname;
	string10	prim_range;
	string28	prim_name;
	string8	sec_range;
	string2	st;
	string5	z5;
end;

temprec into_tempout(outf2 L, df3 R) := transform
	self.best_name_score 	   	:= IF (L.did=0, '', intformat(L.verify_best_name,3,1));
	self.best_Fname 			:= if (append_bests, L.best_fname, '');
	self.best_mname			:= if (append_bests, L.best_mname, '');
	self.best_lname			:= if (append_bests, L.best_lname, '');
	self.best_suffix			:= if (append_bests, L.best_name_suffix, '');
	self.best_address_score 	   	:= IF (L.did=0, '', intformat(L.verify_best_address,3,1));
	self.best_addr1			:= if (append_bests, L.best_addr1, '');
	self.best_city				:= if (append_bests, L.best_city, '');
	self.best_state			:= if (append_bests, L.best_state, '');
	self.best_zip				:= if (append_bests and L.best_zip<>'' and L.best_zip4<>'', L.best_zip + '-' + L.best_zip4, '');
	self.best_phone_score	   	:= IF (L.did=0, '', intformat(L.verify_best_phone,3,1));
	self.best_phone			:= '';
	self.best_Addr_Date 		:= if (L.did = 0, '', intformat(L.best_addr_date,6,1));
	self.adl 			   		:= if (L.did = 0, '', intformat(L.did, 12,1));
	self.num_header_recs   		:= '';
	self.temp_hhid				:= 0;
	self.hhid			   		:= '';
	self.eda_connect 	   		:= '';
	self.eda_disconnect	   		:= '';
	self.prim_range			:= L.prim_range;
	self.prim_name				:= L.prim_name;
	self.sec_range				:= L.sec_range;
	self.st					:= L.st;
	self.z5					:= L.z5;
	self.lname				:= L.lname;
	self 			   		:= R;
end;

outf3 := join(distribute(outf2,hash(seq)),distribute(df3,hash(seq)),
					left.seq = right.seq,
					into_tempout(LEFT,RIGHT),local);
					


outf3 add_HHID(outf3 L, header.file_HHid_current R) := transform
	self.temp_hhid := R.hhid_relat;
	self := L;
end;

outf4 := join(distribute(outf3,hash((integer)adl)),
		    distribute(header.File_HHID_Current, hash(did)),
				(integer)left.adl != 0 and 
				(integer)left.adl = right.did and
				right.ver = 1,
		    add_HHID(LEFT,RIGHT),left outer, local);


outf4_hhid := outf4(temp_hhid != 0);
outf4_nohhid := outf4(temp_hhid = 0);

didville.MAC_HHID_Append_By_Address(outf4_nohhid, outf5_a, temp_hhid,
				lname, prim_range, prim_name, sec_range, st, z5)

seqout := record
	clickdata.Layout_ClickData_Out;
	unsigned4	seq;
end;
				
seqout into_hhid(outf5_a L) := transform
	self.hhid := if (L.temp_hhid = 0, '', intformat(L.temp_hhid, 12, 1));
	self := L;
end;

outf5 := project(outf5_a + outf4_hhid, into_hhid(LEFT));

outf5 get_num_headerrecs(outf5 L, doxie_files.File_Lookups R) := transform
	self.num_header_recs := if (L.adl = '', '', intformat(R.head_cnt,4,1));
	self 			 := L;
end;

outf6 := join(distribute(outf5,hash((integer)adl)), 
			  distribute(doxie_files.File_Lookups,hash(did)),
				(integer)left.adl != 0 and
				(integer)left.adl = right.did,
			  get_num_headerrecs(LEFT,RIGHT),
			  left outer, local);

slimgong := record
	gong.File_Gong_History_Full.did;
	gong.File_Gong_History_Full.hhid;
	gong.File_Gong_History_Full.deletion_date;
	gong.File_Gong_History_Full.dt_first_seen;
end;

gf := table(gong.File_Gong_History_Full, slimgong);

outf6 get_gong_dates(outf6 L, gF R) := transform
	self.EDA_Disconnect := if ((integer)L.eda_disconnect > (integer)R.deletion_date, L.eda_disconnect, R.deletion_date);
	self.EDA_Connect := if (((integer)L.eda_connect != 0 and (integer)L.eda_connect < (integer)R.dt_first_seen) or (integer)R.dt_first_seen = 0, L.eda_connect, R.dt_first_seen);
	self := L;
end;

outf7a := join(distribute(outf6((integer)adl != 0), hash ((integer)adl)),
			distribute(gF(did != 0), hash (did)),
				(integer)left.adl = right.did,
			get_gong_dates(LEFT,RIGHT),
			left outer, local) + outf6((integer)adl = 0);
			
outf7 := join(distribute(outf7a((integer)hhid != 0), hash((integer)hhid)),
			distribute(gF(hhid != 0), hash(hhid)),
				(integer)left.hhid = right.hhid,
			get_gong_dates(LEFT,RIGHT),
			left outer, local) + outf7a((integer)hhid = 0);

outf7 roll_dates(outf7 L, outf7 R) := transform
	self.EDA_Disconnect := if ((integer)L.EDA_Disconnect > (integer)R.EDA_Disconnect, L.EDA_Disconnect, R.EDA_Disconnect);
	self.EDA_Connect := If (((integer)L.eda_connect != 0 and (integer)L.eda_connect < (integer)R.eda_connect) or (integer)R.eda_connect = 0, L.eda_connect, R.eda_connect);
	self := L;
end;

outf8 := group(rollup(group(sort(distribute(outf7,hash(Seq)),seq,local),seq,local), true, roll_dates(LEFT,RIGHT)));

outfinal := project(outf8, transform(clickdata.Layout_ClickData_Out, self := LEFT));

ut.MAC_SF_BuildProcess(outfinal,'~thor_Data400::base::clickdata',do1,3, true);

return do1;

end;
