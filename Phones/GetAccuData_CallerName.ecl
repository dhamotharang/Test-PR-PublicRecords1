IMPORT DidVille, doxie, Gateway, iesp, MDR, Phones, std;

EXPORT GetAccuData_CallerName(DATASET(Phones.Layouts.PhoneAcctno) inPhones,
  DATASET(Gateway.Layouts.Config) gateways, doxie.IDataAccess mod_access) := FUNCTION
  uniquePhones := DEDUP(SORT(inPhones,phone,acctno),phone);
  dsAccuDataCNAM := Gateway.AccudataCallerID.Records(uniquePhones, mod_access, gateways, TRUE);

  Phones.Layouts.AccuDataCNAM resolveCallerID(iesp.accudata_accuname.t_AccudataCnamResponseEx l) := TRANSFORM
    // availabilityIndicator and presentationIndicator flags removed from gateway response
    parsedName := Phones.Functions.ParseAccudataCallingName(l.response.AccudataReport.Reply.CallingName);
    is_accudata_valid := l.response.AccudataReport.ErrorMessage = '';

    SELF.fname := IF(is_accudata_valid, parsedName.fname, '');
    SELF.lname := IF(is_accudata_valid, parsedName.lname, '');
    SELF.listingName := STD.Str.ToUpperCase(l.response.AccudataReport.Reply.CallingName);
    SELF.phone := l.response.AccudataReport.Phone;
    SELF.did   := 0;
    SELF.acctno := l.response.AccudataReport.RequestID;
    errorMessage := IF(l.response._header.Message<>'',l.response._header.Message,l.response.AccudataReport.ErrorMessage);
    SELF.error_desc := errorMessage;
    SELF.source := IF(errorMessage='',MDR.sourceTools.src_Phones_Accudata_CNAM_CNM2,'')
  END;

  dsCallerIDs := PROJECT(dsAccuDataCNAM, resolveCallerID(LEFT));
  // need to send in additional info to get DID - future release
  dsPossibleIndividuals:=PROJECT(dsCallerIDs(fname<>'' AND lname<>''),TRANSFORM(DidVille.Layout_Did_OutBatch,SELF.seq:=(INTEGER)LEFT.acctno,SELF.phone10:=LEFT.phone,SELF:=LEFT,SELF:=[]));
  dsPhonewDIDs := Phones.Functions.GetDIDs(dsPossibleIndividuals,mod_access);
  CallerIDwDIDs := JOIN(dsCallerIDs, dsPhonewDIDs,
  LEFT.acctno = (STRING)RIGHT.seq,
  TRANSFORM(Phones.Layouts.AccuDataCNAM,
    SELF.did := LEFT.did,
    SELF := LEFT),
  LEFT OUTER,ALL);

  #IF(Phones.Constants.Debug.AccuDataCNAM)
    OUTPUT(dsCallerIDs,NAMED('dsCallerIDs'));
  #END
  RETURN dsCallerIDs;
END;
