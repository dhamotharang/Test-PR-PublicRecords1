EXPORT User_Settings_Module := MODULE

//********BOCASHELL PRODUCTS**************

EXPORT BocaShell_41_NONFCRA_settings:= MODULE
	     EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     EXPORT BOOLEAN RemoveFares:=false; 
	 	   EXPORT BOOLEAN LeadIntegrityMode:=false;
			 
END;

EXPORT BocaShell_41_FCRA_settings:= MODULE
	     // EXPORT INTEGER DPPA:=3;
		   // EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     // EXPORT BOOLEAN RemoveFares:=false; 
	 	   // EXPORT BOOLEAN LeadIntegrityMode:=false;
			 
END;

EXPORT BocaShell_50_NONFCRA_settings:= MODULE
	     EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     EXPORT BOOLEAN RemoveFares:=false; 
	 	   EXPORT BOOLEAN LeadIntegrityMode:=false;
			 
END;

EXPORT BocaShell_50_FCRA_settings:= MODULE
	     // EXPORT INTEGER DPPA:=3;
		   // EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     // EXPORT BOOLEAN RemoveFares:=false; 
	 	   // EXPORT BOOLEAN LeadIntegrityMode:=false;
			 
END;

//added BocaShell_54
EXPORT BocaShell_54_NONFCRA_settings:= MODULE
	     EXPORT INTEGER DPPA:=3;
		   EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     EXPORT BOOLEAN RemoveFares:=false; 
	 	   EXPORT BOOLEAN LeadIntegrityMode:=false;
			 
END;

EXPORT BocaShell_54_FCRA_settings:= MODULE
	     // EXPORT INTEGER DPPA:=3;
		   // EXPORT INTEGER GLB:=1;
			 EXPORT STRING DRM :='0000000000000'; 	
	     // EXPORT BOOLEAN RemoveFares:=false; 
	 	   // EXPORT BOOLEAN LeadIntegrityMode:=false;
			 
END;


END;