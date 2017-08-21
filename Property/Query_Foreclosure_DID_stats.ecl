import property,lib_keylib,lib_fileservices,ut,_Control;

// Dataset ****************************************************************************************

string_rec := record
	property.Layout_Fares_Foreclosure;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

FC := DATASET('~thor_data400::base::foreclosure', string_rec, thor);

// DID Record set *********************************************************************************

did_rec := record
	FC.name1_did;
	FC.name2_did;
	FC.name3_did;
	FC.name4_did;
	FC.situs1_st;
	FC.situs2_st;
	string12 name_did := '';
	string2 st := ' ';
END;

DIDtable := table(FC,did_rec);

did_rec FC_st(DIDtable s,unsigned1 st_count) := TRANSFORM
	self.st := choose(st_count,s.situs1_st,s.situs2_st);
	self := s;
END;

st_records := NORMALIZE(DIDtable,2,FC_st(left,counter));
//st_duped := dedup(st_records(st <> ''),st,name_did,ALL);

did_rec FC_did(DIDtable d, unsigned1 did_count) := TRANSFORM
		self.name_did := choose(did_count,d.name1_did,d.name2_did,d.name3_did,d.name4_did);
		self := d;
END;

did_records := NORMALIZE(st_records,4,FC_did(left,counter));
//did_duped := DEDUP(did_records(name_did <> ''),name_did,ALL);



stat_rec := RECORD
	did_records.st;
	reccnt := count(group)
END;

stat_table_did := table(did_records((integer)name_did > 0),stat_rec,st,FEW);
stat_table := table(did_records,stat_rec,st,FEW);

count_rec := record
	string2 str_st := '';
	string2 str_tab := '\t\t';
	string8 str_count := '';
	string2 str_tab1 := '\t\t';
	string8 str_did_count := '';
	string2 str_tab2 := '\t\t';
	string8 str_perc := '';
	string1 ln_feed := '\n';
END;

count_rec GetCounts(stat_rec L, stat_rec R) := TRANSFORM
	SELF.str_st	:= L.st;
	SELF.str_did_count := (string8)L.reccnt;
	SELF.str_count := (string8)R.reccnt;
	SELF.str_perc := (string8)((decimal4_2)((L.reccnt*100)/R.reccnt));
END;

my_did_stats := JOIN(stat_table_did,stat_table, LEFT.st = RIGHT.st, GetCounts(LEFT, RIGHT));

stat_out := output(my_did_stats(str_st <> ''),,'out::foreclosure_did_stats',overwrite);

file_despray := lib_fileservices.fileservices.Despray('~thor400_92::out::foreclosure_did_stats', _Control.IPAddress.edata12,
 									'/thor_back5/fares/foreclosure/build/foreclosure_stats',,,,TRUE);

export Query_Foreclosure_DID_Stats := sequential(stat_out,file_despray);

//sequential(stat_out,file_despray);
