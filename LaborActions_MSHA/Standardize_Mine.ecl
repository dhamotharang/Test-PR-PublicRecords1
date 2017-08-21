import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export Standardize_Mine := MODULE

	export Layout_Clean_Name := record
			LaborActions_MSHA.Layouts_Mine.Base;
			string1         name_flag;
			string5         cln_title;
			string20        cln_fname;
			string20        cln_mname;
			string20        cln_lname;
			string5         cln_suffix;
			string5         cln_title2;
			string20        cln_fname2;
			string20        cln_mname2;
			string20        cln_lname2;
			string5         cln_suffix2;	
	end;
	
	export numeric_string := '0123456789';
	export alpha_string := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	
	export fPreProcess(dataset(LaborActions_MSHA.Layouts_Mine.Input) pRawFileInput) := FUNCTION
	
		LaborActions_MSHA.Layouts_Mine.Base	trf_Mine(pRawFileInput l)	:=	TRANSFORM
				self.Date_Added								  := IF(l.Date_Added <> ' ',fFixDate(StringLib.StringFilter(l.Date_Added,numeric_string)),l.Date_Added);
			  self.Date_Updated								:= IF(l.Date_Updated <> ' ',fFixDate(StringLib.StringFilter(l.Date_Updated,numeric_string)),l.Date_Updated);
			  self.Website										:= StringLib.StringToUpperCase(l.Website); 
			  self.State											:= StringLib.StringToUpperCase(l.State);		
				self.Mine_Id										:= StringLib.StringToUpperCase(l.Mine_Id);
			  self.Mine_Id_Cleaned						:= IF(StringLib.StringFilter(self.Mine_Id,alpha_string)<>'',self.Mine_Id,(string)(integer4)self.Mine_Id);
			  self.Controller_Id							:= StringLib.StringToUpperCase(l.Controller_Id);
				self.Controller_Id_Cleaned			:= IF (StringLib.StringFilter(self.Controller_Id,alpha_string)<>'',self.Controller_Id,(string)(integer4)self.Controller_Id);			
				self.Operator_Id								:= StringLib.StringToUpperCase(l.Operator_Id);
			  self.Operator_Id_Cleaned				:= IF (StringLib.StringFilter(self.Operator_Id,alpha_string)<>'',self.Operator_Id,(string)(integer4)self.Operator_Id);
			  self.Mine_Name									:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Mine_Name)));
			  self.Coal_or_Metal_Mine					:= StringLib.StringToUpperCase(l.Coal_or_Metal_Mine);
			  self.Mine_Type									:= StringLib.StringToUpperCase(l.Mine_Type);
			  self.Mine_Status								:= StringLib.StringToUpperCase(l.Mine_Status);
			  self.Mine_Status_Date						:= IF(l.Mine_Status_Date <> ' ',fFixDate(StringLib.StringFilter(l.Mine_Status_Date,numeric_string)),l.Mine_Status_Date);								
				self.Controller_Name						:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Controller_Name)));
			  //The next statement adds a semicolon at the end of the Controller Name for those records that have multiple
				//business or person names within the Controller Name field.  This simplifies the normalization of the controller
				//name field.
				self.Controller_Name_Cleaned		:= IF (StringLib.StringFindCount(self.Controller_Name,';')<>0
																							,IF (self.Controller_Name[Length(self.Controller_Name)]=';'
																									,self.Controller_Name
																									,self.Controller_Name+';'
																									)
																							,self.Controller_Name
																							);
				self.Operator_Name							:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Operator_Name)));
				self.Operator_Name_Cleaned			:= IF (StringLib.StringFindCount(self.Operator_Name,';')<>0
																							,IF (self.Operator_Name[Length(self.Operator_Name)]=';'
																									,self.Operator_Name
																									,self.Operator_Name+';'
																									)
																							,self.Operator_Name
																							);
			  self.Mine_State									:= StringLib.StringToUpperCase(l.Mine_State);
			  self.County											:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.County)));
			  self.Begin_Date									:= IF(l.Begin_Date <> ' ',fFixDate(StringLib.StringFilter(l.Begin_Date,numeric_string)),l.Begin_Date);
				self.SIC												:= IF(StringLib.StringFilter(l.SIC,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.SIC),
																								IF ((integer4)l.SIC = 0
																									,''
																									,(string)(integer4)l.SIC
																								)
																							);				
			  self.SIC_Description						:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.SIC_Description)));
				self.Commodity_Code							:= IF(StringLib.StringFilter(l.Commodity_Code,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Commodity_Code),
																								IF ((integer4)l.Commodity_Code = 0
																									,''
																									,(string)(integer4)l.Commodity_Code
																								)
																							);			
			  self.Commodity_Description			:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Commodity_Description)));
				self.NAICS_Code									:= IF(StringLib.StringFilter(l.NAICS_Code,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.NAICS_Code),
																								IF ((integer4)l.NAICS_Code = 0
																									,''
																									,(string)(integer4)l.NAICS_Code
																								)
																							);				
				self.SIC_Code										:= IF(StringLib.StringFilter(l.SIC_Code,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.SIC_Code),
																								IF ((integer4)l.SIC_Code = 0
																									,''
																									,(string)(integer4)l.SIC_Code
																								)
																							);				
				self.Suffix_Code								:= IF(StringLib.StringFilter(l.Suffix_Code,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Suffix_Code),
																								IF ((integer4)l.Suffix_Code = 0
																									,''
																									,(string)(integer4)l.Suffix_Code
																								)
																							);			
				self.Old_SIC_Code								:= IF(StringLib.StringFilter(l.Old_SIC_Code,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Old_SIC_Code),
																								IF ((integer4)l.Old_SIC_Code = 0
																									,''
																									,(string)(integer4)l.Old_SIC_Code
																								)
																							);			
			  self.Activity_Indicator					:= StringLib.StringToUpperCase(l.Activity_Indicator);
			  self.Activity_Date							:= IF (l.Activity_Date <> ' ',fFixDate(StringLib.StringFilter(l.Activity_Date,numeric_string)),l.Activity_Date);
			  self.InActivity_Date						:= IF (l.InActivity_Date='',l.InActivity_Date,ERROR('LaborActions_MSHA.Standardize_Mine-field InActivity_Date is now being populated')); //no records contain data				
				self.Bureau_Mines_State_Code		:= IF(StringLib.StringFilter(l.Bureau_Mines_State_Code,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Bureau_Mines_State_Code),
																								IF ((integer4)l.Bureau_Mines_State_Code = 0
																									,''
																									,(string)(integer4)l.Bureau_Mines_State_Code
																								)
																							);
				self.FIPS_County_Code						:= IF(StringLib.StringFilter(l.FIPS_County_Code,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.FIPS_County_Code),
																								IF ((integer4)l.FIPS_County_Code = 0
																									,''
																									,(string)(integer4)l.FIPS_County_Code
																								)
																							);				
				self.Congress_Dist_Code					:= IF(StringLib.StringFilter(l.Congress_Dist_Code,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Congress_Dist_Code),
																								IF ((integer4)l.Congress_Dist_Code = 0
																									,''
																									,(string)(integer4)l.Congress_Dist_Code
																								)
																							);				
			  self.Company_Type								:= StringLib.StringToUpperCase(l.Company_Type);
			  self.District										:= StringLib.StringToUpperCase(l.District);
			  self.Office_Code								:= StringLib.StringToUpperCase(l.Office_Code);
			  self.Office_Name								:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Office_Name)));
			  self.Assess_Control_No					:= StringLib.StringToUpperCase(l.Assess_Control_No);
				self.SIC_Suffix									:= IF(StringLib.StringFilter(l.SIC_Suffix,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.SIC_Suffix),
																								IF ((integer4)l.SIC_Suffix = 0
																									,''
																									,(string)(integer4)l.SIC_Suffix
																								)
																							);				
				self.Second_SIC_Code						:= IF(StringLib.StringFilter(l.Second_SIC_Code,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Second_SIC_Code),
																								IF ((integer4)l.Second_SIC_Code = 0
																									,''
																									,(string)(integer4)l.Second_SIC_Code
																								)
																							);				
			  self.Second_SIC_Description			:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Second_SIC_Description)));		
				self.Second_SIC_Suffix					:= IF(StringLib.StringFilter(l.Second_SIC_Suffix,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Second_SIC_Suffix),
																								IF ((integer4)l.Second_SIC_Suffix = 0
																									,''
																									,(string)(integer4)l.Second_SIC_Suffix
																								)
																							);			
				self.Second_SIC_Group						:= IF(StringLib.StringFilter(l.Second_SIC_Group,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Second_SIC_Group),
																								IF ((integer4)l.Second_SIC_Group = 0
																									,''
																									,(string)(integer4)l.Second_SIC_Group
																								)
																							);								
				self.Primary_Industry_Group			:= IF(StringLib.StringFilter(l.Primary_Industry_Group,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Primary_Industry_Group),
																								IF ((integer4)l.Primary_Industry_Group = 0
																									,''
																									,(string)(integer4)l.Primary_Industry_Group
																								)
																							);							
			  self.Primary_Industry_Code_Desc := StringLib.StringToUpperCase(l.Primary_Industry_Code_Desc);
				self.Second_Industry_Group			:= IF(StringLib.StringFilter(l.Second_Industry_Group,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Second_Industry_Group),
																								IF ((integer4)l.Second_Industry_Group = 0
																									,''
																									,(string)(integer4)l.Second_Industry_Group
																								)
																							);							
			  self.Second_Industry_Code_Desc	:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Second_Industry_Code_Desc)));
			  self.Classification_Desc				:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Classification_Desc)));						  
				self.Classification_Code				:= IF(StringLib.StringFilter(l.Classification_Code,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Classification_Code),
																								IF ((integer4)l.Classification_Code = 0
																									,''
																									,(string)(integer4)l.Classification_Code
																								)
																							);							
			  self.Classification_Date				:= IF(l.Classification_Date <> ' ',fFixDate(StringLib.StringFilter(l.Classification_Date,numeric_string)),l.Classification_Date);
			  self.Portable_Mine_Indicator		:= IF(l.Portable_Mine_Indicator IN ['Y','N'],l.Portable_Mine_Indicator,'');			
				self.Portable_Mine_FIPS					:= IF(StringLib.StringFilter(l.Portable_Mine_FIPS,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Portable_Mine_FIPS),
																								IF ((integer4)l.Portable_Mine_FIPS = 0
																									,''
																									,(string)(integer4)l.Portable_Mine_FIPS
																								)
																							);														
			  self.Days_Per_Week							:= IF(l.Days_Per_Week BETWEEN '0' AND '7',l.Days_Per_Week,'0');
			  self.Hours_Per_Shift						:= IF(l.Hours_Per_Shift BETWEEN '0' AND '12',l.Hours_Per_Shift,'0');
			  self.Production_Shifts_Per_Day	:= IF(l.Production_Shifts_Per_Day BETWEEN '0' AND '3',l.Production_Shifts_Per_Day,'0');
			  self.Maintenance_Shifts_Per_Day	:= IF(l.Maintenance_Shifts_Per_Day BETWEEN '0' AND '3',l.Maintenance_Shifts_Per_Day,'0');
				Temp_Number_Of_Emp							:= StringLib.StringFilter(l.Number_Of_Emp,numeric_string);
			  self.Number_Of_Emp							:= IF (Temp_Number_Of_Emp<>'',Temp_Number_Of_Emp,'0');				
			  self.Training_Indicator					:= IF(l.Training_Indicator IN ['Y','N'],l.Training_Indicator,'');
			  self.Longitude									:= StringLib.StringFilter(l.Longitude,numeric_string+'.');
			  self.Latitude										:= StringLib.StringFilter(l.Latitude,numeric_string+'.');
			  self.Average_Mine_Height				:= StringLib.StringFilter(l.Average_Mine_Height,numeric_string);
			  self.Mine_Gas_Category					:= StringLib.StringToUpperCase(l.Mine_Gas_Category);
			  self.Methane_Liberation					:= StringLib.StringFilter(l.Methane_Liberation,numeric_string);
			  Temp_No_Of_Producing_Pits				:= StringLib.StringFilter(l.No_Of_Producing_Pits,numeric_string);
			  self.No_Of_Producing_Pits				:= IF (Temp_No_Of_Producing_Pits<>'',Temp_No_Of_Producing_Pits,'0');			
			  Temp_No_Of_Non_Producing_Pits		:= StringLib.StringFilter(l.No_Of_Non_Producing_Pits,numeric_string);
			  self.No_Of_Non_Producing_Pits		:= IF (Temp_No_Of_Non_Producing_Pits<>'',Temp_No_Of_Non_Producing_Pits,'0');		
			  Temp_No_Of_Tailing_Ponds				:= StringLib.StringFilter(l.No_Of_Tailing_Ponds,numeric_string);
			  self.No_Of_Tailing_Ponds				:= IF (Temp_No_Of_Tailing_Ponds<>'',Temp_No_Of_Tailing_Ponds,'0');			
			  self.Pilliar_Recovery_Indicator	:= IF(l.Pilliar_Recovery_Indicator IN ['Y','N'],l.Pilliar_Recovery_Indicator,'');
			  self.Highwall_Mine_Indicator		:= IF(l.Highwall_Mine_Indicator IN ['Y','N'],l.Highwall_Mine_Indicator,'');
			  self.Multiple_Pits_Indicator		:= IF(l.Multiple_Pits_Indicator IN ['Y','N'],l.Multiple_Pits_Indicator,'');
			  self.Miner_Rep_Indicator				:= IF(l.Miner_Rep_Indicator IN ['Y','N'],l.Miner_Rep_Indicator,'');
			  self.Safety_Committee_Indicator	:= IF(l.Safety_Committee_Indicator IN ['Y','N'],l.Safety_Committee_Indicator,'');
				self.Miles_From_Mine						:= IF(StringLib.StringFilter(l.Miles_From_Mine,alpha_string)<>''
																								,StringLib.StringToUpperCase(l.Miles_From_Mine),
																								IF ((integer4)l.Miles_From_Mine = 0
																									,''
																									,(string)(integer4)l.Miles_From_Mine
																								)
																							);					
			  self.Direction_To_Mine					:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Direction_To_Mine)));
			  self.Nearest_Town								:= StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.Nearest_Town)));


				
				
				
		 		self														:= l;
				self														:= [];
		end; //end trf_Mine transform

		dPreProcess	:=	project(pRawFileInput, trf_Mine(left));				
						
		return dPreProcess;

	end; //end fPreProcess function
	
	//This transformation determines whether the data in the Controller_Name is a person or
	//a business name.
	LaborActions_MSHA.Layouts_Mine.Base trfControllerName(Layout_Clean_Name l) := TRANSFORM
		self.Controller_Name_Name_Flag	:= l.name_flag;
		Controller_Cleaned 							:= IF (l.Controller_Name_Name_Flag = 'D'
																					,fFixControllerName(l.Controller_Name_Cleaned)
																					,l.Controller_Name_Cleaned);
		self.Controller_Name_Cleaned 		:= StringLib.StringCleanSpaces(trim(Controller_Cleaned));
		self.Controller_Name_Business		:= IF (l.Controller_Name_Name_Flag <> 'P'
																					,l.Controller_Name_Cleaned
																					,'');
		self.Controller_Name_CLN_FName	:= IF (l.Controller_Name_Name_Flag = 'P'
																					,StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.CLN_FName)))
																					,'');
		self.Controller_Name_CLN_MName	:= IF (l.Controller_Name_Name_Flag = 'P'
																					,StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.CLN_MName)))
																					,'');
		self.Controller_Name_CLN_LName	:= IF (l.Controller_Name_Name_Flag = 'P'
																					,StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.CLN_LName)))
																					,'');
		self.Controller_Name_CLN_Suffix	:= IF (l.Controller_Name_Name_Flag = 'P'
																					,StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.CLN_Suffix)))
																					,'');
		self := l;
		self := [];
	end; //end trfControllerName transform	

	//This transformation determines whether the data in the Operator_Name is a person or
	//a business name.
	LaborActions_MSHA.Layouts_Mine.Base trfOperatorName(Layout_Clean_Name l) := TRANSFORM
		self.Operator_Name_Name_Flag	:= l.name_flag;		
		Operator_Cleaned 							:= IF (l.Operator_Name_Name_Flag = 'D'
																				,IF (fIsBusiness(l.Operator_Name_Cleaned) = false
																						,fFixOperatorName(l.Operator_Name_Cleaned)
																						,l.Operator_Name_Cleaned)
																				,l.Operator_Name_Cleaned);
		self.Operator_Name_Cleaned 		:= StringLib.StringCleanSpaces(trim(Operator_Cleaned));
		self.Operator_Name_Business		:= IF (l.Operator_Name_Name_Flag <> 'P' //Indicates not a person but a busines
																					,l.Operator_Name_Cleaned
																					,'');		
		self.Operator_Name_CLN_FName	:= IF (l.Operator_Name_Name_Flag = 'P' //Indicates a person
																					,StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.CLN_FName)))
																					,'');																					
		self.Operator_Name_CLN_MName	:= IF (l.Operator_Name_Name_Flag = 'P'
																					,StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.CLN_MName)))
																					,'');																					
		self.Operator_Name_CLN_LName	:= IF (l.Operator_Name_Name_Flag = 'P'
																					,StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.CLN_LName)))
																					,'');																				
		self.Operator_Name_CLN_Suffix	:= IF (l.Operator_Name_Name_Flag = 'P'
																					,StringLib.StringCleanSpaces(trim(StringLib.StringToUpperCase(l.CLN_Suffix)))
																					,'');																				
		self := l;
		self := [];
	end; //end trfOperatorName transform	

	LaborActions_MSHA.Layouts_Mine.Base	Normalize_Controller_Name(LaborActions_MSHA.Layouts_Mine.Base l, integer c)	:=	TRANSFORM
			Pos_of_Semicolon 							:= StringLib.StringFind(l.Controller_Name_Cleaned,';',c);
			Pos_of_Prev_Semicolon					:= IF (c=1,0,StringLib.StringFind(l.Controller_Name_Cleaned,';',c-1));
			self.Controller_Name_Cleaned 	:= StringLib.StringCleanSpaces(trim(l.Controller_Name_Cleaned[Pos_of_Prev_Semicolon+1..Pos_of_Semicolon-1]));
			self 													:= l;
	end; //end Normalize_Controller_Name transform	

	//This transform function normalizes of the operator name field.
	LaborActions_MSHA.Layouts_Mine.Base	Normalize_Operator_Name(LaborActions_MSHA.Layouts_Mine.Base l, integer c)	:=	TRANSFORM
			Pos_of_Semicolon 						:= StringLib.StringFind(l.Operator_Name_Cleaned,';',c);
			Pos_of_Prev_Semicolon				:= IF (c=1,0,StringLib.StringFind(l.Operator_Name_Cleaned,';',c-1));
			self.Operator_Name_Cleaned 	:= StringLib.StringCleanSpaces(trim(l.Operator_Name_Cleaned[Pos_of_Prev_Semicolon+1..Pos_of_Semicolon-1]));
			self 												:= l;
	end; //end Normalize_Operator_Name transform	
	
	export fAll( dataset(LaborActions_MSHA.Layouts_Mine.Input) pRawFileInput) := function

		dPreprocess	 			 := fPreProcess(pRawFileInput);

		//Call Mac_Is_Business and determine whether the Controller_Name is a Business or Person's name.
		Address.Mac_Is_Business(dPreprocess,Controller_Name_Cleaned,Clean_Controller_Name1,name_flag,false,true );	
		//Populate LaborActions_MSHA.Layouts_Mine.Base fields with cln_* fields
		dNameClean1 := project(Clean_Controller_Name1,transform(Layout_Clean_Name,self := left;self := []));
		//Populate Controller fields in LaborActions_MSHA.Layouts_Mine.Base with cln_* fields
		dNameTrf1		:= project(dNameClean1,trfControllerName(LEFT));

		//Call Mac_Is_Business and determine whether the Operator_Name is a Business or Person's name.
		Address.Mac_Is_Business(dNameTrf1,Operator_Name_Cleaned,Clean_Operator_Name1,name_flag,false,true );
		//Populate LaborActions_MSHA.Layouts_Mine.Base fields with cln_* fields
		dNameClean2 := project(Clean_Operator_Name1,transform(Layout_Clean_Name,self := left;self := []));
		//Populate Operator fields in LaborActions_MSHA.Layouts_Mine.Base with cln_* fields		
		dNameTrf2		:= project(dNameClean2,trfOperatorName(LEFT));

		//Filter out those records that DO NOT need to be normalized; only Mine records where
		//there are single business names or people names in the Controller_Name_Cleaned field
		dNotNormCName 		 := dNameTrf2(StringLib.StringFindCount(Controller_Name_Cleaned,';')=0);  
		//Filter out those records that DO need to be normalized; only Mine records where
		//there are multiple business names or people names in the Controller_Name_Cleaned field
		dNormProcessCName	 := dNameTrf2(StringLib.StringFindCount(Controller_Name_Cleaned,';')<>0);
		//Normalize those records that have multiple business names or people names in the Controller_Name_Cleaned field
		dNormCName		 		 := Normalize(dNormProcessCName,StringLib.StringFindCount(left.Controller_Name_Cleaned,';'),Normalize_Controller_Name(left,counter));
		dCNameTemp	 			 := dNormCName + dNotNormCName;

		//Filter out those records that do not need to be normalized; only Mine records where
		//there are single business names or people names in the Operator_Name_Cleaned field
		dNotNormOName 		 := dCNameTemp(StringLib.StringFindCount(Operator_Name_Cleaned,';')=0);  
		//Filter out those records that do need to be normalized; only Mine records where
		//there are multiple business names or people names in the Operator_Name_Cleaned field
		dNormProcessOName	 := dCNameTemp(StringLib.StringFindCount(Operator_Name_Cleaned,';')<>0);		
		//Normalize those records that have multiple business names or people names in the Operator_Name_Cleaned field
		dNormOName 	 			 := Normalize(dNormProcessOName,StringLib.StringFindCount(left.Operator_Name_Cleaned,';'),Normalize_Operator_Name(left,counter));
		dONameTemp				 := dNormOName + dNotNormOName;		
	
		//Call Mac_Is_Business and determine whether the Controller_Name is a Business or Person's name.
		Address.Mac_Is_Business(dONameTemp,Controller_Name_Cleaned,Clean_Controller_Name2,name_flag,false,true );	
		//Populate LaborActions_MSHA.Layouts_Mine.Base fields with cln_* fields
		dNameClean3 			:= project(Clean_Controller_Name2,transform(Layout_Clean_Name,self := left;self := []));
		//Populate Controller fields in LaborActions_MSHA.Layouts_Mine.Base with cln_* fields
		dNameTrf3					:= project(dNameClean3,trfControllerName(LEFT));

		//Call Mac_Is_Business and determine whether the Operator_Name is a Business or Person's name.
		Address.Mac_Is_Business(dNameTrf3,Operator_Name_Cleaned,Clean_Operator_Name2,name_flag,false,true );
		//Populate LaborActions_MSHA.Layouts_Mine.Base fields with cln_* fields
		dNameClean4 			:= project(Clean_Operator_Name2,transform(Layout_Clean_Name,self := left;self := []));
		//Populate Operator fields in LaborActions_MSHA.Layouts_Mine.Base with cln_* fields		
		dNameTrf4					:= project(dNameClean4,trfOperatorName(LEFT));

		dMineBase					:= dNameTrf4 : persist(_dataset().thor_cluster_Persists + 'persist::LaborActions_MSHA::Standardize_Mine');

		return dMineBase;
				
	end; //end fAll

end; //end Standardize_Mine