#warning('Deprecated. Logic moved to doxie.DOC_Search_People_Records');
import doxie,doxie_files,doxie_build,codes,autokey,doxie_raw;

doxie.MAC_Header_Field_Declare()
doxie.MAC_Selection_Declare()

string25 doc_number := '' : stored('DOCNumber');
string2  doc_state := '' : stored('DOCState');
string60 ofk_in     := '' : stored('OffenderKey');
string14 uid_value := '' : stored('UniqueId');

pre_dids := 	MAP(	uid_value<>''		=> DATASET([{(unsigned)uid_value}],layout_references),
				Law_Enforcement	=> doxie.Get_SRNA_DIDs, 
				did_value<>''		=> DATASET([{(unsigned)did_value}],layout_references),
				IF(~noDeepDive, doxie.Get_Dids()));
				
dids := pre_dids(Include_CriminalRecords_val);

j := doxie_raw.DOC_People_Raw(dids, did_value, doc_number, doc_state, ofk_in, uid_value,
				maxResults_val, dateval, dppa_purpose, glb_purpose,ssn_mask_value, isCRS, application_type_value);

export DOC_Search_People_Local := j;