
import VersionControl;

EXPORT proc_build_keys(string	pVersion,BOOLEAN	pUseProd	=	FALSE) := function

VersionControl.macBuildNewLogicalKeyWithName(Infutor_NARC3.Key_narc3_did(pVersion),Infutor_NARC3.Keynames(pVersion).did.new	,key_did);
                                                                                   
  return key_did;
				       	
									 
end;


	       
		 
