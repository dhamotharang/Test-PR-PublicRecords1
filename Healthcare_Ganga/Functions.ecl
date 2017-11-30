IMPORT Healthcare_Ganga;
EXPORT Functions := Module
	Warning100Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff(inRec.APSTransactionID[1] not in [Healthcare_Ganga.Constants.HCP,Healthcare_Ganga.Constants.Principles, Healthcare_Ganga.Constants.HCO, Healthcare_Ganga.Constants.Orgs],row({'100',''},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning101Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Orgs, Healthcare_Ganga.Constants.HCO]) AND inRec.BusinessName = '',row({'101',''},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning103Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Orgs,Healthcare_Ganga.Constants.HCO]) AND inRec.TaxId = '',row({'103',''},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning104Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff(inRec.StreetAddress1 = '' OR inRec.StreetAddress2 = '' OR inRec.City = '' OR inRec.State = '' OR inRec.Zip5 = '',row({'104',''},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning105Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.FirstName = '',row({'105',''},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning106Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.LastName = '',row({'106',''},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning109Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.SSN = '',row({'109',''},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning110Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff(inRec.NPI = '',row({'110',''},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning112Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff(inRec.EnrollmentId = '',row({'112',''},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	EXPORT getInputWarnings (DATASET(Healthcare_Ganga.Layouts.IdentityInput) inRecs) := FUNCTION
		myWarnings := project(inRecs, transform(Healthcare_Ganga.Layouts.IdentityOutput,
																	self.acctno := left.acctno;
																	self.Warnings:=  (Warning100Input(left)+Warning101Input(left)+Warning103Input(left)+
																									Warning104Input(left)+Warning105Input(left)+Warning106Input(left)+
																								  Warning109Input(left)+Warning110Input(left)+Warning112Input(left))(Code<>'' or Source<>'');
																	self := left;
																	self:=[];));
		return myWarnings;
	End;	
	
	Warning100Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff(inRec.APSTransactionID[1] not in [Healthcare_Ganga.Constants.HCP,Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCO,Healthcare_Ganga.Constants.Orgs],row({'','100'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning101Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Orgs,Healthcare_Ganga.Constants.HCO]) AND inRec.BusinessName = '',row({'','101'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;	
	Warning102Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Orgs,Healthcare_Ganga.Constants.HCO]) AND inRec.LegalName = '',row({'','102'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;		
	Warning103Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Orgs,Healthcare_Ganga.Constants.HCO]) AND inRec.TaxId = '',row({'','103'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;		
	Warning104Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff(inRec.StreetAddress1 = '' OR inRec.StreetAddress2 = '' OR inRec.City = '' OR inRec.State = '' OR inRec.Zip5 = '',row({'','104'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;		
	Warning105Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.FirstName = '',row({'','105'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;		
	Warning106Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.LastName = '',row({'','106'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;	
	Warning107Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.Gender = '',row({'','107'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;	
	Warning108Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.Dob = '0',row({'','108'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;	
	Warning109Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.APSTransactionID[1] in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.SSN = '',row({'','109'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;	
	Warning110Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff(inRec.NPI = '',row({'','110'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	EXPORT getOutputWarnings(DATASET(Healthcare_Ganga.Layouts.IdentityOutput) inRecs) := FUNCTION
		myWarnings := project(inRecs, transform(Healthcare_Ganga.Layouts.IdentityOutput,
																		self.acctno := left.acctno;
																		self.lnpid:=left.lnpid;
																		self.Warnings:=  (Warning100Output(left)+Warning101Output(left)+Warning102Output(left)+
																										Warning103Output(left)+Warning104Output(left)+Warning105Output(left)+
																										Warning106Output(left)+Warning107Output(left)+Warning108Output(left)+
																										Warning109Output(left)+Warning110Output(left))(Code<>'' or Source<>'');
																		self := left;
																		self:=[];));
		return myWarnings;
	End;
END;