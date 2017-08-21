EXPORT Layout_Watchlist := MODULE


export layout_aliases := RECORD,maxlength(15000)
    string id{xpath('@ID')};
    string type{xpath('Type')};
    string category{xpath('Category')};
    unicode title{xpath('Title')};
    unicode first_name{xpath('First_Name')};
    unicode middle_name{xpath('Middle_Name')};
    unicode last_name{xpath('Last_Name')};
    unicode generation{xpath('Generation')};
    unicode full_name{xpath('Full_Name')};
    unicode comments{xpath('Comments')};
   END;

export aka_rollup := RECORD,maxlength(15000)
   //string id;
   DATASET(Layout_Aliases) aka{xpath('AKA')};
  END;

export layout_addresses := RECORD,maxlength(25000)
    string id{xpath('@ID')};
    string type{xpath('Type')};
    unicode street_1{xpath('Street_1')};
    unicode street_2{xpath('Street_2')};
    unicode city{xpath('City')};
    unicode state{xpath('State')};
    unicode postal_code{xpath('Postal_Code')};
    unicode country{xpath('Country')};
    unicode comments{xpath('Comments')};
   END;

export addr_rollup := RECORD,maxlength(15000)
   //string id;
   DATASET(Layout_Addresses) address{xpath('Address')};
  END;

export layout_addlinfo := RECORD,maxlength(25000)
    string id{xpath('@ID')};
    string type{xpath('Type')};
    unicode information{xpath('Information')};
    unicode parsed{xpath('Parsed')};
    unicode comments{xpath('Comments')};
   END;

export addlinfo_rollup := RECORD,maxlength(15000)
   //string id;
   DATASET(Layout_AddlInfo) additionalinfo{xpath('AdditionalInfo')};
  END;

export layout_sp := RECORD,maxlength(15000)
    string id{xpath('@ID')};
    string type{xpath('Type')};
    unicode label{xpath('Label')};
    unicode number{xpath('Number')};
    unicode issued_by{xpath('Issued_By')};
    string date_issued{xpath('Date_Issued')};
    string date_expires{xpath('Date_Expires')};
    unicode comments{xpath('Comments')};
   END;

export id_rollup := RECORD,maxlength(15000)
   //string id;
   DATASET(Layout_SP) identification{xpath('Identification')};
  END;

export layout_phones := RECORD,maxlength(15000)
    string type{xpath('Type')};
    string address_id{xpath('Address_id')};
    unicode number{xpath('Number')};
    unicode comments{xpath('Comments')};
   END;

export phones_rollup := RECORD,maxlength(15000)
   //string id;
   DATASET(Layout_Phones) phones{xpath('Phone_Number')};
  END;
	
// incoming Watchlist format for individual files
export routp := RECORD,maxlength(64000)
  string id{xpath('@ID')};
  string type{xpath('Type')};
  string Entity_Unique_ID {xpath('Entity_Unique_ID')};
  unicode title{xpath('Title')};
  unicode first_name{xpath('First_Name')};
  unicode middle_name{xpath('Middle_Name')};
  unicode last_name{xpath('Last_Name')};
  unicode generation{xpath('Generation')};
  unicode full_name{xpath('Full_Name')};
  string gender{xpath('Gender')};
  string listed_date{xpath('Listed_Date')};
  string modified_date {xpath('Modified_Date')};
  string entity_added_by{xpath('Entity_Added_By')};
  string reason_listed{xpath('Reason_Listed')};
  string reference_id{xpath('Reference_Id')};
  unicode comments{xpath('Comments')};
  unicode search_criteria{xpath('Search_Criteria')};
  AKA_rollup aka_list{xpath('AKA_List')};
  Addr_rollup address_list{xpath('Address_List')};
  AddlInfo_rollup additional_info_list{xpath('Additional_Info_List')};
  ID_rollup identification_list{xpath('Identification_List')};
  phones_rollup phone_number_list{xpath('Phone_Number_List')};
 END;

// incoming Global Watchlist format
export rWatchList := RECORD,maxlength(64000)
  string WatchListName{xpath('@Watch_List_Name')};
  string id{xpath('@ID')};
  string WatchListDate{xpath('@Watch_List_Date')};
  string WatchListType{xpath('@Type')};
//  string accuityDataSource;
  string type{xpath('Type')};
  string Entity_Unique_ID {xpath('Entity_Unique_ID')};
  unicode title{xpath('Title')};
  unicode first_name{xpath('First_Name')};
  unicode middle_name{xpath('Middle_Name')};
  unicode last_name{xpath('Last_Name')};
  unicode generation{xpath('Generation')};
  unicode full_name{xpath('Full_Name')};
  string gender{xpath('Gender')};
  string listed_date{xpath('Listed_Date')};
  string modified_date {xpath('Modified_Date')};
  string entity_added_by{xpath('Entity_Added_By')};
  string reason_listed{xpath('Reason_Listed')};
  string reference_id{xpath('Reference_ID')};
  unicode comments{xpath('Comments')};
  unicode search_criteria{xpath('Search_Criteria')};
  AKA_rollup aka_list{xpath('AKA_List')};
  Addr_rollup address_list{xpath('Address_List')};
  AddlInfo_rollup additional_info_list{xpath('Additional_Info_List')};
  ID_rollup identification_list{xpath('Identification_List')};
  phones_rollup phone_number_list{xpath('Phone_Number_List')};
 END;
/* 
export ds_standard := record
 DATASET(rOutP) entity{xpath('Entity')}
end;
*/
export CountryAKA_location := RECORD,maxlength(150)
    string type{xpath('Type')};
    unicode name{xpath('Name')};
   END;
   
export CountryAKA_rollup := RECORD,maxlength(15000)
   //string id;
   DATASET(CountryAKA_location) aka{xpath('AKA')};
  END;
 
export layout_location := RECORD,maxlength(150)
    string lid{xpath('@ID')};
    string type{xpath('Type')};
    unicode name{xpath('Name')};
   END;

export Location_rollup := RECORD,maxlength(15000)
   //string id;
   DATASET(layout_location) location{xpath('Location')};
  END;

export rgeo := RECORD,maxlength(64000)
  string WatchListName{xpath('@Watch_List_Name')};
  string id{xpath('@ID')};
  string WatchListDate{xpath('@Watch_List_Date')};
  string WatchListType{xpath('@Type')};
  unicode Country_Name{xpath('Country_Name')};
  string Entity_Unique_ID {xpath('Entity_Unique_ID')};
  string listed_date{xpath('Listed_Date')};
  string reason_listed{xpath('Reason_Listed')};
  string reference_id{xpath('Reference_Id')};
  unicode comments{xpath('Comments')};
  CountryAKA_rollup aka_list{xpath('AKA_List')};
  Location_rollup location_list{xpath('Location_List')};
END;

export rgeoOut := 
	rgeo - WatchListName - WatchListDate - WatchListType;


export ds_location := record
 DATASET(rgeo) entity{xpath('Country')}
end;


END;