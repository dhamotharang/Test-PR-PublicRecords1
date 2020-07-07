import iesp, Header, PersonReports, Relationship, SmartRollup, riskwise;
export fn_relativeOf(dataset(iesp.smartlinxreport.t_SLRRelative) inRels, integer subjectDid, PersonReports.IParam._smartlinxreport param) := function
  outrec := iesp.smartlinxreport.t_SLRRelative;

  relrec := record
    integer parentdid;
    integer childdid;
		unsigned1 titleNo := 0;
  end;
  level1 := inRels(relativedepth=1);
  level2 := inRels(relativedepth=2);
  level3 := inRels(relativedepth=3);
  
	relrec fillparent(Relationship.layout_GetRelationship.interfaceOutputNeutral r) := transform
    self.parentdid :=  r.did1;
	  self.childdid := r.did2;
		self.titleNo := r.title;
  end;
	
	// this will be used to get titles for level1: 
	// Use relationship proc to retrieve relative dids.
	Relationship.Layout_GetRelationship.DIDs_layout prep_did() := transform
		self.did := (unsigned6)subjectDid;
		self := [];
	end;
	did_rec := DATASET ([prep_did()]);
	parents0 := project(Relationship.proc_GetRelationshipNeutral(did_rec,TRUE,TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result,fillparent(left));
		
	//do we need to sort these so they are in the same order everytime they get generated 
	//code below gets first parent found wouldn't want it to be different 
	parent1dids := project(level1,transform(Relationship.Layout_GetRelationship.DIDs_layout,SELF.did := (integer)LEFT.uniqueid,SELF := []));	
	parents1 := project(Relationship.proc_GetRelationshipNeutral(parent1dids,TRUE,TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result,fillparent(left));
	
	//do we need to sort these so they are in the same order everytime they get generated 
	//code below gets first parent found wouldn't want it to be different
	parent2dids := project(level2,transform(Relationship.Layout_GetRelationship.DIDs_layout,SELF.did := (integer)LEFT.uniqueid,SELF := []));	
	parents2 := project(Relationship.proc_GetRelationshipNeutral(parent2dids,TRUE,TRUE,doAtmost:=TRUE,MaxCount:=RiskWise.max_atmost).result,fillparent(left));
  
	// for relatives of depth=1 we asign titles, the default 'relative' is replaced with blank to preserve the current functionality
  outrec fill1(inRels l, relrec r) := transform
    self.RelativeOfUniqueId := (string)intformat ((integer) r.parentdid, 12, 1);
		self.title := if(r.titleNo <> Header.relative_titles.num_relative, 
		                 stringlib.stringToUppercase(Header.relative_titles.fn_get_str_title(r.titleNo)),'');
	  self := l;
  end;

  filllevel1 := join(level1, parents0, (integer)left.uniqueid = right.childdid, fill1(left,right), keep(1));
	
  outrec fill2(level2 l, parents1 r) := transform
    self.RelativeOfUniqueId := (string)intformat ((integer) r.parentdid, 12, 1);
	  self := l;
  end;
	//get the first parent found
  filllevel2 := join(level2, parents1, (integer)left.uniqueid = right.childdid, fill2(left,right), keep(1));
	
  //get the first parent found
  filllevel3 := join(level3, parents2, (integer)left.uniqueid = right.childdid, fill2(left,right), keep(1));
	
  outrecs := filllevel1 + filllevel2 + filllevel3;
	
	// Add Key Risk Indicators
	outrec xfm_addResidentKri (outrec inRels) := TRANSFORM
				// Commenting out do to performance issue
				// kris := SmartRollup.fn_smart_KRIAttributes(param,(Integer)inRels.UniqueId,,,,,false);
				// SELF.KriIndicators := PROJECT(kris[1],TRANSFORM(iesp.smartlinxreport.t_SLRKRIIndicators,SELF := LEFT));			
				SELF := inRels;
				SELF := [];
	END;

	RelMetaKRI := PROJECT(outrecs,xfm_addResidentKri(LEFT));

	RETURN(IF(param.include_kris,RelMetaKRI,outrecs));
end;
