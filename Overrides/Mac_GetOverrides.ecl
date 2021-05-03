EXPORT Mac_GetOverrides(ds_input, dsOut) := MACRO
IMPORT _Control,iesp;

	service_name	:= 'ConsumerDisclosure.FCRADataService';
	serviceURL		:= _Control.RoxieEnv.staging_fcra_roxieIP ;

	nodes			:= 50;
	threads			:= 2;

	layout_in   := iesp.fcradataservice.t_FcraDataServiceRequest;
	layout_out  := iesp.fcradataservice.t_FcraDataServiceReportResponse;

	layoutSoap := record
		dataset(layout_in) fcradataservicerequest;
	end;

	layout_in make_child_ds(ds_input L) := TRANSFORM
		SELF.Options.ReturnSuppressedRecords := true;
		SELF.Options.ReturnOverwrittenRecords := true;
		SELF.Options.DatasetSelection.IncludeAll := true;
		SELF.ReportBy.lexid := (STRING) L.did;
		SELF := L;
		SELF := [];
	END;

	layoutSoap trans(ds_input L) := TRANSFORM
		request := PROJECT(L, make_child_ds(LEFT));
		SELF.fcradataservicerequest := request;
		self := L;
	END;

	soap_input := DISTRIBUTE(PROJECT(dedup(sort(ds_input, did), did), trans(LEFT)),RANDOM() % nodes);

	xlayout := RECORD
		layout_out;
		STRING errorcode;
	END;

	xlayout myFail(soap_input le) := TRANSFORM
		SELF.errorcode := FAILCODE +'  '+ FAILMESSAGE;
		SELF := [];
	END;

	soapResponse := soapcall( soap_input,
							serviceURL,
							service_name,
							{soap_input},
							DATASET(xlayout),
							PARALLEL(threads),
							onFail(myFail(LEFT))
							):independent
							;
	r :=	{
		soapResponse.results.headerdata.Metadata.LexID;
		soapResponse.results.headerdata.Metadata.DataGroup;
		soapResponse.results.headerdata.Metadata.RecID;
		soapResponse.results.headerdata.Metadata.StatementID;
		soapResponse.results.headerdata.Metadata.ComplianceFlags;
		soapResponse.results.headerdata.Rawdata;
		};

	Mac_Norm(DsIn, DsOutNorm):= MACRO

		DsOutNorm	:=	NORMALIZE(soapResponse, left.results.DsIn
						,TRANSFORM(r
							,self.LexID:=right.Metadata.LexID
							,self.DataGroup:=right.Metadata.DataGroup
							,self.RecID:=right.Metadata.RecID
							,self.StatementID:=right.Metadata.StatementID
							,self.ComplianceFlags:=right.Metadata.ComplianceFlags
							,self:=right
							,self:=[]
							));
	EndMacro;

	Mac_Norm(Aircrafts.Aircraft,OutAircrafts);
	Mac_Norm(Aircrafts.AircraftDetails,OutAircraftDetails);
	Mac_Norm(Aircrafts.AircraftEngine,OutAircraftEngine);
	Mac_Norm(AlloyMediaStudent,OutAlloyMediaStudent);
	Mac_Norm(AmericanStudent,OutAmericanStudent);
	Mac_Norm(Advo,OutAdvo);
	Mac_Norm(ATF,OutATF);
	Mac_Norm(AVM,OutAVM);
	Mac_Norm(AVMMedians.AVMMediansHistory,OutAVMMediansHistory);
	Mac_Norm(AVMMedians.AddressWithCalculatedAVMMedians,OutAddressWithCalculatedAVMMedians);
	Mac_Norm(Bankruptcy.Main,OutBankruptcyMain);
	Mac_Norm(Bankruptcy.search,OutBankruptcySearch);
	Mac_Norm(Criminal.Offenders,OutCriminalOffenders);
	Mac_Norm(Criminal.OffendersPlus,OutCriminalOffendersPlus);
	Mac_Norm(Criminal.Offenses,OutCriminalOffenses);
	Mac_Norm(Criminal.CourtOffenses,OutCriminalCourtOffenses);
	Mac_Norm(Criminal.Punishment,OutCriminalPunishment);
	Mac_Norm(DeathDid,OutDeathDid);
	Mac_Norm(Email,OutEmail);
	Mac_Norm(Gong,OutGong);
	Mac_Norm(HeaderData,OutHeaderData);
	Mac_Norm(HuntingFishing,OutHuntingFishing);
	Mac_Norm(Infutor,OutInfutor);
	Mac_Norm(Inquiries,OutInquiries);
	Mac_Norm(Liens.Main,OutLiensMain);
	Mac_Norm(Liens.Party,OutLiensParty);
	Mac_Norm(Marriage.Main,OutMarriageMain);
	Mac_Norm(Marriage.Search,OutMarriageSearch);
	Mac_Norm(OptOut,OutOptOut);
	Mac_Norm(PeopleAtWork,OutPeopleAtWork);
	Mac_Norm(Pilot.Certificate,OutPilotCertificate);
	Mac_Norm(Pilot.Registration,OutPilotRegistration);
	Mac_Norm(ProfessionalLicense,OutProfessionalLicense);
	Mac_Norm(ProfLicenseMari,OutProfLicenseMari);
	Mac_Norm(PropertyAssessment.assessment,OutPropertyAssessment);
	Mac_Norm(PropertyAssessment.search,OutPropertyAssessmentSearch);
	Mac_Norm(PropertyDeed.deed,OutPropertyDeed);
	Mac_Norm(PropertyDeed.search,OutPropertyDeedSearch);
	Mac_Norm(DeedByResidence.deed,OutDeedByResidence);
	Mac_Norm(DeedByResidence.search,OutDeedByResidenceSearch);
	Mac_Norm(AssessmentByResidence.assessment,OutAssessmentByResidence);
	Mac_Norm(AssessmentByResidence.search,OutAssessmentByResidenceSearch);
	Mac_Norm(SexOffenders.Main,OutSexOffendersMain);
	Mac_Norm(SexOffenders.Offenses,OutSexOffenses);
	Mac_Norm(SSN,OutSSN);
	Mac_Norm(SSNFromInquiries,OutSSNFromInquiries);
	Mac_Norm(Thrive,OutThrive);
	Mac_Norm(UCC.Main,OutUCCMain);
	Mac_Norm(UCC.Party,OutUCCParty);
	Mac_Norm(Watercraft.Owners,OutWatercraftOwners);
	Mac_Norm(Watercraft.Details,OutWatercraftDetails);
	Mac_Norm(Watercraft.Coastguard,OutWatercraftCoastguard);


	dNorm :=
				OutAircrafts
			+ 	OutAircraftDetails
			+ 	OutAircraftEngine
			+ 	OutAlloyMediaStudent
			+ 	OutAmericanStudent
			+ 	OutAdvo
			+ 	OutATF
			+ 	OutAVM
			+ 	OutAVMMediansHistory
			+ 	OutAddressWithCalculatedAVMMedians
			+ 	OutBankruptcyMain
			+ 	OutBankruptcySearch
			+ 	OutCriminalOffenders
			+ 	OutCriminalOffendersPlus
			+ 	OutCriminalOffenses
			+ 	OutCriminalCourtOffenses
			+ 	OutCriminalPunishment
			+ 	OutDeathDid
			+ 	OutEmail
			+ 	OutGong
			+ 	OutHeaderData
			+ 	OutHuntingFishing
			+ 	OutInfutor
			+ 	OutInquiries
			+ 	OutLiensMain
			+ 	OutLiensParty
			+ 	OutMarriageMain
			+ 	OutMarriageSearch
			+ 	OutOptOut
			+ 	OutPeopleAtWork
			+ 	OutPilotCertificate
			+ 	OutPilotRegistration
			+ 	OutProfessionalLicense
			+ 	OutProfLicenseMari
			+ 	OutPropertyAssessment
			+ 	OutPropertyAssessmentSearch
			+ 	OutPropertyDeed
			+ 	OutPropertyDeedSearch
			+ 	OutDeedByResidence
			+ 	OutDeedByResidenceSearch
			+ 	OutAssessmentByResidence
			+ 	OutAssessmentByResidenceSearch
			+ 	OutSexOffendersMain
			+ 	OutSexOffenses
			+ 	OutSSN
			+ 	OutSSNFromInquiries
			+ 	OutThrive
			+ 	OutUCCMain
			+ 	OutUCCParty
			+ 	OutWatercraftOwners
			+ 	OutWatercraftDetails
			+ 	OutWatercraftCoastguard
			;

		dNorm1:=dNorm(~ComplianceFlags.IsPropagatedCorrection, ComplianceFlags.IsSuppressed  or ComplianceFlags.IsOverride  or ComplianceFlags.IsOverwritten);

		dsOut_1 :=table(dNorm1 , {Datagroup
					,lexid
					,RecID_:=trim(RecID.RecID1)
						+	trim(RecID.RecID2)
						+	trim(RecID.RecID3)
						+	trim(RecID.RecID4)
					,IsSuppressed_:=max(group,ComplianceFlags.IsSuppressed)
					,IsOverride_:=max(group,ComplianceFlags.IsOverride)
					,IsOverwritten_:=max(group,ComplianceFlags.IsOverwritten)
					},Datagroup
					,lexid
					,trim(RecID.RecID1)+trim(RecID.RecID2)+trim(RecID.RecID3)+trim(RecID.RecID4)
					,merge):independent;
		
		
		Overrides.Override_Layouts.Layout_Get_Orphans out_xform(dsOut_1 L):=TRANSFORM
			SELF.datagroup		 := L.Datagroup; 
			SELF.did					 := L.lexid;
			SELF.RECID 				 := trim(L.RecID_);
			SELF.IsSuppressed  := L.IsSuppressed_;
			SELF.IsOverride    := L.IsOverride_;
			SELF.IsOverwritten := L.IsOverwritten_;
		END;
 
      dsOut := 	PROJECT(dsOut_1, out_xform(LEFT)); 
		
ENDMACRO;
