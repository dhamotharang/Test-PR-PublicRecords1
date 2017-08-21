export Mac_split_names(infile,name,outfile ,name_type,is_dba='false',is_pct='false') := macro 

import header,AID,lib_StringLib,watercraft,Address, watercraft_preprocess; 

#uniquename(temp_rec1)
#uniquename(splitNames)

%temp_rec1% := { infile,  string175 v_xname_0;
  string175 v_xname_1;
  string175 v_xname_2;
  string175 v_xname_3;
  string175 v_xname_4;
  string73 v_clean_name_0;
  string73 v_clean_name_1;
  string73 v_clean_name_2;
  string73 v_clean_name_3;
  string73 v_clean_name_4} ;
  
%splitNames% := project(infile , transform({%temp_rec1%},

#if(is_dba=true) 
			   string175 xname_temp := watercraft_preprocess.Mod_Clean_Entities.FixSuffix(watercraft_preprocess.Mod_Clean_Entities.StrReplacedba(StringLib.StringCleanSpaces(left.xname1),is_pct)); 	
#else 
               string175 xname_temp := watercraft_preprocess.Mod_Clean_Entities.FixSuffix(watercraft_preprocess.Mod_Clean_Entities.StrReplace(StringLib.StringCleanSpaces(left.xname1))); 
#end;              
				t_v_xname_0 := StringLib.StringFilterOut(ut.Word(xname_temp, 1,'!'),'()}{'); 
				t_v_xname_1 := StringLib.StringFilterOut(ut.Word(xname_temp, 2,'!'),'()}{');
				t_v_xname_2 := StringLib.StringFilterOut(ut.Word(xname_temp, 3,'!'),'(){}');
				t_v_xname_3 := StringLib.StringFilterOut(ut.Word(xname_temp, 4,'!'),'(){}');
				t_v_xname_4 := StringLib.StringFilterOut(ut.Word(xname_temp, 5,'!'),'(){}');
				
				self.v_xname_0 :=t_v_xname_0; 
				self.v_xname_1 := t_v_xname_1;
				self.v_xname_2 := t_v_xname_2;
				self.v_xname_3 := t_v_xname_3 ;
				self.v_xname_4 := t_v_xname_4;
				
				
				self.v_clean_name_0 := map(t_v_xname_0 =''=> '',
				                           left.xpty_typ1='F' =>Address.CleanPersonFML73(t_v_xname_0),
						                   left.xpty_typ1='L' =>Address.CleanPersonLFM73(t_v_xname_0),
							               Address.CleanPerson73(t_v_xname_0));
				self.v_clean_name_1 := if(t_v_xname_1 <>'',Address.CleanPerson73(t_v_xname_1),'');
				self.v_clean_name_2 := if(t_v_xname_2 <>'',Address.CleanPerson73(t_v_xname_2),'');
				self.v_clean_name_3 := if(t_v_xname_3 <>'',Address.CleanPerson73(t_v_xname_3),'');
				self.v_clean_name_4 := if(t_v_xname_4 <>'',Address.CleanPerson73(t_v_xname_4),'');
				
				self := left)); 

#uniquename(rRecleanDual)
#uniquename(RecleanDual)

%rRecleanDual% := {infile,  string175 xname_p1;
  string175 xname_p2;
  string175 xname_p3;
  string175 xname_p4;
  string175 xname_p5;
  string73 clean_name_1;
  string73 clean_name_2;
  string73 clean_name_3;
  string73 clean_name_4;
  string73 clean_name_5};
  
%RecleanDual% := project(%splitNames% , transform({%rRecleanDual%}, 

                    self.clean_name_1 := if ((left.v_clean_name_0[1..25]='' OR left.v_clean_name_0[47] ='') AND (integer)left.v_clean_name_0[71..73]<>0,
					                        Address.CleanPerson73(StringLib.StringFilterOut(trim(left.v_xname_0,left,right)+ ' '+ left.v_clean_name_1[46..65],'()'))
							               ,left.v_clean_name_0);
										
					self.clean_name_2 := if ((left.v_clean_name_1[1..25]='' OR left.v_clean_name_1[47] ='') AND (integer)left.v_clean_name_1[71..73]<>0,
					                      Address.CleanPerson73(StringLib.StringFilterOut(trim(trim(left.v_xname_1,left,right)+ ' '+ trim(self.clean_name_1[46..65],left,right),left,right),'()'))
										  ,	left.v_clean_name_1);
					
					self.clean_name_3 := if ((left.v_clean_name_2[1..25]='' OR left.v_clean_name_2[47] ='') AND (integer)left.v_clean_name_2[71..73]<>0,
					                      Address.CleanPerson73(StringLib.StringFilterOut(trim(trim(left.v_xname_2,left,right)+ ' '+ trim(self.clean_name_2[46..65],left,right),left,right),'()'))
										  ,	left.v_clean_name_2);
                    
					self.clean_name_4 := if ((left.v_clean_name_3[1..25]='' OR left.v_clean_name_3[47] ='') AND (integer)left.v_clean_name_3[71..73]<>0,
					                      Address.CleanPerson73(StringLib.StringFilterOut(trim(trim(left.v_xname_3,left,right)+ ' '+ trim(self.clean_name_3[46..65],left,right),left,right),'()'))
										  ,	left.v_clean_name_3);
					
					self.clean_name_5 := if ((left.v_clean_name_4[1..25]='' OR left.v_clean_name_4[47] ='') AND (integer)left.v_clean_name_4[71..73]<>0,
					                      Address.CleanPerson73(StringLib.StringFilterOut(trim(left.v_xname_4,left,right)+ ' '+ self.clean_name_4[46..65],'()'))
										  ,	left.v_clean_name_4);
										  
					self.xname_p1     :=  left.v_xname_0 ;
                    self.xname_p2     :=  left.v_xname_1 ;
                    self.xname_p3     :=  left.v_xname_2 ;
                    self.xname_p4     :=  left.v_xname_3 ;
                    self.xname_p5     :=  left.v_xname_4 ;
                    self := left));
#uniquename(rRedefinePname)
#uniquename(ParsedNames)
%rRedefinePname% := {infile,  string175 xname_p1;
  string175 xname_p2;
  string175 xname_p3;
  string175 xname_p4;
  string175 xname_p5;
  string175 Fxname_p1;
  string175 Fxname_p2;
  string175 Fxname_p3;
  string175 Fxname_p4;
  string175 Fxname_p5;
 
  string70 	pname1;
  string3 	pname1_score;
  string70 	pname2;
  string3 	pname2_score;
  string70 	pname3;
  string3 	pname3_score;
  string70 	pname4;
  string3 	pname4_score;
  string70 	pname5;
  string3 	pname5_score;
 };
 
  %ParsedNames% := project(%RecleanDual%,transform({%rRedefinePname%}, 
                                          self.pname1         := left.clean_name_1[1..70], 
										  self.pname1_score   := left.clean_name_1[71..73],
										  self.pname2         := left.clean_name_2[1..70], 
										  self.pname2_score   := left.clean_name_2[71..73],
                                          self.pname3         := left.clean_name_3[1..70], 
										  self.pname3_score   := left.clean_name_3[71..73],
                                          self.pname4         := left.clean_name_4[1..70],
										  self.pname4_score   := left.clean_name_4[71..73],
                                          self.pname5         := left.clean_name_5[1..70],
										  self.pname5_score   := left.clean_name_5[71..73],
										  self.Fxname_p1      := StringLib.StringFindReplace(left.xname_p1,',',' ');
                                          self.Fxname_p2      := StringLib.StringFindReplace(left.xname_p2,',',' ');
                                          self.Fxname_p3      := StringLib.StringFindReplace(left.xname_p3,',',' ');
                                          self.Fxname_p4      := StringLib.StringFindReplace(left.xname_p4,',',' ');
                                          self.Fxname_p5      := StringLib.StringFindReplace(left.xname_p5,',',' ');
						                  self := left )); 
#uniquename(ParsedNamesOut1)
#uniquename(ParsedNamesOut2)
#uniquename(ParsedNamesOut3)
#uniquename(ParsedNamesOut4)
#uniquename(ParsedNamesOut5)

Address.Mac_Is_Business(%ParsedNames%, Fxname_p1, %ParsedNamesOut1%, bus_flag1,,,,,,,,,,,,,['W']);
Address.Mac_Is_Business(%ParsedNamesOut1%, Fxname_p2, %ParsedNamesOut2%, bus_flag2,,,,,,,,,,,,,['W']);
Address.Mac_Is_Business(%ParsedNamesOut2%, Fxname_p3, %ParsedNamesOut3%, bus_flag3,,,,,,,,,,,,,['W']);
Address.Mac_Is_Business(%ParsedNamesOut3%, Fxname_p4, %ParsedNamesOut4%, bus_flag4,,,,,,,,,,,,,['W']);
Address.Mac_Is_Business(%ParsedNamesOut4%, Fxname_p5, %ParsedNamesOut5%, bus_flag5,,,,,,,,,,,,,['W']);
									  
#uniquename(Rout)
%Rout% := {infile,  
  string70   pname1 := '';
  string3    pname1_score := '';
  string100  cname1 := '';
  string70   pname2 := '';
  string3    pname2_score := '';
  string100  cname2 := '';
  string70   pname3 := '';
  string3    pname3_score := '';
  string100  cname3 := '';
  string70   pname4 := '';
  string3    pname4_score := '';
  string100  cname4 := '';
  string70   pname5 := '';
  string3    pname5_score := '';
  string100  cname5 := '';
  string1   bus_flag1:='';
  string1   bus_flag2:='';
  string1   bus_flag3:='';
  string1   bus_flag4:='';
  string1   bus_flag5:=''
  }; 
#uniquename(RecleanDualOut1)
  %RecleanDualOut1% := project(%ParsedNamesOut5% ,transform({%Rout%} , 
  
   self.cname1 := if(left.bus_flag1='B',left.xname_p1, 
                    if(left.bus_flag1 in ['I','U'] and (integer)left.pname1_score<=80,left.xname_p1,'')); 
   self.cname2 := if(left.bus_flag2='B',left.xname_p2, 
                    if(left.bus_flag2 in ['I','U'] and (integer)left.pname2_score<=80,left.xname_p2,'')); 
   self.cname3 := if(left.bus_flag3='B',left.xname_p3, 
                    if(left.bus_flag3 in ['I','U'] and (integer)left.pname3_score<=80,left.xname_p3,'')); 
   self.cname4 := if(left.bus_flag4='B',left.xname_p4, 
                    if(left.bus_flag4 in ['I','U'] and (integer)left.pname4_score<=80,left.xname_p4,'')); 
   self.cname5 := if(left.bus_flag5='B',left.xname_p5, 
                    if(left.bus_flag5 in ['I','U'] and (integer)left.pname5_score<=80,left.xname_p5,'')); 

  self.pname1 :=  if(left.bus_flag1 = 'P', left.pname1,
                     if(left.bus_flag1 in ['I','U'] and (integer)left.pname1_score>80 ,left.pname1,'')); 
  self.pname2 :=  if(left.bus_flag2 = 'P', left.pname2,
                     if(left.bus_flag2 in ['I','U'] and (integer)left.pname2_score>80 ,left.pname2,'')); 
  self.pname3 :=  if(left.bus_flag3 = 'P', left.pname3,
                     if(left.bus_flag3 in ['I','U'] and (integer)left.pname3_score>80 ,left.pname3,'')); 
  self.pname4 :=  if(left.bus_flag4 = 'P', left.pname4,
                     if(left.bus_flag4 in ['I','U'] and (integer)left.pname4_score>80 ,left.pname4,'')); 
  self.pname5 :=  if(left.bus_flag5 = 'P', left.pname5,
                     if(left.bus_flag5 in ['I','U'] and (integer)left.pname5_score>80 ,left.pname5,'')); 

  self := left ; 
  ));  
  
outfile := %RecleanDualOut1% ;

ENDMACRO; 