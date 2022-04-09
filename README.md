In this repo, the task is contained.

The task description:  
1. We get the link to the of. repository of the Broad Institute that contains their pipelines: https://github.com/broadinstitute/warp  
2. The language is used in this repository (of the BI) - WDL (Workflow Description Language): https://github.com/openwdl/wdl/blob/main/versions/1.0/SPEC.md
____________________________________________
3. We are interested in the pipeline of Variant Calling retrieved from a full genome: https://github.com/broadinstitute/warp/tree/develop/pipelines/broad/dna_seq/germline/single_sample/wgs
4. We should modify it in such a way that would identify SNP/indel and structural variants simultaneously (using bash script of smoove tool (for indetifying of SVs) as an example).  
____________________________________________
5. Look at the GATK tool for SVs searching (https://gatk.broadinstitute.org/hc/en-us/articles/360042914831-StructuralVariationDiscoveryPipelineSpark-BETA-) / Compare it with smoove tool in terms of speed and results similarity (it is possible to do that according to a literature review, too).

Additional comments:  
To launch WDL files I've used Cromwell (https://github.com/broadinstitute/cromwell) (its tutorial: https://cromwell.readthedocs.io/en/stable/tutorials/FiveMinuteIntro/).  
The branch "develop" in the broad/warp repository was formed (fork).  
The created fragment script "smoove_fragment.wdl" was integrated via this branch in the main script (https://github.com/broadinstitute/warp/blob/develop/pipelines/broad/dna_seq/germline/single_sample/wgs/WholeGenomeGermlineSingleSample.wdl).  
The inf. about speed and accuracy of smoove can be found here: https://repositories.lib.utexas.edu/bitstream/handle/2152/84497/Pugalenthi-poster.pdf?sequence=1&isAllowed=y.
