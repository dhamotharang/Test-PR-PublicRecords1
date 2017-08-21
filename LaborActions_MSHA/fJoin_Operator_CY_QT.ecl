import LaborActions_MSHA;

export fJoin_Operator_CY_QT(
										dataset(Layouts_Mine.Base)										std_Mine,
										dataset(Layouts_Operator_CY_Employment.Base)	std_Operator_CY_Employment,
										dataset(Layouts_Operator_QT_Employment.Base)	std_Operator_QT_Employment,
										string pversion) := function

	dedup_CY_Employment  := DEDUP(SORT(std_Operator_CY_Employment,whole record),whole record);
	dedup_QT_Employment  := DEDUP(SORT(std_Operator_QT_Employment,whole record),whole record);

	Mine_Dist			 			 := DISTRIBUTE(std_Mine,HASH(Mine_Id_Cleaned));
	CY_Employment_Dist 	 := DISTRIBUTE(dedup_CY_Employment,HASH(Mine_Id_Cleaned));
	QT_Employment_Dist 	 := DISTRIBUTE(dedup_QT_Employment,HASH(Mine_Id_Cleaned));

	Layout_Slim_Mine := record
		string Mine_Id_Cleaned;
	end;

	Layout_Slim_Mine Slim_Down_Mine(Mine_Dist l) := TRANSFORM
		self.Mine_Id_Cleaned := l.Mine_Id_Cleaned;
	end; 

	slim_Mine 	:= PROJECT(Mine_Dist,Slim_Down_Mine(LEFT));

	Layouts_Base_Operator.Base join_mine_operator_cy_employment(slim_Mine l, CY_Employment_Dist r) := TRANSFORM
		self.Mine_Id_Cleaned 	:= If (l.Mine_Id_Cleaned<>'',l.Mine_Id_Cleaned,r.Mine_Id_Cleaned);
		self 									:= r;
		self 									:= [];
	end;	

	//Inner Join because only the cy records that have a mine record is to be kept
	joined_mine_operator_cy_employment := JOIN(slim_Mine,
																						 CY_Employment_Dist,
																						 LEFT.Mine_Id_Cleaned = RIGHT.Mine_Id_Cleaned,
																						 join_mine_operator_cy_employment(LEFT,RIGHT),
																						 LOCAL
																						 );
	
	Layouts_Base_Operator.Base join_mine_operator_qt_employment(slim_Mine l, QT_Employment_Dist r) := TRANSFORM
		self.Mine_Id_Cleaned 	:= If (l.Mine_Id_Cleaned<>'',l.Mine_Id_Cleaned,r.Mine_Id_Cleaned);
		self 									:= r;
		self 									:= [];
	end;		
	
	//Inner Join because only the qt records that have a mine record is to be kept
	joined_mine_operator_qt_employment := JOIN(slim_Mine ,
																						 QT_Employment_Dist,
																						 LEFT.Mine_Id_Cleaned = RIGHT.Mine_Id_Cleaned,
																						 join_mine_operator_qt_employment(LEFT,RIGHT),
																						 LOCAL
																						 );
										
	Layouts_Base_Operator.Base join_operator_cy_and_qt(joined_mine_operator_cy_employment l, joined_mine_operator_qt_employment r) := TRANSFORM
		self.Dart_Id 									:= IF (l.Dart_Id<>'',l.Dart_Id,r.Dart_Id);		
		self.Mine_Id 									:= IF (l.Mine_Id<>'',l.Mine_Id,r.Mine_Id);
		self.Mine_Id_Cleaned	 				:= IF (l.Mine_Id_Cleaned<>'',l.Mine_Id_Cleaned,r.Mine_Id_Cleaned);	
		self.Sub_Unit									:= IF (l.Sub_Unit<>'',l.Sub_Unit,r.Sub_Unit);
		self.Calendar_Year 						:= l.Calendar_Year;
		self.Hours_Reported_for_Year	:= l.Hours_Reported_for_Year;
		self.Annual_Coal_Production		:= l.Annual_Coal_Production;
		self.Avg_Annual_Employee_Ct		:= l.Avg_Annual_Employee_Ct;
		self.Sub_Unit_Description 		:= r.Sub_Unit_Description;
		self.Production_Year 					:= r.Production_Year;
		self.Production_Quarter 			:= r.Production_Quarter;				
		self.QT_Fiscal_Year 					:= r.QT_Fiscal_Year;
		self.QT_Fiscal_Quarter 				:= r.QT_Fiscal_Quarter;
		self.Avg_Employee_Ct	 				:= r.Avg_Employee_Ct;		
		self.Employee_Hours_Worked 		:= r.Employee_Hours_Worked;
		self.Coal_Production 					:= r.Coal_Production;
		self.Date_FirstSeen	 					:= (integer)pversion;
		self.Date_LastSeen	 					:= (integer)pversion;	
		self													:= l;
		self													:= r;
	end;

	//Left Outer because the cy file is an update-summary of the qt file records
	joined_operator_cy_and_qt := JOIN(joined_mine_operator_cy_employment ,
										joined_mine_operator_qt_employment,
										LEFT.Mine_Id_Cleaned 	= RIGHT.Mine_Id_Cleaned AND
										LEFT.sub_unit = RIGHT.sub_unit AND
										LEFT.calendar_year = RIGHT.production_year,
										join_operator_cy_and_qt(LEFT,RIGHT),
										Left Outer,
										LOCAL
										);

  return joined_operator_cy_and_qt;

end;