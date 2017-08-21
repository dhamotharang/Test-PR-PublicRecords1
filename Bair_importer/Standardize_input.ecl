IMPORT ut, mdr, tools, _validate, Address, Ut, lib_stringlib, _Control, business_header, Enclarity,
Header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, NID, AID;

EXPORT Standardize_input (string filedate, boolean pUseProd = false) := MODULE

	EXPORT cfs_2 := FUNCTION	
		baseFile 					:= Files(filedate, pUseProd).cfs_dbo_cfs_2_input;
		
		bair.layouts.cfs_dbo_cfs_2_Base tMapping(bair.layouts.cfs_dbo_cfs_2_In L) := TRANSFORM
			SELF.record_type								:= 'C';
			SELF.src												:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported 	:= (UNSIGNED4)filedate;
			SELF.dt_vendor_last_reported  	:= (UNSIGNED4)filedate;
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
	
	
	EXPORT event_mo := FUNCTION
		baseFile := Files(filedate, pUseProd).event_dbo_mo_input;
		
		bair.layouts.event_dbo_mo_Base tMapping(layouts.event_dbo_mo_In L) := TRANSFORM
			SELF.record_type							:= 'C';
			SELF.src											:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported := (UNSIGNED4)filedate;
			SELF.dt_vendor_last_reported  := (UNSIGNED4)filedate;
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
		baseFile := Files(filedate, pUseProd).event_dbo_persons_input;

		bair.layouts.event_dbo_persons_Base tMapping(layouts.event_dbo_persons_In L) := TRANSFORM
			SELF.record_type							:= 'C';
			SELF.src											:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported := (UNSIGNED4)filedate;
			SELF.dt_vendor_last_reported  := (UNSIGNED4)filedate;
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
		baseFile := Files(filedate, pUseProd).event_dbo_vehicle_input;

		bair.layouts.event_dbo_vehicle_Base tMapping(layouts.event_dbo_vehicle_In L) := TRANSFORM
			SELF.record_type							:= 'C';
			SELF.src											:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported := (UNSIGNED4)filedate;
			SELF.dt_vendor_last_reported  := (UNSIGNED4)filedate;
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
	
	
	
	EXPORT mo_udf := FUNCTION
		baseFile := Files(filedate, pUseProd).event_dbo_mo_udf_input;

		bair.layouts.event_dbo_mo_udf_Base tMapping(layouts.event_dbo_mo_udf_In L) := TRANSFORM
			SELF.record_type							:= 'C';
			SELF.src											:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported := (UNSIGNED4)filedate;
			SELF.dt_vendor_last_reported  := (UNSIGNED4)filedate;
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
		baseFile := Files(filedate, pUseProd).event_dbo_persons_udf_input;

		bair.layouts.event_dbo_persons_udf_Base tMapping(layouts.event_dbo_persons_udf_In L) := TRANSFORM
			SELF.record_type							:= 'C';
			SELF.src											:= mdr.sourceTools.src_Bair_Analytics;//'64';
			SELF.dt_vendor_first_reported := (UNSIGNED4)filedate;
			SELF.dt_vendor_last_reported  := (UNSIGNED4)filedate;
			SELF.Dt_first_seen            := 0;
			SELF.Dt_last_seen             := 0;
			self.clean_datetime_val 			:= (UNSIGNED4)ut.DateTimeToYYYYMMDD((string)trim(stringlib.stringfilterout(L.datetime_val,'.>$!%*@=?&\''),left,right));
			SELF := L;
			SELF := [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));
		return dStd;
		
	END;
	
	
		
END;
