IMPORT Foreclosure_Vacancy, dx_Property, ut, std;

EXPORT BatchService_Records(DATASET(Foreclosure_Services.Layouts.layout_batch_in) ds_xml_in = DATASET([],Foreclosure_Services.Layouts.layout_batch_in), boolean includeBlackKnight=false) := 
	FUNCTION
		
		UCase := STD.Str.ToUpperCase;

		//move AcctNo into UniqueID_in field
		Foreclosure_Services.Layouts.layout_batch_in addAcctNo(ds_xml_in l) := transform
			self.uniqueID := l.acctno;
			self := l;
		end;
		
		input_rec := project(ds_xml_in, addAcctNo(left));
		
		input_cleaned := 
			PROJECT(
				input_rec,
				TRANSFORM(Foreclosure_Vacancy.Layouts.in_clean,
					SELF.UniqueID_in       := LEFT.uniqueID,
					SELF.first_name_in     := UCase(LEFT.first_name),
					SELF.middle_initial_in := UCase(LEFT.middle_initial),
					SELF.last_name_in      := UCase(LEFT.last_name),
					SELF.street_address_in := '',
					SELF.apt_in            := UCase(LEFT.sec_range),
					SELF.city_in           := UCase(LEFT.p_city_name),
					SELF.state_in          := UCase(LEFT.st),
					SELF.zip_in            := UCase(LEFT.z5),
					SELF.zip4_in           := UCase(LEFT.zip4),
					SELF.prim_range        := UCase(LEFT.prim_range);
					SELF.predir            := UCase(LEFT.predir);
					SELF.prim_name         := UCase(LEFT.prim_name);
					SELF.suffix            := UCase(LEFT.addr_suffix);
					SELF.postdir           := UCase(LEFT.postdir);
					SELF.unit_desig        := '';
					SELF.sec_range         := UCase(LEFT.sec_range);
					SELF.p_city_name       := UCase(LEFT.p_city_name);
					SELF.st                := UCase(LEFT.st);
					SELF.zip               := UCase(LEFT.z5);
					SELF.zip4              := UCase(LEFT.zip4);
					SELF                   := LEFT,
					SELF                   := []
				)
			);
			
		//Get data
		byAddr := Foreclosure_Vacancy.getData(isRenewal:=TRUE).fn_Find_Foreclosure_By_Addr(input_cleaned, dx_Property.Key_Foreclosures_Addr,includeBlackKnight);
		byDid := Foreclosure_Vacancy.getData(isRenewal:=TRUE).fn_Find_Foreclosure_By_Did(ds_xml_in,includeBlackKnight);
		response := byAddr+ByDid;

		//Add Acct No back on linked via uniqueID
		Foreclosure_Services.Layouts.Final_Batch addAcctNoBack(input_cleaned l, response r) := transform
			self.acctno      := l.UniqueID_in;
			self             := r;
			self             := l;
			self             := [];
		end;

		final_pre := 
			JOIN(
				input_cleaned, response, 
				TRIM(LEFT.UniqueID_in,LEFT,RIGHT) = TRIM(RIGHT.fc_unique_id,LEFT,RIGHT),
				addAcctNoBack(LEFT, RIGHT),
				INNER
			);
		
		final_pre_dedup := DEDUP(final_pre, RECORD);

		// Add derived fields to support output layout requirements. Note that I did not name the fields.
		
		DEED_TYPE_PREFORECLOSURE    :=  'P';
		LIS_PENDENS                 :=  'L';
		NOTICE_OF_DEFAULT           :=  'N';
		RELEASE_OF_LIS_PENDENS      :=  'R';
		NOTICE_OF_TRUSTEES_SALE     := 'NT';
		DEED_IN_LIEU_OF_FORECLOSURE := 'DL';
		NOTICE_OF_DEFAULT_DOC       := 'ND';

		DEED_TYPE_FORECLOSURE       :=  'F';
		FORECLOSURE                 :=  'U';
		FINAL_JUDGMENT              :=  'F';
		MORTGAGE_FORECLOSURE_DEED   := 'MF';
		SHERIFFS_DEED               := 'SD';

		ALL_OTHER_DEED_TYPES        :=  'D';
		
		TODAY       := (STRING8)Std.Date.Today();

		layout_final_batch_plus := RECORD
			Foreclosure_Services.Layouts.Final_Batch;
			STRING1  foreclosure_type_flag;
			STRING70 deed_document_type_desc;
			STRING8  date_file_processed; // 'Today'
			STRING8  deed_recording_date;
			STRING12 foreclosure_type_age_flag;
		END;
		
		fn_get_foreclosure_type_flag(Foreclosure_Services.Layouts.Final_Batch le) := 
			FUNCTION
				foreclosure_type_flag :=
					MAP(
							le.DEED_EVENT_TYPE_CD IN [ LIS_PENDENS, NOTICE_OF_DEFAULT, RELEASE_OF_LIS_PENDENS ] 
								=> DEED_TYPE_PREFORECLOSURE,
							le.DEED_EVENT_TYPE_CD IN [ FORECLOSURE, FINAL_JUDGMENT ] 
								=> DEED_TYPE_FORECLOSURE,
							le.DOC_TYPE_CD        IN [ NOTICE_OF_TRUSTEES_SALE, DEED_IN_LIEU_OF_FORECLOSURE ] 
								=> DEED_TYPE_PREFORECLOSURE,
							le.DOC_TYPE_CD        IN [ MORTGAGE_FORECLOSURE_DEED, SHERIFFS_DEED ] 
								=> DEED_TYPE_FORECLOSURE,
							/* DEFAULT:...: */ 
									 ALL_OTHER_DEED_TYPES
						);
				RETURN foreclosure_type_flag;
			END;
		
		fn_get_foreclosure_type_age_flag(Foreclosure_Services.Layouts.Final_Batch le) := 
			FUNCTION
				days_apart := ut.DaysApart(le.cp_recording_dt,TODAY);
				
				foreclosure_type_age_flag :=
					MAP( 
				//		days_apart >= 999 => 'INVALID DATE',    //removed by request: bug 76060
						days_apart >  365 => 'OVER A YEAR',
						days_apart =  365 => '365 DAYS',
						days_apart >= 180 => '180 DAYS',
						days_apart >= 120 => '120 DAYS',
						days_apart >= 90  => '90 DAYS',
						days_apart >= 60  => '60 DAYS',
						'INVALID DATE'
					); 
				
				RETURN foreclosure_type_age_flag;
			END;
			
		results := 
			PROJECT( 
				final_pre_dedup, 
				TRANSFORM(
					layout_final_batch_plus,		
					SELF.foreclosure_type_flag     := fn_get_foreclosure_type_flag(LEFT),
					SELF.deed_document_type_desc   := LEFT.doc_type_desc,
					SELF.date_file_processed       := TODAY,
					SELF.foreclosure_type_age_flag := fn_get_foreclosure_type_age_flag(LEFT),
					SELF.deed_recording_date       := LEFT.cp_recording_dt,
					SELF := LEFT
				)
			);

		// restore unique id input
		RETURN SORT(JOIN(results,ds_xml_in,LEFT.acctno=RIGHT.acctno,
			TRANSFORM(layout_final_batch_plus,
				SELF.UniqueID_in:=RIGHT.UniqueID,
				SELF:=LEFT),LEFT OUTER), -deed_recording_date);
		
	END;