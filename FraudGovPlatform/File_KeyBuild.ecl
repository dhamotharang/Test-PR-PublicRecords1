﻿import FraudShared,doxie,Suppress;
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
															
	// Supress CCPA
	mod_access := MODULE(doxie.IDataAccess) END; // default mod_access
	Supress_CCPA := Suppress.MAC_SuppressSource(DpatchIdentityDatadid, mod_access, did, NULL,TRUE);													
															
	FinalValidRecs := Supress_CCPA ;
 return FinalValidRecs ;

end; 