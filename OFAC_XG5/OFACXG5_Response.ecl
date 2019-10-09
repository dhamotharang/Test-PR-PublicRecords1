Import STD, OFAC_XG5;

export OFACXG5_Response (DATASET(OFAC_XG5.Layout.SearchResultsSlimmed) XG5Slim	)  := FUNCTION

//  Sections of code are commented out as those parts of the Result are not used at this time.  They are ready to use if there are future requirements.

EntityRecsCount := count(XG5Slim);

OFAC_XG5.Layout.NormEntityRecord	breakoutentity(OFAC_XG5.Layout.SearchResultsSlimmed le, integer EntityMtchCounter) := TRANSFORM
	self.BlockID := le.blockid;
	self.EntitySeq := EntityMtchCounter;
	self.Matches := le.EntityRecords.Matches[EntityMtchCounter];
	self.CountMatches := count(le.EntityRecords.Matches);
	self.Countcodes := count(le.EntityRecords.Matches[EntityMtchCounter].codes);
	self.Countcities := count(le.EntityRecords.Matches[EntityMtchCounter].cities);
	self.Countaddress := count(le.EntityRecords.Matches[EntityMtchCounter].address.addressdetails);
	self.Countakas := count(le.EntityRecords.Matches[EntityMtchCounter].name.akas);
	self.CountMatchIDDetails := count(le.EntityRecords.Matches[EntityMtchCounter].id.identificationdetails);
	self.CountDesc := count(le.EntityRecords.Matches[EntityMtchCounter].Descriptions);
	self.CountDOB := count(le.EntityRecords.Matches[EntityMtchCounter].DOB.AdditionalInformation);
	self.CountTerms := count(le.EntityRecords.Matches[EntityMtchCounter].Terms);
	self.CountPorts := count(le.EntityRecords.Matches[EntityMtchCounter].Ports);
	self.CountPhone := count(le.EntityRecords.Matches[EntityMtchCounter].Phone.AdditionalInformation);
	self.CountCitizen := count(le.EntityRecords.Matches[EntityMtchCounter].Citizenship.Citizenships);
	self.DOBConflict := le.EntityRecords.Matches[EntityMtchCounter].DOB.Conflict;
	self := [];
end;

normedEntityMatches := NORMALIZE(XG5Slim, count(XG5Slim.EntityRecords[left.EntityRecSeq].Matches), BreakOutEntity(LEFT, COUNTER));
	

OFAC_XG5.Layout.ResultMatchID  BreakOutIDDetails(normedEntityMatches le, integer ID_counter) := TRANSFORM
  self.blockid := le.blockid;
	self.EntitySeq :=  le.EntitySeq;
	self.MatchIDBestScore  := le.Matches.ID.BestScore;
	self.MatchIDConflict  := le.Matches.ID.Conflict;
	self.MatchIDIndexMatch  := le.Matches.ID.IndexMatch;
  self.MatchIDEFTValue  := STD.Str.ToUpperCase(le.Matches.ID.AdditionalInformation[ID_counter].EFTValue);
	self.MatchIDPartialAddress  := le.Matches.ID.AdditionalInformation[ID_counter].PartialAddress;
	self.MatchIDScore   := le.Matches.ID.AdditionalInformation[ID_counter].Score;
	self.MatchIDSourceID  := le.Matches.ID.AdditionalInformation[ID_counter].SourceID;
	self.MatchIDValueType := le.Matches.ID.AdditionalInformation[ID_counter].ValueType;
	self.MatchIDInputInstance := le.Matches.ID.AdditionalInformation[ID_counter].InputInstance;
	//end of addt'l info DS
  self.MatchIDID := le.Matches.ID.IdentificationDetails[ID_counter].ID;
	self.MatchIDType := le.Matches.ID.IdentificationDetails[ID_counter]._Type;
	self.MatchIDTypeDesc := trim(STD.Str.ToUpperCase(OFAC_XG5.Constants.IDType(le.Matches.ID.IdentificationDetails[ID_counter]._Type)));
	self.MatchIDLabel := STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].Label);
	self.MatchIDNumber := STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].Number);
	self.MatchIDIssuer  := STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].Issuer);
	self.MatchIDIssueDate  := STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].IssueDate);
	self.MatchIDExpDate  := STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].ExpDate);
	self.MatchIDNotes  := STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].Notes);
	self.MatchIDremarks := trim(trim(STD.Str.ToUpperCase(OFAC_XG5.Constants.IDType(le.Matches.ID.IdentificationDetails[ID_counter]._Type))) + ' ' 
												+ trim(STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].Label)) + ' '
												+ trim(STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].Number)) + ' '
												+ trim(STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].Issuer)) + ' '
												+ trim(STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].IssueDate)) + ' '
												+ trim(STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].ExpDate)) + ' '
												+ trim(STD.Str.ToUpperCase(le.Matches.ID.IdentificationDetails[ID_counter].Notes)));
	self.MatchIDRemarkscount := ID_counter;
end;

normed_MatchID := NORMALIZE(normedEntityMatches, left.CountMatchIDDetails, BreakOutIDDetails(LEFT, COUNTER))(MatchIDremarks <> '');


OFAC_XG5.Layout.ResultMatchEntityValue  BreakOutCodesDetails(normedEntityMatches le, integer codes_counter) := TRANSFORM
	self.blockid := le.blockid;
	self.EntitySeq :=  le.EntitySeq;
	self.ID  := le.Matches.Codes[codes_counter].ID;
	self.ResultValue := le.Matches.Codes[codes_counter].Value;
	self.recordcount := codes_counter;
end;

normed_codes := NORMALIZE(normedEntityMatches, left.Countcodes, BreakOutCodesDetails(LEFT, COUNTER))(resultvalue <> '');

OFAC_XG5.Layout.ResultMatchEntityValue  BreakOutTermsDetails(normedEntityMatches le, integer terms_counter) := TRANSFORM
	self.blockid := le.blockid;
	self.EntitySeq :=  le.EntitySeq;
	self.ID  := le.Matches.Terms[terms_counter].ID;
	self.ResultValue := le.Matches.Terms[terms_counter].Value;
	self.recordcount := terms_counter;
end;

normed_Terms := NORMALIZE(normedEntityMatches(CountTerms > 0), left.CountTerms,BreakOutTermsDetails(LEFT, COUNTER))(resultvalue <> '');

OFAC_XG5.Layout.ResultMatchEntityDescription BreakOutDescDetails(normedEntityMatches le, integer Desc_counter) := TRANSFORM
  self.blockid := le.blockid;
	self.EntitySeq :=  le.EntitySeq;
	self.DescriptionsID  := le.Matches.Descriptions[Desc_counter].id;
	self.DescriptionsType  := le.Matches.Descriptions[Desc_counter]._Type;
	self.DescriptionsTypeDesc  := trim(STD.Str.ToUpperCase(OFAC_XG5.Constants.AdditionalInfoType(le.Matches.Descriptions[Desc_counter]._Type)));
	self.DescriptionsTypeValue  := STD.Str.ToUpperCase(le.Matches.Descriptions[Desc_counter].Value);
	self.DescriptionsNotes  := STD.Str.ToUpperCase(le.Matches.Descriptions[Desc_counter].Notes);
	self.recordcount := Desc_counter;
	self.remarks := trim(trim(STD.Str.ToUpperCase(OFAC_XG5.Constants.AdditionalInfoType(le.Matches.Descriptions[Desc_counter]._Type))) + ' ' 
								+ trim(STD.Str.ToUpperCase(le.Matches.Descriptions[Desc_counter].Value)) + ' '
								+ trim(STD.Str.ToUpperCase(le.Matches.Descriptions[Desc_counter].Notes)));
	self.remarksCount := Desc_counter;
end;

normed_Descriptions := NORMALIZE(normedEntityMatches, left.CountDesc, BreakOutDescDetails(LEFT, COUNTER))(DescriptionsTypeValue <> '');

OFAC_XG5.Layout.ResultMatchFile BreakOutFileDetails(normedEntityMatches le) := TRANSFORM
	self.blockid := le.blockid;
	self.EntitySeq :=  le.EntitySeq;
	self.BuildDate :=  STD.Str.ToUpperCase(le.Matches.File.Build);
	self.CustomFile := le.Matches.File.Custom;
	self.FileID  := le.Matches.File.ID;
	self.FileIndex  := le.Matches.File.Index;
	fileNameTemp := if(STD.Str.ToUpperCase(trim(le.Matches.File.Name)) = 'BANK OF ENGLAND CONSOLIDATED LIST.BDF', 'UK HM TREASURY LIST.BDF', trim(STD.Str.ToUpperCase(le.Matches.File.Name)));
	self.FileName :=  fileNameTemp;
	self.PublishedDate :=  trim(STD.Str.ToUpperCase(le.Matches.File.Published));
	self.FileType := STD.Str.ToUpperCase(le.Matches.File._Type);
	
	self := [];
END;	

//there is only one file per matched entity
normed_files := project(normedEntityMatches ,BreakOutFileDetails(LEFT)); 

OFAC_XG5.Layout.EntityMatch BreakOutEntityDetails(normedEntityMatches le, integer entity_counter) := TRANSFORM
  self.BlockID  :=  le.blockid;
	self.EntitySeq  :=  le.Entityseq;
	self.EntityCheckSum  :=  le.Matches.Entity.EntityDetails.CheckSum;
	self.EntityCountry  :=  STD.Str.ToUpperCase(le.Matches.Entity.EntityDetails.Country);
	self.EntityDate  :=  STD.Str.ToUpperCase(le.Matches.Entity.EntityDetails.Date);
	self.EntityGender :=  STD.Str.ToUpperCase(le.Matches.Entity.EntityDetails.Gender);
	self.EntityNameFull   :=  if(le.Matches.Entity.EntityDetails._Type = 5, STD.Uni.ToUpperCase(le.Matches.Entity.EntityDetails.Country), STD.Uni.ToUpperCase(le.Matches.Entity.EntityDetails.Name.Full));
	self.EntityNameTitle   :=  STD.Uni.ToUpperCase(le.Matches.Entity.EntityDetails.Name.title);
	self.EntityNameFirst   :=  STD.Uni.ToUpperCase(le.Matches.Entity.EntityDetails.Name.first);
	self.EntityNameMiddle    :=  STD.Uni.ToUpperCase(le.Matches.Entity.EntityDetails.Name.middle);
	self.EntityNameLast   :=  STD.Uni.ToUpperCase(le.Matches.Entity.EntityDetails.Name.last);
	self.EntityNameGeneration    :=  STD.Uni.ToUpperCase(le.Matches.Entity.EntityDetails.Name.Generation);
	self.EntityNotes    :=  STD.Str.ToUpperCase(le.Matches.Entity.EntityDetails.Notes);
  UniqueIDLength := length(le.Matches.Entity.EntityUniqueID);
  EntityNumLength := length(le.Matches.Entity.EntityDetails.Number);
	self.EntityNumber    :=  STD.Str.ToUpperCase(le.Matches.Entity.EntityDetails.Number);
	self.EntityReason    :=  STD.Str.ToUpperCase(le.Matches.Entity.EntityDetails.Reason);
	self.EntityType    :=  le.Matches.Entity.EntityDetails._Type;  // type = 5 = country 
	self.EntityTypeDesc := trim(STD.Str.ToUpperCase(OFAC_XG5.Constants.ENTITYtype(le.Matches.entity.EntityDetails._Type)));
	self.EntityUniqueID   :=  STD.Str.ToUpperCase(le.Matches.Entity.EntityUniqueID);
	self.SearchCriteria    :=  STD.Str.ToUpperCase(le.Matches.Entity.SearchCriteria);
	self.MatchRealert   :=  le.Matches.Entity.MatchRealert;
	self.EntityName   :=  STD.Uni.ToUpperCase(le.Matches.Entity.Name);
	self.EntityOffset   :=  le.Matches.Entity.Offset;
	self.EntityPrevResultID    :=  le.Matches.Entity.PrevResultID;
	self.EntitymatchScore   :=  le.Matches.Entity.Score  * .01;
	self.EntitySourceNumber   :=  STD.Str.ToUpperCase(le.Matches.Entity.SourceNumber);
	self.EntityTypeConflict   :=  le.Matches.Entity.TypeConflict;
	self.EntityPartyKey := STD.Str.ToUpperCase(le.Matches.Entity.EntityDetails.Number);

	self := [];
END;

normed_EntityTemp := NORMALIZE(normedEntityMatches, 1, BreakOutEntityDetails(LEFT, COUNTER));  //only entity per match
 
OFAC_XG5.Layout.EntityMatch  CheckPrtyPrefix( normed_EntityTemp le , normed_files ri) := TRANSFORM
  sourceLength := length(ri.FileName);
  cntryFiles := ri.FileType = OFAC_XG5.Constants.CountryFiles;
	cntryNumber := OFAC_XG5.Constants.CountryKey(STD.Str.ToUpperCase(trim(le.EntityCountry)));
	VendorFiles := STD.Str.ToUpperCase(trim(ri.FileName)) = OFAC_XG5.Constants.OFACSDN and le.EntityPartyKey = '';
	Keyprefix := trim(OFAC_XG5.Constants.PtyKeyPrefix(STD.Str.ToUpperCase(trim(ri.FileName)), (string)le.EntityType));
	self.EntityPartyKey := 	MAP(le.EntityPartyKey = '' and VendorFiles => OFAC_XG5.Constants.VendorRecFlag,
															le.EntityPartyKey <> '' and cntryFiles  => Keyprefix + cntryNumber,
															le.EntityPartyKey <> ''  => Keyprefix + trim(le.EntityNumber),
															le.EntityPartyKey = '' => Keyprefix,
															'');
	self := le;
	
END;
 
normed_Entity := join(normed_EntityTemp, normed_files, left.BlockID = right.blockid and left.EntitySeq =  right.Entityseq,
											CheckPrtyPrefix(LEFT, RIGHT),left outer);
											
											
OFAC_XG5.Layout.AddressMatches BreakOutAddrDetails(normedEntityMatches le, integer addr_counter) := TRANSFORM
	self.blockid := le.blockid;
	self.EntitySeq :=  le.EntitySeq;
	self.AddressCount := count(le.Matches.Address.AddressDetails); 
	self.AddressEFTValue := STD.Str.ToUpperCase(le.Matches.Address.AdditionalInformation[addr_counter].EFTValue);
	self.AddressPartialAddress := le.Matches.Address.AdditionalInformation[addr_counter].PartialAddress;
	self.AddressScore := le.Matches.Address.AdditionalInformation[addr_counter].Score;
	self.AddressSourceID := le.Matches.Address.AdditionalInformation[addr_counter].SourceID;
	self.AddressValueType := le.Matches.Address.AdditionalInformation[addr_counter].ValueType;
	self.AddressInputInstance := le.Matches.Address.AdditionalInformation[addr_counter].InputInstance;
	// addtl info
	self.AddressBestScore :=  le.Matches.Address.BestScore;
	self.AddressBest :=  STD.Str.ToUpperCase(le.Matches.Address.Best);
	self.AddressBestIsPartial :=  le.Matches.Address.BestIsPartial;
	self.AddressConflict :=  le.Matches.Address.Conflict;
	self.AddressIndexMatch :=  le.Matches.Address.IndexMatch;
	self.AddressBestInputID :=  le.Matches.Address.BestInputID;
	self.AddressBestListID :=  le.Matches.Address.BestListID;
	self.addressID :=  le.Matches.Address.AddressDetails[addr_counter].ID;
	self.addressType := le.Matches.Address.AddressDetails[addr_counter]._Type;
	self.addressTypeDesc  := trim(STD.Str.ToUpperCase(OFAC_XG5.Constants.ADDRESStype(le.Matches.Address.AddressDetails[addr_counter]._Type)));
	self.FullAddress  :=  trim(STD.Str.ToUpperCase(le.Matches.Address.AddressDetails[addr_counter].FullAddress));
	self.StreetAddress1 :=  trim(STD.Str.ToUpperCase(le.Matches.Address.AddressDetails[addr_counter].StreetAddress1));
	self.StreetAddress2 :=  trim(STD.Str.ToUpperCase(le.Matches.Address.AddressDetails[addr_counter].StreetAddress2));
	self.City := STD.Str.ToUpperCase(le.Matches.Address.AddressDetails[addr_counter].City);
	self.State :=  STD.Str.ToUpperCase(le.Matches.Address.AddressDetails[addr_counter].State);
	self.PostalCode := STD.Str.ToUpperCase(le.Matches.Address.AddressDetails[addr_counter].PostalCode);
	self.Country := STD.Str.ToUpperCase(le.Matches.Address.AddressDetails[addr_counter].Country);
	self.Notes := STD.Str.ToUpperCase(le.Matches.Address.AddressDetails[addr_counter].Notes);
	self := [];
END;	

normed_address := NORMALIZE(normedEntityMatches, left.countaddress, BreakOutAddrDetails(LEFT, COUNTER))(AddressCount > 0);

OFAC_XG5.Layout.AKABestMatches BreakOutAKADetails(normedEntityMatches le, integer aka_counter) := TRANSFORM
	self.blockid  :=  le.blockid;
	self.EntitySeq  :=  le.EntitySeq;
  self.BestID  :=  le.Matches.Name.BestID;
  self.BestScore  :=  le.Matches.Name.BestScore   * .01;
	self.BestName  :=  STD.Uni.ToUpperCase(le.Matches.Name.Best);
	self.akaID :=  le.Matches.Name.akas[aka_counter].id;
	self.akaTypeDesc  := trim(STD.Str.ToUpperCase(OFAC_XG5.Constants.AKAType(le.Matches.Name.akas[aka_counter]._Type)));
	self.FullName  :=  trim(STD.Uni.ToUpperCase(le.Matches.Name.akas[aka_counter].Full));
	self.Title :=  trim(STD.Uni.ToUpperCase(le.Matches.Name.akas[aka_counter].Title));
	self.FirstName :=  trim(STD.Uni.ToUpperCase(le.Matches.Name.akas[aka_counter].First));
	self.MiddleName := STD.Uni.ToUpperCase(le.Matches.Name.akas[aka_counter].Middle);
	self.LastName :=  STD.Uni.ToUpperCase(le.Matches.Name.akas[aka_counter].Last);
	self.Generation := le.Matches.Name.akas[aka_counter].Generation;
	self.Category := le.Matches.Name.akas[aka_counter].Category;
	self.Notes := STD.Str.ToUpperCase(le.Matches.Name.akas[aka_counter].Notes);
	self := [];
END;

normed_akasTemp := NORMALIZE(normedEntityMatches, left.Countakas, BreakOutAKADetails(LEFT, COUNTER))(akaID <> 0);

OFAC_XG5.Layout.AKABestMatches BreakOutAKADetailsBest(normedEntityMatches le, integer aka_counter) := TRANSFORM
	self.blockid  :=  le.blockid;
	self.EntitySeq  :=  le.EntitySeq;
  self.BestID  :=  le.Matches.Name.BestID;
  self.BestScore  :=  le.Matches.Name.BestScore   * .01;
	self.BestName  :=  STD.Uni.ToUpperCase(le.Matches.Name.Best);
	self.akaID :=  le.Matches.Name.BestID;
	self.akaTypeDesc  := 'BEST';
	self.FullName  :=  trim(STD.Uni.ToUpperCase(le.Matches.Name.Best));
	self := [];
END;

//create additional aka record when the Best name is the input name - then no AKA child record is in the response
normed_akasBest := NORMALIZE(normedEntityMatches(Matches.Name.BestID = 0),1,BreakOutAKADetailsBest(LEFT, COUNTER));

normed_akas := sort(normed_akasTemp + normed_akasBest, blockid, entityseq);

OFAC_XG5.Layout.ResultMatchDOB  BreakOutDOBDetails(normedEntityMatches le, integer DOB_counter) := TRANSFORM
	self.blockid := le.blockid;
	self.EntitySeq :=  le.EntitySeq;
	self.DOBBestIsPartial:= le.Matches.DOB.BestIsPartial;
	self.DOBBestScore := le.Matches.DOB.BestScore;
	self.DOBConflict  := le.Matches.DOB.Conflict;
	self.DOBEFTValue  := STD.Str.ToUpperCase(le.Matches.DOB.AdditionalInformation[DOB_counter].EFTValue);
	self.DOBPartialAddress := le.Matches.DOB.AdditionalInformation[DOB_counter].PartialAddress;
	self.DOBScore  := le.Matches.DOB.AdditionalInformation[DOB_counter].Score;
	self.DOBSourceID := le.Matches.DOB.AdditionalInformation[DOB_counter].SourceID;
	self.DOBValueType := le.Matches.DOB.AdditionalInformation[DOB_counter].ValueType;
	self.DOBInputInstance := le.Matches.DOB.AdditionalInformation[DOB_counter].InputInstance;
end;

normed_DOB := NORMALIZE(normedEntityMatches, left.CountDOB, BreakOutDOBDetails(LEFT, COUNTER))(DOBBestScore <> 0);

OFAC_XG5.Layout.ResponseRec BreakOutDetails(normedEntityMatches le, XG5Slim ri) := TRANSFORM
// Sections that are not used anywhere are commented out just need to uncomment if future need arises.
	self.BlockID :=  le.BlockID;
	self.EntitySeq := le.EntitySeq;
	self.AddrRec := join(normedEntityMatches(EntitySeq = le.EntitySeq  and blockid = le.blockid), normed_address, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.AddressMatches, self := right), left outer);
	self.AKARec := join(normedEntityMatches(EntitySeq = le.EntitySeq  and blockid = le.blockid), normed_akas, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.AKABestMatches, self := right), left outer);
	self.FileRec := join(normedEntityMatches(EntitySeq = le.EntitySeq and blockid = le.blockid), normed_files, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.ResultMatchFile, self := right), left outer);
	self.EntityRec := join(normedEntityMatches(EntitySeq = le.EntitySeq and blockid = le.blockid), normed_Entity, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.EntityMatch, self := right), left outer);
	self.DOBRec := join(normedEntityMatches(EntitySeq = le.EntitySeq and blockid = le.blockid), normed_DOB, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.ResultMatchDOB, self := right), left outer);	
	self.CodesRec := join(normedEntityMatches(EntitySeq = le.EntitySeq and blockid = le.blockid), normed_codes, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.ResultMatchEntityValue, self := right), left outer);
	self.TermsRec := join(normedEntityMatches(EntitySeq = le.EntitySeq and blockid = le.blockid), normed_terms, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.ResultMatchEntityValue, self := right), left outer);
	self.DescRec := join(normedEntityMatches(EntitySeq = le.EntitySeq and blockid = le.blockid), normed_Descriptions, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.ResultMatchEntityDescription, self := right), left outer);
	self.MatchIDRec := join(normedEntityMatches(EntitySeq = le.EntitySeq and blockid = le.blockid), normed_MatchID, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.ResultMatchID, self := right), left outer);											
	self := ri;
	self := [];
END;

AllRecordsTEMP := join(normedEntityMatches(~DOBConflict), XG5Slim, left.blockid = right.seq ,BreakOutDetails(left, right), right outer); 

AllRecords := AllRecordsTemp(EntityRec[1].EntityPartyKey <> OFAC_XG5.Constants.VendorRecFlag);

	return AllRecords;
END;