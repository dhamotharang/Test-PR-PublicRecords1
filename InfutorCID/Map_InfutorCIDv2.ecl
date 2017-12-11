import instantid_logs, aid, address, ut, did_add, header_slimsort, didville, header, address, watchdog, yellowpages, gong, cellphone, risk_indicators, lib_stringlib, ut, idl_header, address, Std;

export Map_InfutorCIDv2(string filedate) := function

////////////////// FORMAT RAW INPUT DATA ////////////////////////////////////////////////////////////////////////////

/* Input files are a full file refresh */
IfCID_pNew := infutorcid.File_InfutorCID ;

/* layout for name cleaning portion with new refresh file and aid input */
clean_layout := record 
  string persistent_record_id := '';
	string  sequence_number := '';
	infutorcid.Layout_InfutorCID;
  string10  phone:='';
	string5		title:='';
  string20	fname:='';
  string20	mname:='';
  string20	lname:='';
  string5		name_suffix:='';
  string3		name_score:='';
	unsigned8 rawAIDin := 0;
	string line1:= '';
	string linelast := '';
	
  unsigned6 dt_first_seen:=0;
	unsigned6 dt_last_seen:=0;
  unsigned6 dt_vendor_first_reported:=0;
	unsigned6 dt_vendor_last_reported:=0;
	
	boolean historical := false;
	
	string182 previous_cleanaddress := '';
end;

/* Clean names, apply dates, change layout for new records */
ifcid_new := project(IfCID_pNew, transform(clean_layout,
																			
																			GOODDATE(string indate) := if(indate between '19010101' and (STRING8)Std.Date.Today(), indate, '');
																			
																			/* Clean out parans (Removes ( or ) and all characters following) and does not display names with junk fields */
																			PRS_CLEANNAME(string ofname, string omname, string olname):= function
																			 CLEANEDPARANS(string namefield):= function
																					cleanedParan1 := if(stringlib.stringfind(namefield, '(', 1) > 0, 
																									namefield[1..stringlib.stringfind(namefield, '(', 1)-1], namefield);
																					cleanedParan2 := if(stringlib.stringfind(cleanedParan1, ')', 1) > 0, 
																									cleanedParan1[1..stringlib.stringfind(cleanedParan1, ')', 1)-1], cleanedParan1);
																				return cleanedParan2; end;
 																			CLEANIT := if(cleanedParans(ofname) <> '' and cleanedParans(olname) <> '' and ~regexfind('[^A-Za-z \\-\\.\',]', ofname + olname),
																									Address.CleanPersonFMl73(cleanedParans(ofname) + ' ' + stringlib.stringfilter(stringlib.stringtouppercase(omname), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ' ) + ' ' + cleanedParans(olname)),'');
																				// cleanit := cleanedParans(fname) + cleanedParans(lname);
 																			  return cleanit; end;
																			CLEANNAME := prs_cleanname(left.orig_firstname, left.orig_mi, left.orig_lastname);
																		
																		is_flip := trim(left.orig_PrimaryHouseNumber, left, right) <> '' and 
																								(trim(left.orig_PrimaryStreetName, left, right)[..3] in ['RR ', 'HC '] or
																								(trim(left.orig_PrimaryStreetName, left, right) = 'PO BOX')) and
																								trim(left.orig_PrimaryPreDirAbbrev, left, right) = '' and
																								trim(left.orig_PrimaryStreetType, left, right) = '' and
																								trim(left.orig_PrimaryPostDirAbbrev, left, right) = '';																	

																		self.sequence_number	:= filedate + '_' + (string)intformat(counter, 10,1) ;
																		self.phone				:= Cellphone.CleanPhones(left.orig_phone);		
		  															self.title 				:= CleanName[1..5];
																		self.fname 				:= CleanName[6..25];
																		self.mname 				:= CleanName[26..45];
																		self.lname 				:= CleanName[46..65];
																		self.name_suffix 	:= CleanName[66..70];
																		self.dt_first_seen		:= (unsigned6)trim(if(GoodDate(left.orig_firstdate) = '', 
																																if(GoodDate(left.orig_lastdate) = '', '99999999', left.orig_lastdate), 
																																left.orig_firstdate), all);
																		self.dt_last_seen			:= (unsigned6)trim(if(GoodDate(left.orig_lastdate) = '', 
																																GoodDate(left.orig_firstdate), left.orig_lastdate), all);
																		self.dt_vendor_first_reported		:= (unsigned6)filedate[1..8];
																		self.dt_vendor_last_reported		:= (unsigned6)filedate[1..8];
																															
																	  self.line1 := address.fn_addr_clean_prep(if(~is_flip, Address.Addr1FromComponents(left.orig_PrimaryHouseNumber,
																																													left.orig_PrimaryPreDirAbbrev,
																																													left.orig_PrimaryStreetName,
																																													left.orig_PrimaryStreetType, 
																																													left.orig_PrimaryPostDirAbbrev,
																																													left.orig_SecondaryAptType,
																																													left.orig_SecondaryAptNbr),
																															 Address.Addr1FromComponents('', '',
																															                             trim(left.orig_PrimaryStreetName, left, right) + ' ' + trim(left.orig_PrimaryHouseNumber, left, right),
																																													 '', '',
																																													 left.orig_SecondaryAptType,
																																													 left.orig_SecondaryAptNbr)), 'first');

																		self.linelast := address.fn_addr_clean_prep(Address.Addr2FromComponents (left.orig_City,
																																									left.orig_State,
																																									left.orig_Zip[..5]), 'last');																		
																		self.previous_cleanaddress := '';
																		self := left));

////////////////// ADD HISTORICAL AND ROLL UP ////////////////////////////////////////////////////////////////////////////

/* Infutor CID Previous Base */
IfCID_Old := project(infutorcid.File_InfutorCID_Base, transform(clean_layout,
																								is_flip := trim(left.orig_PrimaryHouseNumber, left, right) <> '' and 
																								(trim(left.orig_PrimaryStreetName, left, right)[..3] in ['RR ', 'HC '] or
																								(trim(left.orig_PrimaryStreetName, left, right) = 'PO BOX')) and
																								trim(left.orig_PrimaryPreDirAbbrev, left, right) = '' and
																								trim(left.orig_PrimaryStreetType, left, right) = '' and
																								trim(left.orig_PrimaryPostDirAbbrev, left, right) = '';
																								
																																				self.line1 := address.fn_addr_clean_prep(if(~is_flip, Address.Addr1FromComponents(left.orig_PrimaryHouseNumber,
																																													left.orig_PrimaryPreDirAbbrev,
																																													left.orig_PrimaryStreetName,
																																													left.orig_PrimaryStreetType, 
																																													left.orig_PrimaryPostDirAbbrev,
																																													left.orig_SecondaryAptType,
																																													left.orig_SecondaryAptNbr),
																																													Address.Addr1FromComponents('', '',
																															                             trim(left.orig_PrimaryStreetName, left, right) + ' ' + trim(left.orig_PrimaryHouseNumber, left, right),
																																													 '', '',
																																													 left.orig_SecondaryAptType,
																																													 left.orig_SecondaryAptNbr)), 'first');

																																				self.linelast := address.fn_addr_clean_prep(Address.Addr2FromComponents (left.orig_City,
																																									left.orig_State,
																																									left.orig_Zip[..5]), 'last');																		

																																					self := left));

/* Combine and rollup before build*/
full_ := project(IfCID_New + IfCID_Old, transform(clean_layout, self.persistent_record_id := filedate + '_' + (string)intformat(counter, 10,1), self := left));
full_sort := sort(distribute(full_, hash(orig_FirstName, orig_Lastname, orig_phone,orig_PrimaryHouseNumber,orig_City,orig_Zip)), record, except sequence_number, except persistent_record_id, local);

clean_layout rollup_records(clean_layout L, clean_layout R) := transform
		self.orig_FirstDate := if(l.orig_FirstDate > r.orig_FirstDate, r.orig_FirstDate, l.orig_FirstDate);
		self.orig_LastDate := if(l.orig_LastDate > r.orig_LastDate, l.orig_LastDate, r.orig_LastDate);
		self.dt_first_seen := if(l.dt_first_seen > r.dt_first_seen, r.dt_first_seen, l.dt_first_seen);
		self.dt_last_seen  := if(l.dt_last_seen  < r.dt_last_seen,  r.dt_last_seen,  l.dt_last_seen);
		self.dt_vendor_first_reported := if(l.dt_vendor_first_reported > r.dt_vendor_first_reported, r.dt_vendor_first_reported, l.dt_vendor_first_reported);
		self.dt_vendor_last_reported  := if(l.dt_vendor_last_reported  < r.dt_vendor_last_reported,  r.dt_vendor_last_reported,  l.dt_vendor_last_reported);
		self.previous_cleanaddress := if(l.previous_cleanaddress <> '', l.previous_cleanaddress, r.previous_cleanaddress);
		self.rawAIDin := if(r.rawAIDin > 0, r.rawAIDin, l.rawAIDin);
		self.title :=  if(r.title <> '', r.title, l.title);
		self := r;
end;

full_dedup := rollup(full_sort, rollup_records(left, right), record,
			except dt_first_seen,
			except dt_last_seen,
			except dt_vendor_first_reported,
			except dt_vendor_last_reported,
			except fname,
			except historical,
			except line1,
			except linelast,
			except lname,
			except mname,
			except name_score,
			except name_suffix,
			except phone,
			except previous_cleanaddress,
			except rawAIDin,
			except sequence_number,
			except persistent_record_id,
			except title,
			except orig_firstdate,
			except orig_lastdate,
			except orig_Z4Type,
			except orig_DPV,
			except orig_MailDeliverabilityCode,
			except orig_AddressValidationDate,
			except orig_Filler1,
			except orig_DirectoryAssistanceFlag, local);


historical := project(full_dedup, transform(clean_layout, 
																				self.dt_first_seen := if(left.dt_first_seen = 99999999, left.dt_last_seen,  left.dt_first_seen);
																				self.historical := if(left.dt_vendor_last_reported = (unsigned6)filedate[1..8], false, true);
																				self := left));

////////////////// AID APPENDS ////////////////////////////////////////////////////////////////////////////

aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;
	
aid.MacAppendFromRaw_2Line(historical, 
														line1, linelast,
														rawAIDin, historical_out, laidappendflags);

cleaned := historical_out : persist('persist::infutorcid::clean');
// cleaned := dataset('~thor400_88_staging::persist::infutorcid::clean',recordof(historical_out), thor);

DenormedRecOut := RECORD
clean_layout;

/* AID fields */
   unsigned8 cleanaid;
   string1 addresstype;
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

unsigned6 DID := 0;
unsigned6 did_instantid := 0;
END;

DenormedRecOut tNormAidAppends(recordof(cleaned) l) := TRANSFORM
 SELF.rawAIDin := 		L.aidwork_rawaid;
 SELF.cleanaid := 	L.aidwork_acecache.cleanaid;
 SELF.addresstype := 	L.aidwork_acecache.addresstype;
 SELF.prim_range := 	L.aidwork_acecache.prim_range;
 SELF.predir := 	L.aidwork_acecache.predir;
 SELF.prim_name := 	L.aidwork_acecache.prim_name;
 SELF.addr_suffix := 	L.aidwork_acecache.addr_suffix;
 SELF.postdir := 	L.aidwork_acecache.postdir;
 SELF.unit_desig := 	L.aidwork_acecache.unit_desig;
 SELF.sec_range := 	L.aidwork_acecache.sec_range;
 SELF.p_city_name := 	L.aidwork_acecache.p_city_name;
 SELF.v_city_name := 	L.aidwork_acecache.v_city_name;
 SELF.st := 	L.aidwork_acecache.st;
 SELF.zip := 	L.aidwork_acecache.zip5;
 SELF.zip4 := 	L.aidwork_acecache.zip4;
 SELF.cart := 	L.aidwork_acecache.cart;
 SELF.cr_sort_sz := 	L.aidwork_acecache.cr_sort_sz;
 SELF.lot := 	L.aidwork_acecache.lot;
 SELF.lot_order := 	L.aidwork_acecache.lot_order;
 SELF.dbpc := 	L.aidwork_acecache.dbpc;
 SELF.chk_digit := 	L.aidwork_acecache.chk_digit;
 SELF.rec_type := 	L.aidwork_acecache.rec_type;
 SELF.county := 	L.aidwork_acecache.county;
 SELF.geo_lat := 	L.aidwork_acecache.geo_lat;
 SELF.geo_long := 	L.aidwork_acecache.geo_long;
 SELF.msa := 	L.aidwork_acecache.msa;
 SELF.geo_blk := 	L.aidwork_acecache.geo_blk;
 SELF.geo_match := 	L.aidwork_acecache.geo_match;
 SELF.err_stat := 	L.aidwork_acecache.err_stat;
 SELF := L;
END;

aid_append := NORMALIZE(cleaned, 1, tNormAidAppends(LEFT));

/////////////// APPLY NAME FLIPPING MACRO//////////////////////////////////
ut.mac_flipnames(aid_append,fname,mname,lname,names_flipped);

///////////////// DID APPENDS - including Instant ID ////////////////////////////////////////////////////////////////////////////

lMatchSet :=['A','P','Z'];

did_Add.MAC_Match_Flex
	(names_flipped, lMatchSet,						
	 '', '', fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 DID,
	 recordof(names_flipped),
	 false, '',
	 75,						
	 checkpointed
	)

didfile := checkpointed : persist('persist::InfutorCID::clean_did');

for_instant_append := didFILE(did = 0 AND phone != '' AND fname != '' AND lname != ''); 

/* Original Instructions only Append Logs up to 2 years old - if restriction date is not populated it does not error. Default is '' */
restriction_date := (string)((integer6)stringlib.getDateYYYYMMDD() - 20000);

// infutorcid.mac_InstantID_Logs_ADL_Append(for_instant_append, restriction_date, InstantIDAppend);
InstantIDAppend := for_instant_append; //bypassing the DID append from log file for now since the file is missing. 
not_instant_append := didFILE(did > 0 OR phone = '' OR fname = '' OR lname = '') + InstantIDAppend(did_instantid = 0); 

INSTANTdidFile := distribute(instantIDAppend(did_instantid > 0), hash(did_instantid));
// INSTANTdidFile := dataset('~thor400_88_staging::persist::infutorcid::clean_did', recordof(not_instant_append), thor);

////////////////// HEADER ADDRESS APPENDS ////////////////////////////////////////////////////////////////////////////

Instant_DIDs := dedup(project(INSTANTdidFile(did_instantid > 0), 
													transform({unsigned6 did}, self.did := left.did_instantid)), 
											did, all);

/* joins records to header to pull records for appends */
InfutorCID.mac_Header_Address_Append.append_process(Instant_DIDs, hdr_addresses);

/* Assign Addresses from Header */
hdr_append_layout := record
DenormedRecOut;
  string10	append_prim_range:='';
  string2		append_predir:='';
  string28	append_prim_name:='';
  string4		append_addr_suffix:='';
  string2		append_postdir:='';
  string8		append_sec_range:='';
  string25	append_p_city_name:='';
  string2		append_st:='';
  string5		append_zip:='';
  string4		append_zip4:='';
  boolean   append_is_po_box := false;
  string4   append_in_eq := '';
  string4   append_in_en := '';
  string4   append_in_wp := '';
  string4   append_in_util := '';
  string4   append_in_ts := '';
  string4   append_in_veh := '';
  string4   append_in_prop := '';
  string4   append_in_dl := '';
  string4   append_in_tu := '';
  string4   append_in_other := '';
  boolean   append_only_glb := false;
  integer   append_addr_in_zip := 0;
  integer   append_prange_srange_in_zip := 0;
end;

infutorcid.Layout_InfutorCID_Base jnTrApndHdr(INSTANTdidFile l, recordof(hdr_addresses) r) := transform
  self.append_prim_range := r.prim_range;
  self.append_predir := r.predir;
  self.append_prim_name := r.prim_name;
  self.append_addr_suffix := r.suffix;
  self.append_postdir := r.postdir;
  self.append_sec_range := r.sec_range;
  self.append_p_city_name := r.city_name;
  self.append_st := r.st;
  self.append_zip := r.zip;
  self.append_zip4 := r.zip4;
  self.append_is_po_box := r.is_po_box;
  self.append_in_eq := r.in_eq;
  self.append_in_en := r.in_en;
  self.append_in_wp := r.in_wp;
  self.append_in_util := r.in_util;
  self.append_in_ts := r.in_ts;
  self.append_in_veh := r.in_veh;
  self.append_in_prop := r.in_prop;
  self.append_in_dl := r.in_dl;
  self.append_in_tu := r.in_tu;
  self.append_in_other := r.in_other;
  self.append_only_glb := r.only_glb;
  self.append_addr_in_zip := r.addr_in_zip;
  self.append_prange_srange_in_zip := r.prange_srange_in_zip;
	self := l;
end;	

/* Join to headers to append addresses */
jnHeader := dedup(sort(
							distribute(
												 join(INSTANTdidFile, distribute(hdr_addresses(did > 0 and zip <> ''), hash(did)), 
															left.did_instantid = right.did, jnTrApndHdr(left, right), left outer, local) +
												 project(not_instant_append,infutorcid.Layout_InfutorCID_Base), 
							hash(phone, fname, lname, zip, orig_businessname)), 
						record, except sequence_number,except persistent_record_id, local), record, except sequence_number,except persistent_record_id, local);
						
fixDates := project(jnHeader, transform(recordof(jnHeader),
									self.dt_first_seen := min(left.dt_first_seen, left.dt_last_seen);
									self.dt_last_seen := max(left.dt_first_seen, left.dt_last_seen);
									self := left))(orig_phone <> '7725593733', orig_phone <> '8583422994');
										
										
groupInfo := group(fixDates, sequence_number, local);

infutorcid.Layout_InfutorCID_Base t_Sequence(groupInfo l, groupInfo r, unsigned c) := TRANSFORM
  self.persistent_record_id := trim(r.persistent_record_id,left, right) + '_' + filedate + '_' +  (string)intformat(c, 3,1);
	self := r;
END;


// Add num - the number of records per sequence_number
numbered := iterate(groupInfo, t_Sequence(LEFT, RIGHT, COUNTER)) :persist('~persist::infutorcid::persistent_rec_id');

persist_ids := join(distributed(numbered, hash(sequence_number)),
								    distributed(infutorcid.File_InfutorCID_Base, hash(sequence_number)),
										left.sequence_number= right.sequence_number and
										left.orig_phone = right.orig_phone and
										left.did = right.did and
										left.did_instantid = right.did_instantid and
										left.append_prim_range = right.append_prim_range and
										left.append_prim_name = right.append_prim_name and
										left.append_zip = right.append_zip,
										transform(infutorcid.Layout_InfutorCID_Base,
																self.persistent_record_id  := if(left.sequence_number= right.sequence_number,
																																right.persistent_record_id, left.persistent_record_id),
															self := left),
										left outer,
										local);

return persist_ids;
end;