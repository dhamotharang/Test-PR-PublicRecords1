/***
Unicode version ... eventually the non-unicode version will be deprecated
**/

EXPORT Layout_XG := MODULE

export layout_aliases := RECORD,maxlength(15000)
    string type{xpath('Type')};
    string category{xpath('Category')};
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
   DATASET(Layout_Addresses) address{xpath('Address')} ;
  END;

export layout_addlinfo := RECORD,maxlength(25000)
    string type{xpath('Type')};
    unicode information{xpath('Information')};
    string parsed{xpath('Parsed')};
    unicode comments{xpath('Comments')};
   END;

export addlinfo_rollup := RECORD,maxlength(15000)
   //string id;
   DATASET(Layout_AddlInfo) additionalinfo{xpath('AdditionalInfo')};
  END;

export layout_sp := RECORD,maxlength(15000)
    string type{xpath('Type')};
    string label{xpath('Label')};
    string number{xpath('Number')};
    string issued_by{xpath('Issued_By')};
    string date_issued{xpath('Date_Issued')};
    string date_expires{xpath('Date_Expires')};
    string comments{xpath('Comments')};
   END;

export id_rollup := RECORD,maxlength(15000)
   //string id;
   DATASET(Layout_SP) identification{xpath('Identification')};
  END;

export layout_phones := RECORD,maxlength(15000)
    string type{xpath('Type')};
    string address_id{xpath('Address_id')};
    string number{xpath('Number')};
    string comments{xpath('Comments')};
   END;

export phones_rollup := RECORD,maxlength(15000)
   //string id;
   DATASET(Layout_Phones) phones{xpath('Phone_Number')};
  END;

export routp := RECORD,maxlength(64000)
  unsigned8 id{xpath('@ID')};
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
  unicode reason_listed{xpath('Reason_Listed')};
  string reference_id{xpath('Reference_Id')};
  unicode comments{xpath('Comments')};
  string search_criteria{xpath('Search_Criteria')};
  AKA_rollup aka_list{xpath('AKA_List')};
  Addr_rollup address_list{xpath('Address_List')};
  AddlInfo_rollup additional_info_list{xpath('Additional_Info_List')};
  ID_rollup identification_list{xpath('Identification_List')};
  phones_rollup phone_number_list{xpath('Phone_Number_List')};
 END;
 
export ds_standard := record
 DATASET(rOutP) entity{xpath('Entity')}
end;

END;