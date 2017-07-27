ds := dataset('~thor_data400::BASE::Watchdog_Best_nonglb',Layout_Best,thor);


export File_Best_nonglb := IF(thorlib.nodes() = 400, ds,
									DISTRIBUTE(ds, HASH((INTEGER)did)));