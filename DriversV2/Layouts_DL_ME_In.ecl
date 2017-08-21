export Layouts_DL_ME_In := module

	export Layout_ME_Update := record
		string8	 orig_DOB;
		string3	 orig_Credential_Type;
		string8	 orig_ID_Terminal_Date;
		string30 orig_LName;
		string20 orig_FName;
		string1	 orig_MI;
		string3	 orig_NameSuf;
		string50 orig_Street;
		string50 orig_City;
		string2	 orig_State;
		string9	 orig_Zip;
		string1	 orig_DriverEd;
		string1	 orig_Sex; 
		string1  orig_Height;
		string2  orig_Height2;
		string3	 orig_Weight;
		string3	 orig_Hair;
		string3	 orig_Eyes;
		string8	 orig_DLExpireDate;
		string1	 orig_DLStat;
		string8	 orig_DLIssueDate;
		string8	 orig_OriginalIssueDate;
		string1	 orig_RegStatFR;
		string1	 orig_RegStatCR;
		string1	 orig_DLClass;
		string7	 orig_HistoryNum;
		string1	 orig_DisabledVet;
		string1	 orig_Photo;
		string1	 orig_HabitualOffender;
		string20 orig_Restrictions;
		string1	 orig_Endorsements;
		string1	 orig_Endorsements2;
		string1	 orig_Endorsements3;
		string1	 orig_Endorsements4;
		string1	 orig_Endorsements5;
		string1	 orig_Endorsements6;
		string1	 orig_Endorsements7;
		string1  orig_Endorsements8;
		string1	 orig_Endorsements9;
		string1	 orig_Endorsements10;
		string10 orig_Endorsements11_20;
		string1	 orig_Comm_Driv_Status;
		string30 orig_Disabled_Vet_Type;
		string1	 orig_Organ_Donor;
		string1	 orig_LF;
	end;
	
	export Layout_ME_With_ProcessDte := record
	  string8 Process_date;
		Layout_ME_Update;
	end;

  //
  export Layout_ME_Update_MedCert := record
	  string8	 orig_DOB;
		string3	 orig_Credential_Type;
		string8	 orig_ID_Terminal_Date;
		string30 orig_LName;
		string20 orig_FName;
		string1	 orig_MI;
		string3	 orig_NameSuf;
		string50 orig_Street;
		string50 orig_City;
		string2	 orig_State;
		string9	 orig_Zip;
		string1	 orig_DriverEd;
		string1	 orig_Sex; 
		string3  orig_Height_Ins;
		string3	 orig_Weight;
		string3	 orig_Hair;
		string3	 orig_Eyes;
		string8	 orig_DLExpireDate;
		string1	 orig_DLStat;
		string8	 orig_DLIssueDate;
		string8	 orig_OriginalIssueDate;
		string1	 orig_RegStatFR;
		string1	 orig_RegStatCR;
		string1	 orig_DLClass;
		string7	 orig_HistoryNum;
		string1	 orig_DisabledVet;
		string1	 orig_Photo;
		string1	 orig_HabitualOffender;
		string20 orig_Restrictions;
		string1	 orig_Endorsements;
		string1	 orig_Endorsements2;
		string1	 orig_Endorsements3;
		string1	 orig_Endorsements4;
		string1	 orig_Endorsements5;
		string1	 orig_Endorsements6;
		string1	 orig_Endorsements7;
		string1  orig_Endorsements8;
		string1	 orig_Endorsements9;
		string1	 orig_Endorsements10;
		string10 orig_Endorsements11_20;
		string1	 orig_Comm_Driv_Status;
		string30 orig_Disabled_Vet_Type;
		string1	 orig_Organ_Donor;
	  string1   orig_CdlMedCertStsCd;
		string2   orig_CdlMedSelfCertCd;
		string8   orig_CdlMedCertExpDate;
		string8   orig_CdlMedCertSpeWeExpDate;
		string11  orig_SpeWeRestrictions;
		string120 orig_MedExaminerName;
		string13  orig_MedExaminerPhNum;        //Medical Examiner Phone Number
		string8   orig_MedCertIssueDate;
		string8   orig_PostedDate;
		string14  orig_MedLicenseNum;
		string2   orig_MedLicenseJuris;         // Medical Licensing Jurisdiction
		string15  orig_MedExaminerRegNum;       // Medical Examiner Registry Number
		string1	  orig_LF;
	end;
	
	export Layout_ME_With_ProcessDte_MedCert := record
	  string8 Process_date;
		Layout_ME_Update_MedCert;
	end;
	
end;