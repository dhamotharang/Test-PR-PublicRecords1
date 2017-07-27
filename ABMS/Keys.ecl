IMPORT tools;

EXPORT Keys(STRING pversion = '',
	          DATASET(Layouts.Base.Main)						pBaseMainBuilt						=	Files(pversion).Base.Main.Built,
						DATASET(Layouts.Base.Career)					pBaseCareerBuilt					=	Files(pversion).Base.Career.Built,
						DATASET(Layouts.Base.Cert)						pBaseCertBuilt						=	Files(pversion).Base.Cert.Built,
						DATASET(Layouts.Base.Education)				pBaseEducationBuilt				=	Files(pversion).Base.Education.Built,
						DATASET(Layouts.Base.Membership)			pBaseMembershipBuilt			=	Files(pversion).Base.Membership.Built,
						DATASET(Layouts.Base.TypeOfPractice)	pBaseTypeOfPracticeBuilt	=	Files(pversion).Base.TypeOfPractice.Built) := MODULE

	SHARED BaseMain           := PROJECT(pBaseMainBuilt(biog_number != ''), Layouts.Keybuild.Main);
	SHARED BaseMain_DID       := BaseMain(did != 0);
	SHARED BaseMain_BDID      := BaseMain(bdid != 0);
	SHARED BaseMain_NPI       := BaseMain(npi != '');
	SHARED BaseCareer         := pBaseCareerBuilt(biog_number != '');
	SHARED BaseCert           := pBaseCertBuilt(biog_number != '');
	SHARED BaseEducation      := pBaseEducationBuilt(biog_number != '');
	SHARED BaseMembership     := pBaseMembershipBuilt(biog_number != '');
	SHARED BaseTypeOfPractice := pBaseTypeOfPracticeBuilt(biog_number != '');

	SHARED BaseMain_sorted := SORT(DISTRIBUTE(BaseMain(last_name != ''), HASH(biog_number)),
													       RECORD,
													       LOCAL);

	SHARED BaseCareer_sorted := SORT(DISTRIBUTE(BaseCareer(specialty != ''), HASH(biog_number)),
                                   RECORD,
                                   LOCAL);

	SHARED BaseCert_sorted := SORT(DISTRIBUTE(BaseCert(cert_name != '', cert_type_ind != ''), HASH(biog_number)),
                                 RECORD,
                                 LOCAL);

	Layouts.Keybuild.Main_Specialty add_specialty(Layouts.Keybuild.Main L, Layouts.Base.Career R) := TRANSFORM
		SELF.specialty := R.specialty;
		SELF := L;
	END;

	SHARED BaseMain_Specialty := DEDUP(JOIN(BaseMain_sorted, BaseCareer_sorted,
															            LEFT.biog_number = RIGHT.biog_number,
															            add_specialty(LEFT, RIGHT),
															            LOCAL),
															       ALL,
															       LOCAL);

	Layouts.Keybuild.Main_Cert add_cert_info(Layouts.Keybuild.Main L, Layouts.Base.Cert R) := TRANSFORM
		SELF.cert_name     := R.cert_name;
		SELF.cert_type_ind := R.cert_type_ind;

		SELF := L;
	END;

	SHARED BaseMain_Cert := DEDUP(JOIN(BaseMain_sorted, BaseCert_sorted,
															       LEFT.biog_number = RIGHT.biog_number,
															       add_cert_info(LEFT, RIGHT),
															       LOCAL),
															  ALL,
															  LOCAL);

	Layouts.Lookups.Specialty xform(Layouts.Base.Cert L) := TRANSFORM
		SELF.specialty        := L.board_web_desc;
		SELF.sub_specialty_id := L.cert_id;
		SELF.sub_specialty    := L.cert_name;
	END;

	SHARED Specialty_Lookup_Dedup := DEDUP(SORT(PROJECT(BaseCert, xform(LEFT)), RECORD), RECORD);
	
	EXPORT Main := MODULE
		tools.mac_FilesIndex('BaseMain, {biog_number, record_type}, {BaseMain}',
		                        KeyNames(pversion).Main.BIOGNumber, BIOGNumber);
		tools.mac_FilesIndex('BaseMain_DID, {did, biog_number}, {BaseMain}',
		                        KeyNames(pversion).Main.DID, DID);
		tools.mac_FilesIndex('BaseMain_BDID, {bdid, biog_number}, {BaseMain}',
		                        KeyNames(pversion).Main.BDID, BDID);
		tools.mac_FilesIndex('BaseMain_NPI, {npi, biog_number}, {BaseMain}',
		                        KeyNames(pversion).Main.NPI, NPI);
		tools.mac_FilesIndex('BaseMain_Specialty, ' +
		                        '{last_name, specialty, first_name, biog_number}, {BaseMain_Specialty}',
		                        KeyNames(pversion).Main.LNameSpecialtyFName, LNameSpecialtyFName);
		tools.mac_FilesIndex('BaseMain_Cert, ' +
		                        '{last_name, cert_name, first_name, biog_number}, {BaseMain_Cert}',
		                        KeyNames(pversion).Main.LNameCertFName, LNameCertFName);
	END;

	EXPORT Career := MODULE
		tools.mac_FilesIndex('BaseCareer, {biog_number, record_type}, {BaseCareer}',
		                        KeyNames(pversion).Career.BIOGNumber, BIOGNumber);
	END;

	EXPORT Cert := MODULE
		tools.mac_FilesIndex('BaseCert, {biog_number, record_type}, {BaseCert}',
		                        KeyNames(pversion).Cert.BIOGNumber, BIOGNumber);
	END;

	EXPORT Education := MODULE
		tools.mac_FilesIndex('BaseEducation, {biog_number, record_type}, {BaseEducation}',
		                        KeyNames(pversion).Education.BIOGNumber, BIOGNumber);
	END;

	EXPORT Membership := MODULE
		tools.mac_FilesIndex('BaseMembership, {biog_number, record_type}, {BaseMembership}',
		                        KeyNames(pversion).Membership.BIOGNumber, BIOGNumber);
	END;

	EXPORT TypeOfPractice := MODULE
		tools.mac_FilesIndex('BaseTypeOfPractice, {biog_number, record_type}, {BaseTypeOfPractice}',
		                        KeyNames(pversion).TypeOfPractice.BIOGNumber, BIOGNumber);
	END;

	EXPORT Lookups := MODULE
		tools.mac_FilesIndex('Specialty_Lookup_Dedup, {specialty, sub_specialty_id, sub_specialty}, ' +
		                        '{Specialty_Lookup_Dedup}',
		                        KeyNames(pversion).Lookups.Specialty, Specialty);
	END;

END;