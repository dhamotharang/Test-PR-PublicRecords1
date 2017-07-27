//NOTE: kept older keys in this build file cause I think they are still used in comp report.

import ut,VersionControl,RoxieKeyBuild;
export Make_Keys(string filedate) :=
function

	VersionControl.macBuildNewLogicalKeyWithName(domains.Key_Whois_Bdid		,'~thor_data400::key::whois::' + filedate + '::bdid'		,BuildBdidKey		);
	VersionControl.macBuildNewLogicalKeyWithName(domains.Key_Whois_Did		,'~thor_data400::key::whois::' + filedate + '::did'			,BuildDidKey		);	
	VersionControl.macBuildNewLogicalKeyWithName(domains.key_whois_domain	,'~thor_data400::key::whois::' + filedate + '::domain'	,BuildDomainKey	);	
	
	// used these 4 lines for new roxie keys for moxie to roxie migration
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(domains.key_domain	,'~thor_data400::key::internetservices::domain', '~thor_data400::key::internetservices::' + filedate + '::domain'	,BuildRoxieDomainKey	);	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(domains.key_did	,'~thor_data400::key::internetservices::did', '~thor_data400::key::internetservices::' + filedate + '::did'	,BuildRoxiedidKey	);	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(domains.key_bdid	,'~thor_data400::key::internetservices::bdid', '~thor_data400::key::internetservices::' + filedate + '::bdid'	,BuildRoxiebdidKey	);	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(domains.key_id	,'~thor_data400::key::internetservices::id','~thor_data400::key::internetservices::' + filedate + '::id'	,BuildRoxieIDKey	);	
	
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::whois_bdid'	,'~thor_data400::key::whois::' + filedate + '::bdid'	,MoveBdid2Built 	);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::whois_did'		,'~thor_data400::key::whois::' + filedate + '::did'		,MoveDid2Built 		);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::whois_domain','~thor_data400::key::whois::' + filedate + '::domain',MoveDomain2Built );
	
	// used these 4 lines for new roxie keys for moxie to roxie migration
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::internetservices::@version@::bdid'	,'~thor_data400::key::internetservices::'+filedate+'::bdid'	,MoveRoxieBdid2Built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::internetservices::@version@::did'		,'~thor_data400::key::internetservices::'+filedate+'::did',MoveRoxieDid2Built);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::internetservices::@version@::domain','~thor_data400::key::internetservices::'+filedate+'::domain',MoveRoxieDomain2Built );
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::internetservices::@version@::id','~thor_data400::key::internetservices::'+filedate+'::id',MoveRoxieID2Built ); 
		 
	ut.MAC_SK_Move_v2('~thor_data400::key::whois_did'		,'Q',Movedid2QA 		,2);
	ut.mac_sk_move_v2('~thor_data400::key::whois_bdid'	,'Q',MoveBDid2QA 		,2);
	ut.mac_sk_move_v2('~thor_Data400::key::whois_domain','Q',MoveDomain2QA 	,2);
	
	// used these 4 lines for new roxie keys for moxie to roxie migration	                                           	
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_Data400::key::internetservices::@version@::did','Q',MoveRoxiedid2QA,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_Data400::key::internetservices::@version@::bdid','Q',MoveRoxiebdid2QA,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_Data400::key::internetservices::@version@::domain','Q',MoveRoxiedomain2QA,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_Data400::key::internetservices::@version@::id','Q',MoveRoxieid2QA,2);
	
	return sequential(
		parallel(
			 BuildBdidKey		
			,BuildDidKey		
			,BuildDomainKey	
			,BuildRoxieIDKey
			,BuildRoxieDIDKey
			,BuildRoxieBDIDKey
			,BuildRoxieDomainKey
		)  
		,
		parallel(
			 MoveBdid2Built 	
			,MoveDid2Built 		
			,MoveDomain2Built 
			,MoveRoxieBdid2Built 	
			,MoveRoxieDid2Built 		
			,MoveRoxieDomain2Built 
			,MoveRoxieID2Built
		)  
		,parallel(
			 Movedid2QA 	
			,MoveBDid2QA 	
			,MoveDomain2QA
			,MoveRoxiedid2QA 	
			,MoveRoxieBDid2QA 	
			,MoveRoxieDomain2QA
			,MoveRoxieID2QA
		)  
	);


end;