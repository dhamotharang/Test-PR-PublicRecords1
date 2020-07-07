// relatives key contains source_type with how assoc was found see below:
  // -1 By_SSN
	// -2 By_Relatives
	// -3 or actual houseNumber
	// -4 by business_header.Business_Associates
	// -5 By_Property
	// -6 By_Vehiclev2
	// -7 By_Spouse
		 
import iesp, PersonReports, Relationship, SmartRollup, riskwise;

export fn_smart_OtherPersonAssoc( dataset(iesp.bpsreport.t_BpsReportAssociateSlim) inAssociates,unsigned6 subjectDID, PersonReports.IParam._smartlinxreport param) := FUNCTION
  outlayout := iesp.smartlinxreport.t_SLRAssociate;
	entitylayoutSlim := iesp.bpsreport.t_BpsReportIdentitySlim;
	entitylayout := iesp.bps_share.t_BpsReportIdentity;
	foundLayout := record
	   integer uniqueID;
	   dataset(iesp.share.t_StringArrayItem) Roles {xpath('Roles/Role'), MAXCOUNT(iesp.Constants.SMART.MaxRoles)};
	end;
	foundlayout addMisc(inAssociates l, Relationship.layout_GetRelationship.interfaceOutputNeutral r) := transform
	  self.uniqueID := (integer)l.uniqueId;
    self.Roles := map(r.source_type = -3 => 
											dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.PossibleRoommate]], iesp.share.t_StringArrayItem)	 ,
											r.source_type = -4 => 
											dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.Business]], iesp.share.t_StringArrayItem)	 ,
											r.source_type = -5 => 
											dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.RealEstate]], iesp.share.t_StringArrayItem)	 ,
											r.source_type = -6 => 
											dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.OtherProp]], iesp.share.t_StringArrayItem),
											// default to Associate
											dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.Associate]], iesp.share.t_StringArrayItem)	 
											);
  end;
	
	// Use relationship proc to retrieve relative recs.
	Relationship.Layout_GetRelationship.DIDs_layout prep_did() := transform
		self.did := subjectDid;
		self := [];
	end;
	did_rec := DATASET ([prep_did()]);
	relRecs := Relationship.proc_GetRelationshipNeutral(did_rec,
		RelativeFlag:=TRUE,
		AssociateFlag:=TRUE,
		MaxCount:=RiskWise.max_atmost,
		doAtmost:=TRUE,
		txflag:=Relationship.Functions.getTransAssocFlgs(param.relationship_transAssocMask)
		).result;
  
	allRoleRecs := join(inAssociates, relRecs, 
										subjectDID=right.did1 and 
										(integer)left.UniqueId = right.did2, 
										addMisc(left, right));
 	  	
	foundlayout rollem(foundlayout l, foundlayout r) := transform
	  self.UniqueId := l.uniqueId;
		self.Roles := l.Roles + r.Roles;
	end;
	sallRoleRecs := sort(allRoleRecs, UniqueID,  record);
	roleRecs := rollup(sallRoleRecs, left.UniqueID = right.UniqueId, rollem(left, right));
	
  outlayout fillRole(inAssociates l, roleRecs r) := transform
	   self.roles := r.roles;
		 entities := project(l.akas,transform(entitylayout, self := LEFT, self :=[]));
		 rollupEntities := SmartRollup.fn_smart_rollup_names(entities);
		 self.akas := Project(rollupEntities, entitylayoutSlim);
		 self := l;
		 self := [];
	end;
  outrecs := join(inAssociates, roleRecs,  (integer)left.uniqueID = right.uniqueID, fillRole(left,right), left outer);

	// Add Key Risk Indicators
	outlayout xfm_addResidentKri (outlayout inAssoc) := TRANSFORM
				// Commenting out due to performance issue
				// kris := SmartRollup.fn_smart_KRIAttributes(param,(Integer)inAssoc.UniqueId,,,,,false);
        // SELF.KriIndicators := PROJECT(kris[1],TRANSFORM(iesp.smartlinxreport.t_SLRKRIIndicators,SELF := LEFT));			
				SELF := inAssoc;
				SELF := [];
	END;

	AssocMetaKRI := PROJECT(outrecs,xfm_addResidentKri(LEFT));
	
	RETURN(IF(param.include_kris,AssocMetaKRI,outrecs));
END;
