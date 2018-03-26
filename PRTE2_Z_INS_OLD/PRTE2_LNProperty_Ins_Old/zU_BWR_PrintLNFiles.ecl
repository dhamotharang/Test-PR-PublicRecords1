//* PrintLNFiles //*
IMPORT PRTE2, PRTE_CSV;
#WORKUNIT ('name', 'printLNfiles');
//*OUTPUT(CHOOSEN(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__payload,200));
//*OUTPUT(CHOOSEN(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__address,200));
//*OUTPUT(CHOOSEN(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__addressb2,200));

//*OUTPUT(COUNT(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__payload),NAMED('cntpayl'));
//*OUTPUT(COUNT(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__address),NAMED('cntaddr'));
OUTPUT(COUNT(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__addressb2),NAMED('cntadb2'));
OUTPUT(COUNT(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__nameb2),NAMED('cntnamb2'));
//*OUTPUT(CHOOSEN(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__assessor_fid,500),NAMED('asfid'));
//*OUTPUT(CHOOSEN(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__assessor_fid(ln_fares_id = 'DA0149602742'),500),NAMED('DA0149'));
//*OUTPUT(CHOOSEN(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__ssn2,500),NAMED('SSN'));
//*OUTPUT(choosen(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_fid(ln_fares_id = 'DA0149602742'),500),NAMED('DEED'));

//*Dab2 := PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__addressb2;
//*OUTPUT(COUNT(Dab2),NAMED('cntDab2'));

/*
DPAR := PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_parcelnum;
OUTPUT(choosen(DPAR(ln_fares_id = 'DD0000000354'),100),NAMED('DPARCEL'));

DFID := PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_fid;
OUTPUT(choosen(DFID(ln_fares_id = 'DD0000000354'),100),NAMED('DFID'));

APAR := PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__assessor_parcelnum;
OUTPUT(choosen(APAR(ln_fares_id = 'DD0000000354'),100),NAMED('APARCEL'));

AFID := PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__assessor_fid;
OUTPUT(choosen(AFID(ln_fares_id = 'DD0000000354'),100),NAMED('AFID'));

*/

/*
FDID := PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_Fid;
OUTPUT (choosen(FDID(ln_fares_id = 'DA0000006872'),100),NAMED('FDIDrec'));
OUTPUT(choosen(FDID,250),NAMED('FDID250'));	


BDID := PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__search_bdid;
OUTPUT (choosen(BDID(ln_fares_id = 'OA0041634156'),100),NAMED('BDID500'));	
*/

//*OUTPUT(CHOOSEN(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__citystname,100));
//*OUTPUT(CHOOSEN(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__ssn2,100),NAMED('SSN2'));
//*OUTPUT(CHOOSEN(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__assessor_fid,500),NAMED('asfid'));
/*	rKeyLNPropertyV2__autokey__address	:=
	    		RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string6 dph_lname;
  string20 lname;
  string20 pfname;
  string20 fname;
  unsigned8 states;
  unsigned4 lname1;
  unsigned4 lname2;
  unsigned4 lname3;
  unsigned4 lookups;
  unsigned6 did;
 END;*/


//*ADS := DATASET('~prte::key::ln_propertyv2::20121128::autokey::address',rKeyLNPropertyV2__autokey__address,thor);
//*OUTPUT (choosen(ADS(DID[1..6] = '888809'),500));



//*testds := DATASET('~thor40_241_7::prct_pii::in::custtest::LNPROPERTY4',PRTE2.Layouts.batch_in_LNProperty,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(62768)));
//*OUTPUT(choosen(testds,50)); 
//*OUTPUT(COUNT(testds),NAMED('cntds'));

//*Testds1  := DATASET('~prte::ct::ln_propertyv2::join::newexpanded',PRTE2.layouts.layout_ln_propertyv2_expanded_payload,FLAT);
//*D1 := dedup(project(testds1,PRTE2.layouts.layout_ln_propertyv2_expanded_payload),record,all);
//*OUTPUT(COUNT(D1),NAMED('cntD1'));

//*TESTds3 := DATASET('~prte::ct::ln_propertyv2::join::expanded',PRTE2.layouts.layout_ln_propertyv2_expanded_payload,FLAT);
//*D3 := dedup(


//*testds2 := DATASET('~prte::ct::ln_propertyv2::join::ALLexpanded',PRTE2.layouts.layout_ln_propertyv2_expanded_payload,FLAT);
//*OUTPUT (choosen(testds2(ln_fares_id = 'DD0000000354'),50));
//*OUTPUT(CHOOSEN(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__namewords2,100),NAMED('Words'));

//*OUTPUT(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__address,,'~prte::ct::ln_propertyv2::old::address',OVERWRITE);

//*OUTPUT(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__addressb2,,'~prte::ct::ln_propertyv2::old::addressb2',OVERWRITE);


//*OUTPUT(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__deed_fid,,'~prte::ct::ln_propertyv2::old::deed_fid',OVERWRITE);

//*OUTPUT(PRTE_CSV.LN_Propertyv2.dthor_data400__key__ln_propertyv2__autokey__name,,'~prte::ct::ln_propertyv2::old::name',OVERWRITE);