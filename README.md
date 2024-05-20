# Nextflow pipeline for alleleCounter

Simple wrapper for the [alleleCounter](https://github.com/cancerit/alleleCount) tool v4 to count A/C/G/T's on a list of specified loci. It counts alleles across all chromosomes and packages these counts into a tarball

The setup is intended to run with [Battenberg](https://github.com/Wedge-lab/battenberg) loci files across all chromosomes relevant for CNA calling

This pipeline assumes the alleleCounter is already installed locally and is available in `$PATH`

## How to run

```
nextflow run main.nf -c sample_config
```

## Sample config file

Replace samplename, bamfile and baifile to sample specific information.

Set the path to the Battenberg loci files directory

`chromosomes.txt` is just a list of chromosomes to be considered, one named per line
```
params.samplename = "[samplename]"
params.bam = "[bamfile]"
params.bai = "[baifile]"
params.output = "[samplename]_alleleFrequencies_chr"
params.loci = "[path to battenberg_1000genomesloci_phase3]"
params.chromosomes = "[path to chromosomes.txt]"
```

## Overall config

The modules in this pipeline make use of labels to match job resource requirements. The relevant labels are defined below. To configure this pipeline for submission to an LSF cluster, place the following in ~/.nextflow.config
```
process {
        executor = 'lsf'
        clusterOptions = ''

        withLabel: singlecpu_lowmem_lowtime {
                cpus = 1
                memory = '2 GB'
                queue = 'normal'
        }

        withLabel: singlecpu_medmem_lowtime {
                cpus = 1
                memory = '15 GB'
                queue = 'normal'
        }
}
```
