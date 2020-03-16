import didville, doxie, dx_header, address, dx_Gong, ut, Relationship, clickdata;

export ClickData_Relatives_Function(dataset(clickdata.Layout_Clickdata_In_RR) inf,
  Doxie.IDataAccess mod_access, boolean append_bests = false) := function

seqrec := record
  inf;
  unsigned4	seq;
end;

seqrec into_seq(inf L, integer C) := transform
  self.seq := C;
  self.dob := L.dob;

  // Name bit
  to_clean := IF(L.full_name='',L.unParsedFullName,L.full_name);
  isParsed := L.Name_Last<>'' OR L.Name_First<>'';

  clean_name := IF(~isParsed, address.CleanPerson73(to_clean), '');
  self.name_first := IF(isParsed, L.Name_First, clean_name[6..25]);
  self.name_middle := IF(isParsed, L.Name_Middle, clean_name[26..45]);
  self.name_last := IF(isParsed, L.Name_Last, clean_name[46..65]);
  self.Name_Suffix := IF(isParsed, L.Name_Suffix, clean_name[66..70]);

  // just put the address bits into 1 set of fields
  SELF.addr1 := IF(L.addr1='',L.unParsedAddr1,L.addr1);
  SELF.city := IF(L.city='',L.p_city_name,l.city);
  SELF.state := IF(L.state='',L.st,L.state);
  SELF.zip := IF(L.zip='',L.z5,L.zip);
  self := L;
end;

df2 := project(inf,into_seq(LEFT,COUNTER));

Loadxml('<FOO/>');

didville.Layout_Did_outBatch into_dib(df2 L) := transform
  self.fname := L.Name_First;
  self.mname := L.Name_Middle;
  self.lname := L.Name_Last;
  self.suffix := L.Name_Suffix;
  self.phone10 := L.phone;
  self.did := (integer)L.did_in;
  clean_address := Address.CleanAddress182(L.addr1, address.Addr2FromComponents(L.city, L.state, L.zip));
  ut.MAC_Insert_CleanAddrs(clean_address,'P')
  self := L;
  self := [];
end;

df3 := project(df2,into_dib(LEFT));

df3_hasdid := df3(did != 0);
df3_nodid := df3(did  = 0);

didville.MAC_DidAppend(df3_nodid, outfa0, true, 'ZG')
outfa := group(df3_hasdid + outfa0);

didville.MAC_BestAppend(outfa,
                        'BEST_ALL',
                        'BEST_ALL',
                        0,
                        mod_access.isValidGLB(),
                        outfa1,
                        true,
                        // Using mod_access.DataRestrictionMask breaks this macro.
                        doxie.DataRestriction.fixed_DRM,
                        ,
                        ,
                        ,
                        ,
                        mod_access.application_type,
                        ,
                        mod_access.industry_class);

didville.MAC_HHid_Append(outfa1,'HHID_RELATIVES',outfa2)

key_lookups := dx_header.key_Did_Lookups();
outfa2 get_head_count(outfa2 L, key_lookups R) := transform
  self.head_cnt := R.head_cnt;
  self := L;
end;

outf := join(outfa2, key_lookups,
      left.did != 0 and
      keyed(left.did = right.did),
       get_head_count(LEFT,RIGHT),
       left outer);

outrec := layout_clickdata_out_RR;

temprec := record
  unsigned4	seq;
  outrec;
  unsigned6	temp_hhid;
  string20	lname;
end;

temprec into_temp(outf L, df2 R) := transform
  self.best_fname := if (append_bests, L.best_fname, '');
  self.best_mname := if (append_bests, L.best_mname, '');
  self.best_lname := if (append_bests, L.best_lname, '');
  self.best_name_suffix := if (append_bests, L.best_name_suffix, '');
  self.best_addr1 := if (append_bests, L.best_addr1, '');
  self.best_city  := if (append_bests, L.best_city, '');
  self.best_st	 := if (append_bests, L.best_state, '');
  self.best_zip   := if (append_bests and L.best_zip<>'' and L.best_zip4<>'', L.best_zip + '-' + L.best_zip4, '');
  self.best_addr_date := if (append_bests, (string)L.best_addr_date, '');
  self.hhid := intformat(L.hhid, 12, 1);
  self.adl := intformat(L.did, 12, 1);
  self.best_name_score := intformat(L.verify_best_name, 3, 1);
  self.best_addr_score := intformat(L.verify_best_address, 3, 1);
  self.best_phone_score := intformat(L.verify_best_phone, 3, 1);
  self.header_count := intformat(L.head_cnt, 4, 1);
  self.best_phone := '';
  self := L;
  self := R;
  self := [];
end;

outf2 := join(outf,
      df2,
        left.seq = right.seq,
      into_temp(LEFT,RIGHT));

relrec := record
  unsigned4	seq;
  unsigned6	did;
  unsigned2	number_cohabits;
  integer3	recent_cohabit;
  string20	Rel_BestFname;
  string20	Rel_BestMname;
  string20	Rel_BestLname;
  string5	Rel_BestSuffix;
  string100	Rel_BestAddr1;
  string30	Rel_BestCity;
  string2	Rel_BestSt;
  string10	Rel_BestZip;
end;

relrec into_rel(outf2 L, Relationship.layout_GetRelationship.interfaceOutputNeutral R) := transform
  self.seq := l.seq;
  self.did := R.did2;
  self.recent_cohabit := R.rel_dt_last_seen /100;
  self.number_cohabits := MAX(r.total_score/5, 6);
  self := [];
end;

rdid_ds := project(outf2,transform(Relationship.Layout_GetRelationship.DIDs_layout,self.did:=(integer)left.adl,SELF := []));
rel_recs := Relationship.proc_GetRelationshipNeutral(rdid_ds,TRUE,TRUE,FALSE,FALSE,ut.limits.RELATIVES_PER_PERSON,,TRUE).result;

myrels1 := join(outf2, rel_recs,
            (integer)left.adl = right.did1,
            into_rel(LEFT,RIGHT));

doxie.mac_best_records(myrels1,
                       did,
                       outfile,
                       mod_access.isValidDPPA(),
                       mod_access.isValidGLB(),
                       ,
                       doxie.DataRestriction.fixed_DRM);

relrec rel_best(myrels1 L, outfile R) := transform
  self.Rel_bestfname := R.fname;
  self.Rel_bestmname := R.mname;
  self.Rel_bestlname := R.lname;
  self.Rel_bestsuffix := R.name_suffix;
  self.Rel_bestaddr1 := address.Addr1FromComponents(R.prim_Range, R.predir, R.prim_Name, R.suffix, R.postdir, R.unit_desig, R.sec_range);
  self.Rel_BestCity := R.city_name;
  self.Rel_BestSt := R.st;
  self.Rel_BestZip := R.zip + '-' + R.zip4;
  self := l;
end;

myrels2 := join(myrels1, outfile,
        left.did = right.did,
       rel_best(LEFT,RIGHT));

myrels_use := if (append_bests, myrels2, myrels1);

temprec denorm_out(outf2 L, myrels_use R, integer C) := transform
  self.Rel_ADL1 		:= if (C = 1, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL1);
  self.Rel_BestFname1 := if (C = 1, R.Rel_BestFname, L.Rel_BestFname1);
  self.Rel_BestMname1 := if (C = 1, R.Rel_BestMname, L.Rel_BestMname1);
  self.Rel_bestLname1 := if (C = 1, R.Rel_BestLname, L.Rel_BestLname1);
  self.Rel_BestSuffix1 := if (C = 1, R.Rel_BestSuffix, L.reL_bestSuffix1);
  self.Rel_BestAddr1  := if (C = 1, R.Rel_BestAddr1, L.Rel_BestAddr1);
  self.Rel_BestCity1 	:= if (C = 1, R.Rel_BestCity, L.Rel_BestCity1);
  self.Rel_BestSt1	:= if (C = 1, R.Rel_BestSt, L.Rel_BestSt1);
  self.Rel_BestZip1	:= if (C = 1, R.Rel_BestZip, L.Rel_BestZip1);
  self.Rel_ADL2 		:= if (C = 2, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL2);
  self.Rel_BestFname2 := if (C = 2, R.Rel_BestFname, L.Rel_BestFname2);
  self.Rel_BestMname2 := if (C = 2, R.Rel_BestMname, L.Rel_BestMname2);
  self.Rel_bestLname2 := if (C = 2, R.Rel_BestLname, L.Rel_BestLname2);
  self.Rel_BestSuffix2 := if (C = 2, R.Rel_BestSuffix, L.reL_bestSuffix2);
  self.Rel_BestAddr2 := if (C = 2, R.Rel_BestAddr1, L.Rel_BestAddr2);
  self.Rel_BestCity2 	:= if (C = 2, R.Rel_BestCity, L.Rel_BestCity2);
  self.Rel_BestSt2	:= if (C = 2, R.Rel_BestSt, L.Rel_BestSt2);
  self.Rel_BestZip2	:= if (C = 2, R.Rel_BestZip, L.Rel_BestZip2);
  self.Rel_ADL3 		:= if (C = 3, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL3);
  self.Rel_BestFname3 := if (C = 3, R.Rel_BestFname, L.Rel_BestFname3);
  self.Rel_BestMname3 := if (C = 3, R.Rel_BestMname, L.Rel_BestMname3);
  self.Rel_bestLname3 := if (C = 3, R.Rel_BestLname, L.Rel_BestLname3);
  self.Rel_BestSuffix3 := if (C = 3, R.Rel_BestSuffix, L.reL_bestSuffix3);
  self.Rel_BestAddr3 := if (C = 3, R.Rel_BestAddr1, L.Rel_BestAddr3);
  self.Rel_BestCity3 	:= if (C = 3, R.Rel_BestCity, L.Rel_BestCity3);
  self.Rel_BestSt3	:= if (C = 3, R.Rel_BestSt, L.Rel_BestSt3);
  self.Rel_BestZip3	:= if (C = 3, R.Rel_BestZip, L.Rel_BestZip3);
  self.Rel_ADL4 		:= if (C = 4, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL4);
  self.Rel_BestFname4 := if (C = 4, R.Rel_BestFname, L.Rel_BestFname4);
  self.Rel_BestMname4 := if (C = 4, R.Rel_BestMname, L.Rel_BestMname4);
  self.Rel_bestLname4 := if (C = 4, R.Rel_BestLname, L.Rel_BestLname4);
  self.Rel_BestSuffix4 := if (C = 4, R.Rel_BestSuffix, L.reL_bestSuffix4);
  self.Rel_BestAddr4 := if (C = 4, R.Rel_BestAddr1, L.Rel_BestAddr4);
  self.Rel_BestCity4 	:= if (C = 4, R.Rel_BestCity, L.Rel_BestCity4);
  self.Rel_BestSt4	:= if (C = 4, R.Rel_BestSt, L.Rel_BestSt4);
  self.Rel_BestZip4	:= if (C = 4, R.Rel_BestZip, L.Rel_BestZip4);
  self.Rel_ADL5 		:= if (C = 5, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL5);
  self.Rel_BestFname5 := if (C = 5, R.Rel_BestFname, L.Rel_BestFname5);
  self.Rel_BestMname5 := if (C = 5, R.Rel_BestMname, L.Rel_BestMname5);
  self.Rel_bestLname5 := if (C = 5, R.Rel_BestLname, L.Rel_BestLname5);
  self.Rel_BestSuffix5 := if (C = 5, R.Rel_BestSuffix, L.reL_bestSuffix5);
  self.Rel_BestAddr5 := if (C = 5, R.Rel_BestAddr1, L.Rel_BestAddr5);
  self.Rel_BestCity5 	:= if (C = 5, R.Rel_BestCity, L.Rel_BestCity5);
  self.Rel_BestSt5	:= if (C = 5, R.Rel_BestSt, L.Rel_BestSt5);
  self.Rel_BestZip5	:= if (C = 5, R.Rel_BestZip, L.Rel_BestZip5);
  self.Rel_ADL6 		:= if (C = 6, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL6);
  self.Rel_BestFname6 := if (C = 6, R.Rel_BestFname, L.Rel_BestFname6);
  self.Rel_BestMname6 := if (C = 6, R.Rel_BestMname, L.Rel_BestMname6);
  self.Rel_bestLname6 := if (C = 6, R.Rel_BestLname, L.Rel_BestLname6);
  self.Rel_BestSuffix6 := if (C = 6, R.Rel_BestSuffix, L.reL_bestSuffix6);
  self.Rel_BestAddr6 := if (C = 6, R.Rel_BestAddr1, L.Rel_BestAddr6);
  self.Rel_BestCity6 	:= if (C = 6, R.Rel_BestCity, L.Rel_BestCity6);
  self.Rel_BestSt6	:= if (C = 6, R.Rel_BestSt, L.Rel_BestSt6);
  self.Rel_BestZip6	:= if (C = 6, R.Rel_BestZip, L.Rel_BestZip6);
  self.Rel_ADL7 		:= if (C = 7, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL7);
  self.Rel_BestFname7 := if (C = 7, R.Rel_BestFname, L.Rel_BestFname7);
  self.Rel_BestMname7 := if (C = 7, R.Rel_BestMname, L.Rel_BestMname7);
  self.Rel_bestLname7 := if (C = 7, R.Rel_BestLname, L.Rel_BestLname7);
  self.Rel_BestSuffix7 := if (C = 7, R.Rel_BestSuffix, L.reL_bestSuffix7);
  self.Rel_BestAddr7 := if (C = 7, R.Rel_BestAddr1, L.Rel_BestAddr7);
  self.Rel_BestCity7 	:= if (C = 7, R.Rel_BestCity, L.Rel_BestCity7);
  self.Rel_BestSt7	:= if (C = 7, R.Rel_BestSt, L.Rel_BestSt7);
  self.Rel_BestZip7	:= if (C = 7, R.Rel_BestZip, L.Rel_BestZip7);
  self.Rel_ADL8 		:= if (C = 8, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL8);
  self.Rel_BestFname8 := if (C = 8, R.Rel_BestFname, L.Rel_BestFname8);
  self.Rel_BestMname8 := if (C = 8, R.Rel_BestMname, L.Rel_BestMname8);
  self.Rel_bestLname8 := if (C = 8, R.Rel_BestLname, L.Rel_BestLname8);
  self.Rel_BestSuffix8 := if (C = 8, R.Rel_BestSuffix, L.reL_bestSuffix8);
  self.Rel_BestAddr8 := if (C = 8, R.Rel_BestAddr1, L.Rel_BestAddr8);
  self.Rel_BestCity8	:= if (C = 8, R.Rel_BestCity, L.Rel_BestCity8);
  self.Rel_BestSt8	:= if (C = 8, R.Rel_BestSt, L.Rel_BestSt8);
  self.Rel_BestZip8	:= if (C = 8, R.Rel_BestZip, L.Rel_BestZip8);
  self.Rel_ADL9 		:= if (C = 9, if (R.did = 0, '', intformat(R.did, 12, 1)), L.Rel_ADL9);
  self.Rel_BestFname9 := if (C = 9, R.Rel_BestFname, L.Rel_BestFname9);
  self.Rel_BestMname9 := if (C = 9, R.Rel_BestMname, L.Rel_BestMname9);
  self.Rel_bestLname9 := if (C = 9, R.Rel_BestLname, L.Rel_BestLname9);
  self.Rel_BestSuffix9 := if (C = 9, R.Rel_BestSuffix, L.reL_bestSuffix9);
  self.Rel_BestAddr9 := if (C = 9, R.Rel_BestAddr1, L.Rel_BestAddr9);
  self.Rel_BestCity9 	:= if (C = 9, R.Rel_BestCity, L.Rel_BestCity9);
  self.Rel_BestSt9	:= if (C = 9, R.Rel_BestSt, L.Rel_BestSt9);
  self.Rel_BestZip9	:= if (C = 9, R.Rel_BestZip, L.Rel_BestZip9);
  self := l;
end;

outf3 := denormalize(outf2, sort(myrels_use, seq, -number_cohabits, -recent_cohabit),
            left.seq = right.seq,
            denorm_out(LEFT,RIGHT,COUNTER));

Key_History_did := dx_gong.key_history_did();
temprec get_gong_dates(temprec L, Key_History_did R) := transform
  self.EDA_Disconnect := if ((integer)L.eda_disconnect > (integer)R.deletion_date, L.eda_disconnect, R.deletion_date);
  self.EDA_Connect := if (((integer)L.eda_connect != 0 and (integer)L.eda_connect < (integer)R.dt_first_seen) or (integer)R.dt_first_seen = 0, L.eda_connect, R.dt_first_seen);
  self := L;
end;

Key_History_HHID := dx_gong.key_history_hhid();
temprec get_gong_dates2(temprec L, Key_History_HHID R) := transform
  self.EDA_Disconnect := if ((integer)L.eda_disconnect > (integer)R.deletion_date, L.eda_disconnect, R.deletion_date);
  self.EDA_Connect := if (((integer)L.eda_connect != 0 and (integer)L.eda_connect < (integer)R.dt_first_seen) or (integer)R.dt_first_seen = 0, L.eda_connect, R.dt_first_seen);
  self := L;
end;

// Since key data is taken conditionally, we must instead suppress the keys themselves.
D_filtered := join(outf3((integer)adl != 0), Key_History_did,
  keyed((integer)left.adl = right.l_did), transform(right));
D_optout := Suppress.MAC_SuppressSource(D_filtered, mod_access);

H_filtered := join(outf3((integer)hhid != 0), Key_History_HHID,
  keyed((integer)left.hhid = right.s_hhid), transform(right));
H_optout := Suppress.MAC_SuppressSource(H_filtered, mod_access);

outf4a := join(outf3, D_optout,
  (integer)left.adl = right.l_did, get_gong_dates(left, right),
  left outer);

outf4 := join(outf4a, H_optout,
  (integer)left.hhid = right.s_hhid, get_gong_dates2(left, right),
  left outer);

outf4 roll_dates(outf4 L, outf4 R) := transform
  self.EDA_Disconnect := if ((integer)L.EDA_Disconnect > (integer)R.EDA_Disconnect, L.EDA_Disconnect, R.EDA_Disconnect);
  self.EDA_Connect := If (((integer)L.eda_connect != 0 and (integer)L.eda_connect < (integer)R.eda_connect) or (integer)R.eda_connect = 0, L.eda_connect, R.eda_connect);
  self := L;
end;

outf5 := group(rollup(group(sort(outf4,seq),seq), true, roll_dates(LEFT,RIGHT)));

outrec into_outfinal(outf5 L) := transform
  self := L;
end;

outfinal := project(outf5,into_outfinal(LEFT));

return outfinal;

end;
