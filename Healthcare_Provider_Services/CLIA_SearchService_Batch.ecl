/*--SOAP--
<message name="CLIA_SearchService_Batch">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="ApplicationType"     	type="xsd:string"/>
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
	<part name="penalty_threshold"     	type="xsd:string"/>
</message>
*/
/*--INFO--
<pre>
This service will return a set of CLIA records matching the input criteria.

The service requires a either a CLIA number, BDID or Company Name and Address information as input.

</pre>
*/
/*--HELP-- 
<pre>

&lt;batch_in&gt;
&lt;row&gt;
&lt;acctno&gt;&lt;/acctno&gt;
&lt;comp_name&gt;&lt;/comp_name&gt;
&lt;prim_range&gt;&lt;/prim_range&gt;
&lt;predir&gt;&lt;/predir&gt;
&lt;prim_name&gt;&lt;/prim_name&gt;
&lt;addr_suffix&gt;&lt;/addr_suffix&gt;
&lt;postdir&gt;&lt;/postdir&gt;
&lt;sec_range&gt;&lt;/sec_range&gt;
&lt;p_city_name&gt;&lt;/p_city_name&gt;
&lt;st&gt;&lt;/st&gt;
&lt;z5&gt;&lt;/z5&gt;
&lt;CLIAnumber&gt;&lt;/CLIAnumber&gt;
&lt;bdid&gt;&lt;/bdid&gt;
&lt;/row&gt;
&lt;/batch_in&gt;

</pre>
*/


import Autokey_batch,AutoStandardI;
export CLIA_SearchService_Batch := Macro	
		
    rec_batch_in := Healthcare_Provider_Services.CLIA_Layouts.std_batch_in;

	  canned := dataset([],rec_batch_in);
		batch_in := canned : STORED('batch_in', FEW);
		
		batch_in_cleaned := project(batch_in, transform(Healthcare_Provider_Services.CLIA_Layouts.batch_in,
																						self.CLIANumber := stringlib.StringToUpperCase(left.CLIANumber);
																						self:=left));

 	  in_mod := module (Healthcare_Provider_Services.CLIA_Interfaces.clia_config)
			export unsigned4 MaxRecordsPerRow := 4 : stored('MaxRecordsPerRow');
			export unsigned4 penalty_threshold := 10 : stored('penalty_threshold');
			export string applicationType				:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
  	end;

		ds_results_raw := Healthcare_Provider_Services.CLIA_SearchService_Records(batch_in_cleaned,in_mod).records;
		NoHits := join(batch_in_cleaned,ds_results_raw,left.acctno=right.acctno,transform(Healthcare_Provider_Services.CLIA_Layouts.batch_out, self:=left; self:=[];),left only);
		// add back in the no hits
		ds_results := sort(ds_results_raw+NoHits,acctno);

		Healthcare_Provider_Services.CLIA_Layouts.batch_out doSeqLimit(Healthcare_Provider_Services.CLIA_Layouts.batch_out l, integer c):=transform
			self.seq:=if(c > in_mod.MaxRecordsPerRow,skip,c);
			self := l;
		end;

		resultsSeqLimit := Project(group(ds_results,acctno),doSeqLimit(left,counter));

		OUTPUT(resultsSeqLimit, NAMED('Results'));
endMacro;
// Healthcare_Provider_Services.CLIA_SearchService_Batch();
