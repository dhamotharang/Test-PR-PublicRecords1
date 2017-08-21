IMPORT corp2, corp2_raw_wy;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_corp_status_code: returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_corp_status_code(STRING s, STRING recordorigin) := FUNCTION

			uc_s 			:= corp2.t2u(s);
			uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
											map(uc_s in ['AC','AP']									=> true,
													uc_s in ['BK','BT']									=> true,
													uc_s in ['CA','CO','CR','CV']				=> true,
													uc_s in ['DH','DS','DV']						=> true,
													uc_s in ['EE','EX']									=> true,
													uc_s in ['FE','FF','FR']						=> true,
													uc_s in ['IS']											=> true,
													uc_s in ['LF']											=> true,
													uc_s in ['MG','MO']									=> true,
													uc_s in ['NC','NF','NG']						=> true,
													uc_s in ['RF','RI','RR','RV']				=> true,
													uc_s in ['SD','SU']									=> true,
													uc_s in ['TC']											=> true,
													uc_s in ['WD']											=> true,
													uc_s in ['ZZ']											=> true,
												  false
												 ),
											true //For contact records, corp_ln_name_type_cd doesn't have to exist
										 );

			 RETURN if(isValidCD,1,0);

		END;

		//****************************************************************************
		//invalid_corp_orig_org_structure_cd: 	returns true or false based upon the
		//																			incoming code.
		//****************************************************************************
		EXPORT invalid_corp_orig_org_structure_cd(STRING s, STRING recordorigin) := FUNCTION

			uc_s 			:= corp2.t2u(s);
			uc_ro 		:= corp2.t2u(recordorigin);
					 
			isValidCD := if(uc_ro = 'C',
												map(uc_s in [''] 													                   => true,
														uc_s in ['DOMES']																				 => true,
														uc_s in ['DLLC','DPPA','DPRX','DRNP']                    => true,
														uc_s in ['FLLC','FPPC','FRNP','FPXX']                    => true,
														uc_s in ['DCR','DCX','DFX','DLC']                        => true,
                            uc_s in ['DNA','DNP','DNX','DPC']                        => true,
                            uc_s in ['DPR','DPX','DRD','FBT']                        => true,
                            uc_s in ['FCR','FCX','FFX','FLC']                        => true,
														uc_s in ['FNP','FNX','FPC','FPR']                        => true,
                            uc_s in ['FPX','LPC','PLC','ZZ']                         => true,
														false
													 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );


			 RETURN if(isValidCD,1,0);

		END;

		//****************************************************************************
		//invalid_corp_orig_org_structure_desc:	returns true or false based upon the
		//																			incoming code.
		//****************************************************************************
		EXPORT invalid_corp_orig_org_structure_desc(STRING s, STRING recordorigin) := FUNCTION

			uc_s 				:= corp2.t2u(s);
			uc_ro 			:= corp2.t2u(recordorigin);
					 
			isValidDesc := if(uc_ro = 'C',
												map(stringlib.stringfilterout(uc_s,' -/ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '' => true,
														false
													 ),
												true //For contact records, corp_ln_name_type_desc doesn't have to exist
											 );

			 RETURN if(isValidDesc,1,0);

		END;

END;