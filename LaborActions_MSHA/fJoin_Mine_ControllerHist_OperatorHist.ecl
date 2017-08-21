import LaborActions_MSHA;

export fJoin_Mine_ControllerHist_OperatorHist(
										dataset(Layouts_Mine.Base)							std_Mine,
										dataset(Layouts_Controller_Hist.Base)		std_Controller_Hist,
										dataset(Layouts_Operator_Hist.Base)			std_Operator_Hist,
										string pversion) := function

	Mine_Dist							 := DISTRIBUTE(std_Mine,HASH(Controller_Id_Cleaned,Operator_Id_Cleaned));	
	Controller_Hist_Dist	 := DISTRIBUTE(std_Controller_Hist,HASH(Controller_Id_Cleaned,Operator_Id_Cleaned));	
	Operator_Hist_Dist		 := DISTRIBUTE(std_Operator_Hist,HASH(Mine_Id_Cleaned));

	Layouts_Base_Mine.Base join_mine_controllerhist(Mine_Dist l, Controller_Hist_Dist r) := TRANSFORM
		self.Controller_ID 		:= IF (l.Controller_Id_Cleaned<>'',l.Controller_ID_Cleaned,r.Controller_ID_Cleaned);
		self.Operator_Id 			:= IF (l.Operator_Id_Cleaned<>'',l.Operator_Id_Cleaned,r.Operator_Id_Cleaned);
		self 									:= l;
		self 									:= r;
		self 									:= [];
	end;

	// Doing an left outer join on Mine and Controller_Hist because the Mine file is the primary
	// file for LaborActions_MSHA.  Therefore an orphaned Controller_Hist is of no value.
	// However, all Mine records are kept even if a Controller_Hist record doesn't exist.
	joined_mine_controllerhist := JOIN(Mine_Dist,
																		 Controller_Hist_Dist,
																		 LEFT.Controller_Id_Cleaned = RIGHT.Controller_Id_Cleaned AND
																		 LEFT.Operator_Id_Cleaned = RIGHT.Operator_Id_Cleaned,
																		 join_mine_controllerhist(LEFT,RIGHT),
																		 LEFT OUTER,
																		 LOCAL
																		 );

	Mine_Dist_By_Mine	:= DISTRIBUTE(std_Mine,HASH(Mine_Id_Cleaned));	

	Layouts_Base_Mine.Base join_mine_operatorhist(Mine_Dist_By_Mine l, Operator_Hist_Dist r) := TRANSFORM
		self.Mine_Id_Cleaned			:= IF (l.Mine_Id_Cleaned<>'',l.Mine_Id_Cleaned,r.Mine_Id_Cleaned);
		self.Operator_Id_Cleaned 	:= IF (l.Operator_Id_Cleaned<>'',l.Operator_Id_Cleaned,r.Operator_Id_Cleaned);
		self 											:= l;
		self 											:= r;
		self 											:= [];
	end;
	
	// Doing an left outer join on Mine and Operator_Hist because the Mine file is the primary
	// file for LaborActions_MSHA.  Therefore an orphaned Operator_Hist is of no value.
	// However, all Mine records are kept even if a Operator_Hist record doesn't exist.	
	joined_mine_operatorhist := JOIN(Mine_Dist_By_Mine,
										Operator_Hist_Dist,
										LEFT.mine_id_cleaned 		 = RIGHT.mine_id_cleaned AND
										LEFT.operator_id_cleaned = RIGHT.operator_id_cleaned,
										join_mine_operatorhist(LEFT,RIGHT),
										LEFT OUTER,
										LOCAL
										);
										
	joined_mine_controllerhist_dist := DISTRIBUTE(joined_mine_controllerhist,HASH(Mine_Id_Cleaned));									
	
	Layouts_Base_Mine.Base join_to_mine(joined_mine_controllerhist_dist l, joined_mine_operatorhist r) := TRANSFORM
		self.Mine_Id_Cleaned			:= IF (l.Mine_Id_Cleaned<>'',l.Mine_Id_Cleaned,r.Mine_Id_Cleaned);	
		self.Operator_Id_Cleaned 	:= IF (l.Operator_Id_Cleaned<>'',l.Operator_Id_Cleaned,r.Operator_Id_Cleaned);	
		self.Date_FirstSeen	 	:= (integer)pversion;
		self.Date_LastSeen	 	:= (integer)pversion;		
		self									:= l;	
		self									:= r;
	end;

	innerjoin_to_mine := JOIN(joined_mine_controllerhist_dist,
														joined_mine_operatorhist,
														LEFT.Mine_Id_Cleaned 		 = RIGHT.Mine_Id_Cleaned AND
														LEFT.Operator_Id_Cleaned = RIGHT.Operator_Id_Cleaned,
														join_to_mine(LEFT,RIGHT),
														FULL OUTER,
														LOCAL
														);

  return innerjoin_to_mine;

end;