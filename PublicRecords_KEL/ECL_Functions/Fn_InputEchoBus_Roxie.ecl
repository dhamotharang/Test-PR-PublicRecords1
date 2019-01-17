IMPORT PublicRecords_KEL, STD;

EXPORT Fn_InputEchoBus_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout) ds_input) := FUNCTION

    PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII GetInputBusEchoed( RECORDOF(ds_input) le ) := 
      TRANSFORM
        SELF.BusInputUIDAppend := le.BusInputUIDAppend;  
				SELF.BusInputNameEcho := le.CompanyName;           
				SELF.BusInputAlternateNameEcho := le.AlternateCompanyName; 
				SELF.BusInputStreetEcho := le.Addr1;         
				SELF.BusInputCityEcho := le.City1;          
				SELF.BusInputStateEcho := le.State1;          
				SELF.BusInputZipEcho := le.Zip1;            
				SELF.BusInputPhoneEcho := le.BusinessPhone;
				SELF.BusInputTINEcho := le.BusinessTIN;				
				SELF.BusInputIPAddressEcho := le.BusinessIPAddress;      
				SELF.BusInputURLEcho := le.BusinessURL;        
				SELF.BusInputEmailEcho := le.BusinessEmailAddress;          
				SELF.BusInputSICCodeEcho := le.SIC_Code;       
				SELF.BusInputNAICSCodeEcho := le.NAIC_Code;      
				SELF.BusInputArchiveDateEcho := le.ArchiveDate;    
				SELF.InputLexIDBusExtendedFamilyEcho := (INTEGER) le.PowID;
				SELF.InputLexIDBusLegalFamilyEcho := (INTEGER) le.ProxID;
				SELF.InputLexIDBusLegalEntityEcho := (INTEGER) le.SeleID;
				SELF.InputLexIDBusPlaceGroupEcho := (INTEGER) le.OrgID;
				SELF.InputLexIDBusPlaceEcho := (INTEGER) le.UltID;
				SELF := [];
      END;

    InputBusEcho := PROJECT(ds_input, GetInputBusEchoed(LEFT));   
	
	RETURN InputBusEcho;

 END;