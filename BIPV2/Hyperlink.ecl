// Hyperlink functions.  Pass in the variables, and these fucntions construct
//   the HTML necessary to be used as a hyperlink.  The sRoxieIP parameter
//   defaults to Dataland Cert, but can be overridden by whichever roxie is
//   desired.
// NOTE:  In order to have the field be hyperlink-able in ECL output, the field
//   name itself MUST have "__html" (that's two underscores) as its suffix.  So
//   a field with a hyperlink to the person header might be named "did__html".
// Examples:
//   SELF.proxid__html:=BIPV2.Hyperlink().BIPHeader(LEFT.proxid);
//   SELF.compare__html:=BIPV2.Hyperlink().ProxidCompare(LEFT.Results[1].proxid,LEFT.Results[2].proxid);
EXPORT Hyperlink(STRING sRoxieIP='10.173.235.23:8002',STRING sCluster='roxie_130',BOOLEAN bNewWindow=TRUE):=MODULE

  EXPORT BIPHeader(UNSIGNED iProxid):='<a href="http://'+sRoxieIP+'/WsEcl/xslt/query/'+sCluster+'/bizlinkfull.biz_header_service_2?proxid='+iProxid+'"'+IF(bNewWindow,' target="_blank"','')+'>'+iProxid+'</a>';

  EXPORT BIPSearch(STRING sSearchParameters):='<a href="http://'+sRoxieIP+'/WsEcl/xslt/query/'+sCluster+'/bizlinkfull.biz_header_service_2?'+sSearchParameters+'"'+IF(bNewWindow,' target="_blank"','')+'>Search</a>';

  EXPORT CorpReport(STRING sCorpKey):='<a href="http://'+sRoxieIP+'/WsEcl/xslt/query/'+sCluster+'/corp2_services.corpsreportservice?corp_key='+sCorpKey+'"'+IF(bNewWindow,' target="_blank"','')+'>'+sCorpKey+'</a>';

  EXPORT Hierarchy(UNSIGNED iProxid):='<a href="http://'+sRoxieIP+'/WsEcl/xslt/query/'+sCluster+'/bipv2_hrchy.showservice?proxid='+iProxid+'"'+IF(bNewWindow,' target="_blank"','')+'>'+iProxid+'</a>';
  
  EXPORT LGIDCompare(UNSIGNED iLgid01,UNSIGNED iLgid02):='<a href="http://'+sRoxieIP+'/WsEcl/xslt/query/'+sCluster+'/bipv2_lgid3.lgid3compareservice?lgidone='+iLgid01+'&lgidtwo='+iLgid02+'"'+IF(bNewWindow,' target="_blank"','')+'>LGID3 Compare: '+iLgid01+'/'+iLgid02+'</a>';
  
  EXPORT PersonHeader(UNSIGNED iDid):='<a href="http://'+sRoxieIP+'/WsEcl/xslt/query/'+sCluster+'/doxie.headerfilesearchservice?did='+iDid+'"'+IF(bNewWindow,' target="_blank"','')+'>'+iDid+'</a>';
  
  EXPORT ProxidCompare(UNSIGNED iProxid01,UNSIGNED iProxid02):='<a href="http://'+sRoxieIP+'/WsEcl/xslt/query/'+sCluster+'/bipv2_proxid.proxidcompareservice?proxidone='+iProxid01+'&proxidtwo='+iProxid02+'"'+IF(bNewWindow,' target="_blank"','')+'>Proxid Compare: '+iProxid01+'/'+iProxid02+'</a>';
  
  // svcBatch search?
  //   bizlinkfull.svcbatch
  
  // name cleaner
  //   http://10.173.3.1:8002/      bipv2_company_names.servicecompanyclean
  
  // TopBusiness Search
  //   topbusiness_services.businesssearch
  
  // address.addresscleaningservice
  
  EXPORT GoogleMaps(STRING sAddress):='<a href="https://www.google.com/maps/place/'+REGEXREPLACE(' ',sAddress,'+')+'"'+IF(bNewWindow,' target="_blank"','')+'>Google Map</a>';
  
  // Calls to source keys?
  //   corp2_services.corpsreportservice
  //   dnb_feinv2_services.dnbfeinreportservice
  //   bankruptcyv2_services.bankruptcyreportservice
  
  // Person Header Service?  By Search?
  //   doxie.headerfilesearchservice
  
END;
