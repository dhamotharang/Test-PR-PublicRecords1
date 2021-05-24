IMPORT KEL13 AS KEL;
EXPORT FnRoxie_GetInputBIIAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput,
            DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
            PublicRecords_KEL.Interface_Options Options) := FUNCTION
            		
    InputPIIBIIAttributes := KEL.Clean(PublicRecords_KEL.KEL_Queries_MAS_Business.Q_Input_Bus_Attributes_V1_Dynamic(RepInput, BusinessInput, 
        (INTEGER) BusinessInput[1].B_InpClnArchDt[1..8], Options.KEL_Permissions_Mask).res0, TRUE, TRUE, TRUE);
    
		ds_changedatatype :=
		                  PROJECT(InputPIIBIIAttributes,
											        TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
															SELF.B_InpValNameInvalidFlag      		:= (STRING)LEFT.B_InpValNameInvalidFlag,
															SELF.B_InpValAltNameInvalidFlag   		:= (STRING)LEFT.B_InpValAltNameInvalidFlag,
															SELF.B_InpValAddrStInvalidFlag    		:= (STRING)LEFT.B_InpValAddrStInvalidFlag,
															SELF.B_InpValPhoneInvalidFlag    			:= (STRING)LEFT.B_InpValPhoneInvalidFlag,
															SELF.B_InpValTINInvalidFlag       		:= (STRING)LEFT.B_InpValTINInvalidFlag,
															SELF.B_InpValEmailInvalidFlag     		:= (STRING)LEFT.B_InpValEmailInvalidFlag,
															SELF.B_InpValAddrZipBadLenFlag    		:= (STRING)LEFT.B_InpValAddrZipBadLenFlag,
															SELF.B_InpValAddrZipAllZeroFlag   		:= (STRING)LEFT.B_InpValAddrZipAllZeroFlag,
															SELF.B_InpValAddrStateBadAbbrFlag 		:= (STRING)LEFT.B_InpValAddrStateBadAbbrFlag,
															SELF.B_InpValPhoneBadCharFlag     		:= (STRING)LEFT.B_InpValPhoneBadCharFlag,
															SELF.B_InpValPhoneBadLenFlag      		:= (STRING)LEFT.B_InpValPhoneBadLenFlag,
															SELF.B_InpValPhoneBogusFlag       		:= (STRING)LEFT.B_InpValPhoneBogusFlag,
															SELF.B_InpValTINBadCharFlag      			:= (STRING)LEFT.B_InpValTINBadCharFlag,
															SELF.B_InpValTINBadLenFlag        		:= (STRING)LEFT.B_InpValTINBadLenFlag,
															SELF.B_InpValTINBogusFlag      	  		:= (STRING)LEFT.B_InpValTINBogusFlag,
															SELF.B_InpValEmailBogusFlag           := (STRING)LEFT.B_InpValEmailBogusFlag,
															SELF.B_InpValEmailUserBadCharFlag     := (STRING)LEFT.B_InpValEmailUserBadCharFlag,
															SELF.B_InpValEmailUserAllZeroFlag     := (STRING)LEFT.B_InpValEmailUserAllZeroFlag,
															SELF.B_InpValEmailDomBadCharFlag      := (STRING)LEFT.B_InpValEmailDomBadCharFlag,
															SELF.B_InpValEmailDomAllZeroFlag      := (STRING)LEFT.B_InpValEmailDomAllZeroFlag,
															SELF.B_InpValNameBadCharFlag        := (STRING)LEFT.B_InpValNameBadCharFlag,
															SELF.B_InpValAltNameBadCharFlag        := (STRING)LEFT.B_InpValAltNameBadCharFlag,
															SELF.B_InpValNameMatchesAltNameFlag        := (STRING)LEFT.B_InpValNameMatchesAltNameFlag,
															// SELF.B_InpClnAddrLocID := (INTEGER)LEFT.B_InpClnAddrLocID, 
															// SELF.B_Rep1InpClnAddrLocID := (INTEGER)LEFT.B_Rep1InpClnAddrLocID, 
															// SELF.B_Rep2InpClnAddrLocID := (INTEGER)LEFT.B_Rep2InpClnAddrLocID, 
															// SELF.B_Rep3InpClnAddrLocID := (INTEGER)LEFT.B_Rep3InpClnAddrLocID, 
															// SELF.B_Rep4InpClnAddrLocID := (INTEGER)LEFT.B_Rep4InpClnAddrLocID, 
															// SELF.B_Rep5InpClnAddrLocID := (INTEGER)LEFT.B_Rep5InpClnAddrLocID, 															
															
															SELF := LEFT,
			                        SELF := []));

		
		RETURN ds_changedatatype;
END;