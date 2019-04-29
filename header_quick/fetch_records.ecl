import doxie,autokeyb,census_data,doxie_raw,AutoKeyI,AutoStandardI;

export fetch_records(
	Dataset(doxie.layout_references_hh) indids = dataset([], doxie.layout_references_hh),
	doxie.IDataAccess mod_access,
	boolean include_dailies = false, 
	boolean allow_wildcard = false,
	set of STRING1 autokey_skipset=[],
	boolean ApplyBpsFilter = false) := 
FUNCTION

// this seems to be needed only to pull did_value:
doxie.MAC_Header_Field_Declare()

//***** BY AUTOKEY ******
t := header_quick.str_AutokeyName;
ds := dataset([], header_Quick.layout_Autokey);
skipset := ['B','-'] + autokey_skipset;
tempmod := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
	export string autokey_keyname_root := t;
	export string typestr := 'HEAD';
	export set of string1 get_skip_set := skipset;
	export boolean workHard := false;
	export boolean noFail := true;
	export boolean useAllLookups := false;
end;
ak := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

autokeyb.mac_get_payload(ak,t,ds,byak,did,0, 'HEAD',integer8 FakeID)

//common format
comm_ak := project(byak(not ApplyBpsFilter or doxie.bpssearch_filter.rec_OK(
																					ssn,lname,fname,mname,
																					prim_range,prim_name,suffix,
																					sec_range,city_name,zip,phone,'',dob)),
									 transform(header_quick.layout_records, self.did := 0, self := left));

// add county name
census_data.MAC_Fips2County_Keyed(comm_ak, st, county, county_name, wsrc);


// need to preserve header dids from autokey (any id that isn't 'fake'), in the event that the only 
// hit on the search criteria came from autokey
Doxie.layout_references_hh fix(ak l) := TRANSFORM
	SELF.did := l.id;
	SELF := l;
END;
ak_hdr_dids := project(ak(~autokeyb.isFakeID(id,'HEAD')),fix(LEFT));

//***** BY DID ******
d := indids + if((unsigned8)did_value<>0, Fetch_HeaderQuick_Did((unsigned8)did_value));

bothIds := dedup(sort(d+ak_hdr_dids,did),did);
byd := doxie_Raw.QuickHeader_raw(bothIds, mod_access,false,applyBpsFilter);
return if(header_quick.stored_Allow, wsrc + byd);

END;


