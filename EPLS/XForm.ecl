

rString := RECORD
	string	item{maxlength(128)};
END;

rLine := RECORD
	string	line{MAXLENGTH(2056)};
END;

rReference XItem(rLine s, integer c) := TRANSFORM
	self.item := Trim(StringLib.StringExtract(s.line, c),LEFT,RIGHT);
END;

DATASET(rReference) ListToDS(string itemlist) := FUNCTION
		n := StringLib.StringFindCount(itemlist, ',') + 1;
		dsItems := DATASET([itemlist], {string	line{MAXLENGTH(2056)}});
		dsList := DEDUP(NORMALIZE(dsItems, n, XItem(LEFT,COUNTER)),item);
		return IF(n<=1,dsList(item<>''),dsList);
END;

rReference InsertAKA(rReference aka) := TRANSFORM
	self.item := 'aka ' + aka.item;
END;


corplist := 'LLC|L.L.C.|Inc|LTD|Corp|Co|S.A. DE C.V.|S.A.|LDA|W.L.L|Company|Incorporated';

cleanreferences(string s) :=
	REGEXREPLACE(',+ *('+corplist+')\\b', s, ' $1', nocase);
	
FixString(string s) := FUNCTION
		s1 :=	TRIM(StringLib.StringFilterOut(s,'()'),LEFT,RIGHT);
		return cleanreferences(IF(s1[1..5]='also ',s1[6..],s1));
END;

AdjustTD(string s) := IF(s='Indefinite','Indef.',s);
NotNull(string s) := IF(stringlib.StringToUpperCase(s) IN ['NULL','UNKNOWN'],'',s);

EXPORT Layout_EPLS_Ex XForm(Layout_Sam sam, integer c) := TRANSFORM
	self.Name := sam.Name;
	// name
	self.Prefix := sam.Prefix;
	self.FirstName := sam.FirstName;
	self.MiddleName := sam.MiddleName;
	self.LastName := sam.LastName;
	self.Suffix := sam.Suffix;
	
	self.Classification := IF(sam.Classification='Special Entity Designation','Firm',
						sam.Classification);
	self.CTType := sam.ExclusionProgram;
	// address
	self.Addresses.Street1 := NotNull(sam.Address_1);
	self.Addresses.Street2 := NotNull(sam.Address_2);
	self.Addresses.City := NotNull(sam.City);
	isUSA := sam.Country in ['USA',''];
	self.Addresses.Province := IF(isUSA,'',sam.State);
	self.Addresses.State := IF(isUSA,sam.State,'');
	self.Addresses.Country := IF(isUSA,'',sam.Country);
	self.Addresses.ZipCode := NotNull(sam.ZipCode);
	self.Addresses.DUNS := sam.DUNS;
	// Action
	self.Actions := DATASET([{sam.ActiveDate,
											AdjustTD(sam.TerminationDate),
											sam.CTCode,sam.ExcludingAgency,''}],
											Layout_Action);
	//self.Actions.TermDate := sam.TerminationDate;
	//self.Actions.CTCode := sam.CTCode;
	//self.Actions.AgencyComponent := sam.ExcludingAgency;
	//self.Actions.EPLSCreateDate := '';
//
	//self.CrossReference := ListToDS(FixString(sam.CrossReference));
	self.CrossReference := SET(Project(
															ListToDS(FixString(sam.CrossReference)),
															InsertAKA(LEFT)),item);

	self.Description := StringLib.StringFindReplace(sam.AdditionalComments,'\r\n',' ');
	self.AgencyIdentifiers := sam.SAMNumber;
	self.seqnum := c;
	self.SAMNumber := sam.SAMNumber;
	self := [];
END;
/*
Cause 							Nature (Cause)
Treatment 					Effect
CT Action 					[DISCONTINUED]
Action Date 				Active Date
Archived 						Inactive
Entity 							Special Entity Designation
Permanent 					[DISCONTINUED]
CT Code 						Exclusion Type
Exclusion Type 			Exclusion Program
Description 				Additional Comments
*/