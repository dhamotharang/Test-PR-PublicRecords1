import FraudShared;
EXPORT File_KeyBuild (
dataset(FraudShared.Layouts.Base.Main)										pBaseMainBuilt									= Fraudshared.Files().Base.Main.Built ) 
:= 
Function 
import ut, Std; 


  BaseMain              := pBaseMainBuilt(Record_id != 0); 	

  Outfile               := BaseMain ;


	DpatchIdentityDatadid   := project ( Outfile , transform (FraudShared.Layouts.KeyBuild, 
													self.did  := if(left.source = 'IdentityData' and left.did =0, left.Rawlinkid , left.did ); 
													self.ssn	:= left.clean_ssn;
													self.zip	:= left.clean_zip;
													self.ip_address	:= left.clean_ip_address;
													self.dob	:= left.clean_dob;
													self      := left ; )); 
															
	FinalValidRecs := DpatchIdentityDatadid (~(did <> 0 and raw_first_name ='' and raw_last_name ='' and street_1 =''));	// CR 328	
 return FinalValidRecs ;

end; 