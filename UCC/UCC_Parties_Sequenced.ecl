IMPORT ut;

// Add Unique Record ID to UCC Party File, Initialize Current Flag
UCC.Layout_UCC_Initial_Party_Master InitInitialPartyMaster(UCC.Layout_UCC_Expanded_Party L) := TRANSFORM
SELF.RecordID := 0;
SELF.BDID := 0;
SELF.current_flag := 'N';
SELF := L;
END;

UCC_Initial_Party_Master_Init := PROJECT(UCC.File_UCC_Expanded_Party, InitInitialPartyMaster(LEFT));

// Set Unique Record IDs For Source File
UT.MAC_Sequence_Records(UCC_Initial_Party_Master_Init,RecordID,UCC_Initial_Party_Master_Seq)

//Filter out header record if any
UCC_Initial_Party_Master :=  UCC_Initial_Party_Master_Seq(NOT(RecordID=1 AND Stringlib.StringFind(orig_filing_num, 'INDAR',1)<>0));

// Join Initial Parties and Filings to Append Collateral Codes
UCC_Parties_Dist := DISTRIBUTE(UCC_Initial_Party_Master(UCC.Check_Valid_State_Filing_Date(file_state, fk_filing_date)),
                               HASH(file_state, orig_filing_num));

EXPORT UCC_Parties_Sequenced := UCC_Parties_Dist : PERSIST('TEMP::UCC_Parties_Sequenced');