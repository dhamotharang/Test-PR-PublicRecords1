IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, HMS_STLIC,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT StandardizeInputFile (string filedate, boolean pUseProd = false):= MODULE
		EXPORT STRING RemoveTimeStamp(string s) := FUNCTION
							
							searchpattern := '^(.*):(.*):(.*) (AM|PM|EDT|EST|PDT|PST)';
							patStart := REGEXFIND(searchpattern,s,1);
							patEnd := REGEXFIND(searchpattern,s,0);
							f := REGEXREPLACE(s[(length(patStart)-1)..(length(patEnd))], s, '', NOCASE);
     				
					return f;
		END;
		
		EXPORT StLicense	:= FUNCTION
   					
			baseFile := HMS_STLIC.fn_joinstatelicense(filedate,pUseProd);
			
			// baseFile := DATASET('~thor400_data::in::hms_stl::hms_statelicense::temp::' + filedate,HMS_STLIC.Layouts.statelicense_layout,THOR);
			
   		HMS_STLIC.Layouts.statelicense_base tMapping(HMS_STLIC.Layouts.statelicense_layout L) := TRANSFORM
				SELF.ln_key										:= if(L.ln_key[3]<>'_',L.ln_key[..2]+'_'+L.ln_key[3..],L.ln_key);
				SELF.src											:= MDR.SourceTools.src_HMS_PM;//if(L.hms_src[length(trim(L.hms_src,left,right))] in ['M','H'],L.hms_src[..length(trim(L.hms_src,left,right))-1],L.hms_src); //L.hms_src;
   			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
   			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
   			SELF.Dt_first_seen						:= 0;
   			SELF.Dt_last_seen							:= 0;
				SELF.hms_src								:= if(L.hms_src[length(trim(L.hms_src,left,right))] in ['M','H'],L.hms_src[..length(trim(L.hms_src,left,right))-1],L.hms_src);
				SELF.license_number					:= L.license_number;
				SELF.license_class_type			:= L.license_class_type;
				SELF.license_state					:= L.license_state;
				SELF.address_type						:= L.address_type;  
				SELF.specialty_class_type		:= L.specialty_class_type;
				SELF.phone_type							:= L.phone_type;
				SELF.phone_number						:= L.phone_number;
				SELF.firmname								:= TRIM(Stringlib.StringToUpperCase(L.firmname), LEFT, RIGHT);
				SELF.street1								:= TRIM(Stringlib.StringToUpperCase(L.street1), LEFT, RIGHT);
				SELF.street2								:= TRIM(Stringlib.StringToUpperCase(L.street2), LEFT, RIGHT);
				SELF.street3								:= TRIM(Stringlib.StringToUpperCase(L.street3), LEFT, RIGHT);
				SELF.city										:= TRIM(Stringlib.StringToUpperCase(L.city), LEFT, RIGHT);
				SELF.address_state					:= TRIM(Stringlib.StringToUpperCase(L.address_state), LEFT, RIGHT);
				SELF.orig_county						:= TRIM(Stringlib.StringToUpperCase(L.county), LEFT, RIGHT);
				SELF.orig_zip								:= TRIM(Stringlib.StringToUpperCase(L.zip), LEFT, RIGHT);
				SELF.Prepped_addr1					:= TRIM(Stringlib.StringToUpperCase(trim(L.street1,left,right) + if(trim(L.street2,left,right)<>'',',','') +  trim(L.street2,left,right) + if(trim(L.street3,left,right)<>'',',','') + trim(L.street3,left,right)), LEFT, RIGHT);
				SELF.Prepped_addr2          := TRIM(Stringlib.StringToUpperCase(
																							StringLib.StringCleanSpaces(	trim(L.city,left,right) + if(trim(L.city,left,right) <> '',',','')
																		+ ' '+ trim(L.address_state,left,right)
																		+ ' '+ trim(L.zip,left,right)[..5]
																		)),LEFT,RIGHT);
				
				SELF.dateofbirth 						:= if(length(trim(L.dateofbirth,left,right))>20,ut.CleanSpacesAndUpper( RemoveTimeStamp(trim(L.dateofbirth))),L.dateofbirth); 
				SELF.dateofdeath 						:= if(length(trim(L.dateofdeath,left,right))>20,ut.CleanSpacesAndUpper( RemoveTimeStamp(trim(L.dateofdeath))),L.dateofdeath);
				
				// SELF.clean_phone1						:= if(ut.CleanPhone(L.phone1) [1] not in ['0','1'] and length(ut.CleanPhone(L.phone1)) >= 10 and length(REGEXREPLACE('9',ut.CleanPhone(L.phone1),'')) > 0,ut.CleanPhone(L.phone1), '');
				// SELF.clean_phone2						:= if(ut.CleanPhone(L.phone2) [1] not in ['0','1'] and length(ut.CleanPhone(L.phone2)) >= 10 and length(REGEXREPLACE('9',ut.CleanPhone(L.phone2),'')) > 0,ut.CleanPhone(L.phone2), '');
				// SELF.clean_phone3						:= if(ut.CleanPhone(L.phone3) [1] not in ['0','1'] and length(ut.CleanPhone(L.phone3)) >= 10 and length(REGEXREPLACE('9',ut.CleanPhone(L.phone3),'')) > 0,ut.CleanPhone(L.phone3), '');
				// SELF.clean_fax1   					:= if(ut.CleanPhone(L.fax1) [1] not in ['0','1'] and length(ut.CleanPhone(L.fax1)) >= 10 and length(REGEXREPLACE('9',ut.CleanPhone(L.fax1),'')) > 0,ut.CleanPhone(L.fax1), '');
				// SELF.clean_fax2   					:= if(ut.CleanPhone(L.fax2) [1] not in ['0','1'] and length(ut.CleanPhone(L.fax2)) >= 10 and length(REGEXREPLACE('9',ut.CleanPhone(L.fax2),'')) > 0,ut.CleanPhone(L.fax2), '');
				// SELF.clean_fax3   					:= if(ut.CleanPhone(L.fax3) [1] not in ['0','1'] and length(ut.CleanPhone(L.fax3)) >= 10 and length(REGEXREPLACE('9',ut.CleanPhone(L.fax3),'')) > 0,ut.CleanPhone(L.fax3), '');
				// SELF.clean_other_phone1			:= if(ut.CleanPhone(L.other_phone1) [1] not in ['0','1'] and length(ut.CleanPhone(L.other_phone1)) >= 10 and length(REGEXREPLACE('9',ut.CleanPhone(L.other_phone1),'')) > 0,ut.CleanPhone(L.other_phone1), '');
				// SELF.clean_phone						:= if(ut.CleanPhone(L.phone_number) [1] not in ['0','1'] and length(ut.CleanPhone(L.phone_number)) >= 10 and length(REGEXREPLACE('9',ut.CleanPhone(L.phone_number),'')) > 0,ut.CleanPhone(L.phone_number), '');
				
					//Custom Clean 0000000000|9999999999|(0or1)######### and remove prefix 1 and 0
				SELF.clean_phone1						:= HMS_STLIC.fn_cleanHMSPhone (L.phone1); 
				SELF.clean_phone2						:= HMS_STLIC.fn_cleanHMSPhone (L.phone2); 
				SELF.clean_phone3						:= HMS_STLIC.fn_cleanHMSPhone (L.phone3); 
				SELF.clean_fax1   					:= HMS_STLIC.fn_cleanHMSPhone (L.fax1); 
				SELF.clean_fax2   					:= HMS_STLIC.fn_cleanHMSPhone (L.fax2); 
				SELF.clean_fax3   					:= HMS_STLIC.fn_cleanHMSPhone (L.fax3); 
				SELF.clean_other_phone1			:= HMS_STLIC.fn_cleanHMSPhone (L.other_phone1); 
				SELF.clean_phone						:= HMS_STLIC.fn_cleanHMSPhone (L.phone_number);
				
				SELF.clean_company_name 		:= if(ut.CleanCompany(L.firmname)<> '', ut.CleanCompany(L.firmname), datalib.companyclean(L.firmname));
				
				
				// SELF.clean_issue_date				:= if(length(trim(L.issue_date,left,right))<4,'',if(HMS_STLIC.Dates.ChkDtStr(StringLib.StringCleanSpaces(L.issue_date)),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.CvtDate( HMS_STLIC.Dates.CvtDateEx(HMS_STLIC.Dates.PrepDtStr(trim(StringLib.StringCleanSpaces(L.issue_date),left,right)) ) ,'%Y%m%d'),false),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.ChkRevDtStr(trim(StringLib.StringCleanSpaces(L.issue_date),left,right)),false)));
				// SELF.clean_expiration_date	:= if(length(trim(L.expiration_date,left,right))<4,'',if(HMS_STLIC.Dates.ChkDtStr(StringLib.StringCleanSpaces(L.expiration_date)),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.CvtDate( HMS_STLIC.Dates.CvtDateEx(HMS_STLIC.Dates.PrepDtStr(trim(StringLib.StringCleanSpaces(L.expiration_date),left,right)) ),'%Y%m%d'),false),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.ChkRevDtStr(trim(StringLib.StringCleanSpaces(L.expiration_date),left,right)),false)));
				// SELF.clean_offense_date			:= if(length(trim(L.offense_date,left,right))<4,'',if(HMS_STLIC.Dates.ChkDtStr(StringLib.StringCleanSpaces(L.offense_date)),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.CvtDate( HMS_STLIC.Dates.CvtDateEx(HMS_STLIC.Dates.PrepDtStr(trim(StringLib.StringCleanSpaces(L.offense_date),left,right)) ),'%Y%m%d'),false),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.ChkRevDtStr(trim(StringLib.StringCleanSpaces(L.offense_date),left,right)),false)));
				// SELF.clean_action_date			:= if(length(trim(L.action_date,left,right))<4,'',if(HMS_STLIC.Dates.ChkDtStr(StringLib.StringCleanSpaces(L.action_date)),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.CvtDate( HMS_STLIC.Dates.CvtDateEx(HMS_STLIC.Dates.PrepDtStr(trim(StringLib.StringCleanSpaces(L.action_date),left,right)) ),'%Y%m%d'),false),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.ChkRevDtStr(trim(StringLib.StringCleanSpaces(L.action_date),left,right)),false)));
				// SELF.clean_dateofbirth			:= if(length(trim(L.dateofbirth,left,right))<4,'',if(HMS_STLIC.Dates.ChkDtStr(StringLib.StringCleanSpaces(L.dateofbirth)),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.CvtDate( HMS_STLIC.Dates.CvtDateEx(HMS_STLIC.Dates.PrepDtStr(trim(StringLib.StringCleanSpaces(L.dateofbirth),left,right)) ),'%Y%m%d'),false),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.ChkRevDtStr(trim(StringLib.StringCleanSpaces(L.dateofbirth),left,right)),false)));
				// SELF.clean_dateofdeath			:= if(length(trim(L.dateofdeath,left,right))<4,'',if(HMS_STLIC.Dates.ChkDtStr(StringLib.StringCleanSpaces(L.dateofdeath)),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.CvtDate( HMS_STLIC.Dates.CvtDateEx(HMS_STLIC.Dates.PrepDtStr(trim(StringLib.StringCleanSpaces(L.dateofdeath),left,right)) ),'%Y%m%d'),false),_validate.date.fCorrectedDateString(HMS_STLIC.Dates.ChkRevDtStr(trim(StringLib.StringCleanSpaces(L.dateofdeath),left,right)),false)));
				
				SELF.clean_issue_date				:= HMS_STLIC.fn_cleanDate(L.issue_date);
				SELF.clean_expiration_date	:= HMS_STLIC.fn_cleanDate(L.expiration_date);
				SELF.clean_offense_date			:= HMS_STLIC.fn_cleanDate(L.offense_date);
				SELF.clean_action_date			:= HMS_STLIC.fn_cleanDate(L.action_date);
				
				// SELF.clean_dateofbirth			:= HMS_STLIC.fn_cleanDate(L.dateofbirth);
				// SELF.clean_dateofdeath			:= HMS_STLIC.fn_cleanDate(L.dateofdeath);
				
				SELF.clean_dateofbirth			:= if(length(trim(L.dateofbirth,left,right))>20,HMS_STLIC.fn_cleanDate(ut.CleanSpacesAndUpper( RemoveTimeStamp(trim(L.dateofbirth)))),HMS_STLIC.fn_cleanDate(L.dateofbirth));
				SELF.clean_dateofdeath			:= if(length(trim(L.dateofdeath,left,right))>20,HMS_STLIC.fn_cleanDate(ut.CleanSpacesAndUpper( RemoveTimeStamp(trim(L.dateofdeath)))),HMS_STLIC.fn_cleanDate(L.dateofdeath));
				
				SELF.clean_zip5							:= REGEXREPLACE('-', L.zip[..5], '');
				SELF.clean_zip4							:= REGEXREPLACE('-', L.zip[6..], '');
				SELF.In_State								:= trim(L.state,left,right);
				SELF.In_Class								:= trim(L.stlicclass,left,right);
				SELF.In_Status							:= trim(L.status,left,right);
				SELF.In_Qualifier1					:= trim(L.qualifier1,left,right);
				SELF.In_Qualifier2					:= trim(L.qualifier2,left,right);
				SELF.mapped_class						:= trim(L.mapped_class,left,right);
				SELF.mapped_status					:= trim(L.mapped_status,left,right);
				SELF.mapped_qualifier1			:= trim(L.mapped_qualifier1,left,right);
				SELF.mapped_qualifier2			:= trim(L.mapped_qualifier2,left,right);
				SELF.mapped_pdma						:= trim(L.mapped_pdma,left,right);
				SELF.mapped_pract_type			:= trim(L.mapped_pract_type,left,right);
				SELF.source_code						:= 'HMS_PL_' + L.license_state + '_' + (string)L.hms_src;
				SELF.taxonomy_code					:= L.taxonomy_code;
				SELF.file_date							:= (string)filedate;
				SELF  :=  L;
   			SELF  :=  [];
   		END;
   		
   		RETURN PROJECT(baseFile, tMapping(LEFT));
   		
   	END;

END;