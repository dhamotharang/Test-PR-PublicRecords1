IMPORT ut, mdr, tools, _validate, Address, Ut, lib_stringlib, _Control, business_header, Enclarity,
Header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, NID, AID;

EXPORT Standardize_input (string version = '', boolean pUseProd = false, boolean pPrepped = false) := MODULE

	EXPORT cfs_2 := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).cfs_dbo_cfs_2_input(event_number <> '');
		
		bair.layouts.cfs_dbo_cfs_2_Base tMapping(bair.layouts.cfs_dbo_cfs_2_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			self.clean_edit_date 						:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.edit_date,'.>$!%*@=?&\''),left,right));
			self.clean_date_occurred 				:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_occurred,'.>$!%*@=?&\''),left,right));
			self.clean_date_time_received 	:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_time_received,'.>$!%*@=?&\''),left,right));
			self.clean_date_time_archived 	:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_time_archived,'.>$!%*@=?&\''),left,right));			
			SELF.clean_Current_Phone				:= if(ut.CleanPhone(trim(L.Current_Phone, left, right)) [1] not in ['0','1'],ut.CleanPhone(trim(L.Current_Phone, left, right)), '') ;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT cfs_officers_2 := FUNCTION	
		baseFile 	:= bair.Files('', pUseProd, false, pPrepped).cfs_dbo_cfs_officers_2_input(event_number <> '');
		
		bair.layouts.cfs_dbo_cfs_officers_2_Base tMapping(bair.layouts.cfs_dbo_cfs_officers_2_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			self.clean_date_time_dispatched := (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_time_dispatched,'.>$!%*@=?&\''),left,right));
			self.clean_date_time_enroute 		:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_time_enroute,'.>$!%*@=?&\''),left,right));
			self.clean_date_time_arrived 		:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_time_arrived,'.>$!%*@=?&\''),left,right));
			self.clean_date_time_cleared 		:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.date_time_cleared,'.>$!%*@=?&\''),left,right));	
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT event_mo := FUNCTION
		baseFile := bair.Files('', pUseProd, false, pPrepped).event_dbo_mo_input(ir_number	<> '');
		
		bair.layouts.event_dbo_mo_Base tMapping(layouts.event_dbo_mo_In L) := TRANSFORM
			SELF.record_type							:= 'C';
			SELF.src											:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported := (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  := (UNSIGNED4)version;
			SELF.Dt_first_seen            := 0;
			SELF.Dt_last_seen             := 0;
			self.clean_First_Date_Time 		:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.First_Date_Time,'.>$!%*@=?&\''),left,right));
			self.clean_Last_Date_Time 		:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.Last_Date_Time,'.>$!%*@=?&\''),left,right));
			self.clean_First_Date 				:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.First_Date,'.>$!%*@=?&\''),left,right));
			self.clean_Last_Date 					:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.Last_Date,'.>$!%*@=?&\''),left,right));
			self.clean_Edit_Date 					:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.Edit_Date,'.>$!%*@=?&\''),left,right));
			SELF.clean_Report_Date				:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.Report_Date,'.>$!%*@=?&\''),left,right));
			SELF.clean_RAIDS_activityDate	:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.RAIDS_activityDate,'.>$!%*@=?&\''),left,right));
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT event_persons := FUNCTION
		baseFile := bair.Files('', pUseProd, false, pPrepped).event_dbo_persons_input(ir_number	<> '');

		bair.layouts.event_dbo_persons_Base tMapping(layouts.event_dbo_persons_In L) := TRANSFORM
			SELF.record_type							:= 'C';
			SELF.src											:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported := (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  := (UNSIGNED4)version;
			SELF.Dt_first_seen            := 0;
			SELF.Dt_last_seen             := 0;
			self.clean_edit_date 					:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.edit_date,'.>$!%*@=?&\''),left,right));
			SELF.clean_RAIDS_activityDate	:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.RAIDS_activityDate,'.>$!%*@=?&\''),left,right));
			SELF.clean_dob								:= ut.DateTimeToYYYYMMDD((string)L.dob);			
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT event_vehicle := FUNCTION
		baseFile := bair.Files('', pUseProd, false, pPrepped).event_dbo_vehicle_input(ir_number	<> '');

		bair.layouts.event_dbo_vehicle_Base tMapping(layouts.event_dbo_vehicle_In L) := TRANSFORM
			SELF.record_type							:= 'C';
			SELF.src											:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported := (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  := (UNSIGNED4)version;
			SELF.Dt_first_seen            := 0;
			SELF.Dt_last_seen             := 0;
			self.clean_edit_date 					:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.edit_date,'.>$!%*@=?&\''),left,right));
			SELF.clean_RAIDS_activityDate	:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.RAIDS_activityDate,'.>$!%*@=?&\''),left,right));
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT event_group_access := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).event_import_group_access_input;
		
		bair.layouts.event_import_group_access_Base tMapping(bair.layouts.event_import_group_access_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT event_data_provider := FUNCTION
		baseFile := bair.Files('', pUseProd, false, pPrepped).event_dbo_data_provider_input;

		bair.layouts.event_dbo_data_provider_Base tMapping(layouts.event_dbo_data_provider_In L) := TRANSFORM
			SELF.record_type							:= 'C';
			SELF.src											:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported := (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  := (UNSIGNED4)version;
			SELF.Dt_first_seen            := 0;
			SELF.Dt_last_seen             := 0;
			self.clean_last_upload 				:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.last_upload,'.>$!%*@=?&\''),left,right));
			self.clean_last_date 					:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.last_date,'.>$!%*@=?&\''),left,right));
			self.clean_first_date 				:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.first_date,'.>$!%*@=?&\''),left,right));
			SELF.clean_phone_number 			:= if(ut.CleanPhone(trim(L.phone_number, left, right)) [1] not in ['0','1'],ut.CleanPhone(trim(L.phone_number, left, right)), '') ;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT mo_udf := FUNCTION
		baseFile := bair.Files('', pUseProd, false, pPrepped).event_dbo_mo_udf_input(ir_number	<> '');

		bair.layouts.event_dbo_mo_udf_Base tMapping(layouts.event_dbo_mo_udf_In L) := TRANSFORM
			SELF.record_type							:= 'C';
			SELF.src											:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported := (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  := (UNSIGNED4)version;
			SELF.Dt_first_seen            := 0;
			SELF.Dt_last_seen             := 0;
			self.clean_datetime_val 			:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.datetime_val,'.>$!%*@=?&\''),left,right));
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT persons_udf := FUNCTION
		baseFile := bair.Files('', pUseProd, false, pPrepped).event_dbo_persons_udf_input(ir_number	<> '');

		bair.layouts.event_dbo_persons_udf_Base tMapping(layouts.event_dbo_persons_udf_In L) := TRANSFORM
			SELF.record_type							:= 'C';
			SELF.src											:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported := (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  := (UNSIGNED4)version;
			SELF.Dt_first_seen            := 0;
			SELF.Dt_last_seen             := 0;
			self.clean_datetime_val 			:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.datetime_val,'.>$!%*@=?&\''),left,right));
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT intel_entity := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).intel_dbo_entity_input;
		
		bair.layouts.intel_dbo_entity_Base tMapping(bair.layouts.intel_dbo_entity_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			self.clean_entity_entry_date 		:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.entity_entry_date,'.>$!%*@=?&\''),left,right));
			self.clean_entity_purge_date 		:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.entity_purge_date,'.>$!%*@=?&\''),left,right));
			self.clean_dob 									:= ut.DateTimeToYYYYMMDD((string)L.dob);
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;	
	
	EXPORT intel_entity_notes := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).intel_dbo_entity_notes_input;
		
		bair.layouts.intel_dbo_entity_notes_Base tMapping(bair.layouts.intel_dbo_entity_notes_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT intel_incident := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).intel_dbo_incident_input;
		
		bair.layouts.intel_dbo_incident_Base tMapping(bair.layouts.intel_dbo_incident_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			self.clean_incident_entry_date 	:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.incident_entry_date,'.>$!%*@=?&\''),left,right));
			self.clean_incident_purge_date 	:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.incident_purge_date,'.>$!%*@=?&\''),left,right));
			self.clean_incident_date 				:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.incident_date,'.>$!%*@=?&\''),left,right));
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;	
	
	EXPORT intel_incident_notes := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).intel_dbo_incident_notes_input;
		
		bair.layouts.intel_dbo_incident_notes_Base tMapping(bair.layouts.intel_dbo_incident_notes_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT intel_reporting_officer := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).intel_dbo_reporting_officer_input;
		
		bair.layouts.intel_dbo_reporting_officer_Base tMapping(bair.layouts.intel_dbo_reporting_officer_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
		
	EXPORT intel_vehicle_notes := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).intel_dbo_vehicle_notes_input;
		
		bair.layouts.intel_dbo_vehicle_notes_Base tMapping(bair.layouts.intel_dbo_vehicle_notes_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;	
	
	EXPORT intel_entity_photo := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).intel_dbo_entity_photo_input;
		
		bair.layouts.intel_dbo_entity_photo_Base tMapping(bair.layouts.intel_dbo_entity_photo_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;	
	
	EXPORT offenders_classification := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).offenders_dbo_classification_input;
		
		bair.layouts.offenders_dbo_classification_Base tMapping(bair.layouts.offenders_dbo_classification_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;	
	
	EXPORT offenders_offender_classification := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).offenders_dbo_offender_classification_input;
		
		bair.layouts.offenders_dbo_offender_classification_Base tMapping(bair.layouts.offenders_dbo_offender_classification_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			self.clean_classification_date 	:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.classification_date,'.>$!%*@=?&\''),left,right));
			self.clean_expiration_date 			:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.expiration_date,'.>$!%*@=?&\''),left,right));
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT offenders_offender := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).offenders_dbo_offender_input(agency_offender_id <> '');
		
		bair.layouts.offenders_dbo_offender_Base tMapping(bair.layouts.offenders_dbo_offender_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			self.clean_dob 									:= ut.DateTimeToYYYYMMDD((string)L.dob);
			self.clean_RAIDS_activityDate 	:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.RAIDS_activityDate,'.>$!%*@=?&\''),left,right));
			self.clean_edit_date 						:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.edit_date,'.>$!%*@=?&\''),left,right));
			self.clean_user_datetime 				:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.user_datetime,'.>$!%*@=?&\''),left,right));	
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
		
	EXPORT offenders_picture := FUNCTION	
		baseFile := dedup(bair.Files('', pUseProd, false, pPrepped).offenders_dbo_picture_input(agency_offender_id <> ''), record, except id, all);
		
		bair.layouts.Offenders_dbo_offender_picture_Base tMapping(bair.layouts.Offenders_dbo_offender_picture_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;	
	
	EXPORT crash := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).crash_dbo_crash_input(case_number <> '');
		
		bair.layouts.crash_dbo_crash_Base tMapping(bair.layouts.crash_dbo_crash_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			self.clean_report_date 					:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.report_date,'.>$!%*@=?&\''),left,right));
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	
	EXPORT crash_person := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).crash_dbo_person_input(case_number <> '');
		
		bair.layouts.crash_dbo_person_Base tMapping(bair.layouts.crash_dbo_person_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	
	EXPORT crash_vehicle := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).crash_dbo_vehicle_input(case_number <> '');
		
		bair.layouts.crash_dbo_vehicle_Base tMapping(bair.layouts.crash_dbo_vehicle_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT lpr_licenseplateevent := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).lpr_dbo_licenseplateevent_input(EventNumber <> '');
		
		bair.layouts.lpr_dbo_LicensePlate_Base tMapping(bair.layouts.lpr_dbo_LicensePlate_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			self.clean_CaptureDateTime			:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.CaptureDateTime,'.>$!%*@=?&\''),left,right));
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	EXPORT gunop_shot_incident := FUNCTION	
		baseFile 					:= bair.Files('', pUseProd, false, pPrepped).gunop_dbo_shot_incident_input(shot_id <> '');
		
		bair.layouts.gunop_dbo_shot_Base tMapping(bair.layouts.gunop_dbo_shot_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)version;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)version;
			SELF.Dt_first_seen            	:= 0;
			SELF.Dt_last_seen             	:= 0;
			self.clean_shot_datetime				:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.shot_datetime,'.>$!%*@=?&\''),left,right));
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
		
END;
