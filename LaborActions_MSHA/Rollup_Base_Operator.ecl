import ut;

export Rollup_Base_Operator(dataset(Layouts_Base_Operator.Base) pDataset) := function
		
		pDataset_dist	:= DISTRIBUTE(pDataset,HASH(Mine_Id_Cleaned));

		filter_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

		//This transform removes special characters from the Business fields.  Some input
		//datasets do not have special characters in the fields.  This is done before the 
		//rollup occurs.
		Layouts_Base_Operator.Roll_Up trFileToRollUp(Layouts_Base_Operator.Base l) := transform
			self.Rollup_Sub_Unit_Description	:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Sub_Unit_Description,filter_string));
			self                							:= l;
		end;

		//This transform slims down the dataset from the RollUp structure to the 
		//Base structure.
		Layouts_Base_Operator.Base trRollUpToBase(Layouts_Base_Operator.Roll_Up l) := transform
			self := l;
		end;

		Layouts_Base_Operator.Roll_Up RollupUpdate(Layouts_Base_Operator.Roll_Up l, Layouts_Base_Operator.Roll_Up r) := transform
			self.Date_FirstSeen	:=	ut.EarliestDate(
																							ut.EarliestDate(l.Date_FirstSeen, r.Date_FirstSeen),
																							ut.EarliestDate(l.Date_LastSeen, r.Date_LastSeen)
																							);
			self.Date_LastSeen	:=	max(l.Date_LastSeen,r.Date_LastSeen);
			self                := l;
		end;
		
		//This project takes the Base file and creates a new file where
		//the dataset has new "RollUp" fields.  These fields have all the 
		//punctuation removed since some of the files are missing punctuation.
		dProjToRollup		:=	project(pDataset_dist, trFileToRollUp(left));		
		
		//This sort will sort on the "cleaned" fields of Mine_Id and Sub_Unit.	
		pDataset_sort	:=	sort(	dProjToRollup,
														except 
																Mine_Id,
																Sub_Unit,
																Sub_Unit_Description,
																Date_FirstSeen,         
																Date_lastSeen,
																LOCAL
														);

	//This rollup will use the "cleaned" fields of Mine_Id and Sub_Unit.	
	pDataset_rollup := rollup( 	pDataset_sort,
															RollupUpdate(left, right),
															record,
															except
																	Mine_Id,
																	Sub_Unit,
																	Sub_Unit_Description,																	
																	Date_FirstSeen,    
																	Date_lastSeen,
																	LOCAL
                            );

	//This project slims down the dataset from the RollUp structure to the 
	//Base structure.
	dProjToBase		:=	project(pDataset_rollup, trRollUpToBase(left));													

	return dProjToBase;
end;
