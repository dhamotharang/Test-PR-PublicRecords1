IMPORT PublicRecords_KEL;
//Layout for attributes with Archive Date

EXPORT AttrWithDate_Layout := RECORD
	PublicRecords_KEL.ECL_Functions.Attr_Layout;
	STRING20 ArchiveDate;
 END;