#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import ut, lib_stringlib, worldcheck, worldcheck_bridger;

export Mapping_Search_Criteria_Region_8 (string filedate):= function

//WORLDCHECK USA

//BUILDINFO/////////////////////////////////////////////////////////////

	//Category
	ds_Category := Worldcheck_Bridger.File_In_Category;

	layout_Category := record
		string id{xpath('@id')};
		string name{xpath('@name')};
		string x{xpath('@x')};
	end;

	layout_Category catgTran(ds_Category l):= transform
		self.id 	:= l.Category_id;
		self.name 	:= l.Category;
		self.x		:= l.x;
	end;

	ds_Category_proj := sort(project(ds_Category, catgTran(left)), name);

	rollup_group_catg := record
		string id{xpath('@id')};
		string name{xpath('@name')};
		dataset(layout_Category) value{xpath('value')};
	end;
	
	rollup_group_catg t_cgy(ds_Category_proj L) := transform
		self.value 	:= row(L, layout_Category);
		self.id		:= '2';
		self.name	:= 'Category';
		self := L;
	end;

	p_cgy := project(ds_Category_proj, t_cgy(left));

	rollup_group_catg  t_cgy_child(p_cgy L, p_cgy R) := transform
		self.value   	:= L.value + row({r.value[1].id,
													r.value[1].name,
													r.value[1].x}
												   ,layout_Category);
		self              		:= L;
	end;

	Category_out := rollup(sort(p_cgy,name)
						, t_cgy_child(left,right)
						, ID);
						
	Layout_Catg_rollup	:= record
		rollup_group_catg group;
	end;

	Layout_Catg_rollup t_catg2(category_out L) := transform
		self.group	:=	L;
	end;

	proj_category := project(category_out, t_catg2(left));

	//UPDATE FOR PREMIUM PLUS**************************************
	
	//Sub-Category
	ds_SCategory := Worldcheck_Bridger.File_In_SubCategory;
	
	//**************************************************************
	
	layout_SCategory := record
		string id{xpath('@id')};
		string name{xpath('@name')};
		string x{xpath('@x')};
	end;

	layout_SCategory scatTran(ds_SCategory l):= transform
		self.id 	:= l.SubCategory_id;
		self.name 	:= l.SubCategory;
		self.x		:= l.x;
	end;

	ds_SCategory_proj := sort(project(ds_SCategory, scatTran(left)), name);

	rollup_group_scat := record
		string id{xpath('@id')};
		string name{xpath('@name')};
		dataset(layout_SCategory) value{xpath('value')};
	end;
	
	rollup_group_scat t_scat(ds_SCategory_proj L) := transform
		self.value 	:= row(L, layout_SCategory);
		self.id		:= '3';
		self.name	:= 'Sub Category';
		self := L;
	end;

	p_scat := project(ds_SCategory_proj, t_scat(left));

	rollup_group_scat  t_scat_child(p_scat L, p_scat R) := transform
		self.value   	:= L.value + row({r.value[1].id,
									r.value[1].name,
									r.value[1].x}
									,layout_SCategory);
		self              		:= L;
	end;

	SCategory_out := rollup(sort(p_scat,name)
						, t_scat_child(left,right)
						, ID);
	
	Layout_scat_rollup	:= record
		rollup_group_scat group;
	end;

	Layout_scat_rollup t_scatg2(scategory_out L) := transform
		self.group	:=	L;
	end;

	proj_scategory := project(scategory_out, t_scatg2(left));

	//Deceased
	ds_Deceased := Worldcheck_Bridger.File_In_DeceasedState;

	layout_Deceased := record
		string id{xpath('@id')};
		string name{xpath('@name')};
		string x{xpath('@x')};
	end;

	layout_Deceased decTran(ds_Deceased l):= transform
		self.id 	:= l.DeceasedState_id;
		self.name 	:= l.DeceasedState;
		self.x		:= l.x;
	end;

	ds_Deceased_p 		:= project(ds_Deceased, decTran(left));
	ds_Deceased_val		:= sort(ds_Deceased_p(id<>'9'), name);
	ds_Deceased_nval	:= ds_Deceased_p(id='9');
	
	ds_Deceased_proj := ds_Deceased_nval + ds_Deceased_val; //'No Value' on top

	rollup_group_dec := record
		string id{xpath('@id')};
		string name{xpath('@name')};
		dataset(layout_Deceased) value{xpath('value')};
	end;
	
	rollup_group_dec t_dec(ds_Deceased_proj L) := transform
		self.value 	:= row(L, layout_Deceased);
		self.id		:= '4';
		self.name	:= 'Deceased State';
		self := L;
	end;

	p_dec := project(ds_Deceased_proj, t_dec(left));

	rollup_group_dec  t_dec_child(p_dec L, p_dec R) := transform
		self.value   	:= L.value + row({r.value[1].id,
													r.value[1].name,
													r.value[1].x}
												   ,layout_Deceased);
		self            := L;
	end;

	Deceased_out := rollup(sort(p_dec,name)
						, t_dec_child(left,right)
						, ID);
	
	Layout_dec_rollup	:= record
		rollup_group_dec group;
	end;

	Layout_dec_rollup t_dec2(deceased_out L) := transform
		self.group	:=	L;
	end;

	proj_deceased := project(deceased_out, t_dec2(left));

	//Keyword
	ds_keyword := Worldcheck_Bridger.File_In_Keyword;

	layout_keyword := record
		string id{xpath('@id')};
		string name{xpath('@name')};
		string x{xpath('@x')};
	end;

	layout_keyword keyTran(ds_keyword l):= transform
		self.id 	:= l.keyword_id;
		self.name 	:= l.keyword;
		self.x		:= l.x;
	end;

	ds_keyword_p 			:= project(ds_keyword, keyTran(left));
	ds_keyword_val		:= sort(ds_keyword_p(id<>'9999'), name);
	ds_keyword_nval		:= ds_keyword_p(id='9999');
	
	ds_keyword_proj 	:= ds_keyword_nval + ds_keyword_val; //'No Value' on top

	rollup_group_kw := record
		string id{xpath('@id')};
		string name{xpath('@name')};
		dataset(layout_keyword) value{xpath('value')};
	end;
	
	rollup_group_kw t_kw(ds_keyword_proj L) := transform
		self.value 	:= row(L, layout_keyword);
		self.id		:= '5';
		self.name	:= 'Keyword';
		self := L;
	end;

	p_kw := project(ds_keyword_proj, t_kw(left));

	rollup_group_kw   t_kw_child(p_kw L, p_kw R) := transform
		self.value   	:= L.value + row({r.value[1].id,
													r.value[1].name,
													r.value[1].x}
												   ,layout_keyword);
		self              		:= L;
	end;

	kw_out := rollup(sort(p_kw,name)
						, t_kw_child(left,right)
						, ID);
						
	Layout_kw_rollup	:= record
		rollup_group_kw group;
	end;

	Layout_kw_rollup t_kw2(kw_out L) := transform
		self.group	:=	L;
	end;

	proj_keyword := project(kw_out, t_kw2(left));

common_groupings :=  proj_keyword + proj_deceased + proj_scategory + proj_category;// : persist('~thor_200::persist::worldcheck::search_criteria_header_region_common_grouping');

//Country -------------------------------------------------------------------------
	
	//CHANGE FOR STANDARD********************************
	
	ds_country_1 := Worldcheck_Bridger.File_In_Country(Region_id='8');

	//***************************************************
	
	layout_Country := record
		string id{xpath('@id')};
		string name{xpath('@name')};
		string x{xpath('@x')};
	end;

	layout_Country count1Tran(ds_country_1 l):= transform
		self.id 	:= l.Country_id;
		self.name 	:= l.Country;
		self.x		:= l.x;
	end;

	ds_country_1_proj := sort(project(ds_country_1, count1Tran(left)), name);

	rollup_group_count1 := record
		string id{xpath('@id')};
		string name{xpath('@name')};
		dataset(layout_Country) value{xpath('value')};
	end;
	
	rollup_group_count1 t_cnt1(ds_country_1_proj L) := transform
		self.value 	:= row(L, layout_Country);
		self.id		:= '1';
		self.name	:= 'Country';
		self := L;
	end;

	p_cnt1 := project(ds_country_1_proj, t_cnt1(left));
	
	rollup_group_count1  t_cnt1_child(p_cnt1 L, p_cnt1 R) := transform
		self.value   	:= L.value + row({r.value[1].id,
													r.value[1].name,
													r.value[1].x}
												   ,layout_Country);
		self            := L;
	end;

	country_out1 := rollup(sort(p_cnt1,name)
						, t_cnt1_child(left,right)
						, ID);					
						
	Layout_country_rollup1	:= record
		rollup_group_count1	group;
	end;

	Layout_country_rollup1 t_country1(country_out1 L) := transform
		self.group	:=	L;
	end;

	proj_country_1 	:= project(country_out1, t_country1(left));
	
	region_1 		:= proj_country_1 + common_groupings;
	//proj_country_all := proj_country_1 + common_groupings;
		
		
	//Add SearchCriteria Tags
	Layout_country_rollup2	:= record
		Layout_country_rollup1	SearchCriteria;
	end;
	
	Layout_country_rollup2 t_country12(region_1 L) := transform
		self.SearchCriteria	:=	L;
	end;

	proj_country_all 	:= project(region_1, t_country12(left));
	
	//Append ListInfo
	Layout_Add := record
		string ids;
		integer numrows;
		proj_country_all;
	end;

	Layout_add addNum(proj_country_all l):= transform
		self.ids 			:= '1';
		self.numrows		:= 0;
		self				:= l;
	end;
	
	addField 					:= sort(project(proj_country_all, addNum(left)), record);
	
	dcountry_rollup1_blank 		:= dataset([],Layout_country_rollup1);
	
	File_In_Subcat	:= dataset([{
							 '1'
							,0
							,'Entity'
							,'92D0B442-E3F3-4b84-94C9-D42D219391D4'
							,'WORLDCHECK USA'
							,'WorldCheck - United States Residents and Citizens'
							,'16'
							,'False'
							,''
							,dcountry_rollup1_blank
							}],
							{string ids{xpath('ids')}, integer numrows{xpath('numrows')}, string Type{xpath('Type')}, string ID{xpath('ID')}, string name{xpath('Name')}, string description{xpath('Description')}, string speciallistid{xpath('SpecialListID')}, string encrypt{xpath('Encrypt')}, string publication{xpath('Publication')}, dataset(Layout_country_rollup1) SearchCriteria});
	
	//*********************************************************************************

	Layout_country_rollup1 fReformatsearchcriteria(Layout_country_rollup1 pRow) :=transform
		self				:= pRow;
	end;

	File_In_Subcat denormCIT(File_In_Subcat l,  addField r, integer c) := transform
		self.NumRows 		:= C;
		self.ids			:= l.ids;
		self.Type 			:= l.type;
		self.ID 			:= l.id;
		self.Name 			:= l.name;
		self.Description 	:= l.description;
		self.SpecialListID	:= l.speciallistid;
		self.Encrypt 		:= l.encrypt;
		self.Publication 	:= trim(ut.GetDate[1..4]+'-'+ut.GetDate[5..6]+'-'+ut.GetDate[7..8], left, right)+'T12:00:00.0000000Z'; //Run Date			
		self.SearchCriteria := l.SearchCriteria + row(fReformatsearchcriteria(r.SearchCriteria));
	end;

	concat_c  	:= denormalize(File_In_Subcat,addField,
							left.ids = right.ids,
							denormCIT(left, right, counter));
							
	reform_Layout := record
		string Type			{xpath('Type')}; 
		string ID			{xpath('ID')}; 
		string name			{xpath('Name')}; 
		string description	{xpath('Description')};
		string speciallistid{xpath('SpecialListID')};
		string encrypt		{xpath('Encrypt')}; 
		string publication	{xpath('Publication')};
		dataset(Layout_country_rollup1) SearchCriteria;
	end;
	
	//Remove numrow field
	reform_Layout reformTran(concat_C  l):= transform
		self := l;
	end;
	
	reform_ds := project(concat_c, reformTran(left));
	//output(reform_ds, named('reform_ds'));
	
	//Add ListInfo Tags
	Layout_list_info	:= record
		reform_Layout	ListInfo{xpath('ListInfo')};
	end;
	
	Layout_list_info t_listinfo(reform_ds L) := transform
		self.ListInfo	:=	L;
	end;

	list_info_all 		:= project(reform_ds, t_listinfo(left));
	
	//Add BuildInfo Tag
		Layout_add_field2 := record
		list_info_all;
		string ids;
		integer numrows;
	end;

	Layout_add_field2 addInfo2(list_info_all l):= transform
		self.ids 		:= '1';
		self.numrows	:= 0;
		self 			:= l;
	end;
	
	addInfo := project(list_info_all, addInfo2(left));
	//output(addInfo, named('addInfo'));
	
	listInfo_ds 		:= dataset([],reform_Layout);

	reform_Layout fReformatlistInfo(reform_Layout pRow2):= transform
		self := pRow2;
	end;
		
	//Add UserInfo Tag
	ds_ClientID 		:= dataset([{'WorldCheck'}],
								{string ClientID{xpath('ClientID')}});
	
	Layout_ClientID := record
		string ClientID{xpath('ClientID')};
	end;
	
	ds_OutputType 		:= dataset([{'W32Bit'}],
								{string OutputType{xpath('OutputType')}});
								
	Layout_OutputType := record
		string OutputType{xpath('OutputType')};
	end;

	File_In_User := dataset([{'1', 0, reform_ds, ds_clientID, 'W32Bit'}], 
							{string ids, integer numrows, dataset(reform_layout) ListInfo{xpath('ListInfo')}, dataset(Layout_ClientID) UserInfo{xpath('UserInfo')}, string OutputType{xpath('OutputType')}});
							
	reform_layout fReformatUser2(reform_layout pRow2):= transform
		self := pRow2;
	end;
	
	File_In_User denormUI(File_In_User l, addInfo r, integer c) := transform
		self.NumRows 		:= C;
		self.ids			:= l.ids;
		self.ListInfo		:= l.ListInfo;
		self.UserInfo		:= l.UserInfo;
		self.OutputType		:= l.OutputType;
	end;
	
	concat_C3 	:= denormalize(File_In_User, addInfo,
							left.ids = right.ids,
							denormUI(left, right, counter));
	
	//output(concat_c3, named('concat_c3'));
	
	//remove numrows and ids
	reform_Layout2 := record
		dataset(reform_Layout) ListInfo{xpath('ListInfo')};
		dataset(Layout_ClientID) UserInfo{xpath('UserInfo')};
		string OutputType{xpath('OutputType')}; 
	end;
	
	reform_layout2 refSlim(concat_c3 l):= transform
		self := l;
	end;
	
	slimInfo := project(concat_c3, refSlim(left));
	
	//Add BuildInfo Tags
	Layout_BuildInfo_child := record
		slimInfo;
	end;
		
	Layout_BuildInfo_P	:= record
		dataset(Layout_BuildInfo_child) BuildInfo{xpath('BuildInfo')};
	end;
	
	Layout_BuildInfo_P t_Build(slimInfo L) := transform
		self.BuildInfo 	:= row(L, Layout_BuildInfo_child);
		self := L;
	end;

p_Build 	:= project(slimInfo, t_Build(left)):persist('~thor_data200::persist::worldcheck_bridger::region_8_search::'+filedate);
	
return 	output(p_Build,,'~thor_data200::base::worldcheck_bridger::region_8_search::'+filedate+'.xml', XML('', 
						HEADING('<?xml version="1.0" encoding="utf-8"?>'+
						'<Watchlist>'
						,''), TRIM, OPT), overwrite);

end;