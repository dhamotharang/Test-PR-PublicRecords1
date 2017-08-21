// BWR_UsefulContent_CorpOrgStructure.ecl
import CorpFilingsFreeTextFieldAnalysis;

useful_content_layout := CorpFilingsFreeTextFieldAnalysis.useful_content_layout;

no_desired_content_useful_content_layout := RECORD
  useful_content_layout AND NOT desired_content AND NOT desired_content_pos
END;


no_desired_content_useful_content_layout fillCorpOrgStructureUsefulContent( Corp2.Layout_Corporate_Direct_Corp_AID l ) := TRANSFORM
   self.content_type := 'ALL NONBLANK RECORDS';
       
   self.filename            := 'thor_data400::base::corp2::qa::corp_aid';
   self.fieldname           := 'corp_orig_org_structure_desc';
   self.fieldvalue          := l.corp_orig_org_structure_desc;
   self := l;
END;

CorpFilingsFreeTextFieldAnalysis.mac_findFreeTextFieldUsefulContent(
 fillCorpOrgStructureUsefulContent
 ,''
 ,'thor_data400::base::corp2::qa::corp_aid'
 ,Corp2.Layout_Corporate_Direct_Corp_AID
 ,corp_orig_org_structure_desc
 ,Corp_AID_Structure_Desc_0
 ,'all'
);

Corp_AID_Structure_Desc := Corp_AID_Structure_Desc_0 : persist('thumphrey::persist::all::corp_orig_org_structure_desc::useful_content');
output(count(Corp_AID_Structure_Desc),named('c_Corp_AID_Structure_Desc')); 
output(Corp_AID_Structure_Desc,named('Corp_AID_Structure_Desc')); 
