Import FraudGovPlatform,Std;

EXPORT File_Velocityrules := Module

	Shared	Velocity_Base		:= Files().Input.MbsVelocityRules.Sprayed;

					Velocity_Fab := Project(Velocity_Base,Transform(Layouts_Key.MbsVelocityRules
															,self.description := STD.Str.CleanSpaces('Exceeds '+ left.fragment_description +' Velocity '+left.minCnt +' in '+left.maxtime +' '+left.timeunit +' across '+left.contributiontypedescription)
															,self:=left
															));

	Export Velocity_Key := Velocity_Fab;
	
END;