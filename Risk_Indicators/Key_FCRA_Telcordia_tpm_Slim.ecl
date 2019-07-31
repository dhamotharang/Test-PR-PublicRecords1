import doxie, Data_Services, vault, _control;
j := Telcordia_tpm_base;

slimrec := record	, MAXLENGTH(9999)
	j.npa;
	j.nxx;
	j.tb;
	j.dial_ind;
	j.point_id;
	j.nxx_type;
	dataset({string5 zip}) zipcodes;
end;

slimrec into_slim(j L) := transform
	self := L;
	self.zipcodes := [];
end;

j2 := dedup(sort(distribute(project(j, into_slim(LEFT)), hash(npa)), npa, nxx, tb, local), npa, nxx, tb, local);

slimrec denorm_j(j2 L, j R) := transform
	self.zipcodes := L.zipcodes + dataset([{R.zip}],{string5 zip});
	self := L;
end;

j3 := denormalize(j2,j, left.npa= right.npa and left.nxx = right.nxx and
				    left.tb = right.tb,
			   denorm_j(LEFT,RIGHT));



#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_FCRA_Telcordia_tpm_slim := vault.Risk_Indicators.Key_FCRA_Telcordia_tpm_Slim;
#ELSE
export Key_FCRA_Telcordia_tpm_slim := INDEX(j3,{npa,nxx,tb},{j3},Data_Services.Data_Location.Prefix('Telcordia')+'thor_data400::key::fcra::telcordia_tpm_slim_'+doxie.Version_SuperKey,OPT);
#END;


