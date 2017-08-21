EXPORT Build_All(string version, boolean pUseProd = false, boolean pDelta = false) := FUNCTION
outputwork :=		sequential(
															Bair_Layers.Build_Base(version ,pUseProd ,pDelta).all
														 ,Bair_Layers.Build_Keys(version, pUseProd, pDelta).all
													);//: success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure;

return outputwork;
	
END;