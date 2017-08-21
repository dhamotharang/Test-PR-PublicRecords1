import	_control, FDIC_sod_annual, Address;

export Proc_Build_FDIC_SOD_Annual_Keys(string pIndexVersion) := function

rKeyFDICSodAnnual__autokey__addressb2 := RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyFDICSodAnnual__autokey__citystnameb2 := RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyFDICSodAnnual__autokey__nameb2 := RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyFDICSodAnnual__autokey__namewords2 := RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

layout_virtual := RECORD
   unsigned8 fdiccertificatenumber;
   string72 institutionname;
   unsigned8 officenumber;
   real8 branchuniqueidnumber;
   string72 addressbranch;
   string72 addressinstitution;
   real8 asset;
   boolean branchdesignation;
   string2 institutionclass;
   boolean mainofficedesignation;
   unsigned8 sodregionbooknumber;
   string3 cencodes;
   boolean branchdomicileindicator;
   unsigned8 branchservicetype;
   string2 officetype;
   string6 reportdateyrmo;
   string8 reportdateyrmody;
   unsigned8 institutioncorebasestatarea;
   string120 branchmetrodivisionname;
   string120 institutionmetrodivisionname;
   unsigned8 institutionmetrostatarea;
   string120 institutionmetrostatareaname;
   string120 branchmetrostatareaname;
   unsigned8 branchmetrostatarea;
   unsigned8 branchcorebasedstatarea;
   string40 branchcorebasedstatareaname;
   string120 institutioncorebasedareaname;
   unsigned8 cencodeconsolestimatednondep;
   string28 charteragentname;
   string5 charteragentcode;
   string30 institutionhqcity;
   string30 branchuspscity;
   string30 institutionhquspscity;
   string30 branchreportedcity;
   string25 bankholdingcompanycity;
   unsigned8 classnumber;
   unsigned8 fipscmsacodemainoffice;
   unsigned8 fipscmsacodebranch;
   string60 fipscmsanamebranch;
   string60 fipscmsanamemainoffice;
   string56 fipscountryname;
   string56 fipscountrynamebranch;
   string36 countynamebranch;
   string60 countynameinstitution;
   unsigned8 countynumberinstitution;
   unsigned8 countynumberbranch;
   unsigned8 institutioncombinedstatisticalarea;
   unsigned8 branchcombinedstatisticalarea;
   string120 branchcombinedstatareaname;
   string120 institutioncombinedstatareaname;
   boolean newbrickandmortar;
   real8 totaldomesticdeposits;
   real8 totaldomesticdepforinstituions;
   real8 branchdepositsinthousands;
   boolean institutionmetrodivision;
   boolean branchmetrodivision;
   unsigned8 otsdocketnumber;
   real8 escrowaccounttfr;
   unsigned8 fdicregionnumber;
   string13 fdicregionname;
   unsigned8 frbdistrictnumber;
   boolean fedcharter;
   string13 federalreservedistrictname;
   boolean callreport;
   boolean callreportbranch;
   boolean tfrreport;
   boolean tfrreportbranch;
   boolean multibankholdingcompany;
   boolean nobankholdingcompany;
   boolean onebankholdingcompany;
   boolean internationalbankingactentity;
   string5 primaryinsurancefund;
   boolean insuredinstitution;
   real8 demanddepininsuredbranches;
   real8 timeandsavedepositininsuredbranches;
   boolean insuredcommercialbank;
   boolean insuredfdic;
   boolean insuredsavingsinstitution;
   boolean institutionmetrodivisions;
   boolean branchmetrodivisions;
   boolean institutionmicrodivisions;
   boolean branchmicrodivisions;
   unsigned8 msacodeinstitution;
   unsigned8 msacodebranch;
   string60 msanamebranch;
   string60 msanameinstitution;
   string72 branchname;
   string72 fullinstitutionname;
   string95 regulatoryhighholdnamebhc;
   unsigned8 institutionnewenglandcntymetroareas;
   unsigned8 branchnewenglandcntymetroareas;
   string30 branchnewenglandcntymetroareasname;
   string30 institutionnewenglandcntymetroareasname;
   boolean oakar;
   unsigned8 occdistrictnumber;
   string18 occregionname;
   boolean usbranchofforeigninstitution;
   string25 otsregionname;
   unsigned8 otsnumber;
   unsigned8 placecodenumber;
   string10 qbpregionname;
   unsigned8 qbpregionnumber;
   string10 datasourceidentifier;
   string5 primaryfederalregulator;
   string13 branchfdicregionname;
   unsigned8 branchfdicregionnumber;
   string20 reportdate;
   unsigned8 frbidnumberbandholdingco;
   unsigned8 frbidnumber;
   boolean sasser;
   string22 industryspecializationdescr;
   unsigned8 industryspecializationgroup;
   string2 statecode;
   string2 branchstatecode;
   string2 bhcstatecode;
   boolean statecharter;
   unsigned8 institutionstateandcountynumber;
   unsigned8 branchstateandcountynumber;
   string40 institutionhqstatename;
   string40 branchstatename;
   unsigned8 institutionstatenumber;
   unsigned8 branchstatenumber;
   boolean assets100mto300m;
   boolean assetsover10b;
   boolean assets1bto3b;
   boolean assetsunder25m;
   boolean assets25mto50m;
   boolean assets300mto500m;
   boolean assets3bto10b;
   boolean assets500mto1b;
   boolean assets50mto100m;
   unsigned8 assetsizeindicatior;
   boolean unitbank;
   boolean domesticinstitution;
   string5 institutionzipcode;
   string5 branchzipcode;
  END;

layout_clean182_fips := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 zip;
   string4 zip4;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dbpc;
   string1 chk_digit;
   string2 rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  END;

rKeyFDICSodAnnual__autokey__payload := RECORD
  unsigned6 fakeid;
  unsigned6 did;
  unsigned1 did_score;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned6 bid;
  unsigned1 bid_score;
  unsigned8 unique_id;
  layout_virtual rawfields;
  string8 reportdatenew;
  unsigned8 branchuniqueidinteger;
  Layout_Clean182_fips formattedinstitutionaddr;
  Layout_Clean182_fips formattedbranchaddr;
  string1 recordtype;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned8 institutionaid;
  unsigned8 institutionaceaid;
  unsigned8 branchaid;
  unsigned8 branchaceaid;
 END;

rKeyFDICSodAnnual__autokey__stnameb2:= RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyFDICSodAnnual__autokey__zipb2 := RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyFDICSodAnnual__bdid	:= RECORD
	unsigned6 bdid;
  unsigned6 did;
  unsigned1 did_score;
  unsigned1 bdid_score;
  unsigned6 bid;
  unsigned1 bid_score;
  unsigned8 unique_id;
  layout_virtual rawfields;
  string8 reportdatenew;
  unsigned8 branchuniqueidinteger;
  Layout_Clean182_fips formattedinstitutionaddr;
  Layout_Clean182_fips formattedbranchaddr;
  string1 recordtype;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned8 institutionaid;
  unsigned8 institutionaceaid;
  unsigned8 branchaid;
  unsigned8 branchaceaid;
 END;


ds_addressb2		:=dataset([],rKeyFDICSodAnnual__autokey__addressb2);
ds_citystnameb2	:=dataset([],rKeyFDICSodAnnual__autokey__citystnameb2);
ds_nameb2				:=dataset([],rKeyFDICSodAnnual__autokey__nameb2);
ds_namewords2		:=dataset([],rKeyFDICSodAnnual__autokey__namewords2);
ds_payload			:=dataset([],rKeyFDICSodAnnual__autokey__payload);
ds_stnameb2			:=dataset([],rKeyFDICSodAnnual__autokey__stnameb2);
ds_zipb2				:=dataset([],rKeyFDICSodAnnual__autokey__zipb2);
ds_bdid					:=dataset([],rKeyFDICSodAnnual__bdid);	
ds_cert					:=dataset([],rKeyFDICSodAnnual__bdid);
ds_ots					:=dataset([],rKeyFDICSodAnnual__bdid);

addressb2_IN		:=index(ds_addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {ds_addressb2}, '~prte::key::fdic_sod_annual::'+pIndexVersion+'::autokey::addressb2');
citystnameb2_IN	:=index(ds_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {ds_citystnameb2}, '~prte::key::fdic_sod_annual::'+pIndexVersion+'::autokey::citystnameb2');
nameb2_IN				:=index(ds_nameb2, {cname_indic,cname_sec,bdid}, {ds_nameb2}, '~prte::key::fdic_sod_annual::'+pIndexVersion+'::autokey::nameb2');
namewords2_IN		:=index(ds_namewords2, {word,state,seq,bdid}, {ds_namewords2}, '~prte::key::fdic_sod_annual::'+pIndexVersion+'::autokey::namewords2');
payload_IN			:=index(ds_payload, {fakeid}, {ds_payload}, '~prte::key::fdic_sod_annual::'+pIndexVersion+'::autokey::payload');
stnameb2_IN			:=index(ds_stnameb2, {st,cname_indic,cname_sec,bdid}, {ds_stnameb2}, '~prte::key::fdic_sod_annual::'+pIndexVersion+'::autokey::stnameb2');
zipb2_IN				:=index(ds_zipb2, {zip,cname_indic,cname_sec,bdid}, {ds_zipb2}, '~prte::key::fdic_sod_annual::'+pIndexVersion+'::autokey::zipb2');
bdid_IN				  :=index(ds_bdid, {bdid}, {ds_bdid}, '~prte::key::fdic_sod_annual::' + pIndexVersion + '::bdid');	
cert_IN				  :=index(ds_cert, {rawfields.FDICCertificateNumber}, {ds_cert}, '~prte::key::fdic_sod_annual::' + pIndexVersion + '::cert');	
ots_IN				  :=index(ds_ots, {rawfields.OTSNumber}, {ds_ots}, '~prte::key::fdic_sod_annual::' + pIndexVersion + '::ots');	
															 
return	sequential(
										parallel(												
																build(addressb2_IN, update),																															
																build(citystnameb2_IN, update),														
																build(nameb2_IN	, update),															
																build(stnameb2_IN, update),																											
																build(zipb2_IN, update),																
																build(payload_IN, update),
																build(namewords2_IN, update),
																build(bdid_IN, update),
																build(cert_IN, update),
																build(ots_IN, update)
															 ),
								
								PRTE.UpdateVersion('FDICSodKeys',												//	Package name
																pIndexVersion,											//	Package version
																_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																 'B',																//	B = Boca, A = Alpharetta
																 'N',																//	N = Non-FCRA, F = FCRA
																 'N'																//	N = Do not also include boolean, Y = Include boolean, too
																	)
										 );
end;
