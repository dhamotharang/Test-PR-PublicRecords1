// BWR_UsefulContent_ContTitleDesc.ecl
import CorpFilingsFreeTextFieldAnalysis;

useful_content_layout := CorpFilingsFreeTextFieldAnalysis.useful_content_layout;

cont_title_desc_useful_content_layout := RECORD
  string100 cont_name;
  useful_content_layout 
    AND NOT desired_content
    AND NOT desired_content_pos
    AND NOT corp_status_desc
    AND NOT corp_status_date
END;

cont_title_desc_useful_content_layout fillTtileDescUsefulContent( Corp2.Layout_Corporate_Direct_Cont_AID l ) := TRANSFORM
   self.content_type := 'ALL NONBLANK RECORDS';
       
   self.filename            := 'thor_data400::base::corp2::qa::cont_aid';
   self.fieldname           := 'cont_title_desc';
   self.fieldvalue          := l.cont_title_desc;
   self := l;
END;

CorpFilingsFreeTextFieldAnalysis.mac_findFreeTextFieldUsefulContent(
 fillTtileDescUsefulContent
 ,''
 ,'thor_data400::base::corp2::qa::cont_aid'
 ,Corp2.Layout_Corporate_Direct_Cont_AID
 ,cont_title_desc
 ,Cont_AID_Title_Desc_0
 ,'all'
);

Cont_AID_Title_Desc := Cont_AID_Title_Desc_0 : persist('thumphrey::persist::all::cont_title_desc::useful_content');
output(count(Cont_AID_Title_Desc),named('c_Cont_AID_Title_Desc')); 
output(Cont_AID_Title_Desc,named('Cont_AID_Title_Desc')); 
