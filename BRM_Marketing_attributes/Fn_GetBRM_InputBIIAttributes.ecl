IMPORT PublicRecords_KEL,BRM_Marketing_Attributes;
IMPORT KEL11 AS KEL;
EXPORT Fn_GetBRM_InputBIIAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput,
            DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
            PublicRecords_KEL.Interface_Options Options) := FUNCTION
            		
    InputPIIBIIAttributes := KEL.Clean(PublicRecords_KEL.Q_Input_Bus_Attributes_V1(RepInput, BusinessInput, 
        (STRING) BusinessInput[1].B_InpClnArchDt[1..8], Options.KEL_Permissions_Mask).res0, TRUE, TRUE, TRUE);
	ds_changedatatype :=
		                  PROJECT(InputPIIBIIAttributes,
											        TRANSFORM(BRM_Marketing_Attributes.Layout_BRM_NonFCRA.Layout_master,
															SELF.B_InpAcct        := (STRING)LEFT.B_InpAcct,											
															SELF.B_InpClnName        := (STRING)LEFT.B_InpClnName,											
															SELF.B_InpClnAltName        := (STRING)LEFT.B_InpClnAltName,											
															SELF.B_InpClnAddrSt        := (STRING)LEFT.B_InpClnAddrSt,											
															SELF.B_InpClnAddrCity        := (STRING)LEFT.B_InpClnAddrCity,											
															SELF.B_InpClnAddrState        := (STRING)LEFT.B_InpClnAddrState,											
															SELF.B_InpClnAddrZip5        := (STRING)LEFT.B_InpClnAddrZip5,											
															SELF.B_InpClnAddrZip4        := (STRING)LEFT.B_InpClnAddrZip4,											
															SELF.B_InpClnTIN        := (STRING)LEFT.B_InpClnTIN,											
															SELF.B_InpClnPhone        := (STRING)LEFT.B_InpClnPhone,											
															SELF.B_InpClnEmail        := (STRING)LEFT.B_InpClnEmail,	
															SELF.B_LexIDUlt := Left.B_LexIDUlt,
															SELF.B_LexIDOrg := Left.B_LexIDOrg,
															SELF.B_LexIDLegal := Left.B_LexIDLegal,
															SELF.B_LexIDLoc := Left.B_LexIDLoc,
															SELF.B_LexIDSite := Left.B_LexIDSite,
															SELF.B_LexIDLegalScore := Left.B_LexIDLegalScore,													
															SELF.G_ProcBusUID := LEFT.G_ProcBusUID;
															SELF := []));
		
		RETURN ds_changedatatype;
END;