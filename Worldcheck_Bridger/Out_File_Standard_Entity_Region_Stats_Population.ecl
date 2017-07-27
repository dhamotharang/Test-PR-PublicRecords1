#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import ut, strata;

export Out_File_Standard_Entity_Region_Stats_Population (string filedate) := function

//MAIN FILE//////////////////////////////////////////////////////////////////////	
	//Flatten MAIN File
	layout_aliases := RECORD
		string type{xpath('Type')};
		string category{xpath('Category')};
		unicode first_name{xpath('First_Name')};
		unicode middle_name{xpath('Middle_Name')};
		unicode last_name{xpath('Last_Name')};
		unicode generation{xpath('Generation')};
		unicode full_name{xpath('Full_Name')};
		string comments{xpath('Comments')};
	   END;

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
	
	//output(count(dedup(sort(dsMain, reference_id), record, all)));
	
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
		  string region;			//append region field
		  string category;			//append category field
	end;
	
	dsMainFlatLayout dsMainFlatFix(dsMain l):= transform
		self.region				:= trim(l.search_criteria[3..stringlib.stringfind(l.search_criteria,';',1)-1], left, right);
		self.category 			:= trim(l.comments[stringlib.stringfind(l.comments, 'Category:', 1)+10..(stringlib.stringfind(l.comments, 'Category:', 1) + stringlib.stringfind(l.comments[stringlib.stringfind(l.comments, 'Category:', 1)..length(l.comments)], '||', 1)-2)], left, right); 
		self 					:= l;
	end;
	
	dsMainFl 	:= project(dsMain, dsMainFlatFix(left));
	dsMainFlat	:= sort(distribute(dsMainFl, hash(region)), region, local);
	region_1 	:= sort(distribute(worldcheck_bridger.File_In_Country(region_id<>'' and country_id<>''), hash(country_id)), country_id, local);

		dsMainFlatLayout findRegion1(dsMainFlat l, region_1 r):=transform
			self.region := r.region_id;
			self 		:= l;
		end;

	joinReg1 		:= join(dsMainFlat, region_1,
							trim(left.region, left, right) = right.country_id,
							findRegion1(left, right), local);
	
	dedup_ent1		:= dedup(sort(joinReg1, reference_id), record, all);
	
	//Breakdown Count By Region
	rec := record
		dedup_ent1.region;
		dedup_ent1.category;
		countgroup := count(group);
	end;

	out  := table(dedup_ent1,
					rec,
					dedup_ent1.region,
					dedup_ent1.category);

	STRATA.createXMLStats(out
					 ,'World Check - Bridger'
					 ,'Standard Entity Region'
					 ,filedate
					 ,''
					 ,zMain
					 ,
					 ,'population');
	
return zMain;

end;