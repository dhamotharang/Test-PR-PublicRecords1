import iesp;

export consumer_collection_report := module 

  export t_CollectionReportBy := record
    string30 LexID {xpath('LexID')};
    iesp.share.t_Date RequestDate {xpath('RequestDate')};
  end;

  export t_CollectionReportOptions := record  // iesp.share.t_BaseOption has a MakeGatewayCall option that is confusing and makes no sense here.
    boolean Blind {xpath('Blind')};//hidden[inhouse]
    string Encrypt {xpath('Encrypt')};//hidden[inhouse]
  end;

  export t_CollectionReportRequest := record (iesp.share.t_BaseRequest)
    t_CollectionReportOptions Options {xpath('Options')};
    t_CollectionReportBy ReportBy {xpath('ReportBy')};
  end;

  export t_CollectionRecord := record
    string PrivacySourceID {xpath('PrivacySourceId')};
    string GlobalRecordID {xpath('GlobalRecordId')};
    utf8 Content {xpath('Content')};
  end;

  export t_Collection := record
    string _Name {xpath('Name')};
    string LayoutName {xpath('LayoutName')};
    string LayoutVersion {xpath('LayoutVersion')};
    dataset(t_CollectionRecord) Records {xpath('Records/Record')};
  end;

  export t_CollectionReportResult := record 
    t_CollectionReportBy InputEcho {xpath('InputEcho')};
    string LNPID {xpath('LNPID')};
    string RoxieCluster {xpath('RoxieCluster')};
    dataset(t_Collection) Collections {xpath('Collections/Collection')};
  end;

  export t_CollectionReportResponse := record
    iesp.share.t_ResponseHeader _Header {xpath('Header')};
    t_CollectionReportResult Result {xpath('Result')};
  end;
  
  export t_CollectionReportResponseEx := record
    t_CollectionReportResponse response {xpath('response')};
  end;
		
end;