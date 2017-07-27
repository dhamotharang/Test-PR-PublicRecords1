
import lib_stringlib;
Fictitious_Business_Names.Layout_In_InfoUSA_Flat Trans_Flat(Fictitious_Business_Names.File_Out_AllwithProcessDate l) := Transform
self.date_last_updated := l.date_last_updated[7..10]+l.date_last_updated[1..2]+l.date_last_updated[4..5];
self.date_first_updated_app := self.date_last_updated;
self.date_last_updated_app := self.date_last_updated;
self.businessname := regexreplace(' ampersand| &amp;',l.businessname,' &');
self.businessdesc := regexreplace(' ampersand| &amp;',l.businessdesc,' &');
self.businessaddress_s1 := regexreplace(' ampersand| &amp;',l.businessaddress_s1,' &');
self.businessaddress_cy := regexreplace(' ampersand| &amp;',l.businessaddress_cy,' &');
self.contactpersonaddress_s1 := regexreplace(' ampersand| &amp;',l.contactpersonaddress_s1,' &');
self.contactpersonaddress_cy := regexreplace(' ampersand| &amp;',l.contactpersonaddress_cy,' &');
//self.filingdate_index := StringLib.StringFind(trim(l.filingdate,left,right),'/',1);
self.filingdate_mm := if(StringLib.StringFind(trim(l.filingdate,left,right),'/',1)=2,'0'+trim(l.filingdate,left,right)[1..1],trim(l.filingdate,left,right)[1..2]);
self.filingdate_dd := map(
											StringLib.StringFind(l.filingdate,'/',2)= 4 =>'0'+l.filingdate[1..1],
											StringLib.StringFind(l.filingdate,'/',1)= 2 and StringLib.StringFind(l.filingdate,'/',2)= 5 =>l.filingdate[3..4],
											StringLib.StringFind(l.filingdate,'/',1)= 3 and StringLib.StringFind(l.filingdate,'/',2)= 5 =>'0'+l.filingdate[4..4],
											l.filingdate[4..5]);


self.filingdate_yy := map(
											StringLib.StringFind(l.filingdate,'/',2)= 4 =>l.filingdate[5..8],
											StringLib.StringFind(l.filingdate,'/',2)= 5 =>l.filingdate[6..9],
											l.filingdate[7..10]);
self.filingdate := 
//l.filingdate;
self.filingdate_yy+self.filingdate_mm+self.filingdate_dd;
self.InfoUSA_FBN_key := l.businessaddress_st+l.businessaddress_cy+hash64(l.businessname,self.filingdate);
//self.filingdate1 := 
//l.filingdate;
self.CCT_fullname :=regexreplace(' ampersand| &amp;', trim(l.CCT_firstname,left,right)+' '+trim(l.CCT_lastname,left,right)+' '+trim(l.CCT_suffix,left,right),' &');
//self.BusinessTelephone_full := if(trim(l.BusinessTelephone_AreaCode,left,right) !='' or trim(l.BusinessTelephone_Number,left,right) !='',trim(l.BusinessTelephone_AreaCode,left,right) + '-'+trim(l.BusinessTelephone_Number,left,right),'');
//self.ContactTelephone_full := if(trim(l.Telephone_AreaCode,left,right)!='' or trim(l.Telephone_Number,left,right)!='',trim(l.Telephone_AreaCode,left,right) +'-'+trim(l.Telephone_Number,left,right),'');
self :=l;
end;

export File_Out_AllFlat := Project(Fictitious_Business_Names.File_Out_AllwithProcessDate,Trans_Flat(left)):Persist('~thor_data400::persist::Infousa_fbn_flat');