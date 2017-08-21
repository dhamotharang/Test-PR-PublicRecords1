// This Macro will parse dual names and cleans the parsed names. 
// Name is infile name field which has Dual name 
// Name_type is the name format like for LFM => 'L' FML => 'F' else 'U'
// is_sec_owner is applied to only watercraft data sets
export Mac_Clean_Dual_Names(infile,name,outfile ,name_type,is_sec_owner='false') := macro 

import header,AID,lib_StringLib,watercraft,Address, watercraft_preprocess; 

#uniquename(temp_rec)
%temp_rec% := {infile,string1 xpty_typ1,string175 xname1, string1 bus_flag,string1 one_flag}; 
#uniquename(SplitoffName)
#uniquename(tmp_xname1)
#uniquename(tmp_xname2)
%SplitoffName% := project( infile, transform({%temp_rec%}, 
                                 
  
       string   v_name := watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.name); 
#if(is_sec_owner)
       string   v_sec_owner := StringLib.StringFilterOut(if(REGEXFIND('^[[:digit:]]+$',trim(left.sec_owner,left,right)) =true ,'',trim(left.sec_owner,left,right)),'{}');
       string120 %tmp_xname1%:=StringLib.StringToUpperCase(trim(v_name,left,right)+' '+trim(v_sec_owner,left,right));
       string120 %tmp_xname2%:=StringLib.StringToUpperCase(trim(v_name,left,right)+if(trim(v_sec_owner,left,right)<>'' , ' AND ' , '')+trim(v_sec_owner,left,right));

       self.xname1 := if(StringLib.StringFind(%tmp_xname1%,' OR ',1)!= 0  or
		                 StringLib.StringFind(%tmp_xname1%,' AND ',1)!= 0 or
		                 StringLib.StringFind(%tmp_xname1%,' DBA ',1)!= 0 or
		                 StringLib.StringFind(%tmp_xname1%,' C/O ',1)!= 0 or 
						 StringLib.StringFind(%tmp_xname1%,',OR ',1)!= 0  or
						 StringLib.StringFind(%tmp_xname1%,',0R ',1)!= 0  or
						 StringLib.StringFind(%tmp_xname1%,' 0R ',1)!= 0  or
						 StringLib.StringFind(%tmp_xname1%,',AND ',1)!= 0 or
						 StringLib.StringFind(%tmp_xname1%,',DBA ',1)!= 0 or
						 StringLib.StringFind(%tmp_xname1%,',C/O',1)!= 0  ,%tmp_xname1% , %tmp_xname2%);
#else 
	   self.xname1 := v_name ; 
#end;
       self.xpty_typ1   := left.name_type;
       self.bus_flag := if(trim(self.xname1,left,right) ='' ,'', if(watercraft_preprocess.is_company(self.xname1)=1, 'Y' , '')); 
       self.one_flag := if(trim(self.xname1,left,right) ='','', if(watercraft_preprocess.Mod_Clean_Entities.IsOneWord(self.xname1)=1, 'Y' , ''));
       self := left)); 

#uniquename(FilterBusiness)
#uniquename(FilterNames)
#uniquename(FnamesNosingleWords)
#uniquename(FnamesSingleWords)
#uniquename(FilterBusinessAll)
#uniquename(FilterBusinessDba)
%FilterBusinessAll% := %SplitoffName%(bus_flag = 'Y');
%FilterBusinessDba% := %FilterBusinessAll%(StringLib.StringFind(xname1,' DBA ',1)>0 or StringLib.StringFind(xname1,' D/B/A ',1)>0 ); 
%FilterBusiness%    := %FilterBusinessAll%((~(StringLib.StringFind(xname1,' DBA ',1)>0 or StringLib.StringFind(xname1,' D/B/A ',1)>0))); 
%FilterNames%    := %SplitoffName%(bus_flag != 'Y');
%FnamesNosingleWords% := %FilterNames%(one_flag != 'Y'); 
%FnamesSingleWords% :=  %FilterNames%(one_flag = 'Y');
#uniquename(RecleanDualOut)
watercraft_preprocess.Mac_split_names(%FnamesNosingleWords%,xname1,%RecleanDualOut%,xpty_typ1);

#uniquename(FilterBusinessOut)
%FilterBusinessOut% := project(%FilterBusiness% , transform({%RecleanDualOut%},
 
#if(is_sec_owner=true)
     string   v_sec_owner1 := StringLib.StringFilterOut(if(REGEXFIND('^[[:digit:]]+$',trim(left.sec_owner,left,right)) =true ,'',trim(left.sec_owner,left,right)),'{}');
     x := StringLib.StringToUpperCase(trim(left.NAME,left,right)+' '+trim(v_sec_owner1,left,right));
     x2:= StringLib.StringToUpperCase(trim(left.NAME,left,right)+if(v_sec_owner1 <>'', '; ' , '')+trim(v_sec_owner1,left,right));

	self.cname1 :=if(StringLib.StringFind(x,' OR ',1)!= 0 or
		 StringLib.StringFind(x,' AND ',1)!= 0 or
		 StringLib.StringFind(x,' DBA ',1)!= 0 or
		 StringLib.StringFind(x,' C/O ',1)!= 0 , x , x2);
#else 
   self.cname1 :=watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.NAME); 
#end;		 
	self := left; self :=[]));
#uniquename(FnamesSingleWords1)

Address.Mac_Is_Business(%FnamesSingleWords%, name, %FnamesSingleWords1%, Sbus_flag);

#uniquename(FnamesSingleWordsOut)
%FnamesSingleWordsOut% := project(%FnamesSingleWords1%, transform({%RecleanDualOut%},
                            self.pname1 := if(left.Sbus_flag ='P',Address.CleanPerson73(left.name),''); 
							self.cname1 := if(left.Sbus_flag <>'P',watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.NAME),''); 
							self := left,self:=[] ));  

#uniquename(RecleanDualdbaOut)
// DBA names
watercraft_preprocess.Mac_split_names(%FilterBusinessDba%,xname1,%RecleanDualdbaOut%,xpty_typ1,true);

Outfile := %RecleanDualOut%+ %FilterBusinessOut% + %FnamesSingleWordsOut% +%RecleanDualdbaOut% :DEPRECATED('Use NID.Mac_CleanFullNames instead');

ENDMACRO ; 