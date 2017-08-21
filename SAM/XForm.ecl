import Worldcheck_Bridger;

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

Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_aliases InsertAKA(rReference aka) := TRANSFORM
	self.full_name := TRIM(aka.item,LEFT,RIGHT);
	self := [];
END;


corplist := 'LLC|L.L.C.|Inc|LTD|Corp|Co|S.A. DE C.V.|S.A.|LDA|W.L.L|Company|Incorporated';

cleanreferences(string s) :=
	REGEXREPLACE(',+ *('+corplist+')\\b', s, ' $1', nocase);
	
FixString(string s) := FUNCTION
		s1 :=	TRIM(StringLib.StringFilterOut(s,'()'),LEFT,RIGHT);
		return cleanreferences(IF(s1[1..5]='also ',s1[6..],s1));
END;


Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo MakeInfo(string name, string info) :=
			DATASET([{'Other',name,'',info}],Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo);
				

AdjustTD(string s) := IF(s='Indefinite','Indef.',s);
NotNull(string s) := IF(stringlib.StringToUpperCase(s) IN ['NULL','UNKNOWN'],'',s);

Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_sp MakeDunsId(Layout_Sam sam) :=
		DATASET([{'DUNS #',
					'',			// label
					sam.DUNS,		// number
					'DUN & BRADSTREET',			// issued_by
					'',					// date_issued
					'',					// date_expires
					'',
					}
			],
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_sp);

Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_sp MakeCageId(Layout_Sam sam) :=
		DATASET([{'Other',
					'',			// label
					sam.Cage,		// number
					'Department of Defense\'s Defense Logistics Agency',			// issued_by
					'',					// date_issued
					'',					// date_expires
					'Commercial And Government Entity (CAGE) Code',
					}
			],
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_sp);
			
Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addresses MakeAddress(Layout_Sam sam) :=
		DATASET([{'',
					NotNull(sam.Address_1),
					NotNull(sam.Address_2),
					NotNull(sam.City),
					sam.State,		// state or province
					NotNull(sam.ZipCode),	// postal code
					sam.Country,
					TRIM(sam.Address_3 + ' ' + sam.Address_4,LEFT,RIGHT)	// comments
					}
			],
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addresses);

AddCrossReference(string CrossReference) :=
		IF(CrossReference = '','',
			'Cross-Reference: ' +
			RegexReplace(' *, *', FixString(CrossReference), '|'));

EXPORT Layout_BridgerEx XForm(Layout_Sam sam, integer c) := TRANSFORM
	self.ID := (string)(unsigned4)hash32(sam.SAMNumber);
	self.accuityDataSource := 'SAM';
	self.Entity_Unique_ID := IF(sam.SAMNumber='','','EP' + TRIM(sam.SAMNumber,LEFT,RIGHT));
	self.type := CASE(sam.Classification,
						'Firm' => 'Business',
						'Special Entity Designation' => 'Business',
						sam.Classification);
	
	self.full_name := sam.Name;
	// name
	self.title := sam.Prefix;
	self.first_name := sam.FirstName;
	self.middle_name := sam.MiddleName;
	self.last_name := sam.LastName;
	self.generation := sam.Suffix;
	
	self.reason_listed := sam.ExclusionProgram;
	self.Reference_ID := sam.SamNumber;
	// address
	self.address_list.address := MakeAddress(sam);
	
	self.listed_date := sam.ActiveDate;
	self.modified_date := '';			//sam.TerminationDate;
	
	self.identification_list.identification := 
						IF(sam.duns<>'',MakeDunsId(sam)) +
						IF(sam.cage<>'',MakeCageId(sam));

//	self.aka_list.aka := Project(ListToDS(FixString(sam.CrossReference)),
//															InsertAKA(LEFT));
															
	self.additional_info_list.additionalinfo := 
					IF(sam.ActiveDate<>'',MakeInfo('Active Date',sam.ActiveDate)) +
					IF(sam.TerminationDate<>'',MakeInfo('Termination Date',sam.TerminationDate)) +
					IF(sam.CTCode<>'',MakeInfo('CT Code',sam.CTCode)) +
					IF(sam.ExcludingAgency<>'',MakeInfo('Excluding Agency',sam.ExcludingAgency)) +
					IF(sam.ExclusionProgram<>'',MakeInfo('Excluding Program',sam.ExclusionProgram)) +
					IF(sam.ExclusionType<>'',MakeInfo('Excluding Type',sam.ExclusionType)) +
					IF(sam.RecordStatus<>'',MakeInfo('Record Status',sam.RecordStatus)) +
					IF(sam.AdditionalComments<>'',MakeInfo('Additional Comments',StringLib.StringFindReplace(sam.AdditionalComments,'\r\n','||')))
					;

	self.comments := FixString(sam.CrossReference);
	self.seqnum := c;
	self.SamNumber := sam.SamNumber;
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