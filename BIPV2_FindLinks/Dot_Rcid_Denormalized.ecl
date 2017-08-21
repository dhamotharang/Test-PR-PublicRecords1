//EXPORT Dot_Rcid_Denormalized := 'todo';
import BIPV2, BIPV2_FindLinks;
#workunit('priority','high');

unsigned6 theSeleid :=27704653;

ds_new:=BIPV2.CommonBase.DS_BASE;
ds_old:=BIPV2.CommonBase.DS_FATHER;

ds_new_proj:=table(ds_new,{rcid,source,dotid,proxid,seleid,lgid3,is_sele_level,parent_proxid,
													 ultimate_proxid,levels_from_top,nodes_below,nodes_total,iscontact,
													 title,fname,mname,lname,name_suffix,company_name,company_name_type_derived,
													 cnp_name,cnp_number,cnp_btype,prim_range,prim_range_derived,prim_name,
													 prim_name_derived,sec_range,v_city_name,st,zip,corp_legal_name,active_duns_number,
													 hist_duns_number,/*deleted_key,deleted_fein,*/active_enterprise_number,
													 hist_enterprise_number,ebr_file_number,active_domestic_corp_key,hist_domestic_corp_key,
													 foreign_corp_key,unk_corp_key,dt_first_seen,dt_last_seen,company_fein,company_phone,
													 company_inc_state,company_charter_number,vl_id,duns_number,contact_ssn
													 }) : Persist('~thor_data400::HS::FindLinks::BaseData');
													 
ds_old_proj:=table(ds_old,{rcid,source,dotid,proxid,seleid,lgid3,is_sele_level,parent_proxid,
													 ultimate_proxid,levels_from_top,nodes_below,nodes_total,iscontact,
													 title,fname,mname,lname,name_suffix,company_name,company_name_type_derived,
													 cnp_name,cnp_number,cnp_btype,prim_range,prim_range_derived,prim_name,
													 prim_name_derived,sec_range,v_city_name,st,zip,corp_legal_name,active_duns_number,
													 hist_duns_number,/*deleted_key,deleted_fein,*/active_enterprise_number,
													 hist_enterprise_number,ebr_file_number,active_domestic_corp_key,hist_domestic_corp_key,
													 foreign_corp_key,unk_corp_key,dt_first_seen,dt_last_seen,company_fein,company_phone,
													 company_inc_state,company_charter_number,vl_id,duns_number,contact_ssn
													 }) : Persist('~thor_data400::HS::FindLinks::FatherData');

t_sele_new :=ds_new_proj(seleid=theSeleid);
t_sele_old :=ds_old_proj(seleid=theSeleid);

DotRcidNew_List:= sort(table(t_sele_new,{rcid,dotid}),dotid,skew(1.0));
DotRcidOld_List:= sort(table(t_sele_old,{rcid,dotid}),dotid,skew(1.0));

DotNew_List:= table(DotRcidNew_List,{dotid});
DotOld_List:= table(DotRcidOld_List,{dotid});

DotNew_List_ded := dedup(sort(DotNew_List, dotid),dotid);
DotOld_List_ded := dedup(sort(DotOld_List, dotid),dotid);

//BIPV2_DotID.Keys(BIPV2_DOTID.In_DOT).MatchSample
  
NormRec := RECORD
	 unsigned6  rcid;
	 unsigned6  dotid;
 END;

rcid_rec:=Record
	unsigned6  rcid;
end;

dotid_rec:=Record
	unsigned6  dotid;
end;


DotRec := RECORD
	 integer  numRows;
	 unsigned6  dotid;
	 DATASET(rcid_rec) rcidlist;
END;
	 
DotRec DeNormThem(dotid_rec L, DATASET(NormRec) R) := TRANSFORM
	 SELF.NumRows := COUNT(R);
	 SELF.rcidlist := table(R,{rcid});
	 SELF.dotid := L.dotid;
END;
	 
DeNormed_Dot_New := DENORMALIZE(DotNew_List_ded, DotRcidNew_List,
								 LEFT.dotid = RIGHT.dotid,
								 GROUP,
								 DeNormThem(LEFT,ROWS(RIGHT)));	 
	 
   

output(DeNormed_Dot_New,named('DeNormed_Dot_New'));