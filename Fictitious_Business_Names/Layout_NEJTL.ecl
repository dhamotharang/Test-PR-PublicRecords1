Layout_In_Docinfo := record
 string lndocmetaLnlni   {xpath('@lnlni')};
 string lndocmetalnminrev {xpath('@lnminrev')}; 
 string lndocmetasmi {xpath('@lnsmi')}; 
 string lndocmetalndocnum {xpath('@lndocnum')}; 
 string lndocmetalnfilenum {xpath('@lnfilenum')};
end;

export Layout_NEJTL :=record, maxlength(1870470) 

 string doc                    {xpath('doc')};
  Dataset(Layout_In_Docinfo) Docinfo {xpath('lndocmetadocinfo')};
 //string doc                    {xpath('lndocmetadocinfo')};
 string AMOUNT                 {xpath('lnvAMOUNT')};
 string ATTORNEY               {xpath('lnvATTORNEY')};
 string CITE_ID                {xpath('lnvCITE-ID')};
 string CREDITOR               {xpath('lnvCREDITOR')};
 string CREDITOR_ADDRESS       {xpath('lnvCREDITOR-ADDRESS')};
 string DATE_LAST_TRANS        {xpath('lnvDATE-LAST-TRANS')};
 string DEBTOR                 {xpath('lnvDEBTOR')};
 string DEBTOR_ADDRESS              {xpath('lnvDEBTOR-ADDRESS')};
 string DOCKET_NUMBER               {xpath('lnvDOCKET-NUMBER')};
 string DUMMY_SEG                   {xpath('lnvDUMMY-SEG')};
 string FILE_CODE                   {xpath('lnvFILE-CODE')};
 string FILE_ID                     {xpath('lnvFILE-ID')};
 string FILING_DATE                 {xpath('lnvFILING-DATE')};
 string LEGEND                      {xpath('lnvLEGEND')};
 string LXDSEG                      {xpath('lnvLXDSEG')};
 string PUBLICATION_3               {xpath('lnvPUBLICATION-3')};
 string STATUS               {xpath('lnvSTATUS')};
 string STATUS_DATE               {xpath('lnvSTATUS-DATE')};
 string lnvTYPE               {xpath('lnvTYPE')};
 string VDI               {xpath('lnvVDI')};
  string REPORT_NO               {xpath('lnv_REPORT-NO')};
 
end;


