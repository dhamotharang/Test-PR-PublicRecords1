/*
Normalizing by Name, Company name and address. The normalized file is used for did, bdid and ssn append.
This file is used for building autokeys
*/
import property, ut, header_slimsort, DID_Add, Business_Header_SS, Business_header;

foreclosureIn := property.File_Foreclosure_In;

// NORMALIZE: The result of it will be used for DIDing and for building autokeys as well

normalizeDIDLayout := record
	string20 name_first;
	string20 name_middle;
	string20 name_last;
	string5  name_suffix;
	string60  name_Company;
	string10	site_prim_range;
	string2		site_predir;
	string28	site_prim_name;
	string4		site_addr_suffix;
	string2		site_postdir;
	string10	site_unit_desig;
	string8		site_sec_range;
	string25	site_p_city_name;
	string25	site_v_city_name;
	string2		site_st;
	string5		site_zip;
	string4		site_zip4;
	unsigned1 name_indicator;
	unsigned6 did := 0;
	unsigned1 did_score := 0;
	string9 ssn := '';
	unsigned6 bdid := 0;
	unsigned1 bdid_score := 0;
	recordof(foreclosureIn);
end;

// by name (autokeys also will use normalization by company name)
normalizeDIDLayout normalizeRecords (foreclosureIn l, unsigned1 nameCounter) := transform
	self.name_first := choose(nameCounter,l.name1_first,l.name2_first,l.name3_first,l.name4_first);
	self.name_middle := choose(nameCounter,l.name1_middle,l.name2_middle,l.name3_middle,l.name4_middle);
	self.name_last := choose(nameCounter,l.name1_last,l.name2_last,l.name3_last,l.name4_last);
	self.name_suffix := choose(nameCounter,l.name1_suffix,l.name2_suffix,l.name3_suffix,l.name4_suffix);
	self.name_Company := choose(nameCounter,l.name1_company,l.name2_company,l.name3_company,l.name4_company);
	self.site_prim_range :=l.situs1_prim_range;
	self.site_predir :=l.situs1_predir;
	self.site_prim_name :=l.situs1_prim_name;
	self.site_addr_suffix:=l.situs1_addr_suffix;
	self.site_postdir:=l.situs1_postdir;
	self.site_unit_desig:=l.situs1_unit_desig;
	self.site_sec_range:=l.situs1_sec_range;
	self.site_p_city_name:=l.situs1_p_city_name;
	self.site_v_city_name:=l.situs1_v_city_name;
	self.site_st:=l.situs1_st;
	self.site_zip:=l.situs1_zip;
	self.site_zip4:=l.situs1_zip4;

	self.name_indicator := nameCounter;
	self := l;
end;
ds_name_normalized := normalize (foreclosureIn,4,normalizeRecords(left,counter));


// by address
normalizeDIDLayout normalize_Addr_Records(normalizeDIDLayout l, unsigned1 c) := transform
		self.site_prim_range :=choose(c,l.site_prim_range,l.situs2_prim_range);
		self.site_predir :=choose(c,l.site_predir,l.situs2_predir);
		self.site_prim_name :=choose(c,l.site_prim_name,l.situs2_prim_name);
		self.site_addr_suffix:=choose(c,l.site_addr_suffix,l.situs2_addr_suffix);
		self.site_postdir:=choose(c,l.site_postdir,l.situs2_postdir);
		self.site_unit_desig:=choose(c,l.site_unit_desig,l.situs2_unit_desig);
		self.site_sec_range:=choose(c,l.site_sec_range,l.situs2_sec_range);
		self.site_p_city_name:=choose(c,l.site_p_city_name,l.situs2_p_city_name);
		self.site_v_city_name:=choose(c,l.site_v_city_name,l.situs2_v_city_name);
		self.site_st:=choose(c,l.site_st,l.situs2_st);
		self.site_zip:=choose(c,l.site_zip,l.situs2_zip);
		self.site_zip4:=choose(c,l.site_zip4,l.situs2_zip4);
		self := l;
end;
ds_normalized := normalize(ds_name_normalized, if((left.situs2_prim_name='' and left.situs2_zip=''),1,2),normalize_Addr_Records(left,counter));

src_rec := record
header_slimsort.Layout_Source;
normalizeDIDLayout;
end;

DID_Add.Mac_Set_Source_Code (ds_normalized, src_rec, 'FR', foreclosureBaseNormalized_src)

matchset := ['A','Z'];

did_add.MAC_Match_Flex(foreclosureBaseNormalized_src,matchset,
											 foo,foo,name_first,name_middle,name_last,name_suffix,
											 site_prim_range,site_prim_name,site_sec_range,site_zip,site_st,foo,
											 did,src_rec,
											 true,did_score,75,foreclosureDID_src,true,src);
//remove src
foreclosureDID := project(foreclosureDID_src, transform(normalizeDIDLayout, self := left));

matchset_bdid := ['A'];
Business_Header_SS.MAC_Match_Flex(foreclosureDID,matchset_bdid,
								 name_company,
								 site_prim_range,site_prim_name,site_zip,
								 site_sec_range,site_st,
								 foo,foo,
								 bdid,normalizeDIDLayout,
								 true,bdid_score,foreclosureDID_BDID);

DID_Add.MAC_Add_SSN_By_DID(foreclosureDID_BDID,did,ssn,appendSSN);

appendSSNSortDist	:=	SORT(DISTRIBUTE(appendSSN, HASH(foreclosure_id)), RECORD, LOCAL);

EXPORT foreclosure_normalized := dedup(appendSSNSortDist,RECORD,LOCAL)  : persist('~thor_data400::persist::file_foreclosure_normalized'); // use persist here, if needed
