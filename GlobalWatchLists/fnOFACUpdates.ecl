EXPORT fnOFACUpdates(string filedate) := function

dnew := GlobalWatchLists.File_GlobalWatchLists;

dprev := dataset('~thor_data400::base::globalwatchlists_father',GlobalWatchLists.Layout_GlobalWatchLists,flat);

//Get the current updates to OFAC

joinrec := record
 STRING20 pty_key;
	STRING60 source;
	STRING350 orig_pty_name;
	STRING350 orig_vessel_name;
	STRING100 country;
  STRING10  name_type;
	STRING50 addr_1;
	STRING50 addr_2;
	STRING50 addr_3;
	STRING350 cname;
	  STRING10 date_updated;
		STRING1 add_delflag;
end;

joinrec map2add( dnew l ,dprev r) := transform
self.date_updated := filedate[1..8];
self.add_delflag := 'A';
self := l;
end;



dUpdates := Join ( distribute(dnew,hash(pty_key,source)),
                   distribute(dprev,hash(pty_key,source)),
									 left.pty_key=right.pty_key and
									 left.source=right.source,
									 map2add(left,right),
									 left only,
									 local);
									 
joinrec map2del( dnew l ,dprev r) := transform
self.date_updated := filedate[1..8];
self.add_delflag := 'D';
self := r;
end;
									 
									 
dremove := Join ( distribute(dnew,hash(pty_key,source)),
                   distribute(dprev,hash(pty_key,source)),
									 left.pty_key=right.pty_key and
									 left.source=right.source,
									 map2del(left,right),
									 right only,
									 local);
									 
dboth := dUpdates + dremove  ;
									 
outall := Sequential(  output(dboth,,'~thor_200::in::globalwatchlists_updates_'+filedate,overwrite),
                       FileServices.StartSuperFileTransaction(),
											 FileServices.AddSuperfile( '~thor_200::in::globalwatchlists_updates','~thor_200::in::globalwatchlists_updates_'+filedate),
											 FileServices.FinishSuperfileTransaction()
											);
											
return outall;
end;
									 



