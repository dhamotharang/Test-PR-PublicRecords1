IMPORT PRTE2_Header,infutor,header,_CONTROL, doxie;
EXPORT files := module


	SHARED prte_infutor         :=project(PRTE2_Header.files.file_headers,TRANSFORM(Layouts.layout_pre_infutor

						   ,SELF.addr_dt_last_seen  :=LEFT.dt_last_seen
						   ,SELF.addr_dt_first_seen :=LEFT.dt_first_seen
						   ,SELF.s_did              :=LEFT.did
						   ,SELF.valid_dob          :=''
						   ,SELF.hhid               :=0
						   ,SELF.county_name        :=''
						   ,SELF.listed_name        :=''
						   ,SELF.listed_phone       :=''
						   ,SELF.dod                :=0
						   ,SELF.death_code         :='1'
						   ,SELF.lookup_did         :=LEFT.did
						   ,SELF.bestaddr           :=false
						   ,SELF.iscurrent          :=false
						   ,SELF.totalrecords       :=0
						   ,SELF.nameorder          :=0
						   ,SELF.dph_lname          := metaphonelib.DMetaPhone1(left.lname)
						   ,SELF.pfname             :=left.fname
						   ,SELF.yob                :=left.dob div 10000
						   ,SELF.minit              :=left.mname[1]
 
						   ,SELF:=LEFT
							 ,SELF := []));

	EXPORT Header_Infutor_Knowx         := dedup(project(prte_infutor, {Infutor.Key_Header_Infutor_Knowx}),record,all);
	EXPORT Teaser_cnsmr_did             := dedup(project(prte_infutor, {Header.Key_Teaser_cnsmr_did}),record,all);
	EXPORT Infutor_Key_Teaser_cnsmr_did := dedup(project(prte_infutor, {Header.Key_Teaser_cnsmr_search}),record,all);
	EXPORT Infutor_Header			          := project(prte_infutor, {recordof(doxie.header_pre_keybuild)- Infutor.layout_header_exclusions});
	EXPORT infutor_best_did_base			  := dataset('~prte::base::infutor_best_did',{infutor.layout_best.lbest},thor,opt);
	EXPORT infutor_best_did			        := project(infutor_best_did_base, transform(infutor.Layout_infutor_best_DID, self := left, self := []));

END;