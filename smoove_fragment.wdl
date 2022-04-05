workflow smoove {
  call StructuralVariantsCalling {
    input: 
      input_bam = UnmappedBamToAlignedBam.output_bam,
      input_bam_index = UnmappedBamToAlignedBam.output_bam_index,
      ref_fasta = references.reference_fasta.ref_fasta,
      ref_fasta_index = references.reference_fasta.ref_fasta_index,
      sample_name = sample_and_unmapped_bams.sample_name
  }
  
  call StructuralVariantsAnnotating {
    input:
      sample_name = sample_and_unmapped_bams.sample_name
      String output_dir = "./smoove_annotating"
      String docker_image = "brentp/smoove:latest"  
  }
  
  task StructuralVariantsCalling {
    input { 
      File input_bam
      File input_bam_index
      File ref_fasta
      File ref_fasta_index
      String sample_name
      String output_dir = "./smoove_calling"
      String docker_image = "brentp/smoove:latest"  
    }
    
    command {
      set -eou pipefail
      set -o nounset
      set -o errexit
      mkdir -p ~{output_dir}
      smoove call \
      --name ~{sample_name} \
      --fasta ~{ref_fasta} \
      --genotype ~{input_bam} \
      --outdir ~{output_dir} 
    }
    
    output {
      File smoove_vcf = output_dir + "/" + sample_name + "-smoove.genotyped.vcf.gz"
   }
   
    runtime {
      docker: docker_image
    }
  }
  
  task StructuralVariantsAnnotating {
    input {
      File smoove_vcf
      File input_gff
      String sample_name
      String output_dir = "./smoove_annotating"
    }
    
    command {
      set -eou pipefail
      set -o nounset
      set -o errexit
      smoove annotate \
      --gff ~{input_gff} \
      ~{smoove_vcf} | bgzip -c > 
      --gff ~{gff} ~{project_id}.smoove.square.vcf.gz | bgzip -c
    }
    
    output {
      File smoove_annot_vcf = output_dir + "/" + sample_name + "-smoove.square.anno.vcf.gz"
    }
    
    runtime {
      docker: docker_image
    }
  }
 }
