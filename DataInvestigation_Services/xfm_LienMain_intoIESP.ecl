IMPORT iesp, LiensV2;

EXPORT iesp.smallbusinessdatainvestigation.t_LienAndJudgementMain xfm_LienMain_intoIESP ( RECORDOF(LiensV2.Key_liens_main_ID) ds_in) := 
  TRANSFORM
    SELF.ProcessDate        := ds_in.Process_Date;
    SELF.RecordCode         := ds_in.Record_Code;
    SELF.DateVendorRemoved  := ds_in.Date_Vendor_Removed; 
    SELF.FilingJurisdiction := ds_in.Filing_Jurisdiction; 
    SELF.FilingState        := ds_in.Filing_State; 
    SELF.OrigFilingNumber   := ds_in.Orig_Filing_Number;
    SELF.OrigFilingType     := ds_in.Orig_Filing_Type;
    SELF.OrigFilingDate     := ds_in.Orig_Filing_Date;
    SELF.OrigFilingTime     := ds_in.Orig_Filing_Time;
    SELF.CaseNumber         := ds_in.Case_Number;
    SELF.FilingNumber       := ds_in.Filing_Number;
    SELF.FilingTypeDesc     := ds_in.Filing_Type_Desc;
    SELF.FilingDate         := ds_in.Filing_Date;
    SELF.FilingTime         := ds_in.Filing_Time;
    SELF.VendorEntryDate    := ds_in.Vendor_Entry_Date;
    SELF.CaseTitle          := ds_in.Case_Title;
    SELF.FilingBook         := ds_in.Filing_Book;
    SELF.FilingPage         := ds_in.Filing_Page;
    SELF.ReleaseDate        := ds_in.Release_Date;
    SELF.SatisifactionType  := ds_in.Satisifaction_Type;
    SELF.JudgSatisfiedDate  := ds_in.Judg_Satisfied_Date;
    SELF.JudgVacatedDate    := ds_in.Judg_Vacated_Date;
    SELF.TaxCode            := ds_in.Tax_Code;
    SELF.IRSSerialNumber    := ds_in.IRS_Serial_Number;
    SELF.EffectiveDate      := ds_in.Effective_Date;
    SELF.LapseDate          := ds_in.Lapse_Date;
    SELF.AccidentDate       := ds_in.Accident_Date;
    SELF.SherrifIndc        := ds_in.Sherrif_Indc;
    SELF.ExpirationDate     := ds_in.Expiration_Date;
    SELF.AgencyCity         := ds_in.Agency_City;
    SELF.AgencyState        := ds_in.Agency_State;
    SELF.AgencyCounty       := ds_in.Agency_County;
    SELF.LegalLot           := ds_in.Legal_Lot;
    SELF.LegalBlock         := ds_in.Legal_Block;
    SELF.LegalBorough       := ds_in.Legal_Borough;
    SELF.CertificateNumber  := ds_in.Certificate_Number;
    SELF.PersistentRecordId := ds_in.Persistent_Record_Id;
    SELF.FilingStatuses     := PROJECT( ds_in.Filing_Status,
                                 TRANSFORM( iesp.smallbusinessdatainvestigation.t_FilingStatus,
                                            SELF.FilingStatus     := LEFT.Filing_Status,
                                            SELF.FilingStatusDesc := LEFT.Filing_Status_Desc));
    SELF                    := ds_in;
  END;