IMPORT  PromoteSupers,prte2,std,AID,Address,ut;

EXPORT CreateDBAGrid := FUNCTION

//prte2.SprayFiles.Spray_Raw_Data('lnpr__base__dba', 'dba', 'lnpr');

PRTE2.CleanFields(prte2.files.lnpr_DBA_IN, in_file);

DS_out	:=	Project(in_file,
   Transform(prte2.Layouts.Linkid_DBA_Rec,
	  vCmpnyIdParent := (UNSIGNED6) hash(ut.CleanSpacesAndUpper(left.primary_link_inc_date + left.primary_link_fein + left.primary_cust_name));
	//	 vCmpnyIdChild  := (UNSIGNED6) hash(ut.CleanSpacesAndUpper(left.child_link_inc_date + left.child_link_fein + left.child_cust_name));
		 Self.primary_seleid:= vCmpnyIdParent;
		 Self.primary_orgid:= vCmpnyIdParent;
		 Self.primary_ultid:= vCmpnyIdParent;
		 
		 Self.dba_seleid:= vCmpnyIdParent;
		 Self.dba_orgid:= vCmpnyIdParent;
		 Self.dba_ultid:= vCmpnyIdParent;
		 self.Primary_outcome:=0;
		 Self:=LEFT; 
   ));
		 
			 
   prte2.Layouts.DBA_Norm 	tNormalized(DS_out L, INTEGER cnt) :=	TRANSFORM
      self.company_name := choose(cnt, L.Primary_company_name, L.DBA_Company_name);
      self.Link_Fein :=    choose(cnt,L.Primary_Link_Fein,L.DBA_Link_Fein);
	     self.Link_Inc_date :=choose(cnt,L.Primary_Link_Inc_date,L.DBA_Link_Inc_date);
      self.Cust_Name :=    choose(cnt,L.Primary_Cust_Name,L.DBA_Cust_Name); 
		    Self.seleid:=        choose(cnt,L.Primary_seleid,L.DBA_seleid);
		    Self.orgid:=         choose(cnt,L.Primary_orgid,L.DBA_orgid);
		    Self.ultid:=         choose(cnt,L.Primary_ultid,L.DBA_ultid);
			   self.relation:=      choose(cnt,'Primary','DBA');
			 Self.Primary_outcome:=       L.Primary_outcome;
			
    end;
	 nameNormalized := 	normalize(DS_out, 2, tNormalized(LEFT,counter));

	output(dedup(nameNormalized)); 
	PromoteSupers.MAC_SF_BuildProcess(nameNormalized,prte2.constants.dba_linkids, writefile);
	sequential(writefile);

Return 'success';

END;