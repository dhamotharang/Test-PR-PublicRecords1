import ln_propertyv2,property,ln_property, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address, watchdog;

export property_didAndbdid(dataset(recordof(LN_PropertyV2.layout_deed_mortgage_property_search)) in_srch) := function

LN_PropertyV2.layout_deed_mortgage_property_search roll_dates(LN_PropertyV2.layout_deed_mortgage_property_search l) := transform
	self.dt_first_seen            := if(l.dt_last_seen > l.dt_first_seen, l.dt_first_seen, l.dt_last_seen);
	self.dt_last_seen             := if(l.dt_last_seen < l.dt_first_seen, l.dt_first_seen, l.dt_last_seen);
	self.dt_vendor_last_reported  := (integer)l.process_date[1..6];
	self.dt_vendor_first_reported := l.dt_first_seen;
	self.mname                    := stringlib.stringfindreplace(l.mname,',ETAL','');
	self.nameasis                 := ln_property.fn_patch_name_field(l.nameasis);
	self                          := l;
end;

file_dedup := dedup(project(in_srch, roll_dates(left)),all,local);

PreDID_Rec
 :=
  record
    
	qstring34  source_group := '';
	qstring34  vendor_id := '';
	LN_PropertyV2.layout_deed_mortgage_property_search; 
	integer8	temp_DID		    := 0;
	integer8	temp_BDID    	    := 0;
	string9 appended_SSN := '';
    string9 appended_tax_id := '';
  end;
  
PreDID_Rec taddDID(file_dedup L)
 :=
  transform
	self.vendor_id    :=  l.ln_fares_id + 'FA' + ((string)(hash(l.fname, l.lname, l.prim_name)))[1..4];
	self			:=	L;
	
  end
 ;

Prefile	:= project(file_dedup,taddDID(left)); 

preDID  := prefile(cname  = '');
preBDID := prefile(cname <> '');

//append DID

matchset := ['A', 'P', 'Z'];

did_add.MAC_Match_Flex
	(PreDID, matchset,					
	 '', '', fname, mname, lname, suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone_number, 
	 temp_did, PreDID_Rec, false, DID_Score_field,
	 75, postDID)
	 
//append BDID

business_header.MAC_Source_Match(preBDID,dPostSourceMatch,
						false,temp_BDID,
						false,'PR',
						false,foo,
						cname,
						prim_Range,Prim_name,sec_range,zip,
						true,phone_number,
						false,foo,
						false,vendor_id);	 


dWithSourceMatch		:=	dPostSourceMatch(temp_BDID != 0);
dWithNoSourceMatch		:=	dPostSourceMatch(temp_BDID = 0);

myset := ['A'];

Business_header_ss.MAC_Match_Flex(dWithNoSourceMatch,myset,
						cname,
						prim_range,prim_name,zip,sec_range,st,
						phone_number,foo,
						temp_bdid,
						PreDID_Rec,
						false,BDID_Score_field,
						postbdid);
						
post_DID_BDID := postbdid +  postDID + dWithSourceMatch;

//Append SSN 

did_add.MAC_Add_SSN_By_DID(post_DID_BDID, temp_did, appended_SSN, file_search_ssn, false);

// Append Fein


Business_Header_SS.MAC_Add_FEIN_By_BDID(file_search_ssn, temp_bdid, appended_tax_id, file_search_fein);

LN_PropertyV2.Layout_DID_Out reformattemp(file_search_fein L)
 :=
  transform
    self.DID		    :=	L.temp_DID;
    self.BDID		    :=	L.temp_BDID;
	self.app_SSN        :=  l.appended_SSN ;
    self.app_tax_id     :=  l.appended_tax_id ;
	self := L;
	end;

outfinal := project(file_search_fein, reformattemp(left));

search_final := distribute(outfinal,hash(ln_fares_id)) : persist('~thor_data400::persist::ln_propertyv2::property_did'); /*+ ln_property.irs_dummy_recs_search */

return search_final;

end;



