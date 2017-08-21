import tools;

export Utilities :=
module


	export Convert_CAold2new(

		dataset(layouts.base.ca_old)	pDataset
	
	) :=
	function

		//convert to layout with child datasets for repeated fields to make it easier to map to new layout
		tools.mac_RedefineFormat(pDataset		,Liquor_Licenses.Layouts.base.ca_old2		,dPrep		,,,[8,8,8,8,8,8,8,8,8,8,8,8]);
		
		//map to new layout
		dnorm := normalize(dPrep,8,transform(
			layouts.base.ca,
				self.dt_first_seen													:= left.dt_first_seen																																;
				self.dt_last_seen														:= left.dt_last_seen																																;
				self.dt_vendor_first_reported								:= left.dt_vendor_first_reported																										;
				self.dt_vendor_last_reported								:= left.dt_vendor_last_reported																											;
				self.rawfields.license_type									:= left.rawfields.LICENSE_TYPES								[counter].LICENSE_TYPE								;
				self.rawfields.file_number									:= left.rawfields.FILE_NUMBER																												;
				self.rawfields.lic_or_app										:= ''																																								;
				self.rawfields.type_status									:= left.rawfields.TYPES_STATUS_CODES					[counter].TYPES_STATUS_CODE						;
				self.rawfields.type_orig_issue_dates				:= left.rawfields.TYPES_ORIGINAL_ISSUE_DATES	[counter].TYPES_ORIGINAL_ISSUE_DATE		;
				self.rawfields.expiration_dates							:= left.rawfields.TYPES_EXPIRATION_DATES			[counter].TYPES_EXPIRATION_DATE				;
				self.rawfields.fee_codes										:= left.rawfields.TYPES_FEE_CODES							[counter].TYPES_FEE_CODE							;
				self.rawfields.duplicate_counts							:= left.rawfields.TYPES_DUPLICATE_COUNTS			[counter].TYPES_DUPLICATE_COUNT				;
				self.rawfields.master_indicator							:= left.rawfields.TYPES_MASTER_INDICATORS			[counter].TYPES_MASTER_INDICATOR			;
				self.rawfields.term_in_months								:= ''																																								;
				self.rawfields.geo_code											:= left.rawfields.GEO_CODE																													;		
				self.rawfields.district_office_code					:= left.rawfields.DISTRICT_CODE																											;
				self.rawfields.primary_name									:= left.rawfields.PRIMARY_NAME																											;
				self.rawfields.premise_street_address1			:= left.rawfields.PREMISE_STREET_ADDRESS1																						;
				self.rawfields.premise_street_address2			:= left.rawfields.PREMISE_STREET_ADDRESS2																						;
				self.rawfields.premise_city									:= left.rawfields.PREMISE_CITY																											;
				self.rawfields.premise_state								:= left.rawfields.PREMISE_ST																												;
				self.rawfields.premise_zip									:= left.rawfields.PREMISE_ZIP																												;
				self.rawfields.DBA_name											:= left.rawfields.DBA_NAME																													;
				self.rawfields.mail_street_address1					:= left.rawfields.MAIL_STREET_ADDRESS1																							;
				self.rawfields.mail_street_address2					:= left.rawfields.MAIL_STREET_ADDRESS2																							;
				self.rawfields.mail_city										:= left.rawfields.MAIL_CITY																													;
				self.rawfields.mail_state										:= left.rawfields.MAIL_ST																														;
				self.rawfields.mail_zip											:= left.rawfields.MAIL_ZIP																													;
				self.rawfields.CENSUS_TRACT									:= left.rawfields.CENSUS_TRACT																											;			
				self.rawfields.TYPES_TRANSFER_FROM_NUMBER		:= left.rawfields.TYPES_TRANSFER_FROM_NUMBERS	[counter].TYPES_TRANSFER_FROM_NUMBER	;		
				self.rawfields.TYPES_STATUS_DATE						:= left.rawfields.TYPES_STATUS_DATES					[counter].TYPES_STATUS_DATE						;	
				self.rawfields.FILE_STATUS_CODE							:= left.rawfields.FILE_STATUS_CODE																									;
				self.rawfields.FILE_STATUS_DATE							:= left.rawfields.FILE_STATUS_DATE																									;
				self.clean_primary_name											:= left.clean_primary_name																													;
				self.Clean_location_address									:= left.Clean_location_address																											;
				self.Clean_mailing_address									:= left.Clean_mailing_address																												;
				self.clean_dates.FILE_STATUS_DATE						:= left.clean_dates.FILE_STATUS_DATE																								;
				self.clean_dates.TYPES_STATUS_DATE					:= left.clean_dates.TYPES_STATUS_DATES				[counter].TYPES_STATUS_DATE						;
				self.clean_dates.TYPES_ORIGINAL_ISSUE_DATE	:= left.clean_dates.TYPES_ORIGINAL_ISSUE_DATES[counter].TYPES_ORIGINAL_ISSUE_DATE		;
				self.clean_dates.TYPES_EXPIRATION_DATE			:= left.clean_dates.TYPES_EXPIRATION_DATES		[counter].TYPES_EXPIRATION_DATE				;
				
		));
		
		//dedup identical records
		ddedup := dedup(dnorm(rawfields.license_type != ''), all);//must have license type, if not, it is just a dup
		return ddedup;

	end;

end;