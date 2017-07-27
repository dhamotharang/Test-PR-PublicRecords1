import doxie, doxie_crs, header;

layoutHeader	:= header.File_Headers;
layoutAddr		:= doxie.Layout_Comp_Addresses;

export layout_nbr_records := RECORD
	string1			mode;							// record generated in historic or current mode ('H' or 'C')
	unsigned2		seqTarget;				// target address sequence
	unsigned2		seqNPA;						// neighboring address sequence (for a given target)
	unsigned2		seqNbr;						// neighbor sequence (for a given neighboring address)

	boolean			isCurrent;				// whether neighbor is still at the neighboring address
	boolean			isHistoric;				// whether neighbor has an overlap >0 with the subject
	
	unsigned2		distance;					// proximity from neighboring addr to target addr
	unsigned2		overlap;					// months in common between target/neighbor
	unsigned2		affinity;					// rank assimilating distance, overlap, and recency
	
	unsigned6		base_did;					// did of target
	unsigned2		base_prim_range;	// street number of target
	string8			base_sec_range;		// apt number of target

	layoutHeader.did;
	layoutHeader.rid;
	layoutHeader.src;
	layoutHeader.dt_first_seen;
	layoutHeader.dt_last_seen;
	layoutHeader.phone;
	layoutHeader.ssn;
	layoutHeader.dob;
	layoutHeader.title;
	layoutHeader.fname;
	layoutHeader.mname;
	layoutHeader.lname;
	layoutHeader.name_suffix;
	layoutHeader.prim_range;
	layoutHeader.predir;
	layoutHeader.prim_name;
	layoutHeader.suffix;
	layoutHeader.postdir;
	layoutHeader.unit_desig;
	layoutHeader.sec_range;
	layoutHeader.city_name;
	layoutHeader.st;
	layoutHeader.zip;
	layoutHeader.zip4;
	layoutHeader.county;
	layoutHeader.geo_blk;
	layoutHeader.tnt;
	layoutHeader.valid_ssn;
	
	layoutAddr.county_name;
	string9 		ssn_unmasked := '';
	unsigned8  rawaid := 0;   // not used yet, but available when rawaid added to nbr key
	string10   geo_lat := '';    
	string11   geo_long := '';

END;
