IMPORT	ut, AID, iBehavior, DID_Add, header_slimsort, address, lib_StringLib, idl_header, NID, PromoteSupers;
																							
EXPORT proc_build_base(STRING version) := FUNCTION
#workunit('name', 'iBehavior Build' + version);

pre_build := sequential(fileservices.addsuperfile('~thor_data400::in::ibehavior_using','~thor_data400::in::ibehavior::'+version+'::00');
												fileservices.addsuperfile('~thor_data400::in::ibehavior_using','~thor_data400::in::ibehavior::'+version+'::01');
												fileservices.addsuperfile('~thor_data400::in::ibehavior_using','~thor_data400::in::ibehavior::'+version+'::02');
												fileservices.addsuperfile('~thor_data400::in::ibehavior_using','~thor_data400::in::ibehavior::'+version+'::03');
												fileservices.addsuperfile('~thor_data400::in::ibehavior_using','~thor_data400::in::ibehavior::'+version+'::04');
												fileservices.addsuperfile('~thor_data400::in::ibehavior_using','~thor_data400::in::ibehavior::'+version+'::05');
												fileservices.addsuperfile('~thor_data400::in::ibehavior_using','~thor_data400::in::ibehavior::'+version+'::06');
												fileservices.addsuperfile('~thor_data400::in::ibehavior_using','~thor_data400::in::ibehavior::'+version+'::07');
												IF(version = '20090101',fileservices.addsuperfile('~thor_data400::in::ibehavior_using','~thor_data400::in::ibehavior::'+version+'::08'),
												OUTPUT('File does not exists')));
												
	//Validate Title
	setValidTitle:=['MR','MS'];
	string fGetTitle(string TitleIn)		:=		map(TitleIn in setValidTitle => TitleIn
																								,'');
	//Validate Suffix																			
	setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
	string fGetSuffix(string SuffixIn)	:=		map(SuffixIn = '1' => 'I'
																								,SuffixIn in ['2','ND'] => 'II'
																								,SuffixIn in ['3','RD'] => 'III'
																								,SuffixIn = '4' => 'IV'
																								,SuffixIn = '5' => 'V'
																								,SuffixIn = '6' => 'VI'
																								,SuffixIn = '7' => 'VII'
																								,SuffixIn = '8' => 'VIII'
																								,SuffixIn = '9' => 'IX'
																								,SuffixIn in setValidSuffix => SuffixIn
																								,'');

  filtered_suffix := ['CEO','MBA','PA','PE'];


	layout_base_tmp := RECORD
		iBehavior.layouts.Layout_base;
		string5 tmp_name_suffix;
	END;
	
	
	layout_base_tmp tFormatInFileFields(layouts.Layout_in pInput) := TRANSFORM
		self.Last_Name																	:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Last_Name));
		self.First_Name																	:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.First_Name));
		self.Middle_Initial															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Middle_Initial));
		self.Maturity_Title															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Maturity_Title));
		self.tmp_name_suffix														:= if(trim(self.Maturity_Title) in filtered_suffix,'',self.Maturity_Title);
		self.Title																			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Title));
		self.CO_Address																	:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.CO_Address));
		self.Apt_No																			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Apt_No));
		self.Address_Line1															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Address_Line1));
		self.Address_Line2															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Address_Line2));
		self.City																				:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.City));
		self.State																			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.State));
		self.Zip_Code																		:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Zip_Code));
		self.Zip_4																			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Zip_4));
		self.Gender_Code																:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Gender_Code));
		self.IB_Individual_ID														:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.IB_Individual_ID));
		self.IB_Household_ID														:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.IB_Household_ID));
		self.First_Order_Date														:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.First_Order_Date));
		self.Last_Order_Date														:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Last_Order_Date));
		self.First_Online_Order_Date										:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.First_Online_Order_Date));
		self.Last_Online_Order_Date											:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Last_Online_Order_Date));
		self.First_Offline_Order_Date										:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.First_Offline_Order_Date));
		self.Last_Offline_Order_Date										:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Last_Offline_Order_Date));
		self.First_Retail_Order_Date										:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.First_Retail_Order_Date));
		self.Last_Retail_Order_Date											:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Last_Retail_Order_Date));
		self.number_of_sources													:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.number_of_sources));
		self.Total_Number_of_Orders											:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Total_Number_of_Orders));
		self.Total_Dollars															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Total_Dollars));
		self.Online_Orders															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Online_Orders));
		self.Online_Dollars															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Online_Dollars));
		self.Offline_Orders															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Offline_Orders));
		self.Offline_Dollars														:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Offline_Dollars));
		self.Retail_Orders															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Retail_Orders));
		self.Retail_Dollars															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Retail_Dollars));
		self.Average_Days_Between_Orders								:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Average_Days_Between_Orders));
		self.Average_Days_Between_Online_Orders					:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Average_Days_Between_Online_Orders));
		self.Average_Days_Between_Offline_Orders				:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Average_Days_Between_Offline_Orders));
		self.Average_Days_Between_Retail_Orders					:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Average_Days_Between_Retail_Orders));
		self.Average_Amount_Per_Order										:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Average_Amount_Per_Order));
		self.Online_Average_Amount_Per_Order						:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Online_Average_Amount_Per_Order));
		self.Offline_Average_Amount_Per_Order						:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Offline_Average_Amount_Per_Order));
		self.Retail_Average_Amount_Per_Order						:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Retail_Average_Amount_Per_Order));
		self.Online_Orders_Under_50_Range								:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Online_Orders_Under_50_Range));
		self.Online_Orders_50_to_99_dot_99_Range				:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Online_Orders_50_to_99_dot_99_Range));
		self.Online_Orders_100_to_249_dot_99_Range			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Online_Orders_100_to_249_dot_99_Range));
		self.Online_Orders_250_to_499_dot_99_Range			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Online_Orders_250_to_499_dot_99_Range));
		self.Online_Orders_500_to_999_dot_99_Range			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Online_Orders_500_to_999_dot_99_Range));
		self.Online_Orders_1000_plus_Range							:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Online_Orders_1000_plus_Range));
		self.Offline_Orders_Under_50_Range							:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Offline_Orders_Under_50_Range));
		self.Offline_Orders_50_to_99_dot_99_Range				:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Offline_Orders_50_to_99_dot_99_Range));
		self.Offline_Orders_100_to_249_dot_99_Range			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Offline_Orders_100_to_249_dot_99_Range));
		self.Offline_Orders_250_to_499_dot_99_Range			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Offline_Orders_250_to_499_dot_99_Range));
		self.Offline_Orders_500_to_999_dot_99_Range			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Offline_Orders_500_to_999_dot_99_Range));
		self.Offline_Orders_1000_plus_Range							:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Offline_Orders_1000_plus_Range));
		self.Retail_Orders_Under_50_Range								:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Retail_Orders_Under_50_Range));
		self.Retail_Orders_50_to_99_dot_99_Range				:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Retail_Orders_50_to_99_dot_99_Range));
		self.Retail_Orders_100_to_249_dot_99_Range			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Retail_Orders_100_to_249_dot_99_Range));
		self.Retail_Orders_250_to_499_dot_99_Range			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Retail_Orders_250_to_499_dot_99_Range));
		self.Retail_Orders_500_to_999_dot_99_Range			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Retail_Orders_500_to_999_dot_99_Range));
		self.Retail_Orders_1000_plus_Range							:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Retail_Orders_1000_plus_Range));
		self.Weeks_Since_Last_Order_Apparel_General			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Apparel_General));
		self.Weeks_Since_Last_Order_Novelty							:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Novelty));
		self.Weeks_Since_Last_Order_Books								:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Books));
		self.Weeks_Since_Last_Order_Childrens_Products	:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Childrens_Products));
		self.Weeks_Since_Last_Order_Crafts_or_Hobbies		:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Crafts_or_Hobbies));
		self.Weeks_Since_Last_Order_Gift								:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Gift));
		self.Weeks_Since_Last_Order_Holiday_Items				:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Holiday_Items));
		self.Weeks_Since_Last_Order_Specialty_Gifts			:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Specialty_Gifts));
		self.Weeks_Since_Last_Order_Home_Furnishings		:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Home_Furnishings));
		self.Weeks_Since_Last_Order_Housewares					:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Housewares));
		self.Weeks_Since_Last_Order_Homecare						:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Homecare));
		self.Weeks_Since_Last_Order_Garden							:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Garden));
		self.Weeks_Since_Last_Order_Sports_and_Leiser		:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Sports_and_Leiser));
		self.Weeks_Since_Last_Order_Travel							:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Weeks_Since_Last_Order_Travel));
		self.Orders_Apparel_General											:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Apparel_General));
		self.Orders_Novelty															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Novelty));
		self.Orders_Books																:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Books));
		self.Orders_Childrens_Products									:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Childrens_Products));
		self.Orders_Crafts_or_Hobbies 									:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Crafts_or_Hobbies));
		self.Orders_Gift 																:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Gift));
		self.Orders_Holiday_Items 											:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Holiday_Items));
		self.Orders_Specialty_Gifts											:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Specialty_Gifts));
		self.Orders_Home_Furnishings										:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Home_Furnishings));
		self.Orders_Housewares													:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Housewares));
		self.Orders_Homecare														:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Homecare));
		self.Orders_Garden															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Garden));
		self.Orders_Sports_and_Leiser										:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Sports_and_Leiser));
		self.Orders_Travel															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Orders_Travel));
		self.Dollars_Apparel_General										:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Apparel_General));
		self.Dollars_Novelty														:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Novelty));
		self.Dollars_Books															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Books));
		self.Dollars_Childrens_Products									:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Childrens_Products));
		self.Dollars_Crafts_or_Hobbies									:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Crafts_or_Hobbies));
		self.Dollars_Gift																:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Gift));
		self.Dollars_Holiday_Items											:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Holiday_Items));
		self.Dollars_Specialty_Gifts										:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Specialty_Gifts));
		self.Dollars_Home_Furnishings										:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Home_Furnishings));
		self.Dollars_Housewares													:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Housewares));
		self.Dollars_Homecare														:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Homecare));
		self.Dollars_Garden															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Garden));
		self.Dollars_Sports_and_Leiser									:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Sports_and_Leiser));
		self.Dollars_Travel															:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Dollars_Travel));
		self.Email_Address_1														:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Email_Address_1));
		self.Email_Address_2														:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Email_Address_2));
		self.Email_Address_3														:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Email_Address_3));
		self.Primary_Phone_Number												:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Primary_Phone_Number));
		self.Secondary_Phone_Number											:= StringLib.StringToUpperCase(StringLib.StringCleanSpaces(pInput.Secondary_Phone_Number));
		self.Process_Date 															:= thorlib.wuid()[2..9];
		self.date_first_seen														:= version;
		self.date_last_seen															:= version;
		self.Date_Vendor_First_Reported									:= version;
		self.Date_Vendor_Last_Reported									:= version;
		self																						:= pInput;
		self																						:= [];
	END;

	FormattedInputFile	:= PROJECT(files.File_in, tFormatInFileFields(LEFT));
	

//Append Record ID
layout_base_tmp			tAppendRecordID(FormattedInputFile pInput)	:=
	transform
		self.persistent_record_id := HASH64(TRIM(pInput.Last_Name)
																				+ TRIM(pInput.First_Name)
																				+ TRIM(pInput.Middle_Initial)
																				+ TRIM(pInput.Maturity_Title)
																				+ TRIM(pInput.Title)
																				+ TRIM(pInput.CO_Address)
																				+ TRIM(pInput.Apt_No)
																				+ TRIM(pInput.Address_Line1)
																				+ TRIM(pInput.Address_Line2)
																				+ TRIM(pInput.City)
																				+ TRIM(pInput.State)
																				+ TRIM(pInput.Zip_Code)
																				+ TRIM(pInput.Zip_4)	
																				+ TRIM(pInput.Gender_Code)
																				+ TRIM(pInput.IB_Individual_ID)
																				+ TRIM(pInput.IB_Household_ID)	
																				+ TRIM(pInput.First_Order_Date)
																				+ TRIM(pInput.Last_Order_Date)
																				+ TRIM(pInput.First_Online_Order_Date)
																				+ TRIM(pInput.Last_Online_Order_Date)
																				+ TRIM(pInput.First_Offline_Order_Date)
																				+ TRIM(pInput.Last_Offline_Order_Date)
																				+ TRIM(pInput.First_Retail_Order_Date)
																				+ TRIM(pInput.Last_Retail_Order_Date)
																				+ TRIM(pInput.number_of_sources)
																				+ TRIM(pInput.Total_Number_of_Orders)
																				+ TRIM(pInput.Total_Dollars)
																				+ TRIM(pInput.Online_Orders)
																				+ TRIM(pInput.Online_Dollars)
																				+ TRIM(pInput.Offline_Orders)
																				+ TRIM(pInput.Offline_Dollars)
																				+ TRIM(pInput.Retail_Orders)
																				+ TRIM(pInput.Retail_Dollars)
																				+ TRIM(pInput.Average_Days_Between_Orders)
																				+ TRIM(pInput.Average_Days_Between_Online_Orders)
																				+ TRIM(pInput.Average_Days_Between_Offline_Orders)
																				+ TRIM(pInput.Average_Days_Between_Retail_Orders)
																				+ TRIM(pInput.Average_Amount_Per_Order)
																				+ TRIM(pInput.Online_Average_Amount_Per_Order)
																				+ TRIM(pInput.Offline_Average_Amount_Per_Order)
																				+ TRIM(pInput.Retail_Average_Amount_Per_Order)
																				+ TRIM(pInput.Online_Orders_Under_50_Range)
																				+ TRIM(pInput.Online_Orders_50_to_99_dot_99_Range)
																				+ TRIM(pInput.Online_Orders_100_to_249_dot_99_Range)
																				+ TRIM(pInput.Online_Orders_250_to_499_dot_99_Range)
																				+ TRIM(pInput.Online_Orders_500_to_999_dot_99_Range)
																				+ TRIM(pInput.Online_Orders_1000_plus_Range)
																				+ TRIM(pInput.Offline_Orders_Under_50_Range)
																				+ TRIM(pInput.Offline_Orders_50_to_99_dot_99_Range)
																				+ TRIM(pInput.Offline_Orders_100_to_249_dot_99_Range)
																				+ TRIM(pInput.Offline_Orders_250_to_499_dot_99_Range)
																				+ TRIM(pInput.Offline_Orders_500_to_999_dot_99_Range)
																				+ TRIM(pInput.Offline_Orders_1000_plus_Range)
																				+ TRIM(pInput.Retail_Orders_Under_50_Range)
																				+ TRIM(pInput.Retail_Orders_50_to_99_dot_99_Range)
																				+ TRIM(pInput.Retail_Orders_100_to_249_dot_99_Range)
																				+ TRIM(pInput.Retail_Orders_250_to_499_dot_99_Range)
																				+ TRIM(pInput.Retail_Orders_500_to_999_dot_99_Range)
																				+ TRIM(pInput.Retail_Orders_1000_plus_Range)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Apparel_General)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Novelty)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Books)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Childrens_Products)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Crafts_or_Hobbies)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Gift)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Holiday_Items)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Specialty_Gifts)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Home_Furnishings)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Housewares)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Homecare)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Garden)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Sports_and_Leiser)
																				+ TRIM(pInput.Weeks_Since_Last_Order_Travel)
																				+ TRIM(pInput.Orders_Apparel_General)			
																				+ TRIM(pInput.Orders_Novelty)
																				+ TRIM(pInput.Orders_Books)
																				+ TRIM(pInput.Orders_Childrens_Products)
																				+ TRIM(pInput.Orders_Crafts_or_Hobbies)
																				+ TRIM(pInput.Orders_Gift)
																				+ TRIM(pInput.Orders_Holiday_Items)
																				+ TRIM(pInput.Orders_Specialty_Gifts)
																				+ TRIM(pInput.Orders_Home_Furnishings)
																				+ TRIM(pInput.Orders_Housewares)
																				+ TRIM(pInput.Orders_Homecare)
																				+ TRIM(pInput.Orders_Garden)
																				+ TRIM(pInput.Orders_Sports_and_Leiser)
																				+ TRIM(pInput.Orders_Travel)
																				+ TRIM(pInput.Dollars_Apparel_General)
																				+ TRIM(pInput.Dollars_Novelty)
																				+ TRIM(pInput.Dollars_Books)
																				+ TRIM(pInput.Dollars_Childrens_Products)
																				+ TRIM(pInput.Dollars_Crafts_or_Hobbies)
																				+ TRIM(pInput.Dollars_Gift)
																				+ TRIM(pInput.Dollars_Holiday_Items)
																				+ TRIM(pInput.Dollars_Specialty_Gifts)
																				+ TRIM(pInput.Dollars_Home_Furnishings)
																				+ TRIM(pInput.Dollars_Housewares)
																				+ TRIM(pInput.Dollars_Homecare)
																				+ TRIM(pInput.Dollars_Garden)
																				+ TRIM(pInput.Dollars_Sports_and_Leiser)
																				+ TRIM(pInput.Dollars_Travel)
																				+ TRIM(pInput.Email_Address_1)
																				+ TRIM(pInput.Email_Address_2)
																				+ TRIM(pInput.Email_Address_3)
																				+ TRIM(pInput.Primary_Phone_Number)
																				+ TRIM(pInput.Secondary_Phone_Number)
																							);
		
		self								:=	pInput;
	end;
	
	dBehavior_RecordID	:=	project(FormattedInputFile,tAppendRecordID(left));	
	
	//Process consumer file
	NID.Mac_CleanParsedNames(dBehavior_RecordID, rsFileClnName, 
													firstname:=First_Name, middlename:=Middle_Initial, lastname:=Last_Name, namesuffix := tmp_name_suffix,
													 includeInRepository:=true, normalizeDualNames:=true);
	
	//Process consumer file
	 InputFileClnName  := PROJECT(rsFileClnName, TRANSFORM(iBehavior.layouts.Layout_consumer,
																											self.nameid	:= left.nid;
																											self.prefix				:=	left.cln_title;
																											self.fname				:=	left.cln_fname;
																											self.mname				:=	left.cln_mname;
																											self.lname				:=	left.cln_lname;
																											self.name_suffix	:=	left.cln_suffix;
																											SELF := LEFT));
	
	
	BOOLEAN consumerfileexists	:=	nothor(fileservices.GetSuperFileSubCount(thor_cluster + 'base::iBehavior_consumer')) > 0;
	
	ConsumerBasePlusIn	:=	IF(consumerfileexists, InputFileClnName + files.File_consumer, InputFileClnName);
	
	BasePlusInDist	:=	SORT(DISTRIBUTE(ConsumerBasePlusIn, HASH(IB_Individual_ID
																										 + first_name
																										 + Last_Name
																										 + First_Name
																										 + Address_Line1
																										 + City
																										 + Email_Address_1 + Email_Address_2 + Email_Address_3
																										 + Primary_Phone_Number
																										 + Secondary_Phone_Number)), 
																										 IB_Individual_ID
																										 + first_name
																										 + Last_Name
																										 + First_Name
																										 + Address_Line1
																										 + City
																										 + Email_Address_1 + Email_Address_2 + Email_Address_3
																										 + Primary_Phone_Number
																										 + Secondary_Phone_Number
																										 , -IB_Individual_ID, LOCAL);
	
	layouts.Layout_consumer  rollupXform(layouts.Layout_consumer L, layouts.Layout_consumer R) := transform
		self.Process_Date    := if(L.Process_Date > R.Process_Date, L.Process_Date, R.Process_Date);
		self.date_first_seen := if(L.date_first_seen > R.date_first_seen, R.date_first_seen, L.date_first_seen);
		self.date_last_seen  := if(L.date_last_seen  < R.date_last_seen,  R.date_last_seen, L.date_last_seen);
		self.Date_Vendor_First_Reported := if(L.Date_Vendor_First_Reported > R.Date_Vendor_First_Reported, R.Date_Vendor_First_Reported, L.Date_Vendor_First_Reported);
		self.Date_Vendor_Last_Reported  := if(L.Date_Vendor_Last_Reported  < R.Date_Vendor_Last_Reported,  R.Date_Vendor_Last_Reported, L.Date_Vendor_Last_Reported);		
		self := L; 
	end;
	
	BasePlusInRollup := ROLLUP(BasePlusInDist,rollupXform(LEFT,RIGHT),
														 LEFT.IB_Individual_ID = RIGHT.IB_Individual_ID
															AND LEFT.First_Name = RIGHT.First_Name
															AND LEFT.Last_Name = RIGHT.Last_Name
															AND LEFT.Address_Line1 = RIGHT.Address_Line1
															AND LEFT.City = RIGHT.City
															AND (LEFT.Primary_Phone_Number != '' AND RIGHT.Primary_Phone_Number = '' OR (LEFT.Primary_Phone_Number = RIGHT.Primary_Phone_Number AND LEFT.Primary_Phone_Number != '') OR LEFT.Primary_Phone_Number = '' AND RIGHT.Primary_Phone_Number = '')
															AND (LEFT.Secondary_Phone_Number != '' AND RIGHT.Secondary_Phone_Number = '' OR (LEFT.Secondary_Phone_Number = RIGHT.Secondary_Phone_Number AND LEFT.Secondary_Phone_Number != '') OR LEFT.Secondary_Phone_Number = '' AND RIGHT.Secondary_Phone_Number = '')
																	, LOCAL);	

	unitMatchRegexString	:=	'#|APARTMENT|APT|BASEMENT|BLDG|BSMT|BUILDING|DEPARTMENT|DEPT|FL|FLOOR|FRNT|FRONT|HANGER|HNGR|KEY|LBBY|LOBBY|LOT|LOWER|LOWR|OFC|OFFICE|PENTHOUSE|PH|PIER|REAR|RM|ROOM|SIDE|SLIP|SPACE|SPC|STE|STOP|SUITE|TRAILER|TRLR|UNIT|UPPER|UPPR';
	DBApattern	:= '^(.*)(DBA - |DBA | DBA:|D/B/A:| D/B/A |D/B/A | DBA| D/B/A|C/O |C/0 |ATTN:|ATT:|ATTN - |ATTN |ATTENTION:|ATN:|AKA | AKA|A/K/A | A/K/A|T/A )(.*)';
		
	layouts.Layout_consumer tProjectAIDClean_prep(layouts.Layout_consumer pInput) := TRANSFORM
		nonblank_addr1_bogus		:= If(ibehavior.BogusAddress(trim(pInput.address_line1)),'',pInput.Address_Line1);
		nonblank_addr2_bogus		:= If(ibehavior.BogusAddress(trim(pInput.address_line2)),'',pInput.Address_Line2);
		nonblank_apt_bogus			:= If(ibehavior.BogusAddress(trim(pInput.apt_no)),'',pInput.apt_no);
		temp_addr1	:= IF(regexfind(DBApattern,nonblank_addr1_bogus), ibehavior.mod_clean_name_addr.GetCorpName(nonblank_addr1_bogus),nonblank_addr1_bogus);		
		temp_addr2	:= If(regexfind(DBApattern,nonblank_addr1_bogus), ibehavior.mod_clean_name_addr.GetCorpName(nonblank_addr2_bogus),nonblank_addr2_bogus);
		temp_apt		:= If(regexfind(DBApattern,nonblank_apt_bogus), ibehavior.mod_clean_name_addr.GetCorpName(nonblank_apt_bogus),nonblank_apt_bogus);	
		
		self.Append_Prep_Address					:=	IF(REGEXFIND(unitMatchRegexString,temp_addr1) and not regexfind(unitMatchRegexString,temp_addr2)
																								and regexfind('[^0-9]$',trim(temp_addr2)) and temp_addr2 != ''
																								and stringlib.stringfind(trim(temp_addr2),' ',1) >0,	
																										Address.fn_addr_clean_prep(temp_addr2 + temp_addr1 
																											+ if(regexfind(unitMatchRegexString,temp_apt),temp_apt,''), 'first'),
																							IF(REGEXFIND(unitMatchRegexString,temp_addr1) and temp_addr2 = '',	
																											Address.fn_addr_clean_prep(temp_apt + temp_addr1, 'first'),
																													Address.fn_addr_clean_prep(temp_addr1 + temp_addr2
																															+ if(regexfind(unitMatchRegexString,temp_apt),temp_apt,''), 'first')
																									));
	
		self.Append_Prep_Address_Last			:=	Address.fn_addr_clean_prep(pInput.city
																								+	IF(pInput.city <> '',', ','') + pInput.state
																								+	' ' + pInput.zip_code, 'last');
		self.phone_1											:=	ut.CleanPhone(pInput.Primary_Phone_Number);
		self.phone_2											:=	ut.CleanPhone(pInput.Secondary_Phone_Number);
		self := pInput;
	END;
	
	rsAIDClean_prep	:= PROJECT(BasePlusInRollup ,tProjectAIDClean_prep(LEFT));
	
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	
	AID.MacAppendFromRaw_2Line(rsAIDClean_prep,Append_Prep_Address, Append_Prep_Address_Last, RawAID,
																											rsCleanAID, lAIDFlags);
			
	layouts.Layout_consumer tProjectClean(rsCleanAID pInput) := TRANSFORM
	  SELF.prim_range           := pInput.aidwork_acecache.prim_range;
    SELF.predir               := pInput.aidwork_acecache.predir;
    SELF.prim_name            := pInput.aidwork_acecache.prim_name;
    SELF.addr_suffix          := pInput.aidwork_acecache.addr_suffix;
    SELF.postdir              := pInput.aidwork_acecache.postdir;
    SELF.unit_desig           := pInput.aidwork_acecache.unit_desig;
    SELF.sec_range            := pInput.aidwork_acecache.sec_range;
    SELF.p_city_name          := pInput.aidwork_acecache.p_city_name;
    SELF.v_city_name          := pInput.aidwork_acecache.v_city_name;
    SELF.st                   := pInput.aidwork_acecache.st;
    SELF.zip5                 := pInput.aidwork_acecache.zip5;
    SELF.zip4                 := pInput.aidwork_acecache.zip4;
    SELF.cart                 := pInput.aidwork_acecache.cart;
    SELF.cr_sort_sz           := pInput.aidwork_acecache.cr_sort_sz;
    SELF.lot                  := pInput.aidwork_acecache.lot;
    SELF.lot_order            := pInput.aidwork_acecache.lot_order;
    SELF.dbpc                 := pInput.aidwork_acecache.dbpc;
    SELF.chk_digit            := pInput.aidwork_acecache.chk_digit;
    SELF.rec_type             := pInput.aidwork_acecache.rec_type;
    SELF.county               := pInput.aidwork_acecache.county;
		SELF.ace_fips_st					:= pInput.aidwork_acecache.county[1..2];
		SELF.fips_county					:= pInput.aidwork_acecache.county[3..5];
    SELF.geo_lat              := pInput.aidwork_acecache.geo_lat;
    SELF.geo_long             := pInput.aidwork_acecache.geo_long;
    SELF.msa                  := pInput.aidwork_acecache.msa;
    SELF.geo_blk              := pInput.aidwork_acecache.geo_blk;
    SELF.geo_match            := pInput.aidwork_acecache.geo_match;
    SELF.err_stat             := pInput.aidwork_acecache.err_stat;
    SELF.rawaid          			:= pInput.aidwork_rawaid;
    SELF  													:= pInput;		
	END;
	
	rsCleanAIDParsed		:= PROJECT(rsCleanAID, tProjectClean(LEFT));
	
	// ut.MAC_SF_BuildProcess(rsAIDClean_prep, thor_cluster + 'base::iBehavior_consumer_test', build_consumer_base, 3, /*csvout*/false, /*compress*/true);
	
	//Flip names before DID process
	ut.mac_flipnames(rsCleanAIDParsed,fname,mname,lname,rsAIDCleanFlipNames);
	
	matchset :=['A','P','Z'];

	did_Add.MAC_Match_Flex(rsAIDCleanFlipNames, matchset,
													foo, foo, fname, mname, lname, name_suffix, 
													prim_range, prim_name, sec_range, zip5, st, phone_1,
													DID,   			
													layouts.Layout_consumer, 
													true, DID_score,	//these should default to zero in definition
													75,	  //dids with a score below here will be dropped 
													rsCleanAID_DID);

	PromoteSupers.MAC_SF_BuildProcess(rsCleanAID_DID, thor_cluster + 'base::iBehavior_consumer', build_consumer_base, 3, /*csvout*/false, /*compress*/true);
	
	//Process behavior file
	rsBehavior_in								:=	PROJECT(dBehavior_RecordID, layouts.Layout_behavior);
	BOOLEAN behaviorfileexists	:=	nothor(fileservices.GetSuperFileSubCount(thor_cluster + 'base::iBehavior_behavior')) > 0;
	BehaviorBasePlusIn					:=	IF(behaviorfileexists, rsBehavior_in + files.File_behavior, rsBehavior_in);

	layouts.Layout_behavior  BehaviorRollupXform(layouts.Layout_behavior L, layouts.Layout_behavior R) := transform
		self.Process_Date    := if(L.Process_Date > R.Process_Date, L.Process_Date, R.Process_Date);
		self.date_first_seen := if(L.date_first_seen > R.date_first_seen, R.date_first_seen, L.date_first_seen);
		self.date_last_seen  := if(L.date_last_seen  < R.date_last_seen,  R.date_last_seen, L.date_last_seen);
		self := L; 
	end;	
	
	BehaviorBasePlusInRollup := ROLLUP(SORT(BehaviorBasePlusIn,IB_Individual_ID,IB_Household_ID,First_Order_Date,date_first_seen), BehaviorRollupXform(LEFT,RIGHT), EXCEPT process_date, date_first_seen, date_last_seen);		
	
	PromoteSupers.MAC_SF_BuildProcess(BehaviorBasePlusInRollup, thor_cluster + 'base::iBehavior_behavior', build_behavior_base, 3, /*csvout*/false, /*compress*/true);
	
	post_build := sequential(
													fileservices.startsuperfiletransaction(),
													fileservices.clearsuperfile('~thor_data400::in::ibehavior_using'),
													fileservices.finishsuperfiletransaction()
													);	
			
	RETURN sequential(
                    pre_build,
										parallel(build_consumer_base, build_behavior_base),
										post_build);
											
	
END;