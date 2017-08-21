// BWR_UsefulContent_CorpAddress1TypeDesc.ecl
import CorpFilingsFreeTextFieldAnalysis;

useful_content_layout := CorpFilingsFreeTextFieldAnalysis.useful_content_layout;

corp_address1_type_desc_useful_content_layout := RECORD
  string70  corp_address1_line1;
  string70  corp_address1_line2;
  string70  corp_address1_line3;
  string70  corp_address1_line4;
  string70  corp_address1_line5;
  string70  corp_address1_line6;
  useful_content_layout AND NOT desired_content AND NOT desired_content_pos AND NOT corp_status_desc AND NOT corp_status_date
END;

corp_address1_type_desc_useful_content_layout fillAddress1TypeDescUsefulContent( Corp2.Layout_Corporate_Direct_Corp_AID l ) := TRANSFORM
   self.content_type := 'ALL NONBLANK RECORDS';
       
   self.filename            := 'thor_data400::base::corp2::qa::corp_aid';
   self.fieldname           := 'corp_address1_type_desc';
   self.fieldvalue          := l.corp_address1_type_desc;
   self := l;
END;

  CorpFilingsFreeTextFieldAnalysis.mac_findFreeTextFieldUsefulContent(
   fillAddress1TypeDescUsefulContent
   ,''
   ,'thor_data400::base::corp2::qa::corp_aid'
   ,Corp2.Layout_Corporate_Direct_Corp_AID
   ,corp_address1_type_desc
   ,Corp_AID_Address1_Type_Desc_0
   ,'all'
  );
  Corp_AID_Address1_Type_Desc := Corp_AID_Address1_Type_Desc_0 : persist('thumphrey::persist::all::corp_address1_type_desc::useful_content');
  output(count(Corp_AID_Address1_Type_Desc),named('c_Corp_AID_Address1_Type_Desc')); 
  output(Corp_AID_Address1_Type_Desc,named('Corp_AID_Address1_Type_Desc')); 
