/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from criminalimagereport.xml. ***/
/*===================================================*/

export criminalimagereport := MODULE
			
export t_CriminalImageReportBy := record
	string12 UniqueId {xpath('UniqueId')};
	string9 SSN {xpath('SSN')};
	share.t_Name Name {xpath('Name')};
	share.t_Address Address {xpath('Address')};
end;
		
export t_CriminalImageReportOption := record (share.t_BaseReportOption)
  boolean SexualOffenderOnly {xpath('SexualOffenderOnly')};
end;
		
export t_CriminalImageRecord := record
	integer SequenceNumber {xpath('SequenceNumber')};
	string12 UniqueId {xpath('UniqueId')};
	string2 State {xpath('State')};
	string60 Identifier {xpath('Identifier')};
	string2 _Type {xpath('Type')};
	share.t_Date Date {xpath('Date')};
	varstring Image {xpath('Image'), maxlength(iesp.Constants.crim.MaxImageLength)}; // Xsd type: base64Binary
end;
		
export t_CriminalImageReportResponse := record
	share.t_ResponseHeader _Header {xpath('Header')};
	integer RecordCount {xpath('RecordCount')};
	dataset(t_CriminalImageRecord) Records {xpath('Records/Record'), MAXCOUNT(iesp.Constants.crim.MaxImageRecords)};
end;
		
export t_CriminalImageReportRequest := record (share.t_BaseRequest)
	t_CriminalImageReportOption Options {xpath('Options')};
	t_CriminalImageReportBy ReportBy {xpath('ReportBy')};
end;
		
export t_CriminalImageReportResponseEx := record
	t_CriminalImageReportResponse response {xpath('response')};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from criminalimagereport.xml. ***/
/*===================================================*/

