// BWR_UsefulContent_CorpStatusComment.ecl
import text, CorpFilingsFreeTextFieldAnalysis;

pattern alpha_numeric := ( text.alpha | text.digit );

pattern dsep := ( '-' | '/' );

mon_abbr := ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
month := ['JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER'];
pattern date1 := (( mon_abbr opt('.')| month ) NOT AFTER alpha_numeric) repeat(text.digit,1,2) repeat(',' | ' ',1,3) repeat(text.digit,4);
pattern date2 := (('18'|'19'|'20') NOT AFTER alpha_numeric) repeat(text.digit,6);
pattern date3 := repeat(text.digit,1,2) dsep repeat(text.digit,1,2) dsep (repeat(text.digit,2) | repeat(text.digit,4) );
pattern date := ( date1 | date2 | date3 );

useful_content_layout := CorpFilingsFreeTextFieldAnalysis.useful_content_layout;

useful_content_layout fillCorpStatusCommentUsefulInfo( Corp2.Layout_Corporate_Direct_Corp_AID l ) := TRANSFORM

   self.content_type := 'DATE';
       
   self.filename            := 'thor_data400::base::corp2::qa::corp_aid';
   self.fieldname           := 'corp_status_comment';
   self.desired_content     := matchtext(date);
   self.desired_content_pos := matchposition(date);
   self.fieldvalue          := l.corp_status_comment;
   self := l;
   
END;

  CorpFilingsFreeTextFieldAnalysis.mac_findFreeTextFieldUsefulContent(
   fillCorpStatusCommentUsefulInfo
   ,date
   ,'thor_data400::base::corp2::qa::corp_aid'
   ,Corp2.Layout_Corporate_Direct_Corp_AID
   ,corp_status_comment
   ,Copr_AID_StatusComment_0
   ,'all'
  );
  Copr_AID_StatusComment := Copr_AID_StatusComment_0 : persist('thumphrey::persist::all::corp_status_comment::useful_content2');
  output(count(Copr_AID_StatusComment),named('c_Copr_AID_StatusComment')); 
  output(Copr_AID_StatusComment,named('Copr_AID_StatusComment')); 
