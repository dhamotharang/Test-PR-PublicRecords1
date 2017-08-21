import LaborActions_MSHA;

export fJoin_Inspection_Violation(
										dataset(Layouts_Mine.Base)				std_Mine,
										dataset(Layouts_Inspection.Base)	std_Inspection,
										dataset(Layouts_Violation.Base)		std_Violation,
										string pversion) := function
	
	Mine_Dist				:= DISTRIBUTE(std_Mine,HASH(Mine_Id_Cleaned));
	Inspection_Dist := DISTRIBUTE(std_Inspection,HASH(Event_No_Cleaned));
	Violation_Dist 	:= DISTRIBUTE(std_Violation,HASH(Event_No_Cleaned));

	Layout_Slim_Mine := record
		string Mine_Id_Cleaned;
	end;

	Layout_Slim_Mine Slim_Down_Mine(Mine_Dist l) := TRANSFORM
		self.Mine_Id_Cleaned	:= l.Mine_Id_Cleaned;		
	end; 

	slim_Mine 	:= PROJECT(Mine_Dist,Slim_Down_Mine(LEFT));
	
	Layouts_Base_Events.Base Join_Inspection_Violation(Inspection_Dist l, Violation_Dist r) := TRANSFORM
		self.Event_No_Cleaned	:= if (l.Event_No_Cleaned<>'',l.Event_No_Cleaned,r.Event_No_Cleaned);
		self									:= l;
		self									:= r;
		self									:= [];
	end; 

	// Doing an left outer join on Inspection and Violation because the Inspection file
	// contains the primary key "Mine_Id".  Therefore an orphaned Violation is of no value (A
	// violation must have an associated Inspection record otherwise it is eliminated).
	// However, all Inspection records are kept even if a Violation record doesn't exist.
	Joined_Inspect_Violation := JOIN(
										Inspection_Dist,
										Violation_Dist,
										LEFT.Event_No_Cleaned = RIGHT.Event_No_Cleaned,
										Join_Inspection_Violation(LEFT,RIGHT),
										LEFT OUTER,
										LOCAL
										);	
										
	Joined_Inspect_Violation_Dist	:= DISTRIBUTE(Joined_Inspect_Violation,HASH(Mine_Id_Cleaned));						

	Layouts_Base_Events.Base Validate_Mine_Id(slim_Mine l, Joined_Inspect_Violation_Dist r) := TRANSFORM
		self.Mine_Id_Cleaned	:= IF (l.Mine_Id_Cleaned<>'',l.Mine_Id_Cleaned,r.Mine_Id_Cleaned);
		self.Date_FirstSeen	 	:= (integer)pversion;
		self.Date_LastSeen	 	:= (integer)pversion;		
		self									:= r;
	end; 
	
	Joined_Mine_Inspect_Violation := JOIN(
										slim_Mine,
										Joined_Inspect_Violation_Dist,
										LEFT.Mine_Id_Cleaned = RIGHT.Mine_Id_Cleaned,
										Validate_Mine_Id(LEFT,RIGHT),
										LOCAL
										);			

	return Joined_Mine_Inspect_Violation;
end;