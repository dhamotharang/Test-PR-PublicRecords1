IMPORT SALT30,BIPV2_LGID3,BizlinkFull,BIPV2,BIPV2_BlockLink;
EXPORT MatchInfo_OneLgid3(unsigned6 seleid_in, unsigned6 lgid3_in, string20 rcidstr = '0') := module
		shared base:=BIPV2_BlockLink.GetClusterOfOneLgid3(seleid_in,lgid3_in);
		shared BFile := BIPV2_LGID3.In_LGID3;
		shared BIPV2_LGID3.match_candidates(BFile).layout_candidates into(BIPV2_LGID3.Keys(BFile).Candidates le) := transform
			self := le;
		end;
		shared odl := project(choosen(BIPV2_LGID3.Keys2().MatchCandidates.QA(LGID3=lgid3_in),10000),into(left));
		//shared odl := project(choosen(BIPV2_LGID3.Keys(BFile).Candidates(LGID3=lgid3_in),10000),into(left));
		shared k := BIPV2_LGID3.Keys2().Specificity.QA;		
		//shared k := BIPV2_LGID3.Keys(BFile).Specificities_Key;
		shared BIPV2_LGID3.Layout_Specificities.R s_into(k le) := transform
			self := le;
		end;
		shared s := global(project(k,s_into(left))[1]);
		shared odl_noprop := BIPV2_LGID3.Debug(BFile,s).RemoveProps(odl); // Remove propogated values
		
		shared AnnotateClusterMatches_new(DATASET(BIPV2_LGID3.match_candidates(BFile).layout_candidates) in_data,
																			SALT30.UIDType BaseRecord,
																			BIPV2_LGID3.Layout_Specificities.R s) := FUNCTION//Faster form when rcid known
				j1 := in_data(rcid = BaseRecord or BaseRecord=0);
	
				BIPV2_LGID3.match_candidates(BFile).layout_candidates strim(j1 le) := TRANSFORM
						SELF := le;
				END;

				JJJ:=JOIN(in_data(rcid<>BaseRecord),j1,true, 
						BIPV2_LGID3.debug(BFile,s).sample_match_join(PROJECT(LEFT,strim(LEFT)),RIGHT,),ALL);
  				JJJ0:=JJJ(Conf>= BIPV2_LGID3.Config.MatchThreshold and rcid1>rcid2);	
   				TTT:=table(JJJ0,{rcid1,rcid2});
   
   				TTT1:=Join(TTT,base, left.rcid1=right.rcid, 
   											transform({recordof(Left),unsigned6 proxid1}, self.proxid1:=right.proxid;self :=left));
   				TTT2:=join(TTT1,base, left.rcid2=right.rcid, 
   											transform({recordof(left), unsigned6 proxid2},self.proxid2:=right.proxid;self :=left));
   
   				TTT3:=TTT2(proxid1 != proxid2);
   
   				Final:=Join(JJJ0,TTT3, left.rcid1=right.rcid1 and left.rcid2=right.rcid2, 
												transform({recordof(left),unsigned6 proxid1,unsigned6 proxid2},
																	self.proxid1:=right.proxid1;
																	self.proxid2:=right.proxid2;
																	self:=left));
   				RETURN Final;
		END; 
		
		
export LGID3Values:=odl;
export LGID3Values_NoProp:=odl_noprop;
shared aaa:= AnnotateClusterMatches_new(odl_noprop,(unsigned)rcidstr,s);
shared aaa1:=sort(project(aaa, transform(BIPV2_FindLinks.Layouts.LGID3_LK_Det_Rec, self :=left)),-conf);
export mtchnp_new := dedup(aaa1,except dateoverlap,conf_prop,rcid1,rcid2,all); 

shared bbb:= AnnotateClusterMatches_new(odl,(unsigned)rcidstr,s);
shared bbb1:=sort(project(bbb, transform(BIPV2_FindLinks.Layouts.LGID3_LK_Det_Rec, self :=left)),-conf);
export mtch_new := dedup(bbb1, except dateoverlap,conf_prop,rcid1,rcid2,all);

//shared total:=project(mtchnp_new + mtch_new, transform(BIPV2_FindLinks.Layouts.LGID3_LK_Det_Rec, self :=left));
//shared total_ded:=dedup(total,RECORD,all);

export LinkDetail:=sort(mtchnp_new + mtch_new,conf_prop,-conf);	
end;