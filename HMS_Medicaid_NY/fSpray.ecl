// This attribute sprays all the sheets of a NY file. These sheets need to be imported on to the landing zone as individual sheets

import lib_fileservices,tools,_control,lib_stringlib,Versioncontrol, HMS_Medicaid_Common,HMS_Medicaid_NY;

export fSpray(string version, boolean pUseProd = false) := MODULE
EXPORT xyz := Function
	#DECLARE(Ndx);
	#SET(Ndx, 1);
	#Declare(Sheet);
	#DECLARE(S);
	#SET (S, 'Sheet');
	//#APPEND (Sheet, %'Ndx'%);
	#LOOP
		#IF(%Ndx% > 10)
			#BREAK
		#ELSE
			#SET (S, 'Sheet');
			#APPEND (S, %'Ndx'%);
				//%'S'%;
				// X := %'S'%;
				// X;
				VersionControl.fSprayInputFiles(HMS_Medicaid_NY.SpraySheet(%'S'%, version,  pUseProd));
				//VersionControl.fSprayInputFiles(HMS_Medicaid_Common.fSpray(Medicaid_State,pversion,pUseProd));
		#SET (Ndx, %Ndx% + 1);
		#END
	#END
	Return ('All Done');
end; // function
END; // Module