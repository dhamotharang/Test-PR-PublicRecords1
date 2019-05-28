IMPORT NeustarWireless, MDR;
EXPORT Prep_Activity_Status_Ingest := FUNCTION

	//Populate added fields
	NeustarWireless.Layouts.Base.Activity_Status tAppendFields(RECORDOF(NeustarWireless.Files.Raw_In) pInput) := TRANSFORM	
			vFileDate := (unsigned4) pInput.raw_file_name[length(trim(pInput.raw_file_name))-7..length(trim(pInput.raw_file_name))];
			self.date_vendor_first_reported :=	vFileDate;
			self.date_vendor_last_reported 	:=	vFileDate;
			self.process_date 							:=  (unsigned4) workunit[2..9];
			self.process_time								:= 	(unsigned4) workunit[11..16];
			self.source 										:= 	MDR.sourceTools.src_NeustarWireless;
			self.persistent_record_id 			:= HASH64(TRIM(pInput.phone, LEFT, RIGHT)
																								,TRIM(pInput.Activity_Status, LEFT, RIGHT)
																								);
			self														:=	pInput;	
			self														:= 	[];
	END;
	
	pAppendInput := PROJECT(NeustarWireless.Files.Raw_In, tAppendFields(LEFT));
	
	RETURN pAppendInput;
END;

