IMPORT Address, BIPV2, BIPV2_Best, Business_Risk, Business_Risk_BIP, BusinessCredit_Services, Census_data, 
       Corp2, DCAV2, DID_Add, EBR, Gateway, MDR, Risk_Indicators, RiskWise, ut, BusinessInstantID20_Services;

	// The following function appends the BIPIDs to the Business. Borrowed logic from 
	// Business_Risk_BIP.Business_Shell_Function
	EXPORT fn_AppendBIPIDs( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfoClean) ds_CleanedInput_withLexIDs,
	                        Business_Risk_BIP.LIB_Business_Shell_LIBIN Options ) := 
		FUNCTION
			prepBIPAppend := 
				PROJECT(
					ds_CleanedInput_withLexIDs, 
					TRANSFORM( Business_Risk_BIP.Layouts.Input, 
						Rep := LEFT.AuthReps(Rep_WhichOne = 1)[1];
						SELF.Seq            := LEFT.Seq,
						SELF.AcctNo         := LEFT.AcctNo,	
						SELF.PowID          := LEFT.PowID,
						SELF.ProxID         := LEFT.ProxID,
						SELF.SeleID         := LEFT.SeleID,
						SELF.OrgID          := LEFT.OrgID,
						SELF.UltID          := LEFT.UltID,
						SELF.CompanyName    := LEFT.CompanyName,
						SELF.AltCompanyName := LEFT.AltCompanyName,
						SELF.StreetAddress1 := LEFT.StreetAddress1,
						SELF.StreetAddress2 := LEFT.StreetAddress2,
						SELF.Prim_Range     := LEFT.Prim_Range,
						SELF.Prim_Name      := LEFT.Prim_Name,
						SELF.City           := LEFT.City,
						SELF.State          := LEFT.State,
						SELF.Zip            := LEFT.Zip5,
						SELF.FEIN           := LEFT.FEIN,
						SELF.Phone10        := LEFT.Phone10,
						SELF.IPAddr         := LEFT.IPAddr,
						SELF.CompanyURL     := LEFT.CompanyURL,
						SELF.Rep_FirstName  := Rep.FirstName,
						SELF.Rep_MiddleName := Rep.MiddleName,
						SELF.Rep_LastName   := Rep.LastName,
						SELF.Rep_SSN        := Rep.SSN,
						SELF.Rep_LexID      := Rep.LexID,
						SELF.Rep_Sequence   := Rep.Sequence,
						SELF := LEFT,
						SELF := []
						));
			
			BIPAppend := Business_Risk_BIP.BIP_LinkID_Append(prepBIPAppend, ForceAppend := FALSE);

			BIPV2.IDlayouts.l_xlink_ids2 grabLinkIDs(Business_Risk_BIP.Layouts.LinkID_Results le) := TRANSFORM
				SELF.UniqueID		:= le.Seq;
				SELF.PowID			:= le.PowID.LinkID;
				SELF.PowScore		:= le.PowID.Score;
				SELF.PowWeight	:= le.PowID.Weight;
				
				SELF.ProxID			:= le.ProxID.LinkID;
				SELF.ProxScore	:= le.ProxID.Score;
				SELF.ProxWeight	:= le.ProxID.Weight;
				
				SELF.SeleID			:= le.SeleID.LinkID;
				SELF.SeleScore	:= le.SeleID.Score;
				SELF.SeleWeight	:= le.SeleID.Weight;
				
				SELF.OrgID			:= le.OrgID.LinkID;
				SELF.OrgScore		:= le.OrgID.Score;
				SELF.OrgWeight	:= le.OrgID.Weight;
				
				SELF.UltID			:= le.UltID.LinkID;
				SELF.UltScore		:= le.UltID.Score;
				SELF.UltWeight	:= le.UltID.Weight;
				
				SELF := []; // Don't populate DotID or EmpID
			END;
			
			ds_BIPIDs := PROJECT(BIPAppend, grabLinkIDs(LEFT));
						
			RETURN ds_BIPIDs;

		END;