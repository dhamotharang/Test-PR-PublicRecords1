import corp2_mapping;

export mac_Mark_TX_Standing(

	 dataset(Layout_Tx_Ftact																	)	pTxFtact	= Corp2.files().input.txbus.root
	,dataset(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded	)	pCorpBase = corp2.files().Base_xtnd.corp.qa

) :=
function 

Txbus_File := pTxFtact;

corp_in    := pCorpBase;

Non_TX_corp_recs := corp_in(corp_state_origin <> 'TX');

TX_corp_recs     := distribute(corp_in(corp_state_origin = 'TX'),hash(corp_sos_charter_nbr));

//Corp layout.
Layout_corp := Corp2.Layout_Corporate_Direct_Corp_Base_Expanded;

//Slim txbus layout.
Layout_Txbus_Out := record
   string32 corp_sos_charter_nbr;
   string32 corp_state_tax_id;
   string1  IGS_IN_RIGHT_TO_TRANSACT_CODE;
end;

layout_txbus_out trfTxbus(txbus_file l) := transform
   self.corp_sos_charter_nbr := l.IGS_IN_CHARTER_NUMBER;
   self.corp_state_tax_id    := l.IGS_IN_TAXNO;
   self                      := l;
end;

txbus_file_slim 		:= project(txbus_file, trfTxbus(left));

// A right to transact code of '' actually means something
txbus_char_nbr_srt  := dedup(sort(distribute(txbus_file_slim(	trim(corp_sos_charter_nbr, left,right) <> ''),hash(corp_sos_charter_nbr)),
																	corp_sos_charter_nbr,local), corp_sos_charter_nbr,local);

txbus_tax_id_srt    := dedup(sort(distribute(txbus_file_slim(	trim(corp_state_tax_id, left,right) <> ''),hash(corp_state_tax_id)), 
																	corp_state_tax_id,local),  corp_state_tax_id,local);

// Function that returns the description for a given right to transact code.
string getStandingDesc(string1 instr) := function
  string1 standing_code := stringlib.StringToUpperCase(TRIM(instr, LEFT, RIGHT));
  desc := map(standing_code = 'A' => 'RIGHT TO TRANSACT BUSINESS: ACTIVE',
              standing_code = 'D' => 'RIGHT TO TRANSACT BUSINESS: ACTIVE - ELIGIBLE FOR TERMINATION/WITHDRAWL',
              standing_code = 'I' => 'RIGHT TO TRANSACT BUSINESS: FRANCHISE TAX INVOLUNTARILY ENDED',
              standing_code = 'N' => 'RIGHT TO TRANSACT BUSINESS: FORFEITED',
              standing_code = 'U' => 'RIGHT TO TRANSACT BUSINESS: FRANCHISE TAX NOT ESTABLISHED',
              standing_code = ''  => 'RIGHT TO TRANSACT BUSINESS: FRANCHISE TAX ENDED',
              ''
             );
  return(trim(desc,left,right));
end;

layout_corp_temp := record
   Layout_corp;
   string1 txbus_standing := '';
end;

//Phase_1 Transform - Getting right to transact information based on the charter number match.
layout_corp_temp  trfJoinCharterNbr(TX_corp_recs l, txbus_char_nbr_srt r) := transform
  // Since nulls mean something now and a left outer join causes nulls, we need to make sure we
	// only touch those comments that came from the input dataset.
  self.corp_status_comment := IF(r.corp_sos_charter_nbr != '',
	                               getStandingDesc(trim(r.IGS_IN_RIGHT_TO_TRANSACT_CODE)),
																 l.corp_status_comment);
  self.txbus_standing      := if(trim(l.corp_sos_charter_nbr,left,right) = trim(r.corp_sos_charter_nbr,left,right) and 
                                 getStandingDesc(r.IGS_IN_RIGHT_TO_TRANSACT_CODE) <> '', 'Y','');								 
  self := l;
end;

TX_Corp_standing_cnbr_match_recs := Join(TX_corp_recs, txbus_char_nbr_srt, 
                                         trim(left.corp_sos_charter_nbr,left,right) = trim(right.corp_sos_charter_nbr,left,right),
                                         trfJoinCharterNbr(left, right), left outer,local);

TX_Corp_standing_nonblk_taxid_recs := distribute(TX_Corp_standing_cnbr_match_recs(trim(corp_state_tax_id,left,right) <> ''),hash(corp_state_tax_id));

TX_Corp_standing_blk_taxid_recs    := TX_Corp_standing_cnbr_match_recs(trim(corp_state_tax_id,left,right) = '');

//Phase_2 Transform - Getting right to transact information based on the tax_id match.
Layout_corp  trfJoinTaxId(TX_Corp_standing_nonblk_taxid_recs l, txbus_tax_id_srt r) := transform
  // Since nulls mean something now and a left outer join causes nulls, we need to make sure we
	// only touch those comments that came from the input dataset.
  self.corp_status_comment := if(l.txbus_standing = 'Y', l.corp_status_comment,
	                               IF(r.corp_state_tax_id != '',
																    getStandingDesc(trim(r.IGS_IN_RIGHT_TO_TRANSACT_CODE)),
																		l.corp_status_comment));  
  self := l;
end;

TX_Corp_standing_taxid_match_recs := Join(TX_Corp_standing_nonblk_taxid_recs, txbus_tax_id_srt, 
                                          trim(left.corp_state_tax_id,left,right) = trim(right.corp_state_tax_id,left,right),
                                          trfJoinTaxId(left, right), left outer,local);


Layout_corp  trfCorpbase(TX_Corp_standing_blk_taxid_recs l) := transform
  self := l;
end;

// Combining all the tx_corp outputs from the phase1 (charter number) and phase2 (tax_id) marked records 
// and the rest of the non tx corp records.
corp_out := Non_TX_corp_recs + TX_Corp_standing_taxid_match_recs + project(TX_Corp_standing_blk_taxid_recs, trfCorpbase(left));

return corp_out;

end;