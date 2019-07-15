import FraudShared;
EXPORT File_KeyBuild (
dataset(FraudShared.Layouts.Base.Main)										pBaseMainBuilt									= Fraudshared.Files().Base.Main.Built  ) 
:= 
Function 
import ut, Std; 


  BaseMain              := pBaseMainBuilt(Record_id != 0); 	

  Outfile               := BaseMain ;


	DpatchIdentityDatadid   := project ( Outfile , transform (FraudShared.Layouts.KeyBuild, 
													self.ssn	:= left.clean_ssn;
													self.zip	:= left.clean_zip;
													self.ip_address	:= left.clean_ip_address;
													self.dob	:= left.clean_dob;
													self      := left ; )); 
															
	FinalValidRecs := DpatchIdentityDatadid ;	// CR 328	
 return FinalValidRecs ;

end; 