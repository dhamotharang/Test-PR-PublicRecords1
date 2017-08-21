import LaborActions_MSHA;

export fJoin_Contractor_CY_QT( dataset(Layouts_Mine.Base)											std_Mine
															,dataset(Layouts_Contractor.Base)								std_Contractor
															,dataset(Layouts_Contractor_CY_Employment.Base)	std_Contractor_CY_Employment
															,dataset(Layouts_Contractor_QT_Employment.Base)	std_Contractor_QT_Employment
															,string pversion) := function

	dedup_CY_Employment  := DEDUP(SORT(std_Contractor_CY_Employment,whole record),whole record);
	dedup_QT_Employment  := DEDUP(SORT(std_Contractor_QT_Employment,whole record),whole record);

	Mine_Dist			 			 := DISTRIBUTE(std_Mine,HASH(Mine_Id_Cleaned));
	Contractor_Dist	 	 	 := DISTRIBUTE(std_Contractor,HASH(Contractor_Id_Cleaned));
	CY_Employment_Dist 	 := DISTRIBUTE(dedup_CY_Employment,HASH(Contractor_Id_Cleaned));
	QT_Employment_Dist 	 := DISTRIBUTE(dedup_QT_Employment,HASH(Contractor_Id_Cleaned));

		
	Layout_Slim_Mine := record
		string Mine_Id_Cleaned;
	end;

	Layout_Slim_Mine Slim_Down_Mine(Mine_Dist l) := TRANSFORM
		self.Mine_Id_Cleaned	:= l.Mine_Id_Cleaned;		
	end; 

	slim_Mine 	:= PROJECT(Mine_Dist,Slim_Down_Mine(LEFT));

	Layouts_Base_Contractor.Base Join_Contractor_CY_and_QT(CY_Employment_Dist l, QT_Employment_Dist r) := TRANSFORM
		self.Contractor_Id_Cleaned 	:= IF (l.Contractor_Id_Cleaned<>'',l.Contractor_Id_Cleaned,r.Contractor_Id_Cleaned);	
		self.Sub_Unit_Cleaned				:= IF (l.Sub_Unit_Cleaned<>'',l.Sub_Unit_Cleaned,r.Sub_Unit_Cleaned);
		self.Calendar_Year					:= IF (l.Calendar_Year<>'',l.Calendar_Year,r.Production_Year);
		self.Production_Year				:= IF (r.Production_Year<>'',r.Production_Year,l.Calendar_Year);				
		self												:= l;
		self												:= r;
		self												:= [];
	end; 
	
	// Doing an inner join on Contractor_CY_Employment and Contractor_QT_Employment because CY is a summary
	// of the QT records.  Therefore CY or QT orphans are of no value.
	Joined_Contractor_CY_and_QT := JOIN(CY_Employment_Dist,
																			QT_Employment_Dist,
																			LEFT.contractor_id_cleaned = RIGHT.contractor_id_cleaned AND
																			LEFT.sub_unit_cleaned	 		 = RIGHT.sub_unit_cleaned AND
																			LEFT.calendar_year 				 = RIGHT.production_year,
																			Join_Contractor_CY_and_QT(LEFT,RIGHT),
																			LOCAL
																		  );										

	Layouts_Base_Contractor.Base Join_In_Contractor(Contractor_Dist l, joined_contractor_cy_and_qt r) := TRANSFORM
		self.Contractor_Id_Cleaned 	:= IF (l.Contractor_Id_Cleaned<>'',l.Contractor_Id_Cleaned,r.Contractor_Id_Cleaned);	
		self												:= l;
		self												:= r;
	end; 
	
	//Doing an left outer join with the Contractor file.  The contractor record is kept even if a "CY and QT"
	//record doesn't exist.  However, we do not want to keep any "CY and QT" records that don't match with a 
	//record in the contractor file. 
	Joined_In_Contractor := JOIN(Contractor_Dist,
															 joined_contractor_cy_and_qt,
															 LEFT.contractor_id_cleaned = RIGHT.contractor_id_cleaned,
															 Join_In_Contractor(LEFT,RIGHT),
															 LEFT OUTER,
															 LOCAL
															 );	
	
	Joined_In_Contractor_Dist	:= DISTRIBUTE(Joined_In_Contractor,HASH(Mine_Id_Cleaned));

	Layouts_Base_Contractor.Base Validate_Mine_Id(slim_Mine l, Joined_In_Contractor_Dist r) := TRANSFORM
		self.mine_id_cleaned 	:= IF (l.mine_id_cleaned<>'',l.mine_id_cleaned,r.mine_id_cleaned);
		self.Date_FirstSeen	 	:= (integer)pversion;
		self.Date_LastSeen	 	:= (integer)pversion;		
		self									:= r;
	end; 
	
	//Doing an inner join with the Mine file.  Only keep those contractor records that have an associated
	//mine record.  The Mine file is the "primary" file for LaborActions_MSHA.  A contractor record with no
	//matching mine record is of no value.
	Joined_Contractor_CY_QT := JOIN(
										slim_Mine,
										Joined_In_Contractor_Dist,
										LEFT.mine_id_cleaned = RIGHT.mine_id_cleaned,
										Validate_Mine_Id(LEFT,RIGHT),
										LOCAL
										);			

	return Joined_Contractor_CY_QT;
end;