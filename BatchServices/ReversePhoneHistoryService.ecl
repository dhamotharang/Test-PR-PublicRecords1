
/*--SOAP--
<message name="ReversePhoneHistoryService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="MaxRecordsPerPhone"   type="xsd:unsigned"/>
  <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
</message>
*/
/*--INFO--
<pre>
This service will return a set of current and/or historical owners for a given phone number.

The service will return 1 row of data per unique DID based entity rolled up to have only 1 address.

The service requires a 10 digit phone or a 7 digit phone and state or DID or BDID as input.

If Max_RecordsPerPhone = 1, then only the current owner of the number will be returned.
If Max_RecordsPerPhone = 4, then the current owner and previous 3 owners if they exist will be returned.
</pre>
*/
/*--HELP--
<pre>

&lt;batch_in&gt;
&lt;row&gt;
&lt;acctno&gt;&lt;/acctno&gt;
&lt;phone&gt;&lt;/phone&gt;
&lt;st&gt;&lt;/st&gt;
&lt;did&gt;&lt;/did&gt;
&lt;bdid&gt;&lt;/bdid&gt;
&lt;/row&gt;
&lt;/batch_in&gt;

</pre>
*/


import gong,AutoStandardI;
export ReversePhoneHistoryService := Macro

    rec_batch_in := BatchServices.Layouts.ReversePhoneHistory.batch_in;

	  canned := dataset([],rec_batch_in);
		batch_in := canned : STORED('batch_in', FEW);


		batch_in_cleaned := project(batch_in, transform(BatchServices.Layouts.ReversePhoneHistory.batch_in_cleaned,
																						self.phone7:=if(left.phone[8..10]='',left.phone[1..7],left.phone[4..10]),
																						self.phone3:=if(left.phone[8..10]='','',left.phone[1..3]),
																						self.st:=stringlib.StringToUpperCase(left.st);
																						self:=left));

    gm := AutoStandardI.GlobalModule();
    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(gm);

    in_mod := module (BatchServices.Interfaces.reversephonehistory_config)
			export unsigned4 MaxRecordsPerPhone := 4 : stored('MaxRecordsPerPhone');
			export string applicationType := mod_access.application_type;
  	end;

		ds_ReversePhone := BatchServices.ReversePhoneHistory_Records(batch_in_cleaned, in_mod, mod_access);
		OUTPUT(ds_ReversePhone, NAMED('Results'));
endMacro;
//BatchServices.ReversePhoneHistoryService();
