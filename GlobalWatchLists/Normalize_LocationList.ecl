#option('maxLength', 131072);

import globalwatchlists;

	in_file	:= globalwatchlists.Generate_RecordID_Country;
	//in_file := distribute(in_f, random());

//Normalize locaification
	locaTable := table(in_file, 
						{integer locaCount := count(locationlist), 
						in_file});
						
	out_locas := record
		string recordid;
		string watchlistname;
		globalwatchlists.Generate_RecordID_Country.LocationList;
	end;

	out_locas getlocas(locaTable l, integer c):= transform
		self.recordid		:= l.recordid;
		self.watchlistname 	:= l.watchlistname;
		self 				:= l.locationlist[c];
	end;

	locaNorm := normalize(locaTable, 
						left.locaCount, 
						getlocas(left, counter));
	
	flatLayout := record
		string  recordid;
		string  watchlistname;
		string	LocationID;
		string	LocationType;
		string	LocationName;
	end;
	
	flatLayout flatTran(locaNorm l):= transform
		self := l;
	end;
	
	flatProj 	:= project(locaNorm, flatTran(left));
	ds_sort		:= sort(flatProj, recordid, watchlistname): persist('~thor_200::persist::globalwatch::norm_locationlist');
	
export Normalize_LocationList := ds_sort;