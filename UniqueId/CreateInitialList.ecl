EXPORT CreateInitialList(string version) := FUNCTION
file := DATASET('~thor::in::uniqueid::entity::'+version, Layout_Watchlist.rWatchList, XML('WatchList_List/Entity'));
file0 := DISTRIBUTE(file,(integer)id);
//file1 := DEDUP(file0, EXCEPT id,entity_added_by,ALL);

file2 := PROJECT(file0,xAssignPrimaryKey(LEFT,COUNTER));
newseed := MAX(file2, GetMaxLNid(Entity_Unique_id));
file3 := UniqueId.fn_ToFlat(file2);
file4 := DEDUP(file3, RECORD, EXCEPT primarykey, id,entity_added_by,ALL);
initial := fn_AssignId(file4);
return DemoteFiles(initial, version);

END;
