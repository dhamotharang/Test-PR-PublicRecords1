import LaborActions_MSHA;

export fJoin_Accident( dataset(Layouts_Mine.Base)				std_Mine
											,dataset(Layouts_Accident.Base)		std_Accident
											,string pversion) := function

	sorted_Mine			:= SORT(DISTRIBUTE(std_Mine,HASH(Mine_Id_Cleaned)),Mine_Id_Cleaned,LOCAL);
	sorted_Accident := SORT(DISTRIBUTE(std_Accident,HASH(Mine_Id_Cleaned)),Mine_Id_Cleaned,LOCAL);

	Layout_Slim_Mine := record
		string Mine_Id_Cleaned;
	end;

	Layout_Slim_Mine Slim_Down_Mine(sorted_Mine l) := TRANSFORM
		self.Mine_Id_Cleaned	:= l.Mine_Id_Cleaned;		
	end; 

	slim_Mine 	:= PROJECT(sorted_Mine,Slim_Down_Mine(LEFT));

	Layouts_Base_Accident.Base Validate_With_Mine_Id(slim_Mine l, sorted_Accident r) := TRANSFORM
		self.Mine_Id_Cleaned := IF (l.Mine_Id_Cleaned<>'',l.Mine_Id_Cleaned,r.Mine_Id_Cleaned);
		self.Date_FirstSeen	 := (integer)pversion;
		self.Date_LastSeen	 := (integer)pversion;		
		self								 := r;
	end; 
	
	//Inner join with Mine - Only keep Accident records that match Mine records
	//because the Mine file is the primary file.
	Joined_Mine_Accident := JOIN(
										slim_Mine,
										sorted_Accident,
										LEFT.Mine_Id_Cleaned = RIGHT.Mine_Id_Cleaned,
										Validate_With_Mine_Id(LEFT,RIGHT),
										LOCAL
										);			

	return Joined_Mine_Accident;
end;