EXPORT svcCrosswalk() := macro

	import BIPV2;
	import Doxie;

	inputDs := dataset([], BIPV2_Crosswalk.IdLinkLayouts.crosswalkInput) : stored('id_link_input');

	boolean useInputLexid := false : stored('use_input_lexid');
	boolean useInpuBipId := false : stored('use_input_bip_id');
	unsigned consumer_score_threshold := 75 : stored('consumer_score_threshold');
	unsigned bip_weight_threshold := 0 : stored('bip_weight_threshold');
	unsigned bip_score_threshold := 75 : stored('bip_score_threshold');
	boolean onlyTopContact := false : stored('only_top_contact');
	boolean onlyTopBusiness := false : stored('only_top_business');
	boolean allowNoLexid := false : stored('allow_no_lexid');
	string fetchLevel := BIPV2.IDconstants.Fetch_Level_SeleID : stored('fetch_level');
	set of string consumerSegmentation := ALL : stored('consumer_segmentation');
	set of string businessSegmentation := ALL : stored('business_segmentation');
	set of string sourcesToInclude := ALL : stored('sources_to_include');
	boolean isMarketing := false : stored('is_marketing');

modaccess := module(Doxie.iDataAccess)
	EXPORT unsigned1 intended_use := if(isMarketing, 1, 0);
end;

cw := bipv2_crosswalk.BusinessLinks(inputDs
	,useInputLexid := useInputLexid
	,useInputBipId := useInpuBipId
	,bipWeight := bip_weight_threshold
	,consumerScore := consumer_score_threshold
	,bipScore := bip_score_threshold
	,onlyTopContact := onlyTopContact
	,onlyTopBusiness := onlyTopBusiness
	,allowNoLexid := allowNoLexid
	,fetchLevel := fetchLevel
	,consumerSegmentation := consumerSegmentation
	,businessSegmentation := businessSegmentation
	,sourcesToInclude := sourcesToInclude
	,mod_access := modAccess
);


bApp := cw.bipAppend();
lApp := cw.consumerAppend();

bF := cw.businessFetch();
bL := cw.businessLookup();
bB := cw.businessBest;
b := cw.businesses();
cF := cw.contactFetch;
cL := cw.contactLookup;
cB := cw.contactBest;
cH := cw.contactHHID;
c := cw.contacts();
s := cw.summary;
v := cw.verifyInputs();

parallel(
output(bApp, named('bip_append'));
output(lApp, named('consumer_append'));
output(bF, named('business_key_fetch'));
output(bL, named('business_lookup'));
output(sort(bB, ultid, orgid, seleid, proxid), named('business_best'));
output(sort(b, request_id, did, ultid), named('businesses'));
output(cF, named('contact_key_fetch'));
output(cL, named('contact_lookup'));
output(cB, named('contact_best'));
output(cH, named('contact_hhid'));
output(sort(c, request_id, ultid, orgid, seleid, proxid, did), named('contacts'));
output(s, named('summary'));
output(v, named('verify_inputs'));
output(sort(cw.inputBusinessBest(), uniqueid, seleid, proxid), named('inputBusBest'));
);

endmacro;