// this build performs weekly and monthly CompID fullfilments driven by IsWeekly and IsMonthly:
	// weekly:
		// 1.regenerate best_compid_weekly
		// 2.spray a week's worth of compID inserts placed in edata12::/hds_180/cid/weekly/in
		// 3.clean and assign a Link ID to inserts
		// 4.join to best_compid_weekly (watchdog) to inserts
		// 5.enhance insert record with matching record from best_compid_weekly
		// 6.add new Link Id's to monitoring list - exclude Link Id's not matched on #4 and/or not in 51 states
		// 7.split the records enhanced by state
		// 8.despray enhanced CompID records onto edata12::/hds_180/cid/weekly/out
	// monthly:
		// 1.regenerate best_compid
		// 2.detect best_compid changes from previous month (Delta)
		// 3.create a sync transaction record for each split, collapse, change, or add
		// 4.synchronize monitoring list by removing Link ID's that split or collapsed, and adding new cores
		// 5.regenerate best_compid key
		// 6.split the transaction records by state
		// 7.despray enhanced CompID records onto edata12::/hds_180/cid/monthly/out

#if((compID.Mode.IsWeekly and compID.Mode.IsMonthly) or (~compID.Mode.IsWeekly and ~compID.Mode.IsMonthly) )
	#error('         CompID.Mode         IS        NOT        SET        CORRECTLY!!')
#elseif(compID.Mode.IsWeekly)
	#stored ('watchtype','compid_weekly')
	#workunit('name', 'CompID_Weekly....Ver.='+compID.Version)
	#warning('     =>> WEEKLY....Ver.='+compID.Version+'    WEEKLY....Ver.='+compID.Version+'    WEEKLY....Ver.='+compID.Version+'    WEEKLY....Ver.='+compID.Version+'    WEEKLY ! ! ')
#elseif(compID.Mode.IsMonthly)
	#stored ('watchtype','compid')
	#workunit('name', 'CompID_Monthly....Ver.='+compID.Version)
	#warning('    =>>  MONTHLY....Ver.='+compID.Version+'    MONTHLY....Ver.='+compID.Version+'    MONTHLY....Ver.='+compID.Version+'    MONTHLY....Ver.='+compID.Version+'    MONTHLY!!')
#end
CompID.Build_compID;