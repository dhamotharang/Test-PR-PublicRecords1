import mdr,header,business_header;
ds := header.File_Headers;//(src IN ['EQ'] OR src[2]='D');

more_filters :=
	LENGTH(TRIM(ds.lname))>1 AND
	LENGTH(Stringlib.StringFilterOut(ds.lname,'ABCDEFGHIJKLMNOPQRSTUVWXYZ- '))=0;

h := ds(more_filters);

Layout_Name :=
RECORD
	unsigned6 did;
	STRING20 name;
END;


Names := PROJECT(h,TRANSFORM(Layout_Name,SELF.name:=LEFT.lname,SELF := LEFT));
NamesDEDUP := DEDUP(SORT(Names, did, name, LOCAL), did, name, LOCAL);							
			
NameCount :=
RECORD
	NamesDEDUP.name;
	cnt := COUNT(GROUP);
	boolean isaCompany := false;
END;
NameTable := TABLE(NamesDEDUP,NameCount,name,few);


c := business_header.File_Business_Header(
		MDR.sourceTools.SourceIsCorpV2								(source)
or	MDR.sourceTools.SourceIsDunn_Bradstreet				(source)
or	MDR.sourceTools.SourceIsDCA										(source)
);
companyNames := TABLE(c,{bdid,company_name_clean := StringLib.StringFilter(company_name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ')});
companyNames normCompany(companyNames le, INTEGER c) :=
TRANSFORM
	SELF.company_name_clean := TRIM(le.company_name_clean[Stringlib.StringFind(le.company_name_clean,' ',c-1)+1..Stringlib.StringFind(le.company_name_clean,' ',c)-1],ALL);
	SELF := le;
END;
companyWords := DEDUP(NORMALIZE(companyNames, LENGTH(StringLib.StringFilter(TRIM(LEFT.company_name_clean),' '))+1,  normCompany(LEFT, COUNTER)), company_name_clean, ALL);


NameCount rm_company_name(NameCount le, companyWords ri) :=
TRANSFORM
	SELF.isaCompany := ri.company_name_clean<>'';
	SELF := le;
END;

NamesMinusCompanyWords := JOIN(NameTable, companyWords, LEFT.cnt<100000 AND LEFT.name=RIGHT.company_name_clean, rm_company_name(LEFT,RIGHT), LEFT OUTER);


output(NamesMinusCompanyWords,,'~thor_data400::maltemp::lastnames',overwrite);