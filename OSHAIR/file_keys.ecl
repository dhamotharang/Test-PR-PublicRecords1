IMPORT dx_OSHAIR, BIPV2;

EXPORT file_keys := MODULE
  
	//----------------------------
	// BDID Key
	//----------------------------
	f1 := $.file_out_inspection_cleaned;

	slim_f1 := record
		f1.BDID;
		f1.Activity_Number;
	end;

	EXPORT bdid := table (f1 (BDID<>0), slim_f1);
	
	//----------------------------
  // LinkIDs Key
	//----------------------------	
	f2 := $.file_out_inspection_cleaned_both;
 
  slim_f2	:=	record
		bipv2.IDlayouts.l_key_ids;
		UNSIGNED8 source_rec_id 			:= 0;    
		layout_OSHAIR_inspection_clean;
		integer1 fp := 0;  		
	end;
  
	EXPORT linkids := project(f2(UltID > 0), TRANSFORM(slim_f2,SELF := LEFT;));
	
	//----------------------------
  // Accident Key
	//----------------------------		
	f3 := $.file_out_accident_cleaned;

	slim_f3	:=	record
		OSHAIR.layout_OSHAIR_accident_clean	 
		 - dt_first_seen	- dt_last_seen						 
		 - dt_vendor_first_reported - dt_vendor_last_reported;	  
	end;

  EXPORT accident	:=	project(f3, TRANSFORM(slim_f3,SELF := LEFT;));
	
	//----------------------------
  // Hazardous Substance Key
	//----------------------------		
	f4 := $.file_out_hazardous_substance_cleaned;

	slim_f4	:=	record
		OSHAIR.layout_OSHAIR_hazardous_substance_clean	 
		 - dt_first_seen	- dt_last_seen						 
		 - dt_vendor_first_reported - dt_vendor_last_reported;	  
	end;

  EXPORT hazardous_substance	:=	project(f4, TRANSFORM(slim_f4,SELF := LEFT;));
	
	//----------------------------
  // Program Key
	//----------------------------		
	f5 := $.file_out_program_cleaned;

	slim_f5	:=	record
		OSHAIR.layout_OSHAIR_program_clean	 
		 - dt_first_seen	- dt_last_seen						 
		 - dt_vendor_first_reported - dt_vendor_last_reported;	  
	end;

  EXPORT program	:=	project(f5, TRANSFORM(slim_f5,SELF := LEFT;));	
	
	//----------------------------
  // Violations Key
	//----------------------------		
	f6 := $.file_out_violations_cleaned;

	slim_f6	:=	record
		OSHAIR.layout_OSHAIR_violations_clean	 
		 - dt_first_seen	- dt_last_seen						 
		 - dt_vendor_first_reported - dt_vendor_last_reported;	  
	end;

  EXPORT violations	:=	project(f6, TRANSFORM(slim_f6,SELF := LEFT;));	
	
END;