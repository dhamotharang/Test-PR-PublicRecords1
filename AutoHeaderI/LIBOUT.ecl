// This defines the output interfaces for header fetches contained in this
// module inside LIB_ attributes.
import doxie;
export LIBOUT := module
	// This defines the output interface for the business header fetch.
	EXPORT FetchI_Hdr_Biz(LIBIN.FetchI_Hdr_Biz.full args) := INTERFACE
		EXPORT DATASET({unsigned6 BDID;unsigned4 seq;unsigned1 score}) do_plus;
		EXPORT DATASET(doxie.layout_ref_bdid) do;
	END;
	// This defines the output interface for the person header fetch.
	EXPORT FetchI_Hdr_Indv(LIBIN.FetchI_Hdr_Indv.full args0) := INTERFACE
		EXPORT DATASET(doxie.layout_references_hh) do_hhid;
		EXPORT DATASET(doxie.layout_references) do;
		EXPORT DATASET({integer code,string200 msg}) messages;
		EXPORT DATASET(doxie.layout_references) references;
	END;
end;
