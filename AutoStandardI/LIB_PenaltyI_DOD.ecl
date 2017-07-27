/*--LIBRARY--*/
// This library performs penalty calculations based on date of death.
// All logic for performing the calculation should be based here.
import doxie,ut;
export LIB_PenaltyI_DOD(LIBIN.PenaltyI_DOD.full args) := MODULE/*,LIBRARY*/(LIBOUT.PenaltyI_DOD(args))
	EXPORT UNSIGNED val := FUNCTION
		tempmod := module(project(args,LIBIN.PenaltyI_DOB.full,opt))
			export dob := args.dod;
			export dob_field := args.dod_field;
		end;
		return AutoStandardI.LIBCALL_PenaltyI_DOB.val(tempmod) * 2;
	END;
END;