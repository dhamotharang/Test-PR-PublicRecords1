EXPORT Attributes := module

		export ddt_layout := record
				string datasetname {xpath('datasetname')};
				string envment {xpath('envment')};
				string location {xpath('location')};
				string cluster {xpath('cluster')};
				string buildversion {xpath('buildversion')};
				string keycount {xpath('keycount')};
				string releasedate {xpath('releasedate')};
		end;

end;