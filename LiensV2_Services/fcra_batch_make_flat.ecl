IMPORT LiensV2_Services, FFD;

RS := FFD.Constants.RecordType.RS;
DR := FFD.Constants.RecordType.DR;
  
EXPORT LiensV2_Services.Batch_Layouts.fcra_batch_out_pre fcra_batch_make_flat
                    (LiensV2_Services.Batch_Layouts.int_layout_error_match_codes l , INTEGER c) :=
  TRANSFORM
  
    SELF.SequenceNumber := c;

    // To create a record with a lable (DataGroup) pointing to a statement location in the batch output
    FFD.Layouts.ConsumerStatementBatch xform (
      FFD.Layouts.StatementIdRec le,
      STRING2 rType,
      STRING section_id,
      STRING dgroup
    ) := TRANSFORM
      SELF.acctno := l.acctno;
      SELF.StatementID := le.statementId;
      SELF.SequenceNumber := c;
      SELF.UniqueId := 0;
      SELF.DateAdded := '';
      SELF.SectionID := section_id;
      SELF.RecordType := rType;
      SELF.DataGroup := dgroup;
    END;

    // going through all datasets which may have statementids and projecting them into consumer statement layout
    case_sids := PROJECT (l.statementids, xform (LEFT, RS, 'CASE', FFD.Constants.DataGroups.LIEN_MAIN));
    d11_sids := PROJECT (l.debtors[1].parsed_parties[1].statementids, xform (LEFT, RS, 'debtor_1_party_1', FFD.Constants.DataGroups.LIEN_PARTY));
    d12_sids := PROJECT (l.debtors[1].parsed_parties[2].statementids, xform (LEFT, RS, 'debtor_1_party_2', FFD.Constants.DataGroups.LIEN_PARTY));
    d21_sids := PROJECT (l.debtors[2].parsed_parties[1].statementids, xform (LEFT, RS, 'debtor_2_party_1', FFD.Constants.DataGroups.LIEN_PARTY));
    d22_sids := PROJECT (l.debtors[2].parsed_parties[2].statementids, xform (LEFT, RS, 'debtor_2_party_2', FFD.Constants.DataGroups.LIEN_PARTY));
    d31_sids := PROJECT (l.debtors[3].parsed_parties[1].statementids, xform (LEFT, RS, 'debtor_3_party_1', FFD.Constants.DataGroups.LIEN_PARTY));
    d32_sids := PROJECT (l.debtors[3].parsed_parties[2].statementids, xform (LEFT, RS, 'debtor_3_party_2', FFD.Constants.DataGroups.LIEN_PARTY));
    d41_sids := PROJECT (l.debtors[4].parsed_parties[1].statementids, xform (LEFT, RS, 'debtor_4_party_1', FFD.Constants.DataGroups.LIEN_PARTY));
    d42_sids := PROJECT (l.debtors[4].parsed_parties[2].statementids, xform (LEFT, RS, 'debtor_4_party_2', FFD.Constants.DataGroups.LIEN_PARTY));
    d51_sids := PROJECT (l.debtors[5].parsed_parties[1].statementids, xform (LEFT, RS, 'debtor_5_party_1', FFD.Constants.DataGroups.LIEN_PARTY));
    d52_sids := PROJECT (l.debtors[5].parsed_parties[2].statementids, xform (LEFT, RS, 'debtor_5_party_2', FFD.Constants.DataGroups.LIEN_PARTY));
    d61_sids := PROJECT (l.debtors[6].parsed_parties[1].statementids, xform (LEFT, RS, 'debtor_6_party_1', FFD.Constants.DataGroups.LIEN_PARTY));
    d62_sids := PROJECT (l.debtors[6].parsed_parties[2].statementids, xform (LEFT, RS, 'debtor_6_party_2', FFD.Constants.DataGroups.LIEN_PARTY));
    d71_sids := PROJECT (l.debtors[7].parsed_parties[1].statementids, xform (LEFT, RS, 'debtor_7_party_1', FFD.Constants.DataGroups.LIEN_PARTY));
    d72_sids := PROJECT (l.debtors[7].parsed_parties[2].statementids, xform (LEFT, RS, 'debtor_7_party_2', FFD.Constants.DataGroups.LIEN_PARTY));
    
    creditor_sids := PROJECT (l.creditors[1].parsed_parties[1].statementids, xform (LEFT, RS, 'creditor', FFD.Constants.DataGroups.LIEN_PARTY));
    attorney_sids := PROJECT (l.attorneys[1].parsed_parties[1].statementids, xform (LEFT, RS, 'attorney', FFD.Constants.DataGroups.LIEN_PARTY));
    
    filing_1_sids := PROJECT (l.filings[1].statementids, xform (LEFT, RS, 'filing_1', FFD.Constants.DataGroups.LIEN_MAIN));
    filing_2_sids := PROJECT (l.filings[2].statementids, xform (LEFT, RS, 'filing_2', FFD.Constants.DataGroups.LIEN_MAIN));
    filing_3_sids := PROJECT (l.filings[3].statementids, xform (LEFT, RS, 'filing_3', FFD.Constants.DataGroups.LIEN_MAIN));
    filing_4_sids := PROJECT (l.filings[4].statementids, xform (LEFT, RS, 'filing_4', FFD.Constants.DataGroups.LIEN_MAIN));
    
    // going through all datasets which may have disputes.For each dispute, we are
    // forcefully creating a consumerstatement row even without statementid
   
    case_dispute := IF (l.isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'CASE', FFD.Constants.DataGroups.LIEN_MAIN)));
    
    d11_dispute := IF (l.debtors[1].parsed_parties[1].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_1_party_1', FFD.Constants.DataGroups.LIEN_PARTY)));
    d12_dispute := IF (l.debtors[1].parsed_parties[2].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_1_party_2', FFD.Constants.DataGroups.LIEN_PARTY)));
    d21_dispute := IF (l.debtors[2].parsed_parties[1].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_2_party_1', FFD.Constants.DataGroups.LIEN_PARTY)));
    d22_dispute := IF (l.debtors[2].parsed_parties[2].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_2_party_2', FFD.Constants.DataGroups.LIEN_PARTY)));
    d31_dispute := IF (l.debtors[3].parsed_parties[1].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_3_party_1', FFD.Constants.DataGroups.LIEN_PARTY)));
    d32_dispute := IF (l.debtors[3].parsed_parties[2].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_3_party_2', FFD.Constants.DataGroups.LIEN_PARTY)));
    d41_dispute := IF (l.debtors[4].parsed_parties[1].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_4_party_1', FFD.Constants.DataGroups.LIEN_PARTY)));
    d42_dispute := IF (l.debtors[4].parsed_parties[2].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_4_party_2', FFD.Constants.DataGroups.LIEN_PARTY)));
    d51_dispute := IF (l.debtors[5].parsed_parties[1].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_5_party_1', FFD.Constants.DataGroups.LIEN_PARTY)));
    d52_dispute := IF (l.debtors[5].parsed_parties[2].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_5_party_2', FFD.Constants.DataGroups.LIEN_PARTY)));
    d61_dispute := IF (l.debtors[6].parsed_parties[1].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_6_party_1', FFD.Constants.DataGroups.LIEN_PARTY)));
    d62_dispute := IF (l.debtors[6].parsed_parties[2].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_6_party_2', FFD.Constants.DataGroups.LIEN_PARTY)));
    d71_dispute := IF (l.debtors[7].parsed_parties[1].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_7_party_1', FFD.Constants.DataGroups.LIEN_PARTY)));
    d72_dispute := IF (l.debtors[7].parsed_parties[2].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'debtor_7_party_2', FFD.Constants.DataGroups.LIEN_PARTY)));
    
    creditor_dispute := IF (l.creditors[1].parsed_parties[1].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'creditor', FFD.Constants.DataGroups.LIEN_PARTY)));
    attorney_dispute := IF (l.attorneys[1].parsed_parties[1].isDisputed, ROW (xform (FFD.Constants.BlankStatementid, DR, 'attorney', FFD.Constants.DataGroups.LIEN_PARTY)));
    
    filing_1_dispute := IF (l.filings[1].isDisputed,ROW (xform (FFD.Constants.BlankStatementid, DR, 'filing_1', FFD.Constants.DataGroups.LIEN_MAIN)));
    filing_2_dispute := IF (l.filings[2].isDisputed,ROW (xform (FFD.Constants.BlankStatementid, DR, 'filing_2', FFD.Constants.DataGroups.LIEN_MAIN)));
    filing_3_dispute := IF (l.filings[3].isDisputed,ROW (xform (FFD.Constants.BlankStatementid, DR, 'filing_3', FFD.Constants.DataGroups.LIEN_MAIN)));
    filing_4_dispute := IF (l.filings[4].isDisputed,ROW (xform (FFD.Constants.BlankStatementid, DR, 'filing_4', FFD.Constants.DataGroups.LIEN_MAIN)));
    
    statements := 
      case_sids +
        d11_sids + d12_sids +
        d21_sids + d22_sids +
        d31_sids + d32_sids +
        d41_sids + d42_sids +
        d51_sids + d52_sids +
        d61_sids + d62_sids +
        d71_sids + d72_sids +
        creditor_sids + attorney_sids +
        filing_1_sids + filing_2_sids +
        filing_3_sids + filing_4_sids +
      case_dispute +
        d11_dispute + d12_dispute +
        d21_dispute + d22_dispute +
        d31_dispute + d32_dispute +
        d41_dispute + d42_dispute +
        d51_dispute + d52_dispute +
        d61_dispute + d62_dispute +
        d71_dispute + d72_dispute +
        creditor_dispute + attorney_dispute +
        filing_1_dispute + filing_2_dispute +
        filing_3_dispute + filing_4_dispute;
    
    SELF.statements := statements(RecordType <> ''); // to throw the blanks
    // flatten all other fields
    SELF := ROW (LiensV2_Services.batch_make_flat (l));

    
END;
