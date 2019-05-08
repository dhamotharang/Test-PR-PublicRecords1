//This function rolls up assessements, deeds, nod, foreclosures for a property into 1 record.
//The records from datasource 'A' and 'B' are not rolled up.  So 1 property can have up to 2 records, 1 for each datasource.
//The rollup of assessment records is perform 2 ways.  1)By Property Address 2) By ParcelID and Legal Description.
//The output record contains the current assessment information + (all deeds/all NOD/all Foreclosures associated with subject).
//A Current_prior flag is set so the records maybe seperated at display time.
import iesp, LN_PropertyV2, ut, census_data, PersonReports, SmartRollup;
 // inject unsigned date-field (and "ownership") for sorting
  assess_ext := record (iesp.propassess.t_AssessReportRecord)
    boolean IsSubjectOwned;
    unsigned4 srt_date;
  end;
export fn_smart_rollup_prop(dataset(assess_ext) inAssess,
                            dataset(iesp.propdeed.t_DeedReportRecord) inDeeds = Dataset([],iesp.propdeed.t_DeedReportRecord),
                            dataset(iesp.foreclosure.t_ForeclosureReportRecord) inFore =dataset([],iesp.foreclosure.t_ForeclosureReportRecord),
														dataset(iesp.foreclosure.t_ForeclosureReportRecord) inNOD = dataset([],iesp.foreclosure.t_ForeclosureReportRecord),
														unsigned6 subjectDID,
														PersonReports.IParam._smartlinxreport inParam) := function;
	//bug 105902 deed only property no field to indicate current so need to hit ownership key.
	//we may end up using this for Assessments also in the future.
	histRec := RECORD
		UNSIGNED3 dt_seen;
		STRING12  ln_fares_id;
		UNSIGNED6 owner_did;
	END;

	currentPriorKey1 := record
		string70 propertyID;
		boolean	 current;
		UNSIGNED4 dt_last_seen;
	end;
	currentPriorKey2 := RECORD
		STRING12 SrcPropRecId;
	END;

	currentPriorKey1 loadCurrentPrior1(recordof(LN_PropertyV2.key_ownership_did()) l) := TRANSFORM
		BOOLEAN addressFound := LENGTH(TRIM(l.prim_range+l.prim_name+l.suffix+l.sec_range)) > 0;
		SELF.propertyID := IF(NOT addressFound,SKIP,
		stringlib.StringCleanSpaces(TRIM(l.prim_range+'|'+
			l.prim_name+'|'+l.suffix+'|'+l.sec_range+'|'+
			IF (l.zip<>'',l.zip,l.p_city_name +'|'+ l.st))));
		SELF.dt_last_seen := l.dt_last_seen;
		SELF.current := l.current;
	END;
	currentPriorKey2 loadCurrentPrior2(histRec l) := TRANSFORM
		SELF.SrcPropRecId := l.ln_fares_id;
	END;
  prop_owned := LN_PropertyV2.key_ownership_did()(KEYED(did=subjectDID));
	prop_owned_addr := DEDUP(SORT(PROJECT(prop_owned,loadCurrentPrior1(LEFT)),PropertyID, -dt_last_seen), PropertyID); 
	currentFound1 := prop_owned_addr(current=TRUE);
	currentFound2 := PROJECT(NORMALIZE(prop_owned(current=TRUE),
		LEFT.hist,TRANSFORM(histRec,SELF:=RIGHT)),loadCurrentPrior2(LEFT));

	priorFound1 := prop_owned_addr(current=FALSE);
	priorFound2 := PROJECT(NORMALIZE(prop_owned(current=FALSE),
		LEFT.hist,TRANSFORM(histRec,SELF:=RIGHT)),loadCurrentPrior2(LEFT));

	isCurrent(STRING70 inPropertyID,STRING12 inSrcPropRecId) := FUNCTION
		RETURN EXISTS(currentFound1(propertyID=inPropertyID))
		OR EXISTS(currentFound2(SrcPropRecId=inSrcPropRecId));
	END;

	isPrior(STRING70 inPropertyID,STRING12 inSrcPropRecId) := FUNCTION
		RETURN EXISTS(priorFound1(propertyID=inPropertyID))
		OR EXISTS(priorFound2(SrcPropRecId=inSrcPropRecId));
	END;

  outLayout := record
	  integer addressSequence;
	  string70 propertyID;
		set of string70 addrs;
		string100 alternatePropID;
		string1 current_prior;
		unsigned6 sortDate;
		boolean NODFound := false;
		boolean FOREFound := false;
		boolean HIDTA := false;
		boolean HIFCA := false;
		boolean CrimeIndexInd := false;
		string1 ResidentialOrBusinessIndicator ;
	  string35 ResidentialOrBusinessDescription ;
		recordof(inAssess);
		dataset(iesp.propdeed.t_DeedReportRecord) Deeds  {MAXCOUNT(iesp.Constants.SMART.MaxDeeds)};
	end;
  nodkey := record
	  string70 propertyID;
		string100 alternatePropID;
	end;
	forekey := record
	  string70 propertyID;
		string100 alternatePropID;
	end;
	
	nodkey  setNODkey(inNOD l) := transform
	    parcelIDLen := length(trim(l.ParcelNumber));
		  addThis := if (parcelIDLen = 0 or l.ParcelNumber[parcelIDLen] = '0','','0');
		  alternateIdToUse := stringlib.StringCleanSpaces(trim(l.ParcelNumber) + addThis);	
      self.alternatePropID := alternateIdToUse;
	    self.propertyID := stringlib.StringCleanSpaces(trim(
			                                                 l.siteaddress.streetnumber+'|'+
	                                  									 l.siteaddress.streetname+'|'+
										                                   l.siteaddress.streetsuffix+'|'+
										                                   l.siteaddress.unitNumber+'|'+
									                                    if (l.siteaddress.zip5 <> '', 
																											l.siteaddress.zip5, l.siteaddress.city +'|'+ l.siteaddress.state)
										));
	end;
	nodkeyRecs := project(inNOD, setNODkey(left));
	forekey  setFOREkey(inNOD l) := transform
	 	  parcelIDLen := length(trim(l.ParcelNumber));
		  addThis := if (parcelIDLen = 0 or l.ParcelNumber[parcelIDLen] = '0','','0');
		  alternateIdToUse := stringlib.StringCleanSpaces(trim(l.ParcelNumber) + addThis);	
      self.alternatePropID := alternateIdToUse;
	    self.propertyID := stringlib.StringCleanSpaces(trim(
			                                                 l.siteaddress.streetnumber+'|'+
	                                  									 l.siteaddress.streetname+'|'+
										                                   l.siteaddress.streetsuffix+'|'+
										                                   l.siteaddress.unitNumber+'|'+
									                                    if (l.siteaddress.zip5 <> '', 
																											l.siteaddress.zip5, l.siteaddress.city +'|'+ l.siteaddress.state)
										));
	end;
	forekeyRecs := project(inFORE, setFOREkey(left));
	outLayout assessPropId(inAssess L) := transform
	   //make sure blank addresses aren't rolled together for assessments that may have ParcelID
		 parcelIDLen := length(trim(l.parcelID));
		 addThis := if (parcelIDLen = 0 or l.parcelId[parcelIDLen] = '0','','0');
		 alternateIdToUse := stringlib.StringCleanSpaces(trim(l.parcelid) + addThis);	
     self.alternatePropID := alternateIdToUse;
		 addressFound := length(trim(l.propertyAddress.streetnumber + l.propertyAddress.streetname +
										      l.propertyAddress.streetsuffix + l.propertyAddress.unitnumber)) > 0;
		 self.propertyID :=  if (addressfound, stringlib.StringCleanSpaces(trim(
		                                                      l.propertyAddress.streetnumber +'|'+
									          	                            l.propertyAddress.streetname +'|'+
										                                      l.propertyAddress.streetsuffix +'|'+
										                                      l.propertyAddress.unitnumber +'|'+
									                                        if (l.propertyAddress.zip5 <> '',
															                            l.propertyAddress.zip5, l.propertyAddress.city +'|'+ l.propertyAddress.state)
																													
									          	)),alternateIdToUse);
    self.current_prior := if ((l.isSubjectOwned and not isPrior(self.propertyID,l.sourcePropertyRecordId)) or isCurrent(self.propertyID,l.sourcePropertyRecordId), iesp.Constants.SMART.CURRENT,iesp.Constants.SMART.PRIOR);
		self.sortDate := 999999999999 - ((l.srt_date * 10000) + l.taxyear) ; 
		self.addrs := [self.propertyID];
	  self := l;
		self := [];
	end;
  outLayout deedPropId(inDeeds L) := transform
	  self.DataSource := L.DataSource;
		parcelIDLen := length(trim(l.parcelID));
		addThis := if (parcelIDLen = 0 or l.parcelId[parcelIDLen] = '0','','0');
     alternateIdToUse := stringlib.StringCleanSpaces(trim(l.parcelid) + addThis);	
     self.alternatePropID := alternateIdToUse;
	  self.propertyID :=  stringlib.StringCleanSpaces(trim( l.propertyAddress.streetnumber +'|'+
									          	                            l.propertyAddress.streetname +'|'+
										                                      l.propertyAddress.streetsuffix +'|'+
										                                      l.propertyAddress.unitnumber +'|'+
									                                        if (l.propertyAddress.zip5 <> '',
															                            l.propertyAddress.zip5, l.propertyAddress.city +'|'+ l.propertyAddress.state)
									          	));
    self.current_prior := if (isCurrent(self.propertyID,l.sourcePropertyRecordId), iesp.Constants.SMART.CURRENT,iesp.Constants.SMART.PRIOR);															
		self.sortDate := 999999999999 - iesp.ecl2esp.DateToInteger(l.recordingdate);//make sure deeds are last when deduping
	  self.addrs := [self.propertyID];
		self := L;
		self := [];
	end;	
	
	fRecsAssess := project(inAssess, assessPropId(LEFT));
	fRecsDeeds := project(inDeeds, deedPropId(LEFT));  //bug 101491 deed only record getting dropped, this adds propID into primary record set.
  fRecs := fRecsAssess + fRecsDeeds;
	//dedup by property address components keeping the most recent even if not currently owned by subject
	sRecsPrimary   := sort(fRecs, propertyID, datasource, sortDate , record);
	dRecsPrimary   := dedup(sRecsPrimary,  propertyID, datasource);
	//dedup a second method, by legalDesc and parcelID keeping the most recent even if not currently owned by subject
	sRecsSecondary := sort(dRecsPrimary, alternatePropID, datasource,  sortDate , record);
	sRecsSecondary rollalternate(sRecsSecondary l, sRecsSecondary r) := transform
	  self.addrs := if(r.propertyID not in l.addrs, l.addrs + [r.propertyID], l.addrs); //accumulate propertyIDs for linking to deeds later.
		self := l;
	end;
	dRecsWAlternateID := rollup(sRecsSecondary(trim(alternatePropID) <> ''),  rollalternate(left,right), alternatePropID, datasource);
	dRecs := sRecsSecondary(trim(alternatePropID)='') + dRecsWAlternateID;
	//primaryID lookup NOD
	outlayout nodFound(drecs l, nodkeyrecs r) := transform
	  self.NODFound := if (r.propertyID <> '',true,false);
	  self := l;
		self := [];
	end;
	
	dRecsWnodPrimary := JOIN(drecs,nodkeyrecs, left.propertyID = right.propertyID, nodFound(left,right), LEFT OUTER, limit(0), keep(1));
  //alternateID lookup NOD
	outlayout nodFoundAlternate(drecs l, nodkeyrecs r) := transform
	  self.NODFound := if (l.NODFOUND, l.NODFOUND, if (r.alternatePropID <> '',true,false));
	  self := l;
		self := [];
	end;
	
	dRecsWnod := JOIN(dRecsWnodPrimary,nodkeyrecs, left.alternatePropID = right.alternatePropID, nodFoundAlternate(left,right), LEFT OUTER, limit(0), keep(1));
	//primaryID lookup FORECLOSURE
	outLayout foreFound(drecs l, forekeyrecs r) := transform
	  self.FOREFound := if (r.propertyID <> '',true,false);
	  self := l;
		self := [];
	end;
	dRecsWforePrimary := JOIN(dRecsWnod,forekeyrecs, left.propertyID = right.propertyID,foreFound(left,right), LEFT OUTER, limit(0), keep(1));
	//alternateID lookup FORECLOSURE
	outLayout foreFoundAlternate(drecs l, forekeyrecs r) := transform
	  self.FOREFound := if (l.FOREFound, l.FOREFound, if (r.alternatePropID <> '',true,false));
	  self := l;
		self := [];
	end;
	dRecsWfore := JOIN(dRecsWnodPrimary,forekeyrecs, left.alternatePropID = right.alternatePropID,foreFoundAlternate(left,right), LEFT OUTER, limit(0), keep(1));
  outLayout addDeeds(dRecsWfore l, inDeeds r) := transform
    self.deeds := if (r.datasource <> '', dataset(r), dataset([],iesp.propdeed.t_DeedReportRecord)); 
		self := l;
		
	end;
  recsNoSort := JOIN(dRecsWfore, inDeeds,left.datasource = right.datasource and
	                            stringlib.StringCleanSpaces(trim(
	                            right.propertyAddress.streetnumber +'|'+
									          	right.propertyAddress.streetname +'|'+
										          right.propertyAddress.streetsuffix +'|'+
										          right.propertyAddress.unitnumber +'|'+
									            if (right.propertyAddress.zip5 <> '',
															right.propertyAddress.zip5,
															right.propertyAddress.city +'|'+
										          right.propertyAddress.state) 
									          	)) in left.addrs, addDeeds(left,right), LEFT OUTER);
   recstoroll := sort(recsNoSort, datasource,propertyID);															
   recstoroll  rollem(recstoroll l, recstoroll r) := transform
       self.deeds := choosen((l.deeds + r.deeds),iesp.Constants.SMART.MaxDeeds)	 ;
	     self := l;
	 end;
	 routRecs := rollup(recstoroll, left.datasource = right.datasource and left.propertyID = right.propertyid, rollem(left,right));
	 // add address typecode and description from address meta data
	 // NOTE: not deduping on address prior to metadata call, at max there is 2 dups, 1 per source, so its not worth the effort.
	 //1 sequence original records for join back in step4
	 outlayout seqOrigAddr(routRecs l, integer c) := transform
	   self.addressSequence := c;
		 self := l;
	 end;
	 routRecsSeq := project(routRecs, seqOrigAddr(left, counter));
	 //2 get all property addresses to lookup meta data
	 iesp.smartlinxreport.t_SLRAddressBpsSeq loadBpsAddrs(routRecsSeq l)  := transform
	    self.addressSequence := l.addressSequence;
	    self.addressEx := l.PropertyAddress;
			self := [];
	 end;
	 
	 addrs4Meta := project(routRecsSeq, loadBpsAddrs(LEFT));
	 //3 pass to SmartRollup.fn_smart_getAddrMetadata.addresses(addresses)
	 addrWMeta := SmartRollup.fn_smart_getAddrMetadata.addresses(addrs4Meta,,inParam);
	 //4 join results from 3 back to original rolled up out recs
	 outlayout loadAddrType(routRecsSeq l, addrWMeta r) := transform
	   self.ResidentialOrBusinessIndicator := r.AddressCDS.ResidentialOrBusinessIndicator ;
	   self.ResidentialOrBusinessDescription := r.AddressCDS.ResidentialOrBusinessDescription;
		 self.PropertyAddress.state := if (l.PropertyAddress.state <> '', 
 			                                 l.PropertyAddress.state, 
				    														ut.stFips2stAbbrev(l.fipscode[1..2])) ;
		 self.HIDTA := r.HIDTA;
		 self.HIFCA := r.HIFCA;
		 self.CrimeIndexInd := r.CrimeIndexInd;
		 self := l;
	 end;
	 
	 RecsMeta := join(routRecsSeq, addrWMeta, left.addressSequence = right.addressSequence, loadAddrType(left,right),left outer);
   // lookup property address COUNTY NAME if its still missing at this point, state abbrev was filled in above if it was missing.
	 RecsMetaCounty := RecsMeta(propertyAddress.County <> '');
	 RecsMetaNoCounty := RecsMeta(propertyAddress.County = '');
   census_data.MAC_Fips2County_Keyed(RecsMetaNoCounty, propertyAddress.state, fipscode[3..5], propertyAddress.County, RecsMetaCountyFix); 																					
   routRecsMeta := RecsMetaCounty + RecsMetaCountyFix;
	 //
	 routRecsSt := sort(routRecsMeta, current_prior, propertyAddress.state);
	 xrec := record
	   routRecsSt.current_prior;
     routRecsSt.propertyAddress.state;
     propFound := count(group);
   end;
	 
   xtab := table(routRecsSt,xrec,current_prior, propertyAddress.state,few);
   jds := join(routRecsSt, xtab, left.current_prior = right.current_prior and left.propertyAddress.state = right.state, left outer);

   //
	 //Final sort order = All Current then all Prior, within Current/Prior, States with most properties found first, 
	 //                   if equal number found in more than 1 state then alphabetical by state abbrev, 
	 //										after that order by date most recent first.
   soutRecs := sort(jds,current_prior,-propfound, propertyAddress.state, sortDate, propertyID, datasource);
   outRecs := project(soutRecs,transform(iesp.smartlinxreport.t_SLRPropertyAssessmentDeedsRecord, 
	                                        self.CurrentPrior := LEFT.current_prior, 
																					self.NoticeOfDefaultFound := LEFT.NODFound,
																					self.ForeclosureFound := LEFT.FOREFound,
																					self:=left, self := []));

	 RETURN outRecs; 
	
end;
