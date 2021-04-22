/*--SOAP--
<message name="VRU_IdentityService">
	<part name="AlphaNumericInput" type="xsd:boolean" default="false" description=" Defines whether the input is from VRU (numeric only) or non-numeric"/>

	<part name="socs" type="xsd:string" description=" SSN (can be also used in non-numeric input)"/>
	<part name="yob" type="xsd:string" description=" 2-digit year of birth"/>
	<part name="housenum" type="xsd:string"/>
	<part name="hphone" type="xsd:string" description=" 10-digit home number (can be also used in non-numeric input)"/>
	<part name="zip5" type="xsd:string" description=" (5-digit)"/>
  <separator />

	<part name="first" type="xsd:string" /> 
	<part name="middle" type="xsd:string" />
	<part name="last" type="xsd:string" /> 
	<part name="suffix" type="xsd:string"/>
	<part name="addr" type="xsd:string" /> 
	<part name="city" type="xsd:string" /> 
	<part name="state" type="xsd:string" /> 
	<part name="zip" type="xsd:string" description=" (9-digit)"/>
	<part name="dob" type="xsd:string" description=" full date of birth"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <separator />
	
	<part name="seq" type="xsd:unsigned" />
	<part name="neutralIP" type="xsd:string" default="http://certstagingvip.hpcc.risk.regn.net:9876" description=" gateway to Neutral DID Service"/>
</message>
*/
/*--INFO-- Returns DID based on VRU input. */

EXPORT VRU_IdentityService := MACRO
IMPORT doxie, gong, mdr, header, drivers, FCRA, ut, Address, Didville, risk_indicators, header_quick, AutoStandardI, DeathV2_Services, did_add, Suppress, gateway;

deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());


boolean alpha_numeric := false : stored ('AlphaNumericInput');
boolean isVRU := NOT alpha_numeric;

// Numeric input
integer  seq_val 		 := 0  : stored ('seq');
string9  ssn_val     := '' : stored ('socs');
string2  yob_val     := '' : stored ('yob');
string5  hnumber_val := '' : stored ('housenum');
string10 phone_val   := '' : stored ('hphone');
string5  zip_val     := '' : stored ('zip5');

// Non-numeric input
string15 first_val   := '' : stored ('first');
string20 middle_val  := '' : stored ('middle');
string20 last_val    := '' : stored ('last');
string5  suffix_val  := '' : stored ('suffix');
string50 address_val := '' : stored ('addr');
string30 city_val    := '' : stored ('city');
string2  state_val   := '' : stored ('state');
string9  zip9_val    := '' : stored ('zip');
string8  dob_val     := '' : stored ('dob');

string neutralIP 	 	 := '' : stored ('neutralIP');

// common settings
boolean ln_branded  := false;
//this nonFCRA fed from FCRA service. It's assumed it's for FCRA so
//not implementing preGLB rules in this service.
boolean dppa_ok := true;
boolean glb_ok := true;


// validating input
ph_trim := TRIM (phone_val);
ph_trim_len := LENGTH (ph_trim);
ph_filtered_len := LENGTH (StringLib.StringFilterOUT (ph_trim, '0123456789'));
ph_zeros_len := LENGTH (StringLib.StringFilterOUT (ph_trim, '0'));
boolean phone_present := IF ((ph_zeros_len = 0) OR (ph_filtered_len <> 0) OR (ph_trim_len < 10), FALSE, TRUE);

ssn_trim := TRIM (ssn_val);
ssn_trim_len := LENGTH (ssn_trim);
ssn_filtered_len := LENGTH (StringLib.StringFilterOUT (ssn_trim, '0123456789'));
ssn_zeros_len := LENGTH (StringLib.StringFilterOUT (ssn_trim, '0'));
boolean ssn_present := IF ((ssn_zeros_len = 0) OR (ssn_filtered_len <> 0) OR (ssn_trim_len < 9), FALSE, TRUE);

boolean hnumber_present := hnumber_val != '';
boolean zip_present := zip_val != '';
boolean address_present := hnumber_present AND zip_present;
boolean invalid_input := NOT (ssn_present OR phone_present);

unsigned2 MAX_HEADER_DID := 500;
unsigned2 MAX_GONG_DID   := 1000;
unsigned2 MAX_HHID_DID   := 100;
unsigned2 MAX_PII_READ   := 1000; // number of correction person can make


// ==================================================================
// ===================== MAIN LAYOUTS ===============================
// ==================================================================
layout_input    := RiskWise.layouts_vru.layout_input;
layout_person   := RiskWise.layouts_vru.layout_person;
layout_output   := RiskWise.layouts_vru.layout_output;

// formal projection to encapsulate input parameters
layout_temp := RECORD
  unsigned1 x := 0; 
END;

layout_input GetInput (layout_temp L) := TRANSFORM
  SELF.socs     := ssn_val;
  SELF.yob      := yob_val;
  SELF.housenum := hnumber_val;
  SELF.hphone   := phone_val;
  SELF.zip5     := zip_val;

  SELF.first := first_val;
	SELF.middle:= middle_val;
  SELF.last  := last_val;
	SELF.suffix:= suffix_val;
  SELF.addr  := address_val;
  SELF.city  := city_val;
  SELF.state := state_val;
  SELF.zip   := zip9_val;
	SELF.dob   := dob_val;

  SELF.AlphaNumericInput := alpha_numeric;
	SELF.neutralIP := neutralIP;
END;

ds_input := PROJECT (DATASET ([{1}], {layout_temp}), GetInput (Left));



//////////////////////////////////////////////////////////////////////////
//       main routines: find dids by SSN; Phone; "Best" info
//////////////////////////////////////////////////////////////////////////

layout_did := RECORD
  unsigned6 did := 0;
END;	

layout_person GetPersonData (doxie.key_header R) := TRANSFORM
  SELF := R;
END;
layout_person GetPersonDataQuick (header_quick.key_DID R) := TRANSFORM
  SELF := R;
END;

//Get dids by social; duplicate dids might be returned here; no filtering when just "searching" for did
ds_DidsFromSSN := CHOOSEN (doxie.key_header_ssn (
                 keyed (ssn_val[1] = s1) AND
                 keyed (ssn_val[2] = s2) AND
                 keyed (ssn_val[3] = s3) AND
                 keyed (ssn_val[4] = s4) AND
                 keyed (ssn_val[5] = s5) AND
                 keyed (ssn_val[6] = s6) AND
                 keyed (ssn_val[7] = s7) AND
                 keyed (ssn_val[8] = s8) AND
                 keyed (ssn_val[9] = s9) AND
                 (did != 0)), MAX_HEADER_DID);

// Get all header records for given did(s); did != 0 here, but ds_dids might be empty
dids_ssn1 := JOIN (DEDUP (ds_DidsFromSSN, did, ALL), doxie.key_header,
                  keyed (Left.did = Right.s_did) AND Risk_Indicators.iid_constants.IsEligibleHeaderRec (Right, dppa_ok) AND left.did!=0,
                  GetPersonData (Right),
                  LIMIT (MAX_HEADER_DID, SKIP));

// Get all quick header records for given did(s); did != 0 here, but ds_dids might be empty
dids_ssn2 := JOIN (DEDUP (ds_DidsFromSSN, did, ALL), header_quick.key_DID,
                  keyed (Left.did = Right.did) AND left.did!=0,
                  GetPersonDataQuick( right ),
                  LIMIT (MAX_HEADER_DID, SKIP));

dids_ssn := sort(ungroup(dids_ssn1+dids_ssn2),did);

//Find Gong records by phone
ds_DidsFromGong := JOIN (DATASET ([{phone_val}], {string10 phone}), gong.Key_History_Phone,
                    Right.did != 0 AND
                    keyed (Left.phone[4..10] = Right.p7) AND
                    keyed (Left.phone[1..3] = Right.p3),
                    TRANSFORM (layout_did, SELF.did := Right.did),
                    LIMIT (MAX_GONG_DID, SKIP));

// get person's data from header
dids_phone1 := JOIN (DEDUP (ds_DidsFromGong, did, ALL), doxie.key_header,
                  keyed (Left.did = Right.s_did) AND Risk_Indicators.iid_constants.IsEligibleHeaderRec (Right, dppa_ok) AND left.did!=0,
                  GetPersonData (Right),
                  LEFT OUTER, LIMIT (MAX_HEADER_DID, SKIP));

// get person's data from quick header
dids_phone2 := JOIN (DEDUP (ds_DidsFromGong, did, ALL), header_quick.key_DID,
                  keyed (Left.did = Right.did) AND left.did!=0,
                  GetPersonDataQuick( right ),
                  LEFT OUTER, LIMIT (MAX_HEADER_DID, SKIP));

dids_phone := sort(ungroup(dids_phone1+dids_phone2),did);






csz := Address.Addr2FromComponents(city_val, state_val, zip9_val);	
clean_a := if(address_val='' or csz='', '', Address.CleanAddress182(address_val,csz));
cleaned := Address.CleanAddress182(address_val,csz);
clean_pr := clean_a[1..10]; // cleaned prim range
clean_pn := clean_a[13..40]; // cleaned prim name
clean_sr := clean_a[57..64]; // cleaned sec range
clean_z5 := if(clean_a[117..121]<>'', clean_a[117..121], zip9_val[1..5]);	// use the input zip if cass zip is empty
			
tscore(UNSIGNED1 i) := IF(i=255,0,i);


// Choosing "best" name and address;
layout_person ChooseAddress (layout_person L, layout_person R ) := TRANSFORM

  boolean latest := (L.dt_last_seen < R.dt_last_seen) OR (L.dt_last_seen < R.dt_first_seen);
  boolean sameAddress := (L.prim_range = R.prim_range AND L.prim_name = R.prim_name AND L.zip = R.zip);
  boolean takeAddress1 := latest AND (R.prim_range != '' AND R.prim_name != '' AND R.zip != '');

  leScore := risk_indicators.AddrScore.addressScore( clean_pr, clean_pn, clean_sr, l.prim_range, l.prim_name, l.sec_range );
  riScore := risk_indicators.AddrScore.addressScore( clean_pr, clean_pn, clean_sr, r.prim_range, r.prim_name, r.sec_range );

  takeAddress := (isVru and takeAddress1) // when doing a vru search, just use the 'latest' version of takeAddress
	or tscore(riScore) > tscore(leScore);   // or, when using by-address, take the right if it's a higher score but not 255


  SELF.hhid := IF (latest AND R.hhid!=0, R.hhid, L.hhid);
  SELF.dob := IF (R.dob != 0 AND (string) (R.dob[5..6]) != '00', R.dob, L.dob);
  SELF.phone := IF (latest AND R.phone != '', R.phone, L.phone);

  SELF.dt_first_seen := IF (takeAddress, R.dt_first_seen, L.dt_first_seen);
  SELF.dt_last_seen  := IF (takeAddress, R.dt_last_seen, L.dt_last_seen);
  
  // best name
  // see how both records do against the input
  lfScore := risk_indicators.FnameScore(first_val,l.fname); // left's fname score
  rfScore := risk_indicators.FnameScore(first_val,r.fname); // right's fname score
  llScore := risk_indicators.LnameScore(last_val,l.lname);  // left's lname score
  rlScore := risk_indicators.LnameScore(last_val,r.lname);  // right's lname score
  
  // on blank input, simply follow what takeAddress indicates; on valid input, use which ever one scores higher (but not 255)
  fnameRight := first_val='' and takeAddress or tscore(rfscore) > tscore(lfscore);
  lnameRight := last_val ='' and takeAddress or tscore(rlscore) > tscore(llscore);
  
  self.fname := if( fnameRight, r.fname, l.fname );
  self.lname := if( lnameRight, r.lname, l.lname );
  self.mname := map(
	 fnameright and  lnameright => r.mname, // if using both fname and lname from one side, use that mname
	~fnameright and ~lnameright => l.mname,

	// else, pick the longer one. another possibility is to stick strictly with the last name's record, or possibly
	// do some comparison against fname/lname and ensure we don't duplicate one of them.
	length(l.mname) > length(r.mname) => l.mname,
	r.mname
  );
	

  SELF.predir     := IF (takeAddress, R.predir,     L.predir);
  SELF.prim_name  := IF (takeAddress, R.prim_name,  L.prim_name);
  SELF.prim_range := IF (takeAddress, R.prim_range, L.prim_range);
  SELF.suffix     := IF (takeAddress, R.suffix,     L.suffix);
  SELF.postdir    := IF (takeAddress, R.postdir,    L.postdir);
  SELF.unit_desig := IF (takeAddress, R.unit_desig, L.unit_desig);
  SELF.sec_range  := IF (takeAddress, R.sec_range,  L.sec_range);
  SELF.city_name  := IF (takeAddress, R.city_name,  L.city_name);
  SELF.st         := IF (takeAddress, R.st,         L.st);
  SELF.zip        := IF (takeAddress, R.zip,        L.zip);
  SELF.zip4       := IF (takeAddress, R.zip4,       L.zip4);
  
  // score the SSNs and pick the best match
  LSSNScore := did_add.ssn_match_score( ssn_val, L.ssn );
  RSSNScore := did_add.ssn_match_score( ssn_val, R.ssn );
  self.ssn := if(tscore(LSSNScore) > tscore(RSSNScore), L.ssn, R.ssn );
  
  self.did := if( L.did=0, R.did, L.did );
END;


///////////////////////////////////////////////////////////////////////
// ====================================================================
// ====================== VRU-NUMERIC ALGORITHM  ======================
// ====================================================================
///////////////////////////////////////////////////////////////////////

// ---------------------------- I. BY SSN ----------------------------- 
  
//    A. Unless phone is present, or both housenum and zip are present;
ds_ssn_noparams := Risk_Indicators.iid_constants.GetVRUDataset (1, 'ssn: no phone or address');
		
//    B. Find dids by ssn, filter by zip/hnumber/yob, don't eliminate if dob is blank
boolean match_dob     := (yob_val     = '') OR (dids_ssn.dob = 0) OR (yob_val = ((string) dids_ssn.dob)[3..4]);
boolean match_hnumber := (hnumber_val = '') OR (hnumber_val = dids_ssn.prim_range);
boolean match_zip     := (zip_val     = '') OR (zip_val = dids_ssn.zip);

// filter by yob, housenum, zip, whichever is provided; match whole record (paranoic mode)
// ssn might be different here -- add it to filter; don't eliminate dob, if absent
// because we removed corrected_person
dids_ssn_filtered := dids_ssn ((ssn = ssn_val) AND match_dob AND  match_hnumber AND match_zip);


CNT_DidsBySSN := COUNT (DEDUP (dids_ssn_filtered, did, ALL));

//    C. If there were no dids found;
    ds_ssn_nodids := Risk_Indicators.iid_constants.GetVRUDataset (1, 'ssn: no dids found');
	
//    D. If there is a phone number, find the phone number in gong.
//        2.If there were no gong hits;
//            a) If single did found, and the customer supplied housenum and zip;
//                 (1) Verify social, housenum, and zip.
//                 (2) Use the did address as the verified address.
//                 (3) Use the (best name) from ADL as the verified name.
//                 (4) Set VRU code to 2, add FCRA data. (5)Stop.
            // note: there still could be multiple addresses here
            ds_nogong_SingleDid := Risk_Indicators.iid_constants.GetVRUDataset (2, 'ssn: phone: no gong; single did', Risk_Indicators.iid_constants.GetVerified (ssn_val, '', hnumber_val, '', zip_val), dids_ssn_filtered);

//            b) Otherwise (1)VRU=1 (2)Stop.
            ds_nogong := Risk_Indicators.iid_constants.GetVRUDataset (1, 'ssn: phone: no gong; multiple dids or no address');

        ds_ssn_phone_nogong := IF (address_present AND (CNT_DidsBySSN = 1), ds_nogong_SingleDid, ds_nogong);

//        3. Otherwise, restrict dids to those with the did appearing in one of the gong records;
//           if that produces no dids, then look for those with a household ID appearing in one
//           of the gong records; if that produces no dids, then look for those with a last name
//           appearing in one of the gong records.

//========================= join Gong and Header ===========================
// Implemented currently: if header-gong join by did fails (empty), try join by hhid.
// If this fails as well, try using relative hhid information, if fails -- use address.
        // join by DID
        ds_join_did := JOIN (dids_ssn_filtered, DEDUP (dids_phone, did, ALL),
                         Left.did = Right.did,
                         TRANSFORM (layout_person, SELF := Left),
                         LOOKUP);
        CNT_by_dids := COUNT (DEDUP (ds_join_did, did, ALL));
        
        // join by HHID
        ds_join_hhid := JOIN (dids_ssn_filtered, DEDUP (dids_phone (hhid != 0), hhid, ALL),
                         Left.hhid = Right.hhid,
                         TRANSFORM (layout_person, SELF := Left),
                         LOOKUP);
        CNT_by_hhids := COUNT (DEDUP (ds_join_hhid, did, ALL));


        // join by relatives HHID link
        layout_did_hhid := RECORD
          unsigned6 did;
          unsigned6 hhid;
        END; 
        layout_did_hhid getRelativesHHID (doxie.Key_Did_HDid R) := TRANSFORM
          SELF.did := R.did;
          SELF.hhid := R.hhid_relat;
        END;

        //get dids from Gong, get relatives' hhids for all those dids.
        ds_slim_gong := PROJECT (DEDUP (dids_phone, did, ALL), TRANSFORM (layout_did_hhid, SELF:= Left));
        ds_rel_hhid_gong := JOIN (ds_slim_gong, doxie.Key_Did_HDid,
                                  keyed (Left.did = Right.did),
                                  getRelativesHHID (Right),
                                  LEFT OUTER, LIMIT (MAX_HHID_DID, SKIP));

        //get dids from Header, get relatives' hhids for all those dids.
        ds_slim_header := PROJECT (DEDUP (dids_ssn, did, ALL), TRANSFORM (layout_did_hhid, SELF:= Left));
        ds_rel_hhid_header := JOIN (ds_slim_header, doxie.Key_Did_HDid,
                                    keyed (Left.did = Right.did),
                                    getRelativesHHID (Right),
                                    LEFT OUTER, LIMIT (MAX_HHID_DID, SKIP));
        
        // cross them, take those dids (header spawned), for which hhid match
        ds_did_hhid := JOIN (ds_rel_hhid_header, ds_rel_hhid_gong,
                             Left.hhid = Right.hhid,
                             TRANSFORM (layout_did_hhid, SELF := Left));

        //see if not empty
        ds_join_rel := JOIN (dids_ssn_filtered, DEDUP (ds_did_hhid, did, ALL),
                             Left.did = Right.did,
                             LOOKUP);
        CNT_by_rel_hhids := COUNT (DEDUP (ds_join_rel, did, ALL));

        phones_filtered := DEDUP (SORT (dids_phone (prim_range != '', prim_name != '', zip != ''), 
                                       prim_range, prim_name, zip, sec_range), 
                                  prim_range, prim_name, zip, sec_range);

        ds_join_address := JOIN (dids_ssn_filtered, phones_filtered,
                                 (Left.prim_range = Right.prim_range) AND
                                 (Left.prim_name = Right.prim_name) AND
                                 (Left.zip = Right.zip) AND
                                 (Left.sec_range = '' OR Right.sec_range = '' OR (Left.sec_range = Right.sec_range)),
                                 LOOKUP);

        // choose the non-empty one, if any
        ds_join := IF (CNT_by_dids = 0, 
                       IF (CNT_by_hhids = 0, IF (CNT_by_rel_hhids = 0, ds_join_address, ds_join_rel),
                       ds_join_hhid), ds_join_did);
        str_log := IF (CNT_by_dids = 0, 
                       IF (CNT_by_hhids = 0, IF (CNT_by_rel_hhids = 0, '(address)', '(rhhid)'),
                       '(hhid)'), '(did)');
//==========================================================================

        CNT_JoinDids := COUNT (DEDUP (ds_join, did, ALL));

//        4. If there are multiple dids or no dids; (1)VRU=1. (2)Stop.
        ds_join_multiple := Risk_Indicators.iid_constants.GetVRUDataset (1, 'ssn: phone: gong: multiple or no dids');

//        5. Otherwise, if there is a single did;
//            a) If either housenum or zip were present;
//               (1) Verify social and phone, housenum and zip. (2) (best name) from ADL
//               (3) If housenum and zip were both present  (a) Set VRU code to 3, add FCRA data.

                vcode := IF (CNT_by_dids = 0, IF (CNT_by_hhids = 0, IF (CNT_by_rel_hhids = 0, 2, 3), 3), 3);
                ds_all_address := Risk_Indicators.iid_constants.GetVRUDataset (vcode, 'ssn: phone: gong: ' + str_log + ': all match', Risk_Indicators.iid_constants.GetVerified (ssn_val, '', hnumber_val, phone_val, zip_val), ds_join);

//               (4) Otherwise; (a) Set VRU code to 2, add FCRA data.
                ds_part_address := Risk_Indicators.iid_constants.GetVRUDataset (2, 'ssn: phone: gong: ' + str_log + ': partial match', Risk_Indicators.iid_constants.GetVerified (ssn_val, '', hnumber_val, phone_val, zip_val), ds_join);
//               (5) Use the did address as the verified address. (6) Stop.
            ds_address := IF (address_present, ds_all_address, ds_part_address);

//           b) If both housenum and zip were missing;
//               (1) Verify social and phone.
//               (2) Use the (best name) from ADL as the verified name.
//               (3) Set VRU code to 1, add FCRA data. (4) Stop.
//?
            ds_no_address := Risk_Indicators.iid_constants.GetVRUDataset (1, 'by ssn: phone: gong: ' + str_log + ': no zip-home', Risk_Indicators.iid_constants.GetVerified (ssn_val, '', '', phone_val, ''), ds_join);
        ds_join_single := IF (zip_present OR hnumber_present, ds_address, ds_no_address);
    ds_ssn_phone_gong := IF (CNT_JoinDids = 1, ds_join_single, ds_join_multiple);

    CNT_DidsInGong := COUNT (DEDUP (dids_phone, did, ALL));
    ds_ssn_phone := IF (CNT_DidsInGong = 0, ds_ssn_phone_nogong, ds_ssn_phone_gong);

//    E. Otherwise, if phone not present;
//        1. If there were multiple dids found by social;
//            a) Set VRU code to 1. b) Stop.
//        2. If there was only a single did found by social;
//            a) Verify social, housenum, and address. //? housenum+zip?
//            b) Use the did address as the verified address.
//            c) Use the (best name) from ADL as the verified name.
//            d) Set VRU code to 2, add FCRA data. e) Stop.
    ds_ssn_nophone_single := Risk_Indicators.iid_constants.GetVRUDataset (2, 'ssn: no phone: single did', Risk_Indicators.iid_constants.GetVerified (ssn_val, '', hnumber_val, '', zip_val), dids_ssn_filtered);
    ds_ssn_nophone := IF (CNT_DidsBySSN = 1, ds_ssn_nophone_single, Risk_Indicators.iid_constants.GetVRUDataset (1, 'by ssn: no phone: multiple dids'));

    // choose among: C:no dids OR (D:dids+phone OR E:dids+nophone)
    ds_by_ssn := IF (CNT_DidsBySSN = 0, ds_ssn_nodids, IF (phone_present, ds_ssn_phone, ds_ssn_nophone));
	
ds_social := IF (phone_present OR address_present, ds_by_ssn, ds_ssn_noparams);


// ====================================================================
// ----------------------- II. BY PHONE ONLY  -----------------------
// ====================================================================
//    A. If the customer did not supply both housenum and zip; 1.Set VRU code to 1. 2.Stop.
    ds_phone_noaddress := Risk_Indicators.iid_constants.GetVRUDataset (1, 'phone: no house/zip');

//    B. Find phone number in gong;
//        1. If the gong record does not have a dob, then don%t eliminate it because the yob doesn%t match.
//        2. For each gong record, if the customer supplied housenum, then do not use that record unless the housenums agree.
//        3. For each gong record, if the customer supplied zip, then do not use that record unless the zips agree.
    ds_phone_filtered := dids_phone (((yob_val = '') OR (dob = 0) OR (yob_val = ((string) dob)[3..4])) AND
                                     ((hnumber_val = '') OR (hnumber_val = prim_range)) AND
                                     ((zip_val = '') OR (zip_val = zip)));

    CNT_DidsByPhone := COUNT (DEDUP (ds_phone_filtered, did, ALL));

//    C. If there was only a single gong hit;
//        1. Verify phone, housenum, and zip.
//        2. Use the address associated with the gong record as the verified address.
//        3. Set VRU code to 2, add FCRA data.
//        4. Stop.
    phone_single_did := Risk_Indicators.iid_constants.GetVRUDataset (2, 'phone: single did', Risk_Indicators.iid_constants.GetVerified ('', '', hnumber_val, phone_val, zip_val), ds_phone_filtered);
//    D. Otherwise, if there were multiple gong records; 1.VRU = 1. 2.Stop.
//    E. Finally, if there were no gong records; 1.VRU = 1 2.Stop.
    ds_phone_gong := IF (CNT_DidsByPhone = 1, phone_single_did, Risk_Indicators.iid_constants.GetVRUDataset (1, 'phone: multiple or no dids'));
    
ds_phone := IF (address_present, ds_phone_gong, ds_phone_noaddress);
verified_dids := IF (ssn_present, ds_social, ds_phone);


// because we removed corrected_person
ds_numeric_vru := IF (invalid_input, Risk_Indicators.iid_constants.GetVRUDataset (1, 'no ssn or phone'), verified_dids);

// Because of "unknown cluster" bug it is done here, otherwise it can be done in place
// get best address (will be processed only if person was identified uniquely)
dids_addressed := ROLLUP (dids_ssn_filtered, TRUE, ChooseAddress (Left, Right));
join_addressed := ROLLUP (ds_join, TRUE, ChooseAddress (Left, Right));
ds_ssn_best := IF (phone_present AND (CNT_DidsInGong != 0), join_addressed, dids_addressed);

//get best address for gong
ds_phone_best := ROLLUP (ds_phone_filtered, TRUE, ChooseAddress (Left, Right));



dids_numeric_pre := IF (ssn_present, ds_ssn_best, ds_phone_best);

gongByDID := if( dids_numeric_pre[1].did != 0,
	project( gong.Key_History_did( keyed (l_did = dids_numeric_pre[1].did ) ),
	transform( layout_person,
		self.phone := left.phone10,
		self.dt_first_seen:=(integer)left.dt_first_seen,
		self.dt_last_seen :=(integer)left.dt_last_seen,
		self := left,
		self := []
	)),
	dataset( [], layout_person )
);

// pick the better of our already rolled results and everything in gong by phone
dids_numeric := rollup( dids_ssn_filtered+dids_numeric_pre+gongByDid, true, chooseaddress(left,right) );



///////////////////////////////////////////////////////////////////////
// ====================================================================
// ======================= NON-NUMERIC INPUT  =========================
// ====================================================================
///////////////////////////////////////////////////////////////////////

clean_addr := Risk_Indicators.MOD_AddressClean.clean_addr(address_val, city_val, state_val, zip9_val[1..5]);


risk_indicators.layout_input SetInput () := TRANSFORM
  SELF.seq := 0;
	SELF.ssn := ssn_val;
	SELF.dob := dob_val;
	SELF.phone10 := phone_val;
	SELF.fname := first_val;  // stringlib.stringtouppercase (first_value);
	SELF.mname := middle_val;
	SELF.lname := last_val;   // stringlib.stringtouppercase (last_value);
	SELF.suffix := suffix_val;
	SELF.prim_range  := clean_addr [1..10];
	SELF.predir      := clean_addr[11..12];
	SELF.prim_name   := clean_addr[13..40];
	SELF.addr_suffix := clean_addr[41..44];
	SELF.postdir     := clean_addr[45..46];
	SELF.unit_desig  := clean_addr[47..56];
	SELF.sec_range   := clean_addr[57..65];
	SELF.p_city_name := clean_addr[90..114];
	SELF.st          := clean_addr[115..116];
	SELF.z5          := clean_addr[117..121];
	SELF.zip4        := clean_addr[122..125];
	SELF.historydate := 999999;
  SELF := [];   
END;
pre_iid := PROJECT(DATASET ([{0}], {integer int}), SetInput());

// set options
gateways := dataset([{'fcra',ds_input[1].neutralIP}],Gateway.Layouts.Config);
append_best := 0;	// dont append best
datarestriction := risk_indicators.iid_constants.default_DataRestriction;

// Call the neutral service
ds_didsNonNumeric := Risk_Indicators.Neutral_DID_Soapcall(pre_iid, gateways, 1/*bsversion*/, append_best, datarestriction, false); //default RetainInputDID to false


did_general_deduped := DEDUP (UNGROUP (ds_didsNonNumeric), did, ALL);
CNT_DidsGeneral := COUNT (did_general_deduped);

// Get did-score
did_score := did_general_deduped[1].score;


layout_person GetPersonDataNonNumeric (did_general_deduped L, doxie.key_header R) := TRANSFORM
	SELF.did := L.did;
  SELF := R;
END;
layout_person GetPersonDataQuickNonNumeric (did_general_deduped L, header_quick.key_DID R) := TRANSFORM
	SELF.did := L.did;
  SELF := R;
END;


//Get all header records for given did(s); here we have single did
did_general_header1 := JOIN (did_general_deduped, doxie.key_header,
                            keyed (Left.did = Right.s_did) AND Risk_Indicators.iid_constants.IsEligibleHeaderRec (Right, dppa_ok) AND left.did!=0,
                            GetPersonDataNonNumeric (Left, Right),
                            LEFT OUTER, LIMIT(MAX_HEADER_DID,SKIP));


//Get all quick header records for given did(s); here we have single did
did_general_header2 := JOIN (did_general_deduped, header_quick.key_DID,
                            keyed (Left.did = Right.did) AND left.did!=0,
							GetPersonDataQuickNonNumeric(left, right ),
							LEFT OUTER, LIMIT(MAX_HEADER_DID,SKIP));


did_general_header := sort(ungroup(did_general_header1+did_general_header2),did);

//get best address from header
dids_general := ROLLUP (did_general_header, TRUE, ChooseAddress (Left, Right/*, true*/));

ds_general_NoDid := Risk_Indicators.iid_constants.GetVRUDataset (1, 'non-numeric: no dids');
ds_general_MultipleDid := Risk_Indicators.iid_constants.GetVRUDataset (1, 'non-numeric: multiple dids');
string score_message := 'non-numeric: score=' + did_score;
ds_low_score  := Risk_Indicators.iid_constants.GetVRUDataset (2,  score_message, Risk_Indicators.iid_constants.GetVerified ('', '', '', '', ''), dids_general);
ds_high_score := Risk_Indicators.iid_constants.GetVRUDataset (3,  score_message, Risk_Indicators.iid_constants.GetVerified ('', '', '', '', ''), dids_general);

ds_general_vru := map(
	CNT_DidsGeneral  = 0 => ds_general_NoDid,
	CNT_DidsGeneral != 1 => ds_general_MultipleDid,

	// results with a single did:
	did_score >= 75 => ds_high_score,
	did_score >= 50  => ds_low_score,
	Risk_Indicators.iid_constants.GetVRUDataset(1, score_message)
);



//================= CORRECTIONS, INPUT, DIDS ==============================
// Here we have:
// ds_numeric_vru, dids_numeric -- vru code, message, verified info for numeric case
// ds_general_vru, dids_general --  non-numeric case

// choose numeric or non-numeric data
ds_verified := IF (IsVRU, ds_numeric_vru, ds_general_vru);	
dids_append := IF (IsVRU, dids_numeric, dids_general);



// because of corrected_person being moved, will be adjusted in fcra data service
dids_adjusted := dids_append;



layout_output SetOutput (layout_output L) := TRANSFORM
	self.seq := seq_val;
// Check if person is deceased (history isn't considered (right.dod8[1..6] <= history_date))
  isDeceased := EXISTS (doxie.key_death_masterV2_ssa_DID (l_did = dids_adjusted[1].did 		and not DeathV2_Services.functions.Restricted(src, glb_flag, glb_ok, deathparams)));
// add DIDs if vru-code is OK; special Numeric case: code=1, identified: address absent
  addID := /*~exists(corrected_person) and*/ // if corrected person is found using SSN override, don't used dids
			( (L.VRU_code != 1) OR (IsVRU AND ssn_present AND phone_present AND ~address_present AND (CNT_JoinDids = 1)) );
  
  SELF.VRU_code := IF (IsDeceased, 0, L.VRU_code);
  SELF.VRU_message := IF (IsDeceased, trim (L.VRU_message) + ' [deceased]', L.VRU_message);
  SELF.id := IF (addID, dids_adjusted, L.id);
  // SELF.CID := IF (EXISTS (corr_recs), corr_latest[1].UID, ''); this will be done in fcra data service
  SELF.input := ds_input;
  SELF := L;
END;
ds_result :=  PROJECT (ds_verified, SetOutput (Left));

OUTPUT(ds_result, NAMED('result'));	

ENDMACRO;
// RiskWise.VRU_IdentityService()