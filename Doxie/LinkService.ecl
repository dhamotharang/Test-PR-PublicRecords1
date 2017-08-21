/*--SOAP--
<message name="LinkService">
  <part name="DID1" type="xsd:string" required="1"/>
  <part name="DID2" type="xsd:string" required="1"/>
 </message>
*/
/*--INFO-- This is the Link Service. 
It will attempt to find a series of links to join the two DIDs together.
Currently supports up to 6 degrees of seperation (5 intermediate people)
*/
export LinkService() := macro

output(choosen(sort(doxie.link_records,out_seq),2000))

  endmacro;