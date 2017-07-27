import ut, lib_stringlib, _validate, Address, corp2, _control, VersionControl;

export AL := MODULE;

	export constants := module
	   export cluster := '~thor_data400::';
	end;
	
	export Layouts_Raw_Input := MODULE
		
		//The vendor data consists of 9 record types in fixed length format, each in an individual file. 	
	
		//Corporation Master Record
		export Layout_CorpMaster := Record
			ebcdic string6 Account_Number;
			ebcdic string64 Legal_Name_Line1;
			ebcdic string60 Legal_Name_Line2;
			ebcdic string64 Search_Name;   
			ebcdic string36 Principal_Misc; 
			ebcdic string36 Principal_Address;
			ebcdic string21 Principal_City;
			ebcdic string2 Principal_State;
			decimal5 Principal_Zip1;
			decimal5 Principal_Zip2;
			ebcdic string3 Type_of_Filing;
			decimal3 Incorporation_Qualification_Month;
			decimal3 Incorporation_Qualification_Day;
			decimal5 Incorporation_Qualification_Year;
			ebcdic string2 Place_of_Incorporation;
			ebcdic string15 Authorized_Capital;
			ebcdic string15 Paid_in_Capital;
			ebcdic string1 Dissolve_Code;
			ebcdic string1 Dissolve_Sub_code;
			decimal3 Dissolve_Month;
			decimal3 Dissolve_Day;
			decimal5 Dissolve_Year;
			ebcdic string36 Registered_Agent_Name;
			ebcdic string36 Registered_Agent_Misc;
			ebcdic string36 Registered_Agent_Address;
			ebcdic string21 Registered_Agent_City;
			ebcdic string2 Registered_Agent_State;
			decimal5 Registered_Agent_Zip1_Code;
			decimal5 Registered_Agent_Zip2_Code;
			decimal3 Agent_Resign_Month;
			decimal3 Agent_Resign_Day;
			decimal5 Agent_Resign_Year;
			ebcdic string64 Nature_of_Business;
			decimal3 Formed_Month;
			decimal3 Formed_Day;
			decimal5 Formed_Year;
			ebcdic string6 Merge_Consolidate_to_Account;
			ebcdic string64 Account_Comments;
			decimal3 Last_Incorporation_Number;
			ebcdic string1 Fictitious_Registered_Name;
			ebcdic string1 Office_of_Records;
			ebcdic string1 Service_of_Process;
			ebcdic string1 File_Code;
			decimal5 Last_Maintenance_Year;
			decimal3 Last_Maintenance_Month;
			decimal3 Last_Maintenance_Day;
			decimal7 Last_Maintenance_Time;
			ebcdic string15 Last_Maintenance_User;
		end;
		
		//Office Address File Record
		export Layout_Officer :=  RECORD
   			ebcdic string6 Account_Number;
   			ebcdic string36 Ofc_Of_Recs_Misc;
  			ebcdic string36 Ofc_Of_Recs_Address;
  			ebcdic string21 Ofc_Of_Recs_City;
   			ebcdic string2 Ofc_Of_Recs_State;
   			decimal5 Ofc_Of_Recs_Zip_Code_1;
  			decimal5 Ofc_Of_Recs_Zip_Code_2;
  			ebcdic string1 File_Code;
   			decimal5 Last_Maint_Yr;
   			decimal3 Last_Maint_Mth;
   			decimal3 Last_Maint_Day;
  			decimal7 Last_Maint_Time;
   			ebcdic string15 Last_Maint_User;
		end;
			
        //Incorporators File Record 
		export Layout_Incorporator := RECORD
   			ebcdic string6 Account_Number;
   			decimal3 Record_Sequence;
  			ebcdic string36 Incorporator_Name;
   			ebcdic string36 Incorporator_Misc;
   			ebcdic string36 Incorporator_Address;
   			ebcdic string21 Incorporator_City;
   			ebcdic string2 Incorporator_State;
   			decimal5 Incorporator_Zip_Code_1;
   			decimal5 Incorporator_Zip_Code_2;
   			ebcdic string1 Incorporator_File_Code;
   			decimal5 Last_Maint_Yr;
  			decimal3 Last_Maint_Mth;
   			decimal3 Last_Maint_Day;
   			decimal7 Last_Maint_Time;
   			ebcdic string15 Last_Maint_User;
		end;
					
		//Name Changes File Record 
		export Layout_NameChange := RECORD
			ebcdic string6 Account_Number;
   			decimal5 History_Yr;
   			decimal3 History_Mth;
   			decimal3 History_Day;
  			decimal3 History_Type;
   			decimal3 Record_Sequence;
   			ebcdic string64 Legal_Name_1;
   			ebcdic string60 Legal_Name_2;
   			ebcdic string64 Search_Name;
   			ebcdic string6 Simultaneous_Merge;
   			ebcdic string1 File_Code;
   			decimal5 Last_Maint_Yr;
   			decimal3 Last_Maint_Mth;
   			decimal3 Last_Maint_Day;
   			decimal7 Last_Maint_Time;
   			ebcdic string15 Last_Maint_User;
		end;
		
        //Service of Process File Record 
		export Layout_Service := RECORD
			ebcdic string6 Account_Number;
  			ebcdic string36 Svc_of_Proc_Name;
   			ebcdic string36 Svc_of_Proc_Misc;
   			ebcdic string36 Svc_of_Proc_Address;
   			ebcdic string21 Svc_of_Proc_City;
   			ebcdic string2 Svc_of_Proc_State;
   			decimal5 Svc_of_Proc_Zip_Code_1;
   			decimal5 Svc_of_Proc_Zip_Code_2;
   			ebcdic string1 File_Code;
   			decimal5 Last_Maint_Yr;
   			decimal3 Last_Maint_Mth;
   			decimal3 Last_Maint_Day;
   			decimal7 Last_Maint_Time;
   			ebcdic string15 Last_Maint_User;
		end;
			
        //Business Name File Record
		export Layout_BusinessName := RECORD   			
			ebcdic string6 Account_Number;
   			ebcdic string64 Legal_Name_1;
   			ebcdic string60 Legal_Name_2;
   			ebcdic string64 Search_Name;
  		 	ebcdic string1 Dissolve_Code;
   			ebcdic string1 File_Code;
   			decimal5 Last_Maint_Yr;
   			decimal3 Last_Maint_Mth;
   			decimal3 Last_Maint_Day;
   			decimal7 Last_Maint_Time;
   			ebcdic string15 Last_Maint_User;			
		end;
			
		//History File Record
		export Layout_History := RECORD
   			ebcdic string6 Account_number;
   			decimal5 History_Yr;
   			decimal3 History_Mth;
  			decimal3 History_Day;
   			decimal3 History_Type;
   			decimal3 Record_Sequence;
   			ebcdic string148 Legal_name_1;
   			ebcdic string1 File_code;
   			decimal5 Last_Maint_Yr;
   			decimal3 Last_Maint_Mth;
   			decimal3 Last_Maint_Day;
   			decimal7 Last_Maint_Time;
   			ebcdic string15 Last_Maint_User;	
		end;
	
		//Annual Report File Record
		export Layout_AnnualReport := RECORD
			ebcdic string6 Account_Number;
			decimal5 Annual_Report_Yr;
			ebcdic string64 Current_Name;
			ebcdic string36 Current_Misc;
			ebcdic string36 Current_Address;
			ebcdic string21 Current_City;
			ebcdic string2 Current_State;
			decimal5 Current_Zip_Code5;
			decimal5 Current_Zip_Code4;
			ebcdic string36 Agent_Name;
			ebcdic string36 Agent_Misc;
			ebcdic string36 Agent_Address;
			ebcdic string21 Agent_City;
			ebcdic string2 Agent_State;
			decimal5 Agent_Zip_Code5;
			decimal5 Agent_Zip_Code4;
			ebcdic string36 President_Name;
			ebcdic string36 President_Misc;
			ebcdic string36 President_Address;
			ebcdic string21 President_City;
			ebcdic string2 President_State;
			decimal5 President_Zip_Code5;
			decimal5 President_Zip_Code4;
			ebcdic string36 Secretary_Name;
			ebcdic string36 Secretary_Misc;
			ebcdic string36 Secretary_Address;
			ebcdic string21 Secretary_City;
			ebcdic string2 Secretary_State;
			decimal5 Secretary_Zip_Code5;
			decimal5 Secretary_Zip_Code4;
			ebcdic string64 Business_Type;
			ebcdic string36 Business_Misc;
			ebcdic string36 Business_Address;
			ebcdic string21 Business_City;
			ebcdic string2 Business_State;
			decimal5 Business_Zip_Code5;
			decimal5 Business_Zip_Code4;
			ebcdic string64 Foreign_Type;
			ebcdic string36 Foreign_Misc;
			ebcdic string36 Foreign_Address;
			ebcdic string21 Foreign_City;
			ebcdic string2 Foreign_State;
			decimal5 Foreign_Zip_Code5;
			decimal5 Foreign_Zip_Code4;
			decimal3 Tele_Area_Code;
			decimal3 Tele_Prefix;
			decimal5 Tele_Number;
			decimal5 Revenue_Process_Yr;
			decimal3 Revenue_Process_Mth;
			decimal3 Revenue_Process_Day;
			ebcdic string1 File_Code;
			decimal5 Last_Maint_Yr;
			decimal3 Last_Maint_Mth;
			decimal3 Last_Maint_Day;
			decimal7 Last_Maint_Time;
			ebcdic string15 Last_Maint_User;
		end;
	end; 	
    //--------------------- end of Layouts_Raw_Input module--------------------//	
    //--------------------- Lookup Layout--------------------------------------//
	export Layouts_Lookup := module
	    
		export StateCodeLayout := record
			string StateCode;
			string StateDesc;
		end;
	    
	end;
	
	// Input Vendor Raw files
	export Files_Raw_Input := module
	
	    export IncorpIn(string filedate)       := dataset(Constants.cluster + 'in::corp2::'+filedate+'::CRINCPF::al', 
		                                                  Layouts_Raw_Input.Layout_Incorporator, flat);
		
		export OfficerIn(string filedate) 	   := dataset(Constants.cluster + 'in::corp2::'+filedate+'::CROFFPF::al', 
		                                                  Layouts_Raw_Input.Layout_Officer, flat);

        export NameIn(string filedate)         := dataset(Constants.cluster + 'in::corp2::'+filedate+'::CRNAMPF::al', 
		                                                  Layouts_Raw_Input.Layout_NameChange, flat);	
	
	    export ServiceIn(string filedate) 	   := dataset(Constants.cluster + 'in::corp2::'+filedate+'::CRSERPF::al', 
		                                                  Layouts_Raw_Input.Layout_Service, flat);
	
	    export BusinessIn(string filedate)     := dataset(Constants.cluster + 'in::corp2::'+filedate+'::CRBUSPF::al', 
		                                                  Layouts_Raw_Input.Layout_BusinessName, flat);
	
	    export HistoryIn(string filedate) 	   := dataset(Constants.cluster + 'in::corp2::'+filedate+'::CRHSTPF::al', 
		                                                  Layouts_Raw_Input.Layout_History, flat);
	
	    export AnnualReportIn(string filedate) := dataset(Constants.cluster + 'in::corp2::'+filedate+'::CRANLPF::al',
		                                                  Layouts_Raw_Input.Layout_AnnualReport, flat);
		
		export CorpMasterIn(string filedate)   := dataset(Constants.cluster + 'in::corp2::'+filedate+'::CRMSTPF::al', 
		                                                  Layouts_Raw_Input.Layout_CorpMaster, flat);
		
		// -------------------------- lookup...-------------------------------------------------------------//
		export StateCodeTable                  := dataset(_dataset().foreign_prod + Constants.cluster[2..] + 'lookup::corp2::StateCodeTable', 
		                                                  Layouts_Lookup.StateCodeLayout, 
		                                                  CSV(SEPARATOR([',']), TERMINATOR(['\r\n', '\n'])));
	    
	end;    
	

    //---------update function-------------------------------------------------------------------------------------//	
	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray,boolean pOverwrite = false) := function    
		
       //--------------------- Officer file layout starts ---------------------------------------------------------//	
		OfficeAddressLayout := Record 
			string6  CROACC;
			string36 CRORMC;
			string36 CRORAD;
			string21 CRORCT;
			string2  CRORST;
			string5  CRORZP;
			string4  CRORPL;
			string1  CROFCD;
			string4  CROMYR;
			string2  CROMMO;
			string2  CROMDY;
			string8  CROMTM;
			string15 CROMUR;			
		end;

		OfficeAddressLayout  trfOfficerToFixed(Layouts_Raw_Input.Layout_Officer l) := TRANSFORM
			self.CROACC	:=	trim(l.Account_Number,left,right);			
			self.CRORMC	:=	trim(l.Ofc_Of_Recs_Misc,left,right);
			self.CRORAD	:=	trim(l.Ofc_Of_Recs_Address,left,right);
			self.CRORCT	:=	trim(l.Ofc_Of_Recs_City,left,right); 
			self.CRORST	:=	trim(l.Ofc_Of_Recs_State,left,right);
			self.CRORZP	:=	trim((string)l.Ofc_Of_Recs_Zip_Code_1,left,right);
			self.CRORPL	:=	(string) intformat((integer)l.Ofc_Of_Recs_Zip_Code_2,4,1);
			self.CROFCD	:=	trim(l.File_Code,left,right);
			self.CROMYR	:=	trim((string)l.Last_Maint_Yr,left,right);
			self.CROMMO	:=	(string) intformat((integer)l.Last_Maint_Mth,2,1);
			self.CROMDY	:=	(string) intformat((integer)l.Last_Maint_Day,2,1);
			self.CROMTM	:=	trim((string)l.Last_Maint_Time,left,right);
			self.CROMUR	:=	trim(l.Last_Maint_User,left,right);
		end;
		
		OfficerFile	:= PROJECT(Files_Raw_Input.OfficerIn(filedate), trfOfficerToFixed(LEFT));		
        //--------------------- officer file layout end------------------------------------------------------------//
	
        //--------------------- Incorp fiel layout starts----------------------------------------------------------//			
		IncorporatorsFileLayout := Record
			string6  CRIACC;
			string4  CRISEQ;
			string36 CRIINM;
			string36 CRIIMC;
			string36 CRIIAD;
			string21 CRIICT;
			string2  CRIIST;
			string5  CRIIZP;
			string4  CRIIPL;
			string1  CRIFCD;
			string4  CRIMYR;
			string2  CRIMMO;
			string2  CRIMDY;
			string8  CRIMTM;
			string15 CRIMUR;			
		end;		

		IncorporatorsFileLayout	trfIncorpToFixed(Layouts_Raw_Input.Layout_Incorporator l) := TRANSFORM
			self.CRIACC :=	trim(l.Account_Number,left,right);
			self.CRISEQ :=	trim((string)l.Record_Sequence,left,right);
			self.CRIINM :=	trim(l.Incorporator_Name,left,right);	
			self.CRIIMC :=	trim(l.Incorporator_Misc,left,right);	
			self.CRIIAD :=	trim(l.Incorporator_Address,left,right);	
			self.CRIICT	:=	trim(l.Incorporator_City,left,right);	
			self.CRIIST :=	trim(l.Incorporator_State,left,right);	
			self.CRIIZP :=	(string) intformat((integer)l.Incorporator_Zip_Code_1,5,1);	
			self.CRIIPL :=	(string) intformat((integer)l.Incorporator_Zip_Code_2,4,1);
			self.CRIFCD :=	trim(l.Incorporator_File_Code,left,right);	
			self.CRIMYR :=	trim((string) l.Last_Maint_Yr,left,right);
			self.CRIMMO :=	(string) intformat((integer)l.Last_Maint_Mth,2,1);	
			self.CRIMDY :=	(string) intformat((integer)l.Last_Maint_Day,2,1);	
			self.CRIMTM :=	trim((string)l.Last_Maint_Time,left,right);	
			self.CRIMUR :=	trim(l.Last_Maint_User,left,right);	
		end;
		
		IncorpFile	:= PROJECT(Files_Raw_Input.IncorpIn(filedate), trfIncorpToFixed(LEFT));		
       //--------------------- Incorp file layout end--------------------------------------------------------------//	

       //--------------------- name file layout starts-------------------------------------------------------------//
	   NameChangesFileLayout := Record
			string6  CRNACC;
			string4  CRNHYR;
			string2  CRNHMO;
			string3  CRNHDY;
			string4  CRNTYP;
			string4  CRNSEQ;
			string64 CRNLN1;
			string60 CRNLN2;
			string64 CRNNAM;
			string6  CRNMRG;
			string1  CRNFCD;
			string4  CRNMYR;
			string2  CRNMMO;
			string2  CRNMDY;
			string8  CRNMTM;
			string15 CRNMUR;
		end;

		NameChangesFileLayout  trfNameToFixed(Layouts_Raw_Input.Layout_NameChange l) := TRANSFORM
			self.CRNACC	:=	trim(l.Account_Number,left,right);			
			self.CRNHYR	:=	trim((string)l.History_Yr,left,right);
			self.CRNHMO	:=	(string) intformat((integer)l.History_Mth,2,1);
			self.CRNHDY	:=	(string) intformat((integer)l.History_Day,2,1);
			self.CRNTYP	:=	trim((string)l.History_Type,left,right);
			self.CRNSEQ	:=	trim((string)l.Record_Sequence,left,right);
			self.CRNLN1	:=	trim(l.Legal_Name_1,left,right);
			self.CRNLN2	:=	trim(l.Legal_Name_2,left,right);
			self.CRNNAM	:=	trim(l.Search_Name,left,right);
			self.CRNMRG	:=	trim(l.Simultaneous_Merge,left,right);
			self.CRNFCD	:=	trim(l.File_Code,left,right);
			self.CRNMYR	:=	trim((string)l.Last_Maint_Yr,left,right);
			self.CRNMMO	:=	(string) intformat((integer)l.Last_Maint_Mth,2,1);
			self.CRNMDY	:=	(string) intformat((integer)l.Last_Maint_Day,2,1);
			self.CRNMTM	:=	trim((string)l.Last_Maint_Time,left,right);
			self.CRNMUR :=	trim(l.Last_Maint_User,left,right);	
		end;

		NameFile := PROJECT(Files_Raw_Input.NameIn(filedate), trfNameToFixed(LEFT));			
        //---------------------  name fiel layout end -------------------------------------------------------------//

        //---------------------  Service file layout  -------------------------------------------------------------//		
		ServiceofProcessFileLayout := Record
			string6  CRSACC; 
			string36 CRSPNM;
			string36 CRSPMC;
			string36 CRSPAD;
			string21 CRSPCT;
			string2  CRSPST;
			string5  CRSPZP;
			string4  CRSPPL;
			string1  CRSFCD;
			string4  CRSMYR;
			string2  CRSMMO;
			string2  CRSMDY;
			string8  CRSMTM;
			string15 CRSMUR;
		end;

		ServiceofProcessFileLayout  trfServiceToFixed(Layouts_Raw_Input.Layout_Service l) := TRANSFORM
			self.CRSACC	:=	trim(l.Account_Number,left,right);	 
			self.CRSPNM	:=	trim(l.Svc_of_Proc_Name,left,right);
			self.CRSPMC	:=	trim(l.Svc_of_Proc_Misc,left,right);
			self.CRSPAD	:=	trim(l.Svc_of_Proc_Address,left,right);
			self.CRSPCT	:=	trim(l.Svc_of_Proc_City,left,right);
			self.CRSPST	:=	trim(l.Svc_of_Proc_State,left,right);
			self.CRSPZP	:=	(string) intformat((integer)l.Svc_of_Proc_Zip_Code_1,5,1);
			self.CRSPPL	:=	(string) intformat((integer)l.Svc_of_Proc_Zip_Code_2,4,1);
			self.CRSFCD	:=	trim(l.File_Code,left,right);
			self.CRSMYR	:=	trim((string)l.Last_Maint_Yr,left,right);
			self.CRSMMO	:=	(string) intformat((integer)l.Last_Maint_Mth,2,1);
			self.CRSMDY	:=	(string) intformat((integer)l.Last_Maint_Day,2,1);
			self.CRSMTM	:=	trim((string)l.Last_Maint_Time,left,right);
			self.CRSMUR	:=	trim(l.Last_Maint_User,left,right);
		end;

		ServiceFile	:= PROJECT(Files_Raw_Input.ServiceIn(filedate), trfServiceToFixed(LEFT));
        //---------------------  service file layout end ----------------------------------------------------------//	

        //---------------------  business file layout starts ------------------------------------------------------//		 
		BusinessNameFileLayout := Record			
			string6  CRBACC;	
			string64 CRBLN1;	
			string60 CRBLN2;
			string64 CRBNAM;
			string1  CRBDCD;
			string1  CRBFCD;
			string4  CRBMYR;
			string2  CRBMMO;
			string2  CRBMDY;
			string8  CRBMTM;
			string15 CRBMUR;			
		end;

		BusinessNameFileLayout  trfBusinessToFixed(Layouts_Raw_Input.Layout_BusinessName l) := TRANSFORM
			self.CRBACC :=	trim(l.Account_Number,left,right);
			self.CRBLN1 :=	trim(l.Legal_Name_1,left,right);	
			self.CRBLN2 :=	trim(l.Legal_Name_2,left,right);	
			self.CRBNAM :=	trim(l.Search_Name,left,right);	
			self.CRBDCD :=	trim(l.Dissolve_Code,left,right);	
			self.CRBFCD :=	trim(l.File_Code,left,right);	
			self.CRBMYR :=	trim((string)l.Last_Maint_Yr,left,right);
			self.CRBMMO :=	(string) intformat((integer)l.Last_Maint_Mth,2,1); 	
			self.CRBMDY :=	(string) intformat((integer)l.Last_Maint_Day,2,1);	
			self.CRBMTM :=	trim((string)l.Last_Maint_Time,left,right);
			self.CRBMUR :=	trim(l.Last_Maint_User,left,right);
		end;

		BusinessFile	:= PROJECT(Files_Raw_Input.BusinessIn(filedate), trfBusinessToFixed(LEFT));		
	    //---------------------  business file layout ends --------------------------------------------------------//

        //---------------------  history file layout starts -------------------------------------------------------//		
		HistoryFileLayout := Record
			string6   CRHACC;
			string4   CRHHYR;
			string2   CRHHMO;
			string2   CRHHDY;					
			string4   CRHTYP;
			string4   CRHSEQ;
			string148 CRHLIN;	
			string1   CRHFCD;			
			string4   CRHMYR;
			string2   CRHMMO;
			string2   CRHMDY;
			string8   CRHMTM;
			string15  CRHMUR;
		end;
				
		HistoryFileLayout HistoryTransFixed(Layouts_Raw_Input.Layout_History l) := TRANSFORM
			self.CRHACC :=	trim(l.Account_Number,left,right);			
			self.CRHHYR :=	trim((string)l.History_Yr,left,right);
			self.CRHHMO :=	(string) intformat((integer)l.History_Mth,2,1);
			self.CRHHDY :=	(string) intformat((integer)l.History_Day,2,1);
			self.CRHTYP :=	trim((string)l.History_Type,left,right);
			self.CRHSEQ :=	trim((string)l.Record_Sequence,left,right);
			self.CRHLIN :=	trim(l.Legal_Name_1,left,right);
			self.CRHFCD :=	trim(l.File_Code,left,right);
			self.CRHMYR :=	trim((string)l.Last_Maint_Yr,left,right);
			self.CRHMMO :=	(string) intformat((integer)l.Last_Maint_Mth,2,1);
			self.CRHMDY :=	(string) intformat((integer)l.Last_Maint_Day,2,1);
			self.CRHMTM :=	trim((string)l.Last_Maint_Time,left,right);
			self.CRHMUR :=	trim(l.Last_Maint_User,left,right);	
		end;
		
		HistoryFile	:= PROJECT(Files_Raw_Input.HistoryIn(filedate), HistoryTransFixed(LEFT));
        //--------------------- history fiel layout end -----------------------------------------------------------//	

        //--------------------- Annual file layout start-----------------------------------------------------------//
		AnnualLayout := record
			string6	  CRAACC;
			string6	  CRARYR;
			string64  CRACNM;
			string36  CRACMC;
			string36  CRACAD;
			string21  CRACCT;
			string2	  CRACST;
			string10  CRACZP;
			string10  CRACPL;
			string36  CRAANM;
			string36  CRAAMC;
			string36  CRAAAD;
			string21  CRAACT;
			string2	  CRAAST;
			string10  CRAAZP;
			string10  CRAAPL;
			string36  CRAPNM;
			string36  CRAPMC;
			string36  CRAPAD;
			string21  CRAPCT;
			string2	  CRAPST;
			string10  CRAPZP;
			string10  CRAPPL;
			string36  CRASNM;
			string36  CRASMC;
			string36  CRASAD;
			string21  CRASCT;
			string2	  CRASST;
			string5   CRASZP;
			string4   CRASPL;
			string64  CRABNM;
			string36  CRABMC;
			string36  CRABAD;
			string21  CRABCT;
			string2	  CRABST;
			string10  CRABZP;
			string10  CRABPL;
			string64  CRAFNM;
			string36  CRAFMC;
			string36  CRAFAD;
			string21  CRAFCT;
			string2	  CRAFST;
			string6	  CRAFZP;
			string6	  CRAFPL;
			string3	  CRATL1;
			string3	  CRATL2;
			string4	  CRATL3;
			string4	  CRAPYR;
			string2	  CRAPMO;
			string2	  CRAPDY;
			string1	  CRAFCD;
			string4	  CRAMYR;
			string2	  CRAMMO;
			string2	  CRAMDY;
			string8	  CRAMTM;
			string15  CRAMUR;
		end;

		AnnualLayout trfARToFixed(Layouts_Raw_Input.Layout_AnnualReport l) := TRANSFORM
			self.CRAACC	:= trim(l.Account_Number,left,right);
			self.CRARYR	:= trim((string)l.Annual_Report_Yr,left,right);
			self.CRACNM	:= trim(l.Current_Name,left,right);
			self.CRACMC	:= trim(l.Current_Misc,left,right);
			self.CRACAD	:= trim(l.Current_Address,left,right);
			self.CRACCT	:= trim(l.Current_City,left,right);
			self.CRACST	:= trim(l.Current_State,left,right);
			self.CRACZP	:= (string) intformat((integer)l.Current_Zip_Code5,5,1);
			self.CRACPL	:= (string) intformat((integer)l.Current_Zip_Code4,4,1);
			self.CRAANM	:= trim(l.Agent_Name,left,right);
			self.CRAAMC	:= trim(l.Agent_Misc,left,right);
			self.CRAAAD	:= trim(l.Agent_Address,left,right);
			self.CRAACT	:= trim(l.Agent_City,left,right);
			self.CRAAST	:= trim(l.Agent_State,left,right);
			self.CRAAZP	:= (string) intformat((integer)l.Agent_Zip_Code5,5,1);
			self.CRAAPL	:= (string) intformat((integer)l.Agent_Zip_Code4,4,1);
			self.CRAPNM	:= trim(l.President_Name,left,right);
			self.CRAPMC	:= trim(l.President_Misc,left,right);
			self.CRAPAD	:= trim(l.President_Address,left,right);
			self.CRAPCT	:= trim(l.President_City,left,right);
			self.CRAPST	:= trim(l.President_State,left,right);
			self.CRAPZP	:= (string) intformat((integer)l.President_Zip_Code5,5,1);
			self.CRAPPL	:= (string) intformat((integer)l.President_Zip_Code4,4,1);
			self.CRASNM	:= trim(l.Secretary_Name,left,right);
			self.CRASMC	:= trim(l.Secretary_Misc,left,right);
			self.CRASAD	:= trim(l.Secretary_Address,left,right);
			self.CRASCT	:= trim(l.Secretary_City,left,right);
			self.CRASST	:= trim(l.Secretary_State,left,right);
			self.CRASZP	:= (string) intformat((integer)l.Secretary_Zip_Code5,5,1);
			self.CRASPL	:= (string) intformat((integer)l.Secretary_Zip_Code4,4,1);
			self.CRABNM	:= trim(l.Business_Type,left,right);
			self.CRABMC	:= trim(l.Business_Misc,left,right);
			self.CRABAD	:= trim(l.Business_Address,left,right);
			self.CRABCT	:= trim(l.Business_City,left,right);
			self.CRABST	:= trim(l.Business_State,left,right);
			self.CRABZP	:= (string) intformat((integer)l.Business_Zip_Code5,5,1);
			self.CRABPL	:= (string) intformat((integer)l.Business_Zip_Code4,4,1);
			self.CRAFNM	:= trim(l.Foreign_Type,left,right);
			self.CRAFMC	:= trim(l.Foreign_Misc,left,right);
			self.CRAFAD	:= trim(l.Foreign_Address,left,right);
			self.CRAFCT	:= trim(l.Foreign_City,left,right);
			self.CRAFST	:= trim(l.Foreign_State,left,right);
			self.CRAFZP := (string) intformat((integer)l.Foreign_Zip_Code5,5,1);
			self.CRAFPL := (string) intformat((integer)l.Foreign_Zip_Code4,4,1);
			self.CRATL1 := trim((string)l.Tele_Area_Code,left,right);
			self.CRATL2 := (string) intformat((integer)l.Tele_Prefix,3,1);
			self.CRATL3 := (string) intformat((integer)l.Tele_Number,4,1);
			self.CRAPYR := trim((string)l.Revenue_Process_Yr,left,right);
			self.CRAPMO := (string) intformat((integer)l.Revenue_Process_Mth,2,1);
			self.CRAPDY := (string) intformat((integer)l.Revenue_Process_Day,2,1);
			self.CRAFCD := trim(l.File_Code,left,right);			
			self.CRAMYR := trim((string)l.Last_Maint_Yr,left,right);
			self.CRAMMO := (string) intformat((integer)l.Last_Maint_mth,2,1);
			self.CRAMDY := (string) intformat((integer)l.Last_Maint_day,2,1);
			self.CRAMTM := trim((string)l.Last_Maint_time,left,right);
			self.CRAMUR := trim(l.Last_Maint_User,left,right);	
		end;

		ArFile	:= PROJECT(Files_Raw_Input.AnnualReportIn(filedate), trfARToFixed(LEFT));
        //--------------------- annual file end--------------------------------------------------------------------//	
 
        //--------------------- corp file layout start ------------------------------------------------------------//
		CorpMasterLayout := record
			string6  CRMACC;
			string64 CRMLN1;
			string60 CRMLN2;
			string64 CRMNAM;
			string36 CRMPMC;
			string36 CRMPAD;
			string21 CRMPCT;
			string2  CRMPST;
			string10 CRMPZP;
			string10 CRMPPL;
			string3  CRMTYP;
			string2  CRMIMO;
			string2  CRMIDY;
			string4  CRMIYR;
			string2  CRMPLC;
			string15 CRMAUT;
			string15 CRMPIN;
			string1  CRMDCD;
			string1  CRMDSC;
			string4  CRMDMO;
			string4  CRMDDY;
			string6  CRMDYR;
			string36 CRMANM;
			string36 CRMAMC;
			string36 CRMAAD;
			string21 CRMACT;
			string2  CRMAST;
			string10 CRMAZP;
			string10 CRMAPL;
			string4  CRMAMO;
			string4	 CRMADY;
			string6  CRMAYR;
			string64 CRMBUS;
			string2  CRMFMO;
			string2  CRMFDY;
			string4  CRMFYR;
			string6  CRMMRG;
			string64 CRMCOM;
			string4  CRMINC;
			string1  CRMFNF;
			string1  CRMORF;
			string1  CRMSPF;
			string1  CRMFCD;
			string4  CRMMYR;
			string2  CRMMMO;
			string2  CRMMDY;
			string8  CRMMTM;
			string15 CRMMUR;
		end;
		
		CorpMasterLayout trfCorpToFixed(Layouts_Raw_Input.Layout_CorpMaster l) := TRANSFORM
			self.CRMACC := trim(l.Account_Number ,left,right);
			self.CRMLN1 := trim(l.Legal_Name_Line1 ,left,right);
			self.CRMLN2 := trim(l.Legal_Name_Line2,left,right);
			self.CRMNAM	:= trim(l.Search_Name,left,right);

			self.CRMPMC := trim(l.Principal_Misc,left,right);
			self.CRMPAD := trim(l.Principal_Address ,left,right);
			self.CRMPCT := trim(l.Principal_City,left,right);
			self.CRMPST := trim(l.Principal_State ,left,right);
			self.CRMPZP := (string) intformat((integer)l.Principal_Zip1,5,1);
			self.CRMPPL := (string) intformat((integer)l.Principal_Zip2,4,1);
			self.CRMTYP := trim(l.Type_of_Filing,left,right);

			self.CRMIMO := (string) intformat((integer)l.Incorporation_Qualification_Month,2,1);
			self.CRMIDY := (string) intformat((integer)l.Incorporation_Qualification_Day,2,1);
			self.CRMIYR := trim((string)l.Incorporation_Qualification_Year,left,right);
		 
			self.CRMPLC := trim(l.Place_of_Incorporation ,left,right);
			self.CRMAUT := trim(l.Authorized_Capital ,left,right);
			self.CRMPIN := trim(l.Paid_in_Capital ,left,right);
			self.CRMDCD := trim(l.Dissolve_Code ,left,right);
			self.CRMDSC := trim(l.Dissolve_Sub_code ,left,right);

			self.CRMDMO := (string) intformat((integer)l.Dissolve_Month,2,1);
			self.CRMDDY := (string) intformat((integer)l.Dissolve_Day,2,1);
			self.CRMDYR := trim((string)l.Dissolve_Year,left,right);

			self.CRMANM := trim(l.Registered_Agent_Name ,left,right);
			self.CRMAMC := trim(l.Registered_Agent_Misc,left,right);
			self.CRMAAD := trim(l.Registered_Agent_Address ,left,right);
			self.CRMACT := trim(l.Registered_Agent_City ,left,right);
			self.CRMAST := trim(l.Registered_Agent_State ,left,right);
			self.CRMAZP := (string) intformat((integer)l.Registered_Agent_Zip1_Code,5,1);
			self.CRMAPL := (string) intformat((integer)l.Registered_Agent_Zip2_Code,4,1);

			self.CRMAMO := (string) intformat((integer)l.Agent_Resign_Month,2,1);
			self.CRMADY := (string) intformat((integer)l.Agent_Resign_Day,2,1);
			self.CRMAYR := trim((string)l.Agent_Resign_Year,left,right);
			
			self.CRMBUS := trim(l.Nature_of_Business,left,right); 

			self.CRMFMO := (string) intformat((integer)l.Formed_Month,2,1);
			self.CRMFDY := (string) intformat((integer)l.Formed_Day,2,1);
			self.CRMFYR := trim((string)l.Formed_Year,left,right);
			
			self.CRMMRG := trim(l.Merge_Consolidate_to_Account,left,right);
			
			self.CRMCOM := trim(l.Account_Comments ,left,right);
			self.CRMINC := trim((string)l.Last_Incorporation_Number,left,right);
			self.CRMFNF := trim(l.Fictitious_Registered_Name,left,right);
			self.CRMORF := trim(l.Office_of_Records,left,right);
			self.CRMSPF := trim(l.Service_of_Process,left,right);
			self.CRMFCD := trim(l.File_Code,left,right);

			self.CRMMYR := trim((string)l.Last_Maintenance_Year,left,right);
			self.CRMMMO := (string) intformat((integer)l.Last_Maintenance_Month,2,1);
			self.CRMMDY := (string) intformat((integer)l.Last_Maintenance_Day,2,1);			
			self.CRMMTM := trim((string)l.Last_Maintenance_Time,left,right);
			self.CRMMUR := trim(l.Last_Maintenance_User,left,right);
		end;

		CorpFile := PROJECT(Files_Raw_Input.CorpMasterIn(filedate), trfCorpToFixed(LEFT));

	    sortOfficers := sort(ArFile, CRAACC);

	    distofficers := distribute(sortOfficers,hash64(CRAACC));
		
		//--------------- Start Combo file layout for joins ------------------------------------------------------//
		MasterCorpOfficerLayout := record
			CorpMasterLayout;
			OfficeAddressLayout;
		end;

		MasterCorpAnnualReportLayout := record			
			CorpMasterLayout;
			AnnualLayout;
		end;
		
		MasterCorpAnnualReportServiceLayout	:= record
		    CorpMasterLayout;
			AnnualLayout;
			ServiceofProcessFileLayout;
		end;
		
		AnnualReportIncorpLayout := record
		    AnnualLayout;
			IncorporatorsFileLayout;
		end;
        //---------------End Combo file layout for joins ---------------------------------------------------------//
		
		//-----------------------merge between annual report and corp master-------------------------------------------//
		MasterCorpAnnualReportLayout MergeCorpWithAnnual(CorpMasterLayout l, AnnualLayout r ) := transform
			self := l;
			self := r;
			self := [];
		end; 
		
		joinAnnualWithCorp := join(CorpFile, ArFile,
								   trim(left.CRMACC, left, right) = right.CRAACC,
								   MergeCorpWithAnnual(left,right),
								   left outer);
								   
		//------------------------------------merge annual report, corp master and service------------------------//
		MasterCorpAnnualReportServiceLayout MergeCorpAnnualWithService(MasterCorpAnnualReportLayout l, ServiceofProcessFileLayout r ) := transform
			self := l;
			self := r;
			self := [];
		end; 

		// JOIN corp master, annual report WITH SERVICE
		joinAnnualCorpWithService := join(joinAnnualWithCorp ,ServiceFile,
										  trim(left.CRMACC, left, right) = right.CRSACC,
										  MergeCorpAnnualWithService(left,right),
										  left outer);
		
		
		// JOIN master with Officer file
		MasterCorpOfficerLayout MergeCorpWithOfficer(OfficeAddressLayout l, CorpMasterLayout r) := transform
			self := l;
			self := r;
			self := [];
		end; 

		joinCorpWithOfficer := join(OfficerFile, CorpFile,
									trim(left.CROACC, left, right) = trim(right.CRMACC,left,right),
									MergeCorpWithOfficer(left,right),
									left outer);

		//---------------------corp main transform----------------------------------------------------------------//
		Corp2_Mapping.Layout_CorpPreClean AL_corpMainTransform(MasterCorpAnnualReportServiceLayout input):= transform, 
												skip (trim(regexreplace('\\x80',input.CRMLN1,' '),left,right) + 
													  trim(regexreplace('\\x80',input.CRMLN2,' '),left,right) = '' )
		
			self.corp_key						:= '01-' +trim(input.CRMACC, left, right);		
			self.corp_vendor					:= '01';		
			self.corp_state_origin				:= 'AL';
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trim(input.CRMACC,left,right);
			self.corp_src_type					:= 'SOS';

			self.corp_orig_org_structure_cd		:= if ( trim(input.CRMTYP,left,right) <> '', stringlib.StringtoUpperCase(trim(input.CRMTYP,left,right)),'');
		
			self.corp_orig_org_structure_desc	:= if ( trim(input.CRMTYP,left,right) <> '', 
														map(trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='D/C'=>'DOMESTIC FOR PROFIT CORPORATION',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='DLL'=>'DOMESTIC LIMITED LIABILITY COMPANY',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='DLP'=>'DOMESTIC LIMITED PARTNERSHIP',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='DNP'=>'DOMESTIC NONPROFIT CORPORATION',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='DNR'=>'DOMESTIC NAME RESERVATION',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='DPA'=>'DOMESTIC PROFESSIONAL ASSOCIATION',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='DPC'=>'DOMESTIC PROFESSIONAL CORPORATION',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='DRP'=>'DOMESTIC LIMITED LIABILITY PARTNERSHIP',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='DRT'=>'DOMESTIC REAL ESTATE INVESTMENT TRUST',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='F/C'=>'FOREIGN FOR PROFIT CORPORATION',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='FIC'=>'FOREIGN INSURANCE CORPORATION',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='FLL'=>'FOREIGN LIMITED LIABILITY COMPANY',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='FLP'=>'FOREIGN LIMITED PARTNERSHIP',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='FNP'=>'FOREIGN NONPROFIT CORPORATION',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='FNA'=>'FOREIGN NAME AVAILABLE',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='FNR'=>'FOREIGN NAME REGISTRATION',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='FPA'=>'FOREIGN PROFESSIONAL ASSOCIATION',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='FPC'=>'FOREIGN PROFESSIONAL CORPORATION',
															trim(stringlib.StringtoUpperCase(input.CRMTYP),left,right)='FRP'=>'FOREIGN LIMITED LIABILITY PARTNERSHIP',											
															''),'');

			string8 statusDate					:= if ( (integer)(trim(input.CRMDYR,left,right) + trim(input.CRMDMO,left,right) + trim(input.CRMDDY,left,right)) <> 0,
														trim(input.CRMDYR,left,right) + trim(input.CRMDMO,left,right) + trim(input.CRMDDY,left,right),'');

			self.corp_status_date				:= if ( trim(statusDate,left,right) <> '', trim(statusDate,left,right), '');

			self.corp_status_cd				    := if ( trim(input.CRMDCD,left,right) <> '', 
														stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMDCD,' '),left,right)), '');

			self.corp_status_desc			    := map(trim(self.corp_status_cd) = 'C' => 'CANCELLED',
													   trim(self.corp_status_cd) = 'D' => 'DISSOLVED',
													   trim(self.corp_status_cd) = 'M' => 'MERGED',
													   trim(self.corp_status_cd) = 'P' => 'PREVIOUS NAME',
													   trim(self.corp_status_cd) = 'R' => 'REVOKED',
													   trim(self.corp_status_cd) = 'W' => 'WITHDRAWN',
													   trim(self.corp_status_cd) = 'X' => 'ACTIVE',
													   trim(self.corp_status_cd) = ''  => 'ACTIVE',
													   '');

			self.corp_status_comment 		    := map(stringlib.StringtoUpperCase(trim(input.CRMDSC,left,right)) = 'J' => 'JUDICIALLY',
													   stringlib.StringtoUpperCase(trim(input.CRMDSC,left,right)) = 'A' => 'ADMINISTRATIVELY',
													   stringlib.StringtoUpperCase(trim(input.CRMDSC,left,right)) = 'V' => 'VOLUNTARILY',																					
													   '');

			string8 incDate					    := if ( trim(input.CRMIYR,left,right) + trim(input.CRMIMO,left,right) + trim(input.CRMIDY,left,right) <> '' and
														(integer)(trim(input.CRMIYR,left,right) + trim(input.CRMIMO,left,right) + trim(input.CRMIDY,left,right)) <> 0,
														trim(input.CRMIYR,left,right) + trim(input.CRMIMO,left,right) + trim(input.CRMIDY,left,right),'');

			self.corp_inc_date				    := if ( trim(incDate,left,right)<>'' and ut.isNumeric(input.CRMPLC),lib_stringlib.stringlib.stringfilterout(trim(incDate,left,right),'?'),'');

			string8 forgnDate					:= if ( trim(input.CRMFYR,left,right) + trim(input.CRMFMO,left,right) + trim(input.CRMFDY,left,right) <> '' and
														(integer)(trim(input.CRMFYR,left,right) + trim(input.CRMFMO,left,right) + trim(input.CRMFDY,left,right)) <> 0,
														trim(input.CRMFYR,left,right) + trim(input.CRMFMO,left,right) + trim(input.CRMFDY,left,right),'');

			self.corp_forgn_date				:= if ( trim(forgnDate,left,right) <> '' and NOT ut.isNumeric(input.CRMPLC), trim(forgnDate,left,right),'');

			self.corp_addl_info				    := if ( trim(incDate,left,right) <> '' and NOT ut.isNumeric(input.CRMPLC), 'QUALIFICATION DATE: ' + trim(incDate,left,right),'');

			self.corp_inc_state				    := if ( trim(input.CRMPLC,left,right)  <>'' and ut.isNumeric(input.CRMPLC), 'AL','');
			
			self.corp_inc_county			    := map(trim(input.CRMPLC,left,right) = '01' => 'AUTAUGA',
													   trim(input.CRMPLC,left,right) = '02' => 'BALDWIN',
													   trim(input.CRMPLC,left,right) = '03' => 'BARBOUR',
													   trim(input.CRMPLC,left,right) = '04' => 'BIBB',
													   trim(input.CRMPLC,left,right) = '05' => 'BLOUNT',
													   trim(input.CRMPLC,left,right) = '06' => 'BULLOCK',
													   trim(input.CRMPLC,left,right) = '07' => 'BUTLER',
													   trim(input.CRMPLC,left,right) = '08' => 'CALHOUN',
													   trim(input.CRMPLC,left,right) = '09' => 'CHAMBERS',
													   trim(input.CRMPLC,left,right) = '10' => 'CHEROKEE',
													   trim(input.CRMPLC,left,right) = '11' => 'CHILTON',
													   trim(input.CRMPLC,left,right) = '12' => 'CHOCTAW',
													   trim(input.CRMPLC,left,right) = '13' => 'CLARKE',
													   trim(input.CRMPLC,left,right) = '14' => 'CLAY',
													   trim(input.CRMPLC,left,right) = '15' => 'CLEBURNE',
													   trim(input.CRMPLC,left,right) = '16' => 'COFFEE',
													   trim(input.CRMPLC,left,right) = '17' => 'COLBERT',
													   trim(input.CRMPLC,left,right) = '18' => 'CONECUH',
													   trim(input.CRMPLC,left,right) = '19' => 'COOSA',
													   trim(input.CRMPLC,left,right) = '20' => 'COVINGTON',
													   trim(input.CRMPLC,left,right) = '21' => 'CRENSHAW',
													   trim(input.CRMPLC,left,right) = '22' => 'CULLMAN',
													   trim(input.CRMPLC,left,right) = '23' => 'DALE',
													   trim(input.CRMPLC,left,right) = '24' => 'DALLAS',
													   trim(input.CRMPLC,left,right) = '25' => 'DEKALB',
													   trim(input.CRMPLC,left,right) = '26' => 'ELMORE',
													   trim(input.CRMPLC,left,right) = '27' => 'ESCAMBIA',
													   trim(input.CRMPLC,left,right) = '28' => 'ETOWAH',
													   trim(input.CRMPLC,left,right) = '29' => 'FAYETTE',
													   trim(input.CRMPLC,left,right) = '30' => 'FRANKLIN',
													   trim(input.CRMPLC,left,right) = '31' => 'GENEVA',
													   trim(input.CRMPLC,left,right) = '32' => 'GREENE',
													   trim(input.CRMPLC,left,right) = '33' => 'HALE',
													   trim(input.CRMPLC,left,right) = '34' => 'HENRY',
													   trim(input.CRMPLC,left,right) = '35' => 'HOUSTON',
													   trim(input.CRMPLC,left,right) = '36' => 'JACKSON',
													   trim(input.CRMPLC,left,right) = '37' => 'JEFFERSON',
													   trim(input.CRMPLC,left,right) = '38' => 'LAMAR',
													   trim(input.CRMPLC,left,right) = '39' => 'LAUDERDALE',
													   trim(input.CRMPLC,left,right) = '40' => 'LAWRENCE',
													   trim(input.CRMPLC,left,right) = '41' => 'LEE',
													   trim(input.CRMPLC,left,right) = '42' => 'LIMESTONE',
													   trim(input.CRMPLC,left,right) = '43' => 'LOWNDES',
													   trim(input.CRMPLC,left,right) = '44' => 'MACON',
													   trim(input.CRMPLC,left,right) = '45' => 'MADISON',
													   trim(input.CRMPLC,left,right) = '46' => 'MARENGO',
													   trim(input.CRMPLC,left,right) = '47' => 'MARION',
													   trim(input.CRMPLC,left,right) = '48' => 'MARSHALL',
													   trim(input.CRMPLC,left,right) = '49' => 'MOBILE',
													   trim(input.CRMPLC,left,right) = '50' => 'MONROE',
													   trim(input.CRMPLC,left,right) = '51' => 'MONTGOMERY',
													   trim(input.CRMPLC,left,right) = '52' => 'MORGAN',
													   trim(input.CRMPLC,left,right) = '53' => 'PERRY',
													   trim(input.CRMPLC,left,right) = '54' => 'PICKENS',
													   trim(input.CRMPLC,left,right) = '55' => 'PIKE',
													   trim(input.CRMPLC,left,right) = '56' => 'RANDOLPH',
													   trim(input.CRMPLC,left,right) = '57' => 'RUSSELL',
													   trim(input.CRMPLC,left,right) = '58' => 'SAINT CHAIR',
													   trim(input.CRMPLC,left,right) = '59' => 'SHELBY',
													   trim(input.CRMPLC,left,right) = '60' => 'SUMTER',
													   trim(input.CRMPLC,left,right) = '61' => 'TALLADEGA',
													   trim(input.CRMPLC,left,right) = '62' => 'TALLAPOOSA',
													   trim(input.CRMPLC,left,right) = '63' => 'TUSCALOOSA',
													   trim(input.CRMPLC,left,right) = '64' => 'WALKER',
													   trim(input.CRMPLC,left,right) = '65' => 'WASHINGTON',
													   trim(input.CRMPLC,left,right) = '66' => 'WILCOX',
													   trim(input.CRMPLC,left,right) = '67' => 'WINSTON',
													   '');

			self.corp_forgn_state_cd				:= if ( trim(input.CRMPLC,left,right) <> '' and NOT ut.isNumeric(input.CRMPLC) and
															trim(stringlib.StringtoUpperCase(input.CRMPLC),left,right) <> 'AL',
															trim(stringlib.StringtoUpperCase(input.CRMPLC),left,right),'');	
		
			//---------------------merg of annual file and corp file---------------------------------------------------//
			self.corp_orig_bus_type_desc		    := if ( trim(input.CRMBUS,left,right) not in ['','---'],  
															if (trim(input.CRABNM,left,right) <> '', 
															    stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMBUS,' '),left,right) +'; '+ trim(regexreplace('\\x80',input.CRABNM,' '),left,right)),
														        stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMBUS,' '),left,right))),
															if (trim(input.CRABNM,left,right) <> '', trim(regexreplace('\\x80',input.CRABNM,' '),left,right), ''));

			self.corp_legal_name					:= if ( trim(regexreplace('\\x80',input.CRMLN1,' '),left,right) + 
															trim(regexreplace('\\x80',input.CRMLN2,' '),left,right) <> '' , 
															trim(StringLib.StringCleanSpaces(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRMLN1,' ')) +
															                                 stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRMLN2,' '))),left,right),'') ;

			self.corp_ln_name_type_cd				:= if ( trim(input.CRMLN1 + input.CRMLN2,left,right) <> '','01','');

			self.corp_ln_name_type_desc				:= if ( trim(input.CRMLN1 + input.CRMLN2,left,right) <> '','LEGAL','');
		
			self.CORP_ADDRESS1_TYPE_CD				:= if ( trim(stringlib.StringtoUpperCase(input.CRMPST),left,right) = 'OC', 'B','');
			
			self.CORP_ADDRESS1_TYPE_DESC			:= if ( trim(stringlib.StringtoUpperCase(input.CRMPST),left,right) = 'OC', 'BUSINESS','');
			
			self.CORP_ADDRESS1_LINE1				:= if ( trim(input.CRMPMC,left,right) <> '',
															stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMPMC,' '),left,right)),
															if ( trim(input.CRACMC,left,right) <> '',
																 stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRACMC,' '),left,right)),
																 '')
															  );

			self.CORP_ADDRESS1_LINE2				:= if ( trim(input.CRMPAD,left,right) <> '',
															stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMPAD,' '),left,right)),
															if ( trim(input.CRACAD,left,right) <> '',
																 stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRACAD,' '),left,right)),
																 '')
														  );

			self.CORP_ADDRESS1_LINE3				:= if ( trim(input.CRMPCT,left,right) <> '',
															stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMPCT,' '),left,right)),
															if ( trim(input.CRACCT,left,right) <> '',
																 stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRACCT,' '),left,right)),
																 '')
														);
			
			self.CORP_ADDRESS1_LINE4				:= if ( stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMPST,' '),left,right)) <> 'OC',
															stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMPST,' '),left,right)),
															if ( trim(input.CRACST,left,right) <> '',
																 stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRACST,' '),left,right)),
																 '')
														);

			self.CORP_ADDRESS1_LINE5				:= if ( (integer)input.CRMPZP <> 0,
			                                                if ( (integer)input.CRMPPL <> 0, 
																 trim(input.CRMPZP,left,right) + trim(input.CRMPPL,left,right),
															     trim(input.CRACZP,left,right)),
															'');
			
			self.corp_address2_line1				:= if ( trim(input.CRSPMC,left,right) <> '',
															trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRSPMC,' ')),left,right),
															'');

			self.corp_address2_line2				:= if ( trim(input.CRSPAD,left,right) <> '',
															trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRSPAD,' ')),left,right),
															'');

			self.corp_address2_line3				:= if ( trim(input.CRSPCT,left,right) <> '',
															trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRSPCT,' ')),left,right),
															'');

			self.corp_address2_line4				:= if ( trim(input.CRSPST,left,right) <> '',
															trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRSPST,' ')),left,right),
															'');

			self.corp_address2_line5				:= if ( (integer)input.CRSPZP  <> 0,
			                                                if( (integer)input.CRSPPL <> 0,
															     trim(input.CRSPZP,left,right) + trim(input.CRSPPL,left,right),
																 trim(input.CRSPZP,left,right)),
															'');
			
			self.corp_address2_type_cd				:= if ( trim(input.CRSPMC,left,right) <> '' or
															trim(input.CRSPAD,left,right) <> '' or
															trim(input.CRSPCT,left,right) <> '','P','');

			self.corp_address2_type_desc			:= if ( trim(input.CRSPMC,left,right) <> '' or
															trim(input.CRSPAD,left,right) <> '' or
															trim(input.CRSPCT,left,right) <> '','PROCESS','');

			//------------merge with ar to get telephone number--------------------------------------------------------//

			self.corp_phone_number					:= if ( (integer)(input.CRATL1 + input.CRATL2 + input.CRATL3) <> 0,
															trim(input.CRATL1,left,right) + trim(input.CRATL2,left,right) + trim(input.CRATL3,left,right),
															'');

			self.Corp_phone_number_type_desc		:= if ( trim(self.corp_phone_number) <> '', 'BUSINESS', '');

			self.corp_ra_name						:= if ( trim(input.CRMANM,left,right) <> '', stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMANM,' '),left,right)),'') ;

			self.corp_ra_resign_date				:= if ( (integer)(input.CRMAYR + input.CRMAMO + input.CRMADY) <> 0 ,
															trim(input.CRMAYR,left,right) + trim(input.CRMAMO,left,right) + trim(input.CRMADY,left,right),
															'');

			self.CORP_RA_ADDRESS_LINE1				:= if ( trim(input.CRMAMC,left,right) <> '',
															stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMAMC,' '),left,right)),
															'');

			self.CORP_RA_ADDRESS_LINE2				:= if ( trim(input.CRMAAD,left,right) <> '',
															stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMAAD,' '),left,right)),
															'');

			self.CORP_RA_ADDRESS_LINE3				:= if ( trim(input.CRMACT,left,right) <> '',
															stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMACT,' '),left,right)),
															'');

			self.CORP_RA_ADDRESS_LINE4				:= if ( trim(input.CRMAST,left,right) <> '',
															stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRMAST,' '),left,right)),
															'');

			self.CORP_RA_ADDRESS_LINE5				:= if ( (integer)input.CRMAZP <> 0,
															if ( (integer)input.CRMAPL <> 0,
															     trim(input.CRMAZP,left,right) + trim(input.CRMAPL,left,right),
																 trim(input.CRMAZP,left,right)),
															'');
			self									:= [];
		end;
		
		mapCorp  := project(joinAnnualCorpWithService, AL_corpMainTransform(LEFT));
		
		//---------------------main corp transform ends----------------------------------------------------------------//

		//---------------------corp name change transform starts-------------------------------------------------------//
		Corp2_Mapping.Layout_CorpPreClean AL_corpNameChangeTransform(NameChangesFileLayout input) := transform, 
											   skip (trim(regexreplace('\\x80',input.CRNLN1,' '),left,right) = '' or
													 trim(input.CRNTYP,left,right) not in ['01','02','03','04','05','1','2','3','4','5'])

			self.corp_vendor				:= '01';		
			self.corp_state_origin			:= 'AL';
			self.corp_key					:= '01-' +trim(input.CRNACC, left, right);		
			self.dt_vendor_first_reported	:= fileDate;
			self.dt_vendor_last_reported	:= fileDate;
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;
			self.corp_ra_dt_first_seen		:= fileDate;
			self.corp_ra_dt_last_seen		:= fileDate;
			self.corp_process_date			:= fileDate;
			self.corp_orig_sos_charter_nbr	:= trim(input.CRNACC,left,right);
			self.corp_src_type				:= 'SOS';

			dateField						:= if( trim(input.CRNHYR,left,right) + trim(input.CRNHMO,left,right) + trim(input.CRNHDY,left,right) <> '' and
												   (integer)trim(input.CRNHYR + input.CRNHMO + input.CRNHDY,left,right) <> 0,
												   trim(input.CRNHYR,left,right) + '0' + trim(input.CRNHMO,left,right) + '0'+ trim(input.CRNHDY,left,right),'');

			self.corp_filing_date			:= if( trim(input.CRNTYP,left,right) in ['01','02','03','1','2','3'],
												   if ( trim(dateField,left,right) <> '',
														trim(dateField,left,right), ''),
											'');

			self.corp_legal_name			:= if( trim(input.CRNLN1,left,right) +
			                                       trim(input.CRNLN2,left,right) <> '',
												   trim(StringLib.StringCleanSpaces(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRNLN1,' ')) + 
												                                    stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRNLN2,' '))),left,right),
												   '');
		
			self.corp_ln_name_type_cd		:= if( trim(input.CRNTYP,left,right) in ['01','02','03','1','2','3'], 'P','');

			self.corp_ln_name_type_desc		:= if( trim(self.corp_ln_name_type_cd,left,right) = 'P', 'PRIOR',
		                                           if (trim(input.CRNTYP,left,right) in ['04','05'], 'NON-SURVIVOR', ''));

			self							:= [];
		end;
		
		// name corp
		mapNameCorp  := project(NameFile, AL_corpNameChangeTransform(LEFT));
		//---------------------name change corp transform ends---------------------------------------------------------//

		//---------------------corp history transform starts-----------------------------------------------------------//
		Corp2_Mapping.Layout_CorpPreClean AL_corpHistTransform(HistoryFileLayout input) := transform, 
											skip (trim(regexreplace('\\x80',input.CRHLIN,' '),left,right) = '' or
												  trim(input.CRHTYP,left,right) not in ['01','02','03','04','05','1','2','3','4','5'] )
		
			self.corp_vendor				:= '01';
			self.corp_state_origin			:= 'AL';
			self.corp_key					:= '01-' +trim(input.CRHACC, left, right);
			self.dt_vendor_first_reported	:= fileDate;
			self.dt_vendor_last_reported	:= fileDate;
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;
			self.corp_ra_dt_first_seen		:= fileDate;
			self.corp_ra_dt_last_seen		:= fileDate;
			self.corp_process_date			:= fileDate;
			self.corp_orig_sos_charter_nbr	:= trim(input.CRHACC,left,right);
			self.corp_src_type				:= 'SOS';
			
			dateField						:= if ((integer) (input.CRHHYR + input.CRHHMO + input.CRHHDY) <> 0,
												   trim(input.CRHHYR,left,right) + trim(input.CRHHMO,left,right) + trim(input.CRHHDY,left,right),'');

			self.corp_filing_date			:= if (trim(input.CRHTYP,left,right) in ['01','02','03','04','05','1','2','3','4','5'],
												   if (trim(dateField,left,right) <> '',	trim(dateField,left,right),	''),
												   '');

			self.corp_legal_name			:= if (trim(input.CRHLIN,left,right) <> '',
												   trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRHLIN,' ')),left,right),
												   '');

            self.corp_ln_name_type_cd		:= if( trim(input.CRHTYP,left,right) in ['01','02','03','1','2','3'], 'P','');
			
			self.corp_ln_name_type_desc		:= if( trim(self.corp_ln_name_type_cd,left,right) = 'P', 'PRIOR',
			                                       if (trim(input.CRHTYP,left,right) in ['04','05','4','5'],
												       'NON-SURVIVOR',''));

			Integer len 					:= LENGTH(trim(input.CRHLIN,left,right));

			self.corp_filing_reference_nbr	:= if ( len > 0 and 
			                                        //ut.isNumeric(input.CRHLIN[len-6..len]) and 
													(integer)input.CRHLIN[1..len-6] <> 0,
			                                        input.CRHLIN[1..len-6],'');
		
			self							:= [];		
		end;
		
		mapHistCorp		:= project(HistoryFile, AL_corpHistTransform(LEFT));
		//---------------------history corp transform ends-------------------------------------------------------------//

		//---------------------corp business transform starts----------------------------------------------------------//
		Corp2_Mapping.Layout_CorpPreClean AL_corpBusinessTransform(BusinessNameFileLayout input) := transform, 
											skip (trim(regexreplace('\\x80',input.CRBLN1,' '),left,right) +
												  trim(regexreplace('\\x80',input.CRBLN2,' '),left,right) = '')

			self.corp_key					:= '01-' +trim(input.CRBACC, left, right);		
			self.corp_vendor				:= '01';		
			self.corp_state_origin			:= 'AL';
			self.dt_vendor_first_reported	:= fileDate;
			self.dt_vendor_last_reported	:= fileDate;
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;
			self.corp_ra_dt_first_seen		:= fileDate;
			self.corp_ra_dt_last_seen		:= fileDate;
			self.corp_process_date			:= fileDate;
			self.corp_orig_sos_charter_nbr	:= trim(input.CRBACC,left,right);
			self.corp_src_type				:= 'SOS';

			self.corp_legal_name			:= if (trim(regexreplace('\\x80',input.CRBLN1,' '),left,right) + 
												   trim(regexreplace('\\x80',input.CRBLN2,' '),left,right) <> '' , 
												   trim(StringLib.StringCleanSpaces(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRBLN1,' ')) +
												                                    stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRBLN2,' '))),left,right),'') ;

			self.corp_ln_name_type_cd		:= if ( trim(input.CRBLN1,left,right) + trim(input.CRBLN2,left,right) <> '','02','');
			self.corp_ln_name_type_desc		:= if ( trim(input.CRBLN1,left,right) + trim(input.CRBLN2,left,right) <> '','DBA','');

			self							:= [];
		end;
		
		mapBusinessCorp	:= project(BusinessFile, AL_corpBusinessTransform(LEFT));
		//--------------------- business corp transform ends-----------------------------------------------------------//

		//---------------------corp offic address transform starts-----------------------------------------------------//
		Corp2_Mapping.Layout_CorpPreClean AL_corpOfficeTransform(MasterCorpOfficerLayout input) := transform, 
											skip (trim(regexreplace('\\x80',input.CRMLN1,' '),left,right) + 
												  trim(regexreplace('\\x80',input.CRMLN2,' '),left,right) = '')
		
			self.corp_key					:= '01-' +trim(input.CROACC, left, right);			
			self.corp_vendor				:= '01';		
			self.corp_state_origin			:= 'AL';
			self.dt_vendor_first_reported	:= fileDate;	
			self.dt_vendor_last_reported	:= fileDate;		
			self.dt_first_seen				:= fileDate;		
			self.dt_last_seen				:= fileDate;		
			self.corp_ra_dt_first_seen		:= fileDate;			
			self.corp_ra_dt_last_seen		:= fileDate;
			self.corp_process_date			:= fileDate;	
			self.corp_orig_sos_charter_nbr	:= trim(input.CROACC,left,right);
			self.corp_src_type				:= 'SOS';

			self.corp_legal_name			:= if (trim(regexreplace('\\x80',input.CRMLN1,' '),left,right) + 
												   trim(regexreplace('\\x80',input.CRMLN2,' '),left,right) <> '' , 
												   trim(StringLib.StringCleanSpaces(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRMLN1,' ')) +
												                                    stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRMLN2,' '))),left,right),'');

			self.corp_address1_line1		:= if ( trim(input.CRORMC,left,right) <> '', 
													stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRORMC,' '),left,right)),'');

			self.corp_address1_line2		:= if ( trim(input.CRORAD,left,right) <> '', 
													stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRORAD,' '),left,right)),'');

			self.corp_address1_line3		:= if ( trim(input.CRORCT,left,right) <> '', 
													stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRORCT,' '),left,right)),'');

			self.corp_address1_line4		:= if ( trim(input.CRORST,left,right) <> '', 
													stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRORST,' '),left,right)),'');

			self.corp_address1_line5		:= if ((integer)input.CRORZP <> 0,
			                                       if ((integer)input.CRORPL <> 0, 
												       trim(input.CRORZP,left,right) + trim(input.CRORPL,left,right),
												       trim(input.CRORZP,left,right)),
												  '');

			self.corp_address1_type_cd		:= 'M';		
			self.corp_address1_type_desc	:= 'MAILING';
			self							:= [];
		end; 
		
		mapOfficeCorp := project(joinCorpWithOfficer ,AL_corpOfficeTransform(LEFT));
		//---------------------office address corp transform ends------------------------------------------------------//	

		//---------------------------- for lookup ---------------------------------------------------------------------//
		Corp2_Mapping.Layout_CorpPreClean findStateTypeDesc(Corp2_Mapping.Layout_CorpPreClean input, Layouts_Lookup.StateCodeLayout  r ) := transform
				
			self.corp_forgn_state_desc := stringlib.StringtoUpperCase(r.StateDesc);
			self         		       := input;
			self                       := [];
		end;  
		
		joinStateType := join(mapCorp, Files_Raw_Input.StateCodeTable,
							  trim(left.corp_forgn_state_cd,left,right) = right.StateCode,
							  findStateTypeDesc(left,right),
							  left outer, lookup);

		//---------------------------- end of lookup ------------------------------------------------------------------//	
				
		AllCorp			:= distribute(joinStateType + mapNameCorp + mapHistCorp + mapBusinessCorp + mapOfficeCorp, hash64(corp_orig_sos_charter_nbr));

		mapAllCorp      := sort(AllCorp, corp_orig_sos_charter_nbr,local);

		//---------------------cleaning routine starts starts----------------------------------------------------------//		
		corp2.layout_corporate_direct_corp_in CleanCorpNameAddr(Corp2_Mapping.Layout_CorpPreClean input) := transform
			string73 tempname 				:= if (input.corp_ra_name = '', '',Address.CleanPerson73(input.corp_ra_name));
			pname 							:= Address.CleanNameFields(tempName);
			cname 							:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 						:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 					:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1				:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 			:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 			:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 			:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 		:= if(keepPerson, pname.name_suffix,'');
			self.corp_ra_score1 			:= if(keepPerson, pname.name_score, '');
			self.corp_ra_cname1 			:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 		:= if(keepBusiness, pname.name_score,'');	
		
			string182 clean_address  		:= stringlib.StringToUpperCase(
														 if(trim(input.corp_address1_line1,left,right) +
															trim(input.corp_address1_line2,left,right) +
															trim(input.corp_address1_line3,left,right) +
															trim(input.corp_address1_line4,left,right) +
															trim(input.corp_address1_line5,left,right) +
															trim(input.corp_address1_line6,left,right) <> '', 
															Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' +													                        
																						 trim(input.corp_address1_line2,left,right) + ' ' +	
																						 trim(input.corp_address1_line3,left,right),left,right), 
																					trim(input.corp_address1_line4,left,right) + ', ' +
																					trim(input.corp_address1_line5,left,right) + ' ' +
																					trim(input.corp_address1_line6,left,right)),
											  ''));
											
			self.corp_addr1_prim_range    	:= clean_address[1..10];
			self.corp_addr1_predir 	      	:= clean_address[11..12];
			self.corp_addr1_prim_name 	  	:= clean_address[13..40];
			self.corp_addr1_addr_suffix   	:= clean_address[41..44];
			self.corp_addr1_postdir 	    := clean_address[45..46];
			self.corp_addr1_unit_desig 	  	:= clean_address[47..56];
			self.corp_addr1_sec_range 	  	:= clean_address[57..64];
			self.corp_addr1_p_city_name	  	:= clean_address[65..89];
			self.corp_addr1_v_city_name	  	:= clean_address[90..114];
			self.corp_addr1_state 			:= clean_address[115..116];
			self.corp_addr1_zip5 		    := clean_address[117..121];
			self.corp_addr1_zip4 		    := clean_address[122..125];
			self.corp_addr1_cart 		    := clean_address[126..129];
			self.corp_addr1_cr_sort_sz 	 	:= clean_address[130];
			self.corp_addr1_lot 		    := clean_address[131..134];
			self.corp_addr1_lot_order 	  	:= clean_address[135];
			self.corp_addr1_dpbc 		    := clean_address[136..137];
			self.corp_addr1_chk_digit 	  	:= clean_address[138];
			self.corp_addr1_rec_type		:= clean_address[139..140];
			self.corp_addr1_ace_fips_st	  	:= clean_address[141..142];
			self.corp_addr1_county 	  		:= clean_address[143..145];
			self.corp_addr1_geo_lat 	    := clean_address[146..155];
			self.corp_addr1_geo_long 	    := clean_address[156..166];
			self.corp_addr1_msa 		    := clean_address[167..170];
			self.corp_addr1_geo_blk			:= clean_address[171..177];
			self.corp_addr1_geo_match 	  	:= clean_address[178];
			self.corp_addr1_err_stat 	    := clean_address[179..182];
							
			string182 clean_ra_address		:= stringlib.StringToUpperCase(
														 if(trim(input.corp_ra_address_line1,left,right) +
															trim(input.corp_ra_address_line2,left,right) +
															trim(input.corp_ra_address_line3,left,right) +
															trim(input.corp_ra_address_line4,left,right) +
															trim(input.corp_ra_address_line5,left,right) +
															trim(input.corp_ra_address_line6,left,right) <> '',
															Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +													                        
																						 trim(input.corp_ra_address_line2,left,right) + ' ' +	
																						 trim(input.corp_ra_address_line3,left,right),left,right),
																					trim(input.corp_ra_address_line4,left,right) + ', ' +
																					trim(input.corp_ra_address_line5,left,right) + ' ' +
																					trim(input.corp_ra_address_line6,left,right)),
											   ''));
												
			self.corp_ra_prim_range    		:= clean_ra_address[1..10];
			self.corp_ra_predir 	      	:= clean_ra_address[11..12];
			self.corp_ra_prim_name 	  		:= clean_ra_address[13..40];
			self.corp_ra_addr_suffix   		:= clean_ra_address[41..44];
			self.corp_ra_postdir 	    	:= clean_ra_address[45..46];
			self.corp_ra_unit_desig 	  	:= clean_ra_address[47..56];
			self.corp_ra_sec_range 	  		:= clean_ra_address[57..64];
			self.corp_ra_p_city_name	  	:= clean_ra_address[65..89];
			self.corp_ra_v_city_name	  	:= clean_ra_address[90..114];
			self.corp_ra_state 			    := clean_ra_address[115..116];
			self.corp_ra_zip5 		      	:= clean_ra_address[117..121];
			self.corp_ra_zip4 		      	:= clean_ra_address[122..125];
			self.corp_ra_cart 		      	:= clean_ra_address[126..129];
			self.corp_ra_cr_sort_sz 	 	:= clean_ra_address[130];
			self.corp_ra_lot 		      	:= clean_ra_address[131..134];
			self.corp_ra_lot_order 	  		:= clean_ra_address[135];
			self.corp_ra_dpbc  	      		:= clean_ra_address[136..137];
			self.corp_ra_chk_digit 	  		:= clean_ra_address[138];
			self.corp_ra_rec_type		  	:= clean_ra_address[139..140];
			self.corp_ra_ace_fips_st	  	:= clean_ra_address[141..142];
			self.corp_ra_county 	  		:= clean_ra_address[143..145];
			self.corp_ra_geo_lat 	    	:= clean_ra_address[146..155];
			self.corp_ra_geo_long 	    	:= clean_ra_address[156..166];
			self.corp_ra_msa 		      	:= clean_ra_address[167..170];
			self.corp_ra_geo_blk			:= clean_ra_address[171..177];
			self.corp_ra_geo_match 	  		:= clean_ra_address[178];
			self.corp_ra_err_stat 	    	:= clean_ra_address[179..182];
			
			self							:= input;
			self							:= [];
		end; 

		//cleaning corps 
		cleanedCorps	:= project(mapAllCorp,CleanCorpNameAddr(left));		
		//-------------- cleaning routine ends--------------------------------------------------------------------//


		//---------------------------- Stock transform starts-----------------------------------------------------//
		// transfrom Corp records to Stock Common form.
		Corp2.Layout_Corporate_Direct_Stock_In trfCorpTostock(CorpMasterLayout input) := transform
			self.corp_vendor				:= '01';		
			self.corp_state_origin			:= 'AL';
			self.corp_key					:= '01-' +trim(input.CRMACC, left, right);
			self.corp_process_date			:= fileDate;						
			self.corp_sos_charter_nbr		:= trim(input.CRMACC,left,right);
			
			self.stock_addl_info   			:=  if (trim(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRMAUT,' ')),left,right) not in ['','-'] and 
													trim(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRMPIN,' ')),left,right) not in ['','-'],													
													'CAPITAL AMOUNT: ' + trim(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRMAUT,' ')),left,right) +
													' AUTHORIZED ' + trim(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRMPIN,' ')),left,right) +' PAID IN',
													if (trim(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRMAUT,' ')),left,right) <> ''  and 
														trim(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRMAUT,' ')),left,right) <> '-',
														'CAPITAL AMOUNT: ' + trim(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRMAUT,' ')),left,right),
														 if (trim(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRMPIN,' ')),left,right) <> ''  and 
															 trim(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRMPIN,' ')),left,right) <> '-',
															 ' AUTHORIZED ' + trim(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRMPIN,' ')),left,right) +' PAID IN','')));

			self							:= [];
		end;

		mapStock1 := project(CorpFile, trfCorpTostock(LEFT));
		
		// transfrom History records to Corp Stock Common form.
		Corp2.Layout_Corporate_Direct_Stock_In trfHistoryToStock(HistoryFileLayout input) := transform
											//, skip (trim(input.CRHTYP,left,right) <> '9' )

			self.corp_vendor				:= '01';		
			self.corp_state_origin			:= 'AL';
			self.corp_key					:= '01-' +trim(input.CRHACC, left, right);		
			self.corp_process_date			:= fileDate;
							
			self.corp_sos_charter_nbr		:= trim(input.CRHACC,left,right);

			Integer lenMonth				:= LENGTH(trim(input.CRHHMO,left,right));

			Integer lenDay					:= LENGTH(trim(input.CRHHDY,left,right));

			string2 day					    := if (trim(input.CRHHDY,left,right) <> '' and lenDay = 1, 
												   '0'+trim(input.CRHHDY,left,right), trim(input.CRHHDY,left,right));
			
			string2 month					:= if (trim(input.CRHHMO,left,right) <> '' and lenMonth = 1, 
												   '0'+trim(input.CRHHMO,left,right),trim(input.CRHHMO,left,right));

			string8 stockDate				:= if (trim(input.CRHHYR + month + day,left,right) <> '' and
												   (integer)trim(input.CRHHYR + month + day,left,right) <> 0,
												   trim(input.CRHHYR,left,right) + trim(month,left,right) + trim(day,left,right),'');

			self.stock_change_date			:= if (trim(stockDate,left,right) <> '', trim(stockDate,left,right),'');

			self.stock_addl_info   			:= if (trim(input.CRHLIN,left,right) <> '' and 
												   (trim(input.CRHTYP,left,right) = '09' or trim(input.CRHTYP,left,right) = '9'), 
												   'CAPITAL AMOUNTS CHANGED FROM: ' +  trim(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRHLIN,' ')),left,right),'');

			self							:= [];
		end;

		mapStock2 := project(HistoryFile, trfHistoryToStock(LEFT));
		
		mapStock  := mapStock1 + mapStock2;
		
		//--------------------stock transform ends------------------------------------------------------------------//

		//--------------------cont main transform starts---------------------------------------------------------------//
		AnnualReportIncorpLayout MergeAnnualWithIncorp(AnnualLayout l, IncorporatorsFileLayout r ) := transform
			self := l;
			self := r;			
		end; 

		joinAnnualWithIncorp  := join(ArFile, IncorpFile,
									  trim(left.CRAACC,left,right) = trim(right.CRIACC,left,right),
								 	  MergeAnnualWithIncorp(left,right),
							   		  left outer);
		
		// Cont1 preclean mapping
		Corp2_Mapping.Layout_ContPreClean AL_contMainTransform(AnnualReportIncorpLayout input) := transform, 
										    skip (trim(regexreplace('\\x80',input.CRAANM,' '),left,right) = '' )

			self.corp_vendor				:= '01';		
			self.corp_state_origin			:= 'AL';
			self.corp_key					:= '01-' +trim(input.CRAACC, left, right);		
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;
			self.corp_process_date			:= fileDate;

			self.corp_orig_sos_charter_nbr	:= trim(input.CRAACC,left,right);
			
			self.corp_legal_name 		    := if (trim(input.CRACNM,left,right) <> '',
												   stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRACNM,' '),left,right)),'');

			self.cont_name					:= if (trim(regexreplace('\\x80',input.CRAANM,' '),left,right) <>'',
												   trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRAANM,' ')),left,right),'');

			self.cont_type_cd				:= if (trim(regexreplace('\\x80',input.CRAANM,' '),left,right) <> '','T','');

			self.cont_type_desc				:= if (trim(regexreplace('\\x80',input.CRAANM,' '),left,right) <> '','CONTACT','');

			self.cont_title1_desc			:= if (trim(regexreplace('\\x80',input.CRAANM,' '),left,right) <> '','FILER','');

			self.cont_address_type_cd		:= if (trim(input.CRAAMC,left,right) <> '' or	
												   trim(input.CRAAAD,left,right) <> '' or
												   trim(input.CRAACT,left,right) <> '' or
												   trim(input.CRAAST,left,right) <> '','B','');

			self.cont_address_type_desc		:= if (trim(input.CRAAMC,left,right) <> '' or	
												   trim(input.CRAAAD,left,right) <> '' or
												   trim(input.CRAACT,left,right) <> '' or
												   trim(input.CRAAST,left,right) <> '','BUSINESS','');
													   
			self.cont_address_line1			:= if (trim(input.CRAAMC,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRAAMC,' ')),left,right),'');

			self.cont_address_line2			:= if (trim(input.CRAAAD,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRAAAD,' ')),left,right),'');	

			self.cont_address_line3			:= if (trim(input.CRAACT,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRAACT,' ')),left,right),'');

			self.cont_address_line4			:= if (trim(input.CRAAST,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRAAST,' ')),left,right),'');

			agentZip						:= if ((integer)input.CRAAZP <> 0,
												   if ((integer)input.CRAAPL <> 0, 
												   	   trim(input.CRAAZP,left,right) + '-' + trim(input.CRAAPL,left,right),
													   trim(input.CRAAZP,left,right)),
												   '');

			self.cont_address_line5			:= agentZip;

			self							:= [];
		end; 	
		
		mapCont1 := dedup(project(joinAnnualWithIncorp, AL_contMainTransform(LEFT)),RECORD);
		
		// Cont2 preclean mapping
		Corp2_Mapping.Layout_ContPreClean AL_contPressTransform(AnnualReportIncorpLayout input):= transform, 
											skip (trim(regexreplace('\\x80',input.CRAPNM,' '),left,right) = '')

			self.corp_vendor				:= '01';		
			self.corp_state_origin			:= 'AL';				
			self.corp_key					:= '01-' +trim(input.CRAACC, left, right);		
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;
			self.corp_process_date			:= fileDate;
			
			self.corp_orig_sos_charter_nbr	:= trim(input.CRAACC,left,right);
			
			self.corp_legal_name 			:= if (trim(input.CRACNM,left,right) <> '',
												   stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRACNM,' '),left,right)),'');	

			self.cont_name					:= if (trim(regexreplace('\\x80',input.CRAPNM,' '),left,right) <>'',
												   trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRAPNM,' ')),left,right),'');

			self.cont_type_cd				:= if (trim(regexreplace('\\x80',input.CRAPNM,' '),left,right) <> '','O','');

			self.cont_type_desc				:= if (trim(regexreplace('\\x80',input.CRAPNM,' '),left,right) <> '','OFFICER','');

			self.cont_title1_desc			:= if (trim(regexreplace('\\x80',input.CRAPNM,' '),left,right) <> '','PRESIDENT','');

			self.cont_address_type_cd		:= if (trim(input.CRAPMC,left,right) <> '' or													
												   trim(input.CRAPAD,left,right) <> '' or													
												   trim(input.CRAPCT,left,right) <> '' or													
												   trim(input.CRAPST,left,right) <> '', 'B','');												
															
			self.cont_address_type_desc		:= if (trim(input.CRAPMC,left,right) <> '' or													
												   trim(input.CRAPAD,left,right) <> '' or													
												   trim(input.CRAPCT,left,right) <> '' or													
												   trim(input.CRAPST,left,right) <> '', 'BUSINESS','');	

			self.cont_address_line1			:= if ( trim(input.CRAPMC,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRAPMC,' ')),left,right),'');

			self.cont_address_line2			:= if ( trim(input.CRAPAD,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRAPAD,' ')),left,right),'');	

			self.cont_address_line3			:= if ( trim(input.CRAPCT,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRAPCT,' ')),left,right),'');
			
			self.cont_address_line4			:= if ( trim(input.CRAPST,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRAPST,' ')),left,right),'');

			prstZip							:= if ((integer)input.CRAPZP <> 0,
												   if ((integer)input.CRAPPL <> 0, 
												   	   trim(input.CRAPZP,left,right) + trim(input.CRAPPL,left,right),
													   trim(input.CRAPZP,left,right)),
												   '');

			self.cont_address_line5			:= prstZip;

			self							:= [];
		end; 	

		mapCont2 := dedup(project(joinAnnualWithIncorp, AL_contPressTransform(LEFT)),RECORD);
	 
		// Cont3 preclean mapping
		Corp2_Mapping.Layout_ContPreClean AL_contSecTransform(AnnualReportIncorpLayout input):= transform, 
											skip ( trim(regexreplace('\\x80',input.CRASNM,' '),left,right) = '')
			
			self.corp_vendor				:= '01';		
			self.corp_state_origin			:= 'AL';
			self.corp_key					:= '01-' +trim(input.CRAACC, left, right);		
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;
			self.corp_process_date			:= fileDate;

			self.corp_orig_sos_charter_nbr	:= trim(input.CRAACC,left,right);
			
			self.corp_legal_name 			:= if (trim(input.CRACNM,left,right) <> '',
												   stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRACNM,' '),left,right)),'');	
			
			self.cont_name					:= if (trim(regexreplace('\\x80',input.CRASNM,' '),left,right) <>'',
												   trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRASNM,' ')),left,right),'');

			self.cont_type_cd				:= if (trim(regexreplace('\\x80',input.CRASNM,' '),left,right) <> '','O','');

			self.cont_type_desc				:= if (trim(regexreplace('\\x80',input.CRASNM,' '),left,right) <> '','OFFICER','');

			self.cont_title1_desc			:= if (trim(regexreplace('\\x80',input.CRASNM,' '),left,right) <> '','SECRETARY','');

			self.cont_address_type_cd		:= if (trim(input.CRASMC,left,right) <> '' or													
												   trim(input.CRASAD,left,right) <> '' or													
												   trim(input.CRASCT,left,right) <> '' or													
												   trim(input.CRASST,left,right) <> '' ,'B','');
															
			self.cont_address_type_desc		:= if (trim(input.CRASMC,left,right) <> '' or													
												   trim(input.CRASAD,left,right) <> '' or													
												   trim(input.CRASCT,left,right) <> '' or													
												   trim(input.CRASST,left,right) <> '' ,'BUSINESS','');

			self.cont_address_line1			:= if (trim(input.CRASMC,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRASMC,' ')),left,right),'');

			self.cont_address_line2			:= if (trim(input.CRASAD,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRASAD,' ')),left,right),'');	

			self.cont_address_line3			:= if (trim(input.CRASCT,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRASCT,' ')),left,right),'');

			self.cont_address_line4			:= if (trim(input.CRASST,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRASST,' ')),left,right),'');
		
			sectZip							:= if ((integer)input.CRASZP <> 0,
												   if ((integer)input.CRASPL <> 0,
												   		trim(input.CRASZP,left,right) + trim(input.CRASPL,left,right),
														trim(input.CRASZP,left,right)),
												   '');
		
			self.cont_address_line5			:= sectZip;
		
			self							:= [];
		end; 	

		mapCont3 := dedup(project(joinAnnualWithIncorp, AL_contSecTransform(LEFT)),RECORD);

		// Cont4 preclean mapping
		Corp2_Mapping.Layout_ContPreClean AL_contIncorpTransform(AnnualReportIncorpLayout input) := transform, 
											skip (trim(regexreplace('\\x80',input.CRIINM,' '),left,right) = '')
			
			self.corp_vendor				:= '01';		
			self.corp_state_origin			:= 'AL';
			self.corp_key					:= '01-' +trim(input.CRAACC, left, right);		
			self.dt_first_seen				:= fileDate;
			self.dt_last_seen				:= fileDate;
			self.corp_process_date			:= fileDate;
			
			self.corp_orig_sos_charter_nbr	:= trim(input.CRAACC,left,right);
			
			self.corp_legal_name 			:= if (trim(input.CRACNM,left,right) <>'',
												   stringlib.StringtoUpperCase(trim(regexreplace('\\x80',input.CRACNM,' '),left,right)),'');

			self.cont_name					:= if (trim(regexreplace('\\x80',input.CRIINM,' '),left,right) <>'',
												   trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRIINM,' ')),left,right),'');

			self.cont_type_cd				:= if (trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRIINM,' ')),left,right) <>'','M','');

			self.cont_type_desc				:= if (trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRIINM,' ')),left,right) <>'','MEMBER/MANAGER/PARTNER','');

			self.cont_title1_desc			:= if (trim(regexreplace('\\x80',input.CRIINM,' '),left,right) <>'','INCORPORATOR','');

			self.cont_address_type_cd		:= if (trim(input.CRIIMC,left,right) <> '' or													
												   trim(input.CRIIAD,left,right) <> '' or													
												   trim(input.CRIICT,left,right) <> '' or													
												   trim(input.CRIIST,left,right) <> '' ,'B','');

			self.cont_address_type_desc		:= if (trim(input.CRIIMC,left,right) <> '' or													
												   trim(input.CRIIAD,left,right) <> '' or
												   trim(input.CRIICT,left,right) <> '' or													
												   trim(input.CRIIST,left,right) <> '', 'BUSINESS','');

			self.cont_address_line1			:= if (trim(input.CRIIMC,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRIIMC,' ')),left,right),'');

			self.cont_address_line2			:= if (trim(input.CRIIAD,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRIIAD,' ')),left,right),'');	

			self.cont_address_line3			:= if (trim(input.CRIICT,left, right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRIICT,' ')),left,right),'');

			self.cont_address_line4			:= if (trim(input.CRIIST,left,right) <>'', trim(stringlib.StringtoUpperCase(regexreplace('\\x80',input.CRIIST,' ')),left,right),'');

			incrpZip						:= if ((integer)input.CRIIZP <> 0,
												   if((integer)input.CRIIPL <> 0,
												      trim(input.CRIIZP,left,right) + trim(input.CRIIPL,left,right),
													  trim(input.CRIIZP,left,right)),
												   '');

			self.cont_address_line5			:= incrpZip;
			self							:= [];

		end;

		mapCont4 := dedup(project(joinAnnualWithIncorp, AL_contIncorpTransform(LEFT)),RECORD);
		
		mapCont	:=	mapCont1 + mapCont2 + mapCont3 + mapCont4;
		
		//--------------------main cont transform  --------------------------------------------------------------------//
		Corp2.Layout_Corporate_Direct_Cont_In CleanConts(Corp2_Mapping.Layout_ContPreClean input):= transform 
		 
			string73 tempname 				:= if (trim(input.cont_name) <> '', Address.CleanPerson73(input.cont_name), '');
			pname 							:= Address.CleanNameFields(tempName);
			cname 							:= DataLib.companyclean(input.cont_name);
			keepPerson 						:= Corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 					:= Corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1				:= if(keepPerson, pname.title, '');
			self.cont_fname1 				:= if(keepPerson, pname.fname, '');
			self.cont_mname1 				:= if(keepPerson, pname.mname, '');
			self.cont_lname1 				:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.cont_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 			:= if(keepBusiness, pname.name_score,'');				

			string182 clean_address 		:= stringlib.StringToUpperCase(
							                         if(trim(input.cont_address_line1,left,right) +
													    trim(input.cont_address_line2,left,right) +
														trim(input.cont_address_line3,left,right) +
														trim(input.cont_address_line4,left,right) +
														trim(input.cont_address_line5,left,right) <> '', 
													    Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' + 														                        
													                                 trim(input.cont_address_line2,left,right),left,right),	
													                            trim(trim(input.cont_address_line3,left,right) + ', ' +
													                                 trim(input.cont_address_line4,left,right) + ' ' +
													                                 trim(input.cont_address_line5,left,right),left,right)),
											   ''));
	
			self.cont_prim_range    		:= clean_address[1..10];
			self.cont_predir 	      		:= clean_address[11..12];
			self.cont_prim_name 	  		:= clean_address[13..40];
			self.cont_addr_suffix   		:= clean_address[41..44];
			self.cont_postdir 	    		:= clean_address[45..46];
			self.cont_unit_desig 	  		:= clean_address[47..56];
			self.cont_sec_range 	  		:= clean_address[57..64];
			self.cont_p_city_name	  		:= clean_address[65..89];
			self.cont_v_city_name	  		:= clean_address[90..114];
			self.cont_state 				:= clean_address[115..116];
			self.cont_zip5 		      		:= clean_address[117..121];
			self.cont_zip4 		      		:= clean_address[122..125];
			self.cont_cart 		      		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 		:= clean_address[130];
			self.cont_lot 		      		:= clean_address[131..134];
			self.cont_lot_order 	  		:= clean_address[135];
			self.cont_dpbc 		      		:= clean_address[136..137];
			self.cont_chk_digit 	  		:= clean_address[138];
			self.cont_rec_type		  		:= clean_address[139..140];
			self.cont_ace_fips_st	  		:= clean_address[141..142];
			self.cont_county 	  			:= clean_address[143..145];
			self.cont_geo_lat 	    		:= clean_address[146..155];
			self.cont_geo_long 	    		:= clean_address[156..166];
			self.cont_msa 		      		:= clean_address[167..170];
			self.cont_geo_blk				:= clean_address[171..177];
			self.cont_geo_match 	  		:= clean_address[178];
			self.cont_err_stat 	    		:= clean_address[179..182];
			self							:= input;			
			self							:= [];
		end; 
		
		cleanCont 	:= project(mapCont, CleanConts(left));
		
		//--------------------Cont cleaning routine ends-----------------------------------------------------------//

		
		//--------------------event main transform starts----------------------------------------------------------//
		Corp2.Layout_Corporate_Direct_Event_In AL_eventMainTransform(HistoryFileLayout input) := transform,
										skip (trim(input.CRHTYP) in ['9','09'])
			self.corp_vendor			:= '01';		
			self.corp_state_origin		:= 'AL';
			self.corp_key				:= '01-' +trim(input.CRHACC, left, right);
			self.corp_process_date		:= fileDate;	
			self.corp_sos_charter_nbr	:= trim(input.CRHACC,left,right);
		
			string8 eventDate			:= if ((integer)(input.CRHHYR + input.CRHHMO + input.CRHHDY) <> 0,
											   trim(input.CRHHYR,left,right) + trim(input.CRHHMO,left,right) + trim(input.CRHHDY,left,right),'');

			self.event_filing_date		:= if (trim(eventDate,left,right) <> '', trim(eventDate,left,right), '');

			self.event_date_type_cd		:= if (trim(input.CRHHYR + input.CRHHMO + input.CRHHDY,left,right) <>'','FIL','');

			self.event_date_type_desc	:= if (trim(input.CRHHYR + input.CRHHMO + input.CRHHDY,left,right) <>'','FILING','');

			self.event_filing_cd		:= if (trim(input.CRHTYP,left,right) <> '', trim(input.CRHTYP,left,right),'');

			self.event_filing_desc		:= map(trim(input.CRHTYP,left,right) = '01' => 'LEGAL NAME CHANGED',
											   trim(input.CRHTYP,left,right) = '02' => 'FICTITIOUS NAME CHANGED',
											   trim(input.CRHTYP,left,right) = '03' => 'REGISTERED NAME CHANGED',
											   trim(input.CRHTYP,left,right) = '04' => 'LEGAL NAME MERGED',
											   trim(input.CRHTYP,left,right) = '05' => 'LEGAL NAME CONSOLIDATED',
											   trim(input.CRHTYP,left,right) = '06' => 'REGISTERED AGENT CHANGED',
											   trim(input.CRHTYP,left,right) = '07' => 'PRINCIPAL OFFICE CHANGED',
											   trim(input.CRHTYP,left,right) = '08' => 'OFFICE OF RECORDS CHANGED',
											   trim(input.CRHTYP,left,right) = '1'  => 'LEGAL NAME CHANGED',
											   trim(input.CRHTYP,left,right) = '2'  => 'FICTITIOUS NAME CHANGED',
											   trim(input.CRHTYP,left,right) = '3'  => 'REGISTERED NAME CHANGED',
											   trim(input.CRHTYP,left,right) = '4'  => 'LEGAL NAME MERGED',
											   trim(input.CRHTYP,left,right) = '5'  => 'LEGAL NAME CONSOLIDATED',
											   trim(input.CRHTYP,left,right) = '6'  => 'REGISTERED AGENT CHANGED',
											   trim(input.CRHTYP,left,right) = '7'  => 'PRINCIPAL OFFICE CHANGED',
											   trim(input.CRHTYP,left,right) = '8'  => 'OFFICE OF RECORDS CHANGED',
											   trim(input.CRHTYP,left,right) = '10' => 'NATURE OF BUSINESS CHANGED',
											   trim(input.CRHTYP,left,right) = '11' => 'PARTNER ACTIVITY',
											   trim(input.CRHTYP,left,right) = '12' => 'MEMBER/SHAREHOLDER ACTIVITY',
											   trim(input.CRHTYP,left,right) = '15' => 'ARTICLES OF CORRECTION',
											   trim(input.CRHTYP,left,right) = '16' => 'PROBATE OFFICE CORRECTION',
											   trim(input.CRHTYP,left,right) = '17' => 'MISCELLANEOUS FILING',
											   '');

			eventDesc						:= if (trim(input.CRHLIN,left,right) <> '',
			                                       stringlib.StringtoUpperCase(StringLib.StringCleanSpaces(regexreplace('\\x80',input.CRHLIN,' '))),'');

			self.event_desc					:= regexreplace('0*$',eventDesc,'');
		
			self							:= [];
		end;
		
		mapEvent := project(HistoryFile, AL_eventMainTransform(LEFT));
		//--------------------event main transform ends------------------------------------------------------------//
	  
		//--------------------Ar transform starts------------------------------------------------------------------//
		Corp2.Layout_Corporate_Direct_ar_In  AL_arMainTransform(AnnualLayout input) := transform
			self.corp_vendor				:= '01';
			self.corp_state_origin			:= 'AL';
			self.corp_key					:= '01-' + trim(input.CRAACC,left,right);
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trim(input.CRAACC,left,right);
	 
			self.ar_year 					:= if ((integer)trim(input.CRARYR) <> 0, 
												   trim(input.CRARYR,left,right), '');
			self.ar_comment					:= if (trim(self.ar_year) <> '', 'ANNUAL REPORT', '');
			self							:= [];
		end; 
		
		mapAr := project(ArFile, AL_ArMainTransform(LEFT));
		//--------------------Ar transform ends--------------------------------------------------------------------//
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::corp_al'	,cleanedCorps	,corp_out	,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::cont_al'	,cleanCont		,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::stock_al',mapStock			,stock_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::event_al',mapEvent			,event_out,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Constants.cluster + 'in::corp2::'+version+'::ar_al'		,mapAr				,ar_out		,,,pOverwrite);
		                                                                                                                                                       
		Mapped_AL_As_Corp := parallel(
			 corp_out	
			,cont_out	
			,stock_out
			,event_out
			,ar_out		
		);
		
		result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('al',filedate,pOverwrite := pOverwrite))
			,Mapped_AL_As_Corp
			,parallel(
				fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp_al'),
				fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock','~thor_data400::in::corp2::'+version+'::stock_al'),
				fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event','~thor_data400::in::corp2::'+version+'::event_al'),
				fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont_al'),
				fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'		,'~thor_data400::in::corp2::'+version+'::ar_al')
			)							
		);
			
	    return result;
    end;  // end of update function 
end; // end of AL
