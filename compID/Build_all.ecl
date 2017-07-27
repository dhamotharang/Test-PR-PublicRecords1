export Build_all(
				dataset(compid.Layout_compID_out) result
				,string version=compid.version
				,boolean DoPersist=false
				) := module

	shared Target	:=	if(IsWeekly	,'~thor_data400::out::weekly::alpharetta::compid'
									,'~thor_data400::out::monthly::alpharetta::compid');

	export split_	:=	parallel(
							output(result(state='CA'),,Target+'::CA::'+version,overwrite,__compressed__),
							output(result(state='NJ'),,Target+'::NJ::'+version,overwrite,__compressed__),
							output(result(state='NC'),,Target+'::NC::'+version,overwrite,__compressed__),
							output(result(state='IN'),,Target+'::IN::'+version,overwrite,__compressed__),
							output(result(state='MO'),,Target+'::MO::'+version,overwrite,__compressed__),
							output(result(state='NY'),,Target+'::NY::'+version,overwrite,__compressed__),
							output(result(state='FL'),,Target+'::FL::'+version,overwrite,__compressed__),
							output(result(state='VA'),,Target+'::VA::'+version,overwrite,__compressed__),
							output(result(state='TX'),,Target+'::TX::'+version,overwrite,__compressed__),
							output(result(state='PA'),,Target+'::PA::'+version,overwrite,__compressed__),
							output(result(state='IL'),,Target+'::IL::'+version,overwrite,__compressed__),
							output(result(state='OH'),,Target+'::OH::'+version,overwrite,__compressed__),
							output(result(state='MI'),,Target+'::MI::'+version,overwrite,__compressed__),
							output(result(state='GA'),,Target+'::GA::'+version,overwrite,__compressed__),
							output(result(state='WA'),,Target+'::WA::'+version,overwrite,__compressed__),
							output(result(state='TN'),,Target+'::TN::'+version,overwrite,__compressed__),
							output(result(state='MD'),,Target+'::MD::'+version,overwrite,__compressed__),
							output(result(state='AL'),,Target+'::AL::'+version,overwrite,__compressed__),
							output(result(state='NV'),,Target+'::NV::'+version,overwrite,__compressed__),
							output(result(state='NE'),,Target+'::NE::'+version,overwrite,__compressed__),
							output(result(state='ID'),,Target+'::ID::'+version,overwrite,__compressed__),
							output(result(state='RI'),,Target+'::RI::'+version,overwrite,__compressed__),
							output(result(state='SD'),,Target+'::SD::'+version,overwrite,__compressed__),
							output(result(state='DE'),,Target+'::DE::'+version,overwrite,__compressed__),
							output(result(state='MA'),,Target+'::MA::'+version,overwrite,__compressed__),
							output(result(state='SC'),,Target+'::SC::'+version,overwrite,__compressed__),
							output(result(state='KY'),,Target+'::KY::'+version,overwrite,__compressed__),
							output(result(state='OR'),,Target+'::OR::'+version,overwrite,__compressed__),
							output(result(state='UT'),,Target+'::UT::'+version,overwrite,__compressed__),
							output(result(state='WV'),,Target+'::WV::'+version,overwrite,__compressed__),
							output(result(state='WY'),,Target+'::WY::'+version,overwrite,__compressed__),
							output(result(state='ND'),,Target+'::ND::'+version,overwrite,__compressed__),
							output(result(state='MT'),,Target+'::MT::'+version,overwrite,__compressed__),
							output(result(state='AZ'),,Target+'::AZ::'+version,overwrite,__compressed__),
							output(result(state='CT'),,Target+'::CT::'+version,overwrite,__compressed__),
							output(result(state='KS'),,Target+'::KS::'+version,overwrite,__compressed__),
							output(result(state='OK'),,Target+'::OK::'+version,overwrite,__compressed__),
							output(result(state='MS'),,Target+'::MS::'+version,overwrite,__compressed__),
							output(result(state='ME'),,Target+'::ME::'+version,overwrite,__compressed__),
							output(result(state='DC'),,Target+'::DC::'+version,overwrite,__compressed__),
							output(result(state='VT'),,Target+'::VT::'+version,overwrite,__compressed__),
							output(result(state='AK'),,Target+'::AK::'+version,overwrite,__compressed__),
							output(result(state='HI'),,Target+'::HI::'+version,overwrite,__compressed__),
							output(result(state='WI'),,Target+'::WI::'+version,overwrite,__compressed__),
							output(result(state='MN'),,Target+'::MN::'+version,overwrite,__compressed__),
							output(result(state='LA'),,Target+'::LA::'+version,overwrite,__compressed__),
							output(result(state='CO'),,Target+'::CO::'+version,overwrite,__compressed__),
							output(result(state='IA'),,Target+'::IA::'+version,overwrite,__compressed__),
							output(result(state='AR'),,Target+'::AR::'+version,overwrite,__compressed__),
							output(result(state='NM'),,Target+'::NM::'+version,overwrite,__compressed__),
							output(result(state='NH'),,Target+'::NH::'+version,overwrite,__compressed__)
							);

	export promote_() := function

		promote:=FileServices.PromoteSuperFileList([
													Target
													,Target+'_father'
													,Target+'_grandfather'
													]
													,		Target+'::CA::'+version
													+	','+Target+'::NJ::'+version
													+	','+Target+'::CA::'+version
													+	','+Target+'::NJ::'+version
													+	','+Target+'::NC::'+version
													+	','+Target+'::IN::'+version
													+	','+Target+'::MO::'+version
													+	','+Target+'::NY::'+version
													+	','+Target+'::FL::'+version
													+	','+Target+'::VA::'+version
													+	','+Target+'::TX::'+version
													+	','+Target+'::PA::'+version
													+	','+Target+'::IL::'+version
													+	','+Target+'::OH::'+version
													+	','+Target+'::MI::'+version
													+	','+Target+'::GA::'+version
													+	','+Target+'::WA::'+version
													+	','+Target+'::TN::'+version
													+	','+Target+'::MD::'+version
													+	','+Target+'::AL::'+version
													+	','+Target+'::NV::'+version
													+	','+Target+'::NE::'+version
													+	','+Target+'::ID::'+version
													+	','+Target+'::RI::'+version
													+	','+Target+'::SD::'+version
													+	','+Target+'::DE::'+version
													+	','+Target+'::MA::'+version
													+	','+Target+'::SC::'+version
													+	','+Target+'::KY::'+version
													+	','+Target+'::OR::'+version
													+	','+Target+'::UT::'+version
													+	','+Target+'::WV::'+version
													+	','+Target+'::WY::'+version
													+	','+Target+'::ND::'+version
													+	','+Target+'::MT::'+version
													+	','+Target+'::AZ::'+version
													+	','+Target+'::CT::'+version
													+	','+Target+'::KS::'+version
													+	','+Target+'::OK::'+version
													+	','+Target+'::MS::'+version
													+	','+Target+'::ME::'+version
													+	','+Target+'::DC::'+version
													+	','+Target+'::VT::'+version
													+	','+Target+'::AK::'+version
													+	','+Target+'::HI::'+version
													+	','+Target+'::WI::'+version
													+	','+Target+'::MN::'+version
													+	','+Target+'::LA::'+version
													+	','+Target+'::CO::'+version
													+	','+Target+'::IA::'+version
													+	','+Target+'::AR::'+version
													+	','+Target+'::NM::'+version
													+	','+Target+'::NH::'+version
													,true);

		return promote;
	end;

END;
