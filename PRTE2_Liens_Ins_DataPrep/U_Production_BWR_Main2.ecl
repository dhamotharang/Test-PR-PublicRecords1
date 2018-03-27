// PRTE2_Liens_Ins_DataPrep.U_Production_BWR_Main2


// There is probably some attribute somewhere but I just grabbed this from the browser...
layout_filing_status := RECORD,maxlength(10000)
				string filing_status;
				string filing_status_desc;
END;

Prod_Main_Layout := RECORD,maxlength(32766)
				string50 tmsid;
				string50 rmsid;
				string8 process_date;
				string1 record_code;
				string8 date_vendor_removed;
				string50 filing_jurisdiction;
				string2 filing_state;
				string20 orig_filing_number;
				string50 orig_filing_type;
				string8 orig_filing_date;
				string10 orig_filing_time;
				string25 case_number;
				string20 filing_number;
				string125 filing_type_desc;
				string8 filing_date;
				string10 filing_time;
				string8 vendor_entry_date;
				string150 judge;
				string175 case_title;
				string10 filing_book;
				string10 filing_page;
				string8 release_date;
				string50 amount;
				string1 eviction;
				string75 satisifaction_type;
				string8 judg_satisfied_date;
				string8 judg_vacated_date;
				string40 tax_code;
				string200 irs_serial_number;
				string8 effective_date;
				string8 lapse_date;
				string8 accident_date;
				string1 sherrif_indc;
				string8 expiration_date;
				string150 agency;
				string20 agency_city;
				string2 agency_state;
				string40 agency_county;
				string50 legal_lot;
				string10 legal_block;
				string10 legal_borough;
				string20 certificate_number;
				DATASET(layout_filing_status) filing_status;
END;

Prod_Main_tmpLay := RECORD,maxlength(32766)
	INTEGER recCount;
	Prod_Main_Layout;
END;

BaseAnaly_in := RECORD
		STRING filing_number := '';
		STRING orig_filing_date := '';
		STRING amount := '';
		STRING release_date := '';
		STRING orig_filing_number := '';
		STRING filing_type_desc := '';
		STRING certificate_number := '';
		STRING irs_serial_number := '';
		STRING filing_book := '';
		STRING filing_page := '';
		STRING case_number := '';
		STRING agency := '';
		STRING agency_county := '';
		STRING agency_state := '';
END;

BaseAnaly_Joinable := RECORD
		unsigned JoinInt := 0;
		unsigned JoinIntMain := 0;
		unsigned JoinIntPrim := 0;
		BaseAnaly_in;
		string50 tmsid_New := ''; 
		string50 rmsid_New := ''; 
		string12 DIDNew  := '';
		string12 DIDBoca  := '';
		STRING FNum2 := '';
		STRING OFNum2 := '';
		STRING CaseNum := '';
END;

Prod_Party_Layout := RECORD
		string50 tmsid;
		string50 rmsid;
		string1830 orig_full_debtorname;
		string700 orig_name;
		string50 orig_lname;
		string50 orig_fname;
		string50 orig_mname;
		string10 orig_suffix;
		string9 tax_id;
		string9 ssn;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string3 name_score;
		string500 cname;
		string200 orig_address1;
		string200 orig_address2;
		string75 orig_city;
		string50 orig_state;
		string25 orig_zip5;
		string20 orig_zip4;
		string5 orig_county;
		string5 orig_country;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dbpc;
		string1 chk_digit;
		string2 rec_type;
		string5 county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string20 phone;
		string2 name_type;
		string12 did;
		string12 bdid;
		string8 date_first_seen;
		string8 date_last_seen;
		string8 date_vendor_first_reported;
		string8 date_vendor_last_reported;
		string9 app_ssn;
		string9 app_tax_id;
END;

// ------------------------------------------------------------------------------------------------------
ReadOnly_Prod_SF_PartyName	:= '~thor_data400::base::liensv2::party::all_sources';
ReadOnly_Prod_SF_Party_DS	:= DATASET(ReadOnly_Prod_SF_PartyName,Prod_Party_Layout,THOR);
// ------------------------------------------------------------------------------------------------------
							
Tmp_Main_Prod_File := '~prct::TMP::ct_Gather::LiensV2_Alpha::Prod_Main';
Tmp_Party_Prod_File := '~prct::TMP::ct_Gather::LiensV2_Alpha::Prod_Party';
OurRecs1 := DATASET(Tmp_Main_Prod_File,Prod_Main_Layout,THOR);
MinRecs2 := DEDUP(SORT(OurRecs1,tmsid),tmsid);
Prod_Main_tmpLay trxM1(MinRecs2 L, INTEGER CNT) := TRANSFORM
		SELF.recCount := CNT;
		SELF := L;
END;
MinRecs3	:= PROJECT(MinRecs2,trxM1(LEFT, COUNTER));
half := MAX(MinRecs2,recCount)/2;
MSet1 := SET(MinRecs2(recCount<=half),tmsid);
MSet2 := SET(MinRecs2(recCount>half),tmsid);
OUTPUT(MAX(MinRecs2,recCount));
OurParty1 := ReadOnly_Prod_SF_Party_DS(tmsid in MSet1);
OurParty2 := ReadOnly_Prod_SF_Party_DS(tmsid in MSet2);
OurParty := OurParty1+OurParty2;

OUTPUT(OurParty,,Tmp_Party_Prod_File,overwrite);
