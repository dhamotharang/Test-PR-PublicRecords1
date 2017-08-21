
import mi7;


dist_File_valid_ecl_cade_id_source_uid :=  DISTRIBUTE(File_valid_ecl_cade_id_source_uid,HASH32(ecl_cade_id));	
dist_MapCourtOffensesToCriminalCharges :=  DISTRIBUTE(MapCourtOffensesToCriminalCharges,HASH32(ecl_cade_id));																		 

join_get_valid_crim_charges := join(dist_File_valid_ecl_cade_id_source_uid , dist_MapCourtOffensesToCriminalCharges,
                                                                  left.ecl_cade_id = right.ecl_cade_id,local);

ds_get_source_UID := join(join_get_valid_crim_charges , mi7.File_references_tables,
																		left.CAMA_SOURCE_UID = right.court_id and
																		left.OLD_RECORD_SUPPLIER_CD =  right.RECORD_SUPPLIER_CD,
																		LEFT OUTER,lookup);
																																	
//output(ds_get_source_UID);			


Layout_CriminalCharges_Offender_key := Layout_criminal_charges_cp;

Layout_CriminalCharges_Offender_key Get_source_UID(ds_get_source_UID L) := TRANSFORM
Self.CAMA_SOURCE_UID := l.prso_source_uid;                                        
SELF := L;
END;

ds_crim_charges_source_uid_validation := PROJECT(ds_get_source_UID,Get_source_UID(LEFT));

//output(ds_crim_charges_source_uid_validation);


export MapValidCriminalChargesSourceUID := ds_crim_charges_source_uid_validation
                                                                              : persist ('~thor_data400::persist::out::crim::cross_soff::MapValidCriminalChargesSourceUID');   


