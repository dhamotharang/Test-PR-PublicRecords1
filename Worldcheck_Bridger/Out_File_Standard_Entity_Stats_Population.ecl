#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import ut, strata;

export Out_File_Standard_Entity_Stats_Population (string filedate) := function
	
//MAIN FILE//////////////////////////////////////////////////////////////////////	
	//Flatten MAIN File

	aka_rollup := RECORD
	   string id;
	   DATASET(Layout_Aliases) aka{xpath('AKA')};
	  END;

	layout_addresses := RECORD
		string type{xpath('Type')};
		string street_1{xpath('Street_1')};
		string street_2{xpath('Street_2')};
		string city{xpath('City')};
		string state{xpath('State')};
		string postal_code{xpath('Postal_Code')};
		string country{xpath('Country')};
		string comments{xpath('Comments')};
	   END;

	addr_rollup := RECORD
	   string id;
	   DATASET(layout_addresses) address{xpath('Address')};
	  END;

	layout_addlinfo := RECORD
		string type{xpath('Type')};
		string information{xpath('Information')};
		string parsed{xpath('Parsed')};
		string comments{xpath('Comments')};
	   END;

	addlinfo_rollup := RECORD
	   string id;
	   DATASET(Layout_AddlInfo) additionalinfo{xpath('AdditionalInfo')};
	  END;

	layout_sp := RECORD
		string type{xpath('Type')};
		string label{xpath('Label')};
		string number{xpath('Number')};
		string issued_by{xpath('Issued_By')};
		string date_issued{xpath('Date_Issued')};
		string date_expires{xpath('Date_Expired')};
		string comments{xpath('Comments')};
	   END;

	id_rollup := RECORD
	   string id;
	   DATASET(Layout_SP) identification{xpath('Identification')};
	  END;

	layout_phones := RECORD
		string type;
		string address_id;
		string number;
		string comments;
	   END;

	phones_rollup := RECORD
	   string id;
	   DATASET(Layout_Phones) phones{xpath('Phones_Number')};
	  END;

	dsLayoutMain := RECORD
	//,maxLength(720896)
	  string id{xpath('@ID')};
	  string eui{xpath('Entity_Unique_ID')};
	  string type{xpath('Type')};
	  string title{xpath('Title')};
	  string first_name{xpath('First_Name')};
	  string middle_name{xpath('Middle_Name')};
	  string last_name{xpath('Last_Name')};
	  string generation{xpath('Generation')};
	  string full_name{xpath('Full_Name')};
	  string gender{xpath('Gender')};
	  string listed_date{xpath('Listed_Date')};
	  string entity_added_by{xpath('Entity_Added_By')};
	  string reason_listed{xpath('Reason_Listed')};
	  string reference_id{xpath('Reference_Id')};
	  string comments{xpath('Comments')};
	  string search_criteria{xpath('Search_Criteria')};
	  AKA_rollup aka_list{xpath('AKA_List')};
	  Addr_rollup address_list{xpath('Address_List')};
	  AddlInfo_rollup additional_info_list{xpath('Additional_Info_List')};
	  ID_rollup identification_list{xpath('Identification_List')};
	  phones_rollup phone_number_list{xpath('Phone_Number_List')};
	 END;

dsMain := dataset('~thor_200::persist::worldcheck::standard_worldcheck_bridger.mapping_dedup', dsLayoutMain, flat);

	dsMainFlatLayout := record
		  string id;
		  string type;
		  string title;
		  string first_name;
		  string middle_name;
		  string last_name;
		  string generation;
		  string full_name;
		  string gender;
		  string listed_date;
		  string entity_added_by;
		  string reason_listed;
		  string reference_id;
		  string comments;
		  string search_criteria;
		  string category;			//append category field
	end;
	
	dsMainFlatLayout dsMainFlatFix(dsMain l):= transform
		self.category 			:= trim(l.comments[stringlib.stringfind(l.comments, 'Category:', 1)+10..(stringlib.stringfind(l.comments, 'Category:', 1) + stringlib.stringfind(l.comments[stringlib.stringfind(l.comments, 'Category:', 1)..length(l.comments)], '||', 1)-2)], left, right); 
		self 					:= l;
	end;
	
	dsMainFlat := project(dsMain, dsMainFlatFix(left));
	
	//Run MAIN File Stats
	rPopulationStats_WorldCheck_file_Main := record
		dsMainFlat.Category;
		countGroup 						:= count(group);
		id_CountNonZero           		:= sum(group,if(dsMainFlat.id<>'',1,0));
		name_Type_CountNonBlank    		:= sum(group,if(dsMainFlat.type<>'',1,0));
		name_Title_CountNonBlank    	:= sum(group,if(dsMainFlat.title<>'',1,0));
		name_First_CountNonBlank   		:= sum(group,if(dsMainFlat.first_name<>'',1,0));
		name_Middle_CountNonBlank   	:= sum(group,if(dsMainFlat.middle_name<>'',1,0));
		name_Last_CountNonBlank    		:= sum(group,if(dsMainFlat.last_name<>'',1,0));
		name_Generation_CountNonBlank   := sum(group,if(dsMainFlat.generation<>'',1,0));
		name_Full_Name_CountNonBlank    := sum(group,if(dsMainFlat.full_name<>'',1,0));
		gender_CountNonBlank    		:= sum(group,if(dsMainFlat.gender<>'',1,0));
		listed_date_CountNonBlank  		:= sum(group,if(dsMainFlat.listed_date<>'',1,0));
		entity_added_CountNonBlank 		:= sum(group,if(dsMainFlat.entity_added_by<>'',1,0));
		reason_listed_CountNonBlank		:= sum(group,if(dsMainFlat.reason_listed<>'',1,0));	
	end;
	
	dsMainStat 	:= sort(table(dsMainFlat
							,rPopulationStats_WorldCheck_file_Main
							,Category
							,few), category);

//COMPANIES//////////////////////////////////////////////////////////////////////
	
	dsNormCompanyLayout := RECORD,maxlength(100000)
	//,maxLength(100000)
	  string uid;
	  string last_name;
	  string first_name;
	  unicode aliases;
	  unicode low_quality_aliases;
	  unicode alternate_spelling;
	  string category;
	  string title;
	  string sub_category;
	  string position;
	  string age;
	  string date_of_birth;
	  string places_of_birth;
	  string date_of_death;
	  string passports;
	  string social_security_number;
	  string locations;
	  string countries;
	  string companies;
	  string e_i_ind;
	  string linked_tos;
	  string further_information;
	  string keywords;
	  string external_sources;
	  string updated_category;
	  string entered;
	  string updated;
	  string editor;
	  string age_as_of_date;
	  string names;
	  integer8 comp_cnt;
	 END;

	dsNormCompany := dataset('~thor_200::persist::worldcheck::norm_companies', dsNormCompanyLayout, flat);

	dsOneCompanyLayout := RECORD
	//,maxLength(131072)
	  string uid;
	  string last_name;
	  string first_name;
	  unicode aliases;
	  unicode low_quality_aliases;
	  unicode alternate_spelling;
	  string category;
	  string title;
	  string sub_category;
	  string position;
	  string age;
	  string date_of_birth;
	  string places_of_birth;
	  string date_of_death;
	  string passports;
	  string social_security_number;
	  string locations;
	  string countries;
	  string companies;
	  string e_i_ind;
	  string linked_tos;
	  string further_information;
	  string keywords;
	  string external_sources;
	  string updated_category;
	  string entered;
	  string updated;
	  string editor;
	  string age_as_of_date;
	 END;

	dsOneCompany := dataset('~thor_200::persist::worldcheck::one_no_companies', dsOneCompanyLayout, flat);

	dsOneCompanyLayout commonLayoutFix(dsNormCompany l):= transform
		self := l;
	end;

	dsNormComp 		:= project(dsNormCompany, commonLayoutFix(left));

	all_companies 	:= dsOneCompany(companies<>'') + dsNormComp(companies<>'');
	ds_sd_companies := dedup(sort(all_companies(trim(companies, left, right)<>''), record), record);
	
	//Run COMPANIES File Stats
	rPopulationStats_WorldCheck_Companies := record 
		ds_sd_companies.category;
		countGroup   := count(group);
	end;

	dsCompStat := sort(table(ds_sd_companies
						,rPopulationStats_WorldCheck_Companies
						,Category
						,few), category);
												 
//Join MAIN to COMPANIES
	dsMainCompLayout := record
		dsMainStat;
		unsigned8 Companies_CountNonBlank;
	end;
	
	dsMainCompLayout addMainCompTran(dsMainStat l, dsCompStat r):= transform
		self := l;
		self.Companies_CountNonBlank := r.countGroup;
	end;
	
	joinMainComp := sort(join(dsMainStat, dsCompStat,
							left.category = right.category,
							addMainCompTran(left, right), left outer), category);
	
//LINK TOS//////////////////////////////////////////////////////////////////////
	
		dsNormLinkTosLayout := RECORD
	,maxLength(100000)
	  string uid;
	  string last_name;
	  string first_name;
	  unicode aliases;
	  unicode low_quality_aliases;
	  unicode alternate_spelling;
	  string category;
	  string title;
	  string sub_category;
	  string position;
	  string age;
	  string date_of_birth;
	  string places_of_birth;
	  string date_of_death;
	  string passports;
	  string social_security_number;
	  string locations;
	  string countries;
	  string companies;
	  string e_i_ind;
	  string linked_tos;
	  string further_information;
	  string keywords;
	  string external_sources;
	  string updated_category;
	  string entered;
	  string updated;
	  string editor;
	  string age_as_of_date;
	  string links;
	  integer8 link_cnt;
	 END;

	dsNormLinkTos := dataset('~thor_200::persist::worldcheck::norm_linktos', dsNormLinkTosLayout, flat);

	dsOneLinkTosLayout := RECORD
	//,maxLength(131072)
	  string uid;
	  string last_name;
	  string first_name;
	  unicode aliases;
	  unicode low_quality_aliases;
	  unicode alternate_spelling;
	  string category;
	  string title;
	  string sub_category;
	  string position;
	  string age;
	  string date_of_birth;
	  string places_of_birth;
	  string date_of_death;
	  string passports;
	  string social_security_number;
	  string locations;
	  string countries;
	  string companies;
	  string e_i_ind;
	  string linked_tos;
	  string further_information;
	  string keywords;
	  string external_sources;
	  string updated_category;
	  string entered;
	  string updated;
	  string editor;
	  string age_as_of_date;
	 END;

	dsOneLinkTos := dataset('~thor_200::persist::worldcheck::one_no_linktos', dsOneLinkTosLayout, flat);

	dsOneLinkTosLayout commLayoutFix(dsNormLinkTos l):= transform
		self := l;
	end;

	dsNormLinkTo := project(dsNormLinkTos, commLayoutFix(left));

	all_LinkTos 	:= dsOneLinkTos(linked_tos<>'') + dsNormLinkTo(linked_tos<>'');
	ds_sd_link_tos 	:= dedup(sort(all_LinkTos(trim(linked_tos, left, right)<>''), record), record);
		 
	 //Run LINK TOS File Stats
	 rPopulationStats_WorldCheck_Linked_Tos := record
		ds_sd_link_tos.category;
		countGroup  := count(group);
	 end;
    
	dsLinkedToStat 		:= sort(table(ds_sd_link_tos
							,rPopulationStats_WorldCheck_Linked_Tos
							,category
							,few), category);
							
	//Join MAIN, COMPANIES, and LINK TOS
	dsMainCompLinkTosLayout := record
		dsMainCompLayout;
		unsigned8 link_tos_CountNonBlank;
	end;
	
	dsMainCompLinkTosLayout addMainCompLinkTosTran(joinMainComp l, dsLinkedToStat r):= transform
		self := l;
		self.link_tos_CountNonBlank := r.countGroup;
	end;
	
	joinMainCompLinkTos := sort(join(joinMainComp, dsLinkedToStat,
								left.category = right.category,
								addMainCompLinkTosTran(left, right), left outer), category);

//ADDRESSES//////////////////////////////////////////////////////////////////////

//Flatten ADDRESS File
	dsAddressLayout := RECORD
	//,maxLength(131072)
	  string id;
	  string type{xpath('Type')};
	  string street_1{xpath('Street_1')};
	  string street_2{xpath('Street_2')};
	  string city{xpath('City')};
	  string state{xpath('State')};
	  string postal_code{xpath('Postal_Code')};
	  string country{xpath('Country')};
	  string comments{xpath('Comments')};
	  string addr_info;
	 END;
	
	dsAddress := dataset('~thor_200::persist::worldcheck::normalized_addresses', dsAddressLayout, flat);
	
	dsAddressFlatLayout := record
	  string id;
	  string type;
	  string street_1;
	  string street_2;
	  string city;
	  string state;
	  string postal_code;
	  string country;
	  string comments;
	  string addr_info;
	  string category;
	end;
	
	dsAddressFlatLayout dsAddressFlatFix(dsAddress l):= transform
		self.category 	:= '';
		self 			:= l;
	end;
	
	dsAddressFlat 		:= sort(project(dsAddress, dsAddressFlatFix(left)), id);
	dsMainSort 			:= sort(dsMainFlat, id, category);
	
	//Find Category
	dsAddressFlatLayout findAddCatFix(dsMainSort l, dsAddressFlat r):= transform
		self.category	:= l.category;
		self 			:= r;
	end;
	
	joinAddress			:= dedup(sort(join(dsMainSort, dsAddressFlat,
								left.id = right.id,
								findAddCatFix(left, right)), record), all);
		
	//Run ADDRESS File Stats   
	 rPopulationStats_WorldCheck_Address := record
		 joinAddress.category;
	     location_CountNonBlank   			:= sum(group,if(joinAddress.comments='' and joinAddress.addr_info<>'',1,0));
		 country_CountNonBlank    			:= sum(group,if(joinAddress.comments='Countries',1,0));
		 passport_country_CountNonBlank    	:= sum(group,if(joinAddress.comments='Passport Country',1,0));
	 end;
	
	 dsAddressStat 		:= table(joinAddress
								,rPopulationStats_WorldCheck_Address
								,category
								,few);
								
	//Join MAIN, COMPANY, LINKED TOS, and ADDRESSES
	dsMainCompLinkTosAddrLayout := record
		dsMainCompLinkTosLayout;
		unsigned8 location_CountNonBlank;
		unsigned8 country_CountNonBlank;
		unsigned8 passport_country_CountNonBlank;
	end;
	
	dsMainCompLinkTosAddrLayout addMainCompLinkTosAddrTran(joinMainCompLinkTos l, dsAddressStat r):= transform
		self := l;
		self.location_CountNonBlank 		:= r.location_CountNonBlank;
		self.country_CountNonBlank 			:= r.country_CountNonBlank;
		self.passport_country_CountNonBlank := r.passport_country_CountNonBlank;
	end;
	
	joinMainCompLinkTosAddr := sort(join(joinMainCompLinkTos, dsAddressStat,
										left.category = right.category,
										addMainCompLinkTosAddrTran(left, right), left outer), category);

//ADDITIONAL INFO FILE//////////////////////////////////////////////////////////////////////	

	//Flatten ADDITIONAL INFO
	dsExtSourceLayout := RECORD
	//,maxLength(131072)
	  string id;
	  string type{xpath('Type')};
	  string information{xpath('Information')};
	  string parsed{xpath('Parsed')};
	  string comments{xpath('Comments')};
	  string addl_info;
	 END;

	dsDOB 			:= dataset('~thor_200::persist::worldcheck::all_dob', dsExtSourceLayout, flat);
	dsOccupation 	:= dataset('~thor_200::persist::worldcheck::all_occupations', dsExtSourceLayout, flat);
	dsPOB 			:= dataset('~thor_200::persist::worldcheck::all_pob', dsExtSourceLayout, flat);
	dsExtSource 	:= dataset('~thor_200::persist::worldcheck::all_ext_sources', dsExtSourceLayout, flat);

	dsAddInfo		:= dsDOB + dsOccupation + dsPOB + dsExtSource;
	
	dsAddInfoLayout := record
	 string id;
	 string type;
	 string information;
	 string parsed;
	 string comments;
	 string addl_info;
	 string category; //append category field
	end;
	
	dsAddInfoLayout dsAddInfoFlatFix(dsAddInfo l):= transform
		self.category 	:= '';
		self 			:= l;
	end;
	
	dsAddInfoFlat 	:= project(dsAddInfo, dsAddInfoFlatFix(left));
	ds_sd_AddInfo 	:= dedup(sort(dsAddInfoFlat(trim(information, left, right)<>''), record), record);
	
	dsAddInfoSort	:= sort(ds_sd_AddInfo, id);
	//dsMainSort 		:= sort(dsMainFlat, id, category);
	
	//Find Category
	dsAddInfoLayout findAddCatFix2(dsMainSort l, dsAddInfoSort r):= transform
		self.category	:= l.category;
		self 			:= r;
	end;
	
	joinAddInfo			:= dedup(sort(join(dsMainSort, dsAddInfoSort,
								left.id = right.id,
								findAddCatFix2(left, right)), record), all);
	
	//Run ADDITIONAL INFO File Stats
	rPopulationStats_WorldCheck_AddInfo := record
		 joinAddInfo.category;
		 DOB_CountNonBlank 			:= sum(group,if(joinAddInfo.type='Date of Birth',1,0));
		 Occupation_CountNonBlank 	:= sum(group,if(joinAddInfo.type='Occupation',1,0));
		 POB_CountNonBlank 			:= sum(group,if(joinAddInfo.type='Place of Birth',1,0));
		 Other_CountNonBlank 		:= sum(group,if(joinAddInfo.type='Other Information',1,0));
	 end;
    
	dsAddInfoStat 	:= sort(table(joinAddInfo
							,rPopulationStats_WorldCheck_AddInfo
							,category
							,few), category);

	//Join MAIN, COMPANIES, LINKED TOS, ADDRESS, and ADDITIONAL INFO
	dsMainCompLinkTosAddrAddInfoLayout := record
		dsMainCompLinkTosAddrLayout;
		unsigned8 DOB_CountNonBlank;
		unsigned8 Occupation_CountNonBlank;
		unsigned8 POB_CountNonBlank;
		unsigned8 Other_CountNonBlank;
	end;
	
	dsMainCompLinkTosAddrAddInfoLayout addMainCompLinkTosAddrAddInfoTran(joinMainCompLinkTosAddr l, dsAddInfoStat r):= transform
		self := l;
		self.DOB_CountNonBlank 			:= r.DOB_CountNonBlank;
		self.Occupation_CountNonBlank 	:= r.Occupation_CountNonBlank;
		self.POB_CountNonBlank 			:= r.POB_CountNonBlank;
		self.Other_CountNonBlank 		:= r.Other_CountNonBlank;
	end;
	
	joinMainCompLinkTosAddrAddInfo 		:= sort(join(joinMainCompLinkTosAddr, dsAddInfoStat,
												left.category = right.category,
												addMainCompLinkTosAddrAddInfoTran(left, right), left outer), category);

//ID FILE/////////////////////////////////////////////////////////////////

	//Flatten ID FILE
	dsIDLayout := RECORD
	//,maxLength(131072)
	  string id;
	  string type{xpath('Type')};
	  string label{xpath('Label')};
	  string number{xpath('Number')};
	  string issued_by{xpath('Issued_By')};
	  string date_issued{xpath('Date_Issued')};
	  string date_expires{xpath('Date_Expired')};
	  string comments{xpath('Comments')};
	  string ssn_info;
	  string passport_info;
	 END;

	dsIDs 	:= dataset('~thor_200::persist::worldcheck::all_ids', dsIDLayout, flat);

	dsIDFlatLayout := RECORD
	//,maxLength(131072)
	  string id;
	  string type;
	  string label;
	  string number;
	  string issued_by;
	  string date_issued;
	  string date_expires;
	  string comments;
	  string ssn_info;
	  string passport_info;
	  string category; //append category field 
	 END;
	 
	dsIDFlatLayout dsIDFlatFix(dsIDs l):= transform
		self.category 	:= '';
		self 			:= l;
	end;
	
	dsIDFlat 	:= project(dsIDs, dsIDFlatFix(left));
	ds_sd_ID 	:= dedup(sort(dsIDFlat(trim(number, left, right)<>''), record), record);

	dsIDSort	:= sort(ds_sd_ID, id);
	
	//Find Category
	dsIDFlatLayout findAddCatFix3(dsMainSort l, dsIDSort r):= transform
		self.category	:= l.category;
		self 			:= r;
	end;
	
	joinID				:= dedup(sort(join(dsMainSort, dsIDSort,
									left.id = right.id,
									findAddCatFix3(left, right)), record), all);
	
	//Run ID File Stats
	rPopulationStats_WorldCheck_ID := record
		 joinID.category;
		 SSN_CountNonBlank 				:= sum(group,if(joinID.type='SSN',1,0));
		 Passport_CountNonBlank 		:= sum(group,if(joinID.type='Passport',1,0));
		 ProprietaryUID_CountNonBlank 	:= sum(group,if(joinID.type='ProprietaryUID',1,0));
	 end;
    
	dsIDStat 	:= sort(table(joinID
							,rPopulationStats_WorldCheck_ID
							,category
							,few), category);
							
	//Join MAIN, COMPANIES, LINKED TOS, ADDRESS, ADDITIONAL INFO, and IDS
	dsMainCompLinkTosAddrAddInfoIDLayout := record
		dsMainCompLinkTosAddrAddInfoLayout;
		unsigned8 SSN_CountNonBlank;
		unsigned8 Passport_CountNonBlank;
		unsigned8 ProprietaryUID_CountNonBlank;
	end;
	
	dsMainCompLinkTosAddrAddInfoIDLayout addMainCompLinkTosAddrAddInfoIDTran(joinMainCompLinkTosAddrAddInfo l, dsIDStat r):= transform
		self := l;
		self.SSN_CountNonBlank 				:= r.SSN_CountNonBlank;
		self.Passport_CountNonBlank 		:= r.Passport_CountNonBlank;
		self.ProprietaryUID_CountNonBlank 	:= r.ProprietaryUID_CountNonBlank
	end;
	
	joinMainCompLinkTosAddrAddInfoID 		:= sort(join(joinMainCompLinkTosAddrAddInfo, dsIDStat,
													left.category = right.category,
													addMainCompLinkTosAddrAddInfoIDTran(left, right), left outer), category);

//KEYWORDS//////////////////////////////////////////////////////////////////////

	 dsLayoutKeywords := RECORD
		,maxLength(100000)
		  string uid;
		  string last_name;
		  string first_name;
		  unicode aliases;
		  unicode low_quality_aliases;
		  unicode alternate_spelling;
		  string category;
		  string title;
		  string sub_category;
		  string position;
		  string age;
		  string date_of_birth;
		  string places_of_birth;
		  string date_of_death;
		  string passports;
		  string social_security_number;
		  string locations;
		  string countries;
		  string companies;
		  string e_i_ind;
		  string linked_tos;
		  string further_information;
		  string keywords;
		  string external_sources;
		  string updated_category;
		  string entered;
		  string updated;
		  string editor;
		  string age_as_of_date;
		  string names;
		  integer8 comp_cnt;
		 END;
	 
	 ds_keywords 	:= dataset('~thor_200::persist::worldcheck::all_keywords', dsLayoutKeywords, flat);
	 ds_sd_keywords := dedup(sort(ds_keywords(trim(keywords, left, right)<>''), record), record);
	 
	 //Run KEYWORDS File Stats
	 rPopulationStats_WorldCheck_Keywords := record
		 ds_sd_keywords.category;
		 countGroup := count(group);
	 end;
    
	dsKeywordStat 		:= sort(table(ds_sd_keywords
							,rPopulationStats_WorldCheck_Keywords
							,category
							,few), category);
	
	//Join MAIN, COMPANIES, LINKED TOS, ADDRESS, ADDITIONAL INFO, IDS, and KEYWORDS
	dsMainCompLinkTosAddrAddInfoIDKeywordLayout := record
		dsMainCompLinkTosAddrAddInfoIDLayout;
		unsigned8 keyword_CountNonBlank;
	end;
	
	dsMainCompLinkTosAddrAddInfoIDKeywordLayout addMainCompLinkTosAddrAddInfoIDKeywordTran(joinMainCompLinkTosAddrAddInfoID l, dsKeywordStat r):= transform
		self := l;
		self.keyword_CountNonBlank := r.countGroup;
	end;
	
	joinMainCompLinkTosAddrAddInfoIDKeyword := sort(join(joinMainCompLinkTosAddrAddInfoID, dsKeywordStat,
													left.category = right.category,
													addMainCompLinkTosAddrAddInfoIDKeywordTran(left, right), left outer), category):persist('~thor_200::persist::worldcheck::standard_entity_stat_'+filedate);

	STRATA.createXMLStats(joinMainCompLinkTosAddrAddInfoIDKeyword
					 ,'World Check - Bridger'
					 ,'Standard Entity'
					 ,filedate
					 ,''
					 ,zMain
					 ,
					 ,'population');

return zmain;

end;