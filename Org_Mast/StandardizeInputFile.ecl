IMPORT  ut, mdr, _validate, Address, lib_stringlib, Org_Mast;

EXPORT StandardizeInputFile (string filedate, boolean pUseProd = false):= MODULE

	EXPORT msrc := '';
	EXPORT invalid_dates:=['','0000-00-00','\\N'];

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	EXPORT organization := FUNCTION
		baseFile	:= Org_Mast.Files(filedate,pUseProd).organization;

//		Org_Mast.layouts.individual_base tMapping(layouts.organization_in L) := TRANSFORM, SKIP(L.Org_Mast_piid = 'Org_Mast_piid')
		Org_Mast.layouts.organization_base tMapping(layouts.organization_in L) := TRANSFORM //ELIMINATED SKIP:   , SKIP(L.Org_Mast_piid = 'Org_Mast_piid')
			SELF.LNFID											:= L.LNFID;
			SELF.NAME			 									:= TRIM(Stringlib.StringToUpperCase(L.NAME		 			), LEFT, RIGHT);
			SELF.ADDRESS1										:= TRIM(Stringlib.StringToUpperCase(L.ADDRESS1 			), LEFT, RIGHT);
			SELF.ADDRESS2										:= TRIM(Stringlib.StringToUpperCase(L.ADDRESS2 			), LEFT, RIGHT);
			SELF.CITY          					    := TRIM(Stringlib.StringToUpperCase(L.CITY     			), LEFT, RIGHT);
			SELF.STATE         							:= TRIM(Stringlib.StringToUpperCase(L.STATE    			), LEFT, RIGHT);
			SELF.ZIP           							:= TRIM(Stringlib.StringToUpperCase(L.ZIP      			), LEFT, RIGHT);
			SELF.ZIP4          					    := TRIM(Stringlib.StringToUpperCase(L.ZIP4     			), LEFT, RIGHT);
			SELF.LID           							:= TRIM(Stringlib.StringToUpperCase(L.LID      			), LEFT, RIGHT);
			SELF.AGID          							:= TRIM(Stringlib.StringToUpperCase(L.AGID     			), LEFT, RIGHT);
			SELF.CBSA_CODE     					    := TRIM(Stringlib.StringToUpperCase(L.CBSA_CODE			), LEFT, RIGHT);
			SELF.LATITUDE      							:= TRIM(Stringlib.StringToUpperCase(L.LATITUDE      ), LEFT, RIGHT);
			SELF.LONGITUDE     							:= TRIM(Stringlib.StringToUpperCase(L.LONGITUDE     ), LEFT, RIGHT);
			SELF.FACTYPE       					    := TRIM(Stringlib.StringToUpperCase(L.FACTYPE       ), LEFT, RIGHT);
			SELF.ORG_TYPE_CODE 							:= TRIM(Stringlib.StringToUpperCase(L.ORG_TYPE_CODE ), LEFT, RIGHT);
			SELF.ORGTYPE       							:= TRIM(Stringlib.StringToUpperCase(L.ORGTYPE       ), LEFT, RIGHT);
			SELF.LN_GP_SPEC1   					    := TRIM(Stringlib.StringToUpperCase(L.LN_GP_SPEC1		), LEFT, RIGHT);
			SELF.LN_GP_SPEC2   							:= TRIM(Stringlib.StringToUpperCase(L.LN_GP_SPEC2		), LEFT, RIGHT);
			SELF.NCPDP         							:= TRIM(Stringlib.StringToUpperCase(L.NCPDP      		), LEFT, RIGHT);
			SELF.NPI         								:= TRIM(Stringlib.StringToUpperCase(L.NPI	      		), LEFT, RIGHT);
			SELF.VENDIBILITY   					    := TRIM(Stringlib.StringToUpperCase(L.VENDIBILITY		), LEFT, RIGHT);

			SELF.prepped_addr1              := TRIM(Stringlib.StringToUpperCase(SELF.ADDRESS1)
			                                    + IF(SELF.ADDRESS1 <> '' AND SELF.ADDRESS2 <> '', ',', '')
			                                    + Stringlib.StringToUpperCase(SELF.ADDRESS2)
																					,LEFT, RIGHT);
			SELF.prepped_addr2              := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(SELF.CITY)
																					+ IF(SELF.CITY <> '',',','')
																					+ ' '+ SELF.STATE	+ ' '
																					+ SELF.ZIP[..5]))
																					,LEFT,RIGHT);

			SELF.src    												:= msrc;
			SELF.date_vendor_first_reported     := (unsigned)filedate;
			SELF.date_vendor_last_reported      := (unsigned)filedate;
			SELF.date_first_seen                := 0;
			SELF.date_last_seen                 := 0;

	  	SELF.clean_phone 										:= if(ut.CleanPhone(L.phone1) [1] not in ['0','1'],ut.CleanPhone(L.phone1), '') ;

			SELF.record_type										:= 'C';
			SELF  															:=  L;
			SELF 																:= [];		// Make all other fiedls blank/0
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	EXPORT affiliations	:= FUNCTION
		baseFile	:= Org_Mast.Files(filedate,pUseProd).affiliations;

		Org_Mast.layouts.affiliations_base tMapping(layouts.affiliations_in L) := TRANSFORM
			SELF.LNFID													:= L.LNFID;
			SELF.HMS_PIID												:= TRIM(Stringlib.StringToUpperCase(L.HMS_PIID), LEFT, RIGHT);
			SELF.FACTYPE												:= TRIM(Stringlib.StringToUpperCase(L.FACTYPE ), LEFT, RIGHT);

			SELF.date_vendor_first_reported     := (unsigned)filedate;
			SELF.date_vendor_last_reported      := (unsigned)filedate;
			SELF.date_first_seen                := 0;
			SELF.date_last_seen                 := 0;
			SELF.src    												:= msrc;

			SELF.record_type										:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	EXPORT aha	:= FUNCTION
		baseFile	:= Org_Mast.Files(filedate,pUseProd).aha;

		Org_Mast.layouts.aha_base tMapping(layouts.aha_in L) := TRANSFORM
			SELF.LNFID											:= (integer)L.LNFID;
			SELF.AHA_ID 										:= TRIM(Stringlib.StringToUpperCase(L.AHA_ID ), LEFT, RIGHT);
			// New Fields
			SELF.HOSPITAL_NAME							:= TRIM(Stringlib.StringToUpperCase(L.HOSPITAL_NAME), LEFT, RIGHT);
			SELF.NAME_CHIEF_ADMINSTRATOR		:= TRIM(Stringlib.StringToUpperCase(L.NAME_CHIEF_ADMINSTRATOR), LEFT, RIGHT);
			SELF.STREET_ADDRESS							:= TRIM(Stringlib.StringToUpperCase(L.STREET_ADDRESS), LEFT, RIGHT);
			SELF.CITY          					    := TRIM(Stringlib.StringToUpperCase(L.CITY     			), LEFT, RIGHT);
			SELF.STATE_ABBR    							:= TRIM(Stringlib.StringToUpperCase(L.STATE_ABBR		), LEFT, RIGHT);
			SELF.ZIP_CODE      							:= TRIM(Stringlib.StringToUpperCase(L.ZIP_CODE 			), LEFT, RIGHT);
			//SELF.ADDRESS2										:= '';//		TRIM(Stringlib.StringToUpperCase(L.ADDRESS2 			), LEFT, RIGHT);
			SELF.SYSTEM_NAME								:= TRIM(Stringlib.StringToUpperCase(L.SYSTEM_NAME), LEFT, RIGHT);
			SELF.SYSTEM_ADDRESS							:= TRIM(Stringlib.StringToUpperCase(L.SYSTEM_ADDRESS), LEFT, RIGHT);
			SELF.SYSTEM_CITY								:= TRIM(Stringlib.StringToUpperCase(L.SYSTEM_CITY), LEFT, RIGHT);
			SELF.SYSTEM_STATE								:= TRIM(Stringlib.StringToUpperCase(L.SYSTEM_STATE), LEFT, RIGHT);
			SELF.SYSTEM_PRIMARY_CONTACT			:= TRIM(Stringlib.StringToUpperCase(L.SYSTEM_PRIMARY_CONTACT), LEFT, RIGHT);
			SELF.SYSTEM_CONTACT_TITLE				:= TRIM(Stringlib.StringToUpperCase(L.SYSTEM_CONTACT_TITLE), LEFT, RIGHT);
			SELF.COUNTY_NAME								:= TRIM(Stringlib.StringToUpperCase(L.COUNTY_NAME), LEFT, RIGHT);
			SELF.CBSA_NAME									:= TRIM(Stringlib.StringToUpperCase(L.CBSA_NAME), LEFT, RIGHT);
			SELF.TEACH											:= TRIM(Stringlib.StringToUpperCase(L.TEACH), LEFT, RIGHT);
			SELF.CLEAN_DT_BEGIN_DATE				:= if(length(trim(L.DT_BEGIN_DATE,left,right))<4,'',if(Org_Mast.Dates.ChkDtStr(StringLib.StringCleanSpaces(L.DT_BEGIN_DATE)),_validate.date.fCorrectedDateString(Org_Mast.Dates.CvtDate( Org_Mast.Dates.CvtDateEx(Org_Mast.Dates.PrepDtStr(trim(StringLib.StringCleanSpaces(L.DT_BEGIN_DATE),left,right)) ),'%Y%m%d'),false),_validate.date.fCorrectedDateString(Org_Mast.Dates.ChkRevDtStr(trim(StringLib.StringCleanSpaces(L.DT_BEGIN_DATE),left,right)),false)));
			SELF.CLEAN_DT_END_DATE					:= if(length(trim(L.DT_END_DATE,left,right))<4,'',if(Org_Mast.Dates.ChkDtStr(StringLib.StringCleanSpaces(L.DT_END_DATE)),_validate.date.fCorrectedDateString(Org_Mast.Dates.CvtDate( Org_Mast.Dates.CvtDateEx(Org_Mast.Dates.PrepDtStr(trim(StringLib.StringCleanSpaces(L.DT_END_DATE),left,right)) ),'%Y%m%d'),false),_validate.date.fCorrectedDateString(Org_Mast.Dates.ChkRevDtStr(trim(StringLib.StringCleanSpaces(L.DT_END_DATE),left,right)),false)));
			SELF.CLEAN_FISCAL_YEAR					:= if(length(trim(L.FISCAL_YEAR,left,right))<4,'',if(Org_Mast.Dates.ChkDtStr(StringLib.StringCleanSpaces(L.FISCAL_YEAR)),_validate.date.fCorrectedDateString(Org_Mast.Dates.CvtDate( Org_Mast.Dates.CvtDateEx(Org_Mast.Dates.PrepDtStr(trim(StringLib.StringCleanSpaces(L.FISCAL_YEAR),left,right)) ),'%Y%m%d'),false),_validate.date.fCorrectedDateString(Org_Mast.Dates.ChkRevDtStr(trim(StringLib.StringCleanSpaces(L.FISCAL_YEAR),left,right)),false)));
			SELF.SERVICE_DESC 							:= TRIM(Stringlib.StringToUpperCase(L.SERVICE_DESC), LEFT, RIGHT);
			SELF.CBSA_TYPE									:= TRIM(Stringlib.StringToUpperCase(L.CBSA_TYPE), LEFT, RIGHT);
			SELF.src												:= mdr.sourceTools.src_AHA;
			SELF.date_vendor_first_reported     := (unsigned)filedate;
			SELF.date_vendor_last_reported      := (unsigned)filedate;
			SELF.clean_Phone								:= L.area_code + L.Phone_number;
			SELF.date_first_seen                := 0;
			SELF.date_last_seen                 := 0;
			SELF.prepped_addr1              := TRIM(Stringlib.StringToUpperCase(SELF.STREET_ADDRESS) ,LEFT, RIGHT);

			SELF.prepped_addr2              := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(SELF.CITY)
																					+ IF(SELF.CITY <> '',',','')
																					+ ' '+ SELF.STATE_ABBR	+ ' '
																					+ SELF.ZIP_CODE[..5]))
																					,LEFT,RIGHT);


			SELF.record_type										:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	EXPORT dea	:= FUNCTION
		baseFile	:= Org_Mast.Files(filedate,pUseProd).dea;

		Org_Mast.layouts.dea_base tMapping(layouts.dea_in L) := TRANSFORM
			SELF.LNFID													:= L.LNFID;
			SELF.DEA														:= TRIM(Stringlib.StringToUpperCase(L.DEA         ), LEFT, RIGHT);
			SELF.DEA_SCHEDULE										:= TRIM(Stringlib.StringToUpperCase(L.DEA_SCHEDULE), LEFT, RIGHT);
			SELF.DEA_EXPIRATION_DATE						:= TRIM(L.DEA_EXPIRATION_DATE, LEFT, RIGHT);
			SELF.DEA_BUSINESS_ACT_CODE					:= TRIM(Stringlib.StringToUpperCase(L.DEA_BUSINESS_ACT_CODE	  ), LEFT, RIGHT);
			SELF.DEA_BUSINESS_ACT_SUBCODE				:= TRIM(Stringlib.StringToUpperCase(L.DEA_BUSINESS_ACT_SUBCODE), LEFT, RIGHT);

			SELF.date_vendor_first_reported     := (unsigned)filedate;
			SELF.date_vendor_last_reported      := (unsigned)filedate;
			SELF.date_first_seen                := 0;
			SELF.date_last_seen                 := 0;
			SELF.src    												:= msrc;

			SELF.record_type										:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	EXPORT npi	:= FUNCTION
		baseFile	:= Org_Mast.Files(filedate,pUseProd).npi;

		Org_Mast.layouts.npi_base tMapping(layouts.npi_in L) := TRANSFORM
			SELF.LNFID													:= L.LNFID;
			SELF.NPI														:= Stringlib.StringToUpperCase(TRIM(L.NPI, LEFT, RIGHT));
			SELF.NPI_STATUS											:= Stringlib.StringToUpperCase(L.NPI_STATUS);

			SELF.date_vendor_first_reported     := (unsigned)filedate;
			SELF.date_vendor_last_reported      := (unsigned)filedate;
			SELF.date_first_seen                := 0;
			SELF.date_last_seen                 := 0;
			SELF.src    												:= msrc;

			SELF.record_type										:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	EXPORT pos	:= FUNCTION
		baseFile	:= Org_Mast.Files(filedate,pUseProd).pos;

		Org_Mast.layouts.pos_base tMapping(layouts.pos_in L) := TRANSFORM
			SELF.Provider_Number						:= TRIM(L.Provider_Number, LEFT, RIGHT);
			SELF.LNFID											:= (integer)L.LNFID;
			// New Fields
			SELF.Facility_name							:= TRIM(Stringlib.StringToUpperCase(L.Facility_name ), LEFT, RIGHT);
			SELF.ADDRESS										:= TRIM(Stringlib.StringToUpperCase(L.ADDRESS       ), LEFT, RIGHT);
			SELF.CITY          					    := TRIM(Stringlib.StringToUpperCase(L.CITY     			), LEFT, RIGHT);
			SELF.STATE		    							:= TRIM(Stringlib.StringToUpperCase(L.STATE					), LEFT, RIGHT);
			SELF.ZIP_CODE      							:= TRIM(Stringlib.StringToUpperCase(L.ZIP_CODE 			), LEFT, RIGHT);
			SELF.src												:= mdr.sourceTools.src_POS;
			SELF.date_vendor_first_reported     := (unsigned)filedate;
			SELF.date_vendor_last_reported      := (unsigned)filedate;
			SELF.clean_Phone								:= L.Phone;
			SELF.date_first_seen                := 0;
			SELF.date_last_seen                 := 0;
			SELF.prepped_addr1              := TRIM(Stringlib.StringToUpperCase(SELF.ADDRESS) ,LEFT, RIGHT);

			SELF.prepped_addr2              := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM(SELF.CITY)
																					+ IF(SELF.CITY <> '',',','')
																					+ ' '+ SELF.STATE	+ ' '
																					+ SELF.ZIP_CODE[..5]))
																					,LEFT,RIGHT);

			SELF.record_type										:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	EXPORT crosswalk	:= FUNCTION
		baseFile	:= Org_Mast.Files(filedate,pUseProd).crosswalk;

		Org_Mast.layouts.crosswalk_base tMapping(layouts.crosswalk_in L) := TRANSFORM
			SELF.LNFID													:= L.LNFID;
			SELF.SOURCE      	 								  := TRIM(Stringlib.StringToUpperCase(L.SOURCE ), LEFT, RIGHT);
			SELF.PRIMARY_ID    	 								:= TRIM(Stringlib.StringToUpperCase(L.PRIMARY_ID ), LEFT, RIGHT);

			SELF.date_vendor_first_reported     := (unsigned)filedate;
			SELF.date_vendor_last_reported      := (unsigned)filedate;
			SELF.date_first_seen                := 0;
			SELF.date_last_seen                 := 0;
			SELF.src    												:= msrc;

			SELF.record_type										:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;


END;
