import ut;


 fl_div_ds := dataset('~thor_data200::in::mar_div::fl::divorce',
									   marriage_divorce_v2.Layouts_Divorce_FL_In.Layout_Divorce_FL_Variable_In,
										 csv(heading(2),terminator('\r\n')))(payload != ' ',stringlib.stringfind(payload,'row(s) affected',1)=0);



marriage_divorce_v2.Layouts_Divorce_FL_In.Layout_Divorce_FL_In trfProject(marriage_divorce_v2.Layouts_Divorce_FL_In.Layout_Divorce_FL_Variable_In l) :=
transform
	
	self.certnumber 										:= if (trim(l.payload[1..11])   = 'NULL','',l.payload[1..11]);
  self.county_issuing_report					:= if (trim(l.payload[12..52])  = 'NULL','',l.payload[12..52]);
  self.date_of_final_judgmentMM			  := if (trim(l.payload[53..77])  = 'NULL','',l.payload[53..77]);
  self.date_of_final_judgmentDD			  := if (trim (l.payload[78..102]) = 'NULL','',l.payload[78..102]);
  self.date_of_final_judgmentYY			  := if (trim (l.payload[103..127])= 'NULL','',l.payload[103..127]);
  self.date_filed_recMM							  := if (trim (l.payload[128..144])= 'NULL','',l.payload[128..144]);
  self.date_filed_recDD							  := if (trim (l.payload[145..161])= 'NULL','',l.payload[145..161]);
  self.date_filed_recYY							  := if (trim (l.payload[162..178])= 'NULL','',l.payload[162..178]);
  self.husb_name_first								:= if (trim (l.payload[179..219])= 'NULL','',l.payload[179..219]);
  self.husb_name_middle							  := if (trim (l.payload[220..260])= 'NULL','',l.payload[220..260]);
  self.husb_name_last								  := if (trim (l.payload[261..301])= 'NULL','',l.payload[261..301]);	
  self.husb_name_suffix							  := if (trim (l.payload[302..318]) = 'NULL','',l.payload[302..318]);
  self.husb_res_state_code						:= if (trim (l.payload[319..338])= 'NULL','',l.payload[319..338]);
  self.wife_name_first								:= if (trim (l.payload[339..379])= 'NULL','',l.payload[339..379]);
  self.wife_name_middle							  := if (trim (l.payload[380..420])= 'NULL','',l.payload[380..420]);
  self.wife_name_last								  := if (trim (l.payload[421..461])= 'NULL','',l.payload[421..461]);	
  self.wife_maiden_surname						:= if (trim (l.payload[462..502])= 'NULL','',l.payload[462..502]);
  self.wife_res_state_code						:= if (trim (l.payload[503..522])= 'NULL','',l.payload[503..522]);
  self.date_of_marriage_month				  := if (trim (l.payload[523..545])= 'NULL','',l.payload[523..545]);
  self.date_of_marriage_day					  := if (trim (l.payload[546..566])= 'NULL','',l.payload[546..566]);
  self.date_of_marriage_year					:= if (trim (l.payload[567..588])= 'NULL','',l.payload[567..588]);
  self.marr_state_code								:= if (trim (l.payload[589..604])= 'NULL','',l.payload[589..604]);
  self.living_child_under18					  := if (trim (l.payload[605..625])= 'NULL','',l.payload[605..625]);
  self.type_of_report								  := if (trim (l.payload[626..666])= 'NULL','',l.payload[626..666]);
  self.docket_vol_page 							  := if (trim (l.payload[667..716])= 'NULL','',l.payload[667..716]);
	
 end;

export File_Divorce_FL_In := project(fl_div_ds,trfProject(left));
