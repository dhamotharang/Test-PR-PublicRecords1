IMPORT PRTE2_CODE_GENERATOR;
// Builds the text for the Constants attribute
// modulename is the name of the new module.
// datasetname is the name of the dataset as it should look when part of a file name.

EXPORT Build_Constants_Attribute(string modulename,string datasetname) := FUNCTION

constants_text := 
'EXPORT Constants := module\n\n' +
'EXPORT KeyName_' + datasetname + ' := 	\'~prte::key::' + datasetname + '::\'; \n\n' +
'EXPORT ak_keyname := KeyName_' + datasetname + ' +\'autokey::@version@::\'; \n\n' +
'EXPORT ak_logical(string filedate) := KeyName_' + datasetname + ' + filedate + \'::autokey::\'; \n\n' +
'EXPORT skip_set := [/* Fill in appropriate values */ ]; \n\n' +
'EXPORT ak_typestr := \'AK\'; \n\n' +
'END;';

RETURN UpdateAttributeText(modulename, 'Constants', constants_text);

END;