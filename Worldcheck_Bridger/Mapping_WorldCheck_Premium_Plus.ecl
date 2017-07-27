#workunit('priority', 'high')

import worldcheck_bridger, std;

export Mapping_WorldCheck_Premium_Plus(string filedate) := function

in_f 			:= File_WorldCheck_Premium_In;

//POPULATE COMPANIES AND LINKED TOS
in_comp_l 		:= Find_Companies_and_Linked_Tos(in_f);

//POPULATE KEYWORDS
map_keyword	:= Normalize_Keywords(in_comp_l);
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
			sub_category_comment	:= if(l.sub_category<>'', 'Sub-Category: '+ trim(_functions.Find_SubCategory_Premium_Full_Name(trim(l.sub_category, left, right)), left, right)+' || ', 'Sub-Category: Non-PEP || ');
			companies_comment		:= if(l.companies<>'', 'Companies: '+' | '+trim(l.companies, left, right)+' || ', '');
			associations_comment	:= if(l.linked_tos<>'', 'Associations: '+' | '+trim(l.linked_tos, left, right)+' || ', '');
			keywords_comment		:= if(l.keywords<>'', 'Keywords: '+trim(l.keywords, left, right)+' || ', '');
			date_entered_comment	:= if(l.entered<>'', 'Date Entered: '+_Functions.Fix_Date(trim(l.entered, left, right))+' | ', '');
			date_updated_comment	:= if(l.updated<>'', 'Date Updated: '+_Functions.Fix_Date(trim(l.updated, left, right))+' | ', '');
			further_info_comment	:= if(l.further_information<>'', 'Further Information: '+trim(l.further_information, left, right)+' ', '');
			//external_source_comment	:= if(l.external_sources<>'', 'External Sources: '+trim(l.external_sources, left, right)+' ', '');
		
		self.comments				:= deceased_comment + age_comment + category_comment + sub_category_comment + companies_comment + associations_comment + keywords_comment + date_entered_comment + date_updated_comment + further_info_comment;// + external_source_comment;
		
			populate_country_id 	:= if(_functions.Find_Country_ID(l.countries)<>'',
											'1,'+trim(_functions.Find_Country_ID(l.countries), left, right)+';',
											'');									
			populate_category 		:= if(_functions.Find_Category(l.category)<>'',
											'2,'+trim(_functions.Find_Category(l.category), left, right)+';',
											'');
			populate_subcategory 	:= if(_functions.Find_SubCategory_Premium(l.sub_category)<>'',
											'3,'+trim(_functions.Find_SubCategory_Premium(l.sub_category), left, right)+';',
											'3,20;');
			populate_deceased 		:= if(_functions.Find_DeceasedState(l.date_of_death)<>'',
											'4,'+trim(_functions.Find_DeceasedState(l.date_of_death), left, right)+';',
											'4,9;');
			
			populate_keyword		:= if(l.names<>'',
											'5,'+trim(l.names, left, right)+';',
											'5,9999;');
		
		self.search_criteria 		:= populate_country_id + populate_category + populate_subcategory + populate_deceased + StringLib.StringFilter(populate_keyword, '0123456789,;');
	
	end;

ds_entity := project(map_keywords, entityTran(left));// : persist('~thor_200::persist::worldcheck::entity_premium_plus_mapping');

//POPULATE AKAS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	map_akas_altspell 	:= Mapping_AKAs_and_AltSpell(in_f);
	map_low_qual_akas	:= Mapping_Low_Quality_AKAs(in_f);
	map_native_char		:= Mapping_Native_Character;
	
	//Concat AKAs and Alt Spelling with Low Quality AKAs
	concat_AKAs1			:= map_akas_altspell + map_low_qual_akas + map_native_char;
	
	rec := record
	 concat_AKAs1.id;
	 count_ := count(group);
	end;

	out_count  := table(concat_AKAs1,
								rec,
								concat_AKAs1.id);

	count_layout := RECORD
		concat_AKAs1;
		integer count_;
	end;

	count_layout join_akas(concat_AKAs1 l, out_count r):= transform
	  self.count_ := (integer)r.count_;
		self := l;
	end;

	counts_added 		:= join(concat_AKAs1
															,out_count
															,left.id = right.id
															,join_akas(left,right)
															,full outer);
															
	ds_max_akas			:= counts_added((integer)count_ > 254);
	
	Layout_temp3 := record	
		count_layout;
		unicode orig_First_Name;
		unicode orig_Middle_Name;
		unicode orig_Last_Name;
		unicode orig_Full_Name;
		unicode orig_name_alias;
	end;
	
	Layout_temp3 tr(ds_max_akas L) := transform
		self.orig_First_Name		:= l.First_Name;
		self.orig_Middle_Name		:= l.Middle_Name;	
		self.orig_Last_Name			:= l.Last_Name;
		self.orig_Full_Name			:= l.Full_Name;
		self.orig_name_alias		:= l.name_alias;
		self.first_name 	:= STD.Uni.ToUpperCase(L.first_name);
		self.middle_name 	:= STD.Uni.ToUpperCase(L.middle_name);
		self.last_name 		:= STD.Uni.ToUpperCase(L.last_name);
		self.full_name 		:= STD.Uni.ToUpperCase(L.full_name);
		self.name_alias 	:= STD.Uni.ToUpperCase(L.name_alias);
		self := L;
	end;

	ds_max_akas_fixed1 := dedup(sort(PROJECT(ds_max_akas, tr(LEFT)), record), record, except count_, orig_First_Name, orig_Middle_Name, orig_Last_Name, orig_Full_Name, orig_name_alias);
	
	
	counts_added trOriginalNames(ds_max_akas_fixed1 l) := TRANSFORM
			self.First_Name  	:= l.orig_First_Name;	
			self.Middle_Name 	:= l.orig_Middle_Name;		
			self.Last_Name 	 	:= l.orig_Last_Name;	
			self.Full_Name 	 	:= l.orig_Full_Name;
			self.name_alias	 	:= l.orig_name_alias;
   		self 							:= l;
 	END;
	
	ds_max_akas_fixed := project(ds_max_akas_fixed1, trOriginalNames(left));
	
	ds_ok_akas				:= counts_added((integer)count_ <= 254);

	all_akas	:= ds_max_akas_fixed + ds_ok_akas;
	
	concat_AKAs1 oldReform(all_akas l):=transform
		self := l;
	end;

	concat_AKAs := project(all_akas, oldReform(left));

	//Standard Layout	
	Layout_Aliases := record
		string Type{xpath('Type')};
		string Category{xpath('Category')};
		unicode First_Name{xpath('First_Name')};
		unicode Middle_Name{xpath('Middle_Name')};
		unicode Last_Name{xpath('Last_Name')};
		unicode Generation{xpath('Generation')};
		unicode Full_Name{xpath('Full_Name')};
		string Comments{xpath('Comments')};
	end;
	
	// Rollup of Akas and Alternative Spellings
	AKA_rollup := record
		string ID;
		dataset(Layout_Aliases) AKA{xpath('AKA')};
		//string ID;
	end;

	AKA_rollup t_Aliases(concat_AKAs L) := transform
		self.AKA 	:= row(L, Layout_Aliases);
		self := L;
	end;

	p_AKA := project(concat_AKAs, t_Aliases(left));

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
					,id);//: persist('~thor_200::persist::worldcheck::aka');
					
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
									,LEFT OUTER);

//POPULATE ADDRESSES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
map_and_rollup_addr := Mapping_and_Rollup_Addresses_Premium(in_f);

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
									,LEFT OUTER);

//POPULATE ADDITIONAL INFO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
map_and_rollup_addlinfo := Mapping_and_Rollup_AddlInfo(in_f);

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
											,LEFT OUTER);
									
//POPULATE ID INFO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
map_and_rollup_ids := Mapping_and_Rollup_IDs(in_f);

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

	Join_ID 	:= join(Join_Entity_AKA_Addr_AddlInfo
												,pr_ids
												,left.reference_ID = right.Identification_List.ID
												,join_IDs(left,right)
												,LEFT OUTER);//: persist('~thor_200::persist::worldcheck::premium_plus_mapping');

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
									,LEFT OUTER): persist('~thor_200::persist::worldcheck::premium_mapping');
	
	dedup_ent1 			:= dedup(sort(Join_phone_all, reference_id), record, all): persist('~thor_200::persist::worldcheck::premium_plus_mapping_dedup');
	
	
	entity_count_1		:= count(dedup_ent1(reference_id<>''));
	//output(entity_count_1, named('Premium_Plus_Entity'));
	
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
	
	
 return output(p_Ent_NoIDs_1,,'~thor_data200::base::worldcheck_bridger::premium_plus_entity::'+filedate+'.xml', XML('', 
   								HEADING('<Entity_List Count="'+entity_count_1+'">'
   								,'</Entity_List></Watchlist>'), TRIM, OPT), overwrite);
end;