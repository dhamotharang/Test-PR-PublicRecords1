inFile := dataset('~thor_data400::base::facilities',CNLD_Facilities.layout_Facilities_AID,thor);

CNLD_Facilities.layout_Facilities_AID_schd_BIP  tSchedule_prep(inFile L) := TRANSFORM
		self.deanbr_sch1 		:= L.deanbr_sch[1];
		self.deanbr_sch2 		:= L.deanbr_sch[2];
		self.deanbr_sch2n 	:= L.deanbr_sch[3];
		self.deanbr_sch3 		:= L.deanbr_sch[4];
		self.deanbr_sch3n 	:= L.deanbr_sch[5];
		self.deanbr_sch4 		:= L.deanbr_sch[6];
		self.deanbr_sch5 		:= L.deanbr_sch[7];
		SELF := L;
END;
rsSchedule	:= PROJECT(inFile, tSchedule_prep(LEFT));

export file_Facilities_AID_BIP := rsSchedule;

