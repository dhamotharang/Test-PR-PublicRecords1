// PRTE2_Liens_Ins.proc_build_base

IMPORT PRTE2_Liens_Ins, PRTE2_Liens, LiensV2, ut, PromoteSupers, NID, Address, BIPV2, STD;

// Initial data 
Party_In := dedup(Files.Party_IN_DS(tmsid<>''));
Main_In := dedup(Files.Main_IN_DS(tmsid<>''));

// Main_In needs modification to create the filing_status field.
mainLayout := PRTE2_Liens_Ins.Layouts.Boca_main_base;
layout_filing_status := LiensV2.layout_liens_main_module.layout_filing_status;

mainLayout trxMain(Main_In L) := TRANSFORM
		SELF.filing_status := ROW(L, layout_filing_status);
		SELF := L;
		SELF := [];
END;
mainFinalDS := PROJECT(Main_In, trxMain(LEFT));


// **********************************************************************************************************************
// From here down it's the Boca code with file name changes on the PromoteSupers calls and with some reference changes
// for inputs like mainFinalDS and Party_In - all the rest of the code is the same.
// **********************************************************************************************************************
mainLayout PopulateID(mainFinalDS L) := TRANSFORM
			SELF.process_date					:= (STRING8)Std.Date.Today();
			SELF.persistent_record_id := 	HASH64(trim(L.tmsid,left,right)+ ','+
																					trim(L.rmsid,left,right)+  ','+
																					trim(L.record_code,left,right)+  ','+
																					trim(L.date_vendor_removed ,left,right)+  ','+
																					trim(L.filing_jurisdiction,left,right)+  ','+
																					trim(L.filing_state ,left,right)+  ','+
																					trim(L.orig_filing_number ,left,right)+  ','+
																					trim(L.orig_filing_type ,left,right)+  ','+
																					trim(L.orig_filing_date ,left,right)+  ','+
																					trim(L.orig_filing_time ,left,right)+ ','+ 
																					trim(L.case_number   ,left,right)+  ','+
																					trim(L.filing_number ,left,right)+  ','+
																					trim(L.filing_type_desc ,left,right)+  ','+
																					trim(L.filing_date ,left,right)+  ','+
																					trim(L.filing_time ,left,right)+  ','+
																					trim(L.vendor_entry_date ,left,right)+  ','+
																					trim(L.judge ,left,right)+  ','+
																					trim(L.case_title ,left,right)+  ','+
																					trim(L.filing_book ,left,right)+  ','+
																					trim(L.filing_page ,left,right)+  ','+
																					trim(L.release_date ,left,right)+  ','+
																					trim(L.amount ,left,right)+  ','+
																					trim(L.eviction ,left,right)+  ','+
																					trim(L.satisifaction_type ,left,right)+  ','+
																					trim(L.judg_satisfied_date ,left,right)+  ','+
																					trim(L.judg_vacated_date ,left,right)+  ','+
																					trim(L.tax_code ,left,right)+  ','+
																					trim(L.irs_serial_number ,left,right)+  ','+
																					trim(L.effective_date ,left,right)+  ','+
																					trim(L.lapse_date ,left,right)+  ','+
																					trim(L.accident_date ,left,right)+  ','+
																					trim(L.sherrif_indc ,left,right)+  ','+
																					trim(L.expiration_date ,left,right)+  ','+
																					trim(L.agency ,left,right)+  ','+
																					trim(L.agency_city ,left,right)+  ','+
																					trim(L.agency_state ,left,right)+  ','+
																					trim(L.agency_county ,left,right)+  ','+
																					trim(L.legal_lot ,left,right)+  ','+
																					trim(L.legal_block ,left,right)+  ','+
																					trim(L.legal_borough ,left,right)+  ','+
																					trim(L.certificate_number ,left,right)+ ','+
																					trim(L.filing_status[1].filing_status ,left,right)+trim(L.filing_status[1].filing_status_desc,left,right));
			SELF := L;
			SELF := [];
END;
pCreateMainIDs := DEDUP(PROJECT(mainFinalDS, PopulateID(left)),ALL);

															
// **********************************************************************************************************************
//Add Persistent Record ID/Clean names/address was done in the spray file
// **********************************************************************************************************************
PRTE2_Liens_Ins.Layouts.Boca_party_base xfmNamesAddr(Party_In L) := TRANSFORM
			SELF.Bug_Num := l.xBug_num;
			SELF.cust_name := l.xSponsor;
			SELF.persistent_record_id := hash64(trim(l.tmsid,left,right)+','+
																		trim(l.rmsid,left,right)+','+
																		trim(l.orig_full_debtorname,left,right)+','+
																		trim(l.orig_name ,left,right)+','+
																		trim(l.orig_lname,left,right)+','+
																		trim(l.orig_fname,left,right)+','+
																		trim(l.orig_mname ,left,right)+','+
																		trim(l.orig_suffix ,left,right)+','+
																		trim(l.tax_id ,left,right)+','+
																		trim(l.ssn ,left,right)+','+
																		trim(l.cname ,left,right)+','+
																		trim(l.orig_address1 ,left,right)+','+
																		trim(l.orig_address2 ,left,right)+','+
																		trim(l.orig_city ,left,right)+','+
																		trim(l.orig_state ,left,right)+','+
																		trim(l.orig_zip5 ,left,right)+','+
																		trim(l.orig_zip4 ,left,right)+','+
																		trim(l.orig_county ,left,right)+','+
																		trim(l.orig_country ,left,right)+','+
																		trim(l.phone ,left,right)+ ','+
																		trim(l.name_type ,left,right) +','+ trim(l.bdid,left,right) +','+trim(l.did,left,right)+','+trim(l.zip,left,right)
																		+trim(l.fname,left,right)+','+trim(l.lname,left,right)+','+trim(l.mname,left,right)+','+trim(l.name_suffix,left,right) +','+ trim(l.zip4,left,right)); // orig name has multiple names 

				// address and name already cleaned during spray.
				SELF := L;
				SELF := [];
	END;

pCreatePartyIDs := DEDUP(PROJECT(Party_In, xfmNamesAddr(left)),ALL);

// -------------------------------------------------------------------------------------------------
PromoteSupers.Mac_SF_BuildProcess(pCreateMainIDs, Files.Main_Name_SF, build_main_base);
PromoteSupers.Mac_SF_BuildProcess(pCreatePartyIDs, Files.Party_Name_SF, build_party_base);

// -------------------------------------------------------------------------------------------------
EXPORT proc_build_base := SEQUENTIAL(build_main_base, build_party_base);