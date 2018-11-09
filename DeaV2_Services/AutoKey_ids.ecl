/*2007-10-15T21:26:20Z (Eitan Halper-Stromberg)
27190
*/


// #stored('Zip','32601');
import autokeyb2,doxie,business_header,doxie_cbrs,DEA,autokeyi,AutoStandardI,AutoHeaderI;

export autokey_ids(boolean workhard = false, boolean nofail = false, boolean NoDeepDives = true) := FUNCTION
				business_header.doxie_MAC_Field_Declare()
        boolean is_CompSearchL := company_name_value <> '';
        boolean is_ContSearchL := lname_value <> '' or ssn_value <>'' or addr_value <> '';	
									
				// ****** DEFINE ATTRIBUTES
				t := DEA.Constants(Version.key).ak_QAname;
				ds := dataset([],DEAV2_services.assorted_layouts.layout_Index);
				typestr :=DEA.Constants(Version.key).ak_typeStr;
				skip_set := Dea.Constants('').skip_set;

				// ****** SEARCH THE AUTOKEYS
				tempmod := module(project(AutoStandardI.GlobalModule(),autokeyi.AutoKeyStandardFetchArgumentInterface,opt))
					export string autokey_keyname_root := t;
					export string typestr := ^.typestr;
					export set of string1 get_skip_set := skip_set;
					export boolean workHard := ^.workHard;
					export boolean noFail := ^.noFail;
					export boolean useAllLookups := true;
				end;
				ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;
	
				// ****** GET THE PAYLOAD
				mac_get_payload_ids(ids,t,ds,outpl,'AK',, newdids, newbdids);
				
				// ***** DIDs

				dids := if(is_ContSearchL, PROJECT (doxie.Get_Dids(true,true), doxie.layout_references));
				newdids1 := PROJECT(newdids,transform ( doxie.layout_references, SELF.did:=LEFT.indid ));
				newbydid1 := DEA_raw.get_dids(dedup(newdids1+dids,all));
				

				// ***** BDIDs
				tempbhmod := module(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
					export boolean score_results := false;
				end;
				bdids := if(is_CompSearchL,project(AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempbhmod),doxie_cbrs.layout_references));
				newbdids1 := PROJECT(newbdids,transform ( doxie_cbrs.layout_references, SELF.bdid:=LEFT.inbdid ));
			  newbybdid1 := DEA_raw.get_bdids(dedup(newbdids1+bdids,all));

				
				//***** FOR DEEP DIVES
				DeepDives := newbybdid1 + newbydid1;

				//****** IDS DIRECTLY FROM THE PAYLOAD KEY+ DeepDive
			  dups := outpl + if(~ NoDeepDives, deepDives);
        dedup_outpl := DEDUP(SORT(dups,dea_registration_number,if(isDeepDive,1,0)),dea_registration_number);
			  return dedup_outpl;
				
		END;



