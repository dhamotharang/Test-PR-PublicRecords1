import watercraft,ut,address,AID,header,address;

// translates mo_MJ.ksh* Ab intio graph into ECL

fIn_raw := watercraft_preprocess.Files_raw.Mo ; 

// Filter for TOD

fTod := fIn_raw(regexfind(' TOD ',NAME) = true); 
fNTod := fIn_raw(regexfind(' TOD ',NAME) = false); 

fTodRef := project( fTod, transform({watercraft_preprocess.layout_temp.layout_mo_temp}, 

  string delimiters := if(regexfind(' TOD ',left.NAME),' TOD ',
                          if(regexfind(' & ',left.NAME),' & ',''));
						  
  integer4 len := if(regexfind(' TOD ',left.NAME),5,
                   if(regexfind(' & ',left.NAME),3,100));

  self.NAME1 := if(delimiters<>'', left.NAME[1.. StringLib.stringfind(left.NAME,delimiters,1)],'');
  self.NAME2 := if(len <99,left.NAME[1.. StringLib.stringfind(left.NAME,' ',1)]+ left.NAME[StringLib.stringfind(left.NAME,delimiters,1)+len ..100],'');
  self.state_origin := 'MO'; 
  self.process_date := watercraft_preprocess.version; 
  self := left)); 

Watercraft.layout_mo   tnormalize(fTodRef L, integer cnt) := transform

  self.name:= choose(cnt,l.name1,l.name2); 
  self.first_name := ''; 
  self.mid := '' ; 
  self.last_name := ''; 
  self.lf := ''; 
  self := l ; 
end; 

fTodRef_norm := normalize(fTodRef, 2, tnormalize(left, counter));

fprecelan := project(fNTod + fTodRef_norm , transform({Watercraft.layout_mo, string1 name_format}, 

	tmp_xname1:=watercraft_preprocess.Mod_Clean_Entities.TrimandUp(left.NAME);
    tmp_xname2:=StringLib.StringFilterOut(regexreplace('3/4/75',tmp_xname1,' '),'*#');
  self.name := tmp_xname2;
  self.name_format := if(StringLib.stringfind(tmp_xname2,',JR ',1)!=0  OR 
		   StringLib.stringfind(tmp_xname2,',SR ',1)!=0  OR
		   StringLib.stringfind(tmp_xname2,',I ',1)!=0   OR
		   StringLib.stringfind(tmp_xname2,',II ',1)!=0  OR
		   StringLib.stringfind(tmp_xname2,',III ',1)!=0  OR
		   StringLib.stringfind(tmp_xname2,',IV ',1)!=0 OR 
  	   	   StringLib.stringfind(tmp_xname2,',1ST ',1)!=0 OR
  	   	   StringLib.stringfind(tmp_xname2,',2ND ',1)!=0 OR
  	   	   StringLib.stringfind(tmp_xname2,',2ND ',1)!=0 OR 
		   StringLib.stringfind(tmp_xname2,',3RD ',1)!=0 OR 
		   StringLib.stringfind(tmp_xname2,',',1)!=0 , 'L' , 'U');
		   self:= left)); 

ut.Mac_Clean_Dual_Names(fprecelan,name,fcelanDname,name_format);

Watercraft.Layout_Mo_clean_in  tnorm( fcelanDname l , integer cnt) := transform
                         
						 self.pname := choose(cnt,l.pname1,l.pname2,l.pname3,l.pname4,l.pname5);
                         self.pname_score := choose(cnt,l.pname1_score,l.pname2_score,l.pname3_score,l.pname4_score,l.pname5_score);
                         self.cname := choose(cnt,l.cname1,l.cname2,l.cname3,l.cname4,l.cname5);
						 self.state_origin := 'MO'; 
				         self.process_date := watercraft_preprocess.version;
						 self.clean_address := '';
                         self := l; 

end; 

fcelanname :=  normalize(fcelanDname, 5, tnorm(left, counter)); 
			 
export Map_MO_Update := sequential(output(fcelanname(pname<>'' or cname<>''),,watercraft.Cluster_In+'in::watercraft_MO_'+watercraft_preprocess.version),
								  FileServices.AddSuperFile( watercraft.Cluster_In + 'in::watercraft_MO', watercraft.Cluster_In+'in::watercraft_MO_'+watercraft_preprocess.version)
								  ) ;