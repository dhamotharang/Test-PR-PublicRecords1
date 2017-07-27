import BatchServices, header, doxie, Suppress;

rec_in := BatchServices.Layouts.SsnIssuance.batch_in;
rec_out := BatchServices.Layouts.SsnIssuance.batch_out;

// Evaluates SSN as a number, without any context;
// generally, this should be consistent with ut/GetSSNValidation and header/constants
integer GetValidationCode (string9 _ssn) := function
  pocketbook_ssn := ['022281852','042103580','062360749','062360794','078051120','095073645',
    '128036045','135016629','141186941','165167999','165187999','165207999','165247999','189092294',
    '212097694','212099999','219099998','219099999','306302348','308125070','468288779','549241889'];

  boolean is_numeric := REGEXFIND('^[0-9]{9}$', _ssn);

  integer code := 
    if (_ssn[1..3] = '666', header.constants.ssn_indicators.is_666, 0) + // 4
    if (_ssn[1..3] = '000', header.constants.ssn_indicators.is_invalid_area, 0) + // 64
    if (_ssn[4..5] = '00', header.constants.ssn_indicators.is_invalid_group, 0) + // 128
    if (_ssn[6..9] = '0000', header.constants.ssn_indicators.is_invalid_serial, 0) + // 512;
    if (_ssn[1] = '9', 8192, 0) + // 2^13
    if (~is_numeric, 16384, 0) + // 2^14
    if (_ssn IN pocketbook_ssn, 32768, 0); //2^15

  // others defined in header:
    // header.constants.ssn_indicators.is_partial;            //   1
    // header.constants.ssn_indicators.is_itin;               //   2
    // header.constants.ssn_indicators.is_eae;                //   8
    // header.constants.ssn_indicators.is_advertising;        //  16
    // header.constants.ssn_indicators.is_woolworth;          //  32
    // header.constants.ssn_indicators.area_group_not_issued; // 256

  return code;
end;

export SSN_Issuance_BatchService_Records (dataset (rec_in) indata) := function

/*
// if I had DID in the input, I'd also could check if SSN was seen before randomization,
// similar to Doxie/mac_AddHRISSN
*/

  rec_out getIssuance (rec_in L, doxie.Key_SSN_Map R) := transform
    Self.acctno							:= L.acctno;
    Self.ssn								:= L.ssn;
		self.validity_code			:= if(Suppress.dateCorrect.do(L.ssn).needed, 0, GetValidationCode(L.ssn));
		self.issued_location		:= Suppress.dateCorrect.state(L.ssn, R.state);
		self.issued_start_date	:= Suppress.dateCorrect.sdate_s8(L.ssn, R.start_date);
		self.issued_end_date		:= Suppress.dateCorrect.edate_s8(L.ssn, R.end_date);
  end;
	
  ssn_issuance := join (indata, doxie.Key_SSN_Map,
                        keyed (Left.ssn[1..5] = Right.ssn5) AND
                        keyed (Left.ssn[6..9] between Right.start_serial AND Right.end_serial),
                        getIssuance (Left, Right),
												LEFT OUTER,
                        KEEP (1), limit (0)); //1 : 1 relation

  // batch version can't be used directly because of the difference in the field name - acctno vs. seq	
	Suppress.MAC_Suppress(
		ssn_issuance, ssn_compliance,
		Suppress.Constants.ApplicationTypes.DEFAULT,
		Suppress.Constants.LinkTypes.SSN, ssn);

  // join back to retain the same input
  res := join (indata, ssn_compliance,
               Left.acctno = Right.acctno,
               transform (rec_out, Self.acctno := Left.acctno, Self.ssn := Left.ssn, Self := Right),
               LEFT OUTER, KEEP (1), LIMIT (0)); 

  return res;
end;
