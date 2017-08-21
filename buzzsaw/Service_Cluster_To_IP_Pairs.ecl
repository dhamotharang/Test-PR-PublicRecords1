/*--SOAP--
<message name="Service Cluster To IP Pairs">
	<part name="_Cluster" type="xsd:int"/>
</message>
*/
/*--INFO-- This service does nothing.

*/

export Service_Cluster_To_IP_Pairs := MACRO
	INTEGER4 c_param := -1 : STORED('_Cluster');
	c_ds := buzzsaw.Mod_Data.FN_Clusters;
	
	
	
ENDMACRO;