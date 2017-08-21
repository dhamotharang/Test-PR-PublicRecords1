
import BIPV2_FindLinks,BIPV2_BlockLink;
EXPORT VisualLinking_Lgid3(unsigned6 seleid_in, string version_in, unsigned6 lgid3_in) := function
	shared sele_base:=BIPV2_Blocklink.ManualOverlinksLGID3.reducedlayout;
	shared seleSet:=dataset([],sele_base);
	shared prox_base:=BIPV2_Blocklink.ManualOverlinksProxId.reducedlayout;
	shared proxSet:=dataset([],prox_base);
  shared lid:=(string)lgid3_in;
  shared relation_rec:=record
		UNSIGNED id;
		STRING name;
		UNSIGNED parent;
		STRING relationship;
	end;
	
	shared det_rec:=record
		UNSIGNED id;
		STRING det;
	end;
	
	shared Val(string name,string leftVal, string rightVal, string score) := FUNCTION
		RETURN if(leftVal<>'' or rightVal<>'', '<tr><td>' + name + '</td><td>' + trim(leftVal) + '</td><td>' + trim(rightVal) + '</td><td>' + score + '</td></tr>','');
	END;

	shared ds_link:=BIPV2_FindLinks.Hist_OneSele(seleid_in, version_in, lgid3_in); 
  shared overlink_reduced:=BIPV2_Blocklink.ManualOverlinksLGID3.candidates(seleid_in,lgid3_in);


	shared ds0:=dataset([{lgid3_in,'endding lgid3 ' + lid + 'in version ' + version_in, 0, '1'}],relation_rec);
	shared ds1:=project(ds_link,transform(relation_rec,self.id:=left.lgid31;
															self.name :='lgid3 ' + (string)Left.lgid31 + '-->' + (string)Left.lgid32 + ' in version ' +
																				version_in + ' in iter ' + (string)Left.iternumber;
															self.parent:=Left.lgid32; self.relationship:=''));
												
	shared dRelatives:=ds1+ds0;
	
	shared ds2:=dataset([{lgid3_in,''}],det_rec);
	shared ds3:=project(ds_link,transform(det_rec,self.id:=left.lgid31;
		 self.det:='<table border=1 class=formatTable><tr><td>rcid1</td><td>rcid2</td><td>Prox Count in The LGID3</td><td>iternumber</td><td>Threshold</td><td>conf</td><td>conf_prop</td></tr><tr><td>' +
		 (string)left.rcid1 + '</td><td>' + (string)left.rcid2 + '</td><td>' + (string)Left.proxcntinlgid3 + '</td><td>' + (string)Left.iternumber + '</td><td>' + (string)Left.ThresholdVal + '</td><td>' +	 
		 (string)Left.conf + '</td><td>' + (string)Left.conf_prop + '</td></tr></table>' +
		 '<table border=1 class=formatTable><tr><td>field_name</td><td>field1</td><td>field2</td><td>score</td></tr>' +
		 Val('sbfe_id', left.left_sbfe_id, Left.right_sbfe_id, (string)Left.sbfe_id_score) + 
		 Val('active_duns_number', left.left_active_duns_number, Left.right_active_duns_number, (string)Left.active_duns_number_score) + 
		 Val('company_name', left.left_company_name, Left.right_company_name, (string)Left.company_name_score) + 
		 Val('duns_number', left.left_duns_number, Left.right_duns_number, (string)Left.duns_number_score) + 
		 Val('duns_number_concept', left.left_duns_number_concept, Left.right_duns_number_concept, (string)Left.duns_number_concept_score) + 
		 Val('company_fein', left.left_company_fein, Left.right_company_fein, (string)Left.company_fein_score) + 
		 Val('company_charter_number', left.left_company_charter_number, Left.right_company_charter_number, (string)Left.company_charter_number_score) + 
		 Val('cnp_number', left.left_cnp_number, Left.right_cnp_number, (string)Left.cnp_number_score) + 
		 Val('company_inc_state', left.left_company_inc_state, Left.right_company_inc_state, (string)Left.company_inc_state_score) + 
		 Val('cnp_btype', left.left_cnp_btype, Left.right_cnp_btype, (string)Left.cnp_btype_score) + 
		 '</table>'									 
		 ));
  shared dDet:=ds2 + ds3;
	
	shared dLabels:=PROJECT(dRelatives,TRANSFORM(BIPV2_BlockLink.Types.GraphLabels,SELF.label:=LEFT.name;SELF:=LEFT;));
	shared dRelationships:=PROJECT(dRelatives,TRANSFORM(BIPV2_BlockLink.Types.GraphRelationships,SELF.id:=LEFT.parent;SELF.linkid:=LEFT.id;SELF.linklabel:=LEFT.relationship;));
  BIPV2_BlockLink.D3.Graph('VerticalTree','VerticalTree', 'S', dLabels,dRelationships, dDet, proxSet,overlink_reduced);

return 'OK';
end;


