IMPORT doxie,autokeyb2,AutoKeyI,AutoStandardI;

EXPORT Autokey_payload () := 

FUNCTION

   outrec := NPPES.Layouts.KeyBuild;

   //****** SEARCH THE AUTOKEYS
   ds := NPPES.File_SearchAutokey;
   tempmod_NPPES := MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
	   EXPORT STRING autokey_keyname_root := Constants().str_autokeyname;
	   EXPORT STRING typestr              := Constants().ak_typeStr;
	   EXPORT SET OF STRING1 get_skip_set := Constants().ak_skipSet;
		EXPORT BOOLEAN useAllLookups       := TRUE;
	END;

   ids := AutoKeyI.AutoKeyStandardFetch(tempmod_NPPES).ids;

   //****** GRAB THE PAYLOAD KEY
   AutokeyB2.mac_get_payload(ids,Constants().str_autokeyname,ds,outPL,did,bdid)

   //****** IDS DIRECTLY FROM THE PAYLOAD KEY
   ds_byAK := PROJECT(outPL, TRANSFORM( outrec, SELF := LEFT, SELF := []));
	
	RETURN ds_byAK; 

END;