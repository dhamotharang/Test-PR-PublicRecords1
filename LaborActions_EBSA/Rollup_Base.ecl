import ut;
	
export Rollup_Base(dataset(Layouts.Base) pDataset) := function

		filter_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

		//This transform removes special characters and spaces from the Plan fields
		Layouts.Roll_Up trFileToRollUp(Layouts.Base l) := transform
			self.Rollup_Clean_Plan_Name						:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Clean_Plan_Name,filter_string));
			self.Rollup_Clean_Plan_Administrator	:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Clean_Plan_Administrator,filter_string));					
			self                									:= l;
		end;

	Layouts.Roll_Up RollupUpdate(Layouts.Roll_Up l, Layouts.Roll_Up r) := transform
		self.Date_FirstSeen	:=	ut.EarliestDate(
																						ut.EarliestDate(l.Date_FirstSeen, r.Date_FirstSeen),
																						ut.EarliestDate(l.Date_LastSeen, r.Date_LastSeen)
																			  		);
		self.Date_LastSeen	:=	max(l.Date_LastSeen,r.Date_LastSeen);
		self.Date_Added			:=	(string)ut.EarliestDate(
																						ut.EarliestDate((unsigned6)l.Date_Added, (unsigned6)r.Date_Added),
																						ut.EarliestDate((unsigned6)l.Date_Updated, (unsigned6)r.Date_Updated)
																			  		);
		self.Date_Updated		:=	(string)max((unsigned6)l.Date_Updated,(unsigned6)r.Date_Updated);
		self                := l;
 	end;
		
	//This transform slims down the dataset from the RollUp structure to the 
	//Base structure.
	Layouts.Base trRollUpToBase(Layouts.Roll_Up l) := transform
			self := l;
	end;

	//This project takes the Base file and creates a new file where
	//the dataset has new "RollUp" fields.
	dProjToRollup		:=	project(pDataset, trFileToRollUp(left));

	pDataset_sort	:=	sort(	dProjToRollup,
													except 
															 Date_FirstSeen
															,Date_LastSeen
															,Date_Added
															,Date_Updated
															,Plan_Name
															,Plan_Administrator
															,Clean_Plan_Name
															,Clean_Plan_Administrator	
													);

	//This sort will sort on the "RollUp" fields and the other fields where
	//there is not a punctuation issue.	
	pDataset_rollup := rollup( 	pDataset_sort,
															RollupUpdate(left, right),
															record,
															except 
																	 Date_FirstSeen
																	,Date_LastSeen
																	,Date_Added
																	,Date_Updated
												    			,Plan_Name
														   	  ,Plan_Administrator
															    ,Clean_Plan_Name
															    ,Clean_Plan_Administrator	
                            );
														
	//This project slims down the dataset from the RollUp structure to the 
	//Base structure.
	dProjToBase		:=	project(pDataset_rollup, trRollUpToBase(left));

	return dProjToBase;

end;
