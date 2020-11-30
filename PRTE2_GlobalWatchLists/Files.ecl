Import $, GlobalWatchLists,ut,prte2_header,aid,header,lib_datalib,Data_Services,doxie;

EXPORT files := module

// EXPORT GWL_IN := DATASET(constants.In_GWL, Layouts.GWL_base_Layout_ext - [bdid,global_sid,record_sid], CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), maxlength(25000),QUOTE('"')));
EXPORT GWL_IN := DATASET(constants.In_GWL, Layouts.GWL_base_Layout_IN, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), maxlength(25000),QUOTE('"')));
Export GWL_IN_1 := project(GWL_IN(cust_name = ''), 
transform(Layouts.Layout_GWL, 
self := Left;
SELF := [];	 
));

Export GWL_IN_2 := project(GWL_IN(cust_name != ''), 
transform(layouts.GWL_base_Layout_ext, 
self := Left;
SELF := [];	 
));  

EXPORT GWL_Base := DATASET(constants.Base_GWL, layouts.Layout_GWL, FLAT );

EXPORT GWL := Project(GWL_Base,Layouts.Layout_GlobalWatchLists);

Export File_Patriot := Project(GWL_Base (did !=0),
Transform(Layouts.Layout_Patriot_addressid,
Self:=Left;
Self:=[];
));

//key_patriot_file_full
Export GWL_Patriot := Project(GWL_Base (fname <> '' and lname <> ''),
Transform(Layouts.Layout_Patriot2,
Self:=Left;
self := []; 
));

h := PRTE2_header.FILES.file_headers;

hr := record
  h.did;
  h.fname;
  h.lname;
  h.mname;
  end;

ht := dedup(table(h,hr),did,fname,lname,mname,all);

Layouts.Layout_Did take_did(hr le, GWL_Base ri ) := transform
  self := le;
	self := ri;
	self := []; 
  end;
								
br := join(	ht,
						GWL_Base,
						left.fname=right.fname and left.mname=right.mname and
						left.lname=right.lname,
						take_did(left,right));

//key_patriot_did_file
export GWL_Dids := dedup(br,record,all);

popu := record
  GWL_Dids.fname;
  GWL_Dids.mname;
  GWL_Dids.lname;
	GWL_Dids.record_sid;
  GWL_Dids.global_sid;
  GWL_Dids.dt_effective_first;
  GWL_Dids.dt_effective_last;
  GWL_Dids.delta_ind;
  unsigned4 cnt := count(group);
  end;

ta := table(dedup(GWL_Dids,fname,mname,lname,did,all),popu,fname,mname,lname, record_sid, global_sid, dt_effective_first,dt_effective_last, delta_ind);

//key_annotated_names 
export GWL_Annotated_Names := sort(ta,-cnt);

//key_patriot_bdid_file
Export GWL_Patriot_bdid:= Project(GWL_Base (bdid !=0),
Transform (layouts.Layout_bdid,
Self:=Left;
Self:=[];
));

//key_globalwatchlistsseq
p := DEDUP(GWL_Base,pty_key,orig_vessel_name,fname,mname,lname,cname,all);
Layouts.Seq_Layout seq(p le, integer i) :=
TRANSFORM
	SELF.source := IF(le.pty_key[1..4]='OFAC',1,2);
	SELF.seq := i;
	SELF.max_seq := i;
	SELF.first_name := ut.CleanSpacesAndUpper(le.first_name);
	SELF.last_name := ut.CleanSpacesAndUpper(le.last_name);
	SELF.cname := IF(le.orig_vessel_name<>'',ut.CleanSpacesAndUpper(le.orig_vessel_name),le.cname);
	SELF := le;
END;
proj := PROJECT(p,seq(LEFT, counter));
srt := SORT(proj,-seq);
Layouts.Seq_Layout iterator(Layouts.Seq_Layout le, Layouts.Seq_Layout ri) :=
TRANSFORM
	SELF.max_seq := IF(le.max_seq=0,ri.max_seq,le.max_seq);
	SELF := ri;
END;
Export GWL_Seq := ITERATE(srt, iterator(LEFT,RIGHT));

//key_globalwatchlistsglobalwatchlists_key
GWL fix_vessels(GWL le) :=
TRANSFORM
	SELF.orig_pty_name := IF(le.orig_vessel_name<>'',le.orig_vessel_name,le.orig_pty_name);
	SELF.cname := IF(le.orig_vessel_name<>'',ut.CleanSpacesAndUpper(le.orig_vessel_name),le.cname);
	SELF.country := le.country;
	SELF.address_country := ut.CleanSpacesAndUpper(le.address_country);
	SELF.first_name := ut.CleanSpacesAndUpper(le.first_name);
	SELF.last_name := ut.CleanSpacesAndUpper(le.last_name);
	SELF := le;
END;
Export GWL_vessels_fixed := PROJECT(GWL,fix_vessels(LEFT));

//key_globalwatchlistscountries
// p_country := DEDUP(GWL(ut.CleanSpacesAndUpper(name_type)	=	'COUNTRY'),pty_key,address_country,all);
p_country := DEDUP(GWL(ut.CleanSpacesAndUpper(country) <>	''),pty_key,address_country,all);
Layouts.Country_Layout seq(p_country le) :=
TRANSFORM
	SELF.country := ut.CleanSpacesAndUpper(le.address_country);
	SELF := le;
END;
Export GWL_country := PROJECT(p_country,seq(LEFT));

//THE FOLLOWING SET OF FUNCTIONS WHERE ABSTRACTED from SAME-NAMED ATTRIBUTES USED IN THE "PATRIOTS" PRODUCTION PACKAGE
//Baddies

//key_baddids
Export GWL_Baddids :=     project(functions.Baddies,transform(layouts.KeyType_BadDids, self := left, self := []));

//key_patriotbaddies_with_name
Export GWL_Baddies:=      project(functions.Key_Baddids_with_name,Layouts.Layout_Baddids_with_name);

//key_globalwatchlists_entities
Export GWL_entities :=    DATASET([ ],layouts.LayoutEntity);

//key_globalwatchlists_addlinfo
Export GWL_Addlinfo :=    DATASET([ ],Layouts.LayoutAdditionalInfo);

//key_globalwatchlists_address
Export GWL_Address :=     DATASET([ ],Layouts.LayoutAddress);

//key_globalwatchlists_countries2
Export GWL_Countries2 :=  DATASET([ ],Layouts.LayoutCountry);

//key_globalwatchlists_country_aka
Export GWL_CountryName := DATASET([ ],Layouts.LayoutCountryName);

//key_globalwatchlists_country_index
Export GWL_CountryIndex :=DATASET([ ],Layouts.LayoutCountryIndex);

//key_globalwatchlists_id_numbers
Export GWL_IDNumbers :=   DATASET([ ],Layouts.IDLayout);

//key_globalwatchlists_name_index
Export GWL_NameIndex := DATASET([ ],Layouts.LayoutNameIndex);

//key_globalwatchlists_names
Export GWL_Names := DATASET([ ],Layouts.LayoutName);

//base Tokens
Export GWL_CountryTokens := DATASET([ ],Layouts.LayoutTokens);

Export GWL_NameTokens := DATASET([ ],Layouts.LayoutTokens);

EXPORT Patriot_delta_rid := dataset([], layouts.delta_rid);

end; 
	
	