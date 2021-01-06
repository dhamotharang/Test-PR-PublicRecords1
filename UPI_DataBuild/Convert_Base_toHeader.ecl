import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility, Std, UPI_DataBuild;

EXPORT Convert_Base_toHeader (string pVersion, boolean pUseProd, string gcid, string pHistMode) := MODULE

		EXPORT Build_it := FUNCTION
		
			pBaseFile		:= map(												 
											pHistMode = 'N'	=> dataset([],UPI_DataBuild.Layouts_V2.base),
											NOTHOR(FileServices.GetSuperFileSubCount(UPI_DataBuild.Filenames_V2(pVersion, pUseProd, gcid, pHistMode).member_lBaseTemplate_built)) = 0 =>
														dataset([],UPI_DataBuild.Layouts_V2.base),
											UPI_DataBuild.Files_V2(pVersion,pUseProd,gcid,pHistMode).member_base.qa);
												 
			header_layout := record
				UPI_DataBuild.Layouts_V2.as_header;
				unsigned1	__tpe;
			end;

			header_layout xformHL(UPI_DataBuild.Layouts_V2.base L) := TRANSFORM
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

			dsTempHeader := PROJECT(pBaseFile, xformHL(LEFT));
	
			RETURN dsTempHeader;
			
	END;
	
END;
