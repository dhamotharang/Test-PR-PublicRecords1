import iesp,doxie_cbrs;
export fn_smart_rollup_corp_aff (dataset(iesp.bpsreport.t_BpsCorpAffiliation) inCorpAff, 
                                 dataset(iesp.fictitiousbusinesssearch.t_FictitiousBusinessSearchRecord) inFBN,
																 dataset(iesp.peopleatwork.t_PeopleAtWorkRecord) inPAW) := function

    iesp.bpsreport.t_BpsCorpAffiliation fbn2Corp(inFBN l) := transform
		   self.BusinessId  := l.Business.BusinessId;
			 self.BusinessIDs.proxid := l.BusinessIDs.proxid;
			 self.businessIDs.ultid := l.BusinessIDs.ultid;
			 self.businessIDs.orgid := l.BusinessIDs.orgid;
			 self.businessIDs.seleid := l.BusinessIDs.seleid;
			 self.businessIDs.dotid := l.BusinessIDs.dotid;
			 self.BusinessIDs.empid := l.BusinessIDs.empid;
			 self.BusinessIDs.powid := l.BusinessIDs.powid;
			 self.Title := 'OWNER';
		   self.CompanyName  := l.Business.name;
			 self.Address := project(l.Business.MailingAddress, transform(iesp.share.t_AddressWithType, SELF := LEFT, SELF._type := '' ));
			 self.recordDate := l.OriginalFilingDate;
       self := [];
		 end;
     fbnFormatted := project(inFBN, fbn2Corp(LEFT));  //change format to match corp affiliations.

    iesp.bpsreport.t_BpsCorpAffiliation paw2Corp(inPAW l) := transform
		   self.BusinessId  := l.BusinessId;
			 self.BusinessIDs.proxid := l.BusinessIDs.proxid;
			 self.businessIDs.ultid := l.BusinessIDs.ultid;
			 self.businessIDs.orgid := l.BusinessIDs.orgid;
			 self.businessIDs.seleid := l.BusinessIDs.seleid;
			 self.businessIDs.dotid := l.BusinessIDs.dotid;
			 self.BusinessIDs.empid := l.BusinessIDs.empid;
			 self.BusinessIDs.powid := l.BusinessIDs.powid;
			 self.Title := l.title;
		   self.CompanyName  := l.CompanyName;
			 self.Address := l.Address;
			 self.recordDate := l.DateFirstSeen;
       self := [];
		 end;		 
		 
		 pawFormatted := project(inPAW, paw2Corp(LEFT)); //change format to match corp affiliations.
		 
     //include FBN and PAW(officer) with Corp Affiliations
		 corpBoth := inCorpAff(recordtype <> 'HISTORICAL') + fbnFormatted + pawFormatted;
		 // Call function to dedup on linkids and name/address
		 d_corp_aff := SmartRollup.Functions.dedup_businesses(corpBoth,RecordDate);	
		 outrecs := sort(d_corp_aff,	-iesp.ECL2ESP.DateToInteger(recordDate));	
	return outrecs;
end;