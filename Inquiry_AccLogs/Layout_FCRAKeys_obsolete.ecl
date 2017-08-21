export layout_fcrakeys := module

export phone := record
  string10 phone10;
  inquiry_acclogs.Layout.Common;
	end;

export ssn := record
  string9 ssn;
  inquiry_acclogs.Layout.Common;
	end;
	
export address := record
	string5 zip,
	inquiry_acclogs.Layout.persondatalayout.prim_name,
	inquiry_acclogs.Layout.persondatalayout.prim_range,
	inquiry_acclogs.Layout.persondatalayout.sec_range,
  inquiry_acclogs.Layout.Common;
	end;

export did := record
	inquiry_acclogs.Layout.persondatalayout.appended_adl,
  inquiry_acclogs.Layout.Common;
	end;

END;
