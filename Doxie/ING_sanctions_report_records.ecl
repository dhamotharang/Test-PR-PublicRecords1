import Healthcare_Provider_Services, Healthcare_Header_Services,ingenix_natlprof, doxie_files,codes,AutoStandardI,ut;

export ING_sanctions_report_records(set of unsigned6 sanction_id_set, dataset(doxie.layout_references) in_dids = dataset([],doxie.layout_references)) := FUNCTION

doxie.MAC_Header_Field_Declare()
gm := AutoStandardI.GlobalModule();

string federalBoard := 'FEDERAL BOARDS';
string typeOIG := 'DEBARRED/EXCLUDED';
string typeGSA1 := 'EXCLUDED';
string typeGSA2 := 'EXCLUDED/DELETED';

sanctions_ids_raw := dataset(sanction_id_set, {unsigned6 sanction_id});
// peal off Header Sanction ID's and process them
// sanctions_ids_hdr := sanctions_ids_raw(sanction_id > 1000000);
sanctions_ids_hdr := sanctions_ids_raw;
getHdrIDs_fromSanctionID := dedup(project(sanctions_ids_hdr,transform(recordof(sanctions_ids_hdr),self.sanction_id:=(integer)((STRING)left.sanction_id)[1..(length((string)left.sanction_id)-3)])),all);
// Get header records for this Sanction
newlayout  := Healthcare_Header_Services.Layouts.autokeyInput;
ds:=project(getHdrIDs_fromSanctionID, transform(newlayout,
												 self.acctno:='1';
												 self.ProviderID := left.sanction_id; 
												 self.ProviderSrc := 'P';
												 self:=[];));
Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
	 self.glb_ok := ut.glb_ok (gm.GLBPurpose);
	 self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
         self.glb:= gm.GLBPurpose;
          self.dppa:= gm.DPPAPurpose; 

	 self.DRM := gm.DataRestrictionMask;
	 self.includeSanctions := true;
	// self:=[];Do not uncomment otherwise the default values will not get set.
end;
cfg:=dataset([buildConfig()]);

rawData := Healthcare_Header_Services.Records.getRecordsRawDoxieIndividual(ds,cfg);
filterResponse := rawdata(exists(legacysanctions));
out_rec := doxie.ingenix_sanctions_module.layout_ingenix_sanctions_report;
fmtHdrRecs := join(filterResponse.LegacySanctions,sanctions_ids_hdr,left.sanc_id=right.sanction_id,transform(out_rec,self.sanc_id:=(string)left.sanc_id;self:=left;self:=[]));
rawData2 := Healthcare_Header_Services.Records.getRecordsRawDoxiebyDid(in_dids,cfg);
filterResponse2 := rawdata2(exists(legacysanctions));
fmtHdrRecs2 := project(filterResponse2.LegacySanctions,transform(out_rec,self.sanc_id:=(string)left.sanc_id;self:=left;self:=[]));

//If there are legacy gap file sanction ids get them
// sanctions_ids := sanctions_ids_raw(sanction_id < 10000000);//Gap file records
sanctions_ids := sanctions_ids_raw;//Gap file records  review these as we might get bad matches and need to filter them out.

sanctions_id_key := doxie_files.key_sanctions_sancid;

//get sanctions record				
  
out_rec slim_out(sanctions_id_key r) := transform
	isFederal := stringlib.StringToUpperCase(r.sanc_brdtype) = federalBoard;
	isOIG := stringlib.StringToUpperCase(r.sanc_type)= typeOIG;
	isGSA := stringlib.StringToUpperCase(r.sanc_type)= typeGSA1 or stringlib.StringToUpperCase(r.sanc_type)= typeGSA2;
	
	self.npi := '',
	self.NPITierTypeID := 0,
	v3codes_Sanc_Cond := codes.key_codes_v3 (keyed(file_name='INGENIX_SANCTIONS'), keyed(field_name='SANC_CODE'), keyed(field_name2=''), keyed(code=r.SANC_COND));
	Sanc_Cond_Desc:=v3codes_Sanc_Cond[1].long_desc;
	Sanc_Cond_Value := if(r.SANC_COND<>'',
												if(Sanc_Cond_Desc<>'',
															r.SANC_COND + ': ' + Sanc_Cond_Desc,
															r.SANC_COND),
												'');
	// self.SANC_REAS := if(Sanc_Reason_Desc<>'',Sanc_Reason_Desc,r.SANC_REAS);
	self.SANC_COND := Sanc_Cond_Value; //if(Sanc_Reason_Desc<>'',r.SANC_COND & ': ' & Sanc_Reason_Desc,r.SANC_COND);
	self.sanc_grouptype := map(isFederal => 'FEDERAL', 
														 'STATE');
	self.sanc_subgrouptype := map(isFederal and isGSA => 'GSA', 
														 isFederal and isOIG => 'OIG', 
														 '');
	self := r;
end;  

out_rec add_npi({out_rec,string providerID} l, ingenix_natlprof.key_NPI_ProviderId r) := transform
	self.NPI := r.NPI;
	self.NPITierTypeID := (unsigned2)r.NPITierTypeID;
	self := l;
end;

out_final0 := join(sanctions_ids, sanctions_id_key,
                  left.sanction_id = right.l_sancid,
                  slim_out(right));  

out_final1 := join(out_final0, Ingenix_NatlProf.key_ProviderID_UPIN,
									left.sanc_upin = right.l_upin,
									transform({out_rec,string providerID},
										self.providerid := right.providerid,
										self := left),
									left outer);

out_final := join(out_final1, Ingenix_NatlProf.key_NPI_providerid,
									(unsigned)left.providerid = right.l_providerId,
									add_npi(left,right),
									left outer);
			   
out_final_srt := sort(out_final, sanc_grouptype, -sanc_sancdte_form, -sanc_updte_form, (unsigned6)SANC_ID);			   

out_final_verified := Healthcare_Provider_Services.Functions.getNPIthruNPPES_Sanc(out_final_srt);

return fmtHdrRecs+fmtHdrRecs2+out_final_verified;

END;
