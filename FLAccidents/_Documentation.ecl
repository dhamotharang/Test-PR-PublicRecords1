export _Documentation := 

// FLAccidents is an annual Florida Accidents update/append data set.  The yearly vendor file for
// append is dropped in \\tapeload02b\k\accident_reports_(pi) about the third quarter each year.

// Background:
// This process was originally created using Ab-Initio.  The graphs split the vendor file into
// nine files one for each record type.  An extra file with key information from each accident record
// was also created to facilitate searches.  Next, these ten files were appended to the previous
// year files.  Following, a copy of each of the ten files was sprayed (loaded) to dataland
// development environment. Last, while MOXIE keys were created in the Unix environment and left there,
// the ROXIE keys were built using ECL.

// The new version of this process is entirely written in ECL.  FLAccidents.BWR_Build_All runs the entire
// process after the new vendor file has been copied from tape to
// edata12.br.seisint.com/supper_credit/flcrash/new_data/ and converted from ebsidic to ascii format.

// BWR_FLaccidents_01, BWR_FLaccidents_vina_02, BWR_FLaccidents_vina_append_02, BWR_FLaccidents_03
// are used for debugging as they each can be used as a stand alone to produce and examine output in each
// of the build stages.  Each represents a step in the process of creating the files and corresponds to
// an Ab-Initio graph in the original process.  Everything is tied together in the production version.

// Core attributes:
// FLAccidents.FLCrash_SprayInput	(housekeeping)
	// Deletes content from FLAccidents father Superfile
	// Move last vendor imput file to FLAccidents father Superfile
	// Sprays ascii vendor file to FLAccidents Superfile
	// Delete content from "in" father superfiles
	// Move last run output(called "in" because they will be input to create base files) to father superfiles

// FLAccidents.Proc_build_input
	// Create the imput for the base file creation and append new files to previous year files
	// Calls:
		// FLAccidents.FLaccidents_vina
			// FLAccidents.FLaccidents_vina_append
				// FLAccidents.Map_FLAccidents
	// Inputs:
		// in::flaccidents
	// Outputs:
		// in::flcrash0
		// in::flcrash1
		// in::flcrash2v
		// in::flcrash3v
		// in::flcrash4
		// in::flcrash5
		// in::flcrash6
		// in::flcrash7
		// in::flcrash8
		// in::flcrashs

// FLAccidents.FLCrash_BuildFile
	// Create base files from the new "in" files adding DID and bDID to the files containing people or busines
	// Calls:
		// did_add.mac_match_flex
		// business_header_ss.MAC_Add_BDID_Flex
		// ut.MAC_SF_BuildProcess
	// Inputs:
		// in::flcrash0
		// in::flcrash1
		// in::flcrash2v
		// in::flcrash3v
		// in::flcrash4
		// in::flcrash5
		// in::flcrash6
		// in::flcrash7
		// in::flcrash8
	// Outputs:
		// base::flcrash0
		// base::flcrash1
		// base::flcrash2v
		// base::flcrash3v
		// base::flcrash4
		// base::flcrash5
		// base::flcrash6
		// base::flcrash7
		// base::flcrash8

// FLAccidents.FLCrash_BuildDidFile
	// Create people search file "did" file from base files with people DIDs
	// Calls:
		// ut.MAC_SF_BuildProcess
	// Inputs:
		// base::flcrash0
		// base::flcrash2v
		// base::flcrash4
		// base::flcrash5
		// base::flcrash6
		// base::flcrash7
	// Outputs:
		// base::flcrash_did

// FLAccidents.FLCrash_BuildSSFile
	// Create roxie search service file from base "did" and 3 other base files
	// Calls:
		// ut.MAC_SF_BuildProcess
	// Inputs:
		// base::flcrash_did
		// base::flcrash2v
		// base::flcrash4
		// base::flcrash7
	// Outputs:
		// base::flcrash_ss

// FLAccidents.FLCrash_BuildKeys
	// Perform ROXIE keys housekeeping
	// Creates new ROXIE keys from base files
	// Calls:
		// RoxieKeyBuild.Mac_SK_BuildProcess_Local
		// RoxieKeyBuild.Mac_SK_Move_To_Built
		// ut.MAC_SK_Move
	// Inputs:
		// base::flcrash0
		// base::flcrash1
		// base::flcrash2v
		// base::flcrash3v
		// base::flcrash4
		// base::flcrash5
		// base::flcrash6
		// base::flcrash7
		// base::flcrash8
		// base::flcrash_did
		// base::flcrash_ss
	// Outputs:
		// key::flcrash0
		// key::flcrash1
		// key::flcrash2v
		// key::flcrash3v
		// key::flcrash4
		// key::flcrash5
		// key::flcrash6
		// key::flcrash7
		// key::flcrash8
		// key::flcrash_accnbr
		// key::flcrash_bdid
		// key::flcrash_did
		// key::flcrash_dlnbr
		// key::flcrash_tagnbr
		// key::flcrash_vin

// FLAccidents.Out_MOXIE_FLAccidents_Keys
	// Perform MOXIE keys housekeeping
	// Creates new MOXIE keys from "in" files
	// Calls:
		// ut.Mac_Delete_File
	// Inputs:
		// in::flcrash0
		// in::flcrash1
		// in::flcrash2v
		// in::flcrash3v
		// in::flcrash4
		// in::flcrash5
		// in::flcrash6
		// in::flcrash7
		// in::flcrash8
		// in::flcrashs
	// Outputs:
		// flcrash0.accident_nbr.key
		// flcrash1.accident_nbr.key
		// flcrash2v.accident_nbr.section_nbr.key
		// flcrash3v.accident_nbr.section_nbr.key
		// flcrash4.accident_nbr.section_nbr.key
		// flcrash5.accident_nbr.section_nbr.passenger_nbr.key
		// flcrash6.accident_nbr.section_nbr.key
		// flcrash7.accident_nbr.key
		// flcrash8.accident_nbr.section_no.key
		// flcrashs.accident_nbr.rec_type_x.key
		// flcrashs.cn.rec_type_x.key
		// flcrashs.dph_lname.fname.mname.lname.rec_type_x.key
		// flcrashs.drivers_license_info.dl_state.key
		// flcrashs.lfmname.rec_type_x.key
		// flcrashs.nameasis.rec_type_x.key
		// flcrashs.pcn.rec_type_x.key
		// flcrashs.st.city.cn.rec_type_x.key
		// flcrashs.st.city.dph_lname.fname.mname.lname.rec_type_x.key
		// flcrashs.st.city.lfmname.rec_type_x.key
		// flcrashs.st.city.nameasis.rec_type_x.key
		// flcrashs.st.city.pcn.rec_type_x.key
		// flcrashs.st.city.prim_name.prim_range.predir.postdir.suffix.key
		// flcrashs.st.cn.rec_type_x.key
		// flcrashs.st.lfmname.rec_type_x.key
		// flcrashs.st.nameasis.rec_type_x.key
		// flcrashs.st.pcn.rec_type_x.key
		// flcrashs.tag_nbr.key
		// flcrashs.tag_state.tag_nbr.key
		// flcrashs.vin.key
		// flcrashs.z5.prim_name.prim_range.key
		// flcrashs.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key
		// flcrashs.zip.cn.rec_type_x.key
		// flcrashs.zip.dph_lname.fname.mname.lname.key
		// flcrashs.zip.lfmname.rec_type_x.key
		// flcrashs.zip.nameasis.rec_type_x.key
		// flcrashs.zip.pcn.rec_type_x.key
		// flcrashs.zip.prim_name.suffix.predir.postdir.prim_range.sec_range.key

// FLAccidents.Proc_build_autokey
	// Perform AUTO keys housekeeping
	// Creates new AUTO keys from base "did" file
	// Calls:
		// AutoKeyB2.MAC_Build
		// RoxieKeyBuild.MAC_SK_Move_v2
	// Inputs:
		// base::flcrash_ss
	// Outputs:
		// autokey::address
		// autokey::addressb2
		// autokey::citystname
    // autokey::citystnameb2
		// autokey::name
		// autokey::nameb2
		// autokey::namewords2
		// autokey::payload
		// autokey::stname
    // autokey::stnameb2
    // autokey::zip
		// autokey::zipb2

// FLAccidents.DKC_FLAccidents_Keys
	// Copies newly created MOXIE keys and "in" files to Unix (pDestination)
	// Inputs:
		// flcrash0.accident_nbr.key
		// flcrash1.accident_nbr.key
		// flcrash2v.accident_nbr.section_nbr.key
		// flcrash3v.accident_nbr.section_nbr.key
		// flcrash4.accident_nbr.section_nbr.key
		// flcrash5.accident_nbr.section_nbr.passenger_nbr.key
		// flcrash6.accident_nbr.section_nbr.key
		// flcrash7.accident_nbr.key
		// flcrash8.accident_nbr.section_no.key
		// flcrashs.accident_nbr.rec_type_x.key
		// flcrashs.cn.rec_type_x.key
		// flcrashs.dph_lname.fname.mname.lname.rec_type_x.key
		// flcrashs.drivers_license_info.dl_state.key
		// flcrashs.lfmname.rec_type_x.key
		// flcrashs.nameasis.rec_type_x.key
		// flcrashs.pcn.rec_type_x.key
		// flcrashs.st.city.cn.rec_type_x.key
		// flcrashs.st.city.dph_lname.fname.mname.lname.rec_type_x.key
		// flcrashs.st.city.lfmname.rec_type_x.key
		// flcrashs.st.city.nameasis.rec_type_x.key
		// flcrashs.st.city.pcn.rec_type_x.key
		// flcrashs.st.city.prim_name.prim_range.predir.postdir.suffix.key
		// flcrashs.st.cn.rec_type_x.key
		// flcrashs.st.lfmname.rec_type_x.key
		// flcrashs.st.nameasis.rec_type_x.key
		// flcrashs.st.pcn.rec_type_x.key
		// flcrashs.tag_nbr.key
		// flcrashs.tag_state.tag_nbr.key
		// flcrashs.vin.key
		// flcrashs.z5.prim_name.prim_range.key
		// flcrashs.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key
		// flcrashs.zip.cn.rec_type_x.key
		// flcrashs.zip.dph_lname.fname.mname.lname.key
		// flcrashs.zip.lfmname.rec_type_x.key
		// flcrashs.zip.nameasis.rec_type_x.key
		// flcrashs.zip.pcn.rec_type_x.key
		// flcrashs.zip.prim_name.suffix.predir.postdir.prim_range.sec_range.key

// FLAccidents.Proc_build_stats
	// Creates STRATA reports
	// Calls:
		// FLAccidents.Out_FLCrash_STRATA_Population
			// STRATA.createXMLStats
	// Inputs:
		// base::flcrash0
		// base::flcrash1
		// base::flcrash2v
		// base::flcrash3v
		// base::flcrash4
		// base::flcrash5
		// base::flcrash6
		// base::flcrash7
		// base::flcrash8
		// base::did
	// Outputs:

// FLAccidents.Sample_data
	// Creates sample data reports
	// Calls:
	// Inputs:
		// base::flcrash0
		// base::flcrash1
		// base::flcrash2v
		// base::flcrash3v
		// base::flcrash4
		// base::flcrash5
		// base::flcrash6
		// base::flcrash7
		// base::flcrash8
		// base::did
	// Outputs:
