//For the following events, I would like the number of new events by type by month by state all the way back to 2010
//This data should be created using only data on the FCRA Roxies" */
/*  There's a slide for BIP IDs; but Business data is Non-FCRA.
	Usually we count ProxIDs and SeleIDs:
	ProxID:  A ProxID or place (aka LGID17) isolates “a” company at an address.  
	For example, ""ABC Landscaping"" and ""ABC Realty"" would be two separate ProxIDs even if they’re both at the same address.
	LGID3:	 LGID3 is the entity that contains all the ProxIDs for a company that has matching legal identifiers (FEIN, Charter Number, Name). 
	SELEID:	 SELEID is the “Smallest Encapsulating Legal Entity”.  For the majority of use cases, this is the legal entity and the BIP level used for Online products. 
	If a business exists at one, and only one address, then the SELEID = ProxID.  If the “top” level of the business is the LGID3, then the SELEID = LGID3. 
	OrgID (aka LGID2): OrgID is for a collection of legal entities or SELEIDs.  If ABC Holding company owns ABC 1, ABC2 and ABC3 – then all 4 of those things = 1 Org.*/
//W20200806-092231	Prod 

IMPORT _Control, BIPV2, BIPV2_PostProcess, corp2, data_services, STD, ut;
EXPORT NonFCRA_BIP_Corps(string pHostname, string pTarget, string pContact ='\' \'', STRING today = (STRING8)STD.Date.Today()) := function

filedate := today;

//key_BIPV2_Header := INDEX(layout_BIP_linkids, rec_nonkeyed_fields_BIP, data_services.foreign_prod+ 'thor_data400::key::bipv2::business_header::qa::linkids');
key_BIPV2_Header := PULL(BIPV2.Key_BH_Linking_Ids.key);
BIPV2_Header_SELEIDs := DEDUP(sort(distribute(key_BIPV2_Header(seleid > 0), hash(seleid)), seleid, -dt_vendor_last_reported, -dt_last_seen, local), seleid, local); 

tbl_SELEIDs_gold := TABLE(BIPV2_Header_SELEIDs, {sele_gold, seleid_count := count(group)}, sele_gold, few);
tbl_SELEIDs_by_Segment := TABLE(BIPV2_Header_SELEIDs, {sele_seg, sele_seg_desc := BIPV2_PostProcess.constants.fDesc(sele_seg), seleid_count := count(group)}, sele_seg, few);

BIPV2_Header_PROXIDs := DEDUP(sort(distribute(key_BIPV2_Header(PROXid > 0), hash(PROXid)), PROXid, -dt_vendor_last_reported, -dt_last_seen, local), PROXid, local); 
tbl_PROXIDs_by_Segment := TABLE(BIPV2_Header_PROXIDs, {prox_seg, prox_seg_desc := BIPV2_PostProcess.constants.fDesc(prox_seg), proxid_count := count(group)}, prox_seg, few);

//There are 2 slides on Corporations (Corps) data.  Corps can be sourced from BIP Header, but using the Corps build to run stats.
//key_Corps := INDEX(layout_BIP_linkids, rec_nonkeyed_fields_Corps, data_services.foreign_prod+ 'thor_data400::key::corp2::qa::corp::linkids');
key_Corps := PULL(Corp2.Key_LinkIDs.corp.key);
Corps_SELEIDs := DEDUP(sort(distribute(key_Corps(seleid <> 0), hash(seleid)), seleid,-dt_last_seen,-dt_vendor_last_reported, local,skew(1.0)),seleid, local);

since_date := (unsigned6) 20100101;

key_Corps_src_first_seen 	:= DEDUP(sort(distribute(key_Corps(seleid <> 0), hash(corp_state_origin, seleid)), corp_state_origin, seleid, dt_first_seen, local), corp_state_origin, seleid, dt_first_seen, local)(dt_first_seen >= since_date);
key_Corps_src_last_seen 	:= DEDUP(sort(distribute(key_Corps(seleid <> 0), hash(corp_state_origin, seleid)), corp_state_origin, seleid, -dt_last_seen, local), corp_state_origin, seleid, dt_last_seen, local)(dt_last_seen >= since_date);

rec_src_dates_first_seen_Corps :=	RECORD
		key_Corps_src_first_seen.corp_state_origin;
		unsigned6 first_seen := key_Corps_src_first_seen.dt_first_seen DIV 100;
//	key_Corps_src_first_seen.corp_status_desc;
		unsigned6	seleid_count := count(group);
	END;
	
tbl_src_dates_first_seen_Corps := TABLE(key_Corps_src_first_seen, rec_src_dates_first_seen_Corps, corp_state_origin,dt_first_seen DIV 100, MANY);	

rec_src_dates_last_seen_Corps := RECORD
		key_Corps_src_last_seen.corp_state_origin;
		unsigned6 last_seen := key_Corps_src_last_seen.dt_last_seen DIV 100;
		//	key_Corps_src_last_seen.corp_status_desc;
		unsigned6	seleid_count := count(group);
	END;
	
tbl_src_dates_last_seen_Corps := TABLE(key_Corps_src_last_seen, rec_src_dates_last_seen_Corps, corp_state_origin,dt_last_seen DIV 100, MANY);	

//Despray CSV to bctlpedata12 (one thor file and one csv file). FTP to \\Risk\inf\Data_Factory\DI_Landingzone
despray_bip_selid_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_SELEIDs_by_Segment_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/tbl_SELEIDs_by_Segment_'+ filedate +'.csv'
																					,,,,true);

despray_bip_proxid_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_PROXIDs_by_Segment_'+ filedate +'.csv',
																					pHostname, 
																					pTarget + '/tbl_PROXIDs_by_Segment_'+ filedate +'.csv'
																					,,,,true);

despray_corp_fseen_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_src_dates_first_seen_Corps_'+ filedate +'.csv',
																					 pHostname, 
																					 pTarget + '/tbl_src_dates_first_seen_Corps_'+ filedate +'.csv'
																					 ,,,,true);

despray_corp_lseen_tbl := STD.File.DeSpray('~thor_data400::data_insight::data_metrics::tbl_src_dates_last_seen_Corps_'+ filedate +'.csv',
																					 pHostname, 
																					 pTarget + '/tbl_src_dates_last_seen_Corps_'+ filedate +'.csv'
																					 ,,,,true);

//if everything in the Sequential statement runs, it will send the Success email, else it will send the Failure email
email_alert := SEQUENTIAL(
						output(sort(tbl_SELEIDs_by_Segment, sele_seg),,'~thor_data400::data_insight::data_metrics::tbl_SELEIDs_by_Segment_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
						,output(sort(tbl_PROXIDs_by_Segment, prox_seg),,'~thor_data400::data_insight::data_metrics::tbl_PROXIDs_by_Segment_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
						,output(sort(tbl_src_dates_first_seen_Corps, corp_state_origin,-first_seen),,'~thor_data400::data_insight::data_metrics::tbl_src_dates_first_seen_Corps_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
						,output(sort(tbl_src_dates_last_seen_Corps, corp_state_origin,-last_seen),,'~thor_data400::data_insight::data_metrics::tbl_src_dates_last_seen_Corps_'+ filedate +'.csv', csv(heading(single), separator('|'),terminator('\r\n'),quote('\"')), overwrite, expire(10))
						,despray_bip_selid_tbl
						,despray_bip_proxid_tbl
						,despray_corp_fseen_tbl
						,despray_corp_lseen_tbl):
					Success(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_BIP_Corps Build Succeeded', workunit + ': Build complete.' + filedate)),
					Failure(FileServices.SendEmail(pContact, 'NonFCRA Group: NonFCRA_BIP_Corps Build Failed', workunit + filedate + '\n' + FAILMESSAGE));
return email_alert;

end;