IMPORT  PromoteSupers,prte2,std,AID,Address,ut;

EXPORT CreateGrid := FUNCTION

prte2.SprayFiles.Spray_Raw_Data('lnpr__base__relate', 'relate', 'lnpr');

PRTE2.CleanFields(prte2.files.lnpr_IN, in_file);

DS_out	:=	Project(in_file,
   Transform(prte2.Layouts.Linkid_Rec,
	  vCmpnyIdParent := (UNSIGNED6) hash(ut.CleanSpacesAndUpper(left.parent_link_inc_date + left.parent_link_fein + left.parent_cust_name));
		 vCmpnyIdChild  := (UNSIGNED6) hash(ut.CleanSpacesAndUpper(left.child_link_inc_date + left.child_link_fein + left.child_cust_name));
		 Self.parent_seleid:= vCmpnyIdParent;
		 Self.parent_orgid:= vCmpnyIdParent;
		 Self.parent_ultid:= vCmpnyIdParent;
		 Self.child_seleid:= vCmpnyIdChild;
		 Self.child_orgid:= vCmpnyIdParent;
		 Self.child_ultid:= vCmpnyIdParent;
		 self.Parent_outcome:=vCmpnyIDParent - vCmpnyIDChild;
		 Self:=LEFT; 
   ));
		 
			 
   prte2.Layouts.Norm 	tNormalized(DS_out L, INTEGER cnt) :=	TRANSFORM
      self.company_name := choose(cnt, L.Parent_company_name, L.Child_Company_name);
      self.Link_Fein :=    choose(cnt,L.Parent_Link_Fein,L.Child_Link_Fein);
	     self.Link_Inc_date :=choose(cnt,L.Parent_Link_Inc_date,L.Child_Link_Inc_date);
      self.Cust_Name :=    choose(cnt,L.Parent_Cust_Name,L.Child_Cust_Name); 
		    Self.seleid:=        choose(cnt,L.parent_seleid,L.child_seleid);
		    Self.orgid:=         choose(cnt,L.parent_orgid,L.child_orgid);
		    Self.ultid:=         choose(cnt,L.parent_ultid,L.child_ultid);
			   self.relation:=      choose(cnt,'Parent','Child');
			   Self.Parent_outcome:=       L.Parent_outcome;
			
    end;
	 nameNormalized := 	normalize(DS_out, 2, tNormalized(LEFT,counter));

	
	PromoteSupers.MAC_SF_BuildProcess(nameNormalized,prte2.constants.linkids, writefile);
	sequential(writefile);

Return 'success';

END;