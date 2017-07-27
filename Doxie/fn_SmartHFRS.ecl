import doxie, lib_word, SmartRollup,  ut, AutoStandardI;
inLayout := doxie.Layout_Rollup.KeyRec_feedback;
export fn_SmartHFRS(dataset(inLayout) inRecs) := FUNCTION
 //make a single set of names for all DIDs
 nameLayout := record(doxie.Layout_Rollup.nameRec)
   string did;
 end;
 nameLayout makeName(inRecs l, doxie.Layout_Rollup.nameRec r) := transform
    self.did := l.did;
		self := r;
 end;
  names2dedup := normalize(inRecs, left.nameRecs, makeName(left,right));
 //make a single set of addrs for all DIDs
 addrLayout := record(doxie.Layout_Rollup.AddrRec_feedback)
   string did;
	 string pcity;
 end;
 addrLayout makeAddr(inRecs l, doxie.Layout_Rollup.addrRec_feedback r) := transform
    self.did := l.did;
		self.pcity := '';
		self := r;
 end;
 addrs2dedup := normalize(inRecs, left.addrRecs, makeAddr(left,right));
 
 SmartRollup.MAC_suppress_name_dups(names2dedup, nameRecs);
 //dedup the addrs per DID
 //get input city
 inputCity := AutoStandardI.InterfaceTranslator.city_value.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.city_value.params));	
 SmartRollup.MAC_suppress_ADDR_dups_noLoc(addrs2dedup, addrRecsPlus,,,,,,,,,,first_seen, last_seen,inputCity);
 addrRecs := project(AddrRecsPlus,recordof(addrs2Dedup));
 				 
 //join them back into the result to return.
 inLayout loadNames(inRecs l, dataset(nameLayout) r) := transform
   self.nameRecs := choosen(r, rollup_limits.names);
   self := l;
 end;
 inLayout loadAddrs(inRecs l, dataset(addrLayout) r) := transform
   self.addrRecs := choosen(r, rollup_limits.addresses);
   self := l;
 end;
 gNameRecs := group(sort(nameRecs,did),did);
 gAddrRecs := group(sort(addrRecs,did),did);

 outRecsName  := DENORMALIZE(inRecs, gNameRecs, LEFT.did = RIGHT.did, group, loadNames(LEFT, ROWS(RIGHT)));
 outRecs := DENORMALIZE(outRecsName, gAddrRecs, LEFT.did = RIGHT.did, group, loadAddrs(LEFT, ROWS(RIGHT)));

 RETURN outRecs;
END;
