IMPORT VersionControl;

EXPORT _Flags := MODULE

  // This is the last year that Data Fabrication has either done coding, dealing with a layout change,
	//   or verified that the layout hasn't changed and no coding is required for the year.

  // *************************************************************************************************
  // *************************************************************************************************
	// DO NOT SANDBOX THE STOP YEAR TO GET A RUN GOING.  CONTACT DATA FABRICATION IF THE RUN IS BEING
	//   STOPPED BY THIS FLAG.
	// *************************************************************************************************
	// *************************************************************************************************

	// For the developer:  If there is a layout change, you'll be looking into these attributes:
	//   Layout_Voters_In, Layouts_Voters, Mapping_Voters_VoteHistory, and _Flags. This list may not be
	//   everything, but should point you in the right direction.
	//   Remember that any files sprayed in the process where the build failed will need THOR-fixed or
	//   blown away and re-sprayed by the Mac_Spray_Voters call (after code changes are implemented).
	EXPORT stop_year := '2018';

  EXPORT valid_gender := ['M', 'F', 'U'];
	
	//Barb O'Neill - added when working on bug DOPS-461
	EXPORT IsTesting 							:= VersionControl._Flags.IsDataland;
	
END;