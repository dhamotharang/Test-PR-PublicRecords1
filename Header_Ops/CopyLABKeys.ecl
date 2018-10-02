/*
********COPY_LAB_KEYS****************
Util to copy LAB keys from ALPHA to BOCA or Vice Versa.
This can be used to copy incremental and full keys.
Version of the src keys can be harcoded or retrieved from the source DALI
Version of the dst keys can be hardcoded or retrieved from the source DALI
*/

import std, _control;

//aDali := '10.194.126.207:7070';//_control.IPAddress.adataland_dali;
aDali := _control.IPAddress.aprod_thor_dali; //10.194.112.105:7070
//bDali := '10.173.14.201:7070';//_control.IPAddress.dataland_dali;
bDali := _control.IPAddress.prod_thor_dali; //10.173.44.105:7070

aCLSTR := 'thor400_112_12';
bCLSTR := 'thor400_44'; //thor400_66

isIncremental := true; //Only 12 linking keys
CopyToBoca := true;
DALIIP := if(CopyToBoca, aDali, bDali);
CLSTR  := if(CopyToBoca, bCLSTR, aCLSTR);

srcVer := '20180801ib';    
dstVer := '20180801';

KeyPrefix := '~thor_data400::key::insuranceheader_xlink::';
KeyPrefixSrc := KeyPrefix + srcVer;
KeyPrefixDst := KeyPrefix + dstVer;

//********************SEGMENTATION KEYS***********************************************//
seqSegKeys := sequential(
    STD.File.Copy('~thor_data400::key::insuranceheader_segmentation::' + srcVer + '::did_ind' , CLSTR, '~thor_data400::key::insuranceheader_segmentation::' + dstVer + '::did_ind' , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    );

//********************LINKING KEYS***********************************************//
seqLinkingKeys := sequential(
    STD.File.Copy(KeyPrefixSrc + '::did::refs::address' , CLSTR, KeyPrefixDst + '::did::refs::address' , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixSrc + '::did::refs::dln'     , CLSTR, KeyPrefixDst + '::did::refs::dln'     , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixSrc + '::did::refs::dob'     , CLSTR, KeyPrefixDst + '::did::refs::dob'     , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixSrc + '::did::refs::dobf'    , CLSTR, KeyPrefixDst + '::did::refs::dobf'    , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixSrc + '::did::refs::lfz'     , CLSTR, KeyPrefixDst + '::did::refs::lfz'     , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixSrc + '::did::refs::name'    , CLSTR, KeyPrefixDst + '::did::refs::name'    , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixSrc + '::did::refs::ph'      , CLSTR, KeyPrefixDst + '::did::refs::ph'      , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixSrc + '::did::refs::relative', CLSTR, KeyPrefixDst + '::did::refs::relative', DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixSrc + '::did::refs::ssn'     , CLSTR, KeyPrefixDst + '::did::refs::ssn'     , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixSrc + '::did::refs::ssn4'    , CLSTR, KeyPrefixDst + '::did::refs::ssn4'    , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixSrc + '::did::refs::zip_pr'  , CLSTR, KeyPrefixDst + '::did::refs::zip_pr'  , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixSrc + '::did::refs::rid'     , CLSTR, KeyPrefixDst + '::did::refs::rid'     , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    );

//********************RELATIVE KEYS***********************************************//
srcRelVer := '20180801ib';    

seqRelativeKeys := sequential(
    if(CopyToBoca
       ,STD.File.Copy('~thor_data400::key::insurance_header::' + srcRelVer + '::relatives_v3' , CLSTR, '~thor_data400::key::header::' + dstVer + '::relatives_v3' , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true)
       ,STD.File.Copy('~thor_data400::key::header::' + srcRelVer + '::relatives_v3' , CLSTR, '~thor_data400::key::insurance_header::' + dstVer + '::relatives_v3' , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true)
      )
    );

//********************OTHER KEYS***********************************************//
srcOthVer := '20180801ib';    

KeyPrefixOth := '~thor_data400::key::insurance_header::';
KeyPrefixOthSrc := KeyPrefixOth + srcOthVer;
KeyPrefixOthDst := KeyPrefixOth + dstVer;

seqOtherKeys := sequential(
    STD.File.Copy(KeyPrefixOthSrc + '::did' , CLSTR, KeyPrefixOthDst + '::did' , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    STD.File.Copy(KeyPrefixOthSrc + '::dln' , CLSTR, KeyPrefixOthDst + '::dln' , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true);
    if(CopyToBoca
      ,STD.File.Copy('~thor_data400::key::insuranceheader::allpossiblessns::w20180707-175824', CLSTR, '~thor_data400::key::insuranceheader::' + dstVer + '::allpossiblessns' , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true)
      ,STD.File.Copy('~thor_data400::key::insuranceheader::' + dstVer + '::allpossiblessns', CLSTR, '~thor_data400::key::insuranceheader::allpossiblessns::' + dstVer , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true)
      ),
    if(CopyToBoca    
      ,STD.File.Copy('~thor_data400::key::insuranceheader::unique_addresses::expanded_20180705', CLSTR, '~thor_data400::key::header::' + dstVer + '::addr_unique_expanded' , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true)
      ,STD.File.Copy('~thor_data400::key::header::' + dstVer + '::addr_unique_expanded', CLSTR, '~thor_data400::key::insuranceheader::unique_addresses::expanded_' + dstVer , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true)
      ),
    if(CopyToBoca    
      ,STD.File.Copy('~thor_data400::key::insuranceheader::unique_addresses::expanded_fcra_20180707', CLSTR, '~thor_data400::key::fcra::header::' + dstVer + '::addr_unique_expanded' , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true)	
      ,STD.File.Copy('~thor_data400::key::fcra::header::' + dstVer + '::addr_unique_expanded', CLSTR, '~thor_data400::key::insuranceheader::unique_addresses::expanded_fcra_' + dstVer , DALIIP, replicate:=true, compress:=true, allowoverwrite:=true)
      )
    );

CopyIncremental := seqLinkingKeys;
CopyFull        := sequential(seqSegKeys, seqLinkingKeys, seqRelativeKeys, seqOtherKeys);

if(isIncremental, CopyIncremental, CopyFull);