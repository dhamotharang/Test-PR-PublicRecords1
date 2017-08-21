import STD;
new0 := UniqueId.Files.new;
prev := UniqueId.Files.father;			
newseed := MAX(prev, UniqueId.GetMaxLNid(Entity_Unique_id));
new2 := PROJECT(new0,UniqueId.xAssignPrimaryKey(LEFT,COUNTER,newseed));
new2a := UniqueId.fn_ToFlat(new2);
new2b := DEDUP(new2a, RECORD, EXCEPT primarykey, id,entity_added_by,ALL);

new := new2b(Entity_Unique_Id='');	//  : PERSIST('~thor::persist::uniqueid::new');

n_noid := COUNT(new);
withid := new2b(Entity_Unique_Id<>'');
n_withid := COUNT(withid);

ToUpper(unicode s) := Std.Uni.ToUpperCase(s);

common := JOIN(new,prev,
							LEFT.WatchListName=RIGHT.WatchListName AND LEFT.WatchListType=RIGHT.WatchListType
							AND LEFT.type=RIGHT.type AND LEFT.full_name=RIGHT.full_name
							AND LEFT.First_Name=RIGHT.First_Name AND LEFT.Middle_Name=RIGHT.Middle_Name AND LEFT.Last_Name=RIGHT.Last_Name
							AND LEFT.title=RIGHT.title AND LEFT.generation=RIGHT.generation
							AND LEFT.listed_date=RIGHT.listed_date 	//AND LEFT.entity_added_by=RIGHT.entity_added_by 
							AND LEFT.reason_listed=RIGHT.reason_listed AND LEFT.reference_id=RIGHT.reference_id
							AND LEFT.akas=RIGHT.akas
							AND LEFT.addresses=RIGHT.addresses
							AND LEFT.infos=RIGHT.infos
							AND LEFT.ids=RIGHT.ids
							AND LEFT.phones=RIGHT.phones
							AND LEFT.comments=RIGHT.comments,
							TRANSFORM(UniqueId.Layout_Flat,
									SELF.Entity_Unique_ID := RIGHT.Entity_Unique_ID;
									SELF := LEFT;),
							INNER);
n_common := COUNT(common);
unmatched := JOIN(new,common,
							LEFT.primarykey=RIGHT.primarykey, 
							LEFT ONLY);

// find all in previous that have not been matched
available := JOIN(prev,new,
							LEFT.WatchListName=RIGHT.WatchListName AND LEFT.WatchListType=RIGHT.WatchListType
							AND LEFT.type=RIGHT.type AND LEFT.full_name=RIGHT.full_name
							AND LEFT.First_Name=RIGHT.First_Name AND LEFT.Middle_Name=RIGHT.Middle_Name AND LEFT.Last_Name=RIGHT.Last_Name
							AND LEFT.title=RIGHT.title AND LEFT.generation=RIGHT.generation
							AND LEFT.listed_date=RIGHT.listed_date	// AND LEFT.entity_added_by=RIGHT.entity_added_by 
							AND LEFT.reason_listed=RIGHT.reason_listed AND LEFT.reference_id=RIGHT.reference_id
							AND LEFT.akas=RIGHT.akas
							AND LEFT.addresses=RIGHT.addresses
							AND LEFT.infos=RIGHT.infos
							AND LEFT.ids=RIGHT.ids
							AND LEFT.phones=RIGHT.phones
							AND LEFT.comments=RIGHT.comments,
							LEFT ONLY);	// : PERSIST('~thor::persist::uniqueid::available');

scored1 := JOIN(available, unmatched,
							LEFT.WatchListName=RIGHT.WatchListName //AND LEFT.WatchListType=RIGHT.WatchListType
							AND LEFT.type=RIGHT.type
							AND AreNamesCompatible(LEFT.full_name, RIGHT.full_name)
							AND LEFT.reason_listed=RIGHT.reason_listed AND LEFT.reference_id=RIGHT.reference_id,
							UniqueId.x_score(LEFT, RIGHT), INNER);
scored2 := DEDUP(SORT(scored1(score>0), newkey, -score),newkey);			// these are likely matches
scored := DEDUP(SORT(scored2, Entity_Unique_id, -score),Entity_Unique_id);	// avoid overmatching

overscored := TABLE(scored, {scored.newkey, cnt := COUNT(GROUP)}, newkey)(cnt > 1);



newscore := JOIN(unmatched, scored, LEFT.primarykey = RIGHT.newkey,
										TRANSFORM(UniqueId.Layout_Flat,
													SELF.Entity_Unique_ID := RIGHT.Entity_Unique_ID;
													self := LEFT;), INNER);

overqualified1 := JOIN(newscore, overscored, LEFT.primarykey=RIGHT.newkey, INNER);
overqualified := JOIN(overqualified1, scored, LEFT.primarykey=RIGHT.newkey, INNER);
overqualified2 := JOIN(prev, overqualified, LEFT.Entity_Unique_id=RIGHT.Entity_Unique_id, INNER);


prevscore := JOIN(available, scored, LEFT.primarykey = RIGHT.prevkey,
										TRANSFORM(UniqueId.Layout_Flat,
													self := LEFT;), INNER);


UniqueId.Layout_Flat xAssignNewId(UniqueId.Layout_Flat newrecords, integer n, integer seed) := TRANSFORM
		SELF.Entity_Unique_ID := 'LN' + IntFormat(n + seed,10,1);
		self := newrecords;
END;
newrecordsx := JOIN(unmatched, scored, LEFT.primarykey=RIGHT.newkey, 
										TRANSFORM(UniqueId.Layout_Flat,
													self := LEFT;),
													LEFT ONLY);
newrecords := PROJECT(newrecordsx,xAssignNewId(LEFT, COUNTER, newseed));

allrecords := common & newscore & newrecords;

tablists := TABLE(allrecords, {allrecords.WatchListName, cnt := COUNT(GROUP)}, WatchListName);
totalrecords := allrecords&withid;
tabtotal := TABLE(totalrecords, {totalrecords.WatchListName, totalrecords.WatchListDate, cnt := COUNT(GROUP)}, WatchListName,WatchListDate);

reconstruct := JOIN(new2, totalrecords, LEFT.primarykey = RIGHT.primarykey,
						TRANSFORM(UniqueId.Layout_Watchlist.rWatchList,
									SELF.Entity_Unique_ID := RIGHT.Entity_Unique_ID;
									SELF := LEFT;), INNER);
rectotal := TABLE(reconstruct, {reconstruct.WatchListName, reconstruct.WatchListDate, cnt := COUNT(GROUP)}, WatchListName,WatchListDate);

removed := JOIN(totalrecords, prev, left.entity_unique_id=right.entity_unique_id, RIGHT ONLY);

hdr := '<?xml version="1.0" encoding="utf-8"?>\r\n' +
				'<WatchList_List>\r\n';
ftr := '</WatchList_List>';
rStat := RECORD
	string		parameter;
	integer		count;
END;
dsCounts := DATASET([
	{'Previous Record Count', COUNT(prev)},
	{'Total Record Count', COUNT(new0)},
	{'Unique Record Count', COUNT(new2b)},
	{'Records with ID Count', COUNT(withid)},
	{'Records without ID Count', COUNT(new)},
	{'Exact Match Count', COUNT(common)},
	{'Unmatched Count', COUNT(unmatched)},
//	{'Unmatched Previous Count', COUNT(available)},
	{'Likely Match Count', COUNT(newscore)},
	{'New Record Count', COUNT(newrecords)},
	{'Deleted Record Count', COUNT(removed)}
	], rStat);
	
EXPORT ReProcessGlobalWatchlist(string version) :=
SEQUENTIAL(
	OUTPUT(reconstruct,,'~thor::uniqueid::alldata',
			xml('Entity', heading(hdr,ftr),trim, OPT), overwrite),
	OUTPUT(dsCounts,,'~thor::uniqueid::stats.csv',CSV(HEADING(SINGLE),QUOTE('"'),TERMINATOR('\r\n')),OVERWRITE),
	OUTPUT(PROJECT(newscore,rReport),,'~thor::uniqueid::likelymatches.csv',CSV(HEADING(SINGLE),QUOTE('"'),TERMINATOR('\r\n')),OVERWRITE),
	OUTPUT(PROJECT(newrecords,rReport),,'~thor::uniqueid::newrecords.csv',CSV(HEADING(SINGLE),QUOTE('"'),TERMINATOR('\r\n')),OVERWRITE),
	OUTPUT(PROJECT(removed,rReport),,'~thor::uniqueid::deletedrecords.csv',CSV(HEADING(SINGLE),QUOTE('"'),TERMINATOR('\r\n')),OVERWRITE),
	OUTPUT(UniqueId.PubDates,,'~thor::uniqueid::listcounts.csv',CSV(HEADING(SINGLE),QUOTE('"'),TERMINATOR('\r\n')),OVERWRITE),
	OUTPUT(scored,,'~thor::uniqueid::scores.csv',CSV(HEADING(SINGLE),QUOTE('"'),TERMINATOR('\r\n')),OVERWRITE),
	OUTPUT(reconstruct(WatchListName NOT IN uniqueId.SetOfLists),named('unplanned')),	// should be 0
	UniqueId.UnsprayCSV('~thor::uniqueid::stats.csv'),
	UniqueId.UnsprayCSV('~thor::uniqueid::likelymatches.csv'),
	UniqueId.UnsprayCSV('~thor::uniqueid::newrecords.csv'),
	UniqueId.UnsprayCSV('~thor::uniqueid::deletedrecords.csv'),
	UniqueId.UnsprayCSV('~thor::uniqueid::listcounts.csv'),
	UniqueId.UnsprayCSV('~thor::uniqueid::scores.csv'),
	UniqueId.BuildAll,
	STD.File.ClearSuperFile('~thor::uniqueid::base::current'),
	OUTPUT(totalrecords,,'~thor::uniqueid::base::file::' + version,OVERWRITE),
	STD.File.AddSuperFile('~thor::uniqueid::base::current','~thor::uniqueid::base::file::' + version)
);
