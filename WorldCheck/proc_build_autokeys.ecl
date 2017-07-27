import AutoKeyB2,Address, Standard; 

export proc_build_autokeys(string filedate) := function

/////////////////////////////////////////////////////////////////////////////////
// -- Prepped for Macro & Removed Child Records from file
/////////////////////////////////////////////////////////////////////////////////
d := WorldCheck.File_Main;

// This is a special layout being used to drop all the child datasets.
// If there are ever any changes to the main record layout, this must be changed as well.
Layout_WorldCheck_Main_temp :=  record
	unsigned8                     Key;
	integer4                      UID;
	string255                     Name_Orig;
	string1                       Name_Type;
	string255                     Last_Name;
	string255                     First_Name;
	string255                     Category;
	string255                     WC_Title;
	string32                      Sub_Category;
	string255                     Position;
	String3                       Age;
	string8                       Date_Of_Birth;
	string8                       Date_Of_Death;
	string25                      Social_Security_Number;
	string30                      Address_1 := '';
	string30                      Address_2 := '';
	string30                      Address_3 := '';
	string30                      Address_Country := '';
	string1                       E_I_Ind;
	string5000                    Further_Information;
	string8                       Entered;
	string8                       Updated;
	string30                      Editor;
	string8                       Age_As_Of_Date;
	Standard.Name;
	string100                     cname;
	Standard.L_Address.detailed;
end;

xpnd_WorldCheck := RECORD
Layout_WorldCheck_Main_temp;
	          zero     := 0;
			  blank    := '';
	          no_DID   := 0;
	          no_BDID  := 0;

END;

xpnd_WorldCheck xpand_WorldCheck(d le) :=  TRANSFORM 
	SELF := le; 
END;


DS_WorldCheck := PROJECT(d,xpand_WorldCheck(LEFT));

Address.MAC_Multi_City(DS_WorldCheck,p_city_name,zip5,multiCityWorldCheck);
dist_DSWorldCheck := distribute(multiCityWorldCheck,random());

/////////////////////////////////////////////////////////////////////////////////
// -- Initialize AutoKey Macro
/////////////////////////////////////////////////////////////////////////////////

ak_keyname := '~thor_data400::key::WorldCheck::' + '@version@' + '::autokey::';
ak_logical := '~thor_data400::key::WorldCheck::' +  filedate   + '::autokey::';

set_skip := ['P','Q','F'];//keys to omit building
// Skipping the following:
// - P in this set to skip personal phones
// - Q in this set to skip business phones
// - F in this set to skip FEIN

/*
export MAC_Build (indataset
                 ,infname,inmname,inlname
				 ,inssn
				 ,indob
				 ,phone,inprim_name,inprim_range,inst,incity_name,inzip,insec_range
				 ,instates,inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3
				 ,inlookups
				 ,inDID
			     //personal above.  business below
				 ,inbname
				 ,infein
				 ,bphone
				 ,inbprim_name,inbprim_range,inbst,inbcity_name,inbzip,inbsec_range
				 //when one address, use same field names here as above
				 ,inbdid
				 ,inkeyname,inlogical,outaction,diffing='false'
				 ,build_skip_set='[]'
				 //P in this set to skip personal phones
				 //Q in this set to skip business phones
				 //S in this set to skip SSN
				 //F in this set to skip FEIN
				 //C in this set to skip ALL personal (Contact) data
				 //B in this set to skip ALL Business data
				 ,useFakeIDs = false
				 ,typeStr = '\'AK\''
				 //use default
				 ,useOnlyRecordIDs = false
				 ,FakeIDFieldType = 'unsigned6')  :=
*/


AutoKeyB2.MAC_Build (dist_DSWorldCheck
                    ,fname,mname,lname
					,Social_Security_Number
					,Date_Of_Birth
					,zero // For the phone number
					,prim_name,prim_range,st,v_city_name,zip5,sec_range
					,zero // states
					,zero,zero,zero // 3 additional last names
					,zero,zero,zero // 3 additional cities
					,zero,zero,zero // 3 relative first names
					,zero // lookups
					,no_DID
					,cname
					,blank
					,zero
					,prim_name,prim_range,st,v_city_name,zip5,sec_range
					,No_BDID
					,ak_keyname
					,ak_logical
					,bld_WorldCheck_auto,false
					,set_skip,true,
					,true,,,zero) 


/////////////////////////////////////////////////////////////////////////////////
// -- Move AutoKeys to QA
/////////////////////////////////////////////////////////////////////////////////

AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, move2qa,,set_skip)

retval := sequential(bld_WorldCheck_auto,move2qa);

 
return retval;

end;

