sequential(FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident_building')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident_built')
		    ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident_father',false)
		    ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident_grandfather',false)
		    ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::incident_delete',false)
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::party')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::party_building')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::party_built')
		    ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::party_father',false)
		    ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::party_grandfather',false)
		    ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'base::SANCTN::party_delete',false)
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'in::SANCTN::payload')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'out::SANCTN::incident_cleaned')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'out::SANCTN::party_cleaned')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::casenum_built')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::casenum_delete')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::casenum_father')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::casenum_grandfather')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::casenum_prod')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::casenum_qa')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::incident_built')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::incident_delete')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::incident_father')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::incident_grandfather')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::incident_prod')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::incident_qa')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::party_built')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::party_delete')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::party_father')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::party_grandfather')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::party_prod')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::party_qa')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::built::autokey::address')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::delete::autokey::address')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::father::autokey::address')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::grandfather::autokey::address')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::prod::autokey::address')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::qa::autokey::address')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::built::autokey::citystname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::delete::autokey::citystname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::father::autokey::citystname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::grandfather::autokey::citystname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::prod::autokey::citystname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::qa::autokey::citystname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::built::autokey::name')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::delete::autokey::name')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::father::autokey::name')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::grandfather::autokey::name')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::prod::autokey::name')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::qa::autokey::name')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::built::autokey::payload')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::delete::autokey::payload')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::father::autokey::payload')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::grandfather::autokey::payload')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::prod::autokey::payload')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::qa::autokey::payload')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::built::autokey::payload_incident')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::delete::autokey::payload_incident')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::father::autokey::payload_incident')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::grandfather::autokey::payload_incident')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::prod::autokey::payload_incident')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::qa::autokey::payload_incident')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::built::autokey::stname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::delete::autokey::stname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::father::autokey::stname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::grandfather::autokey::stname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::prod::autokey::stname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::qa::autokey::stname')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::built::autokey::zip')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::delete::autokey::zip')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::father::autokey::zip')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::grandfather::autokey::zip')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::prod::autokey::zip')
            ,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::sanctn::qa::autokey::zip')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::built::autokey::addressb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::built::autokey::citystnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::built::autokey::nameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::built::autokey::namewords2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::built::autokey::stnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::built::autokey::zipb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::delete::autokey::addressb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::delete::autokey::citystnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::delete::autokey::nameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::delete::autokey::namewords2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::delete::autokey::stnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::delete::autokey::zipb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::father::autokey::addressb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::father::autokey::citystnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::father::autokey::nameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::father::autokey::namewords2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::father::autokey::stnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::father::autokey::zipb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::grandfather::autokey::addressb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::grandfather::autokey::citystnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::grandfather::autokey::nameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::grandfather::autokey::namewords2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::grandfather::autokey::stnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::grandfather::autokey::zipb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::prod::autokey::addressb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::prod::autokey::citystnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::prod::autokey::nameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::prod::autokey::namewords2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::prod::autokey::stnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::prod::autokey::zipb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::qa::autokey::addressb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::qa::autokey::citystnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::qa::autokey::nameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::qa::autokey::namewords2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::qa::autokey::stnameb2')
			,FileServices.CreateSuperFile(SANCTN.cluster_name + 'key::SANCTN::qa::autokey::zipb2')
			);
