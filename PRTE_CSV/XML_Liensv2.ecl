export XML_Liensv2 := 

module

	shared	lSubDirName					:=	'';
	shared	lXMLVersion					:=	'20100713';
	shared	lXMLFileNamePrefix	:=	PRTE_CSV.Constants.XMLFilesBaseName + lSubDirName;
	
export liensv2__layout_filing_status :=
record,maxLength(10000)
	string filing_status;
	string filing_status_desc;
end;

export rthor_data400__key__liensv2__main__tmsid_rmsid :=
record,maxLength(32766)
	string50 tmsid;
	string50 rmsid;
	string process_date;
	string record_code;
	string date_vendor_removed;
	string filing_jurisdiction;
	string filing_state;
	string20 orig_filing_number;
	string orig_filing_type;
	string orig_filing_date;
	string orig_filing_time;
	string case_number;
	string20 filing_number;
	string filing_type_desc;
	string filing_date;
	string filing_time;
	string vendor_entry_date;
	string judge;
	string case_title;
	string filing_book;
	string filing_page;
	string release_date;
	string amount;
	string eviction;
	string satisifaction_type;
	string judg_satisfied_date;
	string judg_vacated_date;
	string tax_code;
	string irs_serial_number;
	string effective_date;
	string lapse_date;
	string accident_date;
	string sherrif_indc;
	string expiration_date;
	string agency;
	string agency_city;
	string agency_state;
	string agency_county;
	string legal_lot;
	string legal_block;
	string legal_borough;
	string certificate_number;
	DATASET(liensv2__layout_filing_status) filing_status;
	unsigned8 __internal_fpos__;
end;

export dthor_data400__key__liensv2__main__tmsid_rmsid:= dataset(lXMLFileNamePrefix + 'thor_data400__key__liensv2__' + lXMLVersion + '__main__tmsid.rmsid.xml', rthor_data400__key__liensv2__main__tmsid_rmsid, xml('Dataset/Row'));
end;