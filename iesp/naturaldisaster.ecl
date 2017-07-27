/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from naturaldisaster.xml. ***/
/*===================================================*/

export naturaldisaster := MODULE
			
export t_NatDisISOCommittee := record
	string100 Reference {xpath('Reference')};
	string200 Title {xpath('Title')};
	string5 _Type {xpath('Type')};
end;
		
export t_NatDisLiaisonsTotals := record
	integer Total {xpath('Total')};
	integer TotalA {xpath('TotalA')};
	integer TotalB {xpath('TotalB')};
	integer TotalC {xpath('TotalC')};
end;
		
export t_NaturalDisasterRecord := record
	t_NatDisLiaisonsTotals LiaisonsTotals {xpath('LiaisonsTotals')};
	dataset(t_NatDisISOCommittee) ISOCommittees {xpath('ISOCommittees/ISOCommittee'), MAXCOUNT(iesp.constants.NATURAL_DISASTER.MaxISOCommittees)};
end;
		
export t_NaturalDisasterRecordSection := record
	dataset(t_NaturalDisasterRecord) NaturalDisasterRecords {xpath('NaturalDisasterRecords/NaturalDisasterRecord'), MAXCOUNT(iesp.constants.NATURAL_DISASTER.MaxCountSuppRiskRecords)};
	integer NaturalDisasterCount {xpath('NaturalDisasterCount')};
	integer TotalNaturalDisasterCount {xpath('TotalNaturalDisasterCount')};
	dataset(topbusiness_share.t_TopBusinessSourceDocInfo) SourceDocs {xpath('SourceDocs/SourceDoc'), MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)};
end;

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from naturaldisaster.xml. ***/
/*===================================================*/
