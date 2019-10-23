//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','infutor_narb.BWR_Hygiene - Hygiene & Stats - SALT V3.4.3');
IMPORT infutor_narb,SALT34;
// First create an instantiated hygiene module
  infile := infutor_narb.In_infutor_narb;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := infutor_narb.Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL); // Breakdown of source distribution in clusters
  OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL); // Which sources contribute values to a cluster
  OUTPUT(SALT34.MAC_Character_Counts.EclRecord(p,'Layout_infutor_narb'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT34.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of seleid *******
  // seleid consistency module
  CM := infutor_narb.Fields.UIDConsistency(infutor_narb.In_infutor_narb);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.seleid_Unbased,NAMED('Unbasedseleid'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.rcid_TwoParents,NAMED('Twoparentsrcid'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT34.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,process_date,Examples),NAMED('process_dateBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,dotid,Examples),NAMED('dotidBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,dotscore,Examples),NAMED('dotscoreBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,dotweight,Examples),NAMED('dotweightBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,empid,Examples),NAMED('empidBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,empscore,Examples),NAMED('empscoreBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,empweight,Examples),NAMED('empweightBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,powid,Examples),NAMED('powidBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,powscore,Examples),NAMED('powscoreBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,powweight,Examples),NAMED('powweightBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,proxid,Examples),NAMED('proxidBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,proxscore,Examples),NAMED('proxscoreBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,proxweight,Examples),NAMED('proxweightBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,seleid,Examples),NAMED('seleidBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,selescore,Examples),NAMED('selescoreBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,seleweight,Examples),NAMED('seleweightBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,orgid,Examples),NAMED('orgidBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,orgscore,Examples),NAMED('orgscoreBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,orgweight,Examples),NAMED('orgweightBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,ultid,Examples),NAMED('ultidBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,ultscore,Examples),NAMED('ultscoreBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,ultweight,Examples),NAMED('ultweightBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,did,Examples),NAMED('didBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,did_score,Examples),NAMED('did_scoreBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,dt_first_seen,Examples),NAMED('dt_first_seenBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,dt_last_seen,Examples),NAMED('dt_last_seenBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,dt_vendor_first_reported,Examples),NAMED('dt_vendor_first_reportedBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,dt_vendor_last_reported,Examples),NAMED('dt_vendor_last_reportedBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,record_type,Examples),NAMED('record_typeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,pid,Examples),NAMED('pidBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,record_id,Examples),NAMED('record_idBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,ein,Examples),NAMED('einBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,busname,Examples),NAMED('busnameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,tradename,Examples),NAMED('tradenameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,house,Examples),NAMED('houseBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,predirection,Examples),NAMED('predirectionBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,street,Examples),NAMED('streetBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,strtype,Examples),NAMED('strtypeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,postdirection,Examples),NAMED('postdirectionBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,apttype,Examples),NAMED('apttypeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,aptnbr,Examples),NAMED('aptnbrBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,city,Examples),NAMED('cityBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,state,Examples),NAMED('stateBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,zip5,Examples),NAMED('zip5Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,ziplast4,Examples),NAMED('ziplast4Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,dpc,Examples),NAMED('dpcBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,carrier_route,Examples),NAMED('carrier_routeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,address_type_code,Examples),NAMED('address_type_codeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,dpv_code,Examples),NAMED('dpv_codeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,mailable,Examples),NAMED('mailableBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,county_code,Examples),NAMED('county_codeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,censustract,Examples),NAMED('censustractBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,censusblockgroup,Examples),NAMED('censusblockgroupBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,censusblock,Examples),NAMED('censusblockBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,congress_code,Examples),NAMED('congress_codeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,msacode,Examples),NAMED('msacodeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,timezonecode,Examples),NAMED('timezonecodeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,latitude,Examples),NAMED('latitudeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,longitude,Examples),NAMED('longitudeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,url,Examples),NAMED('urlBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,telephone,Examples),NAMED('telephoneBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,toll_free_number,Examples),NAMED('toll_free_numberBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,fax,Examples),NAMED('faxBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,sic1,Examples),NAMED('sic1Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,sic2,Examples),NAMED('sic2Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,sic3,Examples),NAMED('sic3Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,sic4,Examples),NAMED('sic4Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,sic5,Examples),NAMED('sic5Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,stdclass,Examples),NAMED('stdclassBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,heading1,Examples),NAMED('heading1Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,heading2,Examples),NAMED('heading2Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,heading3,Examples),NAMED('heading3Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,heading4,Examples),NAMED('heading4Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,heading5,Examples),NAMED('heading5Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,business_specialty,Examples),NAMED('business_specialtyBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,sales_code,Examples),NAMED('sales_codeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,employee_code,Examples),NAMED('employee_codeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,location_type,Examples),NAMED('location_typeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,parent_company,Examples),NAMED('parent_companyBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,parent_address,Examples),NAMED('parent_addressBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,parent_city,Examples),NAMED('parent_cityBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,parent_state,Examples),NAMED('parent_stateBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,parent_zip,Examples),NAMED('parent_zipBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,parent_phone,Examples),NAMED('parent_phoneBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,stock_symbol,Examples),NAMED('stock_symbolBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,stock_exchange,Examples),NAMED('stock_exchangeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,public,Examples),NAMED('publicBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,number_of_pcs,Examples),NAMED('number_of_pcsBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,square_footage,Examples),NAMED('square_footageBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,business_type,Examples),NAMED('business_typeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,incorporation_state,Examples),NAMED('incorporation_stateBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,minority,Examples),NAMED('minorityBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,woman,Examples),NAMED('womanBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,government,Examples),NAMED('governmentBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,small,Examples),NAMED('smallBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,home_office,Examples),NAMED('home_officeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,soho,Examples),NAMED('sohoBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,franchise,Examples),NAMED('franchiseBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,phoneable,Examples),NAMED('phoneableBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,prefix,Examples),NAMED('prefixBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,first_name,Examples),NAMED('first_nameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,middle_name,Examples),NAMED('middle_nameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,surname,Examples),NAMED('surnameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,suffix,Examples),NAMED('suffixBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,birth_year,Examples),NAMED('birth_yearBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,ethnicity,Examples),NAMED('ethnicityBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,gender,Examples),NAMED('genderBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,email,Examples),NAMED('emailBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,contact_title,Examples),NAMED('contact_titleBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,year_started,Examples),NAMED('year_startedBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,date_added,Examples),NAMED('date_addedBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,validationdate,Examples),NAMED('validationdateBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,internal1,Examples),NAMED('internal1Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,dacd,Examples),NAMED('dacdBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,normcompany_type,Examples),NAMED('normcompany_typeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,normcompany_name,Examples),NAMED('normcompany_nameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,normcompany_street,Examples),NAMED('normcompany_streetBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,normcompany_city,Examples),NAMED('normcompany_cityBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,normcompany_state,Examples),NAMED('normcompany_stateBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,normcompany_zip,Examples),NAMED('normcompany_zipBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,normcompany_phone,Examples),NAMED('normcompany_phoneBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,clean_company_name,Examples),NAMED('clean_company_nameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,title,Examples),NAMED('titleBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,fname,Examples),NAMED('fnameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,mname,Examples),NAMED('mnameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,lname,Examples),NAMED('lnameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,name_suffix,Examples),NAMED('name_suffixBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,name_score,Examples),NAMED('name_scoreBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,prim_range,Examples),NAMED('prim_rangeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,predir,Examples),NAMED('predirBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,prim_name,Examples),NAMED('prim_nameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,addr_suffix,Examples),NAMED('addr_suffixBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,postdir,Examples),NAMED('postdirBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,unit_desig,Examples),NAMED('unit_desigBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,sec_range,Examples),NAMED('sec_rangeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,p_city_name,Examples),NAMED('p_city_nameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,v_city_name,Examples),NAMED('v_city_nameBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,st,Examples),NAMED('stBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,zip,Examples),NAMED('zipBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,zip4,Examples),NAMED('zip4Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,cart,Examples),NAMED('cartBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,cr_sort_sz,Examples),NAMED('cr_sort_szBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,lot,Examples),NAMED('lotBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,lot_order,Examples),NAMED('lot_orderBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,dbpc,Examples),NAMED('dbpcBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,chk_digit,Examples),NAMED('chk_digitBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,rec_type,Examples),NAMED('rec_typeBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,fips_state,Examples),NAMED('fips_stateBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,fips_county,Examples),NAMED('fips_countyBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,geo_lat,Examples),NAMED('geo_latBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,geo_long,Examples),NAMED('geo_longBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,msa,Examples),NAMED('msaBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,geo_blk,Examples),NAMED('geo_blkBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,geo_match,Examples),NAMED('geo_matchBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,err_stat,Examples),NAMED('err_statBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,clean_phone,Examples),NAMED('clean_phoneBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,raw_aid,Examples),NAMED('raw_aidBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,ace_aid,Examples),NAMED('ace_aidBysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,prep_address_line1,Examples),NAMED('prep_address_line1Bysource'));
  //  OUTPUT(SALT34.MAC_CrossTab(infile,source,prep_address_line_last,Examples),NAMED('prep_address_line_lastBysource'));
