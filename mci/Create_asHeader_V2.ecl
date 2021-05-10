import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility, Std, MCI;

EXPORT Create_asHeader_V2 (string pVersion, boolean pUseProd, string gcid, string pHistMode, string100 gcid_name, string10 batch_jobid) := MODULE

		EXPORT Build_it := FUNCTION
		
			pBaseFile		:= IF(NOTHOR(FileServices.GetSuperFileSubCount(MCI.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).processed_input_lBaseTemplate_built)) = 0
												 ,dataset([],MCI.Layouts_V2.input_processing)
												 ,MCI.Files_V2(pVersion,pUseProd,gcid,pHistMode).processed_input.built);

			MCI.Layouts_V2.as_header xformAH(MCI.Layouts_V2.input_processing L) := TRANSFORM
				SELF.dt_first_seen              	:= (unsigned)_validate.date.fCorrectedDateString(trim(stringlib.stringfilterout((string)l.dt_first_seen,'-.>$!%*@=?&\''),left,right),false);
				SELF.dt_last_seen           	   	:= (unsigned)_validate.date.fCorrectedDateString(trim(stringlib.stringfilterout((string)l.dt_last_seen,'-.>$!%*@=?&\''),left,right),false);
				SELF.dt_vendor_first_reported	   	:= (unsigned)_validate.date.fCorrectedDateString(trim(stringlib.stringfilterout((string)l.dt_vendor_first_reported,'-.>$!%*@=?&\''),left,right),false);
				SELF.dt_vendor_last_reported	   	:= (unsigned)_validate.date.fCorrectedDateString(trim(stringlib.stringfilterout((string)l.dt_vendor_last_reported,'-.>$!%*@=?&\''),left,right),false);
				SELF.lexid												:= L.lexid;
				SELF.old_lexid										:= L.prev_lexid;
				SELF.old_crk											:= L.prev_crk;
				SELF															:= L;
				SELF															:= [];
			END;

			dsAsHeader := PROJECT(pBaseFile, xformAH(LEFT));
	
			RETURN dsAsHeader;
			
	END;
	
END;
