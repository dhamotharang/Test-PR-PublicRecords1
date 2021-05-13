IMPORT tools,STD, FraudGovPlatform_Validation, ut;
EXPORT Build_Prepped_IdentityData (
	 string		pversion
) :=
FUNCTION

	Sprayed_IdentityData := Files(pversion).Sprayed.IdentityData;
			
	IdentityData := RECORD 
		string75 fn { virtual(logicalfilename) };
		Layouts.Sprayed.IdentityData;
	END;	
	
	IdentityData MapIdentity(Sprayed_IdentityData L) := TRANSFORM 
		filename := ut.CleanSpacesAndUpper(l.fn);

		fn := StringLib.SplitWords( StringLib.StringFindReplace(filename, '.dat',''), '_', true );	
		//https://confluence.rsi.lexisnexis.com/display/GTG/Data+Dictionary: 
			self.RIN_Source := map(	fn[5] = 'IDENTITY' => 1, // Identity
								fn[5] = 'IDENTITYBATCH' => 13,  // RIN API
								1 );
			SELF := L;
			SELF := [];
	END;

	RETURN(Project(Sprayed_IdentityData,MapIdentity(Left)));
	
	
end;


