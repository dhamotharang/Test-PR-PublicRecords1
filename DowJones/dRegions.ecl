rRegions := RECORD
	string		enumeration;
	string		countryid;
	string		countryname;
	string		countrycode;
	integer		regionid;
	string		regionname;
END;

EXPORT dRegions :=	dataset('~thor::DowJones::regions', rRegions, CSV(HEADING(1),SEPARATOR(',')));
