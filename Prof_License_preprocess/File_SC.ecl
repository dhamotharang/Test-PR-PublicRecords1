EXPORT File_SC  :=  module

export medical := module

Layout_rcps := record
   string  PNAME;
   string  MAILADD1;
   string  MAILADD2;
   string  MAILADD3;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string  LNAME;
   string  FNAME;
   string LICNO;
   string CODE;
   string lf;
end;



export rcps := dataset('~thor_data400::in::prolic::sc::medical::rcps::raw',Layout_rcps,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;

Layout_phys := record
   string  NAME;
   string  MAILADD1;
   string  MAILADD2;
   string  MAILADD3;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string PRACTYP1;
   string  LNAME;
   string  FNAME;
   string LICNO;
   string CODE;
	 string lf;
end;

export phys := dataset('~thor_data400::in::prolic::sc::medical::phys::raw',Layout_phys,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;

Layout_pas := record
   string  PNAME;
   string  MAILADD1;
   string  MAILADD2;
   string  MAILADD3;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string PRAC1;
   string  LNAME;
   string  FNAME;
   string LICNO;
   string CODE;
   string lf;
end;



export pas := dataset('~thor_data400::in::prolic::sc::medical::pas::raw',Layout_pas,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;

Layout_opts := record
   string  NAME;
   string  MAILADD1;
   string  MAILADD2;
   string  MAILADD3;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string  BRCHPH1;
   string  LNAME;
   string  FNAME;
   string prof;
   string LICNO;
   string lf;
end;



export opts := dataset('~thor_data400::in::prolic::sc::medical::opts::raw',Layout_opts,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;

Layout_pharm := record
   string  FNAME;
   string  LNAME;
   string  MAILADD1;
   string  MAILADD2;
   string  MAILADD3;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string MCOUNTY;
   string  pname;
   string LICNO;
   string  ISSUEDT;
   string  EXPDATE;
   string lf;
end;



export pharm := dataset('~thor_data400::in::prolic::sc::medical::pharm::raw',Layout_pharm,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;

Layout_pta := record
   string  NAME;
   string  MAILADD1;
   string  MAILADD2;
   string MAILADD3;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string  LNAME;
   string  FNAME;
   string MI;
   string  COUNTY;
   string LICNO;
   string CODE;
   string lf;
end;


export pta := dataset('~thor_data400::in::prolic::sc::medical::pta::raw',Layout_pta,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;

Layout_ota := record
   string  NAME;
   string  MAILADD1;
   string  MAILADD2;
   string MAILADD3;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string  LNAME;
   string  FNAME;
   string MI;
   string  COUNTY;
   string LICNO;
   string CODE;
   string lf;
end;


export ota := dataset('~thor_data400::in::prolic::sc::medical::ota::raw',Layout_ota,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;

Layout_orthotec :=record
   string  NAME;
   string  MAILADD1;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string LNAME;
   string FNAME;
   string LICNO;
   string CODE;
   string lf;
end;



export orthotec := dataset('~thor_data400::in::prolic::sc::medical::orthotec::raw',Layout_orthotec,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;


Layout_dentec := record
   string  NAME;
   string  MAILADD1;
   string  MAILADD2;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string  LNAME;
   string  FNAME;
   string LICNO;
   string CODE;
   string lf;
end;



export dentec := dataset('~thor_data400::in::prolic::sc::medical::dentec::raw',Layout_dentec,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;


Layout_ccpt := record
   string  FNAME;
	 string MNAME;
   string  LNAME;
   string  MAILADD1;
   string  MAILADD2;
   string  MAILADD3;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string MCOUNTY;
   string  pname;
   string LICNO;
   string  ISSUEDT;
   string  EXPDATE;
   string lf;
end;



export ccpt := dataset('~thor_data400::in::prolic::sc::medical::ccpt::raw',Layout_ccpt,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;


Layout_drug := record
   string LICNO;
   string  PHNAME;
   string  FULLNAME;
   string  MAILADD1;
   string  MAILADD2;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string  county;
   string  TYPES;
   string  ISSUEDT;
   string  EXPDATE;
   string lf;
end;



export drug := dataset('~thor_data400::in::prolic::sc::medical::drug::raw',Layout_drug,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;



Layout_dhy := record
   string  NAME;
   string  MAILADD1;
   string  MAILADD2;
   string  MAILADD3;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string  LNAME;
   string  FNAME;
   string LICNO;
   string CODE;
   string lf;
end;



export dhy := dataset('~thor_data400::in::prolic::sc::medical::dhy::raw',Layout_dhy,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;

Layout_dnt := record
   string  NAME;
   string  MAILADD1;
   string  MAILADD2;
   string  MAILADD3;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string PRACTYP1;
   string  LNAME;
   string  FNAME;
   string LICNO;
   string CODE;
   string lf;
end;



export dnt := dataset('~thor_data400::in::prolic::sc::medical::dnt::raw',Layout_dnt,CSV( heading(1),separator('|'),terminator(['\n','\r\n']),Quote(' ')),opt) ;

end;

Layout_social := record
   string  Description;
   string  ShortName;
	 string Title;
   string  LastName;
   string  middleName;
   string  FirstName;
   string  BusinessName;
   string  company;
   string  Address1;
   string  Address2;
   string  City;
   string StateCode;
   string  ZIPCode;
   string BusinessPhone;
   string FirstEffectiveDate;
   string ExpirationDate;
   string CredentialTypePrefix;
   string CredentialNumber;
   string Status;
   string lf;
end ;

export social := dataset('~thor_data400::in::prolic::sc::social_worker::raw',Layout_social,CSV( heading(1),separator(','),terminator(['\r\n','\n']),Quote('"')));
 
 
Layout_psy := record
   string  Description;
   string  ShortName;
	 string Title;
   string  LastName;
   string  middleName;
   string  FirstName;
   string  BusinessName;
   string  company;
   string  Address1;
   string  Address2;
   string  City;
   string StateCode;
   string  ZIPCode;
   string FirstEffectiveDate;
   string ExpirationDate;
   string CredentialTypePrefix;
   string CredentialNumber;
   string Status;
   string lf;
end ;

export psychology := dataset('~thor_data400::in::prolic::sc::psychology::raw',Layout_psy,CSV( heading(1),separator(','),terminator(['\r\n','\n']),Quote('"')));

export Layout_medical := 
record
   string  NAME;
   string  MAILADD1;
   string  MAILADD2;
   string MAILADD3;
   string  MCITY;
   string MSTATE;
   string  MZIP;
   string  LNAME;
   string  FNAME;
   string MI;
   string  COUNTY;
   string LICNO;
   string CODE;
	 string TYPES;
	 string PRACTYP1;
	 string  ISSUEDT;
   string  EXPDATE;
   string lf;
end;


end;