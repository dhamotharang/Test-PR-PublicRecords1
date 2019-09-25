// NOTE: This service is for internal use only and was created based upon a request
// from Mike Krumlauf in the batch engineering area.

/*--SOAP--
<message name="Did_Unparsed_Name_Service">
	<part name="UnParsedFullName" type="xsd:string"/>	
</message>
*/
/*--INFO-- This service returns 1 did based upon the input.*/
import address, doxie, dx_header, NID; 

export Did_Unparsed_Name_Service := MACRO

  // Store input value
  string120 unparsed_full_name := '' : stored('UnParsedFullName');

  //Parse the input unparsed full name.
  string73 parsed_full_name := address.CleanPerson73(stringlib.StringToUpperCase(
                                                          unparsed_full_name));
	string30 parsed_fname := parsed_full_name[6..25];
	string30 parsed_lname := parsed_full_name[46..65];

  name_rec := record
    string30 fname;
	  string30 lname;
  end;

  // Create dataset of the input fname & lname for join to the key below.
  ds_in_name := dataset ([{parsed_fname, parsed_lname}], name_rec);

  // Join to the header lname.fname key file to get a did (only 1 needed) that matches
	// on the input LastName & Firstname accounting for the phonetic last name and
	// the preferred first name values in the key.
  did_by_FLName := join(ds_in_name, dx_header.key_name(),
                        keyed(metaphonelib.DMetaPhone1(left.lname) = right.dph_lname) and 
											  keyed(left.lname                           = right.lname)     and 
												// NOTE: as of 08/24/10 the line below is the new way of 
												// checking for the preferred first name.
												keyed(NID.mod_PFirstTools.RinPFL(left.fname, right.pfname))   and 
										    keyed(left.fname                           = right.fname),
										    transform(doxie.layout_references,self := right),
                        keep(1));

  output(did_by_FLName, NAMED('Results'));
 
ENDMACRO;
