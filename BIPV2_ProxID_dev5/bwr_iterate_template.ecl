//fix prim range overlinking(diff prim ranges linking)
IMPORT BIPV2_PROX_SALT_int_fullfile,SALT24,BIPV2_Tools,bipv2,salt25,tools;

iteration := '@iteration@';
pversion  := '@version@';


lih       := BIPV2_ProxID_dev5.files().base.built;
names     :=    BIPV2_ProxID_dev5.filenames(pversion + '_' + iteration).dall_filenames
              + BIPV2_ProxID_dev5.keynames(pversion + '_' + iteration).dall_filenames
              ;


#workunit('name','BIPV2_ProxID_dev5.BWR_Iterate ' + iteration + '- Internal Linking - SALT V2.5 Beta 1');

h         := BIPV2_ProxID_dev5.Hygiene(BIPV2_ProxID_dev5.Files().base.qa);
p         := h.AllProfiles; // Detailed profile of every field
combo     := if(iteration = '1' ,(string)((unsigned)iteration - 1)  ,pversion + '_' + (string)((unsigned)iteration - 1));

sequential(
	 output(BIPV2_ProxID_dev5.In_DOT_Base	,named('InputFile'))
  ,nothor(Tools.fun_ClearfilesFromSupers(project(names, transform(Tools.Layout_Names,self.name := left.logicalname)), false)) //clear supers if needed
	,BIPV2_ProxID_dev5.Promote(combo).new2built
	,BIPV2_ProxID_dev5.Proc_Iterate(iteration,pversion,lih).DoAll // Change '1' for subsequent iterations
	,BIPV2_ProxID_dev5.Promote().built2qa
  ,parallel(
     OUTPUT(h.Summary('SummaryReport'),ALL)
    ,OUTPUT(p,NAMED('AllProfiles'),ALL) // Detailed profile of every field
    ,OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL) // Violations of FieldType statements,
    ,OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL) // Breakdown by size of clusters
    ,OUTPUT(SALT25.MAC_Character_Counts.EclRecord(p,'Layout_DOT_Base'),NAMED('OptimizedLayout'))// File layout suggested by data
    //,OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL) // Breakdown of source distribution in clusters
    ,OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL) // Which sources contribute values to a cluster
  )
  ,BIPV2_ProxID_dev5.output_test_cases(BIPV2_ProxID_dev5.Files().base.qa)
);