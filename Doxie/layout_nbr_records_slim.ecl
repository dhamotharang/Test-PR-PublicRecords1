nbrRec := doxie.layout_nbr_records;

export layout_nbr_records_slim := RECORD
	nbrRec.mode;										// record generated in historic or current mode ('H' or 'C') 
	nbrRec.seqTarget;								// target address sequence
	nbrRec.seqNPA;									// neighboring address sequence (for a given target)
	nbrRec.seqNbr;									// neighbor sequence (for a given neighboring address)
	nbrRec.did;											// id of "neighbor" -- a person who lives/lived at a neighboring address
	nbrRec.isCurrent;								// whether neighbor is still at the neighboring address
	nbrRec.isHistoric;							// whether neighbor has an overlap >0 with the subject
	unsigned2 address_seq_no;				// reference to corresponding entry in Comp_addresses
	unsigned2 base_address_seq_no;	// reference to our target's entry in Comp_addresses
  boolean HasCriminalConviction := false;
  boolean IsSexualOffender := false;
  unsigned2 fdn_did_ind := 0;  // Added for the FDN project.
END;
