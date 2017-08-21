ih := dataset([],ngadl.layout_HEADER);
amr := ngadl.match_candidates(ih).layout_matches;

export fn_FilterAmbiguous(dataset(amr) all_Matches) := FUNCTION

rec := record
	unsigned6 did;
	unsigned6 dida := 0; 
	unsigned4 confa := 0;
	unsigned6 didb := 0; 
	unsigned4 confb := 0;
	unsigned6 didc := 0; 
	unsigned4 confc := 0;
	
	unsigned4 confab := 0;
	unsigned2 counte := 1;
end;


//****** GET EVERY DID THAT IS PART OF A MATCH INTO THE DID FIELD
confThreshold := ngadl.constants.confThreshold;
p1 := 
	project(
		All_Matches(conf >= confThreshold),
		transform(
			rec,
			self.did := left.did1,
			self.dida := left.did2,
			self.confa := left.conf
		)
	) + 
	project(
		All_Matches(conf >= confThreshold),
		transform(
			rec,
			self.did := left.did2,
			self.dida := left.did1,
			self.confa := left.conf
		)
	); 


//****** DISTRIBUTE AND BE SURE THAT I ONLY HAVE THE HIGHEST SCORE FOR EACH COMBO

d1 := dedup(sort(distribute(p1, hash(did)), did, dida, -confa, local), did, dida, local);


//****** ROLLUP SO THAT EACH DID HAS A ROW SHOWING UP TO THREE DIDS THAT IT MATCHES WITH IDENTICAL SCORES

r1 := 
	rollup(
		d1, 
		left.did = right.did and 
		left.confa = right.confa,
		transform(
			rec,
			self.did := left.did,
			self.dida := left.dida,
			self.confa := left.confa,
			self.didb :=
				map(
					left.counte = 1 => right.dida,
														 left.didb
				);
			self.confb := 
				map(
					left.counte = 1 => right.confa,
														 left.confb
				);		
			self.didc :=
				map(
					left.counte > 1 => right.dida,
														 left.didc
				);
			self.confc := 
				map(
					left.counte > 1 => right.confa,
														 left.confc
				);	
			self.counte := left.counte + 1;
		),
		local
	);


//****** IF IT HAS THREE IDENTICALLY SCORING MATCHES, THEN I AM GOING TO THROW IT OUT FOR NOW
//****** THE REASON FOR THIS IS THAT IT IS TOO MUCH WORK TO CHECK MORE THAN THREE DIDS AGAINST EACH OTHER AT ONE TIME 	

isevil1 := r1.didc > 0;
evil1 := r1(isevil1);
notevil1 := r1(not isevil1);


//****** IF THERE ARE EXACTLY THREE DIDS (DID, DIDA, AND DIDB), THEN I KNOW BASED ON THE ROLLUP THAT THERE IS EQUAL DISTANCE BW DID AND EACH OF DIDA AND DIDB,
//****** SO CHECK THE DISTANCE BETWEEN A AND B

ab := 
	join(
		notevil1(didb > 0),
		d1,
		left.dida = right.did and
		left.didb = right.dida,
		transform(
			rec,
			self.confab := right.confa,
			self := left
		),
		hash,
		keep(1),
		left outer
	);


//****** THROW IT OUT IF THE DISTANCE IS TOO GREAT, AND ADD THIS LIST TO THE OTHER SET OF EVIL

evil2 := ab(confab < confThreshold);

evil := dedup(evil1 + evil2, all);


//****** STRIP ROWS WHERE MY EVIL DIDS APPEAR

clean0 := 
	join(
		All_Matches,
		evil,
		left.did1 = right.did,
		transform(
			amr,
			self := left
		),
		left only,
		hash
	);
	
clean := 
	join(
		clean0,
		evil,
		left.did2 = right.did,
		transform(
			amr,
			self := left
		),
		left only,
		hash
	);
	

//****** I AM JUST GOING TO SPIT OUT A SAMPLE OF DROPS HERE SO THAT I CAN CHECK THEM AFTER THE BUILD
	
dropset := set(enth(evil1, 5) + enth(evil2, 5), did);	
samples := 
		parallel(
			output(choosen(All_Matches(did1 in dropset or did2 in dropset), 500), named('sample_dropped_by_NGADL_fn_FilterAmbiguous'))		
		);

cleansamp := clean : success(samples);

// output(r1, named('r1'));
// output(ab, named('ab'));
return cleansamp;


END;