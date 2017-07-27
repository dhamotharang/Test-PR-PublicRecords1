layout_vehicles To_Vehicles(Layout_FL_Update pInput) := transform
  self.vrid 					:= 0; // fill in later
  self.dt_first_seen 			:= (unsigned8)(pInput.process_date[1..6]);
  self.dt_last_seen 			:= (unsigned8)(pInput.process_date[1..6]);
  self.dt_vendor_first_reported	:= (unsigned8)(pInput.process_date[1..6]);
  self.dt_vendor_last_reported 	:= (unsigned8)(pInput.process_date[1..6]);
  self.orig_state 				:= 'FL';
  self.seq_no 					:= (unsigned4)pInput.seq_no;
  self.OWN_1_DOB                := if(pInput.OWNER_1_CUSTOMER_TYPExBG3 = 'I',
                                      pInput.OWN_1_DOB, '');
  self.OWN_2_DOB                := if(pInput.OWNER_2_CUSTOMER_TYPE = 'I',
                                      pInput.OWN_2_DOB, '');
  self.REG_1_DOB                := if(pInput.REGISTRANT_1_CUSTOMER_TYPExBG5 = 'I',
                                      pInput.REG_1_DOB, '');
  self.REG_2_DOB                := if(pInput.REGISTRANT_2_CUSTOMER_TYPE = 'I',
                                      pInput.REG_2_DOB, '');
  self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(pInput.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL[1..5] <> 'UNDEF',
											   pInput.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL,
											   ''
											  );
  self.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(pInput.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL[1..5] <> 'UNDEF',
											   pInput.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL,
											   ''
											  );
  self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(pInput.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL[1..5] <> 'UNDEF',
											   pInput.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL,
											   ''
											  );
  self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(pInput.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL[1..5] <> 'UNDEF',
											   pInput.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL,
											   ''
											  );
  self 							:= pInput;
  end;


export FL_as_Vehicles
 :=	project(File_FL_Full	,to_vehicles(left))
 +	project(File_FL_Update	,to_vehicles(left))
 ;