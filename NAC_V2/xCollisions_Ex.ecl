import ut, header, std;

export NAC_v2.Layout_Collisions2.Layout_Collisions xCollisions_Ex(NAC_v2.Layout_Base2_ex l, NAC_v2.Layout_Base2_Ex r,
						unsigned1 priority_, set of string1 matchset) := transform, SKIP(l.PrepRecSeq=r.PrepRecSeq)
			// sort collumns for intra-state collisions.  this will aid dedupe in NAC.Mod_Collisions
			fn_left(string le, string ri):= 
				function
				return map(l.ProgramState <> r.ProgramState => le
											,l.GroupId <> l.GroupId => le
											,l.CaseId > r.CaseId => ri	// intrastate case ids must be different
									 ,le);
			end;
			fn_right(string le, string ri) := function
				return map(l.ProgramState <> r.ProgramState => ri
										,l.GroupId <> l.GroupId => ri
										,l.CaseId > r.CaseId => le			
										,ri);
			end;

			self.pri:=priority_;

			self.MatchCodes
				:= if((l.fname=r.fname
						or l.fname=r.FirstName
						or l.FirstName=r.FirstName
						or l.fname=r.prefname
						or l.prefname=r.FirstName
						or l.prefname=r.prefname)
						and
						(l.lname=r.lname
						or l.LastName=r.LastName
						or l.lname=r.LastName),'N',
						
						if((l.lname=r.lname
							or l.lname=r.LastName
							or l.LastName=r.LastName)
							and
							(l.fname<>r.fname
							or l.fname<>r.prefname)
							and
							(l.fname[1]=r.fname[1]
							or l.fname[1]=r.FirstName[1]
							or l.FirstName[1]=r.FirstName[1]
							or l.fname[1]=r.prefname[1]
							or l.prefname[1]=r.FirstName[1]
							or l.prefname[1]=r.prefname[1]),'V',
							if(l.lname=r.lname
								or l.LastName=r.LastName
								or l.lname=r.LastName,'W','')))

					+if((unsigned)l.Clean_ssn>0 and (unsigned)r.Clean_ssn>0 and l.Clean_ssn=r.Clean_ssn,'S',
						if((unsigned)l.Clean_ssn>0 and (unsigned)r.Clean_ssn>0 and ssn_value(l.Clean_ssn,r.Clean_ssn) > 0,'P',''))

					+if((unsigned)l.clean_dob>0 and	(unsigned)r.clean_dob>0 and	l.clean_dob=r.clean_dob,'D',
								//dob_near(l.clean_dob, r.clean_dob),
						if(gens_ok(l.name_suffix,l.clean_dob,r.name_suffix,r.clean_dob) and
									(unsigned)l.clean_dob>0 and	(unsigned)r.clean_dob>0 and
									(header.sig_near_dob(l.clean_dob,r.clean_dob) or header.date_value(l.clean_dob,r.clean_dob) > 1),'B',''))

					+if(l.prim_name<>'' and	r.prim_name<>'' and	l.prim_name=r.prim_name and	l.prim_range=r.prim_range,'A','')

					+if(l.v_city_name<>'' and r.v_city_name<>'' and	l.st<>'' and	r.st<>'' and	l.v_city_name=r.v_city_name and	l.st=r.st,'C','')

					+if(l.zip<>'' and	r.zip<>'' and	l.zip=r.zip,'Z','');

			self.MatchSet := 	TRANSFER(matchset, string);	//		self.matchset;

			self.LexID:=if('L' in matchset,l.did,0);
			self.LexIdScore:=intformat(if('L' in matchset,l.did_score,0),3,1);
			self.ActivityType := '4';
			//self.BuildVersion := (string)l.ProcessDate;
			self.BuildVersion := Std.Date.DateToString(Std.Date.CurrentDate(false), '%Y%m%d');
			self.BenefitState := fn_left(l.ProgramState,r.ProgramState);
			self.SearchGroupId := fn_left(l.GroupId,r.GroupId);
			self.StartDate := (string8)MAX(l.StartDate,r.StartDate);
			self.EndDate := (string8)MIN(l.EndDate,r.EndDate);

			self.SearchCaseID := fn_left(l.CaseId,r.CaseId);
			self.SearchClientID := fn_left(l.ClientId,r.ClientId);
			self.SearchBenefitType := fn_left(l.ProgramCode,r.ProgramCode);
			//self.SearchBenefitMonth := fn_left(l.Case_Benefit_Month,r.Case_Benefit_Month);
			self.SearchStartDate := fn_left((string8)l.StartDate,(string8)r.StartDate);
			self.SearchEndDate := fn_left((string8)l.EndDate,(string8)r.EndDate);
			self.SearchLastName := fn_left(l.LastName,r.LastName);
			self.SearchFirstName := fn_left(l.FirstName,r.FirstName);
			self.SearchMiddleName := fn_left(l.MiddleName,r.MiddleName);
			self.SearchSSN := fn_left(l.SSN,r.SSN);
			self.SearchDOB := fn_left(l.DOB,r.DOB);
			self.SearchEligibilityDate := fn_left(l.eligibility_status_date,r.eligibility_status_date);
			self.SearchEligibilityStatus := fn_left(l.eligibility_status_indicator,r.eligibility_status_indicator);
			self.SearchAddress1StreetAddress1 := fn_left(l.Physical_Street1,r.Physical_Street1);
			self.SearchAddress1StreetAddress2 := fn_left(l.Physical_Street2,r.Physical_Street2);
			self.SearchAddress1City := fn_left(l.Physical_City,r.Physical_City);
			self.SearchAddress1State := fn_left(l.Physical_State,r.Physical_State);
			self.SearchAddress1Zip := fn_left(l.Physical_Zip,r.Physical_Zip);
			self.SearchAddress2StreetAddress1 := fn_left(l.Mailing_Street1,r.Mailing_Street1);
			self.SearchAddress2StreetAddress2 := fn_left(l.Mailing_Street2,r.Mailing_Street2);
			self.SearchAddress2City := fn_left(l.Mailing_City,r.Mailing_City);
			self.SearchAddress2State := fn_left(l.Mailing_State,r.Mailing_State);
			self.SearchAddress2Zip := fn_left(l.Mailing_Zip,r.Mailing_Zip);
			self.SearchSequenceNumber := fn_left((string)l.PrepRecSeq,(string)r.PrepRecSeq);
			self.OrigSearchSequenceNumber := (unsigned)fn_left((string)l.PrepRecSeq,(string)r.PrepRecSeq);
			self.SearchNCFFileDate := (unsigned)fn_left((string)l.NCF_FileDate,(string)r.NCF_FileDate);
			self.SearchProcessDate := (unsigned)fn_left((string)l.ProcessDate,(string)r.ProcessDate);

			self.CaseState := fn_right(l.ProgramState,r.ProgramState);
			self.CaseGroupId := fn_right(l.GroupId,r.GroupId);
			self.CaseBenefitType := fn_right(l.ProgramCode,r.ProgramCode);
//			self.CaseBenefitMonth := fn_right(l.Case_Benefit_Month,r.Case_Benefit_Month);
			self.CaseStartDate := fn_right((string8)l.StartDate,(string8)r.StartDate);
			self.CaseEndDate := fn_right((string8)l.EndDate,(string8)r.EndDate);
			self.CaseID := fn_right(l.CaseId,r.CaseId);
			self.CaseLastName := fn_right(l.Case_Last_Name,r.Case_Last_Name);
			self.CaseFirstName := fn_right(l.Case_First_Name,r.Case_First_Name);
			self.CaseMiddleName := fn_right(l.Case_Middle_Name,r.Case_Middle_Name);
			self.CaseSuffixName := fn_right(l.case_Name_Suffix,r.case_Name_Suffix);
			self.CasePhone1 := fn_right(l.case_Phone1,r.case_Phone1);
			self.CasePhone2 := fn_right(l.case_Phone2,r.case_Phone2);
			self.CaseEmail := fn_right(l.case_Email,r.case_Email);
			self.CasePhysicalStreet1 := fn_right(l.Physical_Street1,r.Physical_Street1);
			self.CasePhysicalStreet2 := fn_right(l.Physical_Street2,r.Physical_Street2);
			self.CasePhysicalCity := fn_right(l.Physical_City,r.Physical_City);
			self.CasePhysicalState := fn_right(l.Physical_State,r.Physical_State);
			self.CasePhysicalZip := fn_right(l.Physical_Zip,r.Physical_Zip);
			self.CaseMailStreet1 := fn_right(l.Mailing_Street1,r.Mailing_Street1);
			self.CaseMailStreet2 := fn_right(l.Mailing_Street2,r.Mailing_Street2);
			self.CaseMailCity := fn_right(l.Mailing_City,r.Mailing_City);
			self.CaseMailState := fn_right(l.Mailing_State,r.Mailing_State);
			self.CaseMailZip := fn_right(l.Mailing_Zip,r.Mailing_Zip);
			self.CaseCountyParishCode := fn_right(l.CountyCode,r.CountyCode);
			self.CaseCountyParishName := fn_right(l.CountyName,r.CountyName);
			self.ClientID := fn_right(l.ClientId,r.ClientId);
			self.ClientLastName := fn_right(l.LastName,r.LastName);
			self.ClientFirstName := fn_right(l.FirstName,r.FirstName);
			self.ClientMiddleName := fn_right(l.MiddleName,r.MiddleName);
			self.ClientGender := fn_right(l.Gender,r.Gender);
			self.ClientRace := fn_right(l.Race,r.Race);
			self.ClientEthnicity := fn_right(l.Ethnicity,r.Ethnicity);
			self.ClientSSN := fn_right(l.SSN,r.SSN);
			self.ClientSSNType := fn_right(l.ssn_Type_indicator,r.ssn_Type_indicator);
			self.ClientDOB := fn_right(l.DOB,r.DOB);
			self.ClientDOBType := fn_right(l.dob_Type_indicator,r.dob_Type_indicator);
			self.ClientEligibilityStatus := fn_right(l.eligibility_status_indicator,r.eligibility_status_indicator);
			self.ClientEligibilityDate := fn_right(l.eligibility_status_date,r.eligibility_status_date);
			self.ClientPhone := fn_right(l.client_Phone,r.client_Phone);
			self.ClientEmail := fn_right(l.client_Email,r.client_Email);
			self.StateContactName := fn_right(l.ContactName,r.ContactName);
			self.StateContactPhone := fn_right(l.ContactPhone,r.ContactPhone);
			self.StateContactPhoneExtension := fn_right(l.ContactExt,r.ContactExt);
			self.StateContactEmail := fn_right(l.ContactEmail,r.ContactEmail);
			self.ClientSequenceNumber := fn_right((string)l.PrepRecSeq,(string)r.PrepRecSeq);
			//self.ClientSequenceNumber := l.BenefitMonth;
			self.OrigClientSequenceNumber := (unsigned)fn_right((string)l.PrepRecSeq,(string)r.PrepRecSeq);
			self.ClientNCFFileDate := (unsigned)fn_right((string)l.NCF_FileDate,(string)r.NCF_FileDate);
			self.ClientProcessDate := (unsigned)fn_right((string)l.ProcessDate,(string)r.ProcessDate);
			/*
			self.SearchCleanSSN := fn_left(l.Clean_ssn,r.Clean_ssn);
			self.ClientCleanSSN := fn_right(l.Clean_ssn,r.Clean_ssn);
			self.SearchCleanDOB := fn_left((string)l.Clean_Dob,(string)r.Clean_Dob);
			self.ClientCleanDOB := fn_right((string)l.Clean_Dob,(string)r.Clean_Dob);
			//
			self.SearchFName := fn_left(l.fname,r.fname);
			self.ClientFName := fn_right(l.fname,r.fname);
			self.SearchPrefName := fn_left(l.prefname,r.prefname);
			self.ClientPrefName := fn_right(l.prefname,r.prefname);
			self.SearchNameSuffix := fn_left(l.name_suffix,r.name_suffix);
			self.ClientNameSuffix := fn_right(l.name_suffix,r.name_suffix);
			*/
			self:=l;
	end;
