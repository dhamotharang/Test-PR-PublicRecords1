import corp2, tools, Corp2_Raw_AL;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	// Input File Versions
	// --------------------
	EXPORT Input := MODULE
		tools.mac_FilesInput(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Input.crIncPf, Corp2_Raw_AL.Layouts.IncorporatorLayoutIn, crIncPf);	
		tools.mac_FilesInput(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Input.crOffPf, Corp2_Raw_AL.Layouts.OffAddrLayoutIn, crOffPf);	
		tools.mac_FilesInput(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Input.crNamPf, Corp2_Raw_AL.Layouts.NameChangeLayoutIn, crNamPf);	
		tools.mac_FilesInput(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Input.crSerPf, Corp2_Raw_AL.Layouts.ServiceLayoutIn, crSerPf);	
		tools.mac_FilesInput(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Input.crBusPf, Corp2_Raw_AL.Layouts.BusinessNameLayoutIn, crBusPf);	
		tools.mac_FilesInput(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Input.crHstPf, Corp2_Raw_AL.Layouts.HistoryLayoutIn, crHstPf);	
		tools.mac_FilesInput(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Input.crAnlPf, Corp2_Raw_AL.Layouts.AnnualReportLayoutIn, crAnlPf);	
		tools.mac_FilesInput(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Input.crMstPf, Corp2_Raw_AL.Layouts.CorpMasterLayoutIn, crMstPf);	
	
	  // Format Input Files 
		EXPORT crMstPf_raw := crMstPf.logical;		
		EXPORT crOffPf_raw := crOffPf.logical;
		EXPORT crIncPf_raw := crIncPf.logical;
		EXPORT crNamPf_raw := crNamPf.logical;
		EXPORT crSerPf_raw := crSerPf.logical;
		EXPORT crBusPf_raw := crBusPf.logical;
		EXPORT crHstPf_raw := crHstPf.logical;
		EXPORT crAnlPf_raw := crAnlPf.logical;
		
		// Removes nulls
	  EXPORT FixNulls(STRING s) := FUNCTION 	
			RETURN corp2.t2u(StringLib.StringFindReplace(s,'[\\x00]',''));
		END;
		
		// Removes â‚¬ characters
		EXPORT Fix_x80s(STRING s) := FUNCTION 	
			RETURN corp2.t2u(StringLib.StringFindReplace(s,'[\\x80]',''));
		END; 
 		
		// Replaces â‚¬ characters with blanks
		EXPORT Blank_x80s(STRING s) := FUNCTION 	
			RETURN corp2.t2u(StringLib.StringFindReplace(s,'[\\x80]',' '));
		END; 

		EXPORT Corp2_Raw_AL.Layouts.CorpMasterLayout trfCorpMaster(Corp2_Raw_AL.Layouts.CorpMasterLayoutIN l) := TRANSFORM
			self.CRMACC := fixNulls(l.Account_Number );
			self.CRMLN1 := blank_x80s(fixNulls(l.Legal_Name_Line1));
			self.CRMLN2 := blank_x80s(fixNulls(l.Legal_Name_Line2));
			self.CRMNAM	:= fixNulls(l.Search_Name);
			self.CRMPMC := fix_x80s(fixNulls(l.Principal_Misc));
			self.CRMPAD := fix_x80s(fixNulls(l.Principal_Address ));
			self.CRMPCT := fix_x80s(fixNulls(l.Principal_City));
			self.CRMPST := fix_x80s(fixNulls(l.Principal_State ));
			self.CRMPZP := corp2.t2u((string) intformat((integer)l.Principal_Zip1,5,1));
			self.CRMPPL := corp2.t2u((string) intformat((integer)l.Principal_Zip2,4,1));
			self.CRMTYP := fixNulls(l.Type_of_Filing);
			self.CRMIMO := corp2.t2u((string) intformat((integer)l.Incorporation_Qualification_Month,2,1));
			self.CRMIDY := corp2.t2u((string) intformat((integer)l.Incorporation_Qualification_Day,2,1));
			self.CRMIYR := corp2.t2u((string)l.Incorporation_Qualification_Year);
			self.CRMPLC := fixNulls(l.Place_of_Incorporation );
			self.CRMAUT := fix_x80s(fixNulls(l.Authorized_Capital));
			self.CRMPIN := fix_x80s(fixNulls(l.Paid_in_Capital));
			self.CRMDCD := fix_x80s(fixNulls(l.Dissolve_Code ));
			self.CRMDSC := fix_x80s(fixNulls(l.Dissolve_Sub_code ));
			self.CRMDMO := corp2.t2u((string) intformat((integer)l.Dissolve_Month,2,1));
			self.CRMDDY := corp2.t2u((string) intformat((integer)l.Dissolve_Day,2,1));
			self.CRMDYR := corp2.t2u((string)l.Dissolve_Year);
			self.CRMANM := blank_x80s(fixNulls(l.Registered_Agent_Name));
			self.CRMAMC := fix_x80s(fixNulls(l.Registered_Agent_Misc));
			self.CRMAAD := fix_x80s(fixNulls(l.Registered_Agent_Address ));
			self.CRMACT := fix_x80s(fixNulls(l.Registered_Agent_City ));
			self.CRMAST := fix_x80s(fixNulls(l.Registered_Agent_State ));
			self.CRMAZP := corp2.t2u((string) intformat((integer)l.Registered_Agent_Zip1_Code,5,1));
			self.CRMAPL := corp2.t2u((string) intformat((integer)l.Registered_Agent_Zip2_Code,4,1));
			self.CRMAMO := corp2.t2u((string) intformat((integer)l.Agent_Resign_Month,2,1));
			self.CRMADY := corp2.t2u((string) intformat((integer)l.Agent_Resign_Day,2,1));
			self.CRMAYR := corp2.t2u((string)l.Agent_Resign_Year);
			self.CRMBUS := blank_x80s(fixNulls(l.Nature_of_Business)); 
			self.CRMFMO := corp2.t2u((string) intformat((integer)l.Formed_Month,2,1));
			self.CRMFDY := corp2.t2u((string) intformat((integer)l.Formed_Day,2,1));
			self.CRMFYR := corp2.t2u((string)l.Formed_Year);
			self.CRMMRG := fixNulls(l.Merge_Consolidate_to_Account);
			self.CRMCOM := fixNulls(l.Account_Comments );
			self.CRMINC := corp2.t2u((string)l.Last_Incorporation_Number);
			self.CRMFNF := fixNulls(l.Fictitious_Registered_Name);
			self.CRMORF := fixNulls(l.Office_of_Records);
			self.CRMSPF := fixNulls(l.Service_of_Process);
			self.CRMFCD := fixNulls(l.File_Code);
	  	self.CRMMYR := corp2.t2u((string)l.Last_Maintenance_Year);
			self.CRMMMO := corp2.t2u((string) intformat((integer)l.Last_Maintenance_Month,2,1));
			self.CRMMDY := corp2.t2u((string) intformat((integer)l.Last_Maintenance_Day,2,1));			
			self.CRMMTM := corp2.t2u((string)l.Last_Maintenance_Time);
			self.CRMMUR := fixNulls(l.Last_Maintenance_User);
		end;

		EXPORT Corp2_Raw_AL.Layouts.OfficeAddressLayout  trfOffAddr(Corp2_Raw_AL.Layouts.OffAddrLayoutIN l) := TRANSFORM
			self.CROACC	:=	fixNulls(l.Account_Number);			
			self.CRORMC	:=	fix_x80s(fixNulls(l.Ofc_Of_Recs_Misc));
			self.CRORAD	:=	fix_x80s(fixNulls(l.Ofc_Of_Recs_Address));
			self.CRORCT	:=	fix_x80s(fixNulls(l.Ofc_Of_Recs_City)); 
			self.CRORST	:=	fix_x80s(fixNulls(l.Ofc_Of_Recs_State));
			self.CRORZP	:=	fixNulls((string)l.Ofc_Of_Recs_Zip_Code_1);
			self.CRORPL	:=	corp2.t2u((string) intformat((integer)l.Ofc_Of_Recs_Zip_Code_2,4,1));
			self.CROFCD	:=	fixNulls(l.File_Code);
			self.CROMYR	:=	fixNulls((string)l.Last_Maint_Yr);
			self.CROMMO	:=	corp2.t2u((string) intformat((integer)l.Last_Maint_Mth,2,1));
			self.CROMDY	:=	corp2.t2u((string) intformat((integer)l.Last_Maint_Day,2,1));
			self.CROMTM	:=	fixNulls((string)l.Last_Maint_Time);
			self.CROMUR	:=	fixNulls(l.Last_Maint_User);
		end;

		EXPORT Corp2_Raw_AL.Layouts.IncorporatorsFileLayout	trfIncorp(Corp2_Raw_AL.Layouts.IncorporatorLayoutIN l) := TRANSFORM
			self.CRIACC :=	fixNulls(l.Account_Number);
			self.CRISEQ :=	corp2.t2u((string)l.Record_Sequence);
			self.CRIINM :=	blank_x80s(fixNulls(l.Incorporator_Name));	
			self.CRIIMC :=	fix_x80s(fixNulls(l.Incorporator_Misc));	
			self.CRIIAD :=	fix_x80s(fixNulls(l.Incorporator_Address));	
			self.CRIICT	:=	fix_x80s(fixNulls(l.Incorporator_City));	
			self.CRIIST :=	fix_x80s(fixNulls(l.Incorporator_State));	
			self.CRIIZP :=	corp2.t2u((string) intformat((integer)l.Incorporator_Zip_Code_1,5,1));	
			self.CRIIPL :=	corp2.t2u((string) intformat((integer)l.Incorporator_Zip_Code_2,4,1));
			self.CRIFCD :=	fixNulls(l.Incorporator_File_Code);	
			self.CRIMYR :=	corp2.t2u((string) l.Last_Maint_Yr);
			self.CRIMMO :=	corp2.t2u((string) intformat((integer)l.Last_Maint_Mth,2,1));	
			self.CRIMDY :=	corp2.t2u((string) intformat((integer)l.Last_Maint_Day,2,1));	
			self.CRIMTM :=	corp2.t2u((string)l.Last_Maint_Time);	
			self.CRIMUR :=	fixNulls(l.Last_Maint_User);	
		end;

		EXPORT Corp2_Raw_AL.Layouts.NameChangesFileLayout  trfName(Corp2_Raw_AL.Layouts.NameChangeLayoutIN l) := TRANSFORM
			self.CRNACC	:=	fixNulls(l.Account_Number);			
			self.CRNHYR	:=	corp2.t2u((string)l.History_Yr);
			self.CRNHMO	:=	corp2.t2u((string) intformat((integer)l.History_Mth,2,1));
			self.CRNHDY	:=	corp2.t2u((string) intformat((integer)l.History_Day,2,1));
			self.CRNTYP	:=	corp2.t2u((string)l.History_Type);
			self.CRNSEQ	:=	corp2.t2u((string)l.Record_Sequence);
			self.CRNLN1	:=	blank_x80s(fixNulls(l.Legal_Name_1));
			self.CRNLN2	:=	blank_x80s(fixNulls(l.Legal_Name_2));
			self.CRNNAM	:=	fixNulls(l.Search_Name);
			self.CRNMRG	:=	fixNulls(l.Simultaneous_Merge);
			self.CRNFCD	:=	fixNulls(l.File_Code);
			self.CRNMYR	:=	corp2.t2u((string)l.Last_Maint_Yr);
			self.CRNMMO	:=	corp2.t2u((string) intformat((integer)l.Last_Maint_Mth,2,1));
			self.CRNMDY	:=	corp2.t2u((string) intformat((integer)l.Last_Maint_Day,2,1));
			self.CRNMTM	:=	corp2.t2u((string)l.Last_Maint_Time);
			self.CRNMUR :=	fixNulls(l.Last_Maint_User);	
		end;

		EXPORT Corp2_Raw_AL.Layouts.ServiceofProcessFileLayout  trfService(Corp2_Raw_AL.Layouts.ServiceLayoutIN l) := TRANSFORM
			self.CRSACC	:=	fixNulls(l.Account_Number);	 
			self.CRSPNM	:=	blank_x80s(fixNulls(l.Svc_of_Proc_Name));
			self.CRSPMC	:=	fix_x80s(fixNulls(l.Svc_of_Proc_Misc));
			self.CRSPAD	:=	fix_x80s(fixNulls(l.Svc_of_Proc_Address));
			self.CRSPCT	:=	fix_x80s(fixNulls(l.Svc_of_Proc_City));
			self.CRSPST	:=	fix_x80s(fixNulls(l.Svc_of_Proc_State));
			self.CRSPZP	:=	corp2.t2u((string) intformat((integer)l.Svc_of_Proc_Zip_Code_1,5,1));
			self.CRSPPL	:=	corp2.t2u((string) intformat((integer)l.Svc_of_Proc_Zip_Code_2,4,1));
			self.CRSFCD	:=	fixNulls(l.File_Code);
			self.CRSMYR	:=	corp2.t2u((string)l.Last_Maint_Yr);
			self.CRSMMO	:=	corp2.t2u((string) intformat((integer)l.Last_Maint_Mth,2,1));
			self.CRSMDY	:=	corp2.t2u((string) intformat((integer)l.Last_Maint_Day,2,1));
			self.CRSMTM	:=	corp2.t2u((string)l.Last_Maint_Time);
			self.CRSMUR	:=	fixNulls(l.Last_Maint_User);
		end;
  
		EXPORT Corp2_Raw_AL.Layouts.BusinessNameFileLayout  trfBusiness(Corp2_Raw_AL.Layouts.BusinessNameLayoutIN l) := TRANSFORM
			self.CRBACC :=	fixNulls(l.Account_Number);
			self.CRBLN1 :=	blank_x80s(fixNulls(l.Legal_Name_1));	
			self.CRBLN2 :=	blank_x80s(fixNulls(l.Legal_Name_2));	
			self.CRBNAM :=	fixNulls(l.Search_Name);	
			self.CRBDCD :=	fixNulls(l.Dissolve_Code);	
			self.CRBFCD :=	fixNulls(l.File_Code);	
			self.CRBMYR :=	corp2.t2u((string)l.Last_Maint_Yr);
			self.CRBMMO :=	corp2.t2u((string) intformat((integer)l.Last_Maint_Mth,2,1)); 	
			self.CRBMDY :=	corp2.t2u((string) intformat((integer)l.Last_Maint_Day,2,1));	
			self.CRBMTM :=	corp2.t2u((string)l.Last_Maint_Time);
			self.CRBMUR :=	fixNulls(l.Last_Maint_User);
		end;
	
		EXPORT Corp2_Raw_AL.Layouts.HistoryFileLayout trfHistory(Corp2_Raw_AL.Layouts.HistoryLayoutIN l) := TRANSFORM
			self.CRHACC :=	fixNulls(l.Account_Number);			
			self.CRHHYR :=	corp2.t2u((string)l.History_Yr);
			self.CRHHMO :=	corp2.t2u((string) intformat((integer)l.History_Mth,2,1));
			self.CRHHDY :=	corp2.t2u((string) intformat((integer)l.History_Day,2,1));
			self.CRHTYP :=	corp2.t2u((string)l.History_Type);
			self.CRHSEQ :=	corp2.t2u((string)l.Record_Sequence);
			self.CRHLIN :=	blank_x80s(fixNulls(l.Legal_Name_1));
			self.CRHFCD :=	fixNulls(l.File_Code);
			self.CRHMYR :=	corp2.t2u((string)l.Last_Maint_Yr);
			self.CRHMMO :=	corp2.t2u((string) intformat((integer)l.Last_Maint_Mth,2,1));
			self.CRHMDY :=	corp2.t2u((string) intformat((integer)l.Last_Maint_Day,2,1));
			self.CRHMTM :=	corp2.t2u((string)l.Last_Maint_Time);
			self.CRHMUR :=	fixNulls(l.Last_Maint_User);	
		end;

		EXPORT Corp2_Raw_AL.Layouts.AnnualLayout trfAR(Corp2_Raw_AL.Layouts.AnnualReportLayoutIN l) := TRANSFORM
			self.CRAACC	:= fixNulls(l.Account_Number);
			self.CRARYR	:= corp2.t2u((string)l.Annual_Report_Yr);
			self.CRACNM	:= blank_x80s(fixNulls(l.Current_Name));
			self.CRACMC	:= fix_x80s(fixNulls(l.Current_Misc));
			self.CRACAD	:= fix_x80s(fixNulls(l.Current_Address));
			self.CRACCT	:= fix_x80s(fixNulls(l.Current_City));
			self.CRACST	:= fix_x80s(fixNulls(l.Current_State));
			self.CRACZP	:= corp2.t2u((string) intformat((integer)l.Current_Zip_Code5,5,1));
			self.CRACPL	:= corp2.t2u((string) intformat((integer)l.Current_Zip_Code4,4,1));
			self.CRAANM	:= blank_x80s(fixNulls(l.Agent_Name));
			self.CRAAMC	:= fix_x80s(fixNulls(l.Agent_Misc));
			self.CRAAAD	:= fix_x80s(fixNulls(l.Agent_Address));
			self.CRAACT	:= fix_x80s(fixNulls(l.Agent_City));
			self.CRAAST	:= fix_x80s(fixNulls(l.Agent_State));
			self.CRAAZP	:= corp2.t2u((string) intformat((integer)l.Agent_Zip_Code5,5,1));
			self.CRAAPL	:= corp2.t2u((string) intformat((integer)l.Agent_Zip_Code4,4,1));
			self.CRAPNM	:= blank_x80s(fixNulls(l.President_Name));
			self.CRAPMC	:= fix_x80s(fixNulls(l.President_Misc));
			self.CRAPAD	:= fix_x80s(fixNulls(l.President_Address));
			self.CRAPCT	:= fix_x80s(fixNulls(l.President_City));
			self.CRAPST	:= fix_x80s(fixNulls(l.President_State));
			self.CRAPZP	:= corp2.t2u((string) intformat((integer)l.President_Zip_Code5,5,1));
			self.CRAPPL	:= corp2.t2u((string) intformat((integer)l.President_Zip_Code4,4,1));
			self.CRASNM	:= blank_x80s(fixNulls(l.Secretary_Name));
			self.CRASMC	:= fix_x80s(fixNulls(l.Secretary_Misc));
			self.CRASAD	:= fix_x80s(fixNulls(l.Secretary_Address));
			self.CRASCT	:= fix_x80s(fixNulls(l.Secretary_City));
			self.CRASST	:= fix_x80s(fixNulls(l.Secretary_State));
			self.CRASZP	:= corp2.t2u((string) intformat((integer)l.Secretary_Zip_Code5,5,1));
			self.CRASPL	:= corp2.t2u((string) intformat((integer)l.Secretary_Zip_Code4,4,1));
			self.CRABNM	:= fixNulls(l.Business_Type);
			self.CRABMC	:= fixNulls(l.Business_Misc);
			self.CRABAD	:= fixNulls(l.Business_Address);
			self.CRABCT	:= fixNulls(l.Business_City);
			self.CRABST	:= fixNulls(l.Business_State);
			self.CRABZP	:= corp2.t2u((string) intformat((integer)l.Business_Zip_Code5,5,1));
			self.CRABPL	:= corp2.t2u((string) intformat((integer)l.Business_Zip_Code4,4,1));
			self.CRAFNM	:= fixNulls(l.Foreign_Type);
			self.CRAFMC	:= fixNulls(l.Foreign_Misc);
			self.CRAFAD	:= fixNulls(l.Foreign_Address);
			self.CRAFCT	:= fixNulls(l.Foreign_City);
			self.CRAFST	:= fixNulls(l.Foreign_State);
			self.CRAFZP := corp2.t2u((string) intformat((integer)l.Foreign_Zip_Code5,5,1));
			self.CRAFPL := corp2.t2u((string) intformat((integer)l.Foreign_Zip_Code4,4,1));
			self.CRATL1 := corp2.t2u((string)l.Tele_Area_Code);
			self.CRATL2 := corp2.t2u((string) intformat((integer)l.Tele_Prefix,3,1));
			self.CRATL3 := corp2.t2u((string) intformat((integer)l.Tele_Number,4,1));
			self.CRAPYR := corp2.t2u((string)l.Revenue_Process_Yr);
			self.CRAPMO := corp2.t2u((string) intformat((integer)l.Revenue_Process_Mth,2,1));
			self.CRAPDY := corp2.t2u((string) intformat((integer)l.Revenue_Process_Day,2,1));
			self.CRAFCD := fixNulls(l.File_Code);			
			self.CRAMYR := corp2.t2u((string)l.Last_Maint_Yr);
			self.CRAMMO := corp2.t2u((string) intformat((integer)l.Last_Maint_mth,2,1));
			self.CRAMDY := corp2.t2u((string) intformat((integer)l.Last_Maint_day,2,1));
			self.CRAMTM := corp2.t2u((string)l.Last_Maint_time);
			self.CRAMUR := fixNulls(l.Last_Maint_User);	
		end;
		
    EXPORT fCorpMaster := PROJECT(crMstPf_raw, trfCorpMaster(LEFT))(corp2.t2u(CRMACC)<>'');
	  EXPORT fOffAddr  	 := PROJECT(crOffPf_raw, trfOffAddr(LEFT))   (corp2.t2u(CROACC)<>'');
    EXPORT fIncorp	   := PROJECT(crIncPf_raw, trfIncorp(LEFT))    (corp2.t2u(CRIACC)<>'');
    EXPORT fName       := PROJECT(crNamPf_raw, trfName(LEFT))      (corp2.t2u(CRNACC)<>'');
    EXPORT fService	   := PROJECT(crSerPf_raw, trfService(LEFT))   (corp2.t2u(CRSACC)<>'');
	  EXPORT fBusiness	 := PROJECT(crBusPf_raw, trfBusiness(LEFT))  (corp2.t2u(CRBACC)<>'');
    EXPORT fHistory	   := PROJECT(crHstPf_raw, trfHistory(LEFT))   (corp2.t2u(CRHACC)<>'');
		EXPORT fAR	       := PROJECT(crAnlPf_raw, trfAR(LEFT))        (corp2.t2u(CRAACC)<>'');
		
	END;

	// Base File Versions
	// --------------------
	EXPORT Base := MODULE
		tools.mac_FilesBase(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Base.crIncPf, Corp2_Raw_AL.Layouts.IncorporatorLayoutBase, crIncPf);
		tools.mac_FilesBase(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Base.crOffPf, Corp2_Raw_AL.Layouts.OffAddrLayoutBase, crOffPf);
		tools.mac_FilesBase(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Base.crNamPf, Corp2_Raw_AL.Layouts.NameChangeLayoutBase, crNamPf);
		tools.mac_FilesBase(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Base.crSerPf, Corp2_Raw_AL.Layouts.ServiceLayoutBase, crSerPf);	
		tools.mac_FilesBase(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Base.crBusPf, Corp2_Raw_AL.Layouts.BusinessNameLayoutBase, crBusPf);	
		tools.mac_FilesBase(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Base.crHstPf, Corp2_Raw_AL.Layouts.HistoryLayoutBase, crHstPf);	
		tools.mac_FilesBase(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Base.crAnlPf, Corp2_Raw_AL.Layouts.AnnualReportLayoutBase, crAnlPf);
		tools.mac_FilesBase(Corp2_Raw_AL.Filenames(pversion, pUseOtherEnvironment).Base.crMstPf, Corp2_Raw_AL.Layouts.CorpMasterLayoutBase, crMstPf);
  END;

END;

