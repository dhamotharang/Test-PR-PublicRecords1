export Build_all(
				dataset(compid.Layout_compID_out) result
				,string pVersion=Version
				,boolean DoPersist=false
				) := module

	shared Target1	:=	if(Mode.IsWeekly	,'thor_data400::out::weekly::alpharetta::compid'
									,'thor_data400::out::monthly::alpharetta::compid');

	shared Target	:=	'~' + Target1;

	export split_	:=	parallel(
							if(exists(result(state='CA')),output(result(state='CA'),,Target+'::CA::'+pVersion,overwrite)),
							if(exists(result(state='NJ')),output(result(state='NJ'),,Target+'::NJ::'+pVersion,overwrite)),
							if(exists(result(state='NC')),output(result(state='NC'),,Target+'::NC::'+pVersion,overwrite)),
							if(exists(result(state='IN')),output(result(state='IN'),,Target+'::IN::'+pVersion,overwrite)),
							if(exists(result(state='MO')),output(result(state='MO'),,Target+'::MO::'+pVersion,overwrite)),
							if(exists(result(state='NY')),output(result(state='NY'),,Target+'::NY::'+pVersion,overwrite)),
							if(exists(result(state='FL')),output(result(state='FL'),,Target+'::FL::'+pVersion,overwrite)),
							if(exists(result(state='VA')),output(result(state='VA'),,Target+'::VA::'+pVersion,overwrite)),
							if(exists(result(state='TX')),output(result(state='TX'),,Target+'::TX::'+pVersion,overwrite)),
							if(exists(result(state='PA')),output(result(state='PA'),,Target+'::PA::'+pVersion,overwrite)),
							if(exists(result(state='IL')),output(result(state='IL'),,Target+'::IL::'+pVersion,overwrite)),
							if(exists(result(state='OH')),output(result(state='OH'),,Target+'::OH::'+pVersion,overwrite)),
							if(exists(result(state='MI')),output(result(state='MI'),,Target+'::MI::'+pVersion,overwrite)),
							if(exists(result(state='GA')),output(result(state='GA'),,Target+'::GA::'+pVersion,overwrite)),
							if(exists(result(state='WA')),output(result(state='WA'),,Target+'::WA::'+pVersion,overwrite)),
							if(exists(result(state='TN')),output(result(state='TN'),,Target+'::TN::'+pVersion,overwrite)),
							if(exists(result(state='MD')),output(result(state='MD'),,Target+'::MD::'+pVersion,overwrite)),
							if(exists(result(state='AL')),output(result(state='AL'),,Target+'::AL::'+pVersion,overwrite)),
							if(exists(result(state='NV')),output(result(state='NV'),,Target+'::NV::'+pVersion,overwrite)),
							if(exists(result(state='NE')),output(result(state='NE'),,Target+'::NE::'+pVersion,overwrite)),
							if(exists(result(state='ID')),output(result(state='ID'),,Target+'::ID::'+pVersion,overwrite)),
							if(exists(result(state='RI')),output(result(state='RI'),,Target+'::RI::'+pVersion,overwrite)),
							if(exists(result(state='SD')),output(result(state='SD'),,Target+'::SD::'+pVersion,overwrite)),
							if(exists(result(state='DE')),output(result(state='DE'),,Target+'::DE::'+pVersion,overwrite)),
							if(exists(result(state='MA')),output(result(state='MA'),,Target+'::MA::'+pVersion,overwrite)),
							if(exists(result(state='SC')),output(result(state='SC'),,Target+'::SC::'+pVersion,overwrite)),
							if(exists(result(state='KY')),output(result(state='KY'),,Target+'::KY::'+pVersion,overwrite)),
							if(exists(result(state='OR')),output(result(state='OR'),,Target+'::OR::'+pVersion,overwrite)),
							if(exists(result(state='UT')),output(result(state='UT'),,Target+'::UT::'+pVersion,overwrite)),
							if(exists(result(state='WV')),output(result(state='WV'),,Target+'::WV::'+pVersion,overwrite)),
							if(exists(result(state='WY')),output(result(state='WY'),,Target+'::WY::'+pVersion,overwrite)),
							if(exists(result(state='ND')),output(result(state='ND'),,Target+'::ND::'+pVersion,overwrite)),
							if(exists(result(state='MT')),output(result(state='MT'),,Target+'::MT::'+pVersion,overwrite)),
							if(exists(result(state='AZ')),output(result(state='AZ'),,Target+'::AZ::'+pVersion,overwrite)),
							if(exists(result(state='CT')),output(result(state='CT'),,Target+'::CT::'+pVersion,overwrite)),
							if(exists(result(state='KS')),output(result(state='KS'),,Target+'::KS::'+pVersion,overwrite)),
							if(exists(result(state='OK')),output(result(state='OK'),,Target+'::OK::'+pVersion,overwrite)),
							if(exists(result(state='MS')),output(result(state='MS'),,Target+'::MS::'+pVersion,overwrite)),
							if(exists(result(state='ME')),output(result(state='ME'),,Target+'::ME::'+pVersion,overwrite)),
							if(exists(result(state='DC')),output(result(state='DC'),,Target+'::DC::'+pVersion,overwrite)),
							if(exists(result(state='VT')),output(result(state='VT'),,Target+'::VT::'+pVersion,overwrite)),
							if(exists(result(state='AK')),output(result(state='AK'),,Target+'::AK::'+pVersion,overwrite)),
							if(exists(result(state='HI')),output(result(state='HI'),,Target+'::HI::'+pVersion,overwrite)),
							if(exists(result(state='WI')),output(result(state='WI'),,Target+'::WI::'+pVersion,overwrite)),
							if(exists(result(state='MN')),output(result(state='MN'),,Target+'::MN::'+pVersion,overwrite)),
							if(exists(result(state='LA')),output(result(state='LA'),,Target+'::LA::'+pVersion,overwrite)),
							if(exists(result(state='CO')),output(result(state='CO'),,Target+'::CO::'+pVersion,overwrite)),
							if(exists(result(state='IA')),output(result(state='IA'),,Target+'::IA::'+pVersion,overwrite)),
							if(exists(result(state='AR')),output(result(state='AR'),,Target+'::AR::'+pVersion,overwrite)),
							if(exists(result(state='NM')),output(result(state='NM'),,Target+'::NM::'+pVersion,overwrite)),
							if(exists(result(state='NH')),output(result(state='NH'),,Target+'::NH::'+pVersion,overwrite))
							);

	export promote_() := function

		return sequential(
						Promote(pVersion,Target)._delete
						,Promote(pVersion,Target)._father
						,Promote(pVersion,Target)._prod
						,Promote(pVersion,Target1)._new
						);

	end;

END;
