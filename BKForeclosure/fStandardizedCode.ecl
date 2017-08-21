IMPORT mdr;
EXPORT fStandardizedCode := MODULE

export StandardizedNod(DATASET(RECORDOF(layout_BK.did_nod_plus)) dinFile_Nod) := FUNCTION
 layout_BK.base_nod  tStandardizeNod(dinFile_Nod L, C) := TRANSFORM
	SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	    //yyyymmdd
	SELF.LAST_UPD_DTE			:= L.ln_filedate;							//it was set to process_date before
	SELF.STAMP_DTE				:= L.ln_filedate; 					 	//yyyymmdd
	
	//Added based on the implementation from  File_Nod
	SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
	SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
	SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
	SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
	SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
			
  SELF.src  := mdr.sourceTools.src_BKFS_Nod;
	SELF.record_id := intformat(C,10,1);
	SELF := L;
 END;

p_src_nod := PROJECT(dinFile_Nod, tStandardizeNod(LEFT,COUNTER));
RETURN p_src_nod;
END;

export StandardizedReo(DATASET(RECORDOF(layout_BK.did_reo_plus)) dinFile_Reo) := function
 layout_BK.base_reo  tStandardizeReo(dinFile_Reo L, C) := transform
	SELF.CREATE_DTE				:= thorlib.wuid()[2..9];	    //yyyymmdd
	SELF.LAST_UPD_DTE			:= L.ln_filedate;							//it was set to process_date before
	SELF.STAMP_DTE				:= L.ln_filedate; 					 	//yyyymmdd
	
	//Added based on the implementation from  File_Nod
	SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
	SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
	SELF.DATE_VENDOR_FIRST_REPORTED := L.ln_filedate;
	SELF.DATE_VENDOR_LAST_REPORTED	:= L.ln_filedate;
	SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
	
  SELF.src  := mdr.sourceTools.src_BKFS_reo;
	SELF.record_id := intformat(C,10,1);
	SELF := L;
 END;

p_src_reo := PROJECT(dinFile_reo, tStandardizeReo(LEFT,COUNTER));
RETURN p_src_reo;
END;

END;