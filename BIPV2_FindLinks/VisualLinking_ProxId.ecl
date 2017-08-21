import BIPV2_FindLinks,BIPV2_BlockLink,STD;
EXPORT VisualLinking_ProxId(unsigned6 proxid_in, string version_in) := function
	shared sele_base:=BIPV2_Blocklink.ManualOverlinksLGID3.reducedlayout;
	shared seleSet:=dataset([],sele_base);
	shared prox_base:=BIPV2_Blocklink.ManualOverlinksProxId.reducedlayout;
	shared proxSet:=dataset([],prox_base);
  shared string pid:=(string)proxid_in;
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

	shared ds_link:=BIPV2_FindLinks.Hist_OneProx(proxid_in, version_in); 
  shared overlink_reduced:=BIPV2_Blocklink.ManualOverlinksPROXID.candidates(proxid_in);

	shared ds0:=dataset([{proxid_in,'endding prox ' + pid + 'in version ' + version_in, 0, '1'}],relation_rec);
	shared ds1:=project(ds_link, transform(relation_rec, self.id:=left.proxid_before; 
												self.name :='proxid ' + (string)Left.proxid_before + '-->' + (string)Left.proxid_after + ' in version ' + 
												            version_in + ' in iter ' + (string)Left.iternumber;
												self.parent:=Left.proxid_after; self.relationship:=''));
												
	shared dRelatives:=ds1+ds0;
	
	shared ds2:=dataset([{proxid_in,''}],det_rec);
	shared ds3:=project(ds_link,transform(det_rec,self.id:=left.proxid_before;
							 self.det:='<table border=1 class=formatTable><tr><td>rcid1</td><td>Left Company_name</td><td>IsMJ6?</td><td>Threshold</td><td>--</td></tr><tr><td>' +
							 (string)left.rcid1 + '</td><td>' + trim(STD.Str.FindReplace(left.left_company_name,'&','&amp;')) + '</td><td>' + (string)Left.ismj6 + '</td><td>' + (string)Left.ThresholdVal + '</td><td>' +
							 '--</td></tr><tr><td>rcid2</td><td>Right Company_name</td><td>attribute_conf</td><td>conf_prop</td><td>conf</td></tr><tr><td>' +
							 (string)left.rcid2 + '</td><td>' + trim(STD.Str.FindReplace(left.right_company_name,'&','&amp;')) + '</td><td>' + (string)Left.attribute_conf + '</td><td>' + (string)Left.conf_prop + '</td><td>' + (string)Left.conf +
							 '</td></tr></table>'+
							 '<table border=1 class=formatTable><tr><td>field_name</td><td>field1</td><td>field2</td><td>score</td></tr>' +
							 '<tr><td>cnp_name</td><td>' + trim(STD.Str.FindReplace(left.left_cnp_name,'&','&amp;')) + '</td><td>' + trim(STD.Str.FindReplace(Left.right_cnp_name,'&','&amp;')) + '</td><td>' + (string)Left.cnp_name_score + '</td></tr>' +
							 Val('cnp_number', left.left_cnp_number, Left.right_cnp_number, (string)Left.cnp_number_score) + 
							 Val('prim_range', left.left_prim_range, Left.right_prim_range, (string)Left.prim_range_score) + 
							 Val('prim_name_derived', left.left_prim_name_derived, Left.right_prim_name_derived, (string)Left.prim_name_derived_score) + 
							 Val('st', left.left_st, Left.right_st, (string)Left.st_score) + 
							 Val('zip', left.left_zip, Left.right_zip, (string)Left.zip_score) + 
							 Val('hist_duns_number', left.left_hist_duns_number, Left.right_hist_duns_number, (string)Left.hist_duns_number_score) + 
							 Val('hist_domestic_corp_key', left.left_hist_domestic_corp_key, Left.right_hist_domestic_corp_key, (string)Left.hist_domestic_corp_key_score) + 
							 Val('foreign_corp_key', left.left_foreign_corp_key, Left.right_foreign_corp_key, (string)Left.foreign_corp_key_score) + 
							 Val('unk_corp_key', left.left_unk_corp_key, Left.right_unk_corp_key, (string)Left.unk_corp_key_score) + 
							 Val('company_phone', left.left_company_phone, Left.right_company_phone, (string)Left.company_phone_score) + 
							 Val('active_duns_number', left.left_active_duns_number, Left.right_active_duns_number, (string)Left.active_duns_number_score) + 
							 Val('active_domestic_corp_key', left.left_active_domestic_corp_key, Left.right_active_domestic_corp_key, (string)Left.active_domestic_corp_key_score) + 
							 Val('company_fein', left.left_company_fein, Left.right_company_fein, (string)Left.company_fein_score) + 
							 Val('active_enterprise_number', left.left_active_enterprise_number, Left.right_active_enterprise_number, (string)Left.active_enterprise_number_score) + 
							 Val('sec_range', left.left_sec_range, Left.right_sec_range, (string)Left.sec_range_score) + 
							 Val('v_city_name', left.left_v_city_name, Left.right_v_city_name, (string)Left.v_city_name_score) + 
							 Val('hist_enterprise_number', left.left_hist_enterprise_number, Left.right_hist_enterprise_number, (string)Left.hist_enterprise_number_score) + 
							 Val('company_csz', left.left_company_csz, Left.right_company_csz, (string)Left.company_csz_score) + 
							 Val('company_addr1', left.left_company_addr1, Left.right_company_addr1, (string)Left.company_addr1_score) + 
							 Val('company_address', left.left_company_address, Left.right_company_address, (string)Left.company_address_score) + 
							 Val('prim_range_derived', left.left_prim_range_derived, Left.right_prim_range_derived, (string)Left.prim_range_derived_score) + 
							 Val('cnp_btype', left.left_cnp_btype, Left.right_cnp_btype, (string)Left.cnp_btype_score) + 
							 '</table>'									 
/* 							 '<tr><td>cnp_number</td><td>' + left.left_cnp_number + '</td><td>' + Left.right_cnp_number + '</td><td>' + (string)Left.cnp_number_score + '</td></tr>' +
								 '<tr><td>prim_range</td><td>' + left.left_prim_range + '</td><td>' + Left.right_prim_range + '</td><td>' + (string)Left.prim_range_score + '</td></tr>' +
								 '<tr><td>prim_name_derived</td><td>' + left.left_prim_name_derived + '</td><td>' + Left.right_prim_name_derived + '</td><td>' + (string)Left.prim_name_derived_score + '</td></tr>' +
								 '<tr><td>st</td><td>' + left.left_st + '</td><td>' + Left.right_st + '</td><td>' + (string)Left.st_score + '</td></tr>' +
								 '<tr><td>zip</td><td>' + left.left_zip + '</td><td>' + Left.right_zip + '</td><td>' + (string)Left.zip_score + '</td></tr>' +
								 '<tr><td>ebr_file_number</td><td>' + left.left_ebr_file_number + '</td><td>' + Left.right_ebr_file_number + '</td><td>' + (string)Left.ebr_file_number_score + '</td></tr>' +
								 '<tr><td>hist_duns_number</td><td>' + left.left_hist_duns_number + '</td><td>' + Left.right_hist_duns_number + '</td><td>' + (string)Left.hist_duns_number_score + '</td></tr>' +
								 '<tr><td>hist_domestic_corp_key</td><td>' + left.left_hist_domestic_corp_key + '</td><td>' + Left.right_hist_domestic_corp_key + '</td><td>' + (string)Left.hist_domestic_corp_key_score + '</td></tr>' +
								 '<tr><td>foreign_corp_key</td><td>' + left.left_foreign_corp_key + '</td><td>' + Left.right_foreign_corp_key + '</td><td>' + (string)Left.foreign_corp_key_score + '</td></tr>' +
								 '<tr><td>unk_corp_key</td><td>' + left.left_unk_corp_key + '</td><td>' + Left.right_unk_corp_key + '</td><td>' + (string)Left.unk_corp_key_score + '</td></tr>' +
								 '<tr><td>company_phone</td><td>' + left.left_company_phone + '</td><td>' + Left.right_company_phone + '</td><td>' + (string)Left.company_phone_score + '</td></tr>' +
								 '<tr><td>active_duns_number</td><td>' + left.left_active_duns_number + '</td><td>' + Left.right_active_duns_number + '</td><td>' + (string)Left.active_duns_number_score + '</td></tr>' +
								 '<tr><td>active_domestic_corp_key</td><td>' + left.left_active_domestic_corp_key + '</td><td>' + Left.right_active_domestic_corp_key + '</td><td>' + (string)Left.active_domestic_corp_key_score + '</td></tr>' +
								 '<tr><td>company_fein</td><td>' + left.left_company_fein + '</td><td>' + Left.right_company_fein + '</td><td>' + (string)Left.company_fein_score + '</td></tr>' +
								 '<tr><td>active_enterprise_number</td><td>' + left.left_active_enterprise_number + '</td><td>' + Left.right_active_enterprise_number + '</td><td>' + (string)Left.active_enterprise_number_score + '</td></tr>' +
								 '<tr><td>sec_range</td><td>' + left.left_sec_range + '</td><td>' + Left.right_sec_range + '</td><td>' + (string)Left.sec_range_score + '</td></tr>' +
								 '<tr><td>v_city_name</td><td>' + left.left_v_city_name + '</td><td>' + Left.right_v_city_name + '</td><td>' + (string)Left.v_city_name_score + '</td></tr>' +
								 '<tr><td>hist_enterprise_number</td><td>' + left.left_hist_enterprise_number + '</td><td>' + Left.right_hist_enterprise_number + '</td><td>' + (string)Left.hist_enterprise_number_score + '</td></tr>' +
								 '<tr><td>company_csz</td><td>' + left.left_company_csz + '</td><td>' + Left.right_company_csz + '</td><td>' + (string)Left.company_csz_score + '</td></tr>' +
								 '<tr><td>company_addr1</td><td>' + left.left_company_addr1 + '</td><td>' + Left.right_company_addr1 + '</td><td>' + (string)Left.company_addr1_score + '</td></tr>' +
								 '<tr><td>company_address</td><td>' + left.left_company_address + '</td><td>' + Left.right_company_address + '</td><td>' + (string)Left.company_address_score + '</td></tr>' +
								 '<tr><td>prim_range_derived</td><td>' + left.left_prim_range_derived + '</td><td>' + Left.right_prim_range_derived + '</td><td>' + (string)Left.prim_range_derived_score + '</td></tr>' +
								 '<tr><td>cnp_btype</td><td>' + left.left_cnp_btype + '</td><td>' + Left.right_cnp_btype + '</td><td>' + (string)Left.cnp_btype_score + '</td></tr>' +
							 '</table>'
*/
							 ));
  shared dDet:=ds2 + ds3;
	
	shared dLabels:=PROJECT(dRelatives,TRANSFORM(BIPV2_BlockLink.Types.GraphLabels,SELF.label:=LEFT.name;SELF:=LEFT;));
	shared dRelationships:=PROJECT(dRelatives,TRANSFORM(BIPV2_BlockLink.Types.GraphRelationships,SELF.id:=LEFT.parent;SELF.linkid:=LEFT.id;SELF.linklabel:=LEFT.relationship;));
	
	dLabels;
	dRelationships;
	dDet;
  BIPV2_BlockLink.D3.Graph('VerticalTree','VerticalTree', 'P', dLabels,dRelationships, dDet, overlink_reduced, seleSet);

return 'OK';
end;


