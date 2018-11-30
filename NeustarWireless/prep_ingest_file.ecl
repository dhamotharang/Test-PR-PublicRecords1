IMPORT NeustarWireless, MDR;
EXPORT prep_ingest_file (dataset({Layouts.Raw, string75 raw_file_name {virtual(logicalfilename)}}) raw_file):= FUNCTION

	//Populate added fields
		NeustarWireless.Layouts.Base tAppendFields({Layouts.Raw, string75 raw_file_name {virtual(logicalfilename)}} pInput) := TRANSFORM
			vFileDate := pInput.raw_file_name[length(trim(pInput.raw_file_name))-7..length(trim(pInput.raw_file_name))];
			self.date_first_seen	:=  vFileDate; 
			self.date_last_seen		:=  vFileDate;
			self.date_vendor_first_reported :=	vFileDate;
			self.date_vendor_last_reported 	:=	vFileDate;
			self.persistent_record_id 			:= HASH64(TRIM(pInput.phone) + vFileDate);
			self.DID            	:=	0;
			self.RawAID						:=	0;
			self.Process_Date 		:=  thorlib.wuid()[2..9];
			self.current_rec := true;
			self.source := MDR.sourceTools.src_NeustarWireless;
			self:=pInput;	
			self:= [];
	END;
	
	pAppendInput := PROJECT(raw_file, tAppendFields(LEFT));
	
	RETURN pAppendInput;
END;
	