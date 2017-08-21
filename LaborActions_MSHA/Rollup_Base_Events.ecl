import ut;

export Rollup_Base_Events(dataset(Layouts_Base_Events.Base) pDataset) := function
		
		pDataset_dist	:= DISTRIBUTE(pDataset,HASH(Mine_Id_Cleaned));

		//This sort will sort on the "cleaned" fields of Mine_Id, Event_No, Contractor_Id
		//Violation_No, Violator_Id, and Inspection_Activity_Code.		
		pDataset_sort	:=	sort(	pDataset_dist,
														except 
																Mine_Id,
																Event_No,
																Contractor_Id,
																Violation_No,
																Violator_Id,
																Inspection_Activity_Code,
																Date_FirstSeen,                
																Date_lastSeen,
																LOCAL
														);

	Layouts_Base_Events.Base RollupUpdate(Layouts_Base_Events.Base l, Layouts_Base_Events.Base r) := transform
		self.Date_FirstSeen	:=	ut.EarliestDate(
																						ut.EarliestDate(l.Date_FirstSeen, r.Date_FirstSeen),
																						ut.EarliestDate(l.Date_LastSeen, r.Date_LastSeen)
																			  		);
		self.Date_LastSeen	:=	max(l.Date_LastSeen,r.Date_LastSeen);
		self                := l;
 	end;
	
		//This rollup will use the "cleaned" fields of Mine_Id,Event_No, Contractor_Id
		//Violation_No, Violator_Id, and Inspection_Activity_Code.
	pDataset_rollup := rollup( 	pDataset_sort,
															RollupUpdate(left, right),
															record,
															except 
																	Mine_Id,
																	Event_No,
																	Contractor_Id,
																	Violation_No,
																	Violator_Id,
																	Inspection_Activity_Code,
																	Date_FirstSeen,                
																	Date_lastSeen,
																	LOCAL
                            );
														
	return pDataset_rollup;
end;
