import doxie;

party_base := official_records.File_Base_Party(official_record_key != '');

export Key_Party_ORID := index(party_base,
                               {official_record_key},
							                 {state_origin,county_name,
															  doc_filed_dt,doc_type_desc,
																entity_type_desc,entity_nm,
																title1,fname1,mname1,lname1,suffix1,cname1,
																master_party_type_cd},
				           	'~thor_200::key::official_records_party_ORID_' + doxie.Version_SuperKey);
