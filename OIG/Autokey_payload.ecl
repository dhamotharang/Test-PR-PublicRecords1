IMPORT doxie,autokeyb2,AutoKeyI,AutoStandardI;

EXPORT Autokey_payload () := 
   FUNCTION
	   
		outrec := OIG.layouts.KeyBuild;

      //****** SEARCH THE AUTOKEYS
		ds := OIG.File_OIG_KeyBaseTemp;
      tempmod_OIG := MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
	      EXPORT STRING autokey_keyname_root := Constants().autokey_qa_root;  // this is for dev and prod
	      EXPORT STRING typestr              := 'AK';
	      EXPORT SET OF STRING1 get_skip_set := Constants().autokey_buildskipset;
			EXPORT BOOLEAN useAllLookups       := TRUE;
	   END;
      ids := AutoKeyI.AutoKeyStandardFetch(tempmod_OIG).ids;

      //****** GRAB THE PAYLOAD KEY
      AutokeyB2.mac_get_payload(ids,Constants().autokey_qa_root,ds,outPL,did,bdid)
		
      //****** IDS DIRECTLY FROM THE PAYLOAD KEY
      ds_byAK := PROJECT( outPL, transform(outrec, self := left; self := [];));
	
	RETURN ds_byAK; 

END;