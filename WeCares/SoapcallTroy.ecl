EXPORT SoapcallTroy() := FUNCTION
  IMPORT doxie;
  #OPTION('soapTraceLevel', '8');

  STRING remoteIP     := 'http://certstagingvip.hpcc.risk.regn.net:9876';
  STRING ServiceName  := 'doxie.Troy_Service';

  string5 Zip1 := '' : stored('Zip1');
  string5 Zip2 := '' : stored('Zip2');
  string5 Zip3 := '' : stored('Zip3');
  unsigned4 z1l := 0 : stored('Zip1LowYYYYMM');
  unsigned4 z1h := 201412 : stored('Zip1HighYYYYMM');
  unsigned4 z2l := 0 : stored('Zip2LowYYYYMM');
  unsigned4 z2h := 201412 : stored('Zip2HighYYYYMM');
  unsigned4 z3l := 0 : stored('Zip3LowYYYYMM');
  unsigned4 z3h := 201412 : stored('Zip3HighYYYYMM');
  unsigned1 AgeHigh := 100 : stored('AgeHigh');
  unsigned1 AgeLow := 0 : stored('AgeLow');
  unsigned1 Radius := 10: stored('Radius');
  STRING1 pGender := 'M': STORED('Gender');
  null := dataset([{true}], {boolean a});

  _dIn := table(null, {
    string5 Zip1 := Zip1,
    string5 Zip2 := Zip2,
    string5 Zip3 := Zip3,
    unsigned4 Zip1LowYYYYMM := z1l,
    unsigned4 Zip1HighYYYYMM := z1h,
    unsigned4 Zip2LowYYYYMM := z2l,
    unsigned4 Zip2HighYYYYMM := z2h,
    unsigned4 Zip3LowYYYYMM := z3l,
    unsigned4 Zip3HighYYYYMM := z3h,
    unsigned1 AgeHigh := AgeHigh,
    unsigned1 AgeLow := AgeLow,
    unsigned1 Radius := Radius,
    string1 Gender := pGender
    });

  rIn := record
    recordof(_dIn);
  end;

  dIn := project(_dIn , 
    transform(rIn, 
      self := left));

  // Return failure messages
  rSoapcallOut := record
    unsigned4 score;
    unsigned1 crim_records;
    unsigned6    did;
    unsigned4    first_seen;
    unsigned4    last_seen;
    string10    phone;
    string9     ssn;
    integer4     dob;
    string120  name;
    string120  addr1;
    string120  addr2;
    unsigned8 rawaid;
    INTEGER soapcallerrorcode;
    STRING soapcallerrordescription;
  end;

  rSoapcallOut SetError (dIn inn) := TRANSFORM
    SELF.soapcallerrorcode  := FAILCODE,
    SELF.soapcallerrordescription := FAILMESSAGE,
    self := [];
  END;

  dSoapcallOut := SOAPCALL (dIn, 
    remoteIP,
    ServiceName, 
    {dIn},
    dataset (rSoapcallOut), onFail (SetError (Left)))(did <> 0);
  RETURN dSoapcallOut;
END;