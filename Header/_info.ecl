IMPORT STD,dops;

EXPORT _info := MODULE

    EXPORT dops_datasetname:='PersonHeaderKeys';
    EXPORT current_prod_roxie_version := dops.GetBuildVersion(dops_datasetname,'B','N','P')[1..9];

    SHARED getLgcl(string nm,unsigned1 sq=1):=regexfind('[0-9]{8}',nothor(STD.File.SuperFileContents(nm))[sq].name,0);
    
    hdr_base_prod := '~thor_data400::base::header_prod';
    EXPORT version_base_qa:=getLgcl(hdr_base_prod);
    hdr_lnk_qa_inc := '~thor_data400::key::insuranceheader_xlink::qa::did::refs::dob';
    EXPORT get_version_link_qa_inc:=getLgcl(hdr_lnk_qa_inc,2);

    EXPORT wuidLink:= 'http://prod_esp.br.seisint.com:8010/?Wuid='+workunit+'&Widget=WUDetailsWidget#/stub/Summary';

END;