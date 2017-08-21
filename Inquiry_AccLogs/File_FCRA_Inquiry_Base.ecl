export File_FCRA_Inquiry_Base := inquiry_acclogs.File_FCRA_Inquiry_BaseSourced.Build_File
											//(search_info.transaction_id not in set(Inquiry_AccLogs.File_TransactionID_Removals, transaction_id)) 
											: persist('~persist::inquiry::fcra_base');
