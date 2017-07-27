import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export fnMapCommon_fcra_BankoBatch := module

export ready_File := function

prev_base := inquiry_acclogs.File_FCRA_BankoBatch_Logs_Common;

prev_base_trans := project(prev_base, transform({inquiry_acclogs.Layout.Common, string source := 'BANKO'}, self := left));
														
inquiry_acclogs.file_MBSApp_Base().FCRA_Append(prev_base_trans,prev_base_mbs);

prev_base_ready := project(prev_base_mbs, transform(inquiry_acclogs.Layout.Common, self := left));

ReAppendDay := stringlib.stringtolowercase(ut.Weekday((unsigned8)ut.getdate)) in ['friday'];

newFile := dedup(sort(distribute(prev_base_ready, hash(person_q.full_name, search_info.datetime, search_info.sequence_number, mbs.company_id, mbs.global_company_id, search_info.transaction_id, search_info.sequence_number)), record, local), record, local)(mbs.company_id + mbs.global_company_id <> '');

return newFile;
end;

end;