#warning('deprecated. logic moved to doxie.SexOffender_Search_People_Records');
//fetch sexoffender records locally, by did or by sid
import doxie,sexoffender,drivers,header,ut,doxie_raw,STD;

export sexoffender_search_people_local (
  DATASET (doxie.layout_best) ds_best  = DATASET ([], doxie.layout_best),
  boolean IsFCRA) := function

doxie.MAC_Selection_Declare(); // Law_Enforcement
SexOffender.MAC_Header_Field_Declare(isFCRA);

string14 uid_value := '' : stored('UniqueId');

pre_dids := 	MAP( uid_value<>''		=> DATASET([{(unsigned)uid_value}],layout_references),
				Law_Enforcement	=> doxie.Get_SRNA_DIDs, 
				did_value<>''		=> DATASET([{(unsigned)did_value}],layout_references),
				PROJECT (doxie.Get_Dids(,~isCRS), doxie.layout_references));

// on FCRA side DIDs should be pre-calculated
dids := if (IsFCRA, project (ds_best, doxie.layout_references), pre_dids);//(Include_SexualOffenses_val);

string5 in_zip := if(zip_value_cleaned<>'', zip_value_cleaned, city_zip_value);
//
fetchedlocal := doxie_raw.SexOffender_People_Raw(dids,did_value,
		sid_value,uid_value,includeExtra,dateVal,dppa_purpose,glb_purpose, application_type_value, ssn_mask_value, in_zip,
		Maxresults_val, ssn_value, is_zip_only_search or SearchAroundAddress_value, IsFCRA);

key_enh := SexOffender.Key_SexOffender_SPK_Enh (IsFCRA);

xtra_addresses := JOIN(dedup(fetchedlocal,seisint_primary_key,all), key_enh, 
								keyed(LEFT.seisint_primary_key=RIGHT.sspk) AND
								~isFCRA and //currently we are not supporting the options for using SPK_Enh key for FCRA
								(RIGHT.alt_type='S' OR
								 (includeHistorical AND RIGHT.alt_type = 'H') OR
								 (includeRelatives AND RIGHT.alt_type = 'R') OR
								 (includeNonRegistered AND 
								  sexoffender.std_offender_status(left.offender_status) NOT IN ['C','D'] AND
								  RIGHT.alt_type NOT IN ['S','H','R'])) AND
								~(excludeRegistered AND RIGHT.alt_type='S') AND
								// check permissions
								(glb_ok OR RIGHT.alt_glb=0) AND
								(RIGHT.alt_dppa=0 OR (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src),dppa_purpose,RIGHT.src)))
								, TRANSFORM(recordof(key_enh), SELF := RIGHT), LIMIT (ut.limits. SOFFENDER_ENHANCED, SKIP));

sexoffender.Layout_Out_Alt formatAddresses(key_enh le) :=
TRANSFORM
	SELF.addrScore := doxie.FN_Tra_Penalty_Addr(le.alt_predir,le.alt_prim_range,
																							 le.alt_prim_name,le.alt_suffix,
																							 le.alt_postdir,le.alt_sec_range,
																							 le.alt_city_name,le.alt_st,le.alt_zip);
																							 
																							 

	SELF.isMismatched := le.isMismatched;
	SELF.addrPref := CASE(le.alt_type,
												'S' => 10,
												'B' => 9,
												'V' => 8,
												'C' => 7,
												'R' => 6,
												'H' => 4, 5);
												
	SELF := le;	
END;
layout_sexoffender_searchperson add_addresses(layout_sexoffender_searchperson le,
																								xtra_addresses ri) :=
TRANSFORM
	SELF.addresses := (le.addresses+PROJECT(ri, formatAddresses(LEFT)));

	SELF := le;
END;
addresses_added := DENORMALIZE(fetchedlocal, xtra_addresses, 
																LEFT.seisint_primary_key=RIGHT.seisint_primary_key, 
																add_addresses(LEFT,RIGHT));

todaysDate := (string) STD.Date.Today();

layout_sexoffender_searchperson filter_addresses(addresses_added le) :=
TRANSFORM
	filtered_addresses := le.addresses((addrScore<10) AND
					  // rm PO Box unless its the registered address
					  ((INTEGER)alt_zip<>0) AND
					  ((alt_prim_name[1..7] <> 'PO BOX') OR alt_type='S'));
																 
     most_recent_date := max(filtered_addresses, alt_addr_dt_last_seen);
	
     self.addresses := project(filtered_addresses, 
					      transform(recordof(filtered_addresses),
							      self.alt_type := if(left.alt_type not in ['B', 'V', 'C', 'P', 'L'] or   
								                    (left.alt_addr_dt_last_seen <> most_recent_date) or 
								                    (ut.daysapart(left.alt_addr_dt_last_seen + todaysDate[7..8], todaysDate) < 365 or
								                     ut.daysapart(left.alt_addr_dt_first_seen + todaysDate[7..8], todaysDate) < 365),
								                     left.alt_type, if(includeHistorical,'H','&')),
							      self := left))(alt_type<>'&');								 
	SELF := le;
END;

addresses_better := PROJECT(addresses_added, filter_addresses(LEFT));
                      
addresses_filtered := if(excludeRegistered, addresses_better(EXISTS(addresses)), addresses_better);
addresses_out_ready := IF(includeExtra,addresses_filtered,fetchedlocal);

layout_sexoffender_searchperson apply_zip_filter(addresses_out_ready l) := transform
   chd_zip_flag := if(includeExtra,exists(l.addresses((integer4)alt_zip IN zip_value)),false);	
   self.zip5 := if((integer4)l.zip5 in zip_value or chd_zip_flag, l.zip5, skip);
   self := l;
end;

addresses_zip_filted := project(addresses_out_ready, apply_zip_filter(left));

layout_sexoffender_searchperson apply_zip_city_filter(addresses_zip_filted l) := transform
   chd_city_flag := if(includeExtra,exists(l.addresses(alt_city_name=city_value)),false);	
   self.p_city_name := if(l.p_city_name='' or 
                          l.p_city_name=city_value or 
					 l.v_city_name=city_value or 
					 chd_city_flag, l.p_city_name, skip);
   self := l;
end;

addresses_zip_city_filted := project(addresses_zip_filted, apply_zip_city_filter(left));



mapped :=
map(is_zip_only_search => addresses_zip_filted, 
								      is_zip_city_search => addresses_zip_city_filted,
									 is_zip_mname_search => addresses_zip_filted(mname='' or mname[1]=mname_value[1]),
                                              addresses_out_ready);

return mapped;
end;