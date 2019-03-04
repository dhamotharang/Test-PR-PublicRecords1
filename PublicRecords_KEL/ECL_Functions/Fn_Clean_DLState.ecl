IMPORT STD;
EXPORT Fn_Clean_DLState(STRING InputDLStateEcho) := FUNCTION

ValidStates  := ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL',
                 'GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH',
										 'MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM',
										 'NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC',
										 'SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY'];
										 
UpperDL        := STD.str.ToUpperCase(InputDLStateEcho);
										 
Statecheck     := UpperDL IN ValidStates; 


 CleanedState  := If(UpperDL != '' and StateCheck = TRUE, UpperDL, '');
 
										 
RETURN CleanedState ;
END; 


	

	
