Import Gateway, IESP, lib_stringlib;

export OFACXG5_Watchlist2_Response (DATASET(OFAC_XG5.Layout.SearchResultsSlimmed) XG5Slim	)  := FUNCTION


EntityRecsCount := count(XG5Slim);

OFAC_XG5.Layout.NormEntityRecord	breakoutentity(OFAC_XG5.Layout.SearchResultsSlimmed le, integer EntityMtchCounter) := TRANSFORM
	self.BlockID := le.blockid;
	self.EntitySeq := EntityMtchCounter;
	self.searchType := le.searchType;
	self.Matches := le.EntityRecords.Matches[EntityMtchCounter];
	self.CountMatches := count(le.EntityRecords.Matches);
	self.Countaddress := count(le.EntityRecords.Matches[EntityMtchCounter].address.addressdetails);
	self.Countakas := count(le.EntityRecords.Matches[EntityMtchCounter].name.akas);
	self.DOBConflict := le.EntityRecords.Matches[EntityMtchCounter].DOB.Conflict;
	self.origFullName := le.ResponseFullName;
	self := [];
end;
//drop error records here
normedEntityMatches := NORMALIZE(XG5Slim(errormessage = ''), count(left.EntityRecords.Matches), BreakOutEntity(LEFT, COUNTER));

OFAC_XG5.Layout.NormEntityRecord	reseqEntity(normedEntityMatches le, integer EntityMtchseq) := TRANSFORM
	self.BlockID := le.blockid;
	self.EntitySeq := EntityMtchseq;
	self := le;
	self := [];
end;

groupEntity := group(normedEntityMatches, blockid);

ReseqEntityMatches :=  iterate(groupEntity, 
															 transform(OFAC_XG5.Layout.NormEntityRecord,
																					self.EntitySeq := counter, self := right));

AddressRec := ReseqEntityMatches(Countaddress > 0);

OFAC_XG5.Layout.ResultMatchFile BreakOutFileDetails(ReseqEntityMatches le) := TRANSFORM
	self.blockid := le.blockid;
	self.EntitySeq :=  le.EntitySeq;
	self.BuildDate :=  le.Matches.File.Build;
	self.CustomFile := le.Matches.File.Custom;
	self.FileID  := le.Matches.File.ID;
	self.FileIndex  := le.Matches.File.Index;
	fileNameTemp := if(lib_stringlib.stringlib.StringToUpperCase(trim(le.Matches.File.Name)) = 'BANK OF ENGLAND CONSOLIDATED LIST.BDF', 'UK HM TREASURY LIST.BDF', trim(le.Matches.File.Name));
	self.FileName :=  fileNameTemp;
	self.FileKeyPrefix := trim(OFAC_XG5.Constants.PtyKeyPrefix(lib_stringlib.stringlib.StringToUpperCase(trim(le.Matches.File.Name))));
	self.PublishedDate :=  trim(le.Matches.File.Published);
	self.FileType := le.Matches.File._Type;
	
	self := [];
END;	

//there is only one file per matched entity
normed_files := project(ReseqEntityMatches ,BreakOutFileDetails(LEFT)); 

OFAC_XG5.Layout.EntityMatch BreakOutEntityDetails(ReseqEntityMatches le, integer entity_counter) := TRANSFORM
  self.BlockID  :=  le.blockid;
	self.EntitySeq  :=  le.Entityseq;
	self.EntityCheckSum  :=  le.Matches.Entity.EntityDetails.CheckSum;
	self.EntityCountry  :=  le.Matches.Entity.EntityDetails.Country;
	self.EntityDate  :=  le.Matches.Entity.EntityDetails.Date;
	self.EntityGender :=  le.Matches.Entity.EntityDetails.Gender;
	self.EntityNameFull   :=  if(le.Matches.Entity.EntityDetails._Type = 5, le.Matches.Entity.EntityDetails.Country, le.Matches.Entity.EntityDetails.Name.Full);
	self.EntityNameTitle   :=  le.Matches.Entity.EntityDetails.Name.title;
	self.EntityNameFirst   :=  le.Matches.Entity.EntityDetails.Name.first;
	self.EntityNameMiddle    :=  le.Matches.Entity.EntityDetails.Name.middle;
	self.EntityNameLast   :=  le.Matches.Entity.EntityDetails.Name.last;
	self.EntityNameGeneration    :=  le.Matches.Entity.EntityDetails.Name.Generation;
	self.EntityNotes    :=  le.Matches.Entity.EntityDetails.Notes;
  UniqueIDLength := length(le.Matches.Entity.EntityUniqueID);
  EntityNumLength := length(le.Matches.Entity.EntityDetails.Number);
	self.EntityNumber    :=   le.Matches.Entity.EntityDetails.Number;
	self.EntityReason    :=  le.Matches.Entity.EntityDetails.Reason;
	self.EntityType    :=  le.Matches.Entity.EntityDetails._Type;  // type = 5 = country 
	self.EntityTypeDesc := trim(OFAC_XG5.Constants.ENTITYtype(le.Matches.entity.EntityDetails._Type));
	self.EntityUniqueID   :=  le.Matches.Entity.EntityUniqueID;
	self.SearchCriteria    :=  le.Matches.Entity.SearchCriteria;
	self.MatchRealert   :=  le.Matches.Entity.MatchRealert;
	self.EntityName   :=  le.Matches.Entity.Name;
	self.EntityOffset   :=  le.Matches.Entity.Offset;
	self.EntityPrevResultID    :=  le.Matches.Entity.PrevResultID;
	self.EntitymatchScore   :=  le.Matches.Entity.Score  * .01;
	self.EntitySourceNumber   :=  le.Matches.Entity.SourceNumber;
	self.EntityTypeConflict   :=  le.Matches.Entity.TypeConflict;
	self.EntityPartyKey := le.Matches.Entity.EntityDetails.Number;

	self := [];
END;

normed_EntityTemp := project(ReseqEntityMatches ,BreakOutEntityDetails(LEFT, COUNTER));  //only entity per match
 
											
OFAC_XG5.Layout.EntityMatch  CheckPrtyPrefix( normed_EntityTemp le , normed_files ri) := TRANSFORM
  sourceLength := length(ri.FileName);
  cntryFiles := ri.FileType = OFAC_XG5.Constants.CountryFiles;
	VendorFiles := lib_stringlib.stringlib.StringToUpperCase(trim(ri.FileName)) = OFAC_XG5.Constants.OFACSDN and le.EntityPartyKey = '';
	cntryNumber := OFAC_XG5.Constants.CountryKey(lib_stringlib.stringlib.StringToUpperCase(trim(le.EntityCountry)));
	Keyprefix := trim(OFAC_XG5.Constants.PtyKeyPrefix(lib_stringlib.stringlib.StringToUpperCase(trim(ri.FileName)), (string)le.EntityType));

	self.EntityPartyKey := 	MAP(le.EntityPartyKey = '' and VendorFiles => OFAC_XG5.Constants.VendorRecFlag,
															le.EntityPartyKey <> '' and cntryFiles  => Keyprefix + cntryNumber,
															le.EntityPartyKey <> ''  => Keyprefix + trim(le.EntityNumber),
															le.EntityPartyKey = '' => Keyprefix,
															'');
	self := le;
	
END;
 
normed_Entity := join(normed_EntityTemp, normed_files, left.BlockID = right.blockid and left.EntitySeq =  right.Entityseq,
											CheckPrtyPrefix(LEFT, RIGHT),left outer);
											

OFAC_XG5.Layout.AKABestMatches BreakOutAKADetails(normedEntityMatches le, integer aka_counter) := TRANSFORM
	self.blockid  :=  le.blockid;
	self.EntitySeq  :=  le.EntitySeq;
  self.BestID  :=  le.Matches.Name.BestID;
  self.BestScore  :=  le.Matches.Name.BestScore   * .01;
	self.BestName  :=  trim(le.Matches.Name.Best);
	self.akaID :=  le.Matches.Name.akas[aka_counter].id;
	self.akaTypeDesc  := trim(OFAC_XG5.Constants.AKAType(le.Matches.Name.akas[aka_counter]._Type));
	self.FullName  :=  trim(le.Matches.Name.akas[aka_counter].Full);
	self.Title :=  trim(le.Matches.Name.akas[aka_counter].Title);
	self.FirstName :=  trim(le.Matches.Name.akas[aka_counter].First);
	self.MiddleName := le.Matches.Name.akas[aka_counter].Middle;
	self.LastName :=  le.Matches.Name.akas[aka_counter].Last;
	self.Generation := le.Matches.Name.akas[aka_counter].Generation;
	self.Category := le.Matches.Name.akas[aka_counter].Category;
	self.Notes := le.Matches.Name.akas[aka_counter].Notes;
	self := [];
END;

normed_akasTemp := NORMALIZE(normedEntityMatches, left.Countakas, BreakOutAKADetails(LEFT, COUNTER))(akaID <> 0);

OFAC_XG5.Layout.AKABestMatches BreakOutAKADetailsBest(normedEntityMatches le, integer aka_counter) := TRANSFORM
	self.blockid  :=  le.blockid;
	self.EntitySeq  :=  le.EntitySeq;
  self.BestID  :=  le.Matches.Name.BestID;
  self.BestScore  :=  le.Matches.Name.BestScore   * .01;
	self.BestName  :=  Trim(le.Matches.Name.Best);
	self.akaID :=  le.Matches.Name.BestID;
	self.akaTypeDesc  := 'BEST';
	self.FullName  :=  trim(le.Matches.Name.Best);
	self := [];
END;

//create additional aka record when the Best name is the input name - then no AKA child record is in the response
normed_akasBest := NORMALIZE(normedEntityMatches(Matches.Name.BestID = 0),1,BreakOutAKADetailsBest(LEFT, COUNTER));

normed_akas := sort(normed_akasTemp + normed_akasBest, blockid, entityseq);

OFAC_XG5.Layout.AddressMatches BreakOutAddrDetails(ReseqEntityMatches le, integer addr_counter) := TRANSFORM
	self.blockid := le.blockid;
	self.EntitySeq :=  le.EntitySeq;
	self.AddressCount := count(le.Matches.Address.AddressDetails); //count(le.Matches.Address.AddressDetails);
	self.AddressEFTValue := le.Matches.Address.AdditionalInformation[addr_counter].EFTValue;
	self.AddressPartialAddress := le.Matches.Address.AdditionalInformation[addr_counter].PartialAddress;
	self.AddressScore := le.Matches.Address.AdditionalInformation[addr_counter].Score;
	self.AddressSourceID := le.Matches.Address.AdditionalInformation[addr_counter].SourceID;
	self.AddressValueType := le.Matches.Address.AdditionalInformation[addr_counter].ValueType;
	self.AddressInputInstance := le.Matches.Address.AdditionalInformation[addr_counter].InputInstance;
	// addtl info
	self.AddressBestScore :=  le.Matches.Address.BestScore;
	self.AddressBest :=  le.Matches.Address.Best;
	self.AddressBestIsPartial :=  le.Matches.Address.BestIsPartial;
	self.AddressConflict :=  le.Matches.Address.Conflict;
	self.AddressIndexMatch :=  le.Matches.Address.IndexMatch;
	self.AddressBestInputID :=  le.Matches.Address.BestInputID;
	self.AddressBestListID :=  le.Matches.Address.BestListID;
	self.addressID :=  le.Matches.Address.AddressDetails[addr_counter].ID;
	self.addressType := le.Matches.Address.AddressDetails[addr_counter]._Type;
	self.addressTypeDesc  := trim(OFAC_XG5.Constants.ADDRESStype(le.Matches.Address.AddressDetails[addr_counter]._Type));
	self.FullAddress  :=  trim(le.Matches.Address.AddressDetails[addr_counter].FullAddress);
	self.StreetAddress1 :=  trim(le.Matches.Address.AddressDetails[addr_counter].StreetAddress1);
	self.StreetAddress2 :=  trim(le.Matches.Address.AddressDetails[addr_counter].StreetAddress2);
	self.City := le.Matches.Address.AddressDetails[addr_counter].City;
	self.State :=  le.Matches.Address.AddressDetails[addr_counter].State;
	self.PostalCode := le.Matches.Address.AddressDetails[addr_counter].PostalCode;
	self.Country := le.Matches.Address.AddressDetails[addr_counter].Country;
	self.Notes := le.Matches.Address.AddressDetails[addr_counter].Notes;
	self := [];
END;	

normed_address := NORMALIZE(ReseqEntityMatches, left.countaddress, BreakOutAddrDetails(LEFT, COUNTER))(AddressCount > 0);

DDXG5Slim := dedup(sort(XG5Slim, blockid, -searchType),blockid);

OFAC_XG5.Layout.ResponseRec BreakOutDetails(ReseqEntityMatches le, DDXG5Slim ri) := TRANSFORM
	self.errorMessage := ri.errorMessage;
	self.BlockID :=  le.BlockID;
	self.EntitySeq := le.EntitySeq;
	self.ResponseFullName := le.OrigFullName;
	self.AKARec := join(normedEntityMatches(EntitySeq = le.EntitySeq  and blockid = le.blockid), normed_akas, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.AKABestMatches, self := right), left outer);
	self.AddrRec := join(ReseqEntityMatches(EntitySeq = le.EntitySeq  and blockid = le.blockid), normed_address, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.AddressMatches, self := right), left outer);
	self.FileRec := join(ReseqEntityMatches(EntitySeq = le.EntitySeq and blockid = le.blockid), normed_files, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.ResultMatchFile, self := right), left outer);
	self.EntityRec := join(ReseqEntityMatches(EntitySeq = le.EntitySeq and blockid = le.blockid), normed_Entity, left.blockid = right.blockid and left.EntitySeq = right.EntitySeq, 
												transform(OFAC_XG5.Layout.EntityMatch, self := right), left outer);										
	self := ri;
	self := le;
	self := [];
END;

good_records  := join(ReseqEntityMatches(~DOBConflict ), DDXG5Slim, left.blockid = right.seq ,BreakOutDetails(left, right)); 

OFAC_XG5.Layout.ResponseRec transformErrors(XG5Slim le) := TRANSFORM
	self.EntitySeq := le.EntityRecSeq;
	self := le;
	self := [];
END;

error_records := project(XG5Slim(errormessage <> '') ,transformErrors(LEFT));

AllRecords := good_records(EntityRec[1].EntityPartyKey <> OFAC_XG5.Constants.VendorRecFlag) + error_records;

RESPONSEOUT := ungroup(AllRecords);


	return RESPONSEOUT;
	
END;