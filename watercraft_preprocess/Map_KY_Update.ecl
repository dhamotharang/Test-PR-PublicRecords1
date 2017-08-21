import watercraft,ut,address,AID,header,address;

// translates ky_infolink.mp Ab intio graph into ECL

fIn_raw := watercraft_preprocess.Files_raw.ky;

fprecelan := project( fIn_raw, transform({Watercraft.layout_ky_infolink,string1 name_source,
                                          string175 pname,string70 cname,string1 name_format},

                      t_FNAME :=  StringLib.StringFilterOut(if(StringLib.StringFind(left.LNAME,trim(left.FNAME),1)!=0 ,'',trim(left.FNAME)),'.][-');
					  t_LNAME :=  StringLib.StringFilterOut(trim(left.LNAME),'.][-');
					  self.pname := trim(
                             regexreplace(' OR$| AND OR$|AND/OR| OR$| &/OR$| (OR)$|^ OR |/OR$',
                                           if(StringLib.StringFind(trim(t_LNAME),' OR$',1)!=0, regexreplace(' OR$',trim(t_LNAME),' '),t_LNAME)
                                                                   +' '+
	                                                           if(StringLib.StringFind(trim(left.FNAME),' OR$|^OR',1)!=0, regexreplace(' OR$|^OR',trim(t_FNAME),' '),StringLib.StringFilterOut(t_FNAME,'.'))
                                                                   +' '+
                                                                   trim(left.MNAME)+
	                                                           ' ',
	                                                           ''));
  self.cname := '';
  self.name_source := '1';
  self.FNAME :=trim(t_FNAME);
  self.LNAME := trim(t_LNAME);
  self.name_format := 'L'; 
  self:= left ));
  
ut.Mac_Clean_Dual_Names(fprecelan,pname,fcelanDname,name_format);

Watercraft.Layout_KY_infolink_clean_in  tnorm( fcelanDname l , integer cnt) := transform
                         
						 self.pname := choose(cnt,l.pname1+l.pname1_score,l.pname2+l.pname2_score,l.pname3+l.pname3_score,l.pname4+l.pname4_score,l.pname5+l.pname5_score);
                         self.cname := trim(regexreplace('  |    ',choose(cnt,l.cname1,l.cname2,l.cname3,l.cname4,l.cname5),''),left,right)[1..70];
						 self.state_origin := 'KY'; 
				         self.process_date := watercraft_preprocess.version;
						 self.clean_address := '';
						 self.CITY := StringLib.StringFilterOut(trim(l.CITY),',');
                         self.FNAME := StringLib.StringFilterOut(trim(l.FNAME),',');
                         self.LNAME := StringLib.StringFilterOut(trim(l.LNAME),',');
                         self := l; 

end; 

fcelanname :=  normalize(fcelanDname, 5, tnorm(left, counter)); 

export Map_KY_Update := sequential(output(fcelanname(pname<>'' or cname<>''),,watercraft.Cluster_In+'in::watercraft_MO_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_MO', watercraft.Cluster_In+'in::watercraft_MO_'+watercraft_preprocess.version)
								  ) ;
