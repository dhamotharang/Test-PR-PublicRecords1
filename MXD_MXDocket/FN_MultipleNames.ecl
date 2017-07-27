export boolean FN_MultipleNames(UNICODE party) := FUNCTION
	modifiedParty := u' '+party+u' ';
	boolean test :=
			UnicodeLib.UnicodeFind(modifiedParty,u' AND ',1)>0 OR
			UnicodeLib.UnicodeFind(modifiedParty,u' ET AL ',1)>0;
			
	return test;
END;