import LaborActions_EBSA;

EXPORT Layouts := MODULE
	EXPORT rawrec := RECORD
		// recordof(LaborActions_EBSA.Layouts.Base);
		LaborActions_EBSA.Layouts.Base;
		unsigned2 penalt := 0;
	END;
END;