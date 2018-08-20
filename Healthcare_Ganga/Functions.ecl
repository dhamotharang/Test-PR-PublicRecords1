IMPORT Healthcare_Ganga,STD;
EXPORT Functions := Module
	Warning100Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff(inRec.RecordIdentifier = '',row({'100','APS'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning101Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Orgs, Healthcare_Ganga.Constants.HCO]) AND inRec.LegalName = '',row({'101','APS'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning103Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Orgs,Healthcare_Ganga.Constants.HCO]) AND inRec.TaxId = '',row({'103','APS'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning104Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff(inRec.StreetAddress1 = '' OR inRec.City = '' OR inRec.State = '' OR inRec.Zip5 = '',row({'104','APS'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning105Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.FirstName = '',row({'105','APS'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning106Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.LastName = '',row({'106','APS'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning109Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.SSN = '',row({'109','APS'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning110Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff(inRec.NPI = '',row({'110','APS'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning111Input (Healthcare_Ganga.Layouts.IdentityInput inRec) := FUNCTION
		myErr := iff(inRec.EntityType not in [Healthcare_Ganga.Constants.HCP,Healthcare_Ganga.Constants.Principles, Healthcare_Ganga.Constants.HCO, Healthcare_Ganga.Constants.Orgs],row({'111','APS'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
EXPORT getInputWarnings (DATASET(Healthcare_Ganga.Layouts.IdentityInput) inRecs) := FUNCTION
		//Create ResponseDateTime
		MyDate := STD.Date.CurrentDate(False); year := MyDate[1..4]; month := MyDate[5..6]; day := MyDate[7..8];
		MyTime := STD.Date.CurrentTime(False); hour := MyTime[1..2]; minute := MyTime[3..4]; second := MyTime[5..6];
		TistaDateTime := year+'-'+month+'-'+day+'T'+hour+':'+minute+':'+second+'Z';
		
		myWarnings := project(inRecs, transform(Healthcare_Ganga.Layouts.IdentityOutput,
																	self.acctno := left.acctno;
																	self.Warnings := (Warning100Input(left)+Warning101Input(left)+Warning103Input(left)+
																										Warning104Input(left)+Warning105Input(left)+Warning106Input(left)+
																										Warning109Input(left)+Warning110Input(left)+Warning111Input(left))(Code<>'' or Source<>'');
																	self.ResponseDateTime := TistaDateTime;
																	self := left;
																	self:=[];));
		return myWarnings;
	End;	
	
	Warning100Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff(inRec.RecordIdentifier = '',row({'100','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	Warning101Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Orgs,Healthcare_Ganga.Constants.HCO]) AND inRec.LegalName = '',row({'101','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;		
	Warning102Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Orgs,Healthcare_Ganga.Constants.HCO]) AND inRec.DoingBusinessAs = '',row({'102','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;				
	Warning103Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Orgs,Healthcare_Ganga.Constants.HCO]) AND inRec.TaxId = '',row({'103','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;		
	Warning104Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff(inRec.StreetAddress1 = '' OR inRec.City = '' OR inRec.State = '' OR inRec.Zip5 = '',row({'104','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;		
	Warning105Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.FirstName = '',row({'105','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;		
	Warning106Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.LastName = '',row({'106','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;	
	Warning107Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.Gender = '',row({'107','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;	
	Warning108Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND (inRec.Dob = '' OR inRec.Dob = '0'),row({'108','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;	
	Warning109Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff((inRec.EntityType in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND inRec.SSN = '',row({'109','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;	
	Warning110Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff(inRec.NPI = '',row({'110','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;	
	Warning111Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff(inRec.EntityType not in [Healthcare_Ganga.Constants.HCP,Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCO,Healthcare_Ganga.Constants.Orgs],row({'111','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;	
	Warning199Output (Healthcare_Ganga.Layouts.IdentityOutput inRec) := FUNCTION
		myErr := iff(((inRec.EntityType in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP]) AND (inRec.FirstName = '' OR inRec.LastName = '' OR inRec.SSN = '')) OR
								 ((inRec.EntityType in [Healthcare_Ganga.Constants.Orgs,Healthcare_Ganga.Constants.HCO]) AND inRec.LegalName = ''),row({'199','LN'},Healthcare_Ganga.Layouts.WarningsOutput),row({'',''},Healthcare_Ganga.Layouts.WarningsOutput));
		return myErr;
	END;
	EXPORT getOutputWarnings(DATASET(Healthcare_Ganga.Layouts.IdentityOutput) inRecs) := FUNCTION
		myWarnings := project(inRecs, transform(Healthcare_Ganga.Layouts.IdentityOutput,
																		self.acctno := left.acctno;
																		self.lnpid:=left.lnpid;
																		self.Warnings := (Warning100Output(left)+Warning101Output(left)+Warning102Output(left)+
																											Warning103Output(left)+Warning104Output(left)+Warning105Output(left)+
																											Warning106Output(left)+Warning107Output(left)+Warning108Output(left)+
																											Warning109Output(left)+Warning110Output(left)+Warning111Output(left)+
																											Warning199Output(left))(Code<>'' or Source<>'');
																		self := left;
																		self:=[];));
		return myWarnings;
	End;
END;