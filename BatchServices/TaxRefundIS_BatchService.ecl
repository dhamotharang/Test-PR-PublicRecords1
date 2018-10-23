/*--SOAP--
<message name="TaxRefundIS_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
  <part name="DataRestrictionMask"  type="xsd:string"/>
  <part name="DataPermissionMask"  type="xsd:string"/>
  <part name="IndustryClass" type="xsd:string"/>
	<part name="IncludeBlankDOD" type="xsd:boolean"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="IRSState" type="xsd:string"/>
  <part name="BestSSNScoreMin" type="xsd:unsigned2"/>
	<part name="BestNameScoreMin" type="xsd:unsigned2"/>
	<part name="SSNScoreMin" type="xsd:unsigned2"/>
	<part name="NAMEScoreMin" type="xsd:unsigned2"/>
  <part name="ModelName" type="xsd:string"/>
  <part name="NPIThreshold" type="xsd:string"/>
  <part name="FilterRule" type="xsd:string"/>
  <part name="TaxRefund_batch_in" type="tns:XmlDataSet" cols="70" rows="25"/> 
 
</message>
*/
/*--INFO-- This service processes the input through Deceased, Criminal, ADL Best, Best Address and SSN Issuance batch services
           to fill in the appropriate output fields.
					 The search requires a minimum input of last name, 
           first name or initial, SSN, and full address (Street Address 1, City and State, or Zip). 
           

<pre>
&lt;TaxRefund_batch_in&gt;
&lt;row&gt;
  &lt;acctno&gt;&lt;/acctno&gt;
  &lt;name_first&gt;&lt;/name_first&gt;
  &lt;name_middle&gt;&lt;/name_middle&gt;
  &lt;name_last&gt;&lt;/name_last&gt;
  &lt;ssn&gt;&lt;/ssn&gt;
  &lt;dob&gt;&lt;/dob&gt;
  &lt;prim_range&gt;&lt;/prim_range&gt;
  &lt;predir&gt;&lt;/predir&gt;
  &lt;prim_name&gt;&lt;/prim_name&gt;
  &lt;addr_suffix&gt;&lt;/addr_suffix&gt;
  &lt;postdir&gt;&lt;/postdir&gt;
  &lt;unit_desig&gt;&lt;/unit_desig&gt;
  &lt;sec_range&gt;&lt;/sec_range&gt;
  &lt;p_city_name&gt;&lt;/p_city_name&gt;
  &lt;st&gt;&lt;/st&gt;
  &lt;z5&gt;&lt;/z5&gt;
  &lt;zip4&gt;&lt;/zip4&gt;
  &lt;homephone&gt;&lt;/homephone&gt;
  &lt;workphone&gt;&lt;/workphone&gt;
&lt;/row&gt;  
&lt;/TaxRefund_batch_in&gt;
</pre>
*/

import BatchServices;
	
export TaxRefundIS_BatchService := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);	
	in_layout := BatchServices.Layouts.TaxRefundIS.batch_in;
	
	
	ds_batch_in := dataset([], in_layout) : stored('TaxRefund_batch_in');
	
	
	
	doxie.MAC_Header_Field_Declare();
	
  args := MODULE (BatchServices.TaxRefundIS_BatchService_Interfaces.Input)  
		EXPORT string32 ApplicationType  		:= application_type_value;
	  EXPORT unsigned1 DPPAPurpose 				:= DPPA_Purpose;
	  EXPORT unsigned1 GLBPurpose  				:= GLB_Purpose;      
    EXPORT string5 IndustryClass				:= industry_class_value;
	  EXPORT boolean IncludeBlankDOD			:= 0 : stored('IncludeBlankDOD');
    EXPORT boolean PhoneticMatch		    := phonetics; 
    EXPORT boolean AllowNickNames				:= nicknames; 
  	EXPORT string50 DataRestriction     := doxie.DataRestriction.fixed_DRM;
		EXPORT string120 append_l           := 'BEST_ALL, BEST_EDA'; //Append allows all Best Info to return
		EXPORT string120 verify_l           := 'BEST_ALL';
		EXPORT string2 input_state          := '' : stored('IRSState');
		EXPORT unsigned2 BestSSNScoreMin    := 0 : stored('BestSSNScoreMin');
		EXPORT unsigned2 BestNameScoreMin   := 0 : stored('BestNameScoreMin');
		EXPORT unsigned2 SSNScoreMin        := 0 : stored('SSNScoreMin');
		EXPORT unsigned2 NAMEScoreMin       := 0 : stored('NAMEScoreMin');
		EXPORT string20  ModelName          := '' : stored('ModelName');        
		EXPORT string3   NPIThreshold       := '' : stored('NPIThreshold'); // 0 - 999 are valid values
		EXPORT string30  FilterRule         := '' : stored('FilterRule');
		// EXPORT string10 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
		EXPORT string10	DataPermission 			:= AutoStandardI.GlobalModule().DataPermissionMask;
	END;
	
	
	Results := BatchServices.TaxRefundIS_BatchService_Records(ds_batch_in, args);
		
	OUTPUT(Results,NAMED('Results'));
ENDMACRO;

// BatchServices.TaxRefundIS_BatchService()