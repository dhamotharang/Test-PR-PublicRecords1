EXPORT mac_avoid_transitives(ifile, did1, did2, conf, dover, rule_num, ofile) := macro

	// First remove the simplest dups
	// Dedupping before sorting can remove many dups before the sort and often helps with
	// performance because many records are already in a good order for the dedup.
	#uniquename(fc)
	%fc% := dedup(sort(dedup(ifile, left.did1 = right.did1
	                                  and left.did2 = right.did2
	                                  and (left.conf > right.conf
	                                         or (left.conf = right.conf
	                                               and left.rule_num <= right.rule_num)),
	                         local),
	                   did1, did2, -conf, rule_num, local ),
	              did1, did2, local );
	#uniquename(fc1)
	%fc1% := dedup(distribute( %fc%, hash(did1), merge(did1, did2, -conf, rule_num )),
	               did1, did2, local );

	#uniquename(reverse)
	%reverse% :=  distribute(project(%fc1%,
	                                 transform(recordof(ifile),
	                                   self.did1 := left.did2,
	                                   self.did2 := left.did1,
	                                   self := left)),
	                         hash(did1)); // same distribution as fc1

	#uniquename(add_reverse)
	%add_reverse% := %fc1% + %reverse%;
		
	// output(%add_reverse%,named('add_reverse'),all);
	
	#uniquename(only_top_conf)
	%only_top_conf% := rollup(sort(%add_reverse%, did1, -conf, did2, rule_num, local),
	                          left.did1 = right.did1 and (left.conf > right.conf or left.did2 = right.did2),
	                          transform(left), local);
	
	// output(sort(%only_top_conf%,did2,did1),named('only_top_conf'),all);
	
	#uniquename(only_mutual)
	%only_mutual% := join(distribute(%only_top_conf%, hash(did2)), %only_top_conf%,
	                      left.did2 = right.did1 and left.did1 = right.did2,
	                      transform(right), local);
	
	// output(sort(%only_mutual%,did2,did1),named('only_mutual'),all);
	
	#uniquename(only_top_side)
	%only_top_side% := %only_mutual%(did1 > did2);
	// output(sort(%only_top_side%,did2,did1),named('only_top_side'),all);

	#uniquename(statusEnum)
	%statusEnum% := ENUM(unsigned1, UNKNOWN, GOOD, BAD, ADD);

	#uniquename(statusRec)
	%statusRec% := {
		recordof(ifile),
		%statusEnum% _status,
	};

	#uniquename(loopFunc)
	// The input dataset is only records with an unknown status. The LOOP
	// declaration will filter out any record witch doesn't have an unknown status
	// so that we don't try to process them multiple times.
	// Each iteration of the loop only tries to set the status of "terminal" links:
	// ones where the "target" (did2) doesn't link to a "source" (did1).
	// First a single good record is chosen for each did2, then it is built upon
	// to make a group of all good links associated with it.
	%loopFunc%(dataset(%statusRec%) unknown) := function

		// These are the records where "target" is not a "source" in another record
		// and therefore there are no transitives in this dataset.
		terminalDups := join(distribute(unknown, hash(did2)), unknown,
		                     left.did2 = right.did1,
		                     transform(left), left only, local);

		// Remove all of the 'sources' if they are targetted by someone superior or equal
		removeLowConf := join(distribute(terminalDups, hash(did1)), distribute(unknown, hash(did2)),
		                      left.did1 = right.did2 and left.conf < right.conf,
		                      transform(left), left only, local);

		// Can't have duplicates for id1.
		terminal := dedup(sort(distribute(removeLowConf, hash(did1)), did1, did2, local), did1, local);

		unknownRemoveTerminal := join(distribute(unknown, hash(did2)), distribute(terminalDups, hash(did2)),
		                              left.did2 = right.did2,
		                              transform(left), left only, local);

		// Choose one record for each did2. Call this one good and then we'll build up as much
		// of a group as we can from it.
		goodOne := project(dedup(sort(distribute(terminal, hash(did2)), did2, did1, local), did2, local),
		                   transform(recordof(left),
		                     self._status := %statusEnum%.GOOD,
		                     self := left));

		pairRec := {
			typeof(ifile.did1) did1,
			typeof(ifile.did2) did2,
			typeof(ifile.did2) target_id,
		};

		goodSourceIdRec := {
			typeof(ifile.did1) _good_source_id,
		};

		// These are other records that target the same id as the good recs.
		potentialGood := join(distribute(terminal, hash(did2)), goodOne,
		                      left.did2 = right.did2,
		                      transform({recordof(left), goodSourceIdRec},
		                        self._good_source_id := right.did1,
		                        // self.target_id := right.did2,
		                        self := left),
		                      local);

		// We only want to look at ones that target the goodOne recs.
		potentialGood2 := join(distribute(potentialGood, hash(did1)), distribute(unknownRemoveTerminal, hash(did1)),
		                       left.did1 = right.did1
		                         and left._good_source_id = right.did2,
		                       transform(left), local);

		// Get all pairs of did1's that link to the same target_id.
		did1Pairs := join(distribute(potentialGood2, hash(did2)), distribute(potentialGood2, hash(did2)),
		                  left.did2 = right.did2
		                    and left.did1 > right.did1,
		                  transform(pairRec,
		                    self.did1 := left.did1,
		                    self.did2 := right.did1,
		                    self.target_id := left.did2), local);

		// These are pairs that aren't found
		badRecs := join(distribute(did1Pairs, hash(did1)), distribute(unknownRemoveTerminal, hash(did1)),
		                left.did1 = right.did1
		                  and left.did2 = right.did2,
		                transform(left), left only, local);

		// Remove the bad ones, leaving only good.
		goodGroup := join(potentialGood2, badRecs,
		                  left.did1 = right.did1,
		                  transform(recordof(unknown),
		                    self._status := %statusEnum%.GOOD,
		                    self := left),
		                  left only, hash);

		allGood := distribute(goodGroup + goodOne, hash(did1));

		// The unknowns shouldn't include the good links.
		stillUnknown0 := join(distribute(unknownRemoveTerminal, hash(did1)), allGood,
		                       left.did1 = right.did1,
		                       transform(left), left only, local);

		// Remove records that target a good group so as to avoid transitives.
		stillUnknown := join(distribute(stillUnknown0, hash(did2)), allGood,
		                       left.did2 = right.did1,
		                       transform(left), left only, local);

		// Bad links are dropped and we only carry forward the good and unknown.
		// The loop filter will only keep the unknowns for the next iteration
		// through the loop function.
		return distribute(stillUnknown, hash(did1)) + allGood;

	end;

	#uniquename(markStatus)
	%markStatus% := project(%only_top_side%,
	                        transform(%statusRec%,
	                          self._status := %statusEnum%.UNKNOWN,
	                          self := left));

	// Loops through all of the records with an unknown status, setting the status
	// for the good links and removing records with bad links.
	#uniquename(setStatus)
	%setStatus% := loop(%markStatus%,
	                    left._status = %statusEnum%.UNKNOWN,
	                    exists(rows(left)) and counter <= 10,
	                    %loopFunc%(rows(left)));

	// output(sort(%setStatus%, did2, did1), named('setStatus'));


	ofile := project(%setStatus%(_status != %statusEnum%.UNKNOWN), recordof(ifile));

endmacro;