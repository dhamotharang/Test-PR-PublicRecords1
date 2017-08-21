Layout_Header := RECORD
	integer Status {xpath('Status')};
	string Message {xpath('Message')};
	string QueryId {xpath('QueryId')};
	string TransactionId {xpath('TransactionId')};
	string100	ErrorMessage;
	unsigned	ErrorCode;
END;

Layout_ID3CheckResponseResultsDef1B := RECORD
	string UID {xpath('UID')};
	string UIDDescription {xpath('UIDDescription')};
	string ResultCode {xpath('ResultCode')};
	string ResultDescription {xpath('ResultDescription')};
END;

Layout_ID3CheckResponseResultsDef1Bs := RECORD
	dataset(Layout_ID3CheckResponseResultsDef1B) ID3CheckResponseResultsDef1Bs {xpath('ID3CheckResponseResultsDef1Bs/ID3CheckResponseResultsDef1B/')};
END;

Layout_Id3Check1BResult := RECORD
	string Status {xpath('Status')};
	string AuthenticationID {xpath('AuthenticationID')};
	string Timestamp {xpath('Timestamp')};
	string BandText {xpath('BandText')};
	string CustomerRef {xpath('CustomerRef')};
	string Remarks {xpath('Remarks')};
	string NScore {xpath('Nscore')};
	Layout_ID3CheckResponseResultsDef1Bs ID3CheckResponseResults {xpath('ID3CheckResponseResults/')};
END;

Layout_Response := RECORD
	Layout_Header Header {xpath('Header/')};
	Layout_Id3Check1BResult Id3Check1BResult {xpath('Id3Check1BResult/')};
END;

export Layout_GBID3_Out := RECORD
	Layout_Response Response {xpath('response/')};
END;