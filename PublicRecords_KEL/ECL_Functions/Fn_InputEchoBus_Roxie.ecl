IMPORT PublicRecords_KEL, STD;

EXPORT Fn_InputEchoBus_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout) ds_input) := FUNCTION

    PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII GetInputBusEchoed( RECORDOF(ds_input) le ) := 
      TRANSFORM
				SELF.G_ProcBusUID := le.G_ProcBusUID;
				SELF.B_InpName := le.CompanyName;           
				SELF.B_InpAltName := le.AlternateCompanyName; 
				SELF.B_InpAddrLine1 := le.StreetAddressLine1;         
				SELF.B_InpAddrLine2 := le.StreetAddressLine2;    
				SELF.B_InpAddrCity := le.City1;          
				SELF.B_InpAddrState := le.State1;          
				SELF.B_InpAddrZip := le.Zip1;            
				SELF.B_InpPhone := le.BusinessPhone;
				SELF.B_InpTIN := le.BusinessTIN;
				SELF.B_InpIPAddr := le.BusinessIPAddress;      
				SELF.B_InpURL := le.BusinessURL;        
				SELF.B_InpEmail := le.BusinessEmailAddress;          
				SELF.B_InpSICCode := le.SIC_Code;       
				SELF.B_InpNAICSCode := le.NAIC_Code;      
				SELF.B_InpArchDt := le.ArchiveDate;    
				SELF.B_InpLexIDUlt := (INTEGER) le.UltID;
				SELF.B_InpLexIDOrg := (INTEGER) le.OrgID;
				SELF.B_InpLexIDLegal := (INTEGER) le.SeleID;
				SELF.B_InpLexIDSite := (INTEGER) le.ProxID;
				SELF.B_InpLexIDLoc := (INTEGER) le.PowID;
				SELF := []
      END;

    InputBusEcho := PROJECT(ds_input, GetInputBusEchoed(LEFT));   
	
	RETURN InputBusEcho;

 END;