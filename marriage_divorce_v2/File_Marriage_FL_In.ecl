import ut;


fl_mar_ds :=  dataset(ut.foreign_prod+'thor_200::in::mar_div::fl::marriage',
									   marriage_divorce_v2.Layouts_Marriage_FL_In.Layout_Marriage_FL_Variable_In,
										 csv(heading(1),terminator('\r\n')),OPT)(payload != ' ',stringlib.stringfind(payload,'row(s) affected',1)=0);






marriage_divorce_v2.Layouts_Marriage_FL_In.Layout_Marriage_FL_In trfProject(marriage_divorce_v2.Layouts_Marriage_FL_In.Layout_Marriage_FL_Variable_In l) :=
transform
		
	self.certnumber 											:= if (trim (l.payload[1..11])    = 'NULL','',l.payload[1..11]);
  self.county_issuing_lic_code					:= if (trim (l.payload[12..35])   = 'NULL','',l.payload[12..35]);
  self.groom_name_first			  					:= if (trim (l.payload[36..76])   = 'NULL','',l.payload[36..76]);
  self.groom_name_middle			  				:= if (trim (l.payload[77..117])  = 'NULL','',l.payload[77..117]);
  self.groom_name_last			  					:= if (trim (l.payload[118..158]) = 'NULL','',l.payload[118..158]);
  self.groom_name_suffix							  := if (trim (l.payload[159..176]) = 'NULL','',l.payload[159..176]);
  self.groom_DOB_month							  	:= if (trim (l.payload[177..192]) = 'NULL','',l.payload[177..192]);
  self.groom_DOB_day							  		:= if (trim (l.payload[193..206]) = 'NULL','',l.payload[193..206]);
  self.groom_DOB_year										:= if (trim (l.payload[207..221]) = 'NULL','',l.payload[207..221]);
  self.groom_age							  				:= if (trim (l.payload[222..233]) = 'NULL','',l.payload[222..233]);
  self.groom_race_code								  := if (trim (l.payload[234..249]) = 'NULL','',l.payload[234..249]);	
  self.groom_res_state_code							:= if (trim (l.payload[250..270]) = 'NULL','',l.payload[250..270]);
  self.groom_bir_state_code							:= if (trim (l.payload[271..291]) = 'NULL','',l.payload[271..291]);
  self.groom_marr_end_how_code					:= if (trim (l.payload[292..315]) = 'NULL','',l.payload[292..315]);
  self.groom_marriage_number						:= if (trim (l.payload[316..337]) = 'NULL','',l.payload[316..337]);
  self.groom_Date_marr_end_month				:= if (trim (l.payload[338..363]) = 'NULL','',l.payload[338..363]);	
  self.groom_Date_marr_end_day					:= if (trim (l.payload[364..387]) = 'NULL','',l.payload[364..387]);
  self.groom_Date_marr_end_year					:= if (trim (l.payload[388..412]) = 'NULL','',l.payload[388..412]);
  self.bride_name_first				  				:= if (trim (l.payload[413..453]) = 'NULL','',l.payload[413..453]);
  self.bride_name_middle					  		:= if (trim (l.payload[454..494]) = 'NULL','',l.payload[454..494]);
  self.bride_name_last									:= if (trim (l.payload[495..535]) = 'NULL','',l.payload[495..535]);
	self.bride_maiden_surname							:= if (trim (l.payload[536..576]) = 'NULL','',l.payload[536..576]);
  self.bride_DOB_month									:= if (trim (l.payload[577..592]) = 'NULL','',l.payload[577..592]);
  self.bride_DOB_day					  				:= if (trim (l.payload[593..606]) = 'NULL','',l.payload[593..606]);
  self.bride_DOB_year								  	:= if (trim (l.payload[607..621]) = 'NULL','',l.payload[607..621]);
  self.bride_age 							  				:= if (trim (l.payload[622..633]) = 'NULL','',l.payload[622..633]);
	self.bride_race_code									:= if (trim (l.payload[634..649]) = 'NULL','',l.payload[634..649]);
  self.bride_res_state_code							:= if (trim (l.payload[650..670]) = 'NULL','',l.payload[650..670]);
  self.bride_bir_state_code							:= if (trim (l.payload[671..691]) = 'NULL','',l.payload[671..691]);
  self.bride_marr_end_how_code					:= if (trim (l.payload[692..715]) = 'NULL','',l.payload[692..715]);
  self.bride_marriage_number						:= if (trim (l.payload[716..737]) = 'NULL','',l.payload[716..737]);
  self.bride_Date_marr_end_month				:= if (trim (l.payload[738..763]) = 'NULL','',l.payload[738..763]);
  self.bride_Date_marr_end_day					:= if (trim (l.payload[764..787]) = 'NULL','',l.payload[764..787]);
  self.bride_Date_marr_end_year					:= if (trim (l.payload[788..812]) = 'NULL','',l.payload[788..812]);
  self.date_of_marriage_month						:= if (trim (l.payload[813..835]) = 'NULL','',l.payload[813..835]);
  self.date_of_marriage_day							:= if ( trim (l.payload[836..856]) = 'NULL','',l.payload[836..856]);
  self.date_of_marriage_year						:= if (trim (l.payload[857..878]) = 'NULL','',l.payload[857..878]);
  self.type_ceremony_code								:= if (trim (l.payload[879..897]) = 'NULL','',l.payload[879..897]);
  self.city_of_marriage									:= if (trim (l.payload[898..]) = 'NULL','',l.payload[898..]);
	
	
	
 end;

fl_mar_filter := project(fl_mar_ds,trfProject(left));


export File_Marriage_FL_In := fl_mar_filter( (trim(groom_name_last)!=''  and trim(groom_name_last)!='') or 
																						 (trim(bride_name_last)!=''  and trim(bride_name_first)!='')); 		
