import ingenix_natlprof, sexoffender,doxie_files, death_master, prof_licensev2;

providers := ingenix_natlprof.basefile_provider_did;

layout_providerid_did := record
 string providerid := providers.providerid;
 string12 did := providers.did;
end;
tproviderid_did := dedup(sort(table(distribute(providers,hash(providerid)),layout_providerid_did,providerid,did),providerid,did,local),providerid,did,local);

layout_provider_did_cnt := record
 string providerid := tproviderid_did.providerid;
 integer total_dids := count(group);
end;
tproviderid_did_cnt := table(tproviderid_did((integer) did<>0 ),layout_provider_did_cnt,providerid,local);

// output(choosen(tproviderid_did((integer) did<>0),500));
// output(choosen(tproviderid_did_cnt(total_dids>1),500));
// count(tproviderid_did_cnt(total_dids>1));

layout_provider_with_flags := record 
recordof(providers);
boolean has_death;
boolean has_sanction := false;
boolean has_sor := false;
boolean has_crim := false;
end;
pdd := dataset('~thor::temp::_provider_derogatories',layout_provider_with_flags,flat);

layout_provider_with_details := record
string12 DID;
string  taxid;
boolean has_death := false;
boolean has_crim := false;
boolean has_sor := false;
string	ProviderID;
string	BirthDate;
string  FILETYP := '';

string20 	 		Prov_Clean_fname			;
string20  			Prov_Clean_mname			;
string20 			Prov_Clean_lname			;
string5  		 	Prov_Clean_name_suffix 		;
string10  			prov_Clean_prim_range		;
string2  			prov_Clean_predir			;
string28 			prov_Clean_prim_name		;
string4   			prov_Clean_addr_suffix	    ;
string2  			prov_Clean_postdir			;
string10  			prov_Clean_unit_desig		;
string8   			prov_Clean_sec_range		;
string25 			prov_Clean_p_city_name	    ;
// string25 		prov_Clean_v_city_name	    ;
string2  			prov_Clean_st				;
string5  			prov_Clean_zip			    ;
// string4  		prov_Clean_zip4			    ;
string offender_key;
string offender_lname;
string offender_fname;
string offender_ssn_appended;
string seisint_primary_key;
string sor_lname;
string sor_fname;
string sor_ssn_appended;
string crim_offense_description;
string sor_offense_description;
string death_lname;
string death_fname;
string death_ssn_appended;
end;

pddf_bad := sort(distribute(pdd(has_crim or has_sor or has_death),hash(providerid)),providerid,local);
recordof(pddf_bad) to_eliminate_bad_dids(pddf_bad l, tproviderid_did_cnt r) := transform
self := l;
end;
pddf_good_did := join(pddf_bad,sort(distribute(tproviderid_did_cnt(total_dids>1),hash(providerid)),providerid,local),left.providerid=right.providerid,to_eliminate_bad_dids(left,right), local, left only);

pddf := sort(distribute(pddf_good_did,hash((unsigned6) did)),did,local);
crims:= sort(distribute(pull(doxie_files.key_offenders(data_type='1')),hash((unsigned6) sdid)),sdid,local);
layout_provider_with_details to_add_crim(pddf l,crims r) := transform
 self.offender_key:=if((unsigned6)  l.did<>0,r.offender_key,'');
 self.offender_lname:=if((unsigned6)  l.did<>0,r.lname,'');
 self.offender_fname:=if((unsigned6)  l.did<>0,r.fname,'');
 self.offender_ssn_appended := if((unsigned6)  l.did<>0,r.ssn_appended,'');
 self.seisint_primary_key := '';
 self.sor_lname := '';
 self.sor_fname := '';
 self.sor_ssn_appended := '';
 self.sor_offense_description := '';
 self.crim_offense_description := '';
 self.death_lname := '';
 self.death_fname := '';
 self.death_ssn_appended := '';
 self.filetyp:= '';
 self := l;
end;
pddfc := join(pddf,crims,
		((unsigned6)  left.did= (unsigned6)  right.sdid) and
		(left.prov_clean_lname<>'') and 
		(left.prov_clean_lname=right.lname) and 
		((unsigned6) left.did<>0),to_add_crim(left,right),local, left outer);

sors := sort(distribute(pull(sexoffender.Key_SexOffender_Payload),hash((unsigned6) did)),did,local);
layout_provider_with_details to_add_sor(pddfc l,sors r) := transform
 self.seisint_primary_key:=if( (unsigned6)  l.did<>0,r.seisint_primary_key,'');
 self.sor_lname:=if((unsigned6)  l.did<>0,r.lname,'');
 self.sor_fname:=if((unsigned6)  l.did<>0,r.fname,'');
 self.sor_ssn_appended := if((unsigned6)  l.did<>0,r.ssn,'');
 self.death_lname := '';
 self.death_fname := '';
 self.death_ssn_appended := '';
 self := l;
end;
pddfcs := join(pddfc,sors,
		((unsigned6) left.did= (unsigned6)  right.did) and
		(left.prov_clean_lname<>'') and 
		(left.prov_clean_lname=right.lname) and 
		((unsigned6) left.did<>0),to_add_sor(left,right),local,left outer);
		
deadies := sort(distribute(pull(death_master.key_AutokeyPayload),hash((unsigned6) did)),did,local);
layout_provider_with_details to_add_deadies(pddfcs l,deadies r) := transform
 self.death_lname:=if((unsigned6)  l.did<>0,r.lname,'');
 self.death_fname:=if((unsigned6)  l.did<>0,r.fname,'');
 self.death_ssn_appended := if((unsigned6)  l.did<>0,r.ssn,'');
 self := l;
end;
pddfcsd := join(pddfcs,deadies,
		((unsigned6) left.did= (unsigned6)  right.did) and
		(left.prov_clean_lname<>'') and 
		(left.prov_clean_lname=right.lname) and 
		((unsigned6) left.did<>0),to_add_deadies (left,right),local,left outer);

sors_offenses := sort(distribute(pull(sexoffender.key_sexoffender_offenses),hash(seisint_primary_key)),seisint_primary_key,local);
pddfcs_s := sort(distribute(pddfcsd,hash(seisint_primary_key)),seisint_primary_key,local);
layout_provider_with_details to_add_sor_off(pddfcs l, sors_offenses r) := transform
self.sor_offense_description := r.offense_description;
self := l;
end;
pddfcs_so := join(pddfcs_s, sors_offenses, left.seisint_primary_key=right.seisint_primary_key,to_add_sor_off(left,right),local,left outer);

crims_offenses := sort(distribute(pull(doxie_files.Key_Offenses),hash(offender_key)),offender_key,local);
pddfcs_so_c := sort(distribute(pddfcs_so,hash(offender_key)),offender_key,local);
layout_provider_with_details to_add_crim_off(pddfcs_so_c l, crims_offenses r) := transform
self.crim_offense_description := r.off_desc_1;
self := l;
end;
pddfcs_so_co := join(pddfcs_so_c, crims_offenses, left.offender_key=right.offender_key,to_add_crim_off(left,right),local,left outer);

layout_provider_with_details to_rollup_filetyp(pddfcs_so_co l, pddfcs_so_co r) := transform
self.filetyp := if(l.filetyp='AH',r.filetyp,l.filetyp);
self.Prov_Clean_mname := if(l.Prov_Clean_mname<>'',l.Prov_Clean_mname,r.Prov_Clean_mname);
self := l;
end;

ds_readied := sort(distribute(pddfcs_so_co,hash(providerid))
				,providerid,prov_clean_st,prov_Clean_p_city_name,did,crim_offense_description,sor_offense_description,filetyp,local);
				
res := rollup(ds_readied,to_rollup_filetyp(left,right)
				,providerid,prov_clean_st,prov_Clean_p_city_name,did,crim_offense_description,sor_offense_description,local);

layout_provider_prettied := record

string12 did;
string	ID;
string  taxid;
string  offender_ssn_appended;
string  sor_ssn_appended;
string  death_ssn_appended;
string1 Crim := '';
string1 SOR := '';
string1 dead := '';
string offender_lname;
string sor_lname;
string death_lname;
string provider_lname;
string offender_fname;
string sor_fname;
string death_fname;
string provider_fname;
string	DOB;
string  Typ;
string  Name;   
string Address;
string City_ST_Zip;
// string offender_key; //x
// string seisint_primary_key; //x
string crim_offense;
string sor_offense;
string offenses := '';
end;
layout_provider_prettied  to_pretty(res l) := transform
self.offender_lname := l.offender_lname;
self.sor_lname := l.sor_lname;
self.provider_lname := l.prov_clean_lname;
self.offender_fname := l.offender_fname;
self.sor_fname := l.sor_fname;
self.provider_fname := l.prov_clean_fname;
self.did := l.did;
self.ID := l.providerID;
self.Crim := if(l.has_crim,'Y','');
self.SOR := if(l.has_sor,'Y','');
self.dead := if(l.has_death,'Y','');
self.DOB := l.BirthDate;
self.Typ := l.filetyp;
self.Name :=  	
				trim(l.Prov_Clean_fname)+' '+ 
				trim(l.Prov_Clean_mname)+' '+
				trim(l.Prov_Clean_lname)+' '+
				trim(l.Prov_Clean_name_suffix);
self.Address := 
				trim(l.prov_Clean_prim_range)+' '+
				trim(l.prov_Clean_predir)+' '+
				trim(l.prov_Clean_prim_name)+' '+
				trim(l.prov_Clean_addr_suffix)+' '+
				trim(l.prov_Clean_postdir)+' '+
				trim(l.prov_Clean_unit_desig)+' '+
				trim(l.prov_Clean_sec_range);

self.City_ST_Zip := 
				trim(l.prov_Clean_p_city_name)+' '+
				trim(l.prov_Clean_st)+' '+
				trim(l.prov_Clean_zip);
self.crim_offense := trim(l.crim_offense_description);
self.sor_offense  := trim(l.sor_offense_description);
self := l; //x
end;
res_prettied := project(res,to_pretty(left));


layout_slim_offense := record	
	string	ID;
	string provider_lname;
	string sor_lname;
	string offender_lname;
	string offenses;
	end;
layout_slim_offense to_slim_sor_offense(res_prettied l) := transform	
	self.offenses := if(l.provider_lname=l.sor_lname and l.sor_offense<>'','{','') +trim(l.sor_offense) +if(l.provider_lname=l.sor_lname and l.sor_offense<>'','}','');
	self := l;
	end;
layout_slim_offense to_slim_crim_offense(res_prettied l) := transform
	self.offenses := if(l.provider_lname=l.offender_lname and l.crim_offense<>'','{','') +trim(l.crim_offense) +if(l.provider_lname=l.offender_lname and l.crim_offense<>'','}','');
	self := l;
	end;
normalized_offense := 
	dedup(
		sort(
		distribute(	project(res_prettied(sor_offense<>''),to_slim_sor_offense(left)) +
					project(res_prettied(crim_offense<>''),to_slim_crim_offense(left)),hash(ID))
		,record,local)
	,all,local);
layout_slim_offense to_roll_offenses(normalized_offense l,normalized_offense r) := transform
	self.offenses := trim(l.offenses)+ trim(r.offenses);
	self := l;
	end;
rolled_offenses := rollup(normalized_offense,to_roll_offenses(left,right),ID,local);


layout_provider_prettied to_finish(res_prettied l,rolled_offenses r) := transform
self.offenses := r.offenses;
self.crim_offense := '';
self.sor_offense := '';
self := l;
end;
res_with_offensex := dedup(sort(join(res_prettied, rolled_offenses, left.id=right.id, to_finish(left,right),local,left outer),record,local),all,local);
res_bad_or_dead_lname_match_with_offense := res_with_offensex((dead='Y' and dob<>'' and dob<='19500000' and provider_lname=death_lname) or provider_lname=offender_lname or provider_lname=sor_lname);

// add dates back in from professional licenses and ingenix

layout_provider_license_info := record
layout_provider_prettied;
string1 license_source;		//P,I
string2 license_state;
string license_number;
string license_board;
string license_status;
string license_type;
string license_effective_date;
string license_termination_date;
string license_renewal_date;
end;
ingenix_licenses := sort(distribute(ingenix_natlprof.Basefile_ProviderLicense,hash(providerID)),providerID,local);
// string	LicenseNumber;
// string	licenseState;
// string	Effective_Date;
// string	Termination_Date;
layout_provider_license_info to_append_ingenix_license(res_bad_or_dead_lname_match_with_offense l, ingenix_licenses r) := transform
self.license_source := 'I';
self.license_state := r.licensestate;
self.license_effective_date := r.effective_date;
self.license_termination_date := r.termination_date;
self.license_number := ''; //r.licensenumber;
self :=l;
self := [];
end;
res_with_ingenix := join(sort(distribute(res_bad_or_dead_lname_match_with_offense,hash(id)),id,local), ingenix_licenses,left.id=right.providerid, to_append_ingenix_license(left,right),local, left outer);

prof_licenses 	 := sort(distribute(prof_licensev2.File_ProfLic_Base,hash((unsigned6) did)),(unsigned6) did,local);
// string60    license_board;
// string60    license_type;
// string45    license_status;
// string20    license_number;
// string8     issue_date;
// string8     last_expiration_date;
// string8     renewal_date;
layout_provider_license_info to_append_prof_license(res_with_ingenix l, prof_licenses r) := transform
self.license_source := 'P';
self.license_state := r.source_st;
self.license_effective_date := r.issue_date;
self.license_termination_date := r.expiration_date;
self.license_renewal_date := r.last_renewal_date;
self.license_board := r.profession_or_board;
self.license_type := r.license_type;
self.license_status := r.status;
self :=l;
end;
res_with_prof_license := join(sort(distribute(res_with_ingenix,hash((unsigned6) did)),(unsigned6) did,local), prof_licenses,(unsigned6)left.did=(unsigned6)right.did, to_append_prof_license(left,right),local, left outer);

// output(count(pdd),named('count_all'));
// output(count(res_with_prof_license ),named('count_dead_or_derogatory'));
strong := res_with_prof_license((provider_fname[1..3]=offender_fname[1..3] or provider_fname[1..3]=sor_fname[1..3] or provider_fname[1..3]=death_fname[1..3]) and 
			   (taxid<>'' and (taxid=sor_ssn_appended or taxid=offender_ssn_appended or taxid=death_ssn_appended)));
// output(choosen(strong,all),named('strong'));
export _provider_derogatories_detail := strong : persist ('~thor::persist::_provider_derogatories_detail_strong');

// output(choosen(res_with_prof_license ( 
		    // (not(provider_fname=offender_fname or provider_fname=sor_fname  or provider_fname=death_fname) or 
		     // not(taxid<>'' and (taxid=sor_ssn_appended or taxid=offender_ssn_appended or taxid=death_ssn_appended))))
		// ,all),named('other'));


