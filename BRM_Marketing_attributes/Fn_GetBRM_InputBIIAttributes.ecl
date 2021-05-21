IMPORT PublicRecords_KEL,BRM_Marketing_Attributes;
IMPORT KEL11 AS KEL;
EXPORT Fn_GetBRM_InputBIIAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput,
                                    DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
                                    PublicRecords_KEL.Interface_Options Options) := FUNCTION
  
	LayoutBIIAndPII := RECORD
	  PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII BusinessInput;
	  DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput ;
	END;
	
	BIIAttributesInput := DENORMALIZE(BusinessInput, RepInput, 
                         LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,  GROUP,
                         TRANSFORM(LayoutBIIAndPII, 
                         SELF.RepInput := ROWS(RIGHT),
                         SELF.BusinessInput := LEFT));
	
	LayoutBIIAttributes := BRM_Marketing_attributes.BRM_KEL.L_Compile.Input_Bus_Attributes_V1_Dynamic_Res0_Layout;
	
	BIIAttributes_Results := NOCOMBINE(PROJECT(BIIAttributesInput, TRANSFORM(LayoutBIIAttributes,
                                                                  NonFCRABIIResults := BRM_Marketing_attributes.BRM_KEL.Q_Input_Bus_Attributes_V1_Dynamic(
                                                                                        LEFT.RepInput,
                                                                                        DATASET(LEFT.BusinessInput),
                                                                                        (INTEGER)LEFT.BusinessInput.B_InpClnArchDt[1..8],
                                                                                        Options.KEL_Permissions_Mask).res0;                                                                          
                                                                                        SELF := NonFCRABIIResults[1])));
	 




	InputPIIBIIAttributes := KEL.Clean(BIIAttributes_Results,TRUE, TRUE, TRUE);
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
															SELF.B_LexIDUlt := (STRING)Left.B_LexIDUlt,
															SELF.B_LexIDOrg := (STRING)Left.B_LexIDOrg,
															SELF.B_LexIDLegal := (STRING)Left.B_LexIDLegal,
															SELF.B_LexIDLoc :=(STRING)Left.B_LexIDLoc,
															SELF.B_LexIDSite := (STRING)Left.B_LexIDSite,
															SELF.B_LexIDLegalScore := (STRING)Left.B_LexIDLegalScore,													
															SELF.G_ProcBusUID := LEFT.G_ProcBusUID;
															SELF := []));
		
	RETURN ds_changedatatype;
END;