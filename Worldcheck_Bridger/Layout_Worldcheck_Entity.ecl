layout_aliases := RECORD
    string type{xpath('Type')};
    string category{xpath('Category')};
    unicode first_name{xpath('First_Name')};
    unicode middle_name{xpath('Middle_Name')};
    unicode last_name{xpath('Last_Name')};
    unicode generation{xpath('Generation')};
    unicode full_name{xpath('Full_Name')};
    unicode comments{xpath('Comments')};
   END;

aka_rollup := RECORD
   //string id;
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
   //string id;
   DATASET(Layout_Addresses) address{xpath('Address')};
  END;

layout_addlinfo := RECORD
    string type{xpath('Type')};
    string information{xpath('Information')};
    string parsed{xpath('Parsed')};
    string comments{xpath('Comments')};
   END;

addlinfo_rollup := RECORD
   //string id;
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
   //string id;
   DATASET(Layout_SP) identification{xpath('Identification')};
  END;

layout_phones := RECORD
    string type;
    string address_id;
    string number;
    string comments;
   END;

phones_rollup := RECORD
   //string id;
   DATASET(Layout_Phones) phones{xpath('Phones_Number')};
  END;

routp := RECORD
  string id{xpath('@ID')};
  string eui{xpath('Entity_Unique_ID')};
  string type{xpath('Type')};
  string title{xpath('Title')};
  string first_name{xpath('First_Name')};
  string middle_name{xpath('Middle_Name')};
  string last_name{xpath('Last_Name')};
  string generation{xpath('Generation')};
  unicode full_name{xpath('Full_Name')};
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

ds_standard := record
 DATASET(rOutP) entity{xpath('Entity')}
end;

export Layout_Worldcheck_Entity := ds_standard;