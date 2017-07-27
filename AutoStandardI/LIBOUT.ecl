// This defines the output interfaces for penalty calculations contained in this
// module inside LIB_ attributes.
import AutoStandardI;
EXPORT LIBOUT := MODULE

	// This defines the output interface for the address penalty calculation.
	EXPORT PenaltyI_Addr(AutoStandardI.LIBIN.PenaltyI_Addr.full args) := INTERFACE
		EXPORT UNSIGNED val;
	END;
	
	// This defines the output interface for the BDID penalty calculation.
	EXPORT PenaltyI_BDID(AutoStandardI.LIBIN.PenaltyI_BDID.full args) := INTERFACE
		EXPORT UNSIGNED val;
	END;
	
	// This defines the output interface for the business Id penalty calculation.
	EXPORT PenaltyI_BusinessIds(AutoStandardI.LIBIN.PenaltyI_BusinessIds.full args) := INTERFACE
		EXPORT UNSIGNED val;
  END;
	
	// This defines the output interface for the business name penalty calculation.
	EXPORT PenaltyI_Biz_Name(AutoStandardI.LIBIN.PenaltyI_Biz_Name.full args) := INTERFACE
		EXPORT UNSIGNED val;
	END;
	
	// This defines the output interface for the county penalty calculation.
	EXPORT PenaltyI_County(AutoStandardI.LIBIN.PenaltyI_County.full args) := INTERFACE
		EXPORT UNSIGNED val;
	END;
	
	// This defines the output interface for the DID penalty calculation.
	EXPORT PenaltyI_DID(AutoStandardI.LIBIN.PenaltyI_DID.full args) := INTERFACE
		EXPORT UNSIGNED val;
	END;
	
	// This defines the output interface for the date of birth penalty calculation.
	EXPORT PenaltyI_DOB(AutoStandardI.LIBIN.PenaltyI_DOB.full args) := INTERFACE
		EXPORT UNSIGNED val;
	END;

	// This defines the output interface for the date of death penalty calculation.
	EXPORT PenaltyI_DOD(AutoStandardI.LIBIN.PenaltyI_DOD.full args) := INTERFACE
		EXPORT UNSIGNED val;
	END;
	
	// This defines the output interface for the FEIN penalty calculation.
	EXPORT PenaltyI_FEIN(AutoStandardI.LIBIN.PenaltyI_FEIN.full args) := INTERFACE
		EXPORT UNSIGNED val;
	END;
	
	// This defines the output interface for the individual name penalty calculation.
	EXPORT PenaltyI_Indv_Name(AutoStandardI.LIBIN.PenaltyI_Indv_Name.full args) := INTERFACE
		EXPORT UNSIGNED val;
	END;
	
	// This defines the output interface for the phone penalty calculation.
	EXPORT PenaltyI_Phone(AutoStandardI.LIBIN.PenaltyI_Phone.full args) := INTERFACE
		EXPORT UNSIGNED val;
	END;
	
	// This defines the output interface for the SSN penalty calculation.
	EXPORT PenaltyI_SSN(AutoStandardI.LIBIN.PenaltyI_SSN.full args) := INTERFACE
		EXPORT UNSIGNED val;
	END;
	
	// This defines the output interface for the business penalty calculation.
	EXPORT PenaltyI_Biz(AutoStandardI.LIBIN.PenaltyI_Biz.full args) := INTERFACE
		EXPORT UNSIGNED val;
		EXPORT UNSIGNED val_addr;
		EXPORT UNSIGNED val_bdid;
		EXPORT UNSIGNED val_biz_name;
		EXPORT UNSIGNED val_county;
		EXPORT UNSIGNED val_fein;
		EXPORT UNSIGNED val_phone;
	END;
	
	// This defines the output interface for the individual penalty calculation.
	EXPORT PenaltyI_Indv(AutoStandardI.LIBIN.PenaltyI_Indv.full args) := INTERFACE
		EXPORT UNSIGNED val;
		EXPORT UNSIGNED val_addr;
		EXPORT UNSIGNED val_county;
		EXPORT UNSIGNED val_did;
		EXPORT UNSIGNED val_dob;
		EXPORT UNSIGNED val_indv_name;
		EXPORT UNSIGNED val_phone;
		EXPORT UNSIGNED val_ssn;
	END;
	
	// This defines the output interface for the penalty calculation.
	EXPORT PenaltyI(AutoStandardI.LIBIN.PenaltyI.full args) := INTERFACE
		EXPORT UNSIGNED val;
		EXPORT UNSIGNED val_addr;
		EXPORT UNSIGNED val_bdid;
		EXPORT UNSIGNED val_biz_name;
		EXPORT UNSIGNED val_county;
		EXPORT UNSIGNED val_did;
		EXPORT UNSIGNED val_dob;
		EXPORT UNSIGNED val_fein;
		EXPORT UNSIGNED val_indv_name;
		EXPORT UNSIGNED val_phone;
		EXPORT UNSIGNED val_ssn;
		EXPORT UNSIGNED val_biz;
		EXPORT UNSIGNED val_indv;
	END;
	
END;
