#workunit ('name', 'UCC Moxie keys and output files cleanup ' + ucc.UCC_Build_Date);

cleanup(STRING file) := IF(FileServices.FileExists(file),
	FileServices.DeleteLogicalFile(file), OUTPUT('File "' + file + '" does not exist.'));
cleanup('~thor_data400::out::ucc_debtor_master_' + ucc.ucc_build_date);
cleanup('~thor_data400::out::ucc_filing_events_' + ucc.ucc_build_date);
cleanup('~thor_data400::out::ucc_filing_place_' + ucc.ucc_build_date);
cleanup('~thor_data400::out::ucc_filing_summary_' + ucc.ucc_build_date);
cleanup('~thor_data400::out::ucc_secured_master_' + ucc.ucc_build_date);
cleanup('~thor_data400::key::moxie.ucc_debtor_master.asisname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.bdid.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.cn.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.document_num.file_state.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.dph_lname.name_first.name_middle.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.lfmname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.orig_filing_num.file_state.filing_date.filing_type.document_num.orig_filing_date.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.pcn.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.ssn.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.st.asisname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.st.city.asisname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.st.city.cn.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.st.city.dph_lname.name_first.name_middle.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.st.city.lfmname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.st.city.pcn.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.st.city.prim_name.prim_range.predir.postdir.suffix.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.st.cn.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.st.dph_lname.name_first.name_middle.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.st.lfmname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.st.pcn.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.z5.prim_name.prim_range.lname.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.zip.asisname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.zip.cn.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.zip.dph_lname.name_first.name_middle.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.zip.lfmname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.zip.pcn.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.zip.prim_name.suffix.predir.postdir.prim_range.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.zip.street_name.suffix.predir.postdir.prim_range.company.key');
cleanup('~thor_data400::key::moxie.ucc_debtor_master.zip.street_name.suffix.predir.postdir.prim_range.lfmname.sec_range.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.asisname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.bdid.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.cn.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.dph_lname.name_first.name_middle.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.lfmname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.orig_filing_num.file_state.filing_date.filing_type.document_num.orig_filing_date.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.pcn.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.ssn.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.st.asisname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.st.city.asisname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.st.city.cn.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.st.city.dph_lname.name_first.name_middle.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.st.city.lfmname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.st.city.pcn.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.st.city.prim_name.prim_range.predir.postdir.suffix.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.st.cn.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.st.dph_lname.name_first.name_middle.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.st.lfmname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.st.pcn.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.z5.prim_name.prim_range.lname.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.zip.asisname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.zip.cn.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.zip.dph_lname.name_first.name_middle.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.zip.lfmname.event_flag.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.zip.pcn.key');
cleanup('~thor_data400::key::moxie.ucc_secured_master.zip.prim_name.suffix.predir.postdir.prim_range.key');
cleanup('~thor_data400::key::moxie.ucc_filing_events.orig_filing_num.file_state.filing_date.filing_type.document_num.orig_filing_date.key');
cleanup('~thor_data400::key::moxie.ucc_filing_events.document_num.file_state.key');
cleanup('~thor_data400::temp::ucc_debtor_secured');
cleanup('~thor_data400::temp::ucc_dropped_parties');
cleanup('~thor_data400::temp::ucc_filing_events');
cleanup('~thor_data400::temp::ucc_filing_events_temp');
cleanup('~thor_data400::temp::ucc_filing_summary');
cleanup('~thor_data400::temp::ucc_last_parties');
cleanup('~thor_data400::temp::ucc_parties_combined');
cleanup('~thor_data400::temp::ucc_parties_sequenced');
cleanup('~thor_data400::temp::ucc_updated_filing');
cleanup('~thor_data400::temp::ucc_updated_party');