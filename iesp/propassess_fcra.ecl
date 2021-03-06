/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from propassess_fcra.xml. ***/
/*===================================================*/

import iesp;

export propassess_fcra := MODULE
			
export t_FcraAssessEntities := record (iesp.propassess.t_BaseAssessEntities)
	dataset(iesp.property_fcra.t_FcraProperty2Name) Names {xpath('Names/Name'), MAXCOUNT(iesp.Constants.Prop.MaxNames)};
end;
		
export t_FcraAssessReportRecord := record (iesp.propassess.t_BaseAssessReportRecord)
	t_FcraAssessEntities Sellers2 {xpath('Sellers2')};
	t_FcraAssessEntities Buyers2 {xpath('Buyers2')};
	t_FcraAssessEntities Owners2 {xpath('Owners2')};
	boolean IsDisputed {xpath('IsDisputed')};
	dataset(iesp.share_fcra.t_StatementIdRec) StatementIds {xpath('StatementIdRecs/StatementIdRec'), MAXCOUNT(iesp.Constants.MaxConsumerStatementIds)};
end;
		

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from propassess_fcra.xml. ***/
/*===================================================*/

