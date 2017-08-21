import SANCTN_Mari;

export files_Midex_common_raw := MODULE

//export NonPublicSanctnBatch := dataset('~thor_data400::temp::sanctn::non_public', SANCTN_Mari.layout_Midex_spray.recIncident, xml('MIDEX/BATCH/'));
export NonPublicSanctnIncd := dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::incidentdata', SANCTN_Mari.layout_Midex_spray.recIncident, xml('MIDEX/RECORD'));
export NonPublicSanctnParty := dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::partydata', SANCTN_Mari.layout_Midex_spray.recParty, xml('MIDEX/RECORD'));
export NonPublicSanctnIntTxt := dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::incidenttext', SANCTN_Mari.layout_Midex_spray.recIncidentText, xml('MIDEX/RECORD'));
export NonPublicSanctnCd := dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::incidentcode', SANCTN_Mari.layout_Midex_spray.recCode, xml('MIDEX/RECORD'));
export PartyText := dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::partytext', SANCTN_Mari.layout_Midex_spray.recPartyText, xml('MIDEX/RECORD'));
export PartyAkaDba := dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::akadba', SANCTN_Mari.layout_Midex_spray.recPartyAkaDba, xml('MIDEX/RECORD'));
export LicenseTypeLookup := dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::license_type', SANCTN_Mari.layout_Midex_spray.ref_license_type, csv(SEPARATOR(','),QUOTE('"'),HEADING(1)));
export PositionTtlLookup := dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::position_ttl_ref', SANCTN_Mari.layout_Midex_spray.ref_position_title, csv(SEPARATOR('\t'),QUOTE('"'),HEADING(1)));
export ProfessionCodeLookup := dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::profession_cd_ref', SANCTN_Mari.layout_Midex_spray.ref_incident_code, csv(SEPARATOR(','),QUOTE('"'),HEADING(1)));
export IncidentCodeLookup := dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::incident_cd_ref', SANCTN_Mari.layout_Midex_spray.ref_incident_code, csv(SEPARATOR(','),QUOTE('"'),HEADING(1)));
export VerificationCodeLookup := dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::verification_cd_ref', SANCTN_Mari.layout_Midex_spray.ref_incident_code, csv(SEPARATOR(','),QUOTE('"'),HEADING(1)));
END;

