/*2016-06-08T19:32:42Z (Xia Sheng)
Unix to Linux Migration 
*/
export Common_Prof_Lic_Mari := MODULE


// common to all Profesional Lic MARI processing
import _control, Prof_License_Mari ;

// where incoming sources are sprayed
export SourcesFolder := '~thor_data400::in::proflic_mari::';

// where to put processed source files
export DestFolder := '~thor_data400::out::proflic_mari::';

// export espserverIPport	:= _Control.IPAddress.prod_thor_esp;
export sourceIP		 	:=	_Control.IPAddress.bctlpedata12;
export sourcepath		:=	'/data/data_build_5_2/MARI/in/';
export destpath			:= '/data/data_build_5_2/MARI/extract/';	
export MariDestpath		:=  '~thor_data400::in::proflic_mari::';	
export referpath		:= '/data/data_build_5_2/MARI/reference/';
// export group_name	:=	'thor40_241';
export group_name	:=	'thor400_36';
export group_name_2	:=	'thor5_241_10a';

END;