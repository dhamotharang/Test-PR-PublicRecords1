#workunit('priority', 'high');

import ut, lib_stringlib, worldcheck, worldcheck_bridger, std;

export Mapping_Standard_Entity (string filedate) := function

//////////////////////////////////////////////////////////////////////////////////
//[Bug 86370] World Check Standard: When WC indicates Countries=UNKNOWN
//					, look to Locations field for a Country to use to place the record in a region.
//
//Bug: 86379 - World Check Standard: Do not create an AKA for records where the Alias="New York" 
//////////////////////////////////////////////////////////////////////////////////
f := Worldcheck_Bridger.File_WorldCheck_In;
f patchrecs(f L) := transform
	self.countries := if(L.countries = 'UNKNOWN', Worldcheck_Bridger._Functions.Find_Country_ifUnknown(L.locations),L.Countries);


	self.aliases   := regexreplace(U'NEW YORK',
										regexreplace(U';NEW YORK',
											regexreplace(U'NEW YORK;', Std.Uni.ToUpperCase(L.aliases),'')
									,U'')
									,U'');
	self.low_quality_aliases := 
							 regexreplace(U'NEW YORK',
										regexreplace(U';NEW YORK',
											regexreplace(U'NEW YORK;', Std.Uni.ToUpperCase(L.low_quality_aliases),'')
									,U'')
									,U''); 
	self := L;
end;

patchedrecs := project(f,patchrecs(left));
//////////////////////////////////////////////////////////////////////////////////
//Reformat to Premium Layout
in_f 			:= patchedrecs;

//POPULATE COMPANIES AND LINKED TOS
in_comp_l 		:= Worldcheck_Bridger.Find_Companies_and_Linked_Tos(in_f);

//POPULATE KEYWORDS
map_keyword		:= Worldcheck_Bridger.Normalize_Keywords(in_comp_l);
map_keywords	:= distribute(map_keyword, random());

//POPULATE ENTITIES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Layout_Entity := record
		string ID{xpath('@ID')};
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
		//string flag_country;
	end;
	
	Layout_Entity entityTran(map_keywords l) := transform
		self.id					:= l.uid;
		self.eui				:= 'WC'+l.uid;
		self.type 				:= if(l.e_i_ind in ['I','U','M','F'],
										'Individual',
									if(l.e_i_ind = 'E',
										'Business',
										''));
		self.title 				:= l.title;
		self.first_name 		:= if(l.e_i_ind = 'E',
										'',
										l.first_name);
		self.middle_name		:= '';
		self.last_name			:= if(l.e_i_ind = 'E',
										'',
										l.last_name);
		self.generation			:= '';
		self.full_name			:= if(l.e_i_ind <> 'E',
										'',
										l.last_name);
		self.gender				:= if(l.e_i_ind = 'M',
										'Male',
									if(l.e_i_ind = 'F',
										'Female',
										''));
		self.listed_date		:= _Functions.Fix_Date(trim(l.entered, left, right));
		self.entity_added_by	:= l.editor;
		
			subcat_reason		:= if(trim(l.sub_category, left, right)<>'',
										trim(l.sub_category, left, right),
										'Non-PEP');
		
		self.reason_listed		:= trim(trim(l.category, left, right) + ' ' + trim(subcat_reason, left, right), left, right);
		self.reference_id		:= l.uid;
		
			deceased_comment 		:= if(l.Date_Of_Death<>'', 'Deceased Date: '+_Functions.Fix_Date(trim(l.Date_Of_Death, left, right))+' || ', '');
			age_as_of_date_comment	:= if(l.age_as_of_date<>'', 'as of '+_Functions.Fix_Date(trim(l.age_as_of_date, left, right))+' | ', '');
			age_comment				:= if(l.age<>'' and age_as_of_date_comment<>'', 
											'Age: '+trim(l.age, left, right)+' || '+age_as_of_date_comment,
										if(l.age<>'', 
											'Age: '+trim(l.age, left, right)+' || ',
											''));
			category_comment		:= if(l.category<>'', 'Category: '+trim(l.category, left, right)+' || ', '');
			sub_category_comment	:= if(l.sub_category<>'', 'Sub-Category: '+trim(l.sub_category, left, right)+' || ', 'Sub-Category: Non-PEP || ');
			companies_comment		:= if(l.companies<>'', 'Companies: '+' | '+trim(l.companies, left, right)+' || ', '');
			associations_comment	:= if(l.linked_tos<>'', 'Associations: '+' | '+trim(l.linked_tos, left, right)+' || ', '');
			keywords_comment		:= if(l.keywords<>'', 'Keywords: '+trim(l.keywords, left, right)+' || ', '');
			date_entered_comment	:= if(l.entered<>'', 'Date Entered: '+_Functions.Fix_Date(trim(l.entered, left, right))+' | ', '');
			date_updated_comment	:= if(l.updated<>'', 'Date Updated: '+_Functions.Fix_Date(trim(l.updated, left, right))+' | ', '');
			further_info_comment	:= if(l.further_information<>'', 'Further Information: '+trim(l.further_information, left, right)+' ', '');
			//external_source_comment	:= if(l.external_sources<>'', 'External Sources: '+trim(l.external_sources, left, right)+' ', '');
		
		self.comments				:= deceased_comment + age_comment + category_comment + sub_category_comment + companies_comment + associations_comment + keywords_comment + date_entered_comment + date_updated_comment + further_info_comment;// + external_source_comment;
		
			populate_country_id 	:= if(Worldcheck_Bridger._functions.Find_Country_ID(trim(L.countries, left, right))<>'',
											'1,'+trim(Worldcheck_Bridger._functions.Find_Country_ID(trim(L.countries, left, right)), left, right)+';',
											'');									
			populate_category 		:= if(Worldcheck_Bridger._functions.Find_Category(l.category)<>'',
											'2,'+trim(Worldcheck_Bridger._functions.Find_Category(l.category), left, right)+';',
											'');
			populate_subcategory 	:= if(Worldcheck_Bridger._functions.Find_SubCategory(l.sub_category)<>'',
											'3,'+trim(Worldcheck_Bridger._functions.Find_SubCategory(l.sub_category), left, right)+';',
											'3,2;');
			
			populate_deceased 		:= if(Worldcheck_Bridger._functions.Find_DeceasedState(l.date_of_death)<>'',
											'4,'+trim(Worldcheck_Bridger._functions.Find_DeceasedState(l.date_of_death), left, right)+';',
											'4,9;');
			
			populate_keyword		:= if(l.names<>'',
											'5,'+trim(l.names, left, right)+';',
											'5,9999;');
		
		self.search_criteria 		:= populate_country_id + populate_category + populate_subcategory + populate_deceased + StringLib.StringFilter(populate_keyword, '0123456789,;');
		
	end;

	ds_entity := project(map_keywords, entityTran(left)): persist('~thor_200::persist::worldcheck::entity_mapping');

//POPULATE AKAS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
map_akas_altspell := Worldcheck_Bridger.Mapping_AKAs_and_AltSpell(in_f);

	// Rollup of Akas and Alternative Spellings
	AKA_rollup := record
		string ID;
		dataset(Layout_Aliases) AKA{xpath('AKA')};
		//string ID;
	end;

	AKA_rollup t_Aliases(map_akas_altspell L) := transform
		self.AKA 	:= row(L, Layout_Aliases);
		self := L;
	end;

	p_AKA := project(map_akas_altspell, t_Aliases(left));

	AKA_rollup  t_Aliases_child(p_AKA L, p_AKA R) := transform
		self.AKA   			:= L.AKA + row({r.AKA[1].Type,
													r.AKA[1].Category,
													r.AKA[1].First_Name,
													r.AKA[1].Middle_Name,
													r.AKA[1].Last_Name,
													r.AKA[1].Generation,
													r.AKA[1].Full_Name,
													r.AKA[1].Comments}
												   ,Layout_Aliases);
		self              	:= L;
	end;

	rollup_aka := rollup(sort(p_AKA,record)
					,t_Aliases_child(left,right)
					,id);
					
	//Join Aliases to Entities
	Layout_AKA	:= record
		AKA_Rollup	Aka_List{xpath('AKA_List')};
	end;

	Layout_AKA t_Aliases2(rollup_aka L) := transform
		self.Aka_List	:=	L;
	end;

	pr_aka := project(rollup_aka, t_Aliases2(left));

	rOut	:= record
		Layout_Entity;
		Layout_AKA;
	end;

	rOut join_AKA(ds_entity l, pr_aka R) := transform
		 self	:= r;
		 self	:= L;
	end;

	Join_Entity_AKA 		:= join(ds_entity
									,pr_aka
									,left.reference_ID = right.AKA_List.ID
									,join_AKA(left,right)
									,LEFT OUTER);//: persist('~thor_200::persist::worldcheck::entity_aka');

//POPULATE ADDRESSES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
map_and_rollup_addr := Worldcheck_Bridger.Mapping_and_Rollup_Addresses(in_f);

	//Join Addresses to Entities and AKAs
	Layout_Address_Child := record
		map_and_rollup_addr;
	end;
		
	Layout_Address	:= record
		Layout_Address_Child Address_List{xpath('Address_List')};
	end;

	Layout_Address t_Addr(map_and_rollup_addr L) := transform
		self.Address_List	:=	L;
	end;

	pr_addr := project(map_and_rollup_addr, t_Addr(left));
	
	rOut2	:= record
		Join_Entity_AKA;
		pr_addr;
	end;

	rOut2 join_Address(Join_Entity_AKA l, pr_addr R) := transform
		 self	:= r;
		 self	:= L;
	end;

	Join_Entity_AKA_Addr 	:= join(Join_Entity_AKA
									,pr_addr
									,left.reference_ID = right.Address_List.ID
									,join_Address(left,right)
									,LEFT OUTER);//:persist('~thor_200::persist::worldcheck::entity_aka_addr');

//POPULATE ADDITIONAL INFO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
map_and_rollup_addlinfo := Worldcheck_Bridger.Mapping_and_Rollup_AddlInfo(in_f);

	//Join Additional Info to Entities, AKAs, and Addresses
	Layout_AddlInfo_Child := record
		map_and_rollup_addlinfo;
	end;
		
	Layout_AddlInfo	:= record
		Layout_AddlInfo_Child Additional_Info_List{xpath('Additional_Info_List')};
	end;

	Layout_AddlInfo t_AddlInfo(map_and_rollup_addlinfo L) := transform
		self.Additional_Info_List	:=	L;
	end;

	pr_addlinfo := project(map_and_rollup_addlinfo, t_Addlinfo(left));
	
	rOut3	:= record
		Join_Entity_AKA_Addr;
		pr_addlinfo;
	end;

	rOut3 join_AddlInfo(Join_Entity_AKA_Addr l, pr_addlinfo R) := transform
		 self	:= r;
		 self	:= L;
	end;

	Join_Entity_AKA_Addr_AddlInfo 	:= join(Join_Entity_AKA_Addr
											,pr_addlinfo
											,left.reference_ID = right.Additional_Info_List.ID
											,join_AddlInfo(left,right)
											,LEFT OUTER);//: persist('~thor_200::persist::worldcheck::entity_aka_addr_addlinfo');
									
//POPULATE ID INFO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
map_and_rollup_ids := Worldcheck_Bridger.Mapping_and_Rollup_IDs(in_f);

	//Join IDs to Entities, AKAs, Addresses, and Additional Info
	Layout_IDs_Child := record
		map_and_rollup_ids;
	end;
		
	Layout_IDs	:= record
		Layout_IDs_Child Identification_List{xpath('Identification_List')};
	end;

	Layout_IDs t_IDs(map_and_rollup_ids L) := transform
		self.Identification_List	:=	L;
	end;

	pr_ids := project(map_and_rollup_ids, t_IDs(left));
	
	rOut4	:= record
		Join_Entity_AKA_Addr_AddlInfo;
		pr_ids;
	end;

	rOut4 join_IDs(Join_Entity_AKA_Addr_AddlInfo l, pr_ids R) := transform
		 self	:= r;
		 self	:= L;
	end;

	join_id 			:= join(Join_Entity_AKA_Addr_AddlInfo
												,pr_ids
												,left.reference_ID = right.Identification_List.ID
												,join_IDs(left,right)
												,LEFT OUTER);//: persist('~thor_200::persist::worldcheck::standard_mapping');

//POPULATE PHONE INFO-----------------------------------------------
	File_In_Phone := dataset([
		{'','','',''}],
		{string type, string address_id, string number, string comments});

	Layout_phones := record
		string type ;
		string address_id;
		string number;
		string comments;
	end;

	Layout_temp := record
		string ID;
		Layout_phones;
	end;

	Layout_temp phoneTran(Layout_phones l):= transform
		self 		:= l;
		self.id		:= '';
	end;

	ds_phones := project(File_In_Phone, phoneTran(left));
	
	// Rollup of Phones
	phones_rollup := record
		string ID;
		dataset(Layout_phones) phones{xpath('Phones_Number')};
		//string ID;
	end;

	phones_rollup t_Phones(ds_phones L) := transform
		self.phones 	:= row(L, Layout_Phones);
		self := L;
	end;

	p_Phones := project(ds_phones, t_Phones(left));

	Phones_rollup  t_Phones_child(p_Phones L, p_Phones R) := transform
		self.Phones   			:= L.Phones + row({r.Phones[1].Type,
													r.Phones[1].Address_ID,
													r.Phones[1].Number,
													r.Phones[1].Comments}
												   ,Layout_Phones);
		self              	:= L;
	end;

	rollup_Phones := rollup(sort(p_Phones,record)
					,t_Phones_child(left,right)
					,id);
	
	//Join 
	Layout_Phone_Child := record
		rollup_phones;
	end;
	
	Layout_Phone	:= record
		Layout_Phone_Child Phone_Number_List{xpath('Phone_Number_List')};
	end;

	Layout_Phone t_Phone2(rollup_phones L) := transform
		self.Phone_Number_List	:=	L;
	end;

	pr_phone := project(rollup_phones, t_Phone2(left));

	rOutP	:= record
		join_id;
		pr_phone;
	end;

	rOutP join_phone(join_id l, pr_phone R) := transform
		 self	:= r;
		 self	:= L;
	end;

	Join_phone_all 		:= join(join_id
									,pr_phone
									,left.reference_ID = right.Phone_Number_List.ID
									,join_phone(left,right)
									,LEFT OUTER);

	rOutP SplitRecordsIn254(rOutP l, integer pos) := transform,skip(COUNT(l.aka_list.aka) < 255 AND pos=2)
				self.id 					:= CASE(pos,
						1 => l.id,
						2 => l.id + '999',
						l.id);
		
				self.eui := CASE(pos,
						1 => l.eui,
						2 => l.eui + '_999',
						l.eui);
						
				self.aka_list.aka :=	CASE(pos,
						1 =>  choosen(l.aka_list.aka, 254),
						2 =>  choosen(l.aka_list.aka, 254, 255),
						//3 =>  IF(COUNT(l.aka_list.aka)<509, SKIP, choosen(l.aka_list.aka, 254, 209)),
						l.aka_list.aka);

				self := l;
			end;	
	
								
	akakludge := NORMALIZE(Join_phone_all, 2, SplitRecordsIn254(left, counter));

	
	standard_mapping 	:= dedup(sort(akakludge, reference_id), record, all): persist('~thor_200::persist::worldcheck::standard_Worldcheck_Bridger.Mapping_dedup');

//SPLIT INTO REGIONS
standard_filter := standard_mapping(search_criteria[1..2]='1,');

	layout_temp_c := record
		standard_filter;
		string country_id;
	end;

	layout_temp_c findCountry(standard_filter l):= transform
		self.country_id := trim(l.search_criteria[3..stringlib.stringfind(l.search_criteria,';',1)-1], left, right);
		self := l;
	end;

	country_flag 	:= project(standard_filter, findCountry(left));
	country_filter	:= sort(distribute(country_flag(country_id<>''), hash(country_id)), country_id, local);
	
	//Region 1---------------------------------------------------
	region_1 		:= sort(distribute(worldcheck_bridger.File_In_Country(region_id='1' and country_id<>''), hash(country_id)), country_id, local);

		standard_filter findRegion1(country_filter l, region_1 r):=transform
			self := l;
		end;

	joinReg1 		:= join(country_filter, region_1,
						trim(left.country_id, left, right) = right.country_id,
						findRegion1(left, right), local);
	
	dedup_ent1		:= dedup(sort(joinReg1, reference_id), record, all) : persist('~thor_200::persist::worldcheck::standard_mapping_region_1_dedup');
	

	entity_count_1	:= count(dedup_ent1(reference_id<>''));
	//output(entity_count_1, named('Region_1_Entity'));
	
	Layout_ent_child_1 := record
		dedup_ent1;
	end;
	
	Layout_ent_child_1 ent_Child1(dedup_ent1 l):= transform
		self := l;
	end;
	
	ds1 := project(dedup_ent1, ent_Child1(left));
		
	Layout_Ent_P1	:= record
		dataset(Layout_ent_child_1) Entity{xpath('Entity')};
	end;
	
	Layout_Ent_P1 t_Entity1(ds1 L) := transform
		self.Entity 	:= row(L, Layout_ent_child_1);
		self := L;
	end;

	p_Ent1 := project(ds1, t_Entity1(left));//: persist('~thor_200::persist::worldcheck::standard_mapping_region_1');
	
	Layout_Worldcheck_Entity removeIDs1(p_Ent1 l):= transform
		self := l;
	end;
	
	p_Ent_NoIDs_1 := project(p_Ent1, removeIDs1(left));
	
	//output(p_Ent_NoIDs_1);
	
	p_Entity_1 := output(p_Ent_NoIDs_1,,'~thor_data200::base::worldcheck_bridger::region_1_entity::'+filedate+'.xml', XML('MYROW', 
							HEADING('<Entity_List Count="'+entity_count_1+'">'
							,'</Entity_List></Watchlist>'), TRIM, OPT), overwrite);

	//Region 2---------------------------------------------------
	region_2 		:= sort(distribute(worldcheck_bridger.File_In_Country(region_id='2' and country_id<>''), hash(country_id)), country_id, local);

		standard_filter findRegion2(country_filter l, region_2 r):=transform
			self := l;
		end;

	joinReg2 		:= join(country_filter, region_2,
						trim(left.country_id, left, right) = right.country_id,
						findRegion2(left, right), local);
	
	dedup_ent2		:= dedup(sort(joinReg2, reference_id), record, all) : persist('~thor_200::persist::worldcheck::standard_mapping_region_2_dedup');

	entity_count_2	:= count(dedup_ent2(reference_id<>''));
	//output(entity_count_2, named('Region_2_Entity'));
	
	Layout_ent_child_2 := record
		dedup_ent2;
	end;
	
	Layout_ent_child_2 ent_Child2(dedup_ent2 l):= transform
		self := l;
	end;
	
	ds2 := project(dedup_ent2, ent_Child2(left));
		
	Layout_Ent_P2	:= record
		dataset(Layout_ent_child_2) Entity{xpath('Entity')};
	end;
	
	Layout_Ent_P2 t_Entity2(ds2 L) := transform
		self.Entity 	:= row(L, Layout_ent_child_2);
		self := L;
	end;

	p_Ent2 := project(ds2, t_Entity2(left));//: persist('~thor_200::persist::worldcheck::standard_mapping_region_2');
	
	Layout_Worldcheck_Entity removeIDs2(p_Ent2 l):= transform
		self := l;
	end;
	
	p_Ent_NoIDs_2 := project(p_Ent2, removeIDs2(left));
	
	//output(p_Ent_NoIDs_2);
	
	p_Entity_2 := output(p_Ent_NoIDs_2,,'~thor_data200::base::worldcheck_bridger::region_2_entity::'+filedate+'.xml', XML('MYROW', 
							HEADING('<Entity_List Count="'+entity_count_2+'">'
							,'</Entity_List></Watchlist>'), TRIM, OPT), overwrite);

	//Region 3---------------------------------------------------
	region_3 		:= sort(distribute(worldcheck_bridger.File_In_Country(region_id='3' and country_id<>''), hash(country_id)), country_id, local);

		standard_filter findRegion3(country_filter l, region_3 r):=transform
			self := l;
		end;

	joinReg3 		:= join(country_filter, region_3,
						trim(left.country_id, left, right) = right.country_id,
						findRegion3(left, right), local);
	
	dedup_ent3		:= dedup(sort(joinReg3, reference_id), record, all) : persist('~thor_200::persist::worldcheck::standard_mapping_region_3_dedup');

	entity_count_3	:= count(dedup_ent3(reference_id<>''));
	//output(entity_count_3, named('Region_3_Entity'));
	
	Layout_ent_child_3 := record
		dedup_ent3;
	end;
	
	Layout_ent_child_3 ent_Child3(dedup_ent3 l):= transform
		self := l;
	end;
	
	ds3 := project(dedup_ent3, ent_Child3(left));
		
	Layout_Ent_P3	:= record
		dataset(Layout_ent_child_3) Entity{xpath('Entity')};
	end;
	
	Layout_Ent_P3 t_Entity3(ds3 L) := transform
		self.Entity 	:= row(L, Layout_ent_child_3);
		self := L;
	end;

	p_Ent3 := project(ds3, t_Entity3(left));//: persist('~thor_300::persist::worldcheck::standard_mapping_region_3');
	
	Layout_Worldcheck_Entity removeIDs3(p_Ent3 l):= transform
		self := l;
	end;
	
	p_Ent_NoIDs_3 := project(p_Ent3, removeIDs3(left));
	
	//output(p_Ent_NoIDs_3);
	
	p_Entity_3 := output(p_Ent_NoIDs_3,,'~thor_data200::base::worldcheck_bridger::region_3_entity::'+filedate+'.xml', XML('MYROW', 
							HEADING('<Entity_List Count="'+entity_count_3+'">'
							,'</Entity_List></Watchlist>'), TRIM, OPT), overwrite);

	//Region 4---------------------------------------------------
	region_4 		:= sort(distribute(worldcheck_bridger.File_In_Country(region_id='4' and country_id<>''), hash(country_id)), country_id, local);

		standard_filter findRegion4(country_filter l, region_4 r):=transform
			self := l;
		end;

	joinReg4 		:= join(country_filter, region_4,
						trim(left.country_id, left, right) = right.country_id,
						findRegion4(left, right), local);
	
	dedup_ent4		:= dedup(sort(joinReg4, reference_id), record, all) : persist('~thor_200::persist::worldcheck::standard_mapping_region_4_dedup');

	entity_count_4	:= count(dedup_ent4(reference_id<>''));
	//output(entity_count_4, named('Region_4_Entity'));
	
	Layout_ent_child_4 := record
		dedup_ent4;
	end;
	
	Layout_ent_child_4 ent_Child4(dedup_ent4 l):= transform
		self := l;
	end;
	
	ds4 := project(dedup_ent4, ent_Child4(left));
		
	Layout_Ent_P4	:= record
		dataset(Layout_ent_child_4) Entity{xpath('Entity')};
	end;
	
	Layout_Ent_P4 t_Entity4(ds4 L) := transform
		self.Entity 	:= row(L, Layout_ent_child_4);
		self := L;
	end;

	p_Ent4 := project(ds4, t_Entity4(left));//: persist('~thor_400::persist::worldcheck::standard_mapping_region_4');
	
	Layout_Worldcheck_Entity removeIDs4(p_Ent4 l):= transform
		self := l;
	end;
	
	p_Ent_NoIDs_4 := project(p_Ent4, removeIDs4(left));
	
	//output(p_Ent_NoIDs_4);
	
	p_Entity_4 := output(p_Ent_NoIDs_4,,'~thor_data200::base::worldcheck_bridger::region_4_entity::'+filedate+'.xml', XML('MYROW', 
							HEADING('<Entity_List Count="'+entity_count_4+'">'
							,'</Entity_List></Watchlist>'), TRIM, OPT), overwrite);

	//Region 5---------------------------------------------------
	region_5 		:= sort(distribute(worldcheck_bridger.File_In_Country(region_id='5' and country_id<>''), hash(country_id)), country_id, local);

		standard_filter findRegion5(country_filter l, region_5 r):=transform
			self := l;
		end;

	joinReg5 		:= join(country_filter, region_5,
						trim(left.country_id, left, right) = right.country_id,
						findRegion5(left, right), local);
	
	dedup_ent5		:= dedup(sort(joinReg5, reference_id), record, all) : persist('~thor_200::persist::worldcheck::standard_mapping_region_5_dedup');

	entity_count_5	:= count(dedup_ent5(reference_id<>''));
	//output(entity_count_5, named('Region_5_Entity'));
	
	Layout_ent_child_5 := record
		dedup_ent5;
	end;
	
	Layout_ent_child_5 ent_Child5(dedup_ent5 l):= transform
		self := l;
	end;
	
	ds5 := project(dedup_ent5, ent_Child5(left));
		
	Layout_Ent_P5	:= record
		dataset(Layout_ent_child_5) Entity{xpath('Entity')};
	end;
	
	Layout_Ent_P5 t_Entity5(ds5 L) := transform
		self.Entity 	:= row(L, Layout_ent_child_5);
		self := L;
	end;

	p_Ent5 := project(ds5, t_Entity5(left));//: persist('~thor_500::persist::worldcheck::standard_mapping_region_5');
	
	Layout_Worldcheck_Entity removeIDs5(p_Ent5 l):= transform
		self := l;
	end;
	
	p_Ent_NoIDs_5 := project(p_Ent5, removeIDs5(left));
	
	//output(p_Ent_NoIDs_5);
	
	p_Entity_5 := output(p_Ent_NoIDs_5,,'~thor_data200::base::worldcheck_bridger::region_5_entity::'+filedate+'.xml', XML('MYROW', 
							HEADING('<Entity_List Count="'+entity_count_5+'">'
							,'</Entity_List></Watchlist>'), TRIM, OPT), overwrite);

	//Region 6---------------------------------------------------
	region_6 		:= sort(distribute(worldcheck_bridger.File_In_Country(region_id='6' and country_id<>''), hash(country_id)), country_id, local);

		standard_filter findRegion6(country_filter l, region_6 r):=transform
			self := l;
		end;

	joinReg6 		:= join(country_filter, region_6,
						trim(left.country_id, left, right) = right.country_id,
						findRegion6(left, right), local);
	
	dedup_ent6		:= dedup(sort(joinReg6, reference_id), record, all) : persist('~thor_200::persist::worldcheck::standard_mapping_region_6_dedup');

	entity_count_6	:= count(dedup_ent6(reference_id<>''));
	//output(entity_count_6, named('Region_6_Entity'));
	
	Layout_ent_child_6 := record
		dedup_ent6;
	end;
	
	Layout_ent_child_6 ent_Child6(dedup_ent6 l):= transform
		self := l;
	end;
	
	ds6 := project(dedup_ent6, ent_Child6(left));
		
	Layout_Ent_P6	:= record
		dataset(Layout_ent_child_6) Entity{xpath('Entity')};
	end;
	
	Layout_Ent_P6 t_Entity6(ds6 L) := transform
		self.Entity 	:= row(L, Layout_ent_child_6);
		self := L;
	end;

	p_Ent6 := project(ds6, t_Entity6(left));//: persist('~thor_600::persist::worldcheck::standard_mapping_region_6');
	
	Layout_Worldcheck_Entity removeIDs6(p_Ent6 l):= transform
		self := l;
	end;
	
	p_Ent_NoIDs_6 := project(p_Ent6, removeIDs6(left));
	//output(p_Ent_NoIDs_6);
	
	p_Entity_6 := output(p_Ent_NoIDs_6,,'~thor_data200::base::worldcheck_bridger::region_6_entity::'+filedate+'.xml', XML('MYROW', 
							HEADING('<Entity_List Count="'+entity_count_6+'">'
							,'</Entity_List></Watchlist>'), TRIM, OPT), overwrite);
						
	//Region 7---------------------------------------------------
	region_7 		:= sort(distribute(worldcheck_bridger.File_In_Country(region_id='7' and country_id<>''), hash(country_id)), country_id, local);

		standard_filter findRegion7(country_filter l, region_7 r):=transform
			self := l;
		end;

	joinReg7 		:= join(country_filter, region_7,
						trim(left.country_id, left, right) = right.country_id,
						findRegion7(left, right), local);
	
	dedup_ent7		:= dedup(sort(joinReg7, reference_id), record, all) : persist('~thor_200::persist::worldcheck::standard_mapping_region_7_dedup');

	entity_count_7	:= count(dedup_ent7(reference_id<>''));
	//output(entity_count_7, named('Region_7_Entity'));
	
	Layout_ent_child_7 := record
		dedup_ent7;
	end;
	
	Layout_ent_child_7 ent_Child7(dedup_ent7 l):= transform
		self := l;
	end;
	
	ds7 := project(dedup_ent7, ent_Child7(left));
		
	Layout_Ent_P7	:= record
		dataset(Layout_ent_child_7) Entity{xpath('Entity')};
	end;
	
	Layout_Ent_P7 t_Entity7(ds7 L) := transform
		self.Entity 	:= row(L, Layout_ent_child_7);
		self := L;
	end;

	p_Ent7 := project(ds7, t_Entity7(left));//: persist('~thor_700::persist::worldcheck::standard_mapping_region_7');
	
	Layout_Worldcheck_Entity removeIDs7(p_Ent7 l):= transform
		self := l;
	end;
	
	p_Ent_NoIDs_7 := project(p_Ent7, removeIDs7(left));
	
	//output(p_Ent_NoIDs_7);
	
	p_Entity_7 := output(p_Ent_NoIDs_7,,'~thor_data200::base::worldcheck_bridger::region_7_entity::'+filedate+'.xml', XML('MYROW', 
							HEADING('<Entity_List Count="'+entity_count_7+'">'
							,'</Entity_List></Watchlist>'), TRIM, OPT), overwrite);
							
	//Region 8---------------------------------------------------
	region_8 		:= sort(distribute(worldcheck_bridger.File_In_Country(region_id='8' and country_id<>''), hash(country_id)), country_id, local);

		standard_filter findRegion8(country_filter l, region_8 r):=transform
			self := l;
		end;

	joinReg8 		:= join(country_filter, region_8,
						trim(left.country_id, left, right) = right.country_id,
						findRegion8(left, right), local);
	
	dedup_ent8		:= dedup(sort(joinReg8, reference_id), record, all) : persist('~thor_200::persist::worldcheck::standard_mapping_region_8_dedup');
	
	entity_count_8	:= count(dedup_ent8(reference_id<>''));
	//output(entity_count_8, named('Region_8_Entity'));
	
	Layout_ent_child_8 := record
		dedup_ent8;
	end;
	
	Layout_ent_child_8 ent_Child8(dedup_ent8 l):= transform
		self := l;
	end;
	
	ds8 := project(dedup_ent8, ent_Child8(left));
		
	Layout_Ent_P8	:= record
		dataset(Layout_ent_child_8) Entity{xpath('Entity')};
	end;
	
	Layout_Ent_P8 t_Entity8(ds8 L) := transform
		self.Entity 	:= row(L, Layout_ent_child_8);
		self := L;
	end;

	p_Ent8 := project(ds8, t_Entity8(left));//: persist('~thor_800::persist::worldcheck::standard_mapping_region_8');
	
	Layout_Worldcheck_Entity removeIDs8(p_Ent8 l):= transform
		self := l;
	end;
	
	//p_Ent_NoIDs_8 := project(p_Ent8, removeIDs8(left));
		p_Entry_1 := PROJECT(dedup_ent1, Layout_XG);
		p_Entry_2 := PROJECT(dedup_ent2, Layout_XG);
		p_Entry_3 := PROJECT(dedup_ent3, Layout_XG);
		p_Entry_4 := PROJECT(dedup_ent4, Layout_XG);
		p_Entry_5 := PROJECT(dedup_ent5, Layout_XG);
		p_Entry_6 := PROJECT(dedup_ent6, Layout_XG);
		p_Entry_7 := PROJECT(dedup_ent7, Layout_XG);
		p_Entry_8 := PROJECT(dedup_ent8, Layout_XG);

	//output(p_Ent_NoIDs_8);
	
//	p_Entity_8 := output(p_Ent_NoIDs_8,,'~thor_data200::base::worldcheck_bridger::region_8_entity::'+filedate+'.xml', XML('MYROW', 
//							HEADING('<Entity_List Count="'+entity_count_8+'">'
//							,'</Entity_List></Watchlist>'), TRIM, OPT), overwrite);
	p_Region_1 := WriteXGFormat(p_Entry_1, StandardOptions(speciallistid=U'9'), 
										'~thor_data200::base::worldcheck_bridger::region_1_entity::'+filedate+'.xml', filedate);
	p_Region_2 := WriteXGFormat(p_Entry_2, StandardOptions(speciallistid=U'10'), 
										'~thor_data200::base::worldcheck_bridger::region_2_entity::'+filedate+'.xml', filedate);
	p_Region_3 := WriteXGFormat(p_Entry_3, StandardOptions(speciallistid=U'11'), 
										'~thor_data200::base::worldcheck_bridger::region_3_entity::'+filedate+'.xml', filedate);
	p_Region_4 := WriteXGFormat(p_Entry_4, StandardOptions(speciallistid=U'12'), 
										'~thor_data200::base::worldcheck_bridger::region_4_entity::'+filedate+'.xml', filedate);
	p_Region_5 := WriteXGFormat(p_Entry_5, StandardOptions(speciallistid=U'13'), 
										'~thor_data200::base::worldcheck_bridger::region_5_entity::'+filedate+'.xml', filedate);
	p_Region_6 := WriteXGFormat(p_Entry_6, StandardOptions(speciallistid=U'14'), 
										'~thor_data200::base::worldcheck_bridger::region_6_entity::'+filedate+'.xml', filedate);
	p_Region_7 := WriteXGFormat(p_Entry_7, StandardOptions(speciallistid=U'15'), 
										'~thor_data200::base::worldcheck_bridger::region_7_entity::'+filedate+'.xml', filedate);
	p_Region_8 := WriteXGFormat(p_Entry_8, StandardOptions(speciallistid=U'16'), 
										'~thor_data200::base::worldcheck_bridger::region_8_entity::'+filedate+'.xml', filedate);

	return 
				parallel(p_Region_1,
							p_Region_2,
							p_Region_3,
							p_Region_4,
							p_Region_5,
							p_Region_6,
							p_Region_7,
							p_Region_8);	

end;