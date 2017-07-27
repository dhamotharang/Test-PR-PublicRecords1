Import iesp, address, ABMS, AutoStandardI;
EXPORT ABMS_Functions := Module
	shared myLayout := Healthcare_Provider_Services.ABMS_Layouts;
	shared myConst := Healthcare_Provider_Services.ABMS_Constants;

	EXPORT removeLeadingZeros(String inputStr) := FUNCTION
		removeZero := stringlib.StringFilter(stringlib.StringToUpperCase(inputStr),'123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		findStart := stringlib.StringFind(stringlib.StringToUpperCase(inputStr),removeZero[1],1);
		result := inputStr[findStart..];
		RETURN result;
	END;

	export cleanInputName(string inName) := function
		return Address.CleanNameFields(Address.CleanPerson73(inName)).CleanNameRecord;
	end;
	export processNameInput(iesp.share.t_Name inRec) := function
		doClnName := inRec.Full <> '';
		clnName := cleanInputName(inRec.Full);
		returnVal := project(inRec, transform(myLayout.PersonLayout, 
																					self.Full:=inRec.Full;
																					self.FirstName:=if(doClnName,clnName.fname,inRec.First);
																					self.MiddleName:=if(doClnName,clnName.mname,inRec.Middle);
																					self.LastName:=if(doClnName,clnName.lname,inRec.Last);
																					self.Suffix:=if(doClnName,clnName.name_suffix,inRec.Suffix)));
		return returnVal;
	end;
	export getCity(string city, string zip) := function
		return If(city ='' and zip ='', 'ANYTOWN',city);
	end;
	export cleanInputAddress(string street1, string street2, string city, string state, string zip) := function
		return Address.CleanFields(Address.GetCleanAddress(street1+street2,city+' '+state+' '+zip,address.Components.Country.US).str_addr);
	end;
	export processAddressInput(iesp.share.t_Address inAddr) := function
		doClnAddr := inAddr.StreetAddress1 <> '';
		clnTmpCity := getCity(inAddr.city,inAddr.zip5);
		ClnAddr := cleanInputAddress(inAddr.StreetAddress1,inAddr.StreetAddress2,clnTmpCity,inAddr.state,inAddr.zip5);
		returnVal := Project(inAddr, Transform(myLayout.AddressLayout,
																					 self.address1:= inAddr.StreetAddress1;
																					 self.address2:= inAddr.StreetAddress2;
																					 self.prim_range:= if(doClnAddr,ClnAddr.prim_range,inAddr.StreetNumber);
																					 self.predir:= if(doClnAddr,ClnAddr.predir,inAddr.StreetPreDirection);
																					 self.prim_name:= if(doClnAddr,ClnAddr.prim_name,inAddr.StreetName);
																					 self.addr_suffix:= if(doClnAddr,ClnAddr.addr_suffix,inAddr.StreetSuffix);
																					 self.postdir:= if(doClnAddr,ClnAddr.postdir,inAddr.StreetPostDirection);
																					 self.unit_desig:= if(doClnAddr,ClnAddr.unit_desig,inAddr.UnitDesignation);
																					 self.sec_range:= if(doClnAddr,ClnAddr.sec_range,inAddr.UnitNumber);
																					 self.p_city_name:= if(doClnAddr,if(ClnAddr.p_city_name='ANYTOWN','',ClnAddr.p_city_name),inAddr.city);
																					 self.st:= inAddr.state;
																					 self.z5:= inAddr.zip5));
		return returnVal;
	end;
	export doPenalty(recordof(ABMS.Keys().Main.BIOGNumber.qa) inRec, ABMS_Layouts.searchKeyResults inCriteria) := function
		gm:=AutoStandardI.GlobalModule();
		tempindvmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))						
			EXPORT lastname       := inCriteria.Name_last;       // the 'input' last name
			EXPORT middlename     := inCriteria.name_middle;     // the 'input' middle name
			EXPORT firstname      := inCriteria.name_first;      // the 'input' first name
			EXPORT allow_wildcard := FALSE;
			EXPORT useGlobalScope := FALSE;									
			EXPORT lname_field    := inRec.clean_name.lname;			// matching record name information			                          
			EXPORT mname_field    := inRec.clean_name.mname; 
			EXPORT fname_field    := inRec.clean_name.fname;	
		END;	
	
		namePenaltyRaw := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod);							 					 					 
		namePenalty := if(inCriteria.Specialty<>'' and namePenaltyRaw>0,namePenaltyRaw+5,namePenaltyRaw);//If it was a record with a specialty it could have partial matches push the non-exact match penalty higher

		tempaddrmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
			EXPORT predir         := inCriteria.predir;
			EXPORT prim_name      := inCriteria.prim_name;
			EXPORT prim_range     := inCriteria.prim_range;
			EXPORT postdir        := inCriteria.postdir;
			EXPORT addr_suffix    := inCriteria.addr_suffix;
			EXPORT sec_range      := inCriteria.sec_range;
			EXPORT p_city_name    := inCriteria.p_city_name;
			EXPORT st             := inCriteria.st;
			EXPORT z5             := inCriteria.z5;											
			//	The address in the matching record:						
			EXPORT allow_wildcard  := FALSE;															
			EXPORT city_field      := inRec.clean_company_address.p_city_name;
			EXPORT city2_field     := '';										
			EXPORT pname_field     := inRec.clean_company_address.prim_name;									
			EXPORT prange_field    := inRec.clean_company_address.prim_range;										
			EXPORT postdir_field   := inRec.clean_company_address.postdir;																				
			EXPORT predir_field    := inRec.clean_company_address.predir;									
			EXPORT state_field     := inRec.clean_company_address.st;										
			EXPORT suffix_field    := inRec.clean_company_address.addr_suffix;										
			EXPORT zip_field       := inRec.clean_company_address.zip;											
			EXPORT sec_range_field := inRec.clean_company_address.sec_range;
			EXPORT useGlobalScope  := FALSE;
		end;
		addrPenalty:=AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);
		
		NPIPenalty := if(inCriteria.NPI='' or inCriteria.NPI=inRec.NPI, 0, 2);
		penaltyVal := namePenalty+addrPenalty+NPIPenalty;
		return penaltyVal;
	end;

	export appendTypeOfPractice(dataset(ABMS_Layouts.LayoutOutput) inRecs) := function
		myTop := join(InRecs,ABMS.Keys().TypeOfPractice.BIOGNumber.qa,left.abmsbiogid=right.biog_number,
											Transform(ABMS_Layouts.LayoutTypeOfPractice, 
																self.acctno := left.accountnumber;
																self.abmsbiogid := left.abmsbiogid;
																self.RecordType := right.record_type;
																self.TypeOfPractice := right.type_of_practice;
																self.OtherInfo := right.other_text;
																self.DateFirstReported := iesp.ECL2ESP.toDate(right.dt_vendor_first_reported);
																self.DateLastReported := iesp.ECL2ESP.toDate(right.dt_vendor_last_reported)),
											keep(iesp.constants.HPR.Max_ABMS_TypeOfPractice),limit(0));
		ABMS_Layouts.LayoutTypeOfPracticeDS doRollup(ABMS_Layouts.LayoutTypeOfPractice l, dataset(ABMS_Layouts.LayoutTypeOfPractice) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.abmsbiogid := l.abmsbiogid;
			self.childinfo := choosen(project(r,iesp.abms.t_ABMSTypeOfPractice),iesp.constants.HPR.Max_ABMS_TypeOfPractice);
		END;
		topDS := rollup(group(sort(myTop,acctno,abmsbiogid,-DateLastReported),acctno,abmsbiogid),group,doRollup(left,rows(left)));
		recs := join(InRecs,topDS,left.accountnumber=right.acctno and left.abmsbiogid = right.abmsbiogid,
											Transform(ABMS_Layouts.LayoutOutput,
																self.TypeOfPractices := right.childinfo;
																self := left;),left outer,
											keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		return recs;
	end;
	export appendCertificates(dataset(ABMS_Layouts.LayoutOutput) inRecs) := function
		myCerts := join(InRecs,ABMS.Keys().Cert.BIOGNumber.qa,left.abmsbiogid=right.biog_number,
											Transform(ABMS_Layouts.LayoutCertificates, 
																self.acctno := left.accountnumber;
																self.abmsbiogid := left.abmsbiogid;
																self.RecordType := right.record_type;
																self.Seq := right.biog_cert_id;
																self.CertificateName := right.cert_name;
																self.IssuingBoard := right.board_web_desc;
																self.CertificateTypeID := right.cert_id;
																self.CertificateType := right.cert_type_ind_desc;
																self.RecertificateInd := right.recert_ind_desc;
																self.BoardCertified := right.board_certified;
																self.IssueDate := if(right.cert_date <> '',iesp.ECL2ESP.toDatestring8(right.cert_date),iesp.ECL2ESP.toDatestring8(right.cert_year+right.cert_month+right.cert_day));
																self.ExpireDate := if(right.expiration_date <> '',iesp.ECL2ESP.toDatestring8(right.expiration_date),iesp.ECL2ESP.toDatestring8(right.expiration_year+right.expiration_month+right.expiration_day));
																self.ReverificationDate := if(right.reverification_date <> '',iesp.ECL2ESP.toDatestring8(right.reverification_date),iesp.ECL2ESP.toDatestring8(right.reverification_year+right.reverification_month+right.reverification_day));
																self.DurationType := right.duration_type;
																self.DurationTypeDesc := right.duration_type_desc;
																self.MOCPathwayid := right.mocpathway_id;
																self.MOCPathwayName := right.mocpathway_name;
																self.DateFirstReported := iesp.ECL2ESP.toDate(right.dt_vendor_first_reported);
																self.DateLastReported := iesp.ECL2ESP.toDate(right.dt_vendor_last_reported)),
											keep(iesp.constants.HPR.Max_ABMS_Certications),limit(0));
		ABMS_Layouts.LayoutCertificatesDS doRollup(ABMS_Layouts.LayoutCertificates l, dataset(ABMS_Layouts.LayoutCertificates) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.abmsbiogid := l.abmsbiogid;
			self.childinfo := choosen(project(r,iesp.abms.t_ABMSCertificate),iesp.constants.HPR.Max_ABMS_Certications);
		END;
		myCertIDsWithMatchingSpecialty := dedup(sort(join(InRecs,myCerts,left.accountnumber=right.acctno and left.abmsbiogid=right.abmsbiogid and (left.specialty=right.CertificateName or left.specialty = ''),Transform(ABMS_Layouts.LayoutCertificates,self:=right),keep(myConst.MAX_RECS_ON_JOIN),limit(0)),acctno,abmsbiogid),acctno,abmsbiogid);
		myCertIDsToKeep := join(myCerts,myCertIDsWithMatchingSpecialty,left.acctno=right.acctno and left.abmsbiogid=right.abmsbiogid,Transform(ABMS_Layouts.LayoutCertificates,self:=left),keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		CertsDS := rollup(group(sort(myCertIDsToKeep,acctno,abmsbiogid,-ReverificationDate,-ExpireDate,-IssueDate),acctno,abmsbiogid),group,doRollup(left,rows(left)));
		inRecsToKeep := join(InRecs,myCertIDsWithMatchingSpecialty,left.accountnumber=right.acctno and left.abmsbiogid=right.abmsbiogid,Transform(ABMS_Layouts.LayoutOutput,self:=left),keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		recs := join(inRecsToKeep,CertsDS,left.accountnumber=right.acctno and left.abmsbiogid = right.abmsbiogid,
											Transform(ABMS_Layouts.LayoutOutput,
																self.Certifications := right.childinfo;
																self := left;),left outer,
											keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		return recs;
	end;
	export appendBatchCertificates(dataset(ABMS_Layouts.LayoutOutput) inRecs) := function
		rawCerts := join(InRecs,ABMS.Keys().Cert.BIOGNumber.qa,left.abmsbiogid=right.biog_number,
											Transform(ABMS_Layouts.LayoutCertificates, 
																self.acctno := left.accountnumber;
																self.abmsbiogid := left.abmsbiogid;
																self.RecordType := right.record_type;
																self.Seq := right.biog_cert_id;
																self.CertificateName := right.cert_name;
																self.IssuingBoard := right.board_web_desc;
																self.CertificateTypeID := right.cert_id;
																self.CertificateType := right.cert_type_ind_desc;
																self.RecertificateInd := right.recert_ind_desc;
																self.BoardCertified := right.board_certified;
																self.IssueDate := iesp.ECL2ESP.toDatestring8(right.cert_date);
																self.ExpireDate := iesp.ECL2ESP.toDatestring8(right.expiration_date);
																self.ReverificationDate := iesp.ECL2ESP.toDatestring8(right.reverification_date);
																self.DurationType := right.duration_type;
																self.DurationTypeDesc := right.duration_type_desc;
																self.MOCPathwayid := right.mocpathway_id;
																self.MOCPathwayName := right.mocpathway_name;
																self.DateFirstReported := iesp.ECL2ESP.toDate(right.dt_vendor_first_reported);
																self.DateLastReported := iesp.ECL2ESP.toDate(right.dt_vendor_last_reported);
																self := []),
											keep(iesp.constants.HPR.Max_ABMS_Certications),limit(0));
		parentCerts := sort(rawCerts(CertificateType<>'S'),acctno,abmsbiogid,-ReverificationDate,-ExpireDate,-IssueDate);
		subCerts := sort(rawCerts(CertificateType='S'),acctno,abmsbiogid,-ReverificationDate,-ExpireDate,-IssueDate);
		myCerts := join(parentCerts,subCerts,left.acctno=right.acctno and left.abmsbiogid=right.abmsbiogid 
															and left.issuingboard=right.issuingboard,
															transform(ABMS_Layouts.LayoutCertificatesBatch,self.seq:=right.seq;self.SubSpecialty:=right;self:=left),left outer);
		ABMS_Layouts.LayoutCertificatesDSBatch doRollup(ABMS_Layouts.LayoutCertificatesBatch l, dataset(ABMS_Layouts.LayoutCertificatesBatch) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.abmsbiogid := l.abmsbiogid;
			self.childinfo := choosen(project(r,ABMS_Layouts.LayoutCertificatesBatch),iesp.constants.HPR.Max_ABMS_Certications);
		END;
		CertsDS := rollup(group(sort(myCerts,acctno,abmsbiogid,-seq),acctno,abmsbiogid),group,doRollup(left,rows(left)));
		recs := join(InRecs,CertsDS,left.accountnumber=right.acctno and left.abmsbiogid = right.abmsbiogid,
											Transform(ABMS_Layouts.LayoutOutputBatch,
																self.BatchCertifications := project(right.childinfo,ABMS_Layouts.LayoutCertificatesBatch);
																self := left;),left outer,
											keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		return recs;
	end;
	export appendCareer(dataset(ABMS_Layouts.LayoutOutput) inRecs) := function
		myCareer := join(InRecs,ABMS.Keys().Career.BIOGNumber.qa,left.abmsbiogid=right.biog_number,
											Transform(ABMS_Layouts.LayoutCareer, 
																self.acctno := left.accountnumber;
																self.abmsbiogid := left.abmsbiogid;
																self.RecordType := right.record_type;
																self.Seq := (string)right.occurrence_number;
																self.Organization := right.organization;
																self.Specialty := right.specialty;
																self.Position := right.position;
																self.CareerType := right.career_type;
																self.CareerTypeDesc := right.career_type_desc;
																self.FromYear := right.from_year;
																self.ToYear := right.to_year;
																self.City := right.city;
																self.State := right.state;
																self.Country := right.nation;
																self.DateFirstReported := iesp.ECL2ESP.toDate(right.dt_vendor_first_reported);
																self.DateLastReported := iesp.ECL2ESP.toDate(right.dt_vendor_last_reported)),
											keep(iesp.constants.HPR.Max_ABMS_Career),limit(0));
		ABMS_Layouts.LayoutCareerDS doRollup(ABMS_Layouts.LayoutCareer l, dataset(ABMS_Layouts.LayoutCareer) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.abmsbiogid := l.abmsbiogid;
			self.childinfo := choosen(project(r,iesp.abms.t_ABMSCareer),iesp.constants.HPR.Max_ABMS_Career);
		END;
		careerDS := rollup(group(sort(myCareer,acctno,abmsbiogid,-ToYear,-FromYear,-(integer)Seq),acctno,abmsbiogid),group,doRollup(left,rows(left)));
		recs := join(InRecs,careerDS,left.accountnumber=right.acctno and left.abmsbiogid=right.abmsbiogid,
											Transform(ABMS_Layouts.LayoutOutput,
																self.CareerHistory := right.childinfo;
																self := left;),left outer,
											keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		return recs;
	end;
	export appendEducation(dataset(ABMS_Layouts.LayoutOutput) inRecs) := function
		myEducation := join(InRecs,ABMS.Keys().Education.BIOGNumber.qa,left.abmsbiogid=right.biog_number,
											Transform(ABMS_Layouts.LayoutEducation, 
																self.acctno := left.accountnumber;
																self.abmsbiogid := left.abmsbiogid;
																self.RecordType := right.record_type;
																self.Seq := (string)right.occurrence_number;
																self.Degree := right.degree;
																self.SchoolCode := right.abms_school_code;
																self.School := if(right.abms_school_code_desc <> '',right.abms_school_code_desc,right.school);
																self.Years := right.Years;
																self.City := right.city;
																self.State := right.state;
																self.Country := right.country;
																self.DateFirstReported := iesp.ECL2ESP.toDate(right.dt_vendor_first_reported);
																self.DateLastReported := iesp.ECL2ESP.toDate(right.dt_vendor_last_reported)),
											keep(iesp.constants.HPR.Max_ABMS_Education),limit(0));
		ABMS_Layouts.LayoutEducationDS doRollup(ABMS_Layouts.LayoutEducation l, dataset(ABMS_Layouts.LayoutEducation) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.abmsbiogid := l.abmsbiogid;
			self.childinfo := choosen(project(r,iesp.abms.t_ABMSEducation),iesp.constants.HPR.Max_ABMS_Education);
		END;
		educationDS := rollup(group(sort(myEducation,acctno,abmsbiogid,-Years,-(integer)Seq),acctno,abmsbiogid),group,doRollup(left,rows(left)));
		recs := join(InRecs,educationDS,left.accountnumber=right.acctno and left.abmsbiogid=right.abmsbiogid,
											Transform(ABMS_Layouts.LayoutOutput,
																self.EducationHistory := right.childinfo;
																self := left;),left outer,
											keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		return recs;
	end;
	export appendMembership(dataset(ABMS_Layouts.LayoutOutput) inRecs) := function
		myMembership := join(InRecs,ABMS.Keys().Membership.BIOGNumber.qa,left.abmsbiogid=right.biog_number,
											Transform(ABMS_Layouts.LayoutProfessionalAssociation, 
																self.acctno := left.accountnumber;
																self.abmsbiogid := left.abmsbiogid;
																self.RecordType := right.record_type;
																self.Organization := right.member_of;
																self.PositionHeldYears := right.position_held_years;
																self.DateFirstReported := iesp.ECL2ESP.toDate(right.dt_vendor_first_reported);
																self.DateLastReported := iesp.ECL2ESP.toDate(right.dt_vendor_last_reported)),
											keep(iesp.constants.HPR.Max_ABMS_Prof_Assoc),limit(0));
		ABMS_Layouts.LayoutProfessionalAssociationDS doRollup(ABMS_Layouts.LayoutProfessionalAssociation l, dataset(ABMS_Layouts.LayoutProfessionalAssociation) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.abmsbiogid := l.abmsbiogid;
			self.childinfo := choosen(project(r,iesp.abms.t_ABMSProfessionalAssociation),iesp.constants.HPR.Max_ABMS_Prof_Assoc);
		END;
		MembershipDS := rollup(group(sort(myMembership,acctno,abmsbiogid,-DateLastReported),acctno,abmsbiogid),group,doRollup(left,rows(left)));
		recs := join(InRecs,MembershipDS,left.accountnumber=right.acctno and left.abmsbiogid=right.abmsbiogid,
											Transform(ABMS_Layouts.LayoutOutput,
																self.ProfessionalAssociations := right.childinfo;
																self := left;),left outer,
											keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		return recs;
	end;

	export appendOptionalData(dataset(ABMS_Layouts.LayoutOutput) inRecs, dataset(ABMS_Layouts.autokeyInput) inputData) := function
		appendCareerRecs := inputData(includeCareer=true);
		recToAppendCareer := join(inRecs,appendCareerRecs,left.accountnumber=right.acctno,
																		Transform(ABMS_Layouts.LayoutOutput,self := left;),
																		keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		recsWithCareer := join(inRecs,appendCareer(recToAppendCareer),
																	left.accountnumber=right.accountnumber and 
																	left.abmsbiogid=right.abmsbiogid,
																	Transform(ABMS_Layouts.LayoutOutput,self.CareerHistory := right.CareerHistory, self := left;),left outer,
																	keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		appendEducationRecs := inputData(includeEducation=true);
		recToAppendEducation := join(inRecs,appendEducationRecs,left.accountnumber=right.acctno,
																		Transform(ABMS_Layouts.LayoutOutput,self := left;),
																		keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		recsWithEducation := join(recsWithCareer,appendEducation(recToAppendEducation),
																	left.accountnumber=right.accountnumber and 
																	left.abmsbiogid=right.abmsbiogid,
																	Transform(ABMS_Layouts.LayoutOutput,self.EducationHistory := right.EducationHistory, self := left;),left outer,
																	keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		appendProfessionalAssociationRecs := inputData(includeProfessionalAssociations=true);
		recToAppendMembership := join(inRecs,appendProfessionalAssociationRecs,left.accountnumber=right.acctno,
																		Transform(ABMS_Layouts.LayoutOutput,self := left;),
																		keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		recsWithMembership := join(recsWithEducation,appendMembership(recToAppendMembership),
																	left.accountnumber=right.accountnumber and 
																	left.abmsbiogid=right.abmsbiogid,
																	Transform(ABMS_Layouts.LayoutOutput,self.ProfessionalAssociations := right.ProfessionalAssociations, self := left;),left outer,
																	keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		return recsWithMembership;
	end;
END;
