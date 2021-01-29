// CFK 02/23/2016 charles.kaminski@lexisnexis.com
// This code will query a prefix tree to 
//   significantly improve the performance of an 
//   edit distance algorythm.
// Read the code walk-through on the HPCC Systems blog
// https://hpccsystems.com/resources/blog?uid=225 
//==================================================================================================
//=============================== Query Prefix Tree ================================================
//==================================================================================================
Export MAC_PrefixTree_Query_Dataset_Levenshtein(input_query_string, pt_index, max_edit_distance) := FUNCTIONMACRO
   STRING CalculateLevenshteinVector(STRING word, STRING node, STRING state) := BEGINC++
      /// CFK 08/20/2015 charles.kaminski@lexisnexis.com                 
      /// This C++ returns the vector used to calculate
      ///  the Levenshtein distance in an interative process so that
      ///  an efficient trie structure can be traversed when finding candidates
      /// Node values can be passed in and the current state can be saved 
      ///   in the return vector so that other nodes can be further processed in series
      /// We're using char arrays to keep the size down
      /// That also means that all our words (both in the trie and our query words)
      ///  must be less than 255 characters in length.  If that limitation becomes a problem
      ///  we can easily use an array of integers or another other structure to store
      ///  intermediate values.
      #option pure
      #include <algorithm>
      #body
      //  The last element in the array will hold
      //   the min value.  The min value will be used later.
      int v_size = lenWord + 2;
	
      unsigned char min_value = 255;
      unsigned char new_value = 0;
	
      // Since v0 is not returned, we should not use rtlMalloc
      //unsigned char * v0 = (unsigned char*)rtlMalloc(v_size);	
      unsigned char v0[v_size];
      // We use rtlMalloc helper function when a variable is returned by the function
      unsigned char * v1 = (unsigned char*)rtlMalloc(v_size);
	
      if (lenState < 1){
         for (int i = 0; i < v_size; i++){
            v0[i] = i;
         }
      }
      else{
         memcpy(&v0[0], &state[0], v_size);
      }
	
      int cost = 0;
      int k = v0[0];
					
      for (int i=k; i<k+lenNode; i++)
      {
	       min_value = 255;
         v1[0] = i + 1;
         for (int j=0; j<lenWord; j++)
         {
            cost = (node[i-k] == word[j]) ? 0 : 1;
            new_value = std::min(v1[j] + 1, std::min(v0[j+1] + 1, v0[j] + cost));
            v1[j+1] = new_value;
            if (new_value < min_value){
               min_value=new_value;
            }
         }
         memcpy(&v0[0], &v1[0], lenState);
      }
	
      // Store the min_value;
      v1[v_size-1] = min_value;
	
      __lenResult = v_size;
      __result    = (char *) v1;
                                                                
   ENDC++;
 
   UNSIGNED1 GetMinDistance(STRING state) := BEGINC++
      /// CFK 08/20/2015 charles.kaminski@lexisnexis.com	
      ///  Get the Minimum Edit Distance
      #option pure
      #body		
      //return (unsigned char) state[(unsigned int) position];
      return (unsigned char) state[lenState-1];
   ENDC++;
   UNSIGNED1 GetFinalDistance(STRING state) := BEGINC++
      /// CFK 08/20/2015 charles.kaminski@lexisnexis.com	
      ///  Get the Final Edit Distance
      #option pure
      #body		
      //return (unsigned char) state[(unsigned int) position];
      return (unsigned char) state[lenState-2];
   ENDC++;
	 
   QueryPTLayout := RECORD
      STRING    query_string;
      STRING    state                := '';
      DATA      state_data           := (DATA)'';
      UNSIGNED  node_id              := 0;
      STRING    node                 := '';
      UNSIGNED1 _max                 := 255;
      UNSIGNED1 _min                 := 0;
      BOOLEAN   is_word              := False;
      STRING    cumulative_nodes     := '';
      UNSIGNED1 cumulative_node_size := 0;
      UNSIGNED1 current_distance     := 0;
      UNSIGNED1 final_distance       := 0;
   END;
	  
   preped_query_ds := DATASET([{input_query_string}], QueryPTLayout);
   QueryPTLayout QueryPTTransform(QueryPTLayout L, RECORDOF(pt_index) R) := TRANSFORM
      SELF.query_string         := L.query_string;
      SELF.state                := IF(R.is_word, L.state, CalculateLevenshteinVector(L.query_string, R.node, L.state));
      SELF.state_data           := (DATA)SELF.state;
      SELF.node_id              := R.id;
      SELF.node                 := R.node;
      SELF._max                 := R._max;    // The minimum word size for all the children of this node
      SELF._min                 := R._min;    // The maximum word size for all the children of this node
      SELF.is_word              := R.is_word;
      SELF.cumulative_node_size := IF(R.is_word, LENGTH(R.node), LENGTH(R.node) + L.cumulative_node_size);
      SELF.cumulative_nodes     := IF(R.is_word, R.node, L.cumulative_nodes + R.node);
      SELF.current_distance     := IF(R.is_word, L.current_distance, GetMinDistance(SELF.state));
      SELF.final_distance       := IF(R.is_word, GetFinalDistance(SELF.state), L.final_distance);	
   END;
 
   looped_ds := LOOP(preped_query_ds, 
      LEFT.is_word = False,
      EXISTS(ROWS(LEFT)) = True,
      JOIN(ROWS(LEFT), pt_index, LEFT.node_id = RIGHT.parent_id AND
                                 LEFT.current_distance <= max_edit_distance AND
                                 // Current_distance alone cannot be incorporated into the next two expressions
                                 // To do so would "double count" certain edit-distance situations;
                                 // One example would be comparing "dog" and "drop" as seen in the example 1_ThorInlineDataset.ecl from
																 // https://github.com/Charles-Kaminski/FastEditDistanceUsingBigDataPrefixTrees
                                 // Don't do this -> (LENGTH(LEFT.word)) >= (RIGHT._min - (max_edit_distance - LEFT.current_distance))
                                 LENGTH(LEFT.query_string) <= (RIGHT._max + max_edit_distance) AND
                                 LENGTH(LEFT.query_string) >= (RIGHT._min - max_edit_distance),
         QueryPTTransform(LEFT,RIGHT), INNER)); 														 
   interim_results_ds := looped_ds(looped_ds.final_distance <= max_edit_distance);
	 
   RETURN PROJECT(interim_results_ds, {QueryPTLayout.node, QueryPTLayout.final_distance});
ENDMACRO;
/*
//=========================================
//=============== Example Usage ===========
//=========================================
PTIndexLayout := RECORD
   unsigned8 parent_id;
   unsigned8 id;
   unsigned1 _max;
   unsigned1 _min;
   boolean is_word;
   string node;
END;
pt_index := INDEX(DATASET([], PTIndexLayout), {parent_id}, {id, _max, _min, is_word, node}, '~OUT::CFK::LNames_Atl_GA_PT_Key'); 
results := MAC_PrefixTree_Query_Dataset_Levenshtein('KAMINSKI', pt_index, 1);
OUTPUT(results);
*/ 
