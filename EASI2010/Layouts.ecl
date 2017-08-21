export Layouts := Module

export Layout_Census := RECORD
	Layout_Legacy
	OR Layout_Vendor.Layout_Census;
END;

export Layout_Current_yr := RECORD
	Layout_Legacy
	OR Layout_Vendor.Layout_Current_yr;
END;

export Layout_Projection := RECORD
	Layout_Legacy
	OR Layout_Vendor.Layout_Projection;
END;


End;