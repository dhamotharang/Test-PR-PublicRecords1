/*--SOAP--
<message name="AddressRank_BatchService">
  <part name="batch_in" 							type="tns:XmlDataSet" cols="70" rows="25"/>  
  <part name="DPPAPurpose" 						type="xsd:unsignedInt"/>
  <part name="GLBPurpose" 						type="xsd:unsignedInt"/>
  <part name="MaxRecordsToReturn"			type="xsd:unsignedInt"/>
	<part name="ApplicationType"     		type="xsd:string"/>
	<part name="IncludeShortTermRental" type="xsd:boolean"/>
	<part name="IncludeSTRSplitFlag" 		type="xsd:boolean"/>
	<part name="AddrSearchDate" 				type="xsd:string"/>
	<part name="DEBUG" 									type="xsd:boolean"/>
</message>
*/
/*--INFO-- This is a batch service that processes the input and identifies best possible address
					 using the address history ranking key and compares with NCOA then appends additional 
					 metadata from ADVO and STR.
<pre>
&lt;batch_in&gt;
	&lt;row&gt;
		&lt;acctno&gt;&lt;/acctno&gt;
		&lt;did&gt;&lt;/did&gt;
		&lt;ssn&gt;&lt;/ssn&gt;
		&lt;dob&gt;yyyymmdd&lt;/dob&gt;
		&lt;name_last&gt;&lt;/name_last&gt;
		&lt;name_first&gt;&lt;/name_first&gt;
		&lt;name_middle&gt;&lt;/name_middle&gt;
		&lt;name_suffix&gt;&lt;/name_suffix&gt;
		&lt;addr&gt;&lt;/addr&gt;
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
		&lt;county_name&gt;&lt;/county_name&gt;
		&lt;phone&gt;&lt;/phone&gt;
		&lt;NCOA_addr&gt;&lt;/NCOA_addr&gt;
		&lt;NCOA_addr2&gt;&lt;/NCOA_addr2&gt;
		&lt;NCOA_prim_range&gt;&lt;/NCOA_prim_range&gt;
		&lt;NCOA_predir&gt;&lt;/NCOA_predir&gt;
		&lt;NCOA_prim_name&gt;&lt;/NCOA_prim_name&gt;
		&lt;NCOA_addr_suffix&gt;&lt;/NCOA_addr_suffix&gt;
		&lt;NCOA_postdir&gt;&lt;/NCOA_postdir&gt;
		&lt;NCOA_unit_desig&gt;&lt;/NCOA_unit_desig&gt;
		&lt;NCOA_sec_range&gt;&lt;/NCOA_sec_range&gt;
		&lt;NCOA_city&gt;&lt;/NCOA_city&gt;
		&lt;NCOA_state&gt;&lt;/NCOA_state&gt;
		&lt;NCOA_zip&gt;&lt;/NCOA_zip&gt;
		&lt;MatchMoveEffDate&gt;yyyymm&lt;/MatchMoveEffDate&gt;
	&lt;/row&gt;
&lt;/batch_in&gt;
*/

IMPORT Address_Rank, AutoKeyI, doxie;
EXPORT BatchService(useCannedRecs = false) := MACRO
 
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	ds_xml_in 	:= DATASET([],Address_Rank.Layouts.Batch_in) : STORED('batch_in',FEW);
	batch_params		:= Address_Rank.IParams.getBatchParams();							
	processed_input := Address_Rank.fn_processInput(ds_xml_in, useCannedRecs);
	
	//**************************get records************************************/
	ds_batch_out := Address_Rank.Records(processed_input(error_code = 0), batch_params); 										

  //************restore orig_acctno and append input values for user convenience**************/	
	Address_Rank.Layouts.BatchOut_wInputEcho echoInput(processed_input l, ds_batch_out r) := TRANSFORM			
		SELF.acctno 				:= l.orig_acctno;
		SELF.error_code 		:= IF(l.error_code = AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT,
															AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT, 0);
		SELF.error_desc 		:= IF(l.error_code = AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT,
															doxie.ErrorCodes(AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT), '');
		SELF.in_did						:= l.did;           
		SELF.in_ssn						:= l.ssn;
		SELF.in_dob						:= l.dob;
		SELF.in_name_first		:= l.name_first; 
		SELF.in_name_middle 	:= l.name_middle;  
		SELF.in_name_last			:= l.name_last;    
		SELF.in_name_suffix		:= l.name_suffix;  
		SELF.in_prim_range		:= l.prim_range;                           
		SELF.in_predir				:= l.predir;                      
		SELF.in_prim_name			:= l.prim_name;                        
		SELF.in_addr_suffix		:= l.addr_suffix;
		SELF.in_postdir				:= l.postdir;                
		SELF.in_unit_desig		:= l.unit_desig;             
		SELF.in_sec_range			:= l.sec_range;                           
		SELF.in_p_city_name		:= l.p_city_name;
		SELF.in_st						:= l.st;         
		SELF.in_z5						:= l.z5;   
		SELF.in_zip4					:= l.zip4;
		SELF.in_county_name		:= l.county_name;
		SELF.in_phone					:= l.phone;
		SELF.in_NCOA_prim_range		:= l.NCOA_prim_range;
		SELF.in_NCOA_predir				:= l.NCOA_predir;   
		SELF.in_NCOA_prim_name		:= l.NCOA_prim_name;
		SELF.in_NCOA_addr_suffix	:= l.NCOA_addr_suffix	;
		SELF.in_NCOA_postdir			:= l.NCOA_postdir;
		SELF.in_NCOA_unit_desig		:= l.NCOA_unit_desig;              
		SELF.in_NCOA_sec_range		:= l.NCOA_sec_range;
		SELF.in_NCOA_city					:= l.NCOA_city;                          
		SELF.in_NCOA_state				:= l.NCOA_state;                        
		SELF.in_NCOA_zip					:= l.NCOA_zip;                     
		SELF.in_MatchMoveEffDate	:= l.MatchMoveEffDate;		
		SELF.AddrSearchDate				:= batch_params.AddrSearchDate;
		SELF 	:= r;
	END;
	
	results:= JOIN(processed_input, ds_batch_out,
						 LEFT.acctno = RIGHT.acctno,
						 echoInput(LEFT, RIGHT), LEFT OUTER, LIMIT(0), KEEP(batch_params.MaxRecordsToReturn));
	OUTPUT(results, 					NAMED('results'));																//final output
ENDMACRO;
