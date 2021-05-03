//-----------------------------------------------------------------------------
// Gets the candidate records to be used in the main, which is the input data
// and data for two degrees of separation of relatives.
//-----------------------------------------------------------------------------
EXPORT get_universe(unsigned1 mode):=MODULE

  clean := reunion.reunion_clean(mode);

  // Start with a slim version of the original data from reunion_clean that 
	// contains just the DID and an integer came_from='1'.
  dOriginalDIDs:=DEDUP(SORT(DISTRIBUTE(PROJECT(clean(did>0),TRANSFORM(reunion.layouts.lIteration,SELF.came_from:='1';SELF:=LEFT;)),HASH(did)),did,LOCAL),did,LOCAL);

  // Pass2 gives us the input data with first-degree relatives (came_from='2')
  SHARED dFirstDegree:=reunion.mod_get_universe(dOriginalDIDs,'2',mode).universe:PERSIST('~thor::persist::mylife::universe_pass2::' + reunion.Constants.sMode(mode), EXPIRE(10), REFRESH(FALSE));

  dFirstDegreeLimited:=reunion.fn_limit_iteration_2_relatives(dFirstDegree,mode);

  // Pass3 gives us the data from Pass 2 along with second-degree relatives
	// (came_from='3')
  SHARED dSecondDegree:=reunion.mod_get_universe(dFirstDegreeLimited,'3',mode).universe:PERSIST('~thor::persist::mylife::universe_pass3::' + reunion.Constants.sMode(mode), EXPIRE(10), REFRESH(FALSE));
  

  EXPORT get_relative_pairs:=reunion.mod_get_universe(dFirstDegree,'2',mode).relative_pairs;
  EXPORT get_main:=dSecondDegree;
END;