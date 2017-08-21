
import hygenics_soff;

offender_soff :=   JOIN(File_IN_SOFF_Offender(
                                  lname + 
																	fname +  
																	mname + 
																	name_suffix <> ''
																		 ),File_LN_Cross_Extract_Driver,LEFT.Source_file = RIGHT.Source_file and RIGHT.ln_cross_extract_flag = 'Y',lookup);		
																				

dist_offender_soff := distribute(offender_soff,HASH32(seisint_primary_key)); 

dedup_offender_soff := DEDUP(dist_offender_soff, RECORD, ALL, LOCAL); 

export File_soff_Offenders := dedup_offender_soff;		

