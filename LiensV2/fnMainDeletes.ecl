IMPORT LiensV2;

EXPORT fnMainDeletes(DATASET(LiensV2.Layout_liens_main_module_for_hogan.layout_liens_main) dMain, DATASET(liensv2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags) dParty) := FUNCTION
		main_tbl := table(dMain  ,{tmsid, rmsid, orig_rmsid}, tmsid, rmsid, orig_rmsid,few);		//DF-29287 distribute not needed												
		party_tbl:= table(dParty ,{tmsid, rmsid, orig_rmsid}, tmsid, rmsid, orig_rmsid,few);	  //DF-29287 distribute not needed
		fdeletes := table(liensV2.mapping_hogan(ADDDELFLAG IN ['D','C']),{orig_rmsid},orig_rmsid,few); //VC DF-29287 Updates need to be processed as Del+add

		main_del := join(main_tbl(orig_rmsid <> ''),fdeletes, //DF-29287 distribute not needed
															left.orig_rmsid = right.orig_rmsid,
															transform({recordof(main_tbl), string10 orig_rmsid_main_del}, self.orig_rmsid_main_del := right.orig_rmsid, self := left),
															left outer,
															lookup);


		party_del := join(party_tbl(orig_rmsid <> ''),fdeletes,//DF-29287 distribute not needed
															left.orig_rmsid = right.orig_rmsid,
															transform({recordof(party_tbl), string10 orig_rmsid_party_del}, self.orig_rmsid_party_del := right.orig_rmsid, self := left),
															left outer,
															lookup);
									
		main_del_only := join(distribute(main_del, hash(tmsid)), 
											dedup(sort(distribute(main_del(orig_rmsid_main_del <>''), hash(tmsid)), tmsid, rmsid, local), tmsid, rmsid, local),
											left.tmsid = right.tmsid and
											left.rmsid = right.rmsid,
											local);

		party_del_only := join(distribute(party_del, hash(tmsid)), 
											dedup(sort(distribute(party_del(orig_rmsid_party_del <>''), hash(tmsid)), tmsid, rmsid,local), tmsid, rmsid, local),
											left.tmsid = right.tmsid and
											left.rmsid = right.rmsid,
											local);
																													

		tbl_ly := record
			main_del_only.tmsid;
			main_del_only.rmsid;
			string10 orig_rmsid_main;
			main_del_only.orig_rmsid_main_del;
			string10 orig_rmsid_party;
			party_del_only.orig_rmsid_party_del;
		end;

		both_del := join(main_del_only, party_del_only, 
										left.tmsid = right.tmsid and left.rmsid = right.rmsid and left.orig_rmsid = right.orig_rmsid,
										transform(tbl_ly, 
														self.tmsid := if(left.tmsid = '', right.tmsid, left.tmsid),
														self.rmsid := if(left.rmsid = '', right.rmsid, left.rmsid),
														self.orig_rmsid_main := left.orig_rmsid,
														self.orig_rmsid_party := right.orig_rmsid,
														self:= left,
														self := right
														),
										full outer);																												

		both_del_tbl := table(both_del, {tmsid, rmsid, 
																			main_cnt := count(group, orig_rmsid_main <> ''),
																			party_cnt := count(group, orig_rmsid_party <> ''), 
																			main_del_cnt := count(group, orig_rmsid_main_del <> ''), 
																			party_del_cnt := count(group, orig_rmsid_party_del <> '')}, 
													tmsid, rmsid);
																							 

		delete := 	join(both_del, both_del_tbl (main_del_cnt = main_del_cnt and party_cnt = party_del_cnt) ,
										left.tmsid = right.tmsid and
										left.rmsid = right.rmsid
										);
	RETURN DELETE;
END;