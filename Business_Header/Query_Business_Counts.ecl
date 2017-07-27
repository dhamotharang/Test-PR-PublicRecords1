score_threshold := 6;  // combined_score for contact must be greater than this number for people at work
bc := Business_Header.File_Business_Contacts_Stats(NOT Business_Header.CheckUCC(source, company_name, fname, mname, lname, name_suffix));
bc_owners := Business_Header.BC_Owner;
bh_best := Business_Header.File_Business_Header_Best;

//Business Contacts not from Header or Equifax
output(count(bc(From_HDR = 'N')), named('Total_Contacts_from_Business'));
output(count(bc(From_HDR = 'N', did <> 0)), named('Total_Contacts_from_Business_With_DID'));
output(count(dedup(bc(From_HDR = 'N', did <> 0), did, all)), named('Total_Contacts_from_Business_Unique_DID'));
output(count(bc_owners(company_title_rank=1)), named('Total_Business_Owners'));
output(count(bc_owners(company_title_rank=1, did <> 0)), named('Total_Business_Owners_With_DID'));
output(count(dedup(bc_owners(company_title_rank=1, did <> 0),did,all)), named('Total_Business_Owners_Unique_DID'));

//Business Contacts from Header
output(count(bc(From_HDR = 'Y')), named('Total_Contacts_from_Header'));
output(count(bc(From_HDR = 'Y', did <> 0)), named('Total_Contacts_from_Header_With_DID'));
output(count(dedup(bc(From_HDR = 'Y', did <> 0), did, all)), named('Total_Contacts_from_Header_Unique_DID'));

//Business Contacts from Equifax
output(count(bc(From_HDR = 'E')), named('Total_Contacts_from_Equifax'));
output(count(bc(From_HDR = 'E', did <> 0)), named('Total_Contacts_from_Equifax_With_DID'));
output(count(dedup(bc(From_HDR = 'E', did <> 0), did, all)), named('Total_Contacts_from_Equifax_Unique_DID'));

//Business Contacts Combined (People at Work)
output(count(bc(combined_score > score_threshold)), named('Total_PAW'));
output(count(bc(combined_score > score_threshold, did <> 0)), named('Total_PAW_With_DID'));
output(count(dedup(bc(combined_score > score_threshold,  did <> 0), did, all)), named('Total_PAW_Unique_DID'));

//Unique Business Locations
output(count(bh_best(true)), named('Total_Unique_BDID'));
output(count(bh_best(prim_name <> '', zip <> 0)), named('Total_Unique_BDID_Nonblank_ADDR'));
output(count(bh_best(prim_name <> '', zip <> 0,
           prim_name[1..7] <> 'PO BOX')), named('Total_Unique_BDID_Not_POBOX_ADDR'));
output(count(bh_best(prim_name <> '', zip <> 0,
           prim_name[1..7] <> 'PO BOX', prim_name[1..3] not in ['RR ', 'HC '])), named('Total_Unique_BDID_Not_POBOX_RR_ADDR'));