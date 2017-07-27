/*--SOAP--
<message name="Foreclosure_Vacancy_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
</message>
*/
/*--INFO-- Insurance Renewal Batch Service*/
/*--HELP--
<pre>
&lt;dataset&gt;
	&lt;row&gt;
		&lt;UniqueID&gt;&lt;/UniqueID&gt;
		&lt;acctno&gt;&lt;/acctno&gt;
		&lt;last_name&gt;&lt;/last_name&gt;
		&lt;middle_initial&gt;&lt;/middle_initial&gt;
		&lt;first_name&gt;&lt;/first_name&gt;
		&lt;street_address&gt;&lt;/street_address&gt;
		&lt;apt&gt;&lt;/apt&gt;
		&lt;city&gt;&lt;/city&gt;
		&lt;state&gt;&lt;/state&gt;
		&lt;Zip&gt;&lt;/Zip&gt;
		&lt;Zip4&gt;&lt;/Zip4&gt;
	&lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import iesp, Foreclosure_Vacancy;

export BatchService := MACRO

	ds_xml_in := dataset([],Foreclosure_Vacancy.Layouts.In_Data) 			: stored('batch_in',few);

	//move AcctNo into UniqueID_in field
	Foreclosure_Vacancy.Layouts.In_Data addAcctNo(ds_xml_in l) := transform
		self.uniqueID := l.acctno;
		self := l;
	end;
	
	input_rec := project(ds_xml_in, addAcctNo(left));
	
	//Get data
	response := Foreclosure_Vacancy.getData(input_rec, isRenewal:=true).getRenewal();
	
	//Add Acct No back on linked via uniqueID
	Foreclosure_Vacancy.Layouts.Final_Batch addAcctNoBack(response l, ds_xml_in r) := transform
		self.acctno := r.acctno;
		self.UniqueID_in := r.UniqueID;
		self := l;
		self := [];
	end;

	final := join(response, ds_xml_in,
		left.UniqueID_in !='' and right.acctno !='' and
		left.UniqueID_in = right.acctno,
		addAcctNoBack(left, right),Left Outer,
			keep(1));
	
	output(final, named('Results'));

ENDMACRO;

// BatchService();