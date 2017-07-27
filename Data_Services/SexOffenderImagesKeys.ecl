/*--SOAP--
<message name="SexOffenderImagesKeys">
</message>
*/

export SexOffenderImagesKeys := macro
output(choosen(Images.Key_DID,10));
output(choosen(Images.Key_Images,10));
output(choosen(Images.File_Images,10));	
	
endmacro;