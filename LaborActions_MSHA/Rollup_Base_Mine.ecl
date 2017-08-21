import ut;

export Rollup_Base_Mine(dataset(Layouts_Base_Mine.Base) pDataset) := function
		
		pDataset_dist	:= DISTRIBUTE(pDataset,HASH(Mine_Id_Cleaned));
		
		filter_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

		//This transform removes special characters from the name fields.  Some input
		//datasets do not have special characters in the fields.  This is done before the 
		//rollup occurs.
		Layouts_Base_Mine.Roll_Up trFileToRollUp(Layouts_Base_Mine.Base l) := transform
			self.Rollup_Mine_Name				:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Mine_Name,filter_string));
			self.Rollup_Controller_Name	:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Controller_Name,filter_string));				
			self.Rollup_Operator_Name		:= StringLib.StringCleanSpaces(StringLib.StringFilter(l.Operator_Name,filter_string));
			self                				:= l;
		end;

		//This transform slims down the dataset from the RollUp structure to the 
		//Base structure.
		Layouts_Base_Mine.Base trRollUpToBase(Layouts_Base_Mine.Roll_Up l) := transform
			self := l;
		end;
		
		Layouts_Base_Mine.Roll_Up RollupUpdate(Layouts_Base_Mine.Roll_Up l, Layouts_Base_Mine.Roll_Up r) := transform
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
	
	
		//This project takes the Base file and creates a new file where
		//the dataset has new "RollUp" fields.  These fields have all the 
		//punctuation removed since some of the files are missing punctuation.
		dProjToRollup		:=	project(pDataset_dist, trFileToRollUp(left));

		//This sort will sort on the "RollUp" fields and the other fields where
		//there is not a punctuation issue. Also the "cleaned" fields of Mine_Id,
		//Controller_Id, Operator_Id and Assess_Control_No.
		pDataset_sort	:=	sort(	dProjToRollup,
														except
														  Mine_Id
														 ,Controller_Id
														 ,Operator_Id
														 ,Mine_Name
														 ,Controller_Name
														 ,Operator_Name						
														 ,Assess_Control_No
														 ,Date_FirstSeen
														 ,Date_lastSeen
														 ,Date_Added
														 ,Date_Updated
														 ,LOCAL
													);		

		//This rollup will use the "cleaned" fields of Mine_Id,Controller_Id, Operator_Id and
		//Assess_Control_No.  This rollup process will also rollup on all the "RollUp" fields and the other 
		//fields where punctuation is not an issue.
		pDataset_rollup := rollup( 	pDataset_sort,
																RollupUpdate(left, right),
																record,
																except
																	Mine_Id
																 ,Controller_Id
																 ,Operator_Id
																 ,Mine_Name
																 ,Controller_Name
																 ,Operator_Name						
																 ,Assess_Control_No				
																 ,Date_FirstSeen
																 ,Date_lastSeen
																 ,Date_Added
																 ,Date_Updated
																 ,LOCAL
															);												

		//This project slims down the dataset from the RollUp structure to the 
		//Base structure.
		dProjToBase		:=	project(pDataset_rollup, trRollUpToBase(left));

		return dProjToBase;
		
end;
