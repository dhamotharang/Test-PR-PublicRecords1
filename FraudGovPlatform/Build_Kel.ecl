﻿EXPORT Build_Kel (
   string pversion
			):=  module 
			
			
	Export	All := Sequential(
										 Build_Keys(pVersion).Delta_All
										,Build_Base_Kel(pVersion).Delta_All
										,Promote(pversion).buildfiles.New2Built
										,Promote(pversion).buildfiles.Built2QA
										,Build_Keys(pVersion).All
										,Build_Base_Kel(pVersion).All
										,Promote(pversion).buildfiles.New2Built
										,Promote(pversion).buildfiles.Built2QA
													);
		
End;		