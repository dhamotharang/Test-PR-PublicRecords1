IMPORT ut, hygenics_crim,PRTE_CSV;
EXPORT Keys_EIR := MODULE
	
// For the purposes of finding ‘persons’, you will likely want to look at one or both of these keys:
// 1.	prte::key::criminal_offenders::fcra::20130829::did – since this is a “DID” key it will only include records we have a DID for
// 2.	prte::key::criminal_offenses::fcra::20130829::offender_key – should include all offenders
new_rec := record
		unsigned6 sdid;
		hygenics_crim.layout_offender;
end;

export Offenders_fcra_did := index ({UNSIGNED6 sdid},
                                    new_rec,
                                    ut.foreign_prod_boca+ 'prte::key::criminal_offenders::fcra::20130829::did');

// UCC will be similar:
// 1.	prte::key::ucc::20130618a::fcra::did_w_type – parties that have a DID and includes the type of party 
// 2.	prte::key::ucc::20130618a::fcra::party_rmsid – should be all parties
EXPORT ucc_w_type_fcra_did := index({	unsigned integer6 did, string1 party_type}, 
																			PRTE_CSV.UCC.rthor_data400__key__ucc__did_w_type, 
																			// '~prte::key::ucc::' + pIndexVersion + '::fcra::did_w_type');
																			 ut.foreign_prod_boca+ 'prte::key::ucc::20130618a::fcra::did_w_type');



//prte::key::sexoffender::fcra::20130628::didpublic
EXPORT sexOff_fcra_did := index({unsigned8 did}, 
															PRTE_CSV.SexOffender.rthor_data400__key__sexoffender__didpublic, 
															ut.foreign_prod_boca+ 'prte::key::sexoffender::fcra::20130628::didpublic');	
	
END;