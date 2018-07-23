/*--SOAP--
<message name = 'INSTANTID_BATCH'>
	<part name = 'batch_in'    type = 'tns:XmlDataSet' cols="70" rows="25"/>
	<part name = 'HaveBDIDS'   type = 'xsd:boolean'/>
	<part name = 'GLBPurpose'  type = 'xsd:byte'/>
	<part name = 'DPPAPurpose' type = 'xsd:byte'/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="PoBoxCompliance" type="xsd:boolean"/>			
	<part name="OfacOnly" type="xsd:boolean"/>
	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>	
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	<part name="IncludeFraudScores" type="xsd:boolean"/>
	<part name="ModelName" type="xsd:string"/>
	<part name="IncludeTargusE3220" type="xsd:boolean"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="IncludeMSoverride" type="xsd:boolean"/>
	<part name="IncludeDLVerification" type="xsd:boolean"/>
	<part name="AttributesVersionRequest" type="xsd:string"/>	
	<part name="Include_ALL_Watchlist" type="xsd:boolean"/>
	<part name="Include_ALLV4_Watchlist" type="xsd:boolean"/>
	<part name="Include_BES_Watchlist" type="xsd:boolean"/>
	<part name="Include_CFTC_Watchlist" type="xsd:boolean"/>
	<part name="Include_DTC_Watchlist" type="xsd:boolean"/>
	<part name="Include_EUDT_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBI_Watchlist" type="xsd:boolean"/>
	<part name="Include_FCEN_Watchlist" type="xsd:boolean"/>
	<part name="Include_FAR_Watchlist" type="xsd:boolean"/>
	<part name="Include_IMW_Watchlist" type="xsd:boolean"/>
	<part name="Include_OFAC_Watchlist" type="xsd:boolean"/>
	<part name="Include_OCC_Watchlist" type="xsd:boolean"/>
	<part name="Include_OSFI_Watchlist" type="xsd:boolean"/>
	<part name="Include_PEP_Watchlist" type="xsd:boolean"/>
	<part name="Include_SDT_Watchlist" type="xsd:boolean"/>
	<part name="Include_BIS_Watchlist" type="xsd:boolean"/>
	<part name="Include_UNNT_Watchlist" type="xsd:boolean"/>
	<part name="Include_WBIF_Watchlist" type="xsd:boolean"/>
	<part name="Include_ADFA_Watchlist" type="xsd:boolean"/>
	<part name="Include_FAJC_Watchlist" type="xsd:boolean"/>
	<part name="Include_FATF_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIH_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIS_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIT_Watchlist" type="xsd:boolean"/>
	<part name="Include_FBIW_Watchlist" type="xsd:boolean"/>
	<part name="Include_HKMA_Watchlist" type="xsd:boolean"/>
	<part name="Include_MASI_Watchlist" type="xsd:boolean"/>
	<part name="Include_OFFC_Watchlist" type="xsd:boolean"/>
	<part name="Include_PMLC_Watchlist" type="xsd:boolean"/>
	<part name="Include_PMLJ_Watchlist" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This is the Business InstantID Batch Service */
/*--HELP-- 
<pre>
&lt;batch_in&gt;
  &lt;Row&gt;
    &lt;BDID&gt;&lt;/BDID&gt;
    &lt;Score&gt;&lt;/Score&gt;
    &lt;AcctNo&gt;&lt;/AcctNo&gt;
    &lt;Name_Company&gt;&lt;/Name_Company&gt;
    &lt;Alt_Company_Name&gt;&lt;/Alt_Company_Name&gt;
    &lt;Street_Addr&gt;&lt;/Street_Addr&gt;
    &lt;P_City_Name&gt;&lt;/P_City_Name&gt;
    &lt;St&gt;&lt;/St&gt;
    &lt;Z5&gt;&lt;/Z5&gt;
    &lt;Zip4&gt;&lt;/Zip4&gt;
    &lt;Prim_Range&gt;&lt;/Prim_Range&gt;
    &lt;PreDir&gt;&lt;/PreDir&gt;
    &lt;Prim_Name&gt;&lt;/Prim_Name&gt;
    &lt;Addr_Suffix&gt;&lt;/Addr_Suffix&gt;
    &lt;PostDir&gt;&lt;/PostDir&gt;
    &lt;Sec_Range&gt;&lt;/Sec_Range&gt;
    &lt;Lat&gt;&lt;/Lat&gt;
    &lt;Long&gt;&lt;/Long&gt;
    &lt;Addr_Type&gt;&lt;/Addr_Type&gt;
    &lt;Addr_Status&gt;&lt;/Addr_Status&gt;
    &lt;FEIN&gt;&lt;/FEIN&gt;
    &lt;PhoneNo&gt;&lt;/PhoneNo&gt;
    &lt;IP_Addr&gt;&lt;/IP_Addr&gt;
    &lt;unParsedFullName&gt;&lt;/unParsedFullName&gt;
    &lt;Name_First&gt;&lt;/Name_First&gt;
    &lt;Name_Middle&gt;&lt;/Name_Middle&gt;
    &lt;Name_Last&gt;&lt;/Name_Last&gt;
    &lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
    &lt;Name_Last_Alt&gt;&lt;/Name_Last_Alt&gt;
    &lt;Street_Addr2&gt;&lt;/Street_Addr2&gt;
    &lt;P_City_Name_2&gt;&lt;/P_City_Name_2&gt;
    &lt;St_2&gt;&lt;/St_2&gt;
    &lt;Z5_2&gt;&lt;/Z5_2&gt;
    &lt;Zip4_2&gt;&lt;/Zip4_2&gt;
    &lt;Prim_Range_2&gt;&lt;/Prim_Range_2&gt;
    &lt;PreDir_2&gt;&lt;/PreDir_2&gt;
    &lt;Prim_Name_2&gt;&lt;/Prim_Name_2&gt;
    &lt;Addr_Suffix_2&gt;&lt;/Addr_Suffix_2&gt;
    &lt;PostDir_2&gt;&lt;/PostDir_2&gt;
    &lt;Unit_Desig_2&gt;&lt;/Unit_Desig_2&gt;
    &lt;Sec_Range_2&gt;&lt;/Sec_Range_2&gt;
    &lt;SSN&gt;&lt;/SSN&gt;
    &lt;DOB&gt;&lt;/DOB&gt;
    &lt;Phone_2&gt;&lt;/Phone_2&gt;
    &lt;Rep_Age&gt;&lt;/Rep_Age&gt;
    &lt;DL_Number&gt;&lt;/DL_Number&gt;
    &lt;DL_State&gt;&lt;/DL_State&gt;
    &lt;Rep_Email&gt;&lt;/Rep_Email&gt;
    &lt;HistorydateYYYYMM&gt;&lt;/HistorydateYYYYMM&gt;
  &lt;/Row&gt;
&lt;/batch_in&gt;
</pre>
*/

export InstantID_Batch_Service() := macro
import doxie, address, AutoStandardI, OFAC_XG5;

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',0);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

df   := dataset([],business_risk.Layout_Input_Moxie_2) : stored('batch_in',few);
hb   := false 	: stored('HaveBDIDS');
unsigned1 glb := 0 : stored('GLBPurpose');
dppa := 0 	: stored('DPPAPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean IsPOBoxCompliant := false : STORED('PoBoxCompliance');
boolean ofac_only := true : stored('OfacOnly');
boolean ExcludeWatchLists := false : stored('ExcludeWatchLists');
unsigned1 OFAC_version :=1 :STORED('OFACversion');
boolean Include_Additional_watchlists := FALSE: stored('IncludeAdditionalWatchlists');
boolean Include_Ofac := FALSE: stored('IncludeOfac');
real Global_WatchList_Threshold_temp := 0 :stored('GlobalWatchlistThreshold');
	global_watchlist_threshold := Map( 
																		OFAC_version >= 4	and global_watchlist_threshold_temp = 0			=> OFAC_XG5.Constants.DEF_THRESHOLD_KeyBank_REAL,
																		OFAC_version < 4  and global_watchlist_threshold_temp = 0 		=> OFAC_XG5.Constants.DEF_THRESHOLD_REAL,
																		global_watchlist_threshold_temp);
boolean IncludeFraudScores := false :stored('IncludeFraudScores');
boolean isUtility := false;
boolean ln_branded_value := false;
string4 tribcode := '';
boolean from_IT1O:=false;
boolean suppressNearDups := false;
boolean require2ele := false;
boolean fromBiid := false;
boolean isFCRA := false;
boolean use_dob_filter := FALSE :stored('UseDobFilter');
integer2 dob_radius := 2 :stored('DobRadius');
string  model_name_value := '' : stored('ModelName');
model_name := StringLib.StringToLowerCase(model_name_value);
boolean IncludeTargus3220 := false : stored('IncludeTargusE3220');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

nugen := true;

dob_radius_use := if(use_dob_filter,dob_radius,-1);

gateways_in := Gateway.Configuration.Get();
STRING AttributesVersionRequest := '' : STORED('AttributesVersionRequest');
IncludeRepAttributes := StringLib.StringToUpperCase(AttributesVersionRequest) IN ['BIIDATTRIBUTESV1'];
boolean Include_ALL_Watchlist:= false : stored('Include_ALL_Watchlist');
boolean Include_ALLV4_Watchlist:= false : stored('Include_ALLV4_Watchlist');
boolean Include_BES_Watchlist:= false : stored('Include_BES_Watchlist');
boolean Include_CFTC_Watchlist:= false : stored('Include_CFTC_Watchlist');
boolean Include_DTC_Watchlist:= false : stored('Include_DTC_Watchlist');
boolean Include_EUDT_Watchlist:= false : stored('Include_EUDT_Watchlist');
boolean Include_FBI_Watchlist:= false : stored('Include_FBI_Watchlist');
boolean Include_FCEN_Watchlist:= false : stored('Include_FCEN_Watchlist');
boolean Include_FAR_Watchlist:= false : stored('Include_FAR_Watchlist');
boolean Include_IMW_Watchlist:= false : stored('Include_IMW_Watchlist');
boolean Include_OFAC_Watchlist:= false : stored('Include_OFAC_Watchlist');
boolean Include_OCC_Watchlist:= false : stored('Include_OCC_Watchlist');
boolean Include_OSFI_Watchlist:= false : stored('Include_OSFI_Watchlist');
boolean Include_PEP_Watchlist:= false : stored('Include_PEP_Watchlist');
boolean Include_SDT_Watchlist:= false : stored('Include_SDT_Watchlist');
boolean Include_BIS_Watchlist:= false : stored('Include_BIS_Watchlist');
boolean Include_UNNT_Watchlist:= false : stored('Include_UNNT_Watchlist');
boolean Include_WBIF_Watchlist:= false : stored('Include_WBIF_Watchlist');

boolean Include_ADFA_Watchlist:= false : stored('Include_ADFA_Watchlist');
boolean Include_FAJC_Watchlist:= false : stored('Include_FAJC_Watchlist');
boolean Include_FATF_Watchlist:= false : stored('Include_FATF_Watchlist');
boolean Include_FBIH_Watchlist:= false : stored('Include_FBIH_Watchlist');
boolean Include_FBIS_Watchlist:= false : stored('Include_FBIS_Watchlist');
boolean Include_FBIT_Watchlist:= false : stored('Include_FBIT_Watchlist');
boolean Include_FBIW_Watchlist:= false : stored('Include_FBIW_Watchlist');
boolean Include_HKMA_Watchlist:= false : stored('Include_HKMA_Watchlist');
boolean Include_MASI_Watchlist:= false : stored('Include_MASI_Watchlist');
boolean Include_OFFC_Watchlist:= false : stored('Include_OFFC_Watchlist');
boolean Include_PMLC_Watchlist:= false : stored('Include_PMLC_Watchlist');
boolean Include_PMLJ_Watchlist:= false : stored('Include_PMLJ_Watchlist');

dWL := dataset([], iesp.share.t_StringArrayItem) +
if(Include_ALL_Watchlist, dataset([{patriot.constants.wlALL}], iesp.share.t_StringArrayItem)) +
if(Include_ALLV4_Watchlist, dataset([{patriot.constants.wlALLV4}], iesp.share.t_StringArrayItem)) +
if(Include_BES_Watchlist, dataset([{patriot.constants.wlBES}], iesp.share.t_StringArrayItem)) +
if(Include_CFTC_Watchlist, dataset([{patriot.constants.wlCFTC}], iesp.share.t_StringArrayItem)) +
if(Include_DTC_Watchlist, dataset([{patriot.constants.wlDTC}], iesp.share.t_StringArrayItem)) +
if(Include_EUDT_Watchlist, dataset([{patriot.constants.wlEUDT}], iesp.share.t_StringArrayItem)) +
if(Include_FBI_Watchlist, dataset([{patriot.constants.wlFBI}], iesp.share.t_StringArrayItem)) +
if(Include_FCEN_Watchlist, dataset([{patriot.constants.wlFCEN}], iesp.share.t_StringArrayItem)) +
if(Include_FAR_Watchlist, dataset([{patriot.constants.wlFAR}], iesp.share.t_StringArrayItem)) +
if(Include_IMW_Watchlist, dataset([{patriot.constants.wlIMW}], iesp.share.t_StringArrayItem)) +
if(Include_OFAC_Watchlist, dataset([{patriot.constants.wlOFAC}], iesp.share.t_StringArrayItem)) +
if(Include_OCC_Watchlist, dataset([{patriot.constants.wlOCC}], iesp.share.t_StringArrayItem)) +
if(Include_OSFI_Watchlist, dataset([{patriot.constants.wlOSFI}], iesp.share.t_StringArrayItem)) +
if(Include_PEP_Watchlist, dataset([{patriot.constants.wlPEP}], iesp.share.t_StringArrayItem)) +
if(Include_SDT_Watchlist, dataset([{patriot.constants.wlSDT}], iesp.share.t_StringArrayItem)) +
if(Include_BIS_Watchlist, dataset([{patriot.constants.wlBIS}], iesp.share.t_StringArrayItem)) +
if(Include_UNNT_Watchlist, dataset([{patriot.constants.wlUNNT}], iesp.share.t_StringArrayItem)) +
if(Include_WBIF_Watchlist, dataset([{patriot.constants.wlWBIF}], iesp.share.t_StringArrayItem))+
if(Include_ADFA_Watchlist, dataset([{patriot.constants.wlADFA}], iesp.share.t_StringArrayItem)) +
if(Include_FAJC_Watchlist, dataset([{patriot.constants.wlFAJC}], iesp.share.t_StringArrayItem)) +
if(Include_FATF_Watchlist, dataset([{patriot.constants.wlFATF}], iesp.share.t_StringArrayItem)) +
if(Include_FBIH_Watchlist, dataset([{patriot.constants.wlFBIH}], iesp.share.t_StringArrayItem)) +
if(Include_FBIS_Watchlist, dataset([{patriot.constants.wlFBIS}], iesp.share.t_StringArrayItem)) +
if(Include_FBIT_Watchlist, dataset([{patriot.constants.wlFBIT}], iesp.share.t_StringArrayItem)) +
if(Include_FBIW_Watchlist, dataset([{patriot.constants.wlFBIW}], iesp.share.t_StringArrayItem)) +
if(Include_HKMA_Watchlist, dataset([{patriot.constants.wlHKMA}], iesp.share.t_StringArrayItem)) +
if(Include_MASI_Watchlist, dataset([{patriot.constants.wlMASI}], iesp.share.t_StringArrayItem)) +
if(Include_OFFC_Watchlist, dataset([{patriot.constants.wlOFFC}], iesp.share.t_StringArrayItem)) +
if(Include_PMLC_Watchlist, dataset([{patriot.constants.wlPMLC}], iesp.share.t_StringArrayItem)) +
if(Include_PMLJ_Watchlist, dataset([{patriot.constants.wlPMLJ}], iesp.share.t_StringArrayItem));

watchlists_request := dWL(value<>'');
boolean IncludeMSoverride := false : stored('IncludeMSoverride');
boolean IncludeDLverification := false : stored('IncludeDLverification');

IF( OFAC_version != 4 AND OFAC_XG5.constants.wlALLV4 IN SET(watchlists_request, value),
    FAIL( OFAC_XG5.Constants.ErrorMsg_OFACversion ) );

ret := Business_Risk.InstantID_Batch_Service_records(//risk_indicators.Layout_Gateways_In  
																gateways_in,
                                // business_risk.Layout_Input_Moxie_2 
																df,
																 //boolean
																 hb,
																// unsigned2 
																glb,
																// unsigned2 
																dppa,
																// boolean 
																isUtility,
																// boolean 
																ln_branded_value,
																 //string4 
																 tribcode,
																 //boolean 
																 excludeWatchLists,
																 //boolean 
																 ofac_only,
																 //unsigned1 
																 ofac_version,
																 //boolean
																 include_ofac,
																 //boolean 
																 include_additional_watchlists,
																 //real 
																 global_watchlist_threshold,
																 //integer2 
																 dob_radius_use,
																 //boolean 
																 isPOBoxCompliant,
																 //bsversion // set directly,
																 //exactMatchLevel set directly,
																 //string10 
																 IncludeTargus3220,
																 DataRestriction,
																 //boolean 
																 includeMSoverride,
																 //boolean 
																 IncludeDLverification,
																 //iesp.share.t_StringArrayItem 
																 watchlists_request,
																 suppressNearDups,
																 require2ele,
																 fromBiid,
																 isFCRA,
																 from_IT1O,
																 nugen,
																 Model_name,
																 IncludeFraudScores,
																 IncludeRepAttributes,
																 DataPermission
																 );
																 
output(ret, named('RESULTS'));


endmacro;
