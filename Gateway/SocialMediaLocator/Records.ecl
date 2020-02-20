IMPORT Doxie, dx_gateway, iesp, Gateway, Royalty;

EXPORT Records(
  iesp.socialmedialocatorsearch.t_SocialMediaLocatorSearchRequest rec_in,
  Doxie.IDataAccess mod_access,
  DATASET(Gateway.layouts.config) gws)
:= FUNCTION

  gesp_req := Gateway.SocialMediaLocator.Functions.create_gesp_req(rec_in);
  cleaned_req := dx_gateway.parser_socialmedialocator.cleanRequest(gesp_req, mod_access);

  is_suppressed := ~EXISTS(cleaned_req);
  recs := IF(~is_suppressed, Gateway.SoapCall_SocialMediaLocator(gesp_req[1], gws));

  // Transform G-ESP response to T-ESP response, add requestInfo echo if suppressed.
  req_info := IF(is_suppressed, rec_in.SearchBy.Name);
  tesp_resp := Gateway.SocialMediaLocator.Functions.create_tesp_response(recs[1].Response, req_info);
  royalties := IF(~is_suppressed, Royalty.SocialMediaLocator.GetRoyalties(recs[1].Response));

  // Bundle royalties and T-ESP response.
  bundle_layout := RECORD
    DATASET(iesp.socialmedialocatorsearch.t_SocialMediaLocatorSearchResponse) recs;
    DATASET(Royalty.Layouts.Royalty) royalties;
  END;

  bundle_layout bundle_xform() := TRANSFORM
    SELF.recs := tesp_resp;
    SELF.royalties := royalties;
  END;

  //DEBUG OUTPUT---------------------------------------------
  // OUTPUT(gws, NAMED('gws'));
  // OUTPUT(cleaned_req, NAMED('cleaned_req'));
  // OUTPUT(is_suppressed, NAMED('is_suppressed'));
  // OUTPUT(recs, NAMED('recs'));
  // OUTPUT(req_info, NAMED('req_info'));
  // OUTPUT(tesp_resp, NAMED('tesp_resp'));
  // OUTPUT(royalties, NAMED('royalties'));
  //END DEBUG OUTPUT-----------------------------------------

  RETURN DATASET([bundle_xform()]);
END;
