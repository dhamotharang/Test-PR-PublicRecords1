/*--SOAP--
<message name="LoadPlugins">
</message>
*/
import patriot, ut;

export LoadPlugins := macro

in_data := group(project(dataset([{1}], {unsigned a}), 
	transform(patriot.Layout_batch_in,
	self.seq := 1;
	self.name_first := 'DANIEL';
	self.name_last := 'GARCIA';
	self.search_type := 'I';
	SELF := [])), seq);
	
v1_results := Patriot.Search_Base_Function(in_data, false, 0.84, , 1, true, true);
v2_results := Patriot.Search_Base_Function(in_data, false, 0.84, , 2, true, true);
v3_results := Patriot.Search_Base_Function(in_data, false, 0.84, , 3, true, true);
	
output(v1_results, named('v1_results'));
output(v2_results, named('v2_results'));
output(v3_results, named('v3_results'));		
		
endmacro;

// doxie.LoadPlugins();
