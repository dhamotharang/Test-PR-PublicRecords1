IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, UPI_DataBuild,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT Standardize_V2 (string pVersion, boolean pUseProd, string gcid, unsigned1 pLexidThreshold, string1 pHistMode, string100 gcid_name, string10 batch_jobid, string1 pAppendOption):= MODULE
					
	EXPORT Common_stamping	:= FUNCTION
	
		pBaseFile	:= UPI_DataBuild.Files_V2(pVersion, pUseProd, gcid, pHistMode).from_batch;

		UPI_DataBuild.layouts_V2.input_processing tMapping(UPI_DataBuild.layouts_V2.from_batch L) := TRANSFORM
			SELF.Src											:= gcid;
			SELF.gcid_name								:= gcid_name;
			SELF.batch_jobid							:= batch_jobID;
			SELF.Dt_first_seen						:= (unsigned)pVersion[1..8];
			SELF.Dt_last_seen							:= (unsigned)pVersion[1..8];
			SELF.Dt_vendor_first_reported	:= (unsigned)pVersion[1..8];
			SELF.Dt_vendor_last_reported	:= (unsigned)pVersion[1..8];		
			SELF.history_or_current				:= 'C';
			SELF.startdate								:= (unsigned)pVersion[1..8]; // place holder for point-in-time
			SELF.enddate									:= 99991231; // place holder for point-in-time
			SELF.runtime_threshold				:= if(pAppendOption = '4', 90, pLexidThreshold);
			SELF.history_mode							:= (string)pHistMode;
			SELF.append_option						:= (string)pAppendOption;
			SELF.current_input						:= 'Y';
			SELF.prev_lexid								:= 0;
			SELF.prev_crk									:= '';
			SELF.crk_changed							:= '';
			SELF.lexid_changed						:= '';
			SELF  :=  L;
			SELF  :=  [];
		END;
		
		stdFile	:= project(pBaseFile, tMapping(left));
		
		RETURN	stdFile;		
	END;
		
END;