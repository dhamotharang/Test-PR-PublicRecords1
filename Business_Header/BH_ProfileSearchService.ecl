/*--SOAP--
<message name="BH_ProfileSearchService">
  <part name="CompanyName" 		type="xsd:string"/>
  <part name="ExactOnly"   		type="xsd:boolean"/>
	<part name="StrictMatch"		type="xsd:boolean"/>
  <part name="FirstName"   		type="xsd:string"/>
  <part name="MiddleName"  		type="xsd:string"/>
  <part name="LastName"    		type="xsd:string"/>
  <part name="Addr"	       		type="xsd:string"/>
  <part name="City"        		type="xsd:string"/>
  <part name="State"       		type="xsd:string"/>
  <part name="Zip"         		type="xsd:string"/>
  <part name="FEIN"		  		type="xsd:string"/>
  <part name="Phone"	  		type="xsd:string"/>
  <part name="MileRadius"  		type="xsd:unsignedInt"/>
  <part name="MaxResults"  		type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" 	type="xsd:unsignedInt"/>
  <part name="SkipRecords" 		type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
</message>
*/
/*--INFO-- This service searches the business header file.*/


import suppress, STD;

export BH_ProfileSearchService() := macro
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#stored('MileRadius',25);
#stored('isProfileSearch',true);
#stored('AllowNickNames',true);

Business_Header.doxie_MAC_Field_Declare(true)

res_rec := record
	unsigned6 BDID;
	UNSIGNED4 seq := 0;
	UNSIGNED1 score := 0;
end;

//***** REGULAR SEARCH FOR BDID
gb_bdids := if(is_CompSearch or is_CompAddrSearch, Business_Header.doxie_get_bdids_plus()(score > 40));

//***** BDID ADDRESS
/*
doxie.layout_addressSearch prepaddr(precs l) := transform
	self.state := l.st;
	self.zip := l.z5;
	self := l;
end;

precs_prp := project(precs, prepaddr(left));

ad_bdids_raw := doxie.bdid_from_address(precs_prp, false);
*/
//***** GET BDIDS BY CONTACT NAME
cnv := if(is_CompSearch, '', company_name_Value); //we will combine later, so no need to filter on company name here
cn_bdids_unf := IF(is_ContSearch,Business_Header.Fetch_BC(bdid_value,(unsigned6)did_value,ssn_value,fname_value,mname_value,lname_value,prange_value,pname_value,city_value,state_value,zip_val,cnv,glb_ok,dppa_ok,nicknames,phonetics)
																 (from_hdr='N'));

 
res_rec cntra(cn_bdids_unf l) := transform
	self.bdid := l.bdid;
	self.seq := 2; //just to keep track of where i got the bdid, at least for now
end;

cn_bdids := project(cn_bdids_unf, cntra(left));

//cn_bdids := dataset([],res_rec);


//***** PICK MY RESULT SET(S)
filtered_res_dups := 
	if(is_CompSearch and is_ContSearch,
	   join(gb_bdids, cn_bdids, left.bdid = right.bdid, lookup), //then must hit both
	   gb_bdids + cn_bdids);		//else use either
	

filtered_res_srt := sort(filtered_res_dups, bdid, seq, -score); //not sure seq is needed
filtered_res_preSuppress := dedup(filtered_res_srt, bdid);
Suppress.MAC_Suppress(filtered_res_preSuppress,filtered_res,application_type_value,Suppress.Constants.LinkTypes.BDID,bdid,'','',false,'');

//***** APPEND THE BEST INFO
bhkb := Business_Header.Key_BH_Best;

layout_most := record
	unsigned6 group_id := 0;
	unsigned6 group_score := 0;
	qstring10 prim_range;
	string2   predir;
	qstring28 prim_name;
	qstring4  addr_suffix;
	string2   postdir;
	qstring5  unit_desig;
	qstring8  sec_range;
	qstring25 city;
	string2   state;
	string5 zip; 
	unsigned1 seq;
	unsigned1 score;
	unsigned1 actual_zip_distance;
	string6 Profile_Raw := 'report';
	string6 Profile_Risk := 'report';
	string120 input_company_name_value;
	string30 input_first_name_value;
	string30 input_last_name_value;
	string25 input_city_value;
	string2 input_state_value;
	string5 input_zip_value;
end;

layout_rest := record
	unsigned6 bdid;
	unsigned4 dt_last_seen := 0;
	qstring120 company_name;
end;

mymaxlength := 40000;
layout_temp := record, maxlength(mymaxlength)
	layout_rest;
	layout_most;
end;

layout_result := record, maxlength(mymaxlength)
	dataset(layout_rest) names_children;
	layout_most;
end;

string5 zip_used := 
	if(zip_val <> '', zip_val, city_zip_value);

layout_temp AddBest(filtered_res l,  bhkb r) := transform
	self.bdid := l.bdid;
	self.seq := l.seq;
	self.score := 0;	//better score below
	self.actual_zip_distance := 
		map(mile_radius_value = 0 or zip_used = '' or STD.Str.ToUpperCase(city_val) = (string25)r.city => 0,
			  ut.zip_Dist(zip_used, (string5)r.zip) > mile_radius_value => mile_radius_value,
				ut.zip_Dist(zip_used, (string5)r.zip));
	self.input_company_name_value := STD.Str.ToUpperCase(company_name_val);
	self.input_first_name_value := STD.Str.ToUpperCase(fname_val);
	self.input_last_name_value := STD.Str.ToUpperCase(lname_val);
	self.input_city_value := STD.Str.ToUpperCase(city_val);
	self.input_state_value := STD.Str.ToUpperCase(state_val);
	self.input_zip_value := STD.Str.ToUpperCase(zip_val);
	self.zip:=intformat(r.zip,5,1); 
	self := r;
end;

best_wls := join(filtered_res(bdid != 0), bhkb,
				keyed(left.bdid = right.bdid) and 
				(right.dppa_state = '' or (dppa_ok AND drivers.state_dppa_ok(right.dppa_state,dppa_purpose,,right.source))),
				AddBest(left, right),
				keep (1), limit (0));

//****** Add group ID and score 
grpk := Business_Header.Key_BH_SuperGroup_BDID;

layout_result AddGRPID(best_wls l, grpk r) := transform
	self.group_id := r.group_id;
	self.score := Business_Header.compute_ProfileSearchScore
		(l.company_name,l.prim_range,l.prim_name,l.sec_range,l.city,/*l.phone,l.fein,*/
		 l.actual_zip_distance);
	self.names_children := dataset([{l.bdid, l.dt_last_seen, l.company_name}],
															    layout_rest);
	self := l;
end;

wgrp := join(best_wls, grpk, keyed(left.bdid = right.bdid), AddGRPID(left, right), left outer, keep(1));




//rollem up
	
gsort := sort(wgrp, group_id, prim_range, predir, prim_name, addr_suffix, postdir,
									  unit_desig, sec_range, city, state, zip, -score, company_name);
	
gddpd := dedup(gsort, group_id, prim_range, predir, prim_name, addr_suffix, postdir,
									  unit_desig, sec_range, city, state, zip, keep(20));	
	
layout_result rollem(layout_result l, layout_result r) := transform
	self.names_children := l.names_children + r.names_children(bdid > 0);
	self.score := if(l.score > r.score, l.score, r.score);
	self := l;
end;

groll := rollup(gddpd, rollem(left, right), 
									  group_id, prim_range, predir, prim_name, addr_suffix, postdir,
									  unit_desig, sec_range, city, state, zip);


//find the group score
gsr := record
	groll.group_id;
	gs := max(group, groll.score);
end;

scores := table(groll, gsr, group_id);

groll addgscore(groll l, scores r) := transform
	self.group_score := r.gs;
	self := l;
end;

wscores := join(groll, scores, left.group_id = right.group_id, addgscore(left, right), lookup);

best_sorted := sort(wscores,-group_score, group_id, -score);//actual_zip_distance);
//sort by -max score in the group and group_id 
//sort the little names in the box?

doxie.MAC_Marshall_Results(best_sorted,outfinal,mymaxlength);


DO_ALL := output(outfinal, NAMED('Results'));

if(is_CompSearch or is_ContSearch or is_CompAddrSearch,
	 DO_ALL,
	 FAIL(11, doxie.ErrorCodes(11)))
	 
endmacro;
