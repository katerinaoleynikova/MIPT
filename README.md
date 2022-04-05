In this repo, the test task is contained.

The task description:  
1. We get the link to the of. repository of the Broad Institute that contains their pipelines: https://github.com/broadinstitute/warp  
2. The language is used in this repository (of the BI) - WDL (Workflow Description Language): https://github.com/openwdl/wdl/blob/main/versions/1.0/SPEC.md
____________________________________________
3. We are interested in the pipeline of Variant Calling retrieved from a full genome: https://github.com/broadinstitute/warp/tree/develop/pipelines/broad/dna_seq/germline/single_sample/wgs
4. We should modify it in such a way that would identify SNP/indel and structural variants simultaneously (using bash script of smoove tool (for indetifying of SVs) as an example).  

Additional comments:  
To launch WDL files I've used Cromwell (https://github.com/broadinstitute/cromwell) (its tutorial: https://cromwell.readthedocs.io/en/stable/tutorials/FiveMinuteIntro/).  
The branch "develop" in the broad/warp repository was formed (fork).  
The created fragment script "smoove_fragment.wdl" was integrated via this branch in the main script ("WholeGenomeGermlineSingleSample.wdl").
