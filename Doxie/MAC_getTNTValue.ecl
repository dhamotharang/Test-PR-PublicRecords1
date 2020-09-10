
/* TNT Verification levels
 Details available here Phones.Constants.TNT
*/

EXPORT MAC_getTNTValue(infile,
							best_infile, //preferably from mac_best_records to obtain best address
							outfile,
							mod_access, //Doxie.IDataAccess expected
							didfield='did',
							hhidfield='hhid',
							tntfield='tnt',
							zipfield='zip',
							primnamefield='prim_name',
							primrangefield='prim_range',
							secrangefield='sec_range',
							statefield='st',
							dtlastseenfield = 'dt_last_seen'
							) := macro

		import dx_Gong, ut, DID_Add, Suppress, std, Phones;

		//1. Check best records to determine if best address
		#uniquename(trans_best)
		#uniquename(results_best)
		infile %trans_best%(infile l,best_infile r) := transform
			self.tntfield := if(DID_Add.Address_Match_Score(L.primrangefield, L.primnamefield, L.secrangefield, L.zipfield,
													R.prim_range, R.prim_name, R.sec_range, R.zip) BETWEEN 76 AND 254
													AND l.primrangefield=r.prim_range, Phones.Constants.TNT.Current, //Current - is best address but not validated by the gong file
													Phones.Constants.TNT.History);
			self := l;
		end;

		%results_best%:= join(infile,best_infile,(integer)left.didfield = right.did,%trans_best%(left,right),
												left outer,keep(1),limit(0));

		//2. Check for DID match to the Gong file
		#uniquename(layout_gong_out)
		%layout_gong_out% :=
		RECORD
			dx_Gong.layout_prepped_for_keys;
			string15 did;
			unsigned6 hhid;
			unsigned6 bdid := 0;
			unsigned4 global_sid := 0;
			unsigned8 record_sid := 0;
		END;

		//use the most current gong did records
		#uniquename(key_did)
		%key_did% := dx_Gong.key_did();
		#uniquename(get_did_base)
		#uniquename(did_base_recs)
		#uniquename(did_base_recs_suppressed)
		#uniquename(final_did)
		%layout_gong_out% %get_did_base%(infile le, %key_did% ri) := transform
			self.did := le.didfield;
			self := ri;
			self := [];
		end;

		%did_base_recs% := join(%results_best%, %key_did%,
														keyed((integer)left.didfield = right.l_did),%get_did_base%(left,right), ATMOST(50));

		%did_base_recs_suppressed% := Suppress.MAC_SuppressSource(%did_base_recs%, mod_access);

		%final_did% := dedup(sort(%did_base_recs_suppressed%,bdid,did,listed_name,phone10),
											 bdid,did,listed_name,phone10);

		#uniquename(checkgDID)
		#uniquename(results_best_tnt)
		infile %checkgDID%(%results_best% le, %final_did% ri) := transform
			self.tntfield := map(ri.did != '' AND le.tntfield = Phones.Constants.TNT.Current => Phones.Constants.TNT.Bullseye, //Bullseye - is currently the 'best' address and is a DID match to the gong file
						 le.tntfield = Phones.Constants.TNT.Current => Phones.Constants.TNT.Current,
						 ri.did != '' AND ut.DaysApart(le.dtlastseenfield+'00', (STRING8)Std.Date.Today()) < 31*6 => Phones.Constants.TNT.Probable, //Probable - is not currently the best address, but is did verified with a dtlastseenfield within 6 months
						 le.tntfield);
			SELF := le;
		END;

		%results_best_tnt% := JOIN(%results_best%, %final_did%,
							 (string)LEFT.didfield = RIGHT.did AND
							 ((DID_Add.Address_Match_Score(LEFT.primrangefield, LEFT.primnamefield, LEFT.secrangefield, LEFT.zipfield,
												RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range, RIGHT.z5) BETWEEN 76 AND 254 AND
							 LEFT.primrangefield=RIGHT.prim_range) OR
							 (RIGHT.prim_name='' AND RIGHT.prim_range='' AND LEFT.zipfield=RIGHT.z5 AND
								(LEFT.tntfield= Phones.Constants.TNT.Current OR
								(ut.DaysApart(LEFT.dtlastseenfield+'00', (STRING8)Std.Date.Today()) < ut.DaysInNYears(1))))),
												%checkgDID%(LEFT, RIGHT), LEFT OUTER, MANY LOOKUP, PARALLEL);

		//3. Check for HHID match to the Gong file
		//use the most current gong hhid records
		#uniquename(key_hhid)
		%key_hhid% := dx_Gong.key_hhid();
		#uniquename(get_hhid_base)
		#uniquename(hhid_base_recs)
		#uniquename(final_hhid)
		%layout_gong_out% %get_hhid_base%(%results_best_tnt% le, %key_hhid% ri) := transform
			self.did := (string) ri.did;          
			self := ri;
			self := [];
		end;

		%hhid_base_recs% := join(%results_best_tnt%, %key_hhid%,
														 (integer)left.hhidfield = right.s_hhid,%get_hhid_base%(LEFT, RIGHT), ATMOST(50));
														 
		%final_hhid% := suppress.MAC_SuppressSource(dedup(sort(%hhid_base_recs%,bdid,did,listed_name,phone10)
										 ,bdid,did,listed_name,phone10),mod_access);

		#uniquename(checkgHHID)
		infile %checkgHHID%(%results_best_tnt% le, %final_hhid% ri) := transform
			self.tntfield := MAP(le.tntfield = Phones.Constants.TNT.Bullseye => Phones.Constants.TNT.Bullseye,
						 ri.hhid != 0 AND le.tntfield = Phones.Constants.TNT.Current => Phones.Constants.TNT.Verified, //Verified - is currently the best address and is a HHID match to the gong file
						 le.tntfield = Phones.Constants.TNT.Current => Phones.Constants.TNT.Current,
						 ri.hhid != 0 AND ut.DaysApart(le.dtlastseenfield+'00', (STRING8)Std.Date.Today()) < 31*6 => Phones.Constants.TNT.Probable, //Probable - is not currently the best address, but is hhid verified with a dtlastseenfield within 6 months
						 le.tntfield = Phones.Constants.TNT.Probable => Phones.Constants.TNT.Probable,
						 ri.hhid != 0 => Phones.Constants.TNT.Relative, //Relative - is not currently the best address, and has a dtlastseenfield > 6 months but is HHID verified
						 le.tntfield);
			self := le;
		END;

		outfile := JOIN(%results_best_tnt%(hhidfield != 0), %final_hhid%,
								(integer)left.hhidfield = right.hhid and
						 DID_Add.Address_Match_Score(LEFT.primrangefield, LEFT.primnamefield, LEFT.secrangefield, LEFT.zipfield,
												RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range, RIGHT.z5) BETWEEN 76 AND 254
												AND LEFT.primrangefield=RIGHT.prim_range,
						 %checkgHHID%(LEFT, RIGHT), left outer, MANY LOOKUP, PARALLEL) + %results_best_tnt%(hhidfield = 0);

endmacro;
